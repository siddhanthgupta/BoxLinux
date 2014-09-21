#!/bin/bash
#runs inotifywatch over the root directory

source config.sh

#run an instance of inotifywatch and parse it's output
notify(){
	inotifywatch -e modify,attrib,close_write,moved_from,moved_to,create,delete -r -t $CHECKINT $1 > toparse$$.txt || (echo 'Error while establishing daemon.' && exit 1)
	lockfile $JOBBUF.lock
	awk -f parser toparse$$.txt >> $JOBBUF
	rm -f $JOBBUF.lock
	rm toparse$$.txt
}


#main. Kepp running it indefinitely. use tokill.txt to kill the process.
echo $$ > tokill.txt
while true; do
	notify $ROOT
done
