#!/bin/bash

clear

# Header style
RED='\033[1;31m'
NC='\033[0m' # No Color

# Fancy title
echo -e "${RED}=============================================="
echo -e "         JALOPY PINGER vFINAL MONITOR        "
echo -e "==============================================${NC}"

read -p "Enter the IP address or hostname to ping: " TARGET

echo ""
echo "Pinging $TARGET every 0.1 seconds..."
echo "Press CTRL+C to stop."
echo "----------------------------------------------"
sleep 1

while true; do
    PING_OUTPUT=$(ping -c 1 -W 1 $TARGET 2>&1)

    if echo "$PING_OUTPUT" | grep -q "time="; then
        LATENCY=$(echo "$PING_OUTPUT" | grep "time=" | sed -E 's/.*time=([0-9.]+) ms.*/\1/')
        MS_INT=${LATENCY%.*}  # Get integer part

        # Determine color based on latency
        if [ "$MS_INT" -lt 60 ]; then
            COLOR='\033[1;32m' # Green
        elif [ "$MS_INT" -lt 150 ]; then
            COLOR='\033[1;33m' # Yellow
        else
            COLOR='\033[1;31m' # Red
        fi

        # Generate bar
        NUM_BARS=$(awk -v lat=$LATENCY 'BEGIN { printf("%d", lat / 3) }')
        BAR=$(printf "%${NUM_BARS}s" | tr ' ' '■')

        echo -e "${COLOR}[$(date +"%H:%M:%S")] $TARGET is ONLINE (${LATENCY} ms) |$BAR${NC}"
    else
        echo -e "\033[1;31m[$(date +"%H:%M:%S")] $TARGET is OFFLINE                  |X${NC}"
    fi

    sleep 0.1
done

