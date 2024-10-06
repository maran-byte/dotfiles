Config { font = "xft:JetBrainsMono Nerd Font-10, FontAwesome-10"
       , bgColor = "#282a36"
       , fgColor = "#f8f8f2"
      -- , alpha = 196
       , borderColor = "#44475a"
       , borderWidth = 8
       , position = TopSize C 100 25
       , lowerOnStart = True
       , commands = [ Run Com "echo" ["<action=`rofi -show drun -theme ~/.config/rofi/config.rasi`><icon=/home/maran/Pictures/Logo/Xmonadwhite.xpm/></action>"] "rofi_icon" 10
                    , Run Date "<fc=#f1fa8c>\xf017 %I:%M %p</fc> | \xf073  %a, %d %b %y" "date" 10
                    , Run Cpu ["-L", "3", "-H", "50", "--normal", "#50fa7b", "--high", "#ff5555"] 10
                    , Run Memory ["-t", "Mem: <usedratio>%"] 10
                    , Run Com "sh" ["-c", "uname -r"] "kernel" 36000
                    , Run Network "enp2s0" ["-t", "<fc=#ffb86c>\xf0ac Net: \xf019 <rx>KB | \xf093 <tx>KB</fc>"] 10
                    , Run Volume "default" "Master" ["-t", "<status>", "--", "-O", "<fc=#50fa7b>\xf028 : <volume>%</fc>", "-o", "<fc=#ff5555>\xf026 : <volume>%</fc>"] 10
                    , Run DiskU [("/", "\xf0a0 Root: <free> | "), ("/mnt/ntfs", "\xf0a0 NTFS: <free>")] [] 60
                    , Run Com "/home/maran/.config/xmobar/weather.sh" [] "weather" 3600
                    , Run Com "echo" ["<action=`reboot`><fc=#f1fa8c>\xf021</fc></action>"] "restart" 3600
                    , Run Com "echo" ["<action=`shutdown now`><fc=#ff5555>\xf011</fc></action>"] "shutdown" 3600
                    , Run Com "echo" ["<action=`pkill xmonad`><fc=#50fa7b>\xf08b</fc></action>"] "logout" 3600
                    , Run StdinReader
                    ]
       , sepChar = "%"
       , alignSep = "}{"
       , template = "%rofi_icon% %StdinReader% | %title% }{<fc=#bd93f9>%kernel%</fc> | %date% | %weather% | %cpu% | %memory% | %enp2s0% | %disku% | %default:Master%"
       }