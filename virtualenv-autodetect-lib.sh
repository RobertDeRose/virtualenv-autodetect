# virtualenv-autodetect-lib.sh
#
# File containning all generic functions used by the plugin


_virtualenv_auto_activate() {
    _virtualenv_path=$(_get_virtualenv_path)
    if [ -e "$_virtualenv_path" ]
    then
        # Check if already activated to avoid redundant activation.
        if [ "$VIRTUAL_ENV" != "${_virtualenv_path%/bin/activate}" ]
        then
            _remove_from_pythonpath     # Remove any previous VE path
            source "$_virtualenv_path"
            _add_to_pythonpath "$VIRTUAL_ENV"
        fi
    else
        _remove_from_pythonpath
        deactivate 2>/dev/null
    fi
}

_add_to_pythonpath() {
    sp=$(find $1 -type d -name 'site-packages')
    export PYTHONPATH=$(echo $PYTHONPATH${PYTHONPATH:+:}$sp | tr : "\n" | sort -u | tr "\n" : | sed -e 's/:$//')
}

_remove_from_pythonpath() {
    if [ -n "$VIRTUAL_ENV" ]; then
        export PYTHONPATH=$(echo $PYTHONPATH | tr : "\n" | grep -v "$VIRTUAL_ENV" | tr "\n" : | sed -e 's/:$//')
    fi
}

# Get absolute path to virtualenv dir in current dir or one of it's parents.
_get_virtualenv_path() {
    # Find subdir of given one that is a virtualenv dir.
    _find_virtualenv_subdir() {
        result=$(find $1 -maxdepth 2 -type d -name 'bin' -exec find {} -name 'activate' \; 2> /dev/null)
        if [ -n "$result" ]; then
            if [ -n "$(head -1 $result | grep "source bin/activate" 2> /dev/null)" ]; then
                echo $result
            fi
        fi
    }

    _current_dir="$PWD"
    while true
    do
        _virtualenv_subdir=$(_find_virtualenv_subdir "$_current_dir")
        if [ -n "$_virtualenv_subdir" ]
        then
            echo "$_virtualenv_subdir"
            return
        else
            if [[ "$_current_dir" != "/" ]]
            then
                _current_dir=`dirname "$_current_dir"`
            else
                return
            fi
        fi
    done
}

# Before activation remove VIRTUAL_ENV from inherited env.
unset VIRTUAL_ENV

# Activate on shell start.
_virtualenv_auto_activate