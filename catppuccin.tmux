#!/usr/bin/env bash
PLUGIN_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

main() {
  get-tmux-option() {
    local option value default
    option="$1"
    default="$2"
    value="$(tmux show-option -gqv "$option")"

    if [ -n "$value" ]; then
      echo "$value"
    else
      echo "$default"
    fi
  }

  set() {
    local option=$1
    local value=$2
    tmux set-option -gq "$option" "$value"
  }

  setw() {
    local option=$1
    local value=$2
    tmux set-window-option -gq "$option" "$value"
  }

  local theme
  theme="$(get-tmux-option "@catppuccin_flavour" "mocha")"

  # NOTE: Pulling in the selected theme by the theme that's being set as local
  # variables.
  sed -E 's/^(.+=)/local \1/' \
      > "${PLUGIN_DIR}/catppuccin-selected-theme.tmuxtheme" \
      < "${PLUGIN_DIR}/catppuccin-${theme}.tmuxtheme"

  source "${PLUGIN_DIR}/catppuccin-selected-theme.tmuxtheme"

  # status
  set status "on"
  set status-bg "${thm_bg}"
  set status-justify "centre"
  set status-left-length "100"
  set status-right-length "100"

  # messages
  set message-style "fg=${thm_cyan},bg=${thm_gray},align=centre"
  set message-command-style "fg=${thm_cyan},bg=${thm_gray},align=centre"

  # panes
  set pane-border-style "fg=${thm_gray}"
  set pane-active-border-style "fg=${thm_blue}"

  # windows
  setw window-status-activity-style "fg=${thm_fg},bg=${thm_bg},none"
  setw window-status-separator ""
  setw window-status-style "fg=${thm_fg},bg=${thm_bg},none"

  # --------=== Statusline

  # NOTE: Checking for the value of @catppuccin_window_tabs_enabled
  wt_enabled="$(get-tmux-option "@catppuccin_window_tabs_enabled" "off")"
  readonly wt_enabled

  # These variables are the defaults so that the setw and set calls are easier to parse.
  readonly show_directory="#[fg=$thm_pink,bg=$thm_bg,nobold,nounderscore,noitalics]#[fg=$thm_bg,bg=$thm_pink,nobold,nounderscore,noitalics]  #[fg=$thm_fg,bg=$thm_gray] #{b:pane_current_path} #{?client_prefix,#[fg=$thm_red]"
  readonly show_window="#[fg=$thm_pink,bg=$thm_bg,nobold,nounderscore,noitalics]#[fg=$thm_bg,bg=$thm_pink,nobold,nounderscore,noitalics] #[fg=$thm_fg,bg=$thm_gray] #W #{?client_prefix,#[fg=$thm_red]"
  readonly show_session="#[fg=$thm_green]}#[bg=$thm_gray]#{?client_prefix,#[bg=$thm_red],#[bg=$thm_green]}#[fg=$thm_bg] #[fg=$thm_fg,bg=$thm_gray] #S "
  readonly show_directory_in_window_status="#[fg=$thm_bg,bg=$thm_blue] #I #[fg=$thm_fg,bg=$thm_gray] #{b:pane_current_path} "
  readonly show_directory_in_window_status_current="#[fg=$thm_bg,bg=$thm_orange] #I #[fg=$thm_fg,bg=$thm_bg] #{b:pane_current_path} "
  readonly show_window_in_window_status="#[fg=$thm_fg,bg=$thm_bg] #W #[fg=$thm_bg,bg=$thm_blue] #I#[fg=$thm_blue,bg=$thm_bg]#[fg=$thm_fg,bg=$thm_bg,nobold,nounderscore,noitalics] "
  readonly show_window_in_window_status_current="#[fg=$thm_fg,bg=$thm_gray] #W #[fg=$thm_bg,bg=$thm_orange] #I#[fg=$thm_orange,bg=$thm_bg]#[fg=$thm_fg,bg=$thm_bg,nobold,nounderscore,noitalics] "

  #readonly show_mode_indicator="#{?client_prefix,#[fg=$thm_red],#[fg=$thm_green]}#{?client_prefix,#[bg=$thm_red],#[bg=$thm_green]}#[fg=$thm_gray]#{?client_prefix,#[fg=$thm_red],#[fg=$thm_green]}#[bg=$thm_bg]"
  readonly show_mode_indicator="#{?client_prefix,#[fg=$thm_cyan],#[fg=$thm_bg]}#{?client_prefix,#[fg=$thm_gray]#[bg=$thm_cyan],#[fg=$thm_fg]#[bg=$thm_bg]}#{?client_prefix,#[fg=$thm_cyan],#[fg=$thm_bg]}#[bg=$thm_bg]"

  # Really basic, but buttons
  #readonly show_window_status="#[fg=$thm_gray,bg=$thm_bg]#[fg=$thm_fg,bg=$thm_gray]#W#[fg=$thm_gray,bg=$thm_bg] "
  #readonly show_current_window_status="#[bg=$thm_blue,fg=$thm_bg]#[bg=$thm_gray,fg=$thm_blue,bold]#I#W#[bg=$thm_blue,fg=$thm_bg,nobold] "

  # Buttons with separator
  readonly show_window_status="#[fg=$thm_gray,bg=$thm_bg] #[fg=$thm_fg,bg=$thm_gray]#I#[fg=$thm_fg,bg=$thm_gray]#[fg=$thm_fg,bg=$thm_gray]#W#[fg=$thm_gray,bg=$thm_bg,nobold] "
  readonly show_current_window_status="#[bg=$thm_blue,fg=$thm_bg] #[bg=$thm_gray,fg=$thm_blue,bold]#I#[bg=$thm_gray,fg=$thm_blue]#[bg=$thm_gray,fg=$thm_blue]#W#[bg=$thm_blue,fg=$thm_bg,nobold] "

  # Slanted buttons - Look best, but separator for non-active looks bad
  #readonly show_window_status="#[fg=$thm_gray,bg=$thm_bg]#[fg=$thm_fg,bg=$thm_gray]#I #[fg=$thm_bg,bg=$thm_gray]#[fg=$thm_fg,bg=$thm_gray]#W#[fg=$thm_gray,bg=$thm_bg,nobold] "
  #readonly show_current_window_status="#[bg=$thm_gray,fg=$thm_bg]#[bg=$thm_blue,fg=$thm_gray,nobold]#I #[bg=$thm_blue,fg=$thm_gray]#[bg=$thm_gray,fg=$thm_blue,bold]#W#[bg=$thm_blue,fg=$thm_bg,nobold] "

  # Right column 1 by default shows the Window name.
  local right_column1=$show_window

  # Right column 2 by default shows the current Session name.
  local right_column2=$show_session

  # Window status by default shows the current directory basename.
  local window_status_format=$show_directory_in_window_status
  #local window_status_format=$show_window_in_window_status
  local window_status_current_format=$show_directory_in_window_status_current
  #local window_status_current_format=$show_window_in_window_status_current

  # NOTE: With the @catppuccin_window_tabs_enabled set to on, we're going to
  # update the right_column1 and the window_status_* variables.
  if [[ "${wt_enabled}" == "on" ]]
  then
    right_column1=$show_directory
    window_status_format=$show_window_in_window_status
    window_status_current_format=$show_window_in_window_status_current
  fi

  #set status-left ""
  set status-left "${show_mode_indicator}"

  #set status-right "${right_column1},${right_column2}"
  set status-right ""

  #setw window-status-format "${window_status_format}"
  setw window-status-format "${show_window_status}"
  #setw window-status-format ""

  #setw window-status-current-format "${window_status_current_format}"
  setw window-status-current-format "${show_current_window_status}"
  #setw window-status-current-format ""

  # --------=== Modes
  #
  setw clock-mode-colour "${thm_blue}"
  setw mode-style "fg=${thm_pink} bg=${thm_black4} bold"
}

main "$@"
