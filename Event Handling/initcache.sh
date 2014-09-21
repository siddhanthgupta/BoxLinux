#!/bin/bash
#given a directory name lists all its contents along with their last modification date. Used for building initial state files only

source config.sh

buildcache(){
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
	
	for what in *; do
		#recurse on directories only
		if [[ -d "$what" ]]; then
			(buildcache "$what")	#don't remove brackets
		fi
	done
	
	cd - > /dev/null
}

buildcache "$1"
