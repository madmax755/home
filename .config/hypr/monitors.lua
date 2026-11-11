-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
-- List current monitors and supported resolutions with: hyprctl monitors all

hl.env("GDK_SCALE", "1.75")
hl.monitor({ output = "DP-1", mode = "5120x1440@60", position = "0x0", scale = 1 })
hl.monitor({ output = "eDP-1", mode = "2880x1800@120", position = "1760x1440", scale = 1.8 })
