@ECHO OFF
:db.s
REM ////////////////////////////////////////////////////////////////////////
REM // Unless you require special java commands, you shouldn't be poking  //
REM //                        around inside me.                           //
REM //  If for some reason the minecraft server won't load, type "debug"  //
REM //     in the main         menu to check if the java function was     //
REM //   initialized properly. Everything you see here, is 100% mine. I   //
REM //                  did everything from scratch.                      //
REM //                                                                    //
REM //IF YOU REQUIRE SPECIAL JAVA PARAMETERS, GO TO THE "///// RUN" LINES //
REM //                     Love, NightDelSolEXE7                          //
REM ////////////////////////////////////////////////////////////////////////
REM                 JAVA IS A REQUIREMENT TO RUN ANY SERVER!
REM       Most computers will get the latest Java update automatically.
REM ////////////////////////////////////////////////////////////////////////
REM Below is the version number in % states. They will be read when
REM they are prompted.
set FVSShort=RB763b12
set FVSLong=RUNBUKK_7.6.3b12
set FVSSplash=RB7.6.3b12
set FVS
set settingsF=settings.rbk
set jarfile=0.txt
set runmenu=0
REM ////////////////////////////////////////////////////////////////////////
REM ////////////////////////////////////////////////////////////////////////
REM ///////////// <,>,>>         SWITCHES                    ///////////////
REM ////////////////////////////////////////////////////////////////////////
REM ////////////////////////////////////////////////////////////////////////
REM %settingsF%
REM /////////////////////////////
REM Line 1 = %jarfile%         The jar name. -jar     RUN ONCE STUFF
REM /////////////////////////////
REM /////////////////////////////
REM GBUsage.txt
REM /////////////////////////////
REM Line 1 = %GB%             -Xms%GB%G -Xmx%GB%G     RUN, LOOP, LOOP_AFK
REM /////////////////////////////
REM /////////////////////////////
REM if %runmenu%==debug.s ping localhost -n 3 >nul
Rem ////////////////////////////////////////////////////////////////////////
Rem /////////////              RUN ONCE STUFF                ///////////////
Rem ////////////////////////////////////////////////////////////////////////
if exist %settingsF% (
echo A settings file already exists. Loading data.
(
set /P jarfile=
)<%settingsF%
)
REM if %runmenu%==debug.s ping localhost -n 3 >nul
if exist GBUsage.txt goto LoadGBU
:freset
cls
title Server Gigabyte Usage
echo (RUN ONCE)
echo /// Enter Server Gigabyte Usage ///
echo 2 is default. Between 1 and your maximum RAM. Whole numbers only.
echo 1 GB = 10 users.
SET GB=2
SET /P GB=/X.usage/# 
(echo %GB%)> GBUsage.txt
echo.
echo The GBUsage.txt file was written in the same folder.
echo If you want to change the value of the Server Gigabyte Usage,
echo either open the file and modify the integer, or type fullreset
echo in the main menu.
echo.
echo This message will disappear shortly.
ping localhost -n 10 >nul
cls
echo (RUN ONCE)
echo What is your bukkit version file name? (IMPORTANT: INCLUDE .JAR)
echo Your bukkit jar CANNOT contain ANY spaces.
echo You can change this by typing fullreset in the main menu.
echo.
:nopero
SET /P jarfile=/X.jarfile/$ 
(echo %JARFILE%)> %settingsF%
if not exist %jarfile% goto nopero

:splash
Rem ////////////////////////////////////////////////////////////////////////
Rem /////////////                 SPLASH                     ///////////////
Rem ////////////////////////////////////////////////////////////////////////

