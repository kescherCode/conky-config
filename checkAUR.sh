#!/usr/bin/env bash
UPDATES=`yay --aur -Qyu | wc -l`
if [[ $UPDATES -lt 1 ]]; then
    echo "\${color1}$UPDATES"
elif [[ $UPDATES -lt 5 ]]; then
    echo "\${color4}$UPDATES"
else
    echo "\${color2}$UPDATES"
fi
