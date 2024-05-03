#!/bin/bash


if [ "$#" -ne 3 ]; then
    echo "Usage: $0 classlist firstname"
    exit 1
fi


if [ ! -f "$1" ]; then
    echo "Error: classlist file not found."
    exit 1
fi


if grep -q "$2" "$1"; then
    echo "Warning: firstname already exists in the classlist."
else

    echo "$2" >> "$1"
fi