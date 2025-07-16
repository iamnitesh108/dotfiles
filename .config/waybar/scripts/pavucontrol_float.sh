#!/bin/bash

# Launch pavucontrol in floating mode via swaymsg
swaymsg 'exec [app_id="pavucontrol"] floating enable, exec pavucontrol'

