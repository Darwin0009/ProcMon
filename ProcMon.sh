#!/bin/bash

function ctrl_c() {
    echo -e "\n\n[!] Saliendo...\n"
    tput cnorm
    exit 1
}

# Ctrl+c
trap ctrl_c INT

tput civis

old_process="$(ps -eo command)"

while true; do
    new_process="$(ps -eo command)"

    # Use diff to compare old and new process lists, and filter out common system processes
    diff <(echo "$old_process") <(echo "$new_process") | grep -vE "procmon|command|kworker"

    old_process="$new_process"

    sleep 1  # Adjust the interval (in seconds) for checking process changes
done
