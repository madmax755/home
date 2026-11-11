-- Keep only your personal keybinding overrides here. Add new bindings or
-- unbind defaults before replacing them.

-- See current bindings and descriptions:
--   omarchy menu keybindings --print

-- SUPER+F was: ASUS platform profile cycle.
hl.unbind("SUPER + F")
o.bind("SUPER + F", "Search files", "walker --provider files --width 460 --height 420")

-- SUPER+L was: Toggle workspace layout. Lock is SUPER+CTRL+L by default.
hl.unbind("SUPER + L")
o.bind("SUPER + L", "Lock system", "omarchy-system-lock")

hl.unbind("SUPER + SHIFT + G")
o.bind("SUPER + SHIFT + G", "Gemini", { webapp = "https://gemini.google.com/app" })

hl.unbind("SUPER + SHIFT + A")
o.bind("SUPER + SHIFT + A", "ChatGPT", { webapp = "https://chatgpt.com" })

hl.unbind("SUPER + SHIFT + ALT + G")
o.bind("SUPER + SHIFT + ALT + G", "Grok", { webapp = "https://grok.com" })

-- Map the mouse back/forward buttons to Super+C and Super+V.
local function mouse_clipboard_shortcut(default_mods, default_key, terminal_mods, terminal_key)
  return function()
    local mods, key = default_mods, default_key
    local window = hl.get_active_window()

    if window then
      for _, tag in ipairs(window.tags or {}) do
        if tag:gsub("%*$", "") == "terminal" then
          mods, key = terminal_mods, terminal_key
          break
        end
      end
    end

    hl.dispatch(hl.dsp.send_key_state({ mods = mods, key = key, state = "down" }))
    hl.timer(function()
      hl.dispatch(hl.dsp.send_key_state({ mods = mods, key = key, state = "up" }))
    end, { timeout = 50, type = "oneshot" })
  end
end

o.bind("mouse:275", "Copy", mouse_clipboard_shortcut("CTRL", "C", "CTRL SHIFT", "C"))
o.bind("mouse:276", "Paste", mouse_clipboard_shortcut("CTRL", "V", "CTRL SHIFT", "V"))


-- Dictation keys from before Alt + Space and Right Alt became the defaults.
-- Remove these lines to give the keys back to applications.
if o.dictation_installed and o.dictation_installed() then
  o.bind("SUPER + CTRL + X", "Toggle dictation", "omarchy-dictation toggle")
  o.bind_hold("F9", "Start dictation (push-to-talk)", "omarchy-dictation start", "Stop dictation (push-to-talk)", "omarchy-dictation stop")
end
