$showListTemp = @((gci E:\Files\Shows).Name)
$showList = @()
$date = Get-Date -Format G
$showFile = "C:\Users\Administrator\app\routes\showList.txt"

if (!(Test-Path $showFile))
{
   New-Item -path C:\Users\Administrator\app\routes -Name showList.txt -type "file"
}

Clear-Content $showFile

foreach ($show IN $showListTemp){
    $showList += "<tr><td>" + $show + "</td></tr>"
}

"Show List as of: $date <br /> <Table border='1'><tr><th><b>TV Show</b></th></tr>" | Out-File -FilePath $showFile -Append -NoClobber -Encoding utf8
$showList | Out-File -FilePath $showFile -Append -NoClobber -Encoding utf8
"</Table>" | Out-File -FilePath $showFile -Append -NoClobber -Encoding utf8