title [RUNBUKK7]
color 1F
cls
echo Copyright 2013 shir0tetsuo     -            .
echo                                            (
echo          *   GIGABYTES: %GB%                                *
echo                                             `
echo    *  %FVSSplash%   *      _..---""""-...     )
echo                       .--'              `   .`
echo            -      ._.'     .   .      .-.   (    *
echo                  / -     .       .    `-   (   .      .=.
echo     *            )`     .                  '    `   _'(88\
echo                 '      .--.       .   \___   )  _.-'  :888^|
echo                '      ^|  . ^|     .   _/   \__.-'8'  -' \88:
echo               ^|       `.__.'.  .       ( __('8  8.   _.-`='
echo               '                      \__/  x.8. `8.-'
echo *            ^|        :           ..'     / `-Px'  '
echo              `        `:.                 ^| - \ `- :
echo           *   `      _                  _/  __/    '
echo               `     ( )-             .'     \    ./
echo                .     .                         .' :
echo                 .         Shir0's Server      .  .
echo                             Starter   __.    .  .         *
echo  -                )                 ,' _-'   ..'
echo                   `^.-.    .- .      -'   _.'
echo                  *     `a:f_   `    ___.-'         *
echo                            ""--"--""
ping localhost -n 5 >nul
cls
echo                                -            .
echo                                            (
echo          *   I AM NOT RESPONSIBLE FOR ANY                *
echo              LOSS OF DATA THAT MAY OCCUR    `
echo    *  %FVSSplash%   *  DUE TO MODIFYING THE CONTENTS
echo                       .--'     OF THIS FILE OR NOT FOLLOWING
echo            -      ._.'     .   .      .-THE INSTRUCTIONS!
echo                  / -     .       .    `-   (   .      .=.
echo     *            )`     .                  '    `   _'(88\
echo                 '      .--.       .   \___   )  _.-'  :888^|
echo                '      ^|  . ^|     .   _/   \__.-'8'  -' \88:
echo               ^|       `.__.'.  .       ( __('8  8.   _.-`='
echo               '                      \__/  x.8. `8.-'
echo *            ^|        :           ..'     / `-Px'  '
echo              `        `:.                 ^| - \ `- : BETA
echo           *   `      _                  _/  __/    ' 
echo               `     ( )-             .'     \    ./ 
echo                .     .                         .' :
echo                 .         Shir0's Server      .  .
echo                             Starter   __.    .  .         *
echo  -                )                 ,' _-'   ..'
echo                   `^.-.    .- .      -'   _.'
echo                  *     `a:f_   `    ___.-'         *
echo                            ""--"--""
ping localhost -n 5 >nul
color 0F

Rem ////////////////////////////////////////////////////////////////////////
Rem /////////////              END OF SPLASH                 ///////////////
Rem ////////////////////////////////////////////////////////////////////////

REM //////////////////////////////////////////////////////////// JAR EXIST
:reset1
if exist %jarfile% goto debug
if %jarfile%==0.txt goto freset
cls
echo           Whoops! %jarfile% appears to be MISSING!
echo.
echo - This program must be in the same folder as %jarfile%.
echo - If you already have your bukkit jar in the same folder, please
echo   make sure that the filename is %jarfile%.
echo.
echo If %jarfile% already exists
echo in your folder, you can modify the %SettingsF% file on the
echo first line to match the filename, or delete %SettingsF% to
echo trigger a full reset.
pause
exit

REM //////////////////////////////////////////////////////////// JAR EXIST END
REM //////////////////////////////////////////////////////////// DEBUG LINES
REM ////////////////////////////////////////////////////////////
REM ///////// DO NOT MODIFY ANY OF THESE LINES OR IT WILL CRASH
REM ////////////////////////////////////////////////////////////
:resetdebug1
if %runmenu%==loop_afk goto loop
:resetdebug2
if %runmenu%==loop goto loop
:cont
if %runmenu%==run goto invalid

