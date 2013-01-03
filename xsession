#! /bin/sh

echo Starting .xsession

set -x

# set up paths.
. ~/.profile

# Set correct screen size/dpi
xrandr --dpi 96 #--fbmm 408x306

# start ssh-agent and import its variables
eval `ssh-agent -s`

# set up proper koi8-r input with default messages/date/etc
#LANG=ru_RU.KOI8-R
#LC_CTYPE="ru_RU.KOI8-R"
#LC_COLLATE="ru_RU.KOI8-R"
#LC_TIME=C
#LC_NUMERIC=C
#LC_MONETARY=C
#LC_MESSAGES=C
#GDK_USE_XFT=0
LANG=en_US.UTF-8
export LANG

#xkbcomp $HOME/.xkbrc $DISPLAY
#xmodmap -e "pointer = 1 2 3 6 7 4 5" # Fix wheel/buttons on MX500
#xmodmap ~/.Xmodmap
# .. OR..
#setxkbmap -v 10 -model microsoft7000 -layout us,ru \
#     -variant ,winkeys \
#     -option "grp:alt_shift_toggle,terminate:ctrl_alt_bksp"
# # altwin:alt_super_win screws up Alt keys...
# # got to use xmodmap below to turn Menu key into Super_R which 
# # is part of mod4

xmodmap -e "keysym Menu = Super_R"

xset r rate 250 40
#xset -r 116 # Turn autorepeat for Alt_R. Don't remember why.
xset dpms 600 1200 1800
xset b off # we don't need no stinking bell
xrdb -merge $HOME/.Xresources
imwheel -p 
xsetroot -solid LightSkyBlue4 -cursor_name left_ptr
(cd /; xscreensaver&)
xbuffy -g +0-0 -poll 120 -header 0 -priority 0 &
pland&
# Load MS4K keyboard handlers, so at least F-lock works.
usbhidaction -f0 -p /dev/null -c /etc/hid-kbd-ms4k.conf &
#autocutsel -selection PRIMARY -fork&
wmCalClock -e plan&
#acroread -iconic&
(sleep 2; cd / ; exec ipager)&
WM=fluxbox
# I hate it when WM crashes and everything quits
while true; do
    # start stuff from / so processes don't hold on to NFS-mounted home curdir.
    cd /
    if [ -x $HOME/.wm ] ; then
	$HOME/.wm
    else
        $WM;
    fi 
    [ -f $HOME/.wm-noquit ] || exit 0
done
