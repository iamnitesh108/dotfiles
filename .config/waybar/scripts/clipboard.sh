#!/bin/bash

CLIP=$(wl-paste --no-newline 2>/dev/null | tr '\n' ' ' | head -c 50)
if [[ -z "$CLIP" ]]; then
  echo "📋 empty"
else
  echo "📋 $CLIP"
fi

