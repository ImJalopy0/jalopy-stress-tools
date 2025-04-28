#!/bin/bash

clear
echo -e "\e[1;34m=========================="
echo -e "     JALOPY PINGER"
echo -e "==========================\e[0m"
echo ""

# Ask for target IP
read -p "Enter the target IP address: " target

echo ""
echo -e "\e[1;34mPinging $target every 0.1 seconds...\e[0m"
echo ""

# Main loop
while true
do
    ping_result=$(ping -c 1 -W 1 $target | grep 'time=')
    
    if [ -n "$ping_result" ]; then
        ping_time=$(echo $ping_result | sed -n 's/.*time=\(.*\) ms/\1/p')

        # Choose color based on ping time
        if (( $(echo "$ping_time < 100" | bc -l) )); then
            color="\e[1;32m" # Green
        elif (( $(echo "$ping_time < 200" | bc -l) )); then
            color="\e[1;33m" # Yellow
        else
            color="\e[1;31m" # Red
        fi

        echo -e "${color}[$(date +%T)] $target is ONLINE - Ping: ${ping_time} ms\e[0m"
    else
        echo -e "\e[1;31m[$(date +%T)] $target is OFFLINE\e[0m"
    fi

    sleep 0.1
done

