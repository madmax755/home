# Home configuration

This repository is checked out at `$HOME` and intentionally tracks a small,
explicit set of personal configuration files. Omarchy supplies the base
Hyprland configuration; the tracked Lua files contain local overrides.

## Tracked configuration

- `.bash_setup_shared`: shared Bash setup.
- `.config/hypr/*.lua`: personal Omarchy/Hyprland configuration. `monitors.lua`
  describes this machine's built-in display and ultrawide layout.
- `.config/walker/`: Walker search settings and the customized Omarchy theme.
- `.config/omarchy/`: shell settings, personal hooks, the `mk.lock` plugin, and
  the Vantablack Ghostty theme override.
- `.config/{ghostty,alacritty,foot}/` and `.config/starship.toml`: terminal and
  prompt settings.

The root `.gitignore` is an allowlist. New files remain ignored by
`git add --all`; to intentionally track one, run `git add -f <path>`. Keep
credentials, histories, caches, generated backups, and machine application
state out of this repository. Git identity remains local in `.config/git`.
