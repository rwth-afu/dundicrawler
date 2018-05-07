#!/bin/bash
# Asterisk Info prefetch by Ralf Wilke DH3WR, based on Stefan Dambeck DC7DS

# Short-Description: async. prefetch info asterisk
# To lower system load lock mechanism to prevent cpu hogging script loops 
# using lock file im ramdisk
prefetchlock=/run/shm/asterisk-prefetch.lock

if [ -f "$prefetchlock" ] 
then
	echo "prefetch in progress. exiting!"
	echo "execute rm $prefetchlock in case of unexpected behaviour!"
	exit 0
else
	touch $prefetchlock

	# asterisk
	asterisk -r -x 'core show channels' >/run/shm/core_show_channels.info
	asterisk -r -x 'sip show peers' | /bin/grep -v UNKNOWN >/run/shm/sip_show_peers.info
	asterisk -r -x 'dundi show peers' >/run/shm/dundi_show_peers.info

	#remove lockfile to unblock future batchruns
	rm -f $prefetchlock
fi
