# vlc-karaoke
Adding songs to playlist of VLC player via mobile phones

## Make your own MMO video

### Download video with best resolution 1080 at most
```
yt-dlp -f 'bestvideo[height<=1080]+bestaudio/best[height<=1080]' --merge-output-format mp4 https://youtu.be/xyz?ab=xxxxxx
```

### Extract audio track in aac format
```
ffmpeg -i video.mp4 -c:a aac audio.aac
```

### Prepare mmo track from audio.acc using AI such as x-minus.pro

### Check volume level of mmo.mp3 and audio.aac
```
ffmpeg -i audio.aac -af volumedetect -f null /dev/null
ffmpeg -i mmo.mp3 -af volumedetect -f null /dev/null
```

### Adjust volume level to -15dB (your mileage may vary)
```
ffmpeg -i mmo.mp3 -af "volume=10dB" -c:a aac mmo.m4a
ffmpeg -i audio.aac -af "volume=10dB" -c:a aac audio.m4a
```

### Put all materials together
```
ffmpeg -i video.mp4 -i mmo.m4a -i audio.m4a -map 0:v -map 1:a -map 2:a -metadata:s:a:0 language=mmo -c copy output.mp4
```
