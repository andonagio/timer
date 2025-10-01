#!/bin/bash

# Basic timer. Time and title are specified on the command line.
# Timer runs in the background once started. Upon completion,
# it shows a confirmation screen and plays a sound. Time is specified
# using the same syntax as the Linux date command.

main() {
	local title="$1"
	local timer="$2"

	# Gets the amount of time in seconds by finding the
	# difference between now and now + time specified
	# in Unix Epoch time.
	local amountOfTime=$(($(date -d "$2" +%s) - $(date +%s)))

	# Run the timer
	sleep "$amountOfTime"
	
	# The sound file is in the same directory as this script
	# The dirname and readlink commands give us the absolute
	# path to that file. We use -really-quiet and pipe any
	# remaining output to /dev/null so that nothing shows in the
	# terminal when the sound plays. We also send this command to
	# the background so that the dialog box appears while the sound plays.
	mplayer -really-quiet -loop 0 "$(dirname "$(readlink -f "$0")")/oxygen.wav" &> /dev/null &

	# "Time's Up" dialog box
	yad --title "TIME'S UP" \
		--text "Time's up for timer $1" \
		--text-align center \
		--buttons-layout=center \
		--button=OK:255

	# Kill the music when the dialog box closes
	pkill mplayer
}

title="$1"
timer="$2"

# Error checking the inputs
if [ -z "$title" ]; then
	echo "ERROR: Please specify a title for your timer."
	exit 1
elif [ -z "$timer" ]; then
	echo "ERROR: Please specify an amount of time."
	exit 1
elif [[ ! $(date -d "$timer" 2> /dev/null) ]]; then
	echo "ERROR: Please enter a valid amount of time."
	exit 1
fi

# Put the timer in the background once it starts
main "$title" "$timer" &
echo "Timer \"$title\" set for $timer"