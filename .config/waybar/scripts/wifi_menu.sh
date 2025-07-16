#!/bin/bash

# Get list of available networks (SSID)
mapfile -t networks < <(nmcli -t -f SSID dev wifi | grep -v '^$' | sort -u)

# If no networks found, show message
if [ ${#networks[@]} -eq 0 ]; then
    notify-send "Wi-Fi" "No networks found"
    exit 1
fi

# Use wofi to select a network
choice=$(printf '%s\n' "${networks[@]}" | wofi --dmenu --prompt "Connect to Wi-Fi")

# Exit if no selection
[ -z "$choice" ] && exit 0

# Try connecting
nmcli dev wifi connect "$choice" || {
    # If connection fails (likely due to password), prompt for password
    password=$(wofi --dmenu --password --prompt "Password for $choice")
    [ -z "$password" ] && exit 0
    nmcli dev wifi connect "$choice" password "$password"
}

