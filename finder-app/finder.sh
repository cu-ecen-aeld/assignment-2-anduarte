#!/bin/sh

filesdir=$1
searchstr=$2
failstatus=1
successvalue=0

# check if parameters are not empty
if [ -z "$filesdir" ] || [ -z "$searchstr" ]
then
	echo "Arguments list is invalid. It is expected a directory path and text to search."
	exit $failstatus
else
	# check if 'filesdir' exist and if it is a directory
	if [ -d "$filesdir" ]
	then
		# [ ls -p ] Append / to files that are directories
		# [ grep -v / ] returns lines not containing /
		# [ wc -l ] print the newline count	
		numberoffiles=$( ls -p "${filesdir}" | grep -v / | wc -l )
	
		# [ grep -rI ]
		#    '-r' - Recursively read files under each directoy.
		#    '-I' - Skip binary files. That way when 'wc -l' is call it will not count 
		#           the lines with 'Binary file ---- matches.
		# [ wc -l ] print the newline counts	
		matchinglines=$( grep -rI "${searchstr}" "${filesdir}" | wc -l )
		
		echo "The number of files are ${numberoffiles} and the number of matching lines are ${matchinglines}"
		exit $successvalue
	else
		echo "\'${filesdir}\' does not represent a directory on system"
		exit $failstatus
	fi
fi
