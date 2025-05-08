#!/bin/bash

idle_time=0
check_interval=15 # in seconds
max_idle_time=300 # 5 minutes

while true; do
  player_count=$(mc-monitor status -host 127.0.0.1 | grep -oP '\d+/\d+' | cut -d/ -f1)
  
  if [[ "$player_count" == "0" ]]; then
    idle_time=$((idle_time + check_interval))
  else
    idle_time=0
  fi

  if [[ "$idle_time" -ge "$max_idle_time" ]]; then
    echo "Shutting down due to inactivity..."
    screen -S mc -p 0 -X stuff "stop$(printf \\r)"
    break
  fi

  sleep $check_interval
done
