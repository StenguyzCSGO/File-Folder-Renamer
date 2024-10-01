@echo off
setlocal enabledelayedexpansion

:main
cls
set /p path="Path to rename file or folder: "
set /p prefix="New name start with: "
set /A filesNb=1
set /A foldersNb=1

if not exist "%path%" (
    echo Le chemin n'existe pas. Réessayez.
    pause
    goto main
)

echo Renaming ...

for %%a in ("%path%\*") do (
    set "oldName=%%~nxa"
    set "newName=!prefix!!filesNb!%%~xa"
    ren "%%a" "!newName!"
    echo [FILE] !oldName! -^> !newName!
    set /A filesNb+=1
)

echo Renaming finished
echo.
set /p choice="Press 'C' to continue or any other key to exit: "
if /i "%choice%"=="C" (
    goto main
)

endlocal
exit