REM //////////////////////////////////////////////////////////// END DEBUG
REM ////////////////////////////////////////////////////////////
REM ////////////////////////////////////////////////////////////
REM //////////////////////////////////////////////////////////// MENU
cls
:debug
if not exist %jarfile% goto reset1
cls
echo ////////////////////////////////////////////////////////
echo ///////////////////////////////////////BUKKIT!//////////
echo /// %FVSShort% ///// NightDelSolEXE7 //////////////////////
echo ________________________________________________________
echo ________________________________________________________
echo                      Main Menu
:invalid
title [RUNBUKK7] - Start Menu
echo ________________________________________________________
echo ________________________________________________________
echo /R///////////////////////////////////////////////C//////
echo /U////       run        /// checkgb          /////O/////
echo /N//// loop    loop_afk ///     purgelogs    //////N////
echo /////////////// 2.0 //////////////// 1.0 ///////////F///
echo /R////    maploader     /// fullreset   help ////////I//
echo /B///////////// 0.9 /////// debug    debug.s /////////G/
echo /////////////////////////////////////// quit ///////////
set runmenu=err
set /p runmenu= /%FVSShort%.MainMenu/$ 
if %runmenu%==run goto loop
if %runmenu%==loop goto loop
if %runmenu%==loop_afk goto loop
if %runmenu%==help goto help1
if %runmenu%==quit goto end
if %runmenu%==checkgb goto checkgb
if %runmenu%==fullreset goto freset
if %runmenu%==purgelog goto logname
if %runmenu%==maploader goto unload
if %runmenu%==err goto invalid
REM Debug Hidden Function
if %runmenu%==debug echo You are now entering debug mode.
if %runmenu%==debug echo Close manually to exit debug mode. It is recommended that you run debug from C:\
if %runmenu%==debug echo --------------------------------------------------------------------------------
if %runmenu%==debug pause
if %runmenu%==debug @echo on
if %runmenu%==debug goto freset
if %runmenu%==debug.s @echo on &goto db.s
echo.
echo %runmenu% is not an option or was typed incorrectly.
echo You must enter one of the options displayed in lower case.
echo.
pause
goto invalid

REM //////////////////////////////////////////////////////////// END MENU
REM ////////////////////////////////////////////////////////////
REM ////////////////////////////////////////////////////////////
REM ////////////////////////////////////////////////////////////
REM //////////////////////////////////////////////////////////// TOOLS
:logname
cls
if not exist server.log goto logname2  
if exist server.log RENAME server.log server.log.old
echo PURGELOG
echo.
echo server.log renamed to server.log.old !
echo The server log was renamed so that there are no lag conflicts.
echo ///// Deleting it is recommended. /////
echo It is recommended that you run this when your server log is larger
echo                           than 512 KB.
echo All for the benifits of latency! :)
pause
cls
goto debug
:logname2
echo //// Error ////
echo server.log doesn't exist in your folder.
echo You haven't started the server up silly!
goto invalid
:checkgb
echo.
echo You are currently using %GB% gigabytes.
echo The default gigabyte usage is 2.
echo Please type fullreset to display the gigabyte modifier
echo if required.
echo.
goto invalid
REM ////////////////////////////////////////////////////////////
REM ////////////////////////////////////////////////////////////
REM ////////////////////////////////////////////////////////////
REM ------------------------------------------------------------ MLU1
REM This is a BETA! The coding is NOT compressed!
:unload
title [RUNBUKK7] - Map Loading Utility 0.9 BETA
cls
echo BETA
echo                             Map Loading Utility
echo                                      0.9
echo.
echo.
echo This is a very simple map loading utility built imported from Server6.
echo          !!! You don't need to type in .unloaded in the file name !!!
echo          !!!      Special characters might crash this console     !!!
echo            PLEASE NOTE, THIS IS NOT FOR MULTIPLE SLOTS, JUST LOADING
echo.
echo Enter the name of your world folder below. (World is Default)
echo On the second line, type unload or load. (Unload is Default)
echo If you are here by mistake, type menu to go back to the Server6 menu.
echo.
SET MLU1=world
SET /P MLU1= //S6/MLU: 
if %MLU1%==menu goto debug
if not exist %MLU1% goto nef
:refunction 
SET MLU2=unload
SET /P MLU2= //S6/MLU/%MLU1%: 
if %MLU2%==unload goto RunFCH
if %MLU2%==load goto RunFCH
echo You have typed in an incorrect function.
echo.
echo.
goto refunction
:RunFCH
echo.
echo If the information displayed is correct, press ENTER to execute.
echo Type abort to re-enter the parameters, or type menu to exit MLU.
echo.
SET FCH=execute
SET /P FCH= %MLU2% %MLU1%: 
if %FCH%==execute goto MLUE
if %FCH%==menu goto debug
if %FCH%==abort goto unload
echo.
echo The command was not entered properly.
echo Please make sure that you enter the command in lower case.
echo You will be returned to the main menu.
pause
goto debug

