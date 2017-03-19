ECHO off

SET BIN_DIR=%~dp0
SET EXE=cpuminer-aes-avx2.exe

:main
CLS
ECHO ********************************************
ECHO *                  Pools                   *
ECHO ********************************************
ECHO *                                          *
ECHO *               1 - Zpool                  *
ECHO *               2 - DwarfPool              *
ECHO *               3 - Suprnova               *
ECHO *               4 - Exit                   *
ECHO *                                          *
ECHO ********************************************

CHOICE /C:1234 /M "Select pool"

IF ERRORLEVEL 4 GOTO exit
IF ERRORLEVEL 3 GOTO suprnova
IF ERRORLEVEL 2 GOTO dwarfpool
IF ERRORLEVEL 1 GOTO zpool

GOTO main

REM =============================================
:suprnova
CLS

ECHO ****************************************
ECHO *          https://suprnova.cc         *
ECHO ****************************************
ECHO *                                      *
ECHO *            1 - Lyra2z (XZC)          *
ECHO *            2 - Back                  *
ECHO *            3 - Exit                  *
ECHO *                                      *
ECHO ****************************************

CHOICE /C:123 /M "Select algorithm"

IF ERRORLEVEL 3 GOTO exit
IF ERRORLEVEL 2 GOTO main
IF ERRORLEVEL 1 GOTO sn-xzc
GOTO suprnova

:sn-run
taskkill /IM %EXE%
cmd.exe /c start %BIN_DIR%/%EXE% -c config/suprnova.%ALGO%
GOTO exit

:sn-xzc
SET ALGO=xzc
GOTO sn-run

REM =============================================

:zpool

CLS

ECHO *******************************************
ECHO *         https://www.zpool.ca            *
ECHO *******************************************
ECHO *                                         *
ECHO *            1 - Xevan (BSD)              *
ECHO *            2 - m7m (XMG)                *
ECHO *            3 - Yescrypt                 *
ECHO *            4 - Neoscrypt                *
ECHO *            5 - Argon2                   *
ECHO *            6 - Lyra2z (XZC)             *
ECHO *            7 - Back                     *
ECHO *            8 - Exit                     *
ECHO *                                         *
ECHO *******************************************


CHOICE /C:12345678 /M "Select algorithm"

IF ERRORLEVEL 8 GOTO exit
IF ERRORLEVEL 7 GOTO main
IF ERRORLEVEL 6 GOTO menu6
IF ERRORLEVEL 5 GOTO menu5
IF ERRORLEVEL 4 GOTO menu4
IF ERRORLEVEL 3 GOTO menu3
IF ERRORLEVEL 2 GOTO menu2
IF ERRORLEVEL 1 GOTO menu1

GOTO zpool

:run
SET URL=stratum+tcp://%ALGO%.mine.zpool.ca:%PORT%
taskkill /IM %EXE%
cmd.exe /c start %BIN_DIR%/%EXE% -a %ALGO% -o %URL% -p %PASS% -c config/zpool.ca.json
GOTO exit

:menu1
SET ALGO=xevan
SET PASS=BSD
SET PORT=3739
GOTO run

:menu2
SET ALGO=m7m
SET PASS=XMG
SET PORT=6033
GOTO run

:menu3
SET ALGO=yescrypt
SET PASS=BTC
SET PORT=6233
GOTO run

:menu4
SET ALGO=neoscrypt
SET PASS=4
SET PORT=4233
GOTO run

:menu5
SET ALGO=argon2
SET PASS=MMXVI
SET PORT=4234
GOTO run

:menu6
SET ALGO=lyra2z
SET PASS=XZC
SET PORT=4553
GOTO run


REM =============================================
:dwarfpool
CLS

ECHO ****************************************
ECHO *          http://dwarfpool.com        *
ECHO ****************************************
ECHO *                                      *
ECHO *           1 - Cryptonight (XMR)      *
ECHO *           2 - Equihash (ZEC)         *
ECHO *           3 - Back                   *
ECHO *           4 - Exit                   *
ECHO *                                      *
ECHO ****************************************

CHOICE /C:1234 /M "Select algorithm"

IF ERRORLEVEL 4 GOTO exit
IF ERRORLEVEL 3 GOTO main
IF ERRORLEVEL 2 GOTO dw-zec
IF ERRORLEVEL 1 GOTO dw-xmr
GOTO dwarfpool

:dw-run
taskkill /IM %EXE%
cmd.exe /c start %BIN_DIR%/%EXE% -c config/dwarf-pool.%ALGO%
GOTO exit

:dw-xmr
SET ALGO=xmr
GOTO dw-run

:dw-zec
SET ALGO=zec
GOTO dw-run

:exit 
EXIT