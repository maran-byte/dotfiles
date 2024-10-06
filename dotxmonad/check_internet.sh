#!/bin/bash

if ping -c 1 8.8.8.8 &> /dev/null; then
    local_ip=$(ip route get 1 | awk '{print $7;exit}')
    echo "Connected: $local_ip"
else
    echo "Disconnected"
fi