:MLUE
REM ---------------------------- FNS ---------------------------
cls
if %MLU2%==unload goto unldline
if %MLU2%==load goto loadline
echo An error has been returned.
pause
exit
:unldline
cls
echo Attempting to unload %MLU1%...
if exist %MLU1%.unloaded goto nef2
if not exist %MLU1% goto nef3
rename %MLU1% %MLU1%.unloaded
goto confirmation
:loadline
cls
echo Attempting to load %MLU1%...
if not exist %MLU1%.unloaded goto nef3
if exist %MLU1% goto nef2
rename %MLU1%.unloaded %MLU1%
goto confirmation
REM --------------------- NON EXISTENT FILE LINES --------------
:nef
if exist %MLU1%.unloaded goto refunction
echo.
echo The folder name you have entered doesn't exist in your server folder.
pause
cls
goto unload
:nef2
echo.
echo Error
if %MLU2%==unload echo You already have an unloaded %MLU1% folder!
if %MLU2%==load echo You already have a %MLU1% folder!
pause
goto unload
:nef3
echo.
echo Error
if %MLU2%==load echo The .unloaded
echo %MLU1% does not exist in your folder!
pause
goto unload
:qor
echo.
echo TYPE menu TO EXIT. TYPE unloader TO GO BACK TO THE UNLOADER.
SET qorf=menu
SET /P quor= //S6/MLU_FinishedJob: 
if %quor%==menu goto debug
if %quor%==unloader goto unload 
goto qor
REM ------------------------------------------------------------ END VARIABLE
:confirmation
echo.
REM Unload Function Variable
if %MLU2%==unload echo %MLU1% has been unloaded!
if %MLU2%==unload echo %MLU1% has been renamed to %MLU1%.unloaded .
if %MLU2%==unload echo You can MANUALLY load %MLU1% by deleting the .unloaded portion in its name,
if %MLU2%==unload echo or you can use the load function in the map unloader.
REM Load Function Variable
if %MLU2%==load echo %MLU1% has been loaded!
if %MLU2%==load echo %MLU1%.unloaded has been renamed to %MLU1% .
goto qor
REM ------------------------------------------------------------ MLU1 END
REM ////////////////////////////////////////////////////////////
REM ////////////////////////////////////////////////////////////
REM //////////////////////////////////////////////////////////// END TOOLS
REM //////////////////////////////////////////////////////////// RUN VAR
:loop
cls
echo [RUNBUKK7] Starting...
if %runmenu%==run title Server Console (Run) - RUNBUKK7
if %runmenu%==loop title Server Console (Loop) - RUNBUKK7
if %runmenu%==loop_afk title Server Console (AFK Mode) - RUNBUKK7
if %runmenu%==loop_afk echo Remember that AFK Mode is ON.
if %runmenu%==loop_afk echo To exit, MANUALLY close during interval.
REM set LROV=0
REM echo Do you want to record the instances where the server unexpectedly
REM echo crashes and closes Bukkit?
REM set /p LROV=Y/N: 
REM Prime example of a complex IF script
REM if %LROV%==Y set LROV=1&echo Instances will be recorded in crash.txt
echo.
REM //////////////////////////////////////////////////////////// RUN
REM You don't have to change this! Enter your gigabyte usage during the batch startup.
java -Xincgc -Xms%GB%G -Xmx%GB%G -jar %jarfile%
REM /////// CAUTION   DO NOT CHANGE DEBUG ROUTES!
echo.
REM if %LROV%==Y goto writecrash
:goback
if %runmenu%==run echo The Server has been stopped.
if %runmenu%==loop echo The server has been stopped.
if %runmenu%==loop_afk echo The server has been stopped (unexpectedly).
if %runmenu%==run pause
if %runmenu%==run goto reset1
if %runmenu%==loop_afk echo 10 Tick Interval...
if %runmenu%==loop_afk ping localhost -n 10 >nul
if %runmenu%==loop_afk goto resetdebug1
pause
goto resetdebug2

