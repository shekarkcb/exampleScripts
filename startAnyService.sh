#!/bin/bash
# Script to start any process/service.
# Tries to find the process running using pgrep command.
# Dependency :  pgrep, date, whoami, basename and nohup
# Replace 'pn' variable with your process Name
# Exit codes  - 0 - Success full starting
#               1 - Process/Service already running
#               2 - Tried starting it, but somehow its failing.
# Variables to Adjust:
#       pn  - put your processName / Service Name
#       outPutOftheProcess - This is where log files are written. I mean after the process/service started. 
#                            Its put in /tmp/, but you can replace with whatever the path you need.
# By: @shekarkcb

# LogFile 
outPutOftheProcess="/tmp/outPutOftheProcess.log"
# Date with time for the log files
dt="date +%c"
# Program used to grep process names
pg='pgrep'
# Replace this with your process Name
pn='sampleProcessName'
c=$($pg -c  $pn )
# Just to know who is running this process
u='whoami'
# This script name, removing trailig path as neat for logs
bn=$(basename $0)

#Function to print lines, no need to write echo multiple times :)
function showMSG {
    echo "$($dt) | $bn | $($u) | $1"
}

if [[ $c != 0 ]];
then
    showMSG "ERROR: You are trying to start $pn , but its already running !!!"
    pids=$($pg $pn | xargs)
    showMSG " $pn PIDs ($c) are - $pids"
    exit 1
fi
showMSG "Starting $pn..."

# Starting process , redirect everything to outPutOftheProcess variable (logfile).
nohup $pn >> $outPutOftheProcess 2>&1 &
c=$($pg -c  $pn )
if [[ $c != 0 ]];
then
    pids=$($pg $pn | xargs)
    showMSG "Success : $pn Started, PID's ($c) are - $pids"
    exit 0
else
    showMSG "ERROR :  Unable to start $pn, check the $outPutOftheProcess log file may be?"
    exit 2
fi
