$movieDir = "C:\Data\Movies\*"
$movieListTemp = @((Get-ChildItem $movieDir -File -Recurse -Exclude "*.txt","*.srt","*.jpg","*.ass","*.nfo","*.url","*.db","*.png").FullName)
$movieList = @()
$date = Get-Date -Format G
$movieFile = "C:\Users\Administrator\app\routes\movieList.txt"

if (!(Test-Path $movieFile))
{
   New-Item -path C:\Users\Administrator\app\routes -Name movieList.txt -type "file"
}

Clear-Content $movieFile

for($i=0; $i -lt $movieListTemp.Length; $i++){
    $movieList += "<tr><td>" + ((Split-Path $movieListTemp[$i] -Leaf) -Replace '\.',' ' `
                                                                      -Replace 'x264','' `
                                                                      -Replace 'BrRip.','' `
                                                                      -Replace 'BDRip.','' `
                                                                      -Replace 'BRRip.','' `
                                                                      -Replace 'BluRay','' `
                                                                      -Replace 'avi','' `
                                                                      -Replace 'mp4','' `
                                                                      -Replace 'mkv','' `
                                                                      -Replace '\[YTS AM\]','' `
                                                                      -Replace '\[YTS AG\]','' `
                                                                      -Replace 'YIFY','' `
                                                                      -Replace '1080p','' `
                                                                      -Replace '720p','' `
                                                                      -Replace 'DVDRip','' `
                                                                      -Replace '-','' `
                                                                      -Replace 'WEBRip','') + "</td><td>" + (gci $movieListTemp)[$i].CreationTime.ToString("MM/dd/yyyy") + "</td></tr>"
}

"Movie List as of: $date <br /> <Table border='1'><tr><th><b>Movie Name</b></th><th><b>First added</b></th></tr>" | Out-File -FilePath $movieFile -Append -NoClobber -Encoding utf8
$movieList | Out-File -FilePath $movieFile -Append -NoClobber -Encoding utf8
"<tr><td><b>Count</b></td> <td><b>$($movieListTemp.Count)</b></tr></td>" | Out-File -FilePath $movieFile -Append -NoClobber -Encoding utf8
"</Table>" | Out-File -FilePath $movieFile -Append -NoClobber -Encoding utf8
