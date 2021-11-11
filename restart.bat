@ECHO OFF




ECHO This is sample batch file that can do something useful if rig has problems
ECHO Rig name: %1   Problem ID: %2
ECHO Problem IDs: 1 - miner offline, 2 - temperature warning, 3 - low hashrate, 4 - fan warning.
REM TIMEOUT /T 10

SHUTDOWN /m \\%1 /f /r /t 0

>> Restart_Log_%1.txt ECHO[
>> Restart_Log_%1.txt ECHO %date% %time%
>> Restart_Log_%1.txt ECHO Problem ID %2

IF "%2"=="1" Set Reason=Miner Offline
IF "%2"=="2" Set Reason=Temperature Warning
IF "%2"=="3" Set Reason=Low Hashrate
IF "%2"=="4" Set Reason=Fan Warning

>> Restart_Log_%1.txt ECHO Reason: %Reason%
REM >> Restart_Log_%1.txt ECHO Reason: %Reason%
REM >> Restart_Log_%1.txt ECHO Reason: %Reason%
REM >> Restart_Log_%1.txt ECHO Reason: %Reason%

REM ===================================================

Set emailerRootPath=%CD%
Set emailerTimeStamp=%date% %time%

REM ***** Set this folder for where emailer.exe is *****
CD /D "C:\Stuff\Emailer"

Shutdown /m %1 /f /r /t 0

REM EXIT

> Emailer_subject.txt ECHO RESTARTING %1 FOR PROBLEM: %Reason%

> Emailer_body.txt ECHO %1 problem: %Reason%
>>Emailer_body.txt ECHO %emailerTimeStamp%

REM Emailer.exe trigger@applet.ifttt.com
REM ***** SET THIS TO YOUR RECIPIENT EMAIL ADDRESS *****
Emailer.exe youremailaddress@gmail.com

CD /D "%emailerRootPath%"

Set Reason=
Set emailerRootPath=
Set emailerTimeStamp=

