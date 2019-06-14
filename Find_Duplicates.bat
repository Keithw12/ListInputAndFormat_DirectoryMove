@echo off
SETLOCAL ENABLEDELAYEDEXPANSION

set /a counter=0
set prevA=
set prevB=
set prevC=
set fullname=
set prevfullname=

echo Duplicates Start:> duplicates.txt
FOR /F "tokens=1,2,3 delims=." %%a in (global_list_main.txt) DO (
	echo First name:%%b
	echo Last name:%%a
	echo Number:%%c
	set fullname=%%a.%%b
	IF !prevfullname!==!fullname! (
		set /a counter+=1
		echo !prevfullname!.!prevC! >> duplicates.txt
		echo !fullname!.%%c >> duplicates.txt
		REM {prevA & prevB & %%b & %%a>>dup.txt}

	)	
	set prevB=%%b
	set prevA=%%a
	set prevC=%%c
	set prevfullname=!prevA!.!prevB!
)

echo Number of duplicate names: !counter!
ENDLOCAL
echo "The program has completed"
pause
