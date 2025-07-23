#!/bin/bash

# 1. Get the full clipboard content and convert newlines to spaces.
#    We do NOT truncate it yet.
CLIP_FULL_CONTENT=$(wl-paste --no-newline 2>/dev/null | tr '\n' ' ')

# 2. Trim leading spaces or tabs from the full content.
#    This ensures that the 25-character limit will count actual content, not leading whitespace.
CLIP_TRIMMED_LEADING=$(echo "${CLIP_FULL_CONTENT}" | sed -E 's/^[[:space:]]+//')

# 3. Now, take the first 25 characters of the content that has already had its leading spaces/tabs removed.
CLIP_PREVIEW=$(echo "${CLIP_TRIMMED_LEADING}" | head -c 25)


# Check if the final preview content is empty (e.g., if clipboard was all spaces, or genuinely empty)
if [[ -z "$CLIP_PREVIEW" ]]; then
  echo "  empty"
else
  echo "  $CLIP_PREVIEW"
fi
