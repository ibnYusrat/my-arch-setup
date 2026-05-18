#!/bin/bash

# Define the options
options="  Screen Off\n  Restart\n  Shutdown"

# Show wofi menu (appears as a clean list)
choice=$(echo -e "$options" | wofi --dmenu --prompt "System" --width 250 --height 180 --hide-scroll)

# Execute based on the user's choice
case "$choice" in
    *"Screen Off"*)
        sleep 1 && hyprctl dispatch dpms off
        ;;
    *"Restart"*)
        systemctl reboot
        ;;
    *"Shutdown"*)
        systemctl poweroff
        ;;
esac
