declare-option -hidden bool fcitx_was_on false

define-command fcitx-turn-on %{ %sh{ fcitx-remote -o }}

define-command fcitx-turn-off %{ %sh{ fcitx-remote -c }}

define-command -hidden fcitx-turn-off-with-state %{ %sh{
	state=`fcitx-remote`
	if [ $state -eq 2 ] ; then
		echo 'set-option global fcitx_was_on true'
	else
		echo 'set-option global fcitx_was_on false'
	fi
	echo 'fcitx-turn-off'
}}

define-command -hidden fcitx-restore-state %{ %sh{
	[ $kak_opt_fcitx_was_on = true ] && echo 'fcitx-turn-on'
}}

define-command -docstring 'Turn off fcitx when you go back normal mode.
Turn on fcitx when you enter insert mode,
if it was on when you left insert mode last time.
To use this feature correctly, you should set option \'fcitx_on\'' \
setup-fcitx-auto-switch %{
	remove-hooks global fcitx
	hook -group fcitx global ModeChange insert:normal %{ fcitx-turn-off-with-state }
	hook -group fcitx global ModeChange normal:insert %{ fcitx-restore-state }
	hook -group fcitx global ModeChange prompt:normal %{ fcitx-turn-off }
}

define-command -docstring 'turn off fcitx when you go back normal mode.' \
setup-fcitx-auto-off %{
	remove-hooks global fcitx
	hook -group fcitx global ModeChange insert:normal %{ fcitx-turn-off }
	hook -group fcitx global ModeChange prompt:normal %{ fcitx-turn-off }
}
