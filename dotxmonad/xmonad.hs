import XMonad
import XMonad.Util.EZConfig (additionalKeys)
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run (spawnPipe)
import XMonad.Layout.Spacing
import XMonad.Layout.ThreeColumns
import XMonad.Layout.Grid
import XMonad.Layout.OneBig
import XMonad.Layout.NoBorders
import XMonad.Layout.Renamed
import XMonad.Layout.LimitWindows
import XMonad.Layout.ResizableTile
import XMonad.Layout.ToggleLayouts as T
import XMonad.Layout.Magnifier
import XMonad.Layout.ZoomRow
import XMonad.Layout.MouseResizableTile
import XMonad.Layout.WindowArranger
import XMonad.Layout.SimplestFloat -- Fix for floating windows
import XMonad.ManageHook
import XMonad.Actions.SpawnOn
import XMonad.Actions.CycleWS
import System.IO
import Graphics.X11.ExtraTypes.XF86
import XMonad.Util.Cursor
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.SetWMName
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP
import XMonad.Layout.MultiToggle
import XMonad.Layout.MultiToggle.Instances

-- Define your workspace names/icons
myWorkspaces :: [String]
myWorkspaces = [ " \xf120 ", " \xf269 ", " \xf019 ", " \xf2c6 ", " \xf121 ", " \xf008 ", " \xf15c ", " \xf1fc ", " \xf07b " ]

-- Define layouts with proper names
myLayoutHook = avoidStruts $ windowArrange $ T.toggleLayouts floats $ 
               mkToggle (NBFULL ?? NOBORDERS ?? EOT) $ myDefaultLayout
             where 
                 myDefaultLayout = space ||| tall ||| grid ||| threeRow ||| oneBig ||| noBorders monocle ||| floats

-- Define individual layouts

space      = renamed [Replace "space"]    $ limitWindows 4  $ spacing 12 $ Mirror $ OneBig (2/3) (2/3)
tall       = renamed [Replace "tall"]     $ limitWindows 12 $ spacing 6 $ ResizableTall 1 (3/100) (1/2) []
grid       = renamed [Replace "grid"]     $ limitWindows 12 $ spacing 6 $ mkToggle (single MIRROR) Grid
threeRow   = renamed [Replace "threeRow"] $ limitWindows 3  $ Mirror $ mkToggle (single MIRROR) zoomRow
oneBig     = renamed [Replace "oneBig"]   $ limitWindows 6  $ Mirror $ OneBig (5/9) (8/12)
monocle    = renamed [Replace "monocle"]  $ limitWindows 20 $ Full
floats     = renamed [Replace "floats"]   $ limitWindows 20 $ simplestFloat

-- Assign applications to specific workspaces

myManageHook :: ManageHook
myManageHook = composeAll
    [ className =? "kitty" --> doShift " \xf120 " 
    , className =? "firefox" --> doShift " \xf269 " 
    , className =? "qBittorrent" --> doShift " \xf019 " 
    , className =? "TelegramDesktop" --> doShift " \xf2c6 " 
    , className =? "code-oss" --> doShift " \xf121 " 
    , className =? "mpv" --> doShift " \xf008 " 
    , className =? "Stremio" --> doShift " \xf008 " 
    , className =? "libreoffice-writer" --> doShift " \xf15c " 
    , className =? "libreoffice-calc" --> doShift " \xf15c " 
    , className =? "Pinta" --> doShift " \xf1fc " 
    , className =? "Thunar" --> doShift " \xf07b "
    , className =? "localsend" --> doShift " \xf07b " 
    , className =? "Vivaldi" --> doShift " \xf07b " 
    ]

-- Send the layout info via IPC to Polybar
polybarLogHook :: X ()
polybarLogHook = dynamicLogWithPP $ def
    { ppOutput = \str -> spawn $ "polybar-msg hook xmonad-layout 1 " ++ str
    , ppLayout = \x -> case x of
        "space"       -> "Spacious"
        "tall"        -> "Tiled"
        "grid"        -> "Grid"
        "threeRow"    -> "Three Rows"
        "oneBig"      -> "One Big"
        "monocle"     -> "Monocle"
        "floats"      -> "Floating"
        _             -> x
    }

