DOTFILES

Stow symlinks files from a package into a target folder.

HOME CONFIGS

Run inside the repo:

  stow --no-folding --target="$HOME" <package>

To undo:

  stow --no-folding --delete --target="$HOME" <package>

SYSTEM-WIDE CONFIGS

  sudo stow --no-folding --target=/ <package>
  sudo stow --no-folding --delete --target=/ <package>
