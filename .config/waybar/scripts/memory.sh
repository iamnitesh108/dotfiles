#!/bin/bash
ram=$(free | awk '/Mem:/ {printf("%.0f", $3/$2 * 100)}')
echo "󰘚 ${ram}% |"

