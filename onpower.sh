#!/usr/bin/env bash
sed -i 's/update_interval = 2/update_interval = 0.5/' "$HOME/.config/conky/leftside"
sed -i 's/update_interval = 2/update_interval = 0.5/' "$HOME/.config/conky/rightside"
