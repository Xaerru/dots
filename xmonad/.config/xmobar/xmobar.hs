import           Xmobar

config :: Config
config = defaultConfig
  { font            = "xft:Jetbrains Mono Nerd Font:pixelsize=10:antialias=true:hinting=true"
  , additionalFonts = [ "xft:Jetbrains Mono Nerd Font:pixelsize=10:antialias=true:hinting=true"
                      , "xft:Font Awesome 5 Free Solid:pixelsize=10"
                      , "xft:Font Awesome 5 Brands:pixelsize=10"
                      ]
  , bgColor         = "#2E3440"
  , fgColor         = "#BF616A"
  , position        = Static { xpos = 0, ypos = 0, width = 1920, height = 24 }
  , lowerOnStart    = True
  , hideOnStart     = False
  , allDesktops     = True
  , persistent      = True
  , iconRoot        = ".xmonad/xpm/"  -- default: "."
  , commands        =
    [
                      -- Time and date
      Run $ Date "%a %B %e %H:%M" "date" 50
                      -- Network up and down
    , Run $ Network "wlan0" ["-t", "<fn=2>\xf019</fn> <rx>kb <fn=2>\xf093</fn> <tx>kb"] 20
                      -- Cpu usage in percent
    , Run $ Cpu ["-t", "<fn=2>\xf108</fn> <total>%"] 20
                      -- Ram used number and percent
    , Run $ Memory ["-t", "<fn=2>\xf233</fn> <used>M (<usedratio>%)"] 20
                      -- Disk space free
    , Run $ DiskU [("/", "<fn=2>\xf0c7</fn> <free> free")] [] 60
                      -- Runs a standard shell command 'uname -r' to get kernel version
    , Run $ Com "uname" ["-r"] "" 3600
    , Run $ UnsafeStdinReader
    , Run $ BatteryP
      ["BAT1"]
      [ "-t"
      , "<acstatus>"
      , "--"
      , "--highs"
      , "Bat: <left>%"
      , "--mediums"
      , "Bat: <left>%"
      , "--lows"
      , "Bat: <left>%"
      , "-O"
      , "<fc=#A3BE8C><fn=2>\xf1e6</fn></fc>"
      , "-o"
      , ""
      , "-a"
      , "notify-send -u critical 'Battery running out!!'"
      , "-A"
      , "5"
      ]
      30
    , Run $ Com "/home/xaerru/.config/xmobar/scripts/song.sh" [] "music" 10
    , Run $ Com "/home/xaerru/.config/xmobar/scripts/sound.sh" [] "sound" 1
    , Run $ Com "/home/xaerru/.config/xmobar/scripts/trayer-padding-icon.sh" [] "trayerpad" 10
    ]
  , sepChar         = "%"
  , alignSep        = "}{"
  , template        =
    " <icon=profile.xpm/> <fc=#666666>|</fc> %UnsafeStdinReader% }{ <fc=#A3BE8C>%music%</fc> <fc=#666666>|</fc> <fc=#8FBCBB>%uname%</fc> <fc=#666666>|</fc> <fc=#A3BE8C>%disku%</fc> <fc=#666666>|</fc> <fc=#B48EAD>Vol: %sound%</fc> <fc=#666666>|</fc> <fc=#88C0D0>%memory%</fc> <fc=#666666>|</fc> <fc=#B48EAD>%cpu%</fc> <fc=#666666>|</fc> <fc=#88C0D0>%wlan0%</fc> <fc=#666666>|</fc> <fc=#A3BE8C>%battery%</fc> <fc=#666666>|</fc> <fc=#D8DEE9>%date%</fc>%trayerpad%"
  }

main :: IO ()
main = xmobar config
