DOTFILES

Stow links files from a package into a target folder.
The folders inside each package become folders in the target.

HOME CONFIGS

Run inside the repo:

  stow --target="$HOME" xdefaults memes

This installs .Xdefaults and the meme in ~/Pictures/memes/.
Stow creates missing folders and stops if a target conflicts.

To undo:

  stow --delete --target="$HOME" xdefaults memes

SYSTEM-WIDE CONFIGS

System-wide files go in a package that mirrors paths from /.
For example, xorg/etc/X11/... maps to /etc/X11/....
Install or remove it with:

  sudo stow --target=/ xorg
  sudo stow --delete --target=/ xorg
