Custom fork of the [Catppuccin Tmux theme](https://github.com/catppuccin/tmux), replacing the default itms appearance, but retaining the original color themes

## Themes

- 🌻 [Latte](./catppuccin-latte.tmuxtheme)
- 🪴 [Frappé](./catppuccin-frappe.tmuxtheme)
- 🌺 [Macchiato](./catppuccin-macchiato.tmuxtheme)
- 🌿 [Mocha](./catppuccin-mocha.tmuxtheme)

## Usage

### TPM

1. Install [TPM](https://github.com/tmux-plugins/tpm)
2. Add the Catppuccin plugin:

```bash
set -g @plugin 'tilegg/catppuccin-tmux'
# ...alongside
set -g @plugin 'tmux-plugins/tpm'
```

3. (Optional) Set your preferred flavour, it defaults to `"mocha"`:

```bash
set -g @catppuccin_flavour 'latte' # or frappe, macchiato, mocha
```

### Manual

1. Copy your desired theme's configuration contents into your Tmux config (usually stored at `~/.tmux.conf`)
2. Reload Tmux by either restarting the session or reloading it with `tmux source-file ~/.tmux.conf`

#### Configuration options

All flavours support certain levels of customization that match our [Catppuccin
Style Guide][style-guide]. To add these customizations, add any of the following
options to your Tmux configuration.

##### Enable window tabs

By default, the theme places the `window-status` in the `status-right`. With
`@catppuccin_window_tabs_enabled` set to `on`, the theme will place the
directory within the `status-right` and move the window names to the
`window-status` format variables.

```sh
set -g @catppuccin_window_tabs_enabled on # or off to disable window_tabs
```

[style-guide]: https://github.com/catppuccin/catppuccin/blob/main/docs/style-guide.md

## 💝 Thanks to

- [Pocco81](https://github.com/catppuccin)
- [vinnyA3](https://github.com/vinnyA3)
- [rogeruiz](https://github.com/rogeruiz)

&nbsp;

<p align="center"><img src="https://raw.githubusercontent.com/catppuccin/catppuccin/main/assets/footers/gray0_ctp_on_line.svg?sanitize=true" /></p>
<p align="center">Copyright &copy; 2021-present <a href="https://github.com/catppuccin" target="_blank">Catppuccin Org</a>
<p align="center"><a href="https://github.com/catppuccin/catppuccin/blob/main/LICENSE"><img src="https://img.shields.io/static/v1.svg?style=for-the-badge&label=License&message=MIT&logoColor=d9e0ee&colorA=363a4f&colorB=b7bdf8"/></a></p>
