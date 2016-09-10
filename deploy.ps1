Write-Host "Begin Deployment"
$date = Get-Date
Invoke-Expression -Command:hugo
Invoke-Expression -Command:'cd public'
Invoke-Expression -Command:'git add -A'
Invoke-Expression -Command:'git commit -m "Update, $($date)"'
Invoke-Expression -Command:'git push blog master'
Write-Host "git pull over SSH"
ForEach( $session in Get-SSHSession) {
    Write-Host $session.Host
    if($session.Host -eq "server")
    {
        $mysession = $session
    }
    else
    {
        $mysession = -1
    }
 
 } 
if($mysession -eq -1 -OR !$mysession)
{
    $mysession = New-SSHSession -ComputerName server -Credential (Get-Credential)
}
$result = Invoke-SSHCommand -Index $mysession.SessionId -Command "cd ~/www/ && git pull blog master"
Write-Host "Status" $result.ExitStatus
Pause