# virtualenv-autodetect.sh
#
# Installation:
# Add this line to your .bashrc or .bash-profile:
#
# source /path/to/virtualenv-autodetect.sh

# https://github.com/egilewski/virtualenv-autodetect

SCRIPT_DIR=$(dirname ${BASH_SOURCE[0]})

. $SCRIPT_DIR/virtualenv-autodetect-lib.sh

# Execute given function if directory changed.
# Unlike in Zsh's "chpwd_functions" won't work with "cd .".
_bash_chpwd_function() {
    if [ "$PWD" != "$_myoldpwd" ]
    then
        _myoldpwd="$PWD";
        $1
    fi
}

# Bash.
export PROMPT_COMMAND="_bash_chpwd_function _virtualenv_auto_activate"
