#!/bin/bash
core=$1
search_mode=$2
if test $core -ge 160
then
	echo "number of insts exceed 160"
	exit
fi
if test $core -le 0
then
	echo "number of insts can't be 0 or less"
	exit
fi
echo "number of insts: $core"

if test "$search_mode" = "hyperscan"
then
	echo "using hyperscan"
	echo "docker run -it --cpuset-cpus=$core --name="snort-core-test-$core" snort3.1.1.0:latest snort --rule-path /usr/local/etc/rules/ -c /usr/local/etc/snort/snort.lua --lua 'search_engine.search_method = "'$search_mode'"' -r /root/snort/maccdc2012_00001.pcap"
	docker run -it --cpuset-cpus=$core --name="snort-core-test-$core" snort3.1.1.0:latest snort --rule-path /usr/local/etc/rules/ -c /usr/local/etc/snort/snort.lua --lua 'search_engine.search_method = "hyperscan"' -r /root/snort/maccdc2012_00001.pcap
	exit
fi

if test "$search_mode" = "ac_bnfa"
then
	echo "using ac_bnfa"
	echo "docker run -it --cpuset-cpus=$core --name="snort-core-test-$core" snort3.1.1.0:latest snort --rule-path /usr/local/etc/rules/ -c /usr/local/etc/snort/snort.lua --lua 'search_engine.search_method = "$search_mode"' -r /root/snort/maccdc2012_00001.pcap"
	docker run -it --cpuset-cpus=$core --name="snort-core-test-$core" snort3.1.1.0:latest snort --rule-path /usr/local/etc/rules/ -c /usr/local/etc/snort/snort.lua --lua 'search_engine.search_method = "ac_bnfa"' -r /root/snort/maccdc2012_00001.pcap
	exit
fi

if test "$search_mode" = "ac_full"
then
	echo "using ac_full"
	echo "docker run -it --cpuset-cpus=$core --name="snort-core-test-$core" snort3.1.1.0:latest snort --rule-path /usr/local/etc/rules/ -c /usr/local/etc/snort/snort.lua --lua 'search_engine.search_method = "$search_mode"' -r /root/snort/maccdc2012_00001.pcap"
	docker run -it --cpuset-cpus=$core --name="snort-core-test-$core" snort3.1.1.0:latest snort --rule-path /usr/local/etc/rules/ -c /usr/local/etc/snort/snort.lua --lua 'search_engine.search_method = "ac_full"' -r /root/snort/maccdc2012_00001.pcap
	exit
else
	echo "wrong search_mode entered: $search_mode"
	echo "must be one of these hyperscan|ac_bnfa|ac_full!"
	echo "USAGE: $0 core1 (inst# OR core#) $search_mode (hyperscan|ac_full|ac_bnfa)"
	exit
fi
#echo "USAGE: $0 core1 (inst# OR core#) $search_mode (hyperscan|ac_full|ac_bnfa)"
#echo "docker run -it --cpuset-cpus=$core --name="snort-core-test-$core" snort3.1.1.0:latest snort --rule-path /usr/local/etc/rules/ -c /usr/local/etc/snort/snort.lua --lua 'search_engine.search_method = "$search_mode"' -r /root/snort/maccdc2012_00001.pcap"
#docker run -it --cpuset-cpus=$core --name="snort-core-test-$core" snort3.1.1.0:latest snort --rule-path /usr/local/etc/rules/ -c /usr/local/etc/snort/snort.lua --lua 'search_engine.search_method = "$search_mode"' -r /root/snort/maccdc2012_00001.pcap
