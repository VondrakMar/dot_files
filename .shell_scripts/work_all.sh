connected_display=$(xrandr | grep " connected" | grep -v "eDP-1" |  grep DP | awk '{print $1}')
xrandr --output HDMI-1 --left-of $connected_display --output $connected_display --primary --mode 2560x1440 
