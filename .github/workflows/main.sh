# Get the current program name
PROGRAM=`basename $0`

# Check to see if the user specified a command-line option
if [ "$1" != "" ]
then
        # The user called the script correctly, so we can do work
        TARGETFILE=$1
        REPORTDIR="/var/log/nmap"
        for TARGET in $(cat $TARGETFILE)
        do

                echo "Scanning $TARGET ..."
                /usr/bin/nmap -oN $REPORTDIR/$TARGET.nmap -sS -sU -T4 -A -v -PE -PP -PS80,443 -PA3389 -PU40125 -PY -g 53 --script "default or (discovery and safe)" $TARGET >> $REPORTDIR/$TARGET.nmap 2>$1

        done
else
        # The user didn't specify any command line options, so let's
        # give them instructions
        echo
        echo "Usage:  $PROGRAM [file]"
        echo
        echo "The program will read from a list of attack nodes and output a text report"
        echo "for each node."
        echo
        echo "You must specify a file containing attack node IP addresses.  Each address"
        echo "must be on its own line"
        echo
fi
