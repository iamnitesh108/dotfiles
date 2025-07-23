#!/bin/bash

# Get swap usage and total in human-readable format (e.g., 8Ki/4Mi)
swap_raw=$(free -h | awk '/Swap:/ {print $3 "/" $2}')

# Remove 'i' from units (Ki, Mi, Gi, Ti)
# Explanation:
# s/         - substitute command
# \([KMGT]\) - capture K, M, G, or T (the unit letter) into group 1
# i          - match the 'i' immediately after the unit letter
# /\1/       - replace with what was captured in group 1 (effectively removing 'i')
# g          - global replacement (replace all occurrences on the line)
swap_formatted=$(echo "${swap_raw}" | sed 's/\([KMGT]\)i/\1/g')

echo "  ${swap_formatted}"
