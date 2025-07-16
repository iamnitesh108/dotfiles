#!/bin/bash
# copyq_status.sh

# Get the last clipboard item, truncated to 40 chars for example
copyq clipboard 0 --no-newline | cut -c1-40