REM //////////////////////////////////////////////////////////// END RUN
REM ////////////////////////////////////////////////////////////
REM ////////////////////////////////////////////////////////////
REM //////////////////////////////////////////////////////////// CONSOLE
:help1
title [RUNBUKK7] - Help
cls
echo.
echo [%FVSLong%] Help Page
echo.
echo run       Start the Server.
echo loop      Start an infinite plugin loop with a pause system. Useful for
echo           adding plugins. Exit manually during pause.
echo loop_afk  Start an infinite plugin loop with a timed delay. Useful if you're
echo           gone somewhere and you don't want to worry about if the server
echo           gets shutdown. Exit manually during interval.
echo.
echo checkgb   This checks how many gigabytes you're going to load.
echo fullreset Is as it says, it does a full reset, allowing the gigabyte modifier
echo           to display.
echo purgelog  Simply renames your server.log file so that it doesn't load when
echo           the server does. This is useful. It gets rid of some lag if your
echo           server.log is over 512 kb.
echo.
pause
cls
echo maploader
echo           Simple map unloader which changes the filename of your world so that
echo           it doesn't load when the server starts. Planned functionality:
echo           - The ability to utilize world slots.
echo           - Overwrite loaded world slot.
echo           - Change folder name to active world.
echo           Map Loading Utility at this time is mainly going to be used for the
echo           unload function when an admin would like to start a new world right
echo           away.
echo.
echo      ////////////////////////////////////////////////////////////
echo           It is not recommended that you use MLU at this time.
echo      ////////////////////////////////////////////////////////////
echo.
echo Designed by NightDelSolEXE7, youtube Killshadow3. Comment on the Server6 video
echo if you have any comments / questions / suggestions, anything.
echo.
pause
cls
echo debug
echo           Runs the file over again with echo ON.
echo debug.s
echo           Runs the file over again skipping to the very beginning of the file,
echo           rather than the menu.
echo options
echo         * This function is not yet available.
echo           Once enabled it will be used to store extra information about the
echo           map loader utility (MLU) on the second and third settings.rbk lines.
echo           (Line 2: Ejected Map. Line 3: 0/1; stating unloaded true/false.
echo           Line 4: Server's world default name. Line 5: Original loaded name.)
REM line 2 = addr of unloaded. Eg world.e (%world%.e)
REM if 0 = None unloaded. Unload to set line 2 from line 4 filename.
REM if 1 = ejected map, see line 2.
REM if 1 = true, options = denied till unloaded current world unloads.
REM on if 1 = true & unload, rename %world% to %line5% & rename line 2 to line 4.
REM On unload, set line 3 = 0 and set line 2 = 0.
REM line 4 = since %world%.e, %world%==filename.
REM Options will include link to bukkit dev site.
REM Line 6 will be a splash skipper. 0/1; 0=off 1=on
REM Line 7 will be a menu skipper, direct run. 0=off 1=on (comes before line 6 in file header)
REM Lines that shouldn't boot will be echoes.
REM Test echo. to see if it will skip that line.
REM Splash skipper before ping lines
REM Add backup tool (to %world%.bak), (in the menu under maploader)
REM Add timestamp to purgelog, (server.log > server.log.%time%.old) - Save in sep fol
REM .
REM Skip to line 5 for world name?!?! In Options: getServerWorldname
echo.
echo End of Help.
echo.
pause
goto reset1
Rem To Add: built-in option for gigabyte usage

REM ////////////////////////////////////////////////////////////
REM //////////////////////////////////////////////////////////// EOF
REM ////////////////////////////////////////////////////////////
REM ////////////////////////////////////////////////////////////
:end
cls
echo Thank you for using RUNBUKK!
pause
exit
REM ////////////////////////////////////////////////////////////
REM ////////////////////////////////////////////////////////////
REM //////////////////////////////////////////////////////////// END MAIN CONSOLE


REM ////////////////////////////////////////////////////////////
REM ///////////// THIS IS WHERE RUNMENU OPTIONS ////////////////
REM /////////////   ARE GOING TO BE AS WELL AS  ////////////////
REM ////////////////// LOADER LINES ////////////////////////////

REM :writecrash
REM echo Bukkit crashed or exited at [%time%] >>crash.txt
REM goto goback

:LoadGBU
(
set /p GB=
)<GBUsage.txt
goto splash