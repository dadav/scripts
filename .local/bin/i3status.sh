#!/bin/bash

i3status -c "$HOME/.config/i3status/config" | while :
do
    read -r line
    # Meminfo
    meminfo=$(grep ^Dirty /proc/meminfo | tr -s " ")
    meminfo="[{\"name\":\"\",\"markup\":\"none\",\"full_text\":\" $meminfo\"}"
    # Xautolock
    lockpid=$(pgrep xautolock)
    lockmessage="Unknown"
    lockicon="" # questionmark
    if [[ -n "$lockpid" ]]; then
      lockstatus="$(ps -o state= -p "$lockpid")"
      if [[ "$lockstatus" = T ]]; then
        lockmessage="Paused"
        lockicon="" # unlock
      elif [[ "$lockstatus" = S ]]; then
        lockmessage="Running"
        lockicon=""
      fi
    fi
    autolock="{\"name\":\"\",\"markup\":\"none\",\"full_text\":\"$lockicon $lockmessage\"},{"
    echo -e "${line/[{/${meminfo},${autolock}}" || exit 1
done
