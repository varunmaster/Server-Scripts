$movieList = @()
$movieDir = "C:\Data\Movies"
$date = Get-Date -Format G
$movieFile = "C:\Data\movieList.txt"

Clear-Content $movieFile

foreach($item in (Get-ChildItem $movieDir)){
    $movieList += "<tr><td>" + $($item.Name) + "</td><td>" + $($item.CreationTime) + "</td></tr>"
}

"Movie List as of: $date <br /> <Table border='1'><tr><th><b>Movie Name</b></th><th><b>First added to server</b></th></tr>" | Out-File -FilePath $movieFile -Append -NoClobber -Encoding utf8
$movieList | Out-File -FilePath $movieFile -Append -NoClobber -Encoding utf8
"</Table>" | Out-File -FilePath $movieFile -Append -NoClobber -Encoding utf8

$body = Get-Content "C:\Data\movieList.txt" -Raw

Send-MailMessage -SMTPServer localhost -To @("varunmaster95@gmail.com","nvelani2@gmail.com","s.advani96@gmail.com") -From Plex@ESXI-Plex.com -Subject "Plex Movie List - $date" -Body "$body" -BodyAsHtml
