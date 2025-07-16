#!/bin/bash
cpu=$(top -bn1 | grep "Cpu(s)" | awk '{printf("%.0f", 100 - $8)}')
echo " ${cpu}%"
