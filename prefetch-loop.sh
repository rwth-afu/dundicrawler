#!/bin/bash
# Endless loop to execute prefetch commands every 15 seconds

# set prefetch priority via nice
# prefetch should not impact other services
# -20=highst prio, 19=lowest
niceprio=19

# set script to be executed, has to be adapted
prefetch_skript=/usr/local/scripts/sip/asterisk-status.sh

while [ "true" ]
do
	nice -n $niceprio $prefetch_skript
        sleep 15
done
