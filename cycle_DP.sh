#!/bin/bash

# cycle DP off/on
xrandr --output DP-2 --off
xrandr --output DP-2 --primary --auto --right-of eDP-1
feh --bg-fill /home/brett/Pictures/paradise_lake.jpg