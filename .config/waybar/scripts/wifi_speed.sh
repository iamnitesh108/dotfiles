#!/bin/bash

# Simple WiFi download speed monitor for Waybar
# Change this to your interface or leave empty for auto-detection
INTERFACE="${1:-wlan0}"

# Cache file for storing previous measurements
CACHE_FILE="/tmp/waybar_wifi_speed_${INTERFACE}"

# Read current RX bytes
rx_bytes=$(cat /sys/class/net/$INTERFACE/statistics/rx_bytes 2>/dev/null) || {
    echo "No WiFi"
    exit 1
}

current_time=$(date +%s)

# Read previous values
if [ -f "$CACHE_FILE" ]; then
    read prev_rx prev_time < "$CACHE_FILE"
else
    # First run - store current values and show 0
    echo "$rx_bytes $current_time" > "$CACHE_FILE"
    echo "0.00 Mbps"
    exit 0
fi

# Calculate time difference
time_diff=$((current_time - prev_time))

# Avoid division by zero
if [ "$time_diff" -le 0 ]; then
    echo "0.00 Mbps"
    exit 0
fi

# Calculate download rate (bytes per second)
rx_rate=$(((rx_bytes - prev_rx) / time_diff))

# Handle negative values (counter reset)
[ "$rx_rate" -lt 0 ] && rx_rate=0

# Convert to Mbps using integer arithmetic for 2 decimal places
rx_mbps_int=$((rx_rate * 800 / 1000000))  # *8/1000000 * 100 for 2 decimals

# Format with 2 decimal places and download icon
printf "| ⬇ %d.%02d Mbps\n" $((rx_mbps_int / 100)) $((rx_mbps_int % 100))

# Store current values
echo "$rx_bytes $current_time" > "$CACHE_FILE"
