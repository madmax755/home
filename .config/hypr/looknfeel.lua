-- Change the default Omarchy look'n'feel.

-- https://wiki.hypr.land/Configuring/Basics/Variables/#general
hl.config({
  general = {
    -- No gaps between windows.
    gaps_in = 0,
    gaps_out = 0,
  },
})

-- Slightly more transparent unfocused windows than the Omarchy default.
-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
o.window({ tag = "default-opacity" }, { opacity = "1.0 0.9" })

-- Opt another application in to Omarchy's standard transparency.
-- Find its class with: hyprctl clients
-- o.transparent_window("my-app")
-- o.transparent_window("my-app", "0.9 0.85") -- Custom active/inactive opacity.
