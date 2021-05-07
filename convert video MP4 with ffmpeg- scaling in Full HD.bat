REM https://linuxconfig.org/ffmpeg-audio-format-conversions
REM https://linuxconfig.org/ffmpeg-audio-format-conversions
REM ffmpeg.exe -i input.mkv -codec copy -acodec ac3 output.mkv

@echo off
echo %CD%
echo %~dp0
cd /d %~dp0

REM For first file
REM %1
REM For multiple files
echo %*

set COUNTER=0
for %%x in (%*) do (
	echo %%x
	set /A COUNTER+=1
)
echo COUNTER = %COUNTER%

if %COUNTER% GTR 0 (
	if %COUNTER% EQU 1 (
		echo _____GET ONE FILE_____
	) else (
		echo _____GET MULTI FILES: %COUNTER% files_____
	)
	for %%x in (%*) do (
REM //////////////////// MAIN \\\\\\\\\\\\\\\\\\\\\\\\\		
ffmpeg -y -i %%x -qmin 10 -qmax 40 -crf 30 -c:v libx264 -b:v 1000k -c:a aac -ar 48000 -b:a 128k -vf "scale='min(1920,iw)':-1" %%~nx_output_MP4.mp4
REM		ffmpeg -i %%x -vcodec copy -acodec copy "%%~nx_output_MP4.mp4"
	)
) else (
	echo _____GET NO ONE FILES_____
)

pause
