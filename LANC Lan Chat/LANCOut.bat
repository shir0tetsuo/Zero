@echo off
mode con: cols=62 lines=30
REM ---------------------------------------------
REM Start of File
set location=0
set locf=loc.dat
title LANCOut2
color 0b
set noch=0
set userk=nulx
set user1k=nul
set noch2=0
set noch3=0
set nochx=0
set xmod=0
set viewmode=0
set ver=2.6.0.0
set ver2=Expanded Functions Build
set adminpermissions=0
echo Hello!
echo v%ver% %ver2%
ping localhost -n 3 >nul
echo Commencing Loading Sequence ...
ping localhost -n 1 >nul
echo [!][1/4] R/W Searching for %locf%...
if not exist %locf% echo [!] loc.dat missing. Please run the configuration in LANCIn2.bat.
if not exist %locf% ping localhost -n 5 >nul
if not exist %locf% start LANCIn2.bat
cls
echo [!][2/4] R/W Loading %locf%...
if exist %locf% (
set /P location=
)<%locf%
cls
echo [!][3/4] Checking 
if exist %locf% echo [!] R/W ...
cd %location%
if not exist LANCX.txt (
echo [!] E:404 LANCX Server Path Not Found
echo [!][4/4] Running Auto-Push...
pushd %location%
) ELSE (
if not exist LANCX.txt echo [!] E:404 LANCX Server Path Not Found
if not exist LANCX.txt echo Push didn't find %location%.
if not exist LANCX.txt ping localhost -n 5 >nul
)
REM /////////////////////////////////////////////////////////////////////
REM /////////////////////////////////////////////////////////////////////
REM /////////////////////////////////////////////////////////////////////
REM /////////////////////////////////////////////////////////////////////
REM /////////////////////////////////////////////////////////////////////

:rs1
cls
echo.
echo LANCOut: Local Area Network Chat Output
if not exist LANCX.txt echo [!!] WARN  The specified path does not contain a LANCX server.
echo.
echo         Case Sensitive
echo               1- ---------------
echo                   Color
echo                   Help
echo               2- ---------------
if exist LANCX.txt echo                   Login
if exist %locf% echo                   pushd
echo               3- ---------------
if not exist LANCX.txt echo               [!] Configure
if %noch2%==0 echo                   SilentLogin
if %noch2%==1 echo              [ON] SilentLogin
if %noch3%==0 echo                   console
if %noch3%==1 echo              [ON] console
echo.
set CVCr=er
set /p CVCr=$ 
if %CVCr%==er goto rs1 
if %CVCr%==Color goto colormod
if %CVCr%==Help goto H
if %CVCr%==Login goto runsetname
if %CVCr%==login goto runsetname
if %CVCr%==Configure start LANCIn2.bat
if %CVCr%==pushd goto push
if %CVCr%==pushload goto pushloader
if %CVCr%==console set noch3=1&goto rs1
REM Put EXE when 1.1.40
REM if %CVCr%==Receive start CloudReceive.bat&goto rs1
REM if %CVCr%==OromUtil start CloudWrite.bat&goto rs1
if %CVCr%==SilentLogin set noch2=1&goto rs1

REM ------------------------ Error -----------------------------------
echo.
echo %CVCr% is not an option or was typed incorrectly.
echo You must enter one of the options displayed, case sensitive.
echo.
pause
goto rs1
REM ------------------------------------------------------------------

:colormod
set SSW=err2
:SSWe
cls
echo DESCRIPTION        COL.      CODE
echo Default          :: 0F ::    default
echo Black and Gray   :: 70 ::    lunar
echo Lime             :: A0 ::    lime
echo Virus Red        :: 4C ::    virus
echo Manual                       colorsel
set /p SSW=Color Menu: 
if %SSW%==err2 (
goto SSWe
)
if %SSW%==menu goto reset1
if %SSW%==lime (
color A0
goto SSWe
)
if %SSW%==lunar (
color 70
goto SSWe
)
if %SSW%==default (
color 0F
goto SSWe
)
if %SSW%==virus (
color 4C
goto SSWe
)
if %SSW%==colorsel goto custcol
goto rs1
:custcol
cls
echo.
echo ////////////////////////////////////////////
echo      Enter the color code manually.
echo     Usage: 0F    or    3B    or    98
echo       0 = Black    8 = Gray
echo       1 = Blue     9 = Light Blue
echo       2 = Green    A = Light Green
echo       3 = Aqua     B = Light Aqua
echo       4 = Red      C = Light Red
echo       5 = Purple   D = Light Purple
echo       6 = Yellow   E = Light Yellow
echo       7 = White    F = Bright White
echo.
:coldeny
SET mancol=x
SET /P mancol=Code: 
if %mancol%==back goto rs1
if %mancol%==x (
echo.
echo You have nothing input!
echo.
goto coldeny
)
echo.
echo Your code is: %mancol%
echo.
echo Is the code you entered correct? [ y / n ]
SET confirmcol=y
SET /P confirmcol=Confirm? 
if %confirmcol%==y (
color %mancol%
echo.
echo The scheme has been modified.
echo Type back to go back.
echo.
goto coldeny
)
if %confirmcol%==n (
echo.
echo The scheme was not loaded.
echo Type back to go back.
echo.
goto coldeny
)

