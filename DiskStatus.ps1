$C = (gwmi win32_logicaldisk)[1] | select @{Name="Drive";Expression={"C:\"}}, @{Name="Total Size";Expression={$_.size/1GB}}, @{Name="Available Space";Expression={$_.FreeSpace/1GB}}, @{Name="Used Space";Expression={($_.Size/1GB)-($_.FreeSpace/1GB)}}
$E = (gwmi win32_logicaldisk)[3] | select @{Name="Drive";Expression={"E:\"}}, @{Name="Total Size";Expression={$_.size/1GB}}, @{Name="Available Space";Expression={$_.FreeSpace/1GB}}, @{Name="Used Space";Expression={($_.Size/1GB)-($_.FreeSpace/1GB)}}

$body = "<Table border='1'><tr><th><b>Drive Letter</b></th><th><b>Total Size(GB)</b></th><th><b>Available Space(GB)</b></th><th><b>Used Space(GB)</b></th>" + `
        "<tr><td>" + $C.Drive + "</td>" + "<td>" + $C.'Total Size' + "</td>" + "<td>" + $C.'Available Space' + "</td>" + "<td>" + $C.'Used Space' + "</td>" + "</tr>" + `
        "<tr><td>" + $E.Drive + "</td>" + "<td>" + $E.'Total Size' + "</td>" + "<td>" + $E.'Available Space' + "</td>" + "<td>" + $E.'Used Space' + "</td>" + "</tr></Table>"

Send-MailMessage -SMTPServer ESXi-WinMail -To @("varunmaster95@gmail.com","nvelani2@gmail.com") -From esxiplex@gmail.com -Subject "Plex Disk Usage - $(Get-Date -Format G)" -Body "$body" -BodyAsHtml
