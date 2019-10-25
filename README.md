# virtualenv-autodetect

Makes you forget that you have virtualenv's (if you use cd). Works in Zsh and Bash.

## Installation

You can source one of the files in the project or you can use a plugin manager like ZPlug.

### Bash

Add this line to your .bashrc or .bash-profile:

```sh
source /path/to/virtualenv-autodetect.sh
```

### Zsh

Add this line to your .zshenv

```sh
source /path/to/virtualenv-autodetect.plugin.zsh
```

Or use a plugin manager, for instance, with ZPlug, you can add this line to your `.zshrc`:

```sh
zplug "RobertDeRose/virtualenv-autodetect"
```

## Notes

Virtualenv will be activated automatically when you enter the
directory or it's descendant of any depth.

Active virtualenv will be replaced with deeper one on changing dir to it.

Virtualenv will be deactivated automatically upon changing dir to one
that has no parent virtualenv.

Virtualenv directory is detected automatically by bin/activate inside it.

Venv prefix won't be shown as it's not needed any more (for me at least).

Works in Zsh and Bash.

Inspired and faintly based on https://gist.github.com/2211471

### Note on ZPlug

With ZPlug you can `deffer` the initialization of certain plugins.
When you do for a plugin that alter your prompt (usually a theme), the
prompt setup may happen _after_ the virtual env is initializated.

When it does, all the prompt configuration done by virtualenv is lost,
and when you deactivate the virtualenv, it tries to restore the old
prompt, which, in this case, is the prompt defined before you have
applied the shell theme.

If you face this issue, make sure to add the following as the very last
line on your `.zshrc` file:

```sh
zplug_virtualenv_validate
```
