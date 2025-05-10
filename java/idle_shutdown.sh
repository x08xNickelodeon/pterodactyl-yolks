#!/bin/bash

# Total time to monitor (5 minutes = 300 seconds)
TOTAL_DURATION=300
# Check interval (in seconds)
INTERVAL=10
# Counter
ELAPSED=0

# Log file location or use console command
SERVER_LOG="logs/latest.log"

echo "[IdleCheck] Monitoring player activity for $TOTAL_DURATION seconds..."

while [ $ELAPSED -lt $TOTAL_DURATION ]; do
    # Send 'list' command to Minecraft console
    # Replace this depending on how input is sent to the console
    screen -S minecraft -p 0 -X stuff "list\n"

    sleep 1

    # Extract player count from the latest.log file
    PLAYER_COUNT=$(grep -a "There are" "$SERVER_LOG" | tail -n 1 | grep -oP '(?<=There are )\d+')

    if [ -z "$PLAYER_COUNT" ]; then
        echo "[IdleCheck] Could not detect player count, retrying..."
        PLAYER_COUNT=1  # Assume active players to prevent false shutdown
    fi

    echo "[IdleCheck] Players online: $PLAYER_COUNT"

    if [ "$PLAYER_COUNT" -gt 0 ]; then
        echo "[IdleCheck] Players detected. Exiting idle shutdown check."
        exit 0
    fi

    sleep $INTERVAL
    ELAPSED=$((ELAPSED + INTERVAL))
done

# If reached here, 5 minutes passed with 0 players
echo "[IdleCheck] No players for 5 minutes. Shutting down server."
screen -S minecraft -p 0 -X stuff "say Server shutting down due to inactivity...\n"
sleep 2
screen -S minecraft -p 0 -X stuff "stop\n"
