xrandr --auto
connected_display=$(xrandr | grep " connected" | grep -v "eDP-1" |  grep DP | awk '{print $1}')
xrandr --output eDP-1 --output HDMI-1 --left-of $connected_display --output $connected_display --primary --mode 3440x1440 --right-of eDP-1
