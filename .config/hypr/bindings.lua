-- Keep only your personal keybinding overrides here. Add new bindings or
-- unbind defaults before replacing them.

-- See current bindings and descriptions:
--   omarchy menu keybindings --print

-- SUPER+F was: ASUS platform profile cycle.
hl.unbind("SUPER + F")
o.bind("SUPER + F", "Walker launcher", "walker")

-- SUPER+L was: Toggle workspace layout. Lock is SUPER+CTRL+L by default.
hl.unbind("SUPER + L")
o.bind("SUPER + L", "Lock system", "omarchy-system-lock")

hl.unbind("SUPER + SHIFT + G")
o.bind("SUPER + SHIFT + G", "Gemini", { webapp = "https://gemini.google.com/app" })

hl.unbind("SUPER + SHIFT + A")
o.bind("SUPER + SHIFT + A", "ChatGPT", { webapp = "https://chatgpt.com" })

hl.unbind("SUPER + SHIFT + ALT + G")
o.bind("SUPER + SHIFT + ALT + G", "Grok", { webapp = "https://grok.com" })

