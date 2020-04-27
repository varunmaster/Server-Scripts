﻿$C = (gwmi win32_logicaldisk)[1] | select @{Name="Drive";Expression={"C:\"}}, @{Name="Total Size";Expression={$_.size/1GB}}, @{Name="Available Space";Expression={$_.FreeSpace/1GB}}, @{Name="Used Space";Expression={($_.Size/1GB)-($_.FreeSpace/1GB)}},@{Name="Percentage Used";Expression={(($_.Size/1GB)-($_.FreeSpace/1GB))/($_.Size/1GB)}}
$E = (gwmi win32_logicaldisk)[3] | select @{Name="Drive";Expression={"E:\"}}, @{Name="Total Size";Expression={$_.size/1GB}}, @{Name="Available Space";Expression={$_.FreeSpace/1GB}}, @{Name="Used Space";Expression={($_.Size/1GB)-($_.FreeSpace/1GB)}},@{Name="Percentage Used";Expression={(($_.Size/1GB)-($_.FreeSpace/1GB))/($_.Size/1GB)}}

$body = "<Table border='1'><tr><th><b>Drive Letter</b><th><b>Free Space(%)</b></th><th><b>Used Space(%)</b></th></th><th><b>Total Size(GB)</b></th><th><b>Available Space(GB)</b></th><th><b>Used Space(GB)</b></th>" + `
        "<tr><td>" + $C.Drive + "</td>" + "<td>" + (100.00 - [math]::Round($C.'Percentage Used' * 100,2)) + "</td>" + "<td>" + [math]::Round($C.'Percentage Used' * 100,2) + "</td>" + [math]::Round($C.'Total Size',3) + "</td>" + "<td>" + [math]::Round($C.'Available Space',3) + "</td>" + "<td>" + [math]::Round($C.'Used Space',3) + "</td>" + "</tr>" + `
        "<tr><td>" + $E.Drive + "</td>" + "<td>" + (100.00 - [math]::Round($E.'Percentage Used' * 100,2)) + "</td>" + "<td>" + [math]::Round($E.'Percentage Used' * 100,2) + "</td>" + [math]::Round($E.'Total Size',3) + "</td>" + "<td>" + [math]::Round($E.'Available Space',3) + "</td>" + "<td>" + [math]::Round($E.'Used Space',3) + "</td>" + "</tr></Table>"

Send-MailMessage -SMTPServer ESXi-WinMail -To @("varunmaster95@gmail.com") -From esxiplex@gmail.com -Subject "Plex Disk Usage - $(Get-Date -Format G)" -Body "$body" -BodyAsHtml
