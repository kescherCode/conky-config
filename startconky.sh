#!/usr/bin/env bash
killall conky
conky -c "~/.config/conky/leftside.conf" &
conky -c "~/.config/conky/rightside.conf" &
