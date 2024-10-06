#!/bin/bash

# Full emoji list with descriptions
emoji=$(cat <<EOF
😀 Grinning Face
😁 Beaming Face with Smiling Eyes
😂 Face with Tears of Joy
🤣 Rolling on the Floor Laughing
😃 Smiling Face with Open Mouth
😄 Smiling Face with Open Mouth and Smiling Eyes
😅 Smiling Face with Sweat
😆 Smiling Face with Open Mouth and Closed Eyes
😉 Winking Face
😊 Smiling Face with Smiling Eyes
😋 Face Savoring Food
😎 Smiling Face with Sunglasses
😍 Smiling Face with Heart-Eyes
😘 Face Blowing a Kiss
😗 Kissing Face
😙 Kissing Face with Smiling Eyes
😚 Kissing Face with Closed Eyes
🙂 Slightly Smiling Face
🤗 Hugging Face
🤩 Star-Struck
🤔 Thinking Face
🤨 Face with Raised Eyebrow
😐 Neutral Face
😑 Expressionless Face
😶 Face Without Mouth
🙄 Face with Rolling Eyes
😏 Smirking Face
😣 Persevering Face
😥 Sad but Relieved Face
😮 Face with Open Mouth
🤐 Zipper-Mouth Face
😯 Hushed Face
😪 Sleepy Face
😫 Tired Face
🥱 Yawning Face
😴 Sleeping Face
😌 Relieved Face
😛 Face with Tongue
😜 Winking Face with Tongue
🤪 Zany Face
😝 Squinting Face with Tongue
🤑 Money-Mouth Face
🤗 Hugging Face
🤭 Face with Hand Over Mouth
🤫 Shushing Face
🤥 Lying Face
😶‍🌫️ Face in Clouds
🤢 Nauseated Face
🤮 Face Vomiting
🤧 Sneezing Face
😷 Face with Medical Mask
🤒 Face with Thermometer
🤕 Face with Head-Bandage
❤ Red Heart
🧡 Orange Heart
💛 Yellow Heart
💚 Green Heart
💙 Blue Heart
💜 Purple Heart
🖤 Black Heart
🤎 Brown Heart
💔 Broken Heart
❣ Heart Exclamation
💕 Two Hearts
💞 Revolving Hearts
💓 Beating Heart
💗 Growing Heart
💖 Sparkling Heart
💘 Heart with Arrow
💝 Heart with Ribbon
💟 Heart Decoration
🔥 Fire
🌟 Glowing Star
✨ Sparkles
⚡ High Voltage
🌈 Rainbow
💧 Droplet
💦 Sweat Droplets
🍎 Red Apple
🍇 Grapes
🍉 Watermelon
🍓 Strawberry
🍒 Cherries
🍍 Pineapple
🥥 Coconut
🍔 Hamburger
🍕 Pizza
🌭 Hot Dog
🍩 Doughnut
🍪 Cookie
🍣 Sushi
🎂 Birthday Cake
🍰 Shortcake
🍫 Chocolate Bar
🍬 Candy
🍭 Lollipop
🍻 Beer Mugs
🍷 Wine Glass
🍸 Cocktail Glass
🍾 Bottle with Popping Cork
🍹 Tropical Drink
🍾 Champagne
🍽️ Fork and Knife
🚀 Rocket
✈️ Airplane
🚗 Car
🏍️ Motorcycle
🚲 Bicycle
🛴 Kick Scooter
🚢 Ship
🏖️ Beach with Umbrella
🏝️ Desert Island
🏜️ Desert
🗻 Mount Fuji
🏔️ Snow-Capped Mountain
🏕️ Camping
🌋 Volcano
🎇 Sparkler
🎆 Fireworks
🎈 Balloon
🎉 Party Popper
🎊 Confetti Ball
🎋 Tanabata Tree
🎍 Pine Decoration
🎎 Japanese Dolls
🎏 Carp Streamer
🎐 Wind Chime
🎑 Moon Viewing Ceremony
🎖 Military Medal
🎗 Reminder Ribbon
🎟 Admission Tickets
🏆 Trophy
🏅 Sports Medal
🥇 1st Place Medal
🥈 2nd Place Medal
🥉 3rd Place Medal
⚽ Soccer Ball
🏀 Basketball
🏈 American Football
🎾 Tennis Ball
⚾ Baseball
🏐 Volleyball
🎱 Billiards
🎳 Bowling
⛳ Flag in Hole
🎣 Fishing Pole
🎽 Running Shirt
🎿 Skis
🏒 Ice Hockey Stick and Puck
🥋 Martial Arts Uniform
🎧 Headphones
📱 Mobile Phone
💻 Laptop
⌨️ Keyboard
🖱️ Computer Mouse
🖲️ Trackball
💡 Light Bulb
🔦 Flashlight
🕯️ Candle
EOF
)

# Use Rofi to display the list and capture the selected emoji
chosen=$(echo "$emoji" | rofi -dmenu -i -p "Select Emoji" | awk '{print $1}')

# Type the selected emoji using xdotool
[ -n "$chosen" ] && xdotool type "$chosen"

