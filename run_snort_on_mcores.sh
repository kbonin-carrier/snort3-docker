#!/bin/bash
num=$1
search_mode=$2
if test $num -ge 160
then
	echo "number of insts exceed 160"
	exit
fi
if test $num -le 0
then
	echo "number of insts can't be 0 or less"
	exit
fi
echo "number of insts: $num"

DATE=$(date +"%m-%d-%y-%H-%M")
mkdir snort-$num-cores-$search_mode-results-$DATE

case $search_mode in
	"hyperscan")
		echo "using hyperscan"
		for ((i = 1; i <= $num; i++))
		do
    			echo "docker run -d --rm --cpuset-cpus=$i --name="snort-mcore-test-$i" newsnort3/update1:latest snort --rule-path /usr/local/etc/rules/ -c /usr/local/etc/snort/snort.lua --lua 'search_engine.search_method = "hyperscan"' -r /root/snort/maccdc2012_00001.pcap"	
    			docker run --cpuset-cpus=$i --name="snort-mcore-test-$i" newsnort3/update1:latest snort --rule-path /usr/local/etc/rules/ -c /usr/local/etc/snort/snort.lua --lua 'search_engine.search_method = "hyperscan"' -r /root/snort/maccdc2012_00001.pcap 2>&1 > snort-$num-cores-$search_mode-results-$DATE/snort-mcore-test-$i.txt &
		done
		;;
	"ac_bnfa")
		echo "using ac_bnfa"
		for ((i = 1; i <= $num; i++))
		do
    			echo "docker run -d --rm --cpuset-cpus=$i --name="snort-mcore-test-$i" newsnort3/update1:latest snort --rule-path /usr/local/etc/rules/ -c /usr/local/etc/snort/snort.lua --lua 'search_engine.search_method = "ac_bnfa"' -r /root/snort/maccdc2012_00001.pcap"	
    			docker run --cpuset-cpus=$i --name="snort-mcore-test-$i" newsnort3/update1:latest snort --rule-path /usr/local/etc/rules/ -c /usr/local/etc/snort/snort.lua --lua 'search_engine.search_method = "ac_bnfa"' -r /root/snort/maccdc2012_00001.pcap 2>&1 > snort-$num-cores-$search_mode-results-$DATE/snort-mcore-test-$i.txt &
		done
		;;
	"ac_full")
		echo "using ac_full"
		for ((i = 1; i <= $num; i++))
		do
    			echo "docker run -d --rm --cpuset-cpus=$i --name="snort-mcore-test-$i" newsnort3/update1:latest snort --rule-path /usr/local/etc/rules/ -c /usr/local/etc/snort/snort.lua --lua 'search_engine.search_method = "ac_full"' -r /root/snort/maccdc2012_00001.pcap"	
    			docker run --cpuset-cpus=$i --name="snort-mcore-test-$i" newsnort3/update1:latest snort --rule-path /usr/local/etc/rules/ -c /usr/local/etc/snort/snort.lua --lua 'search_engine.search_method = "ac_full"' -r /root/snort/maccdc2012_00001.pcap 2>&1 > snort-$num-cores-$search_mode-results-$DATE/snort-mcore-test-$i.txt &
		done
		;;
	*)
		echo "wrong search_mode entered: $search_mode"
		echo "must be one of these hyperscan|ac_bnfa|ac_full!"
		exit
esac

read -p "Hit any key to continue "
echo "mum of cores $num testing snort $search_mode mode in parallel results:" > snort-$num-cores-$search_mode-results-$DATE/snort-$num-cores-$search_mode-results.csv
for ((i = 1; i <= $num; i++))
do
	tail -5 snort-$num-cores-$search_mode-results-$DATE/snort-mcore-test-$i.txt >> snort-$num-cores-$search_mode-results-$DATE/snort-$num-cores-$search_mode-results.csv
done
