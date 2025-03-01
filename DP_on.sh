#!/bin/bash
# For Apple external monitor
# xrandr --output DP-2 --primary --auto --right-of eDP-1
# feh --bg-fill /home/brett/Pictures/paradise_lake.jpg


# For Dell external monitor
# xrandr --output eDP-1 --primary --auto --left-of DP-2
# xrandr --output DP-2 --mode 3840x2160 --scale 0.7x0.7 --rate 60 --output eDP-1 --primary --auto --left-of DP-2
if xrandr | grep "DP-2 connected"; then
	xrandr --output DP-2 --mode 3840x2160 --scale 0.7x0.7 --rate 60 --output eDP-1 --primary --auto --left-of DP-2
	feh --bg-fill /home/brett/Pictures/paradise_lake.jpg
fi