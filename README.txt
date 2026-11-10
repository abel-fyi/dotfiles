DOTFILES

Stow links files from a package into a target folder.

HOME CONFIGS

Run inside the repo:

  stow --no-folding --target="$HOME" xdefaults
  stow --no-folding --target="$HOME" pictures
  stow --no-folding --target="$HOME" ksh
  stow --no-folding --target="$HOME" cwm

This installs .Xdefaults, ~/Pictures/, ~/.kshrc,
and ~/.cwmrc.
Stow creates missing folders and stops if a target conflicts.
Use --no-folding to keep new folders real, not symlinks.

To undo:

  stow --no-folding --delete --target="$HOME" xdefaults
  stow --no-folding --delete --target="$HOME" pictures
  stow --no-folding --delete --target="$HOME" ksh
  stow --no-folding --delete --target="$HOME" cwm

SYSTEM-WIDE CONFIGS

System-wide files go in a package that mirrors paths from /.
For example, xorg/etc/X11/... maps to /etc/X11/....
Install or remove it with:

  sudo stow --no-folding --target=/ xorg
  sudo stow --no-folding --delete --target=/ xorg
