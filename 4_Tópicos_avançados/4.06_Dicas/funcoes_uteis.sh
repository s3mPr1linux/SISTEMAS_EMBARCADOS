#! /bin/bash

function weather()
{
    curl -s "wttr.in/$1?m1"
}

function up()
{
    if [ "$#" = "0" ] ; then
        cd ..
    else
        times=$1
        while [ "$times" -gt "0" ]; do
            cd ..
            times=$(($times - 1))
        done
    fi
}

function count_lines()
{
    N=$(wc -l < $1)
    N=$((N+1))
    echo $N
}

function mkcd()
{
    mkdir $1
    cd $1
}

alias lsla='ls -la'

function extract ()
{
    if [ -f $1 ] ; then
        case $1 in
          *.tar.bz2)   tar xvjf $1    ;;
          *.tar.gz)    tar xvzf $1    ;;
          *.tar.xz)    tar Jxvf $1    ;;
          *.bz2)       bunzip2 $1     ;;
          *.rar)       rar x $1       ;;
          *.gz)        gunzip $1      ;;
          *.tar)       tar xvf $1     ;;
          *.tbz2)      tar xvjf $1    ;;
          *.tgz)       tar xvzf $1    ;;
          *.zip)       unzip -d `echo $1 | sed 's/\(.*\)\.zip/\1/'` $1;;
          *.Z)         uncompress $1  ;;
          *.7z)        7z x $1        ;;
          *)           echo "don't know how to extract '$1'" ;;
    esac
    else
        echo "'$1' is not a valid file!"
    fi
}

function find_rpi()
{
    arp -na | grep "b8:27"
    arp -na | grep "b827"
}

function search_between_strings()
{
    grep -oP '(?<='$1').*?(?='$2')' $3
}

function search_history()
{
    history | grep search_history -v | grep $1 
}

function search_ps()
{
    ps aux | head -1
    ps aux | grep grep -v | grep "ps aux" -v | grep $1
}

function disk_usage()
{
    df -h | head -1
    df -h | grep /$
}

function folder_size()
{
    if [ "$#" -ne "0" ]; then
        du -h $1 | tail -1
    else
        du -h .  | tail -1
    fi
}

function folders_size()
{
    if [ "$#" -ne "0" ]; then
        CUR_FOLDER=$1
    else
        CUR_FOLDER="."
    fi
    for f in ${CUR_FOLDER}/*/
    do
        folder_size $f
    done
}

function pinout()
{
    gpio readall
}

function i2cfind()
{
    i2cdetect -y 1
}

function check_internet_connection()
{
    echo "ping www.google.com"
    ping www.google.com
}

function testa_desempenho_SO()
{
    arq="output_os_test.txt"
    sudo cyclictest -l100000 -m -S -p90 -i200 -h400 -q > $arq
    tail -8 $arq
    rm $arq
}