:H
cls
echo Made by Ryan Davis 2013.
echo LANCX server must be specified in loc.dat .
echo You need LANCIn2.bat to properly configure.
echo It's pretty easy to understand and stuff!
echo You are welcome sir
pause
goto rs1

:runsetname
cls
set u=Guest
set /p u=Username: 
if exist REG_%u%.usr goto securelog
:usercheck
echo Channel needs to be set.
ping localhost -n 3 >nul
cls
type avsrvr.dat
set c=0
set /p c=Set Channel: 
if not exist orom-c%c%.txt goto redo 

if exist orom-x%c%.txt set pass=0&goto enc1

goto chatbox

:redo
echo An error occured. The chatroom may not exist.
pause
goto runsetname

:chatbox 
REM set /p c=Chatlog path (end it in .txt):
set time=&time /t
if %noch2%==1 goto CHLo
if %xmod%==1 (
title %RANDOM%
echo [!][M][%time%] Moderator %u% Signed In. >> orom-c%c%.txt
goto CHLo
)
if %noch3%==0 echo [!][%time%] %u% Signed In. >> orom-c%c%.txt
if %noch3%==1 echo [!][CU][%time%] %u% Signed in as a console user. >> orom-c%c%.txt
REM //////////////////////////////////// CHLo
set /a loopMotd=0
:CHLo
cls
if %nochx%==0 echo Sending - %u%
if %nochx%==1 echo Sending - %u%  (REGISTERED)
if exist BAN_%u%.usr goto bannedname
if exist KCK_%u%.tmp goto kicker
echo --- CH: %c% -----------------------------------------------
type orom-c%c%.txt
REM Message of the Day Looper: +1
if exist orom-m%c%.txt (
set /a loopMotd=%loopMotd%+1
)
if exist PM_%u%.log echo ============================================
if exist PM_%u%.log type PM_%u%.log
echo --- CH: %c% -----------------------------------------------
REM Message of the Day Looper: EQU & Reset
if %loopMotd% EQU 11 (
echo  MOTD:
type orom-m%c%.txt
echo.
echo -----------------------------------------------
set /a loopMotd=0
)

if %viewmode%==1 echo --------- Admin Oh Admin! Please Read! --------
if %viewmode%==1 type orom-a%c%.txt
if %viewmode%==1 echo -----------------------------------------------
REM //////////////////////////////////// Kick Everyone

if exist eja.txt (
if %xmod%==1 goto skipdw
MODE CON: COLS=80 LINES=20
color CF
echo                        J                ""#$$$$$$r                     
echo                       @                       $$$$b                    
echo                     .F                        ^*3$$$                   
echo                    :  4         ERROR           J$$$N                  
echo                    $  :F                       :$$$$$                  
echo                   4F  9                       J$$$$$$$                 
echo                   4$   k             4$$$$bed$$$$$$$$$                 
echo                   $$r  'F            $$$$$$$$$$$$$$$$$r                
echo                   $$$   b.           $$$$$$$$$$$$$$$$$N                
echo                   $$$$$k 3eeed$$b    $$$Euec."$$$$$$$$$                
echo    .@$**N.        $$$$$" $$$$$$F'L $$$$$$$$$$$  $$$$$$$                
echo    :$$L  'L       $$$$$ 4$$$$$$  * $$$$$$$$$$F  $$$$$$F         edNc   
echo   @$$$$N  ^k      $$$$$  3$$$$*/   $F4$$$$$$$   $$$$$"        d"  z$N  
echo   $$$$$$   ^k     '$$$"   #$$$F   .$  $$$$$c.u@$$$          J"  @$$$$r 
echo   $$$$$$$b   *u    ^$L            $$  $$$$$$$$$$$$u@       $$  d$$$$$$ 
echo    ^$$$$$$.    "NL   "N. z@*     $$$  $$$$$$$$$$$$$P      $P  d$$$$$$$ 
echo       ^"*$$$$b   '*L   9$E      4$$$  d$$$$$$$$$$$"     d*   J$$$$$r   
echo            ^$$$$u  '$.  $$$L     "#" d$$$$$$".@$$    .@$"  z$$$$*"  
timeout /T 3 /NOBREAK
echo        YOU HAVE BEEN EJECTED BY THE MODERATOR FOR MAINTENANCE
timeout /T 10
exit
)

