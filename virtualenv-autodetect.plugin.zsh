# virtualenv-autodetect.plugin.zsh
#
# Installation:
# Add this line to your .zshenv
#
# source /path/to/virtualenv-autodetect.plugin.zsh

SCRIPT_DIR=${0:a:h}

. $SCRIPT_DIR/virtualenv-autodetect-lib.sh

# Fix for the wrong $PS1 when the shell starts with a virtualenv already
# activated when using ZPlug.
#
# With ZPlug you can `deffer` the initialization of certain plugins.
# When you do for a plugin that alter your prompt (usually a theme), the
# prompt setup may happen _after_ the virtual env is initializated. When
# it does, all the prompt configuration done by virtualenv is lost, and
# when you deactivate the virtualenv, it tries to restore the old
# prompt, which, in this case, is the prompt defined before you have
# applied the shell theme.
#
# If you face such problem, call the following function in the end of
# your .zshrc to guarantee that your prompt will reflect the correct
# state.
zplug_virtualenv_validate() {
    if [ -n "${VIRTUAL_ENV:-}" ]; then
        _OLD_VIRTUAL_PS1="${PS1:-}"
        _OLD_VIRTUAL_PATH="${PATH}"
        _OLD_VIRTUAL_PYTHONHOME="${PYTHONHOME:-}"

        if [ "`basename \"${VIRTUAL_ENV}\"`" = "__" ] ; then
            # special case for Aspen magic directories
            # see http://www.zetadev.com/software/aspen/
            PS1="[`basename \`dirname \"${VIRTUAL_ENV}\"\``] ${PS1}"
        else
            PS1="(`basename \"${VIRTUAL_ENV}\"`) ${PS1}"
        fi
        export PS1
    fi
}

# Activate on directory change.
# Zsh.
chpwd_functions+=(_virtualenv_auto_activate)