main = do
    -- Kill any existing Polybar instance
    spawn "killall -q polybar"
    
    -- Launch Polybar with a longer delay
    
    spawn "sleep 2 && polybar main &"

    -- Set up wallpaper, keybindings, etc.
    
    spawn "nitrogen --restore &"
    spawn "xbindkeys &"
    spawn "xmodmap ~/.Xmodmap &"
    spawn "conky -c ~/.config/conky/xmonad.conf &"
    spawn "nvidia-settings --assign CurrentMetaMode='nvidia-auto-select +0+0 {ForceFullCompositionPipeline=On}'"
    spawn "setxkbmap -layout us"

                                                                                                                                                                                                             
--                                                                           88                                      ad88 88                                                                                                                d8"   ""                                                 ,d    ""                          
--                                                                           88                                     88                                                
--8b,     ,d8 88,dPYba,,adPYba,   ,adPPYba,  8b,dPPYba,  ,adPPYYba,  ,adPPYb,88  ,adPPYba,  ,adPPYba,  8b,dPPYba, MM88MMM 88  ,adPPYb,d8    
-- `Y8, ,8P'  88P'   "88"    "8a a8"     "8a 88P'   `"8a ""     `Y8 a8"    `Y88 a8"     "" a8"     "8a 88P'   `"8a  88    88 a8"    `Y88 
--   )888(    88      88      88 8b       d8 88       88 ,adPPPPP88 8b       88 8b         8b       d8 88       88  88    88 8b       88   
-- ,d8" "8b,  88      88      88 "8a,   ,a8" 88       88 88,    ,88 "8a,   ,d88 "8a,   ,aa "8a,   ,a8" 88       88  88    88 "8a,   ,d88   
--8P'     `Y8 88      88      88  `"YbbdP"'  88       88 `"8bbdP"Y8  `"8bbdP"Y8  `"Ybbd8"'  `"YbbdP"'  88       88  88    88  `"YbbdP"Y8   
--                                                                                                                            aa,    ,88                                                                       
--                                                                                                                             "Y8bbdP"                                                                        

    -- Main XMonad Configuration

    xmonad $ docks $ ewmhFullscreen $ ewmh def
        { modMask = mod4Mask
        , terminal = "kitty"
        , borderWidth = 0                                           -- Border
        , focusedBorderColor = "#bfff00"
        , normalBorderColor = "#44475a"
        , workspaces = myWorkspaces
        , layoutHook = myLayoutHook
        , manageHook = manageDocks <+> myManageHook <+> manageHook def
        , logHook = polybarLogHook  -- Send layout changes to Polybar
        , handleEventHook = handleEventHook def
        , startupHook = do
                spawn "nitrogen --restore &"
                spawn "xbindkeys &"
                spawn "xmodmap ~/.Xmodmap &"
                spawn "conky -c ~/.config/conky/xmonad.conf &"
                spawn "nvidia-settings --assign CurrentMetaMode='nvidia-auto-select +0+0 {ForceFullCompositionPipeline=On}'"
                spawn "setxkbmap -layout us"
                setWMName "LG3D"
                setDefaultCursor xC_left_ptr
        }
        `additionalKeys`
        [
        
--                                88                                                         
--                                88                                                  ,d     
--                                88                                                  88     
--                                88 ,adPPYYba, 8b       d8  ,adPPYba,  88       88 MM88MMM  
--                                88 ""     `Y8 `8b     d8' a8"     "8a 88       88   88     
--                                88 ,adPPPPP88  `8b   d8'  8b       d8 88       88   88     
--                                88 88,    ,88   `8b,d8'   "8a,   ,a8" "8a,   ,a88   88,    
--                                88 `"8bbdP"Y8     Y88'     `"YbbdP"'   `"YbbdP'Y8   "Y888  
--                                                d8'                                      
--                                               d8'                                           
    
        -- Layout-specific shortcuts with Ctrl + Alt

        ((mod1Mask .|. controlMask, xK_1), sendMessage $ JumpToLayout "tall"),        -- Switch to tall layout with Ctrl + Alt + 1
        ((mod1Mask .|. controlMask, xK_2), sendMessage $ JumpToLayout "grid"),        -- Switch to grid layout with Ctrl + Alt + 2
        ((mod1Mask .|. controlMask, xK_3), sendMessage $ JumpToLayout "threeRow"),    -- Switch to threeRow layout with Ctrl + Alt + 3
        ((mod1Mask .|. controlMask, xK_4), sendMessage $ JumpToLayout "oneBig"),      -- Switch to oneBig layout with Ctrl + Alt + 4
        ((mod1Mask .|. controlMask, xK_5), sendMessage $ JumpToLayout "monocle"),     -- Switch to monocle layout with Ctrl + Alt + 5
        ((mod1Mask .|. controlMask, xK_6), sendMessage $ JumpToLayout "space"),       -- Switch to space layout with Ctrl + Alt + 6
        ((mod1Mask .|. controlMask, xK_7), sendMessage $ JumpToLayout "floats"),      -- Switch to floating layout with Ctrl + Alt + 7
        ((mod1Mask .|. controlMask, xK_e), spawn "rofimoji"),                         -- Launch Emoji with Ctrl + Alt + E

        
--                       ad8888888888ba
--                      dP'         `"8b,
--                    8  ,aaa,       "Y888a     ,aaaa,     ,aaa,  ,aa,
--                    8  8' `8           "88baadP""""YbaaadP"""YbdP""Yb
--                    8  8   8              """        """      ""    8b
--                    8  8, ,8         ,aaaaaaaaaaaaaaaaaaaaaaaaddddd88P
--                    8  `"""'       ,d8""
--                      Yb,         ,ad8"    keybindings
--                        "Y8888888888P"



        -- Your existing keybindings here

        ((mod4Mask .|. shiftMask, xK_Return), spawnOn " \xf120 " "kitty"),
        ((mod4Mask, xK_w), spawnOn " \xf269 " "firefox"),
        ((mod4Mask, xK_b), spawnOn " \xf019 " "qBittorrent"),
        ((mod4Mask, xK_t), spawnOn " \xf2c6 " "telegram-desktop"),
        ((mod4Mask, xK_c), spawnOn " \xf121 " "code"),
        ((mod4Mask, xK_m), spawnOn " \xf008 " "mpv"),
        ((mod4Mask, xK_o), spawnOn " \xf15c " "libreoffice"),
        ((mod4Mask, xK_p), spawnOn " \xf1fc " "pinta"),
        ((mod4Mask, xK_Right), nextWS),                                -- Move to next workspace with Right Arrow
        ((mod4Mask, xK_Left), prevWS),                                 -- Move to previous workspace with Left Arrow
        ((mod4Mask, xK_d), spawn "dmenu_run"),                         -- Launch dmenu with Super + D
        ((mod4Mask, xK_s), spawn "screengrab"),                        -- Launch Screengrab with Super + S
        ((mod4Mask, xK_r), spawn "rofi -show drun -theme ~/.config/rofi/config.rasi"), -- Launch Rofi with Super + R
        ((mod4Mask, xK_e), spawn "thunar"),                            -- Launch Thunar with Super + E

        -- Actions taken with Win + Alt

        ((mod4Mask .|. mod1Mask, xK_s), spawn "shutdown now"),          -- shutdown
        ((mod4Mask .|. mod1Mask, xK_l), spawn "pkill xmonad"),          -- log ppOutput
        ((mod4Mask .|. mod1Mask, xK_r), spawn "reboot"),                -- restart

        -- Volume control

        ((0, xF86XK_AudioLowerVolume), spawn "amixer -q sset Master 1%-"),
        ((0, xF86XK_AudioRaiseVolume), spawn "amixer -q sset Master 1%+"),
        ((0, xF86XK_AudioMute), spawn "amixer -q sset Master toggle")
        ]
