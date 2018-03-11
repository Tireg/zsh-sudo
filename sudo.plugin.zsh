# ------------------------------------------------------------------------------
#          FILE:  sudo.plugin.zsh
#   DESCRIPTION:  Insert sudo or sudoedit before command
#        AUTHOR:  Tireg
#   INSPIRED BY:  https://github.com/hcgraf/zsh-sudo/blob/master/sudo.plugin.zsh
#          FROM:    Dongweiming <ciici123@gmail.com>
#                   Hagen Graf - added vicmd binding
#       VERSION:  1.0.0
# ------------------------------------------------------------------------------

# Define a behavior
_sudo_zle_handler() {

	# Dynamically detect whether to use sudoedit
	local sudoedit_state;
	zstyle -s ':tireg:module:sudo' sudoedit sudoedit_state;

	(( $+commands[sudoedit] )) \
		&& [[ "${sudoedit_state}" != 'disable' ]] \
		&& use_sudoedit="true";

	# If current buffer is empty, get last command in history
    [ -z ${BUFFER} ] && zle up-history;

	# Check into buffer for any sudo-like prefix
	case "${BUFFER}" in
		'sudo '*)
			LBUFFER="${LBUFFER#sudo }";
			;;
		"${EDITOR} "* )
			LBUFFER="${${use_sudoedit:+sudoedit}:-sudo} ${LBUFFER#${use_sudoedit:+${EDITOR} }}";
			;;
		"sudoedit "* )
			LBUFFER="${EDITOR} ${LBUFFER#sudoedit }";
			;;
		* )
			LBUFFER="sudo ${LBUFFER}";
			;;
	esac;

}

# Use this behavior as a zle widget
zle -N _sudo_zle_handler;

# Retrieve user config
zstyle -s ':tireg:module:sudo' keys binding_keys;

# Defined shortcut keys: [Esc] [Esc] by default
bindkey "${binding_keys:-\e\e}" _sudo_zle_handler            # Normal / emacs mode
bindkey -M vicmd "${binding_keys:-\e\e}" _sudo_zle_handler   # Vim mode
