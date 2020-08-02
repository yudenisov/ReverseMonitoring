@echo off
rem
rem Командный файл инсталляции дистрибутива с основными файлами пакета "Exponenta"
rem
rem USAGE
rem > postinstall.bat
rem Запускать файл с правами администратора

setlocal enableextensions enabledelayedexpansion

Rem Установка системнмных переменных окружения

set Dest_DIR=c:\pub1

echo -
echo Welcome to RemoteMonitoring Installer!!
echo This program install the packet into directory %Dest_DIR%
echo -

rem Write Config Files 
rem @echo on
echo "=== Changing Exponente Config ==="
echo -

Rem Change Execution Code...

%SystemRoot%\System32\cscript.exe //NoLogo %Dest_DIR%\Util\ReverseMonitoring-SearchReplace.vbs

Rem Execute Changed Script

call %Dest_DIR%\Util\ReverseMonitoring-postinstall1.bat

echo Installation is made with Success!
rem
rem Отправка лога установки на сервер хозяина
rem pause