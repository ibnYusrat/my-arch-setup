#!/bin/bash

# ==============================================================================
# SMART PAUSE CONFIGURATION
# Add the 'class' name of any application you want to IGNORE.
# (If one of these apps is open, the wallpaper will KEEP PLAYING).
#
# You can find the class of any open window by running: `hyprctl clients`
# ==============================================================================
IGNORED_CLASSES=(
    "kitty"
    "rofi"
    "wofi"
    "waybar"
)

IPC_SOCKET="/tmp/mpvsocket"
STATE="playing"

while true; do
    # Get active workspace ID
    ACTIVE_WS=$(hyprctl activeworkspace -j | jq -r '.id' 2>/dev/null)
    
    if [ -z "$ACTIVE_WS" ]; then
        sleep 1
        continue
    fi

    # Construct the jq filter to find windows on the active workspace 
    # that are NOT in the ignored list and are visible.
    FILTER=".[] | select(.workspace.id == $ACTIVE_WS and .mapped == true and .hidden == false"
    for class in "${IGNORED_CLASSES[@]}"; do
        FILTER+=" and .class != \"$class\""
    done
    FILTER+=")"

    # Count blocking windows
    BLOCKING_COUNT=$(hyprctl clients -j | jq "[ $FILTER ] | length" 2>/dev/null)

    # Prevent errors if jq fails briefly
    if [ -z "$BLOCKING_COUNT" ]; then
        BLOCKING_COUNT=0
    fi

    if [ "$BLOCKING_COUNT" -gt 0 ]; then
        if [ "$STATE" != "paused" ]; then
            echo '{ "command": ["set_property", "pause", true] }' | socat - UNIX-CONNECT:"$IPC_SOCKET" > /dev/null 2>&1
            STATE="paused"
        fi
    else
        if [ "$STATE" != "playing" ]; then
            echo '{ "command": ["set_property", "pause", false] }' | socat - UNIX-CONNECT:"$IPC_SOCKET" > /dev/null 2>&1
            STATE="playing"
        fi
    fi
    
    sleep 0.5
done
