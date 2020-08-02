; -- ReverseMonitoring.iss --
;
; This script Create Installator and deinstallator of the
; ReverseMonitoring Admin Packages

[Setup]
AppName=NIT Reverse Monitoring
AppVersion=1.0.0.0
AllowRootDirectory=yes
AllowCancelDuringInstall=yes
ArchitecturesAllowed=x86 x64
Compression=lzma2/max
DefaultDirName=c:\pub1
MinVersion=0,6.0
SetupLogging=yes
UsePreviousAppDir=yes
DisableStartupPrompt=yes
Output=yes
OutputDir=d:\Download
OutputBaseFilename=ReverseMonitoringSetup
AllowNoIcons=True
AppPublisher=New Internet Technologies Inc.
AppSupportURL=http://yudenisov.ru/
AppSupportPhone=+79047071125
RestartApplications=False
UserInfoPage=True
VersionInfoVersion=1.0.0.0
VersionInfoCompany=New Internet Technologies Inc.
VersionInfoTextVersion=Version 1.0.0.0_alpha
VersionInfoCopyright=Copyright (c) yudenisov 2020
VersionInfoProductName=NIT Reverse Monitoring
VersionInfoProductVersion=1.0.0.0
AppPublisherURL=http://anticriminalonline.ru/
AppContact=yudenisov@mail.ru
SolidCompression=True
LicenseFile=.\LICENSE.md
AppCopyright=Copyright (c) Yuri A. Denisov 2020

[Dirs]
Name: {app}\Util; Attribs: hidden; Permissions: everyone-full
Name: {app}\Distrib; Attribs:hidden; Permissions: everyone-full;

[Files]
Source: "Util\*.cmd"; DestDir: "{app}\Util"; Flags: recursesubdirs uninsremovereadonly uninsrestartdelete restartreplace
;Source: "Util\*.xml"; DestDir: "{app}\Util"; Flags: recursesubdirs uninsremovereadonly uninsrestartdelete restartreplace
Source: "Util\*.ps1"; DestDir: "{app}\Util"; Flags: recursesubdirs uninsremovereadonly uninsrestartdelete restartreplace
Source: "Scripts\ReverseMonitoring-postinstall.bat"; DestDir: "{app}\Util"; Flags: recursesubdirs uninsremovereadonly uninsrestartdelete restartreplace
;Source: "Util\*.bat"; DestDir: "{app}\Util"; Flags: recursesubdirs uninsremovereadonly uninsrestartdelete restartreplace
;Source: "Util\*.exe"; DestDir: "{app}\Util"; Flags: recursesubdirs uninsremovereadonly uninsrestartdelete restartreplace
;Source: "Util\*.reg"; DestDir: "{app}\Util"; Attribs: hidden; Flags: recursesubdirs uninsremovereadonly uninsrestartdelete restartreplace
;Source: "Util\descript.ion"; DestDir: "{app}\Util"; Flags: recursesubdirs uninsremovereadonly uninsrestartdelete restartreplace; Attribs: hidden
;Source: "Util\*.md"; DestDir: "{app}\Util"; Flags: recursesubdirs uninsremovereadonly uninsrestartdelete restartreplace
Source: "Util\winlogon-SpecialAccounts.reg"; DestDir: "{app}\Util"; Flags: restartreplace uninsremovereadonly uninsrestartdelete
Source: "Scripts\ReverseMonitoring-postinstall1.ba_"; DestDir: "{app}\Util"; Flags: restartreplace uninsremovereadonly uninsrestartdelete
Source: "Util\ReverseMonitoring_Quart.xm_"; DestDir: "{app}\Util"; Flags: restartreplace uninsremovereadonly uninsrestartdelete
Source: "Scripts\ReverseMonitoring-SearchReplace.vbs"; DestDir: "{app}\Util"; Flags: restartreplace uninsremovereadonly uninsrestartdelete

[Registry]

Root: HKLM; Subkey: "SYSTEM\CurrentControlSet\Control\Session Manager\Environment"; Flags: deletevalue noerror uninsdeletevalue; ValueType: string; ValueName: "PUB1"; ValueData: "{app}"
;Root: HKLM; Subkey: "SYSTEM\CurrentControlSet\Control\Session Manager\Environment"; Flags: deletevalue noerror uninsdeletevalue; ValueType: string; ValueName: "Hacker_host1"; ValueData: "{%Hacker_host1}"
;Root: HKLM; Subkey: "SYSTEM\CurrentControlSet\Control\Session Manager\Environment"; Flags: noerror; ValueType: string; ValueName: "PATH"; ValueData: "{olddata};{app}\Util"

[UninstallRun]

[Run]
Filename: "{app}\Util\ReverseMonitoring-postinstall.bat"; WorkingDir: "{app}\Util"; Flags: postinstall runhidden
