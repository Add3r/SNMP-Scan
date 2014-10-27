#!/bin/bash

#Script Info
echo -e "\e[34m#########################################\e[0m"
echo -e "\e[34m# SNMP Scanner                          #\e[0m"
echo -e "\e[34m# Script by\e[0m \e[40;38;5;82m K@r \e[30;48;5;82m 7h1ck \e[0m \e[34m, Version 1.0  #\e[0m"
echo -e "\e[34m#########################################\e[0m"
echo " "

#script
scan_target(){
	echo -n "Enter the target ip : "
	read target
	echo -e "Scanning for windows parameters \n"
	echo -e "Enumerating Windows User \n"
	snmpwalk -c public -v1 $target 1.3.6.1.4.1.77.1.2.25
	echo -e "\n Enumerating Running Windows Processes\n"
	snmpwalk -c public -v1 $target 1.3.6.1.2.1.25.4.2.1.2
	echo -e "\n Enumerating Open TCP ports \n"
	snmpwalk -c public -v1 $target 1.3.6.1.2.1.6.13.1.3
	echo -e "\n Enumerating Installed Software Names\n"
	snmpwalk -c public -v1 $target 1.3.6.1.2.1.25.6.3.1.2
	echo -e "\n Enumerating System Processes \n"
	snmpwalk -c public -v1 $target 1.3.6.1.2.1.25.1.6.0
	echo -e "\n Enumerating Processes Path \n"
	snmpwalk -c public -v1 $target 1.3.6.1.2.1.25.4.2.1.4
	echo -e "\n Enumerating Storage Units \n"
	snmpwalk -c public -v1 $target 1.3.6.1.2.1.25.2.3.1.4
	echo -e "\n Scan complete \n"
	continue
}
scan_network(){
	for target in $(cat ~/bash/ip.txt);do
	echo -e "Scanning for windows parameters \n"
	touch snmp$target.txt
	echo -e "File created \n"
	echo -e "Enumerating Windows User \n"
	snmpwalk -c public -v1 $target 1.3.6.1.4.1.77.1.2.25 >> snmp$target.txt
	echo -e "\n Enumerating Running Windows Processes\n"
	snmpwalk -c public -v1 $target 1.3.6.1.2.1.25.4.2.1.2 >> snmp$target.txt
	echo -e "\n Enumerating Open TCP ports \n"
	snmpwalk -c public -v1 $target 1.3.6.1.2.1.6.13.1.3 >> snmp$target.txt
	echo -e "\n Enumerating Installed Software Names\n"
	snmpwalk -c public -v1 $target 1.3.6.1.2.1.25.6.3.1.2 >> snmp$target.txt
	echo -e "\n Enumerating System Processes \n"
	snmpwalk -c public -v1 $target 1.3.6.1.2.1.25.1.6.0 >> snmp$target.txt
	echo -e "\n Enumerating Processes Path \n"
	snmpwalk -c public -v1 $target 1.3.6.1.2.1.25.4.2.1.4 >> snmp$target.txt
	echo -e "\n Enumerating Storage Units \n"
	snmpwalk -c public -v1 $target 1.3.6.1.2.1.25.2.3.1.4 >> snmp$target.txt
	echo -e "\n Scan complete \n"
	done
	continue
}
161_target(){
	echo -n "Enter the target ip : "
        read target
	onesixtyone  -c /usr/share/doc/onesixtyone/dict.txt $target
	continue
}
161_network(){
	touch 161scan.txt
	for target in $(cat ~/bash/ip.txt);do
        echo -e "Scanning with 161 \n"
	onesixtyone -c /usr/share/doc/onesixtyone/dict.txt $target >> 161scan.txt
	echo -e "Scan complete\n"
	done
	continue
}
scan_with_onesixtyone(){
	touch snmpdict.txt
	echo -e " 1. scan network "
	echo -e " 2. scan single target"
	echo -n " option : "
	read op
	case $op in
		1)161_network;;
		2)161_target;;
		*) echo "invalid choice, cya!"
	esac
	continue
}
continue(){
echo -n "Do you want to continue the scan (y/n) : "
read input
case $input in
	y) choice;;
	n) echo "$(exit 0)" && echo "Try Harder , Don giveup"
esac
}
choice(){
echo " "
echo " 1.scan single target"
echo " 2.scan complete network"
echo " 3.scan with onesixtyone"
echo " 4.exit"
echo -n "your option ? : "
read opt
case $opt in
	1) scan_target;;
	2) scan_network;;
	3) scan_with_onesixtyone;;
	4) echo "$(exit 0)" && echo "Try Harder , Don give up";;
	*) echo "invalid choice, cya!"
esac
}
echo " Snmp scanner "
choice
