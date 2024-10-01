@echo off
setlocal enabledelayedexpansion

:main
set /p path="Path to rename file or folder: "
set /p choice="Choose what to rename (F for files, D for directories, B for both): "
set /A filesNb=1
set /A foldersNb=1

if not exist "%path%" (
    echo Path doesn't exist
    pause
    goto main
)

if /i "%choice%"=="B" (
    set /p prefix_files="New name start with for files: "
    set /p prefix_dirs="New name start with for directories: "
) else (
    set /p prefix="New name start with: "
)

echo Renaming ...
echo.

if /i "%choice%"=="F" (
    for %%a in ("%path%\*") do (
        if not exist "%%a\" (
            set "oldName=%%~nxa"
            set "newName=!prefix!!filesNb!%%~xa"
            ren "%%a" "!newName!"
            echo [FILE] !oldName! -^> !newName!
            set /A filesNb+=1
        )
    )
)

if /i "%choice%"=="D" (
    for /d %%a in ("%path%\*") do (
        set "oldName=%%~nxa"
        set "newName=!prefix!!foldersNb!"
        ren "%%a" "!newName!"
        echo [DIR] !oldName! -^> !newName!
        set /A foldersNb+=1
    )
)

if /i "%choice%"=="B" (
    for %%a in ("%path%\*") do (
        if not exist "%%a\" (
            set "oldName=%%~nxa"
            set "newName=!prefix_files!!filesNb!%%~xa"
            ren "%%a" "!newName!"
            echo [FILE] !oldName! -^> !newName!
            set /A filesNb+=1
        )
    )

    for /d %%a in ("%path%\*") do (
        set "oldName=%%~nxa"
        set "newName=!prefix_dirs!!foldersNb!"
        ren "%%a" "!newName!"
        echo [DIR] !oldName! -^> !newName!
        set /A foldersNb+=1
    )
)

echo.
echo Renaming finished
set /p continueChoice="Press 'C' to continue or press any other key to quit "
if /i "%continueChoice%"=="C" (
    echo.
    goto main
)

endlocal
exit
