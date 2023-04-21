#!/bin/bash

# Написать bash-скрипт. Скрипт запускается с одним параметром.
# Параметр - это абсолютный или относительный путь до какой-либо директории.
# Советую смотреть папку /materials
# https://ru.stackoverflow.com/questions/1042530/bash-%D0%B2%D1%80%D0%B5%D0%BC%D1%8F-%D0%B2%D1%8B%D0%BF%D0%BE%D0%BB%D0%BD%D0%B5%D0%BD%D0%B8%D0%B5-%D1%81%D0%BA%D1%80%D0%B8%D0%BF%D1%82%D0%B0-%D0%B2-%D0%BC%D0%B8%D0%BB%D0%B8%D1%81%D0%B5%D0%BA%D1%83%D0%BD%D0%B4%D0%B0%D1%85

# Total number of folders (including all nested ones)
ALL_DIR="$(ls -la $dir | grep ^d | wc -l)"

# TOP 5 folders of maximum size arranged in descending order (path and size)
TOP_FIVE() {
        for ((i = 2; i <= 6; i++))
    {
        TOP_FIVE=$(du $dir | sort -rnk1 | head -n 6 | awk "(NR==${i})")
        if ! [[ -z $TOP_FIVE ]]; then
            echo -n "$((${i}-1)) - "
            echo -n $(echo "${TOP_FIVE}" | awk '{print $2}')
            echo -n ", "
            echo -n $(echo "${TOP_FIVE}" | awk '{print $1}')
            echo "KB"
        fi
    }
}

# Total number of files
ALL_FILES="$(ls -laR $directory | grep "^-" | wc -l)"

# Число: Number of: 
# - конфигурационных файлов (с расширением .conf); Configuration files (with the .conf extension)
# - текстовых файлов; Text files
# - исполняемых файлов; Executable files
# - логов (файлов с расширением .log); Log files (with the extension .log)
# - архивов; Archive files
# - символических ссылок; Symbolic links
NUM_CONFIG="$(ls $dir | grep .conf | wc -l)"
NUM_TXT="$(ls $dir | grep -E "\.(text|txt)" | wc -l)"
NUM_ARCH="$(ls $dir | grep -E "\.(sh|exe)" | wc -l)"
NUM_LOG="$(ls $dir | grep .log | wc -l)"
NUM_ARCH2="$(ls $dir | grep -E ".\(rar|zip|tar|arj|gz|gzip|7z)" | wc -l)"
NUM_LINKS="$(ls -laR $dir | grep ^l | wc -l)"

# TOP 10 files of maximum size arranged in descending order (path, size and type)
TOP_10="$(find $1 -type f -exec du -h {} + | sort -hr | head -10 | awk '{print $2}')"
TOP_10_SIZE="$(find $1 -type f -exec du -h {} + | sort -hr | head -10 | awk '{print $1}')"
TOP_10_TYPE="$(find $1 -type f -exec du -h {} + | sort -hr | head -10 | awk -F'.' '{print $3}')"

TOP=($TOP_10)
SIZE=($TOP_10_SIZE)
TYPE=($TOP_10_TYPE)

TOP() {
    for (( i = 0; i < 10; i++ )); do
    printf "%d - " "$((i + 1))"
    printf "${TOP[$i]}, ${SIZE[$i]}, ${TYPE[$i]}\n"
    done
}

# TOP 10 executable files of the maximum size arranged in descending order (path, size and MD5 hash of file)
TOP_10_EXE="$(find $1 -name "*.sh" -o -name "*.exe")"
TOP_10_EXE_SIZE="$(du -h $1 | awk '{print $1}')"
HASH="$(md5sum -r $1 | awk '{print $1}')"

EXE=($TOP_10_EXE)
EXE_SIZE=($TOP_10_EXE_SIZE)
HASHSH=($HASH)

TOP_TOP() {
    for (( i = 0; i < 10; i++ )); do
    printf "%d - " "$((i + 1))"
    printf "${EXE[$i]}, ${EXE_SIZE[$i]}, ${HASHSH[$i]}\n"
    done
}

############################################################

START=$(date +%s)
dir=$1

if [[ $2 != '' ]] ;
then
    echo "Введите не более 1 аргумента."
    exit 1
fi

if [[ $dir == '' ]] ;
then
    dir='./'
elif ! [[ $dir == */ ]] ;
then
    echo "Ошибка ввода. Параметр должен заканчиваться знаком '/'."
    exit 1
fi

if ! [ -d $dir ] ;
then
    echo "Папки не существует."
    exit 1
fi

echo "Total number of folders (including all nested ones) = "$ALL_DIR
echo "TOP 5 folders of maximum size arranged in descending"
echo "order (path and size):"
TOP_FIVE $dir
echo "Total number of files = "$ALL_FILES
echo "Number of:"
echo "Configuration files (with the .conf extention) = "$NUM_CONFIG
echo "Text files = "$NUM_TXT
echo "Executable files = "$NUM_ARCH
echo "Log files (with the extention .log) = "$NUM_LOG
echo "Archive files = "$NUM_ARCH2
echo "Symbolic links = "$NUM_LINKS
echo "TOP 10 files of maximum size arranged in descending order"
echo "(path, size and type):"
TOP $dir
echo "TOP 10 executable files of the maximum size arranged in"
echo "descending order (path, size and MD5 hash of file):"
TOP_TOP $dir
echo "Script execution time (in seconds) = "$(($(date +%s)-$START))
