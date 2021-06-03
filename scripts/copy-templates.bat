@echo off

mkdir DevOps

cd DevOps


set srcpath=%~dp0 
echo %srcpath%

rem COPYIT.BAT transfers all files in all subdirectories of
rem the source drive or directory (%1) to the destination rem drive or directory (%2)



rem set /p Arg1=Please enter the source folder of your custom templates?:%1
rem set /p Arg2=Please enter the target folder of your CCE library templates?:%2

rem xcopy %Arg1% %Arg2% /s /e



REM set /p Arg3=Please enter the environment file of your custom templates?:%3
REM set /p Arg4=Please enter the environment file of your CCE templates?: %4
 
REM xcopy %Arg3% %Arg4% /s /e
