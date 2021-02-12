#!/bin/bash
num=$1
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

docker ps -a
for ((i = 1; i <= $num; i++))
do
	echo "removing the docker"
	docker container rm `docker ps -q -l`
done
echo "--------------------"
docker ps -a

