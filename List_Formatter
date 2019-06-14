@echo off

SETLOCAL ENABLEDELAYEDEXPANSION

set /a counter=0

set filename=OrgName
set first_half_name=

echo Formatted List:> !filename!_Formatted.txt

FOR /F "tokens=1,2 delims=," %%a in (!filename!.txt) DO (
	set fullname=%%b.%%a
	set first_half_name=%%b
	set lastname=%%a
	for /F "tokens=1,2,3 delims= " %%a in ("!first_half_name!") DO (
		echo First name:%%a
		echo Middle name:%%b
		echo Prefix:%%c
		echo Last name:!lastname!
		set formatted_name=!lastname!.%%a
		echo !formatted_name!!>> !filename!_Formatted.txt
	)
)

ENDLOCAL
echo "The program has completed"
pause

