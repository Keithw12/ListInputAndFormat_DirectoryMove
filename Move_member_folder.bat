@echo off

Rem Set directory for Org
set FORMS="<DRIVE_LETTER>:\Personnel\member_folder"

Rem Read each name from name list.(EXCEL SPREADSHEET DATA)

Rem Need to use this next line to prevent weird cmd.exe variable issues in for loops
SETLOCAL ENABLEDELAYEDEXPANSION

set /a counter=0
set /a couldntfind=0
set namelist=Org_Formatted_Cleaned
set orgfolder="<DRIVE_LETTER>:\Org"

echo > notfound_!namelist!.txt
Rem Loop through each name given
FOR /F "tokens=1,2 delims=." %%a in (!namelist!.txt) DO (
	set /a counter+=1
	echo First name:%%b
	echo Last name:%%a
	echo %%b.%%a
	set copyDir=!FORMS:memberfolder=%%b.%%a!
	echo !copyDir!
	IF EXIST !copyDir! (
		echo !copyDir!
		MOVE !copyDir! !orgfolder!	
	) ELSE (
		echo %%a.%%b>> notfound_!namelist!.txt
		set /a couldntfind+=1
		echo Cannot locate member directory:!firstname!.!lastname!
		
	)
)
echo Number of names parsed:!counter!
echo Number of names to manually lookup:!couldntfind!
REM echo 

ENDLOCAL

echo "The program has completed"
pause
