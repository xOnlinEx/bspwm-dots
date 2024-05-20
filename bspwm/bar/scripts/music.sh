#!/bin/sh

PLAYER="tauonmb"

if pidof "$PLAYER" >/dev/null 2>&1; then
    name_music=$(playerctl metadata --player="tauon" --format "{{ artist }} - {{ title }}")
    while IFS= read -r -n1 letra; do
        if [ "$letra" = " " ]; then
            echo " "
        else
            echo "$letra"
        fi
    done <<< "$name_music"
else
    echo "Offline"
    exit 1
fi
