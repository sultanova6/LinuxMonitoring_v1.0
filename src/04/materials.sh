#!/bin/bash

HOSTNAME="$(hostname)"
TIMEZONE="$(timedatectl | grep "Time zone" | awk '{print $3}' | \
sed 's/0//; s/0//; s/0//') UTC $(timedatectl | grep "Time zone" | \
awk '{print $5}' | sed 's/0//; s/0//; s/0//' | grep -o '[+-][0-9]*')"
USER="$(whoami)"
OS="$(cat /etc/issue | cut -c1-18)"
DATE="$(date +"%d %b %Y %H:%M:%S")"
UPTIME="$(uptime -p)"
UPTIME_SEC="$(hostname -I)"
IP="$(ifconfig | grep -m1 "inet" | awk '{print $2}')"
MASK="$(ifconfig | grep -m1 "netmask" | awk '{print $4}')"
GATEWAY="$(ip r | grep -m1 "default" | awk '{print $3}')"
RAM_TOTAL="$(free -h | grep -m1 "Mem" | awk '{printf "%.3f GB", $2/1024}')"
RAM_USED="$(free -h | grep -m1 "Mem" | awk '{printf "%.3f GB", $3/1024}')"
RAM_FREE="$(free -h | grep -m1 "Mem" | awk '{printf "%.3f GB", $4/1024}')"
SPACE_ROOT="$(lsblk -r | grep "/$" | awk '{printf "%.2f MB", $4*1024}')"
SPACE_ROOT_USED="$(df | grep "/$" | awk '{printf "%.2f MB", $3/1024}')"
SPACE_ROOT_FREE="$(df | grep "/$" | awk '{printf "%.2f MB", $4/1024}')"

# функция для цвета шрифта
font() {
    case ${1} in
        1) echo "\033[37m";;
        2) echo "\033[31m";;
        3) echo "\033[32m";;
        4) echo "\033[34m";;
        5) echo "\033[35m";;
        6) echo "\033[30m";;
        esac
}

# функция для цвета фона
bg() {
    case ${1} in
        1) echo "\033[47m";;
        2) echo "\033[41m";;
        3) echo "\033[42m";;
        4) echo "\033[44m";;
        5) echo "\033[45m";;
        6) echo "\033[40m";;
    esac
}

color() {
    case ${1} in
        1) echo "1 (white)";;
        2) echo "2 (red)";;
        3) echo "3 (green)";;
        4) echo "4 (blue)";;
        5) echo "5 (purple)";;
        6) echo "6 (black)";;
        "")
            if [[ $2 == "bg" ]]; then
                echo "default (black)"
            else
                echo "default (white)"
            fi
    esac
}