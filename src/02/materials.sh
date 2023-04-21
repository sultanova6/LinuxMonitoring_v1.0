#!/bin/bash

function info() {
    echo "HOSTNAME = $(hostname)"
    echo "TIMEZONE = $(timedatectl | grep "Time zone" | awk '{print $3}' | sed 's/0//; s/0//; s/0//') UTC" "$(timedatectl | grep "Time zone" | awk '{print $5}' | sed 's/0//; s/0//; s/0//' | grep -o '[+-][0-9]*')"
    echo "USER = $(whoami)"
    echo "OS = $(cat /etc/issue | cut -c1-18)"
    echo "DATE = $(date +"%d %b %Y %H:%M:%S")"
    echo "UPTIME = $(uptime -p)"
    echo "UPTIME_SEC = $(hostname -I)"
    echo "IP = $(ifconfig | grep -m1 "inet" | awk '{print $2}')"
    echo "MASK = $(ifconfig | grep -m1 "netmask" | awk '{print $4}')"
    echo "GATEWAY = $(ip r | grep -m1 "default" | awk '{print $3}')"
    echo "RAM_TOTAL = $(free -h | grep -m1 "Mem" | awk '{printf "%.3f GB", $2/1024}')"
    echo "RAM_USED = $(free -h | grep -m1 "Mem" | awk '{printf "%.3f GB", $3/1024}')"
    echo "RAM_FREE = $(free -h | grep -m1 "Mem" | awk '{printf "%.3f GB", $4/1024}')"
    echo "SPACE_ROOT = $(lsblk -r | grep "/$" | awk '{printf "%.2f MB", $4*1024}')"
    echo "SPACE_ROOT_USED = $(df | grep "/$" | awk '{printf "%.2f MB", $3/1024}')"
    echo "SPACE_ROOT_FREE = $(df | grep "/$" | awk '{printf "%.2f MB", $4/1024}')"
}