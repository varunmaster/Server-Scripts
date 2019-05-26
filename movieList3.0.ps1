$movieListTemp = @((Get-ChildItem -path 'C:\Data\Movies' -Directory).Name)
$movieList = @()
$date = Get-Date -Format G
$movieFile = "C:\Users\Administrator\app\routes\movieList.txt"

if (!(Test-Path $movieFile))
{
   New-Item -path C:\Users\Administrator\app\routes -Name movieList.txt -type "file"
}

Clear-Content $movieFile

function getItemNameAndTimeCreation($fileName){
    (Get-ChildItem C:\Data\Movies\$fileName).CreationTime | select -First 1
}

for($i=0; $i -lt $movieListTemp.Length; $i++){
    $movieList += "<tr><td>" + $i + "</td><td>" + $movieListTemp[$i] + "</td><td>" + (getItemNameAndTimeCreation $movieListTemp[$i]) + "</td></tr>"
}

"Movie List as of: $date <br /> <Table border='1'><tr><th></th><th><b>Movie Name</b></th><th><b>First added</b></th></tr>" | Out-File -FilePath $movieFile -Append -NoClobber -Encoding utf8
$movieList | Out-File -FilePath $movieFile -Append -NoClobber -Encoding utf8
"<tr><td><b>Count</b></td> <td><b>$($movieListTemp.Count)</b></tr></td>" | Out-File -FilePath $movieFile -Append -NoClobber -Encoding utf8
"</Table>" | Out-File -FilePath $movieFile -Append -NoClobber -Encoding utf8

#.ToString("MM/dd/yyyy")
