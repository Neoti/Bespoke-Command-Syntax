#!/bin/bash
DEBUG="Yes"

if [ "$DEBUG" == "Yes" ]; then
	testpath="_test"
else
	testpath=""
fi

# 1. set system name in /etc/hostname
# 2. edit hosts file /etc/hosts
# 3. edit resolve.conf /etc/resolv.conf
# 4. set up ssh keys

if [ "$DEBUG" == "Yes" ]; then
	echo " "
	echo "###########################"
	echo "#  STARTING IN TEST MODE! #"
	echo "##########################"
	echo " "
	echo "This will set up the common stuff on the sysyem"
fi

read -p "Enter HostName:  " HNAME
read -p "Enter Domain Name:  " DOMNAME
read -p "Enter DNS Server 1:  " DNSSRV1
read -p "Enter DNS Server 2:  " DNSSRV2
read -p "Reboot system when done?  Enter Yes with a capital Y.  " REBOOT

echo "Continue?"
read -p "Enter Yes with a capital Y if you wish to continue. " AnswerYes

if [ "$AnswerYes" == "Yes" ]; then
    echo "Continuing"
else
    echo "You did not answer"
    echo "Yes"
    echo "So I am exiting, have a nice day!"
    exit 0
fi

echo "$HNAME" > /etc/hostname$testpath
echo "127.0.0.1	$HNAME	$HNAME.$DOMNAME" >> /etc/hosts$testpath
echo "127.0.1.1 $HNAME	$HNAME.$DOMNAME" >> /etc/hosts$testpath
echo "nameserver	$DNSSRV1" > /etc/resolv.conf$testpath
echo "nameserver        $DNSSRV2" >> /etc/resolv.conf$testpath
ssh-keygen -t rsa -f /root/.ssh/id_rsa$testpath -q -P ""

if [ "$REBOOT" == "Yes" ]; then
	echo "## >>COMPLETED. REBOOTING<< ##"
	reboot
else
	echo "Not Rebooting, as you said not to"
fi

