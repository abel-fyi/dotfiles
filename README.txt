DOTFILES

Stow links files from a package into your home folder.
The folders inside each package become folders in your home.

INSTALL

Run inside the repo:

  stow --target="$HOME" */

This installs every package folder, including xdefaults and memes.
Stow creates missing folders and stops if a target conflicts.

To undo all packages:

  stow --delete --target="$HOME" */
