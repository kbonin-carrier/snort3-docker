docker run snort3.1.1.0 snort --rule-path /usr/local/etc/rules/ -c /usr/local/etc/snort/snort.lua --lua 'search_engine.search_method = "hyperscan"' -r /root/snort/maccdc2012_00001.pcap

