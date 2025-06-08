#!/bin/sh
connected_display=$(xrandr | grep " connected" | grep -v "eDP-1" |  awk '{print $1}')
xrandr --output eDP-1 --off --output $connected_display --primary 