:skipdw
echo.
set m=
set /p m=Message: 
REM Main Message
if %noch3%==0 echo [%time%] %u%: %m% >> orom-c%c%.txt
if %adminpermissions%==1 (
echo [A][%time%] %u%: %m% >> orom-c%c%.txt
goto solcom
)
if %noch3%==1 echo [CU][%time%] %u%: %m% >> orom-c%c%.txt

if %noch3%==1 goto solcom

echo [:] Anti-Flood
ping localhost -n 2 >nul
goto CHLo

:solcom

if %noch3%==1 set sol=0
set /p sol=Console: 

REM ! commands
REM ///////////////////////////////////////////////////////////////////////////
echo [CU] Checking Command..
if %sol%==!register goto userreg1

if %sol%==!waffles (
echo [!][%time%] %u% ate a bunch of waffles. >> orom-c%c%.txt
goto CHLo
)
if %sol%==!quit (
echo [%time%] %u% Logged Off. >> orom-c%c%.txt
ping localhost -n 2 >nul
goto rs1
)
if %sol%==!exit (
echo [%time%] %u% Logged Off. >> orom-c%c%.txt
ping localhost -n 2 >nul
echo Goodbye.
ping localhost -n 2 >nul
exit
)

if %sol%==!help (
if %adminpermissions%==0 echo !telladmin: Tell an admin yo issues.
if %nochx%==0 echo !register: Register your username.
echo !waffles
if %nochx%==0 echo !fish
if %nochx%==1 echo !fish *
if %nochx%==1 echo !pm: Privately Message A User.
if %nochx%==1 echo !cpm: Clear Private Messages.
if %nochx%==1 echo !nh / !ne: News Header / Ender
echo !pizza
if %adminpermissions%==1 echo !penis
echo !list: Displays channel list
echo !help: Displays help
echo !ch: Switches channel
echo !quit: Goes to main menu
echo !exit: Exits the application
echo !disable: Disables Console User till next restart
echo !changeusr: Changes your username.
if exist admin.txt echo !admin: Login to use admin permissions.
if %adminpermissions%==1 echo [A] List of Admin Commands
if %adminpermissions%==1 echo !v: Check build version.
if %adminpermissions%==1 echo !reset: Reset the chatroom and export to a log.
if %adminpermissions%==1 echo !
if %adminpermissions%==1 echo !ban: Ban A user.
if %adminpermissions%==1 echo !unban: Unban A user.
if %adminpermissions%==1 echo !viewmode: See complaints.
if %adminpermissions%==1 echo !kick: Kick A User.
if %viewmode%==1 echo !clear: Clear complaints.
if %xmod%==1 echo [M] Moderator Tools
if %xmod%==1 echo !killadminperm
pause
goto CHLo
)

if %sol%==!pizza (
echo [!][%time%] %u% said we should get pizza. >> orom-c%c%.txt
goto CHLo
)

if %sol%==!telladmin goto rexa

if %sol%==!penis (
echo [!][%time%] %u% slapped you in the face with a big floppy green penis saying "HULK SMASH!" >> orom-c%c%.txt
goto CHLo
)

if %sol%==!admin goto enc2

if %sol%==!changeusr goto changeusrn

if %sol%==!disable (
set noch3=0
echo [!CU] Console Usage Disabled.
ping localhost -n 4 >nul
goto CHLo
)

if %sol%==!list (
echo.
type avsrvr.dat
echo.
echo.
echo [:] To switch channels, do !ch
pause
goto CHLo
)

if %sol%==!fish goto slap

REM Channel Switching
if %sol%==!ch (
echo.
set c2=0
set /P c2=Channel: 
echo [!] R/W ...
)
if %sol%==!ch (
ping localhost -n 2 >nul
echo [!] %c% --- to --- %c2%
ping localhost -n 2 >nul
if not exist orom-c%c2%.txt (
echo Non-Existent Channel.
ping localhost -n 3 >nul
goto CHLo
)

echo [%time%] %u% switched to channel %c2%. >> orom-c%c%.txt
set c=%c2%
if exist orom-x%c2%.txt goto enc1
goto chatbox
)
REM ///////////////////////////////////////////////////////////////////////////
REM Registered
if %nochx%==1 goto xu

