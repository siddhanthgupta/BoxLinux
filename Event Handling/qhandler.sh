#!/bin/bash
#Handle the queue, for every changed directory, fire off a difference finder

source config.sh

#run indefinitely
while true; do
	#lock the file so notifier doesn't add to it now.
	lockfile $JOBBUF.lock
	cat $JOBQUEUE $JOBBUF > tmp && mv tmp $JOBQUEUE
	cat /dev/null > $JOBBUF #clear the queue
	rm -f $JOBBUF.lock #remove lock
	
	#for each line in the job queue fire off a difference finding script
	while read line; do
		./dirstat.sh "$line"	#generate cur state
		echo "$line$CURSTATE" "$line$PREVSTATE"
		./folderdiff.py "$line" "$line$CURSTATE" "$line$PREVSTATE" "$ACTIONFILE"
		mv "$line$CURSTATE" "$line$PREVSTATE"	#prev state changes to cur state
	done < $JOBQUEUE
	
	cat /dev/null > $JOBQUEUE #clear the queue
	
	sleep $INTERVAL	#sleep now. 
done
