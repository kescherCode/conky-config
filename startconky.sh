#!/usr/bin/env bash
killall conky
conky -c "/home/kescher/.config/conky/leftside" &
conky -c "/home/kescher/.config/conky/rightside" &