REM ///////////////////////////////////////////////////////////////////////////

if %adminpermissions%==1 goto adminsub

REM Channel Switching End
ping localhost -n 2 >nul
goto CHLo

REM ///////////////////////////////////////////////////////////////////////////

:adminsub
echo [A] Checking Admin Subroutine...

if %sol%==!killadminperm goto superuser1

if %sol%==!reset (
echo [!] R/W ...
ren orom-c%c%.txt orom-L%c%--%time:~0,2%%time:~3,2%-%DATE:/=%.txt
echo [!] Channel %c% was exported on %time:~0,2%%time:~3,2%-%DATE:/=%.
echo [!!] An admin has reset this chatroom. > orom-c%c%.txt
pause
goto CHLo
)

if %sol%==!v (
echo %ver%
)

if %sol%==! goto rex

if %sol%==!viewmode (
set viewmode=1
)

if %sol%==!clear (
echo [!] R/W ...
ren orom-a%c%.txt orom-aL%c%--%time:~0,2%%time:~3,2%-%DATE:/=%.txt
echo [!] Channel %c% Admin Notices were exported on %time:~0,2%%time:~3,2%-%DATE:/=%.
pause
goto CHLo
)

if %sol%==!ban goto banusr

if %sol%==!unban goto unbanusr

if %sol%==!kick goto kickusr

ping localhost -n 2 >nul
goto CHLo


:xu

echo CHECKIN'!
if %sol%==!pm goto primes
if %sol%==!cpm del PM_%u%.log
if %sol%==!nh echo [N]==== >> orom-c%c%.txt
if %sol%==!nh echo [N]==== Today in the house [%time%]=====NEWSNET===*==[!]= >> orom-c%c%.txt
if %sol%==!nh echo [N]==== >> orom-c%c%.txt
if %sol%==!ne echo [N]========================[%time%]=====NEWSNET===*==[!]= >> orom-c%c%.txt
if %adminpermissions%==1 goto adminsub
goto CHLo
REM ///////////////////////////////////////////////////////////////////////////
REM Extra Command References

:slap
set slapee=Another Fish
set /P slapee=Who do you want to slap? 
if %nochx%==1 (
echo [!][%time%] %u% slapped %slapee% with A Soggy Waffle! >> orom-c%c%.txt
goto CHLo
)
if %adminpermissions%==0 echo [!][%time%] %u% slapped %slapee% with A Smelly Fish! >> orom-c%c%.txt
if %adminpermissions%==1 echo [!][%time%] Admin %u% slapped %slapee% with A Dank Fishstick! >> orom-c%c%.txt
goto CHLo

REM ///////////////////////////////////////////////////////////////////////////

:enc1
cls
echo This chatroom has a password!
if %noch2%==1 echo [!] SilentLogin was disabled.
echo.
set noch2=0
echo [!] R/W ...
if exist orom-x%c%.txt (
set /P pass=
)<orom-x%c%.txt
echo [!] 
set pass2=1
set /P pass2=PW: 
if %pass2%==%pass% (
echo %pass2% --- %pass% -- Password Correct!
echo.
echo You will be logged in shortly.
ping localhost -n 5 >nul
goto chatbox
)
goto enc1

:enc2
echo [!] R/W ...
if not exist admin.txt (
echo No admin permissions available.
ping localhost -n 3 >nul
goto CHLo
)
if exist admin.txt (
set /P afile=
)<admin.txt
cls
echo Please type in the admin password.
set /P acon=
if %acon%==%afile% (
echo Correct. %acon% --- %afile%
pause
set adminpermissions=1
goto CHLo
)
goto enc2

:push
set ipush=0
echo [:] The %locf% will be ignored.
set /P ipush=Enter Pushed Drive Path: 
if %ipush%==0 goto push
echo [!] pushd %ipush% ...
pushd %ipush%
echo [!] R/W ...
ping localhost -n 2 >nul
goto rs1

REM Extra Console Bit
:changeusrn
set /P u2=Username: 
if %adminpermissions%==1 echo [!][A][%time%] %u% changed their username to %u2%. >> orom-c%c%.txt
if %adminpermissions%==0 echo [!][CU][%time%] %u% changed their username to %u2%. >> orom-c%c%.txt
set u=%u2%
goto CHLo

:rex
cls
set mastersymbol=
set /P mastersymbol=!!! 
echo ---[%time%]---------- Priority Message from Admin [!!!] >> orom-c%c%.txt
echo %mastersymbol% >> orom-c%c%.txt
echo ---[%time%]--- EOL ---------- [A] %u% -------- >> orom-c%c%.txt
goto CHLo

