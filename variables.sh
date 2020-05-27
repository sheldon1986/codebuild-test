#!/bin/bash

sed -nr '/variables:/,$ s/  ([A-Z_]+): (.*)/\1:\2/ p' buildspec.yml | while read assign; do echo $assign ; done > variables.txt
sed -i "s%/%\\\/%g" env

exec < variables.txt
while read line
do
key=$(echo $line |awk -F ':' '{print $1}')

  if [[ $(cat ./env |grep -v '^#' |grep $key |wc -l) == 0 ]]; then
        echo please insert value about $key
        exit 1
  elif [[ $(cat ./env |grep $key |wc -l) == 1 ]]; then
        sed -i "/variables:/,$ s/  $key: /  $key:$(cat ./env |grep -v '^#' |grep $key |awk -F ':' '{print $2}')/g" buildspec.yml
  fi
done
