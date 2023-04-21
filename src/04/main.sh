#!/bin/bash

. ./materials.sh

# Написать bash-скрипт. Скрипт должен вывести на экран информацию.
# https://sysadmins.ru/topic105410.html

source ./config.conf

while read number; do
    arr[$i]="$(echo $number | sed 's|.*=||')"
    i=$(($i+1))
done < ./colors.conf

for i in ${!arr[@]}; do
    if ! [[ ${arr[$i]} == [0-6] ]] && ! [[ ${arr[$i]} == "" ]]; then
        echo "Параметр должен быть числом от 1 до 6."
        exit
    fi
done

if ([[ ${arr[0]} == ${arr[1]} ]] && ! [[ ${arr[0]} == "" ]]) || \
    ([[ ${arr[2]} == ${arr[3]} ]] && ! [[ ${arr[0]} == "" ]]) || \
    ([[ ${arr[0]} == "" ]] && [[ ${arr[1]} == "6" ]]) || \
    ([[ ${arr[2]} == "" ]] && [[ ${arr[3]} == "6" ]]) || \
    ([[ ${arr[1]} == "" ]] && [[ ${arr[0]} == "1" ]]) || \
    ([[ ${arr[3]} == "" ]] && [[ ${arr[1]} == "1" ]]); 
then
    echo "Цвета текста и фона не должны совпадать."
    exit
fi

off="\033[0m"
bg1=$(bg "${arr[0]}")
font1=$(font "${arr[1]}")
bg2=$(bg "${arr[2]}")
font2=$(font "${arr[3]}")

echo -e "${bg1}${font1}HOSTNAME${off} = ${bg2}${font2}${HOSTNAME}${off}"
echo -e "${bg1}${font1}TIMEZONE${off} = ${bg2}${font2}${TIMEZONE}${off}"
echo -e "${bg1}${font1}USER${off} = ${bg2}${font2}${USER}${off}"
echo -e "${bg1}${font1}OS${off} = ${bg2}${font2}${OS}${off}"
echo -e "${bg1}${font1}DATE${off} = ${bg2}${font2}${DATE}${off}"
echo -e "${bg1}${font1}UPTIME${off} = ${bg2}${font2}${UPTIME}${off}"
echo -e "${bg1}${font1}UPTIME_SEC${off} = ${bg2}${font2}${UPTIME_SEC}${off}"
echo -e "${bg1}${font1}IP${off} = ${bg2}${font2}${IP}${off}"
echo -e "${bg1}${font1}MASK${off} = ${bg2}${font2}${MASK}${off}"
echo -e "${bg1}${font1}GATEWAY${off} = ${bg2}${font2}${GATEWAY}${off}"
echo -e "${bg1}${font1}RAM_TOTAL${off} = ${bg2}${font2}${RAM_TOTAL}${off}"
echo -e "${bg1}${font1}RAM_USED${off} = ${bg2}${font2}${RAM_USED}${off}"
echo -e "${bg1}${font1}RAM_FREE${off} = ${bg2}${font2}${RAM_FREE}${off}"
echo -e "${bg1}${font1}SPACE_ROOT${off} = ${bg2}${font2}${SPACE_ROOT}${off}"
echo -e "${bg1}${font1}SPACE_ROOT_USED${off} = ${bg2}${font2}${SPACE_ROOT_USED}${off}"
echo -e "${bg1}${font1}SPACE_ROOT_FREE${off} = ${bg2}${font2}${SPACE_ROOT_FREE}${off}"
echo

if ([[ ${arr[0]} -eq 6 ]] && \
[[ ${arr[1]} -eq 1 ]] && \
[[ ${arr[2]} -eq 2 ]] && \
[[ ${arr[3]} -eq 4 ]])
then
    echo "Column 1 background = default (black)"
    echo "Column 1 font color = default (white)"
    echo "Column 2 background = default (red)"
    echo "Column 2 font color = default (blue)"
else
    echo "Column 1 background = $(color "${arr[0]}" "bg")"
    echo "Column 1 font color = $(color "${arr[1]}" "text")"
    echo "Column 2 background = $(color "${arr[2]}" "bg")"
    echo "Column 2 font color = $(color "${arr[3]}" "text")"
fi
