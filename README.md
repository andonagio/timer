# Bash Timer

This is a simple command-line Bash timer that I created for personal use:

`./timer.sh "title" "amount of time"`

where "title" is the title of the timer and "amount of time" is the length of time specified as a human-readable date string that is accepted by the Linux `date` command (ex. `10 seconds`, `5 minutes`, etc.). The timer runs in the background once started. Upon completion, it shows a "TIME'S UP" screen and plays a sound.

This script requires [mplayer](http://www.mplayerhq.hu/design7/news.html) and [yad](https://github.com/v1cont/yad) to run.
