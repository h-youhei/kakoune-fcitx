# fcitx controller for Kakoune
## Feature
Turn off fcitx when you go back normal mode.

If you want, restore fcitx state when you re-enter insert mode.

## Install
clone this repository, symlink fcitx.kak to your autoload directory.

write `setup-fcitx-fcitx-switch` or `setup-fcitx-auto-off` in your kakrc.

`setup-fcitx-auto-off` do only turn off.

`setup-fcitx-auto-switch` do both turn off and restore.
