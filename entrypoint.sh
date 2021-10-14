#!/bin/bash

# this is based on https://github.com/jkuri/alpine-xfce4
nohup /usr/bin/Xvfb ${DISPLAY} -screen 0 $RESOLUTION -ac +extension GLX +render -noreset > /dev/null 2>&1 &
nohup lightdm > /dev/null 2>&1 &
nohup x11vnc -xkb -noxrecord -noxfixes -noxdamage -display ${DISPLAY} -forever -bg -rfbauth /home/${USER}/.vnc/passwd -users ${USER} -rfbport 5900 > /dev/null 2>&1 &
/bin/zsh
