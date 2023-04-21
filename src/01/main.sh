#!/bin/bash

# Написать bash-скрипт. Скрипт запускается с одним параметром. Параметр текстовый.
# Скрипт выводит значение параметра.
# Если параметр - число, то должно выводится сообщение о некорректности ввода.

not_a_number="^[+-]?[0-9]+([.][0-9]+)?$"

if [[ $1 =~ $not_a_number ]];
then
    echo "Incorrect stdin"
    exit
else
    echo $1
    exit
fi