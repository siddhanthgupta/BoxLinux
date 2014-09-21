#!/bin/bash

source config.sh

#initializes the .cur file in a single directory, used for changed directories
#format: <FILE/DIR>:<filename>:<last modification timestamp>

cd "$1"

cat /dev/null > "$CURSTATE"

for something in *; do
	if [[ -d "$something" ]]; then
		echo -n "DIR:" >> "$CURSTATE"
		stat -c "%n:%Y" "$something" >> "$CURSTATE"
	fi
	if [[ -f "$something" ]]; then
		echo -n "FILE:" >> "$CURSTATE"
		stat -c "%n:%Y" "$something" >> "$CURSTATE"
	fi
done

cd - > /dev/null
