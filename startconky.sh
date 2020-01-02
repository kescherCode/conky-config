#!/usr/bin/env bash
killall conky
conky -c "$HOME/.config/conky/leftside.conf" &
conky -c "$HOME/.config/conky/rightside.conf" &
