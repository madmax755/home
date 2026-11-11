-- Keep only your personal input overrides here. Uncommented settings below
-- replace Omarchy's defaults.

-- Keyboard layout and options.
-- See https://wiki.hypr.land/Configuring/Basics/Variables/#input
hl.config({
  input = {
    -- GB QWERTY plus GB Colemak-DH; both Shifts toggle layout.
    kb_layout = "gb",
    kb_variant = "",

    -- Change speed of keyboard repeat.
    repeat_rate = 40,
    repeat_delay = 600,

    -- Start with numlock on by default.
    numlock_by_default = true,

    -- Increase sensitivity for mouse/trackpad (default: 0).
    sensitivity = 0.4,

    touchpad = {
      -- Use natural (inverse) scrolling.
      natural_scroll = true,

      -- Control the speed of your scrolling.
      scroll_factor = 0.4,
    },
  },
})

-- Slightly lower sensitivity for the external USB mice; leave the laptop touchpad alone.
hl.device({ name = "Keychron Keychron Receiver Mouse", sensitivity = 0.25 })
hl.device({ name = "2.4G Mouse", sensitivity = 0.25 })

-- Enable touchpad gestures for changing workspaces.
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Gestures/
hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })
