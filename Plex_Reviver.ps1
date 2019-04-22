if(Get-Process "Plex Media Server" -ErrorAction SilentlyContinue ){
    Exit 0
    }
else {
    Start-Process "C:\Program Files (x86)\Plex\Plex Media Server\Plex Media Server.exe"
    Send-MailMessage -SmtpServer ESXi-WinMail -From esxiplex@gmail.com -To @("varunmaster95@gmail.com","nvelani2@gmail.com","s.advani96@gmail.com") -Subject "Plex restarted" -BodyAsHtml "Plex just restarted. $(Get-Date -Format G)"
}
