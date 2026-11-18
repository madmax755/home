-- Extra autostart processes.
-- Workspace placement comes from the class rules in hyprland.lua.
o.launch_on_start("beeper")
o.launch_on_start("ticktick.AppImage")
o.launch_on_start("grok-bot.AppImage")
o.exec_on_start(o.launch_webapp("https://calendar.google.com"))
