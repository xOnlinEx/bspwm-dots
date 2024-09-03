#!/bin/bash

# Terminate already running bar instances
killall -q polybar

# Launch Polybar
polybar -c "$HOME"/.config/bspwm/polybar/config.ini &

echo "Polybar launched..."