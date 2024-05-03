#!/bin/bash

# Set the threshold values for CPU and memory usage
CPU_THRESHOLD=80
MEMORY_THRESHOLD=90

# Function to get the CPU and memory usage of a process
get_usage() {
  pid=$1
  cpu_usage=$(top -b -n 1 -p $pid | awk '/^$/ {getline} {print $9}')
  mem_usage=$(pmap -d $pid | awk '/^total/ {print $2}' | sed 's/K//g')
  echo "$cpu_usage $mem_usage"
}

# Function to kill a process
kill_process() {
  pid=$1
  echo "Killing process $pid (CPU: $2%, MEM: $3%)"
  kill -9 $pid
}

# Get a list of all running processes
processes=$(ps -ef | awk '{print $2}')

# Loop through each process
for pid in $processes; do
  # Get the CPU and memory usage of the process
  usage=$(get_usage $pid)
  cpu_usage=$(echo $usage | cut -d' ' -f1)
  mem_usage=$(echo $usage | cut -d' ' -f2)

  # Check if the process exceeds the threshold values
  if [ $cpu_usage -gt $CPU_THRESHOLD ] || [ $mem_usage -gt $MEMORY_THRESHOLD ]; then
    kill_process $pid $cpu_usage $mem_usage
  fi
done