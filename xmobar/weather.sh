#!/bin/bash
# Fetch weather for your city from wttr.in (replace <city> with your city name or use coordinates)
weather=$(curl -s "wttr.in/Chandigarh?format=1")
echo "$weather"

