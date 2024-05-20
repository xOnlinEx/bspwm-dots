#!/bin/bash

color=$(xcolor)
echo -n "$color" | tr -d '\n' | xclip -selection clipboard

# Envía una notificación a dunst con el color
dunstify "hex" "$color" -i "$HOME/Pictures/avatar-chiori.png"