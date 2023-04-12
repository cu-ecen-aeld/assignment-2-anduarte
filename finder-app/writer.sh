#!/bin/sh

writefile=$1
writestr=$2
failstatus=1
successstatus=0

# check if parameters are not empty
if [ -z $writefile ] || [ -z $writestr ]
then
	echo "Please provide directory path and text to search"
	exit $failstatus
else
	# create directory and respective parents directories if not exists
	# dirname strips last component from file name leaving only the file pathy
        # echo will override the file with given string
	# 2>/dev/null 
	#      '2>' - redirect standard error, to
	#      '/dev/null' - device that will discard anything that is redirected to it
	#                    That way errors that below command might throw will not be displayed 
	{ mkdir -p "$(dirname "$writefile")" && echo "${writestr}" > "${writefile}" ; } 2>/dev/null  
	
	# store the exit status of the most recently run process
	stdoutputstatus=$?

	# was not able to create the file
	if [ $stdoutputstatus -gt 0 ]
	then
		echo "File could not be created"
		exit $failstatus
	else
		exit $successstatus
	fi
fi
