@echo off

Rem Set directory for Org
set FORMS="<DRIVE_LETTER>:\Personnel\member_folder"

Rem Read each name from name list.(EXCEL SPREADSHEET DATA)

Rem Need to use this next line to prevent weird cmd.exe variable issues in for loops
SETLOCAL ENABLEDELAYEDEXPANSION

set /a counter=0
set /a couldntfind=0

echo List Start:> list.txt
echo NotFound Start:> notfound.txt
Rem Loop through each name given
FOR /F "tokens=1,2 delims=," %%a in (names.txt) DO (
	set /a counter+=1
	echo First name:%%b
	echo Last name:%%a
	set copyDir=!FORMS:memberfolder=%%b.%%a!
	echo !copyDir!
	IF EXIST !copyDir! (
		echo %%b.%%a >> list.txt
		echo !copyDir!
		REM forfiles /p !copyDir! /m *.* /c "cmd /c echo @file is a batch file"		
		
		REM Iterate through each file in the member's folder
		for /f "tokens=*" %%a in ('dir !copyDir! /b') do (
			REM File is set to file name
			set file=%%~na
			set fileSubstring=!file:~0,6!
			REM Compare first 6 characters of file name to string
			IF NOT !fileSubstring!==FORMX (
				
				IF NOT !fileSubstring!==FORMX2 (
					
					set fileSubstring=!file:~0,5!
					IF NOT !fileSubstring!==FORMX3 (
						
						set fileSubstring=!file:~0,12!
						IF NOT !fileSubstring!==FORMX4 (
							echo File not FORMX,FORMX2,FORMX3,FORMX4:!file!!ext!>>list.txt
						) ELSE (
							echo Found FORMX4:!file!!ext!>> list.txt	
						)
					) ELSE (
						echo Found FORMX3:!file!!ext!>> list.txt
					)
				) ELSE (
					echo Found FORMX2:!file!!ext!>> list.txt
				)
			) ELSE (
				echo Found FORMX:!file!!ext!>> list.txt
			)
			REM set ext=%%~xa
			REM set new=!file:~0,16!
			REM echo !file!!ext!
		)		
	) ELSE (
		echo %%b.%%a >> notfound.txt
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
