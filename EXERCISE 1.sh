#!/bin/bash


CPU_THRESHOLD=80
MEMORY_THRESHOLD=90


get_usage() {
  pid=$1
  cpu_usage=$(top -b -n 1 -p $pid | awk '/^$/ {getline} {print $9}')
  mem_usage=$(pmap -d $pid | awk '/^total/ {print $2}' | sed 's/K//g')
  echo "$cpu_usage $mem_usage"
}


kill_process() {
  pid=$1
  echo "Killing process $pid (CPU: $2%, MEM: $3%)"
  kill -9 $pid
}


processes=$(ps -ef | awk '{print $2}')


for pid in $processes; do

    usage=$(get_usage $pid)
  cpu_usage=$(echo $usage | cut -d' ' -f1)
  mem_usage=$(echo $usage | cut -d' ' -f2)

  if [ $cpu_usage -gt $CPU_THRESHOLD ] || [ $mem_usage -gt $MEMORY_THRESHOLD ]; then
    kill_process $pid $cpu_usage $mem_usage
  fi
done
