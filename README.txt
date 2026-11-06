DOTFILES

Stow links files from a package into a target folder.

HOME CONFIGS

Run inside the repo:

  stow --no-folding --target="$HOME" xdefaults
  stow --no-folding --target="$HOME" memes
  stow --no-folding --target="$HOME" ksh

This installs .Xdefaults, the meme in ~/Pictures/memes/, and ~/.kshrc.
Stow creates missing folders and stops if a target conflicts.
Use --no-folding to keep new folders real, not symlinks.

To undo:

  stow --no-folding --delete --target="$HOME" xdefaults
  stow --no-folding --delete --target="$HOME" memes
  stow --no-folding --delete --target="$HOME" ksh

SYSTEM-WIDE CONFIGS

System-wide files go in a package that mirrors paths from /.
For example, xorg/etc/X11/... maps to /etc/X11/....
Install or remove it with:

  sudo stow --no-folding --target=/ xorg
  sudo stow --no-folding --delete --target=/ xorg
