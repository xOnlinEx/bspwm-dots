#!/bin/bash
set -o pipefail

<<screensht

 _____ _____ _____ _____ _____ _____ _____ _____ _____
|   __|     | __  |   __|   __|   | |   __|  |  |_   _|
|__   |   --|    -|   __|   __| | | |__   |     | | |
|_____|_____|__|__|_____|_____|_|___|_____|__|__| |_|
Simple Script To Take Aesthetic Screenshots!
using maim, imagemagick, colord and AwesomeWM API

@author rxyhn
https://github.com/rxyhn

screensht

# =============================================

# Directory
_SCREENSHOT_DIR_=$HOME/Pictures/Screenshots
_ORIGINAL_DIR_=$_SCREENSHOT_DIR_/Original
_LOG_FILE_="$_SCREENSHOT_DIR_/.screensht.log"

# Color
_FG_COLOR_='#181616'
_BG_COLOR_='#8a9a7b'
_BG_SIZE_=10

# Border Size Applied when value greater than or equal 3
_BORDER_SIZE_=0
_SHADOW_SIZE_='100x30+0+16'  # [ weight ] x [ radius ] + [ horizontal ] x [ vertical ]
_ROUNDED_CORNER_=10

# Author Config
_AUTHOR_POST_=( 'South' '+0+15' )
_AUTHOR_NAME_=" xOnlinEx"
_AUTHOR_COLOR_='#0d0f18'

# Get Lists Font With "convert -list font | grep -iE 'font:.*' | nl"
_FONT_SIZE_=13
_FONT_='JetBrainsMono-NF-Regular'

# =============================================

function check() {
    if [[ $? -eq 1 && ${PIPESTATUS[0]} -eq 1 ]]; then
        _end_job_=$(date +%s)
        summary $_start_job_ $_end_job_ 'failed' && notify-send -u critical -t 3000 -a "Screenshot Tool" "Screensht!" "screenshot aborted" >> $_LOG_FILE_ 2>&1
        exit 1
    fi
}

# Check save directory
# Create it if it doesn't exist
function check_dir() {
	if [[ ! -d "$_SCREENSHOT_DIR_" || ! -d "$_ORIGINAL_DIR_" ]]; then
		mkdir -p "$_SCREENSHOT_DIR_"
    	mkdir -p "$_ORIGINAL_DIR_"
	fi
}

function get_latest_img() { 
    _LATEST_IMAGE_=$(/bin/ls -th $_SCREENSHOT_DIR_ | grep -vE '.screensht.png$' | grep -E '.png$' | head -n 1)

    if [[ $( echo "$_LATEST_IMAGE_" | wc -w ) -eq 0 ]]; then
        exit 1
    else
        _LATEST_IMAGE_="$_SCREENSHOT_DIR_/$_LATEST_IMAGE_"
    fi
}

function convert() {
    _target_file_=$( echo "$_LATEST_IMAGE_" | sed 's/.png/.screensht.png/g'  )

    if [[ $_BORDER_SIZE_ -ge 3 ]]; then
        magick convert "$_LATEST_IMAGE_" \
            -format 'roundrectangle 1,1 %[fx:w+4],%[fx:h+4] '"$_ROUNDED_CORNER_"','"$_ROUNDED_CORNER_"''\
            info: > $_SCREENSHOT_DIR_/_rounded_.mvg
        check

        magick convert "$_LATEST_IMAGE_" -border $_BORDER_SIZE_ -alpha transparent \
            -background none -fill white -stroke none -strokewidth 0 \
            -draw "@"$_SCREENSHOT_DIR_"/_rounded_.mvg" $_SCREENSHOT_DIR_/_rounded_mask_.png >> $_LOG_FILE_ 2>&1
        check

        magick convert "$_LATEST_IMAGE_" -border $_BORDER_SIZE_ -alpha transparent \
            -background none -fill none -stroke $_FG_COLOR_ -strokewidth $_BORDER_SIZE_ \
            -draw "@"$_SCREENSHOT_DIR_"/_rounded_.mvg" $_SCREENSHOT_DIR_/_rounded_overlay_.png >> $_LOG_FILE_ 2>&1
        check

        magick convert "$_LATEST_IMAGE_" -alpha set -bordercolor none -border $_BORDER_SIZE_  \
            $_SCREENSHOT_DIR_/_rounded_mask_.png -compose DstIn -composite \
            $_SCREENSHOT_DIR_/_rounded_overlay_.png -compose Over -composite \
            "$_target_file_" >> $_LOG_FILE_ 2>&1 && \
        rm -f $_SCREENSHOT_DIR_/_rounded_*
        check
    else
        magick convert "$_LATEST_IMAGE_" \( +clone  -alpha extract -draw 'fill black polygon 0,0 0,'"$_ROUNDED_CORNER_"' '"$_ROUNDED_CORNER_"',0 fill white circle '"$_ROUNDED_CORNER_"','"$_ROUNDED_CORNER_"' '"$_ROUNDED_CORNER_"',0' \
        \( +clone -flip \) -compose Multiply -composite \
        \( +clone -flop \) -compose Multiply -composite \
        \) -alpha off -compose CopyOpacity -composite -compose over "$_target_file_" >> $_LOG_FILE_ 2>&1
        check
    fi

    magick convert "$_target_file_" \( +clone -background black -shadow $_SHADOW_SIZE_ \) +swap -background none -layers merge +repage "$_target_file_" >> $_LOG_FILE_ 2>&1 \
    && magick convert "$_target_file_" -bordercolor $_BG_COLOR_ -border $_BG_SIZE_ "$_target_file_" >> $_LOG_FILE_ 2>&1
    check

    echo -en "  $_AUTHOR_NAME_  " | magick convert "$_target_file_" -gravity ${_AUTHOR_POST_[0]} -pointsize $_FONT_SIZE_ -fill $_AUTHOR_COLOR_ -undercolor none -font $_FONT_ -annotate ${_AUTHOR_POST_[1]} @- "$_target_file_" \
    >> $_LOG_FILE_ 2>&1 && magick convert "$_target_file_" -gravity South -chop 0x$(( $_BG_SIZE_ / 2 )) "$_target_file_" >> $_LOG_FILE_ 2>&1
    check

    magick convert "$_target_file_" -gravity North -background $_BG_COLOR_ -splice 0x$(( $_BG_SIZE_ / 2 )) "$_target_file_" >> $_LOG_FILE_ 2>&1
    check

    magick convert "$_target_file_" -profile /usr/share/color/icc/colord/sRGB.icc "$_target_file_" >> $_LOG_FILE_ 2>&1
    check
}

