#!/bin/bash

. ./materials.sh

# Написать bash-скрипт. Скрипт должен вывести на экран информацию.
# https://mb4.ru/programming/bash/853-colors-for-bash.html
# https://itisgood.ru/2019/11/26/dobavlenie-cvetov-v-skripty-bash/

if [[ $1 -eq $2 ]] || [[ $3 -eq $4 ]]
then
    echo "Цвет текста и фона не должны совпадать!"
    exit
fi

if [[ "$#" -ne 4  ]]
then
    echo "Введите 4 параметра."
    exit
fi

for number in "$@"
do
    if ! [[ $number == [1-6] ]] ; then
        echo "Параметры должен быть от 1 до 6."
        exit
    fi
done

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
