#!/bin/bash

source config.sh

#initializes the .prev file in a single directory, used for new directories
#format: <FILE/DIR>:<filename>:<last modification timestamp>

initcache(){
	cd "$1"

	cat /dev/null > "$PREVSTATE"

	for something in *; do
		if [[ -d "$something" ]]; then
			echo -n "DIR:" >> "$PREVSTATE"
			stat -c "%n:%Y" "$something" >> "$PREVSTATE"
		fi
		if [[ -f "$something" ]]; then
			echo -n "FILE:" >> "$PREVSTATE"
			stat -c "%n:%Y" "$something" >> "$PREVSTATE"
		fi
	done
	
	cd - > /dev/null
}

initcache $1
