@echo off
cd /D "F:\apps\ytdlp"
setlocal enabledelayedexpansion

:MENU
echo.
echo Choose option:
echo   1. Video+Audio (MP4)
echo   2. Audio-only (choose MP3, FLAC, or OPUS)
echo   3. Video-only (choose MKV, MP4, or WEBM)
echo   4. Video+Audio+Subtitles (VLC-friendly)
echo   5. Stream Video to VLC (download + play + cleanup)
echo   6. Exit
set /p choice="Enter choice [1-6]: "

if "%choice%"=="6" goto END

set /p url="Enter video URL: "
set af=
set ext=

if "%choice%"=="1" (
  set flags=-f "bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]" --merge-output-format mp4
) else if "%choice%"=="2" (
  echo Select audio format:
  echo   a. mp3
  echo   b. flac
  echo   c. opus
  set /p afmt="Enter a, b, or c: "
  if /I "%afmt%"=="a" set af=mp3
  if /I "%afmt%"=="b" set af=flac
  if /I "%afmt%"=="c" set af=opus
  if not defined af (
    echo Invalid choice. Try again.
    goto MENU
  )
  set flags=-x --audio-format %af%
) else if "%choice%"=="3" (
  echo Select video-only container:
  echo   a. mkv
  echo   b. mp4
  echo   c. webm
  set /p vfmt="Enter a, b, or c: "
  if /I "%vfmt%"=="a" set ext=mkv
  if /I "%vfmt%"=="b" set ext=mp4
  if /I "%vfmt%"=="c" set ext=webm
  if not defined ext (
    echo Invalid choice. Try again.
    goto MENU
  )
  set flags=-f "bestvideo[ext=%ext%]" --merge-output-format %ext%
) else if "%choice%"=="4" (
  set flags=-f "bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]" --write-subs --write-auto-sub --embed-subs --sub-langs "en.*" --merge-output-format mp4
) else if "%choice%"=="5" (
  set "vlcPath=F:\apps\vlc\vlc.exe"
  if not exist "%vlcPath%" (
    echo VLC not found. Please install VLC or update the path.
    pause
    goto MENU
  )

  set "tempFile=stream_%random%%random%.mkv"
  echo.
  echo Starting download to: %tempFile%
  echo This may take a few seconds...

  REM Download and merge synchronously
  yt-dlp.exe -f "bestvideo+bestaudio/best" --merge-output-format mkv -o "%tempFile%" "%url%"
  if not exist "%tempFile%" (
    echo Error: file was not created.
    pause
    goto MENU
  )

  echo.
  echo Playing with VLC...
  "%vlcPath%" "%tempFile%" --play-and-exit

  echo.
  echo Cleaning up...
  del /f /q "%tempFile%"
  echo Done.
  pause
  goto MENU
) else (
  echo Invalid option. Try again.
  goto MENU
)

REM Run yt-dlp normally for options 1-4
echo Running: yt-dlp.exe %flags% "%url%"
yt-dlp.exe %flags% "%url%"

REM Clean up subtitles after embedding
if "%choice%"=="4" (
  del /Q *.vtt 2>nul
)

echo.
pause
goto MENU

:END
echo Goodbye!
pause
