#!/bin/bash

# Configuration
MONITOR="DP-2"
VIDEO_WALLPAPER="$HOME/Pictures/winter_forest.mp4"
STATIC_WALLPAPER="$HOME/Photos/archtv.jpg"
MPV_OPTS="--loop --no-audio --hwdec=auto --input-ipc-server=/tmp/mpvsocket"
STATE_FILE="$HOME/.config/hypr/.wallpaper_state"

# Help message
usage() {
    echo "Usage: $0 [mode]"
    echo "Modes:"
    echo "  1 : Video Wallpaper (Always Playing)"
    echo "  2 : Video Wallpaper (Auto-pause when windows are visible)"
    echo "  3 : Static Wallpaper (hyprpaper fallback)"
    echo "If no mode is provided, it will read the last saved state."
    exit 1
}

# Determine mode
MODE=$1
if [ -z "$MODE" ]; then
    if [ -f "$STATE_FILE" ]; then
        MODE=$(cat "$STATE_FILE")
    else
        MODE=1
    fi
else
    echo "$MODE" > "$STATE_FILE"
fi

# Cleanup existing wallpaper daemons and pause scripts
killall -q mpvpaper-stop
killall -q smart_pause.sh
killall -q mpvpaper
killall -q hyprpaper
killall -q swaybg

# Small delay to ensure they are killed
sleep 0.5

case "$MODE" in
    1)
        echo "Starting mpvpaper (Always Playing)..."
        mpvpaper -o "$MPV_OPTS" "$MONITOR" "$VIDEO_WALLPAPER" &
        ;;
    2)
        echo "Starting mpvpaper with custom smart-pause helper..."
        mpvpaper -o "$MPV_OPTS" "$MONITOR" "$VIDEO_WALLPAPER" &
        # Give mpvpaper a moment to create the socket
        sleep 1
        ~/.config/hypr/smart_pause.sh &
        ;;
    3)
        echo "Starting hyprpaper (Static)..."
        hyprpaper &
        ;;
    *)
        echo "Invalid mode selected."
        usage
        ;;
esac
