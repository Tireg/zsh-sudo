# ZSH sudo plugin

Forked from https://github.com/hcgraf/zsh-sudo

This plugin toggles "sudo" before the current/previous command
by pressing keys in emacs-mode or vi-command mode.


## Installation

You can use this plugin using zplug :

```bash
zplug "Tireg/zsh-sudo", if:"(( $+commands[sudo] ))";
```


## Requirements

Unlike [`sudo`](https://github.com/robbyrussell/oh-my-zsh/tree/master/plugins/sudo) plugin
from [`oh-my-zsh`](https://github.com/robbyrussell/oh-my-zsh), this one
doesn't requires sudoedit. It will instead auto-detect sudoedit and
use it if available.

If you wish not to use sudoedit, you can configure it using :

```bash
zstyle ':tireg:module:sudo' sudoedit 'disable';
```


## Configuration

You can configure it using :

```bash
zstyle ':tireg:module:sudo' keys '<keycodes>'
```

Default value is [ESC][ESC]

```bash
zstyle ':tireg:module:sudo' keys '\e\e'
```
