#!/bin/bash -eu

MONKEYDIR="/gorilla/app/bin/win32"
MONKEYBIN="DancingMonkeys.exe"
cd $MONKEYDIR

if [ $# -lt 2 ] || [ "$1" != "--music" ]; then
    echo "[ERROR]: Usage: --music <mp3/wav>"
    exit 1
fi

MUSICFILE="$2"
if ! [ -f "$MUSICFILE" ]; then
    echo "[ERROR]: Can't find $MUSICFILE"
    exit 2
fi

# Make sure #@ is everything AFTER --music music.mp3
shift; shift;
if [ $# -ne 0 ]; then
    echo "[INFO]: Extra arguments to be passed to DancingMonkeys.exe: $*"
fi

FILEXT="${MUSICFILE##*.}"
if ! [[ "$FILEXT" =~ (wav|mp3|ogg|aac|flac) ]]; then
    echo "[ERROR]: Music file name must end in any of wav,mp3,ogg,aac,flac"
    exit 3
fi

# LAME doesn't seem to work in the wine setting, so we convert with ffmpeg
# beforehand
if [ "$FILEXT" != "wav" ]; then
    echo "[INFO]: File format is not wav, converting..."
    ffmpeg -hide_banner -i "$MUSICFILE" /tmp/music.wav 2>/dev/null
    MUSICFILE="/tmp/music.wav"
fi

echo "[INFO]: Running DancingMonkeys, please be patient..."
set -x
wine "$MONKEYBIN" -ob "$MUSICFILE" $@ 2>/dev/null
