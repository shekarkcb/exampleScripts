#!/bin/bash
# Script to stop any process/service.
# Tries to find the process running using pgrep command.
# Dependency :  pgrep, date, whoami, basename, xargs, pkill
# Replace 'pn' variable with your process Name
# Exit codes  - 0 - Success full stopping
#               1 - Process/Service not running, nothing to stop
#               2 - Tried stopping it, but somehow its failing.
# Variables to Adjust:
#       pn  - put your processName / Service Name
#       outPutOftheProcess - This is where log files are written. I mean after the process/service stopped. 
#                            Its put in /tmp/, but you can replace with whatever the path you need.
# By: @shekarkcb

# LogFile 
outPutOftheProcess="/tmp/outPutOftheProcess.log"
# Date with time for the log files
dt="date +%c"
# Program used to grep process names
pg="pgrep"
# Replace this with your process Name
pn="sampleProcessName"
# Just to know who is running this process
u="whoami"
# This script name, removing trailig path as neat for logs
b=$(basename $0)

#Function to print lines, no need to write echo multiple times :)
function showMSG {
    echo "$($dt) | $b | $($u) | $1"
}
c=$($pg -c $pn)
if [[ $c == 0 ]];
then
    showMSG "ERROR: Nothing to stop, $pn is not running (OR i couldn't find it using pgrep :( ) !!!"
	exit 1

else
    p_n=$($pg $pn | xargs)
    showMSG "Stoping $pn , PID's ($c) - $p_n ...."
    pkill $pn
    sleep 1
    c=$($pg -c $pn)
    if [[ $c == 0 ]];
    then
        showMSG "Successfuly Stopped |$pn|...!"
		exit 0
    else
        showMSG "ERROR : Unable to stop |$pn|..., Try manuall kill...!"
		exit 2
    fi
fi
