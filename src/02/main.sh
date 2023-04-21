#!/bin/bash

. ./materials.sh

# Написать bash-скрипт. Скрипт должен вывести на экран информацию.

info

read -p "Хотите записать данные в файл? [Y/N] " answer
if [[ $answer == "y" ]] || [[ $answer == "Y" ]];
    then info > ./$(date +"%d_%m_%y_%H_%M_%S").status
fi
