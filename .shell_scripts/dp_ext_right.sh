#!/bin/sh
connected_display=$(xrandr | grep " connected" | grep -v "eDP-1" |  awk '{print $1}')
xrandr --output eDP-1 --output $connected_display --primary --right-of eDP-1 
