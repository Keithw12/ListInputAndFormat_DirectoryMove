@echo off

SETLOCAL ENABLEDELAYEDEXPANSION

set /a counter=0
set prevA=
set prevB=
set prevC=
set fullname=
set prevfullname=
set /a mybool=0
set /a dirtlistnamescount=0
set filename=Org_Formatted

echo Names_Cleaned:> !filename!_Cleaned.txt

FOR /F "tokens=1,2 delims=." %%a in (!filename!.txt) DO (
	set /a dirtlistnamescount+=1
	set prevB=%%b
	set prevA=%%a
	set fullname=%%a.%%b
	FOR /F "tokens=1,2 delims=." %%a in (duplicates.txt) DO (
		
		IF /I !fullname!==%%a.%%b (
			set /a mybool=1
			echo !fullname!
			echo %%a.%%b
			set /a counter+=1
		)	
	)
	IF !mybool!==0	(
		echo !fullname!>> !filename!_Cleaned.txt
	)
	set /a mybool=0
)
echo Number of names:!dirtlistnamescount!
echo Number of duplicates found: !counter!
ENDLOCAL
echo "The program has completed"
pause