:rexa
cls
set mastersymbol2=
set /P mastersymbol2=Yes? :: 
echo ---[%time%]--- To Admin --- %mastersymbol2% ------- By %u% >> orom-a%c%.txt
echo I'll see this message the next time I log in.
ping localhost -n 5 >nul
goto CHLo

:securelog
echo [!] R/W ...
if exist REG_%u%.usr (
set /P userk=
set /P xmod=
)<REG_%u%.usr
cls
echo Please type in your user password.
set /P user1k=
if %user1k%==%userk% (
echo Correct. %user1k% --- %userk%
pause
set nochx=1
goto usercheck
)
goto securelog

:userreg1
set /P userk=One String Password: 
echo %userk% > REG_%u%.usr
echo 0 >> REG_%u%.usr
echo %userk% saved.
set nochx=1
ping localhost -n 3 >nul
echo [%time%] %u% has just registered their username. >> orom-c%c%.txt
goto CHLo

:bannedname
cls
echo [!] You have been banned for the following reason;
if exist BAN_%u%.usr (
set /P banreason=
)<BAN_%u%.usr
echo %banreason%
echo.
echo Goodbye.
pause
exit

:banusr
set /P banname=Ban: 
if exist BAN_%banname%.usr (
echo This user has already been banned.
ping localhost -n 3 >nul
goto CHLo
)
set banreason=N-A
set /P banreason=Description? 
echo [!] R/W ...
echo %banreason% > BAN_%banname%.usr
echo The user has been banned.
echo [BAN][%time%] %banname% was banned for: %banreason%  ::: Admin %u% >> orom-c%c%.txt
ping localhost -n 3 >nul
goto CHLo

:unbanusr
set banname=Guest
set /P banname=Unban: 
if exist BAN_%banname%.usr (
echo [!] R/W ...
del BAN_%banname%.usr
echo This user was restored.
echo [%time%] %banname% was unbanned from LANCX. >> orom-c%c%.txt
ping localhost -n 3 >nul
goto CHLo
)
if not exist BAN_%banname%.usr (
echo This user was never banned.
ping localhost -n 3 >nul
goto CHLo
)

:kickusr
echo Leave Blank to Kick All Guests.
set kun=Guest
set /P kun=Kick: 
echo Kicking > KCK_%kun%.tmp
echo [!][%time%] Admin %u% kicked %kun%. >> orom-c%c%.txt
if %kun%==Guest (
echo [!] Guests are being evicted.
ping localhost -n 2 >nul
ping localhost -n 5
echo Kicking > KCK_%kun%.tmp
cls
echo .
ping localhost -n 5
echo Kicking > KCK_%kun%.tmp
cls
echo ..
ping localhost -n 5
echo Kicking > KCK_%kun%.tmp
cls
echo ...
echo Success!
ping localhost -n 3 >nul
)
goto CHLo

:kicker
cls
echo You have been kicked!
pause
del KCK_%u%.tmp
goto rs1

:superuser1
cls
if %xmod%==1 (
echo The current password is "%afile%".
echo !killpower
echo !cleanlogs
echo !cleanadmlogs
echo !changepw
echo !eject
echo !canceleject
) ELSE (
echo [!] FATAL:
echo You are not A Moderator.
pause
goto CHLo
)
set xmodse=0
set /P xmodse=$ 
if %xmodse%==!killpower (
echo xt>admin.txt
REM del admin.txt
REM set adminpermissions=0
goto rs1
)
if %xmodse%==!changepw (
set /P xmcp=New String: 
echo %xmcp% > admin.txt
goto CHLo
)
if %xmodse%==!cleanadmlogs (
del orom-aL*.txt
echo Cleaned all channels.
ping localhost -n 3 >nul
goto CHLo
)
if %xmodse%==!cleanlogs (
del orom-L*.txt
echo Cleaned all channels.
ping localhost -n 3 >nul
goto CHLo
)
if %xmodse%==!eject (
echo 1>eja.txt
)
if %xmodse%==!canceleject (
@echo on
del eja.txt
@echo off
cls
)
goto superuser1

:primes
set pmu=nul
set /P pmu=PM: 
set /P pmm=M: 
if exist REG_%pmu%.usr (
echo [!][PM][%time%] -FROM- %u%   %pmm% >> PM_%pmu%.log
goto CHLo
) ELSE (
cls
echo User Not Found!
ping localhost -n 2 >nul
goto CHLo
)