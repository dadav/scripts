#!/bin/bash

i3status -c "$HOME/.config/i3status/config" | while :
do
    read -r line
    meminfo=$(grep ^Dirty /proc/meminfo | tr -s " ")
    meminfo="[{\"name\":\"\",\"markup\":\"none\",\"full_text\":\" $meminfo\"},{"
    echo -e "${line/[{/${meminfo}}" || exit 1
done
