# virtualenv-autodetect.plugin.zsh
#
# Installation:
# Add this line to your .zshenv
#
# source /path/to/virtualenv-autodetect.plugin.zsh

SCRIPT_DIR=${0:a:h}

. $SCRIPT_DIR/virtualenv-autodetect-lib.sh

# Activate on directory change.
# Zsh.
chpwd_functions+=(_virtualenv_auto_activate)