' *****************************************************************************
'
' TestSearchReplace.vbs
'
' This Script Searches String MSSQLSR in a Text File and Replace it on
' %COMPUTERNAME%\MSSQLSR at Whole File
'
' PARAMETERS: 	NONE
'
' RETURNS:	NONE
'
' *****************************************************************************

' Constants Definition '
Const ForReading = 1
Const ForWriting = 2
Const TristateTrue = -1
Const TristateFalse = 0
Const USERNAME = "MSSQLSR"
Const XMLFILENAME1 = "ReverseMonitoring_Quart"
Const BATFILENAME1 = "ReverseMonitoring-postinstall1"
Const PUB1_PATH = "C:\pub1"

' Variable Declaration '
Dim wshShell, shApp, envVarProccess
Dim pathCMD, COMPUTERNAME
Dim strLocal_Path, strLocalFileReading, strLocalFileWriting

' Objects Definition '
Set wshShell = CreateObject( "WScript.Shell" )
Set envVarProccess = wshShell.Environment("PROCESS")
Set shApp = CreateObject( "Shell.Application" )
pathCMD = envVarProccess( "SystemRoot" ) & "\System32"
COMPUTERNAME = envVarProccess( "COMPUTERNAME" )

' Test '
'strLocal_Path = "C:\Users\yuden\source\repos\New_Internet_Technologies\TestSearchReplace\VBS"
strLocal_Path = PUB1_PATH & "\Util"

' Code '
strPattern = USERNAME
strReplace = COMPUTERNAME & "\" & USERNAME

strLocalFileReading = strLocal_Path & "\" & BATFILENAME1 & ".ba_"
strLocalFileWriting = strLocal_Path & "\" & BATFILENAME1 & ".bat"

ReplaceInFile strLocalFileReading, strLocalFileWriting, strPattern, strReplace, False

strLocalFileReading = strLocal_Path & "\" & XMLFILENAME1 & ".xm_"
strLocalFileWriting = strLocal_Path & "\" & XMLFILENAME1 & ".xml"

ReplaceInFile strLocalFileReading, strLocalFileWriting, strPattern, strReplace, True

' *****************************************************************************
'
' SUB Replace in File
'
' Search strPattern at strLocalFileReading, replace it on strReplace and
' write result on strLocalFileWriting
' NOTE! strLocalFileReading and strLocalFileWriting must NOT be same file
'
' PARAMETERS:	strLocalFileReading -- input file
'		strLocalFileWriting -- output file
'		strPattern -- Pattern to search
'		strReplace -- Replace string
'		isUnicode -- True If file UNICODE, False if ANSI
' RETURNS:	NONE
'
' *****************************************************************************

SUB ReplaceInFile( strLocalFileReading, strLocalFileWriting, strPattern, strReplace, isUnicode )
	Dim fileReading, fileWriting
	Dim fso, objRegExp
	Dim strContent, strReplacement
	Set fso = CreateObject("Scripting.FileSystemObject")
	Set objRegExp = CreateObject("VBScript.RegExp")
	objRegExp.Pattern = strPattern
	objRegExp.Global = True
	objRegExp.IgnoreCase = True
	If Not fso.FileExists( strLocalFileReading ) Then 
		WScript.Echo "File " & strLocalFileReading & " not Found!"
	Else
		If fso.FileExists( strLocalFileWriting ) Then
			fso.DeleteFile strLocalFileWriting, True
		End If
		Set fileWriting = fso.CreateTextFile( strLocalFileWriting, True, isUnicode )
		Set fileReading = fso.OpenTextFile( strLocalFileReading, ForReading, TristateFalse )
		' WScript.Echo strPattern & " " & strReplace
		Do While fileReading.AtEndOfStream <> True
			strContent = fileReading.ReadLine
			strReplacement = objRegExp.Replace( strContent, strReplace )
			fileWriting.WriteLine(strReplacement)
		Loop
		fileReading.Close
		fileWriting.Close
	End If
End SUB