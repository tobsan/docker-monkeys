#!/bin/bash -eu

MONKEYDIR="/gorilla/app/bin/win32"
MONKEYBIN="DancingMonkeys.exe"
cd $MONKEYDIR

if [ $# -ne 2 ] || [ $1 != "--music" ]; then
    echo "Usage: --music <mp3/wav>"
    exit 1
fi

MUSICFILE="$2"
if ! [ -f "$MUSICFILE" ]; then
    echo "Can't find $MUSICFILE"
    exit 2
fi

# TODO: Make a nice list of music formats rather than a long if
FILEXT="${MUSICFILE##*.}"
if [ "$FILEXT" != "wav" ] && [ "$FILEXT" != "mp3" ] && [ "$FILEXT" != "ogg" ]; then
    echo "Music file name must end in .wav, .mp3 or .ogg"
    exit 3
fi

# LAME doesn't seem to work in the wine setting, so we convert with ffmpeg
# beforehand
if [ "$FILEXT" != "wav" ]; then
    echo "File format is not wav, converting..."
    ffmpeg -hide_banner -i "$MUSICFILE" /tmp/music.wav 2>/dev/null
    MUSICFILE="/tmp/music.wav"
fi

# Run Dancing monkeys
echo "Running DancingMonkeys, be patient..."
wine "$MONKEYBIN" -ob "$MUSICFILE" 2>/dev/null
