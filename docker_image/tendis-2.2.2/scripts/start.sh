#!/bin/bash
set -ex

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:../bin/deps

dir=/data1/tendis
ip=`/sbin/ifconfig -a|grep eth -A 3 | grep inet | grep -v 127.0.0.1 | grep -v inet6 | awk '{print $2}' | tr -d "addr:" | head -n 1 | sed 's/^M//g'`


port=51002
echo ${port}
if [[ "AA${port}AA" == "AAAA" ]]; then
        echo "port is empty!!"
        exit
fi

mkdir -p ${dir}/${port}/db
mkdir -p ${dir}/${port}/dump
mkdir -p ${dir}/${port}/log
cp ./tendisplus.conf ${dir}/${port}/

sed -i "s/{{PORT}}/${port}/g" ${dir}/${port}/tendisplus.conf
sed -i "s/{{IP}}/${ip}/g" ${dir}/${port}/tendisplus.conf
sed -i "s:{{DIR}}:${dir}:g" ${dir}/${port}/tendisplus.conf
sed -i "s/{{CLUSTER}}/${CLUSTER}/g" ${dir}/${port}/tendisplus.conf
if [[ "${REDIS_PASSWORD}" != "" ]]; then
        echo "requirepass ${REDIS_PASSWORD}" >> ${dir}/${port}/tendisplus.conf
        echo "masterauth ${REDIS_PASSWORD}" >> ${dir}/${port}/tendisplus.conf
fi
cat ${dir}/${port}/tendisplus.conf

../bin/tendisplus ${dir}/${port}/tendisplus.conf
