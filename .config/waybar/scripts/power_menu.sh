#!/bin/bash

choice=$(printf "Lock\nSuspend\nHibernate\nReboot\nShutdown\nCancel" | wofi --dmenu --width 250 --height 250 --prompt "Power Menu")

case "$choice" in
  Lock)
    swaylock -f -c 000000  # or replace with your lock command (see below)
    ;;
  Suspend)
    systemctl suspend
    ;;
  Hibernate)
    systemctl hibernate
    ;;
  Reboot)
    systemctl reboot
    ;;
  Shutdown)
    systemctl poweroff
    ;;
  *)
    exit 0
    ;;
esac

