$C = (gwmi win32_logicaldisk)[1] | select @{Name="Drive";Expression={"C:\"}}, @{Name="Total Size";Expression={$_.size/1GB}}, @{Name="Available Space";Expression={$_.FreeSpace/1GB}}, @{Name="Used Space";Expression={($_.Size/1GB)-($_.FreeSpace/1GB)}},@{Name="Percentage Used";Expression={(($_.Size/1GB)-($_.FreeSpace/1GB))/($_.Size/1GB)}}
$E = (gwmi win32_logicaldisk)[3] | select @{Name="Drive";Expression={"E:\"}}, @{Name="Total Size";Expression={$_.size/1GB}}, @{Name="Available Space";Expression={$_.FreeSpace/1GB}}, @{Name="Used Space";Expression={($_.Size/1GB)-($_.FreeSpace/1GB)}},@{Name="Percentage Used";Expression={(($_.Size/1GB)-($_.FreeSpace/1GB))/($_.Size/1GB)}}

$body = "<Table border='1'><tr><th><b>Drive Letter</b><th><b>Used Space(%)</b></th></th><th><b>Total Size(GB)</b></th><th><b>Available Space(GB)</b></th><th><b>Used Space(GB)</b></th>" + `
        "<tr><td>" + $C.Drive + "</td>" + "<td>" + [math]::Round($C.'Percentage Used' * 100,2) + "</td>" + $C.'Total Size' + "</td>" + "<td>" + $C.'Available Space' + "</td>" + "<td>" + $C.'Used Space' + "</td>" + "</tr>" + `
        "<tr><td>" + $E.Drive + "</td>" + "<td>" + [math]::Round($E.'Percentage Used' * 100,2) + "</td>" + $E.'Total Size' + "</td>" + "<td>" + $E.'Available Space' + "</td>" + "<td>" + $E.'Used Space' + "</td>" + "</tr></Table>"

Send-MailMessage -SMTPServer ###### -To @("#######","######") -From ##### -Subject "Plex Disk Usage - $(Get-Date -Format G)" -Body "$body" -BodyAsHtml
