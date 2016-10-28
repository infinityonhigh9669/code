#!/bin/bash
#**********************************************************
#       Copyright (c) 2016 T-Bone
#                          All rights reserved.
#**********************************************************
trap '' SIGUSR1 SIGINT SIGHUP SIGQUIT SIGTERM SIGSTOP
PROGRAMNAME=${0##*/}
VERSION=1.1

titlec_i='\033[036;1m'
titlec_s='\033[033;1m'
color_e='\033[0m'
textc_s='\033[031;1m'
textc_e='\033[0m'

ServInfo()
{
	echo -e ""$titlec_i"`uptime`"$color_e""
	echo -e ""$titlec_s">>> - - - Server information - - - <<<"$color_e""

		if [ `which date` ];then
			echo -e ""$textc_s"  systemTime :"$color_e" `date`"
		fi

	echo -e ""$textc_s"  hostname   :"$color_e" `hostname`          "$textc_s"kernel ver       :"$color_e" `uname -r`"
	echo -e ""$textc_s"  domainname :"$color_e" `domainname`"

		if [ ! -s /etc/resolv.conf ];then
			echo -e ""$textc_s"  resolve.conf     :"$color_e" Empty"
		else
			echo -e ""$textc_s"  resolve.conf     :"$color_e" `cat /etc/resolv.conf |grep nameserver |awk '{print $2}' |xargs echo`"
		fi
	echo ""
}

HwInfo()
{
	echo -e ""$titlec_s">>> - - - Hardware information - - - <<<"$color_e""
	cpun=`cat /proc/cpuinfo |grep processor |wc -l`
	let "++$cpun"
	echo "CPU `cat /proc/cpuinfo |grep 'model name' |uniq` x $cpun"
	echo "`free -m |grep total -C 1`"
	echo "`df -l -h -T |grep -e 'sd' -e 'hd' -e 'loop'`"
}

NetInfo()
{
	echo -e ""$titlec_s">>> - - - Network interface - - - <<<"$color_e""
		for ethdev in `ifconfig |grep Ethernet |awk '{print $1}'` lo
	do
		ifconfig $ethdev > /dev/null 2>&1
			if [ $? = 0 ]; then
				echo -e ""$textc_s"  $ethdev  :"$color_e" `ifconfig $ethdev |grep 'inet addr' |awk '{print $2,$4}'`"
		fi
	done
	echo ""
}

RouteTab()
{
	echo -e ""$titlec_s">>> - - - Routing table - - - <<<"$color_e""
	route -n
	echo ""
}

ServInfo
NetInfo
RouteTab
HwInfo
