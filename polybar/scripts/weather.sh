#!/bin/bash

# Replace with your OpenWeatherMap API key
API_KEY="7501beeb88b2ed3e51a2941ab9e82025"

# City ID for Chandigarh, India
CITY_ID="1274746"

# Units: metric for Celsius, imperial for Fahrenheit
UNITS="metric"

# Fetch weather data
WEATHER=$(curl -sf "http://api.openweathermap.org/data/2.5/weather?id=$CITY_ID&units=$UNITS&appid=$API_KEY")

if [ ! -z "$WEATHER" ]; then
    WEATHER_DESC=$(echo $WEATHER | jq -r ".weather[0].description")
    WEATHER_TEMP=$(echo $WEATHER | jq -r ".main.temp" | cut -d "." -f 1)

    echo "$WEATHER_DESC, ${WEATHER_TEMP}°C"
else
    echo "Weather Unavailable"
fi

