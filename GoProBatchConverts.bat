@echo off
set input_folder=D:\Unity files\a
set output_folder=D:\GoProConvertedVideos

for %%f in ("%input_folder%\*.mp4") do (
    ffmpeg -i "%%f" -c:v libx265 -crf 28 -preset medium -c:a aac -b:a 128k "%output_folder%\%%~nf_converted.mp4"
)
pause