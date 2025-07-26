# YouTube-DL Batch Utility
A simple and flexible .bat script that leverages yt-dlp and ffmpeg to:

Download Video + Audio   (works)
Downloads the best video and audio streams and merges them into an .mp4 file.

Download Audio Only
Choose your preferred audio format: (currently none work)

    MP3
    FLAC
    OPUS

Download Video Only
Choose your preferred video container: (currently none work)

    MKV

    MP4

    WEBM

Download Video + Audio + Subtitles (VLC-friendly) (works)
Downloads and embeds English subtitles along with the video and audio into an .mp4.

Stream Video to VLC (Experimental) (works but downloads the full file)
Downloads the best available video+audio stream into a temporary .mkv file, opens it in VLC, and deletes it after playback.

⚙️ Requirements

yt-dlp — place yt-dlp.exe in the same folder as the .bat file or update the script with its full path.

ffmpeg — must be installed and accessible via system PATH.

VLC Media Player — needed for streaming mode (option 5). Update the vlcPath in the script if it's installed in a different location.