function summary() {
    _runtime_job_=$(($2-$1))
    hours=$((_runtime_job_ / 3600)); minutes=$(( (_runtime_job_ % 3600) / 60 )); seconds=$(( (_runtime_job_ % 3600) % 60 ))

    if [[ $3 != "failed" ]]; then
        xclip -selection clipboard -t image/png -i $_target_file_ >> $_LOG_FILE_ 2>&1
        dunstify -a "Screenshot" -i "$_target_file_" "Screenshot Saved:" "$_target_file_"

	       awesome-client "
	    -- IMPORTANT NOTE: THIS PART OF THE SCRIPT IS LUA!
	    naughty = require('naughty')
	    awful = require('awful')
	    beautiful = require('beautiful')
	    dpi = beautiful.xresources.apply_dpi

	    local open_image = naughty.action {
	    	name = 'Open',
	       	icon_only = false,
	    }

	    local delete_image = naughty.action {
	    	name = 'Delete',
	       	icon_only = false,
	    }

	    -- Execute the callback when 'Open' is pressed
	    open_image:connect_signal('invoked', function()
	    	awful.spawn('xdg-open ' .. '${_target_file_}', false)
	    end)

	    -- Execute the callback when 'Delete' is pressed
	    delete_image:connect_signal('invoked', function()
	    	awful.spawn('gio trash ' .. '${_target_file_}', false)
	    end)

	    -- Show notification
	    naughty.notification ({
	    	app_name = 'Screenshot Tool',
	    	icon = '${_target_file_}',
	    	timeout = 10,
	    	title = 'Screenshot Captured',
	    	message = '${_notif_message_}',
	    	actions = { open_image, delete_image }
	    })
	    "
    fi
}

function main() {
    check_dir

    rm -f $_LOG_FILE_
    _start_job_=$(date +%s)

	_screenshot_command_="$1"
	_notif_message_="$2"

    $_screenshot_command_ $_SCREENSHOT_DIR_\/$_start_job_.png> /dev/null 2>&1
    check

    get_latest_img
    convert

	mv $_LATEST_IMAGE_ $_ORIGINAL_DIR_
    
    _end_job_=$(date +%s)
    summary $_start_job_ $_end_job_
}

# Check the args passed
if [ -z "$1" ] || ([ "$1" != 'full' ] && [ "$1" != 'area' ]);
then
	echo "
	Requires an argument:
	area 	- Area screenshot
	full 	- Fullscreen screenshot

	Example:
	./screensht area
	./screensht full
	"
elif [ "$1" = 'full' ];
then
	msg="Full screenshot saved and copied to clipboard!"
	main 'maim -u -m 10' "${msg}"
elif [ "$1" = 'area' ];
then
	msg='Area screenshot saved and copied to clipboard!'
	main 'maim -u -m 10 -s -b 2' "${msg}"
fi
