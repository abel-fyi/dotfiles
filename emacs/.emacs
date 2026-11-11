;;; .emacs --- Just a few fixes to Emacs defaults -*- lexical-binding: t; -*-

;;; Startup & Interface

;; Start directly in an empty *scratch* buffer.
(setq inhibit-startup-screen t)
(setq initial-scratch-message nil)

;; Display relative line numbers.
(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode 1)

;; Show the current column number in the mode line.
(column-number-mode 1)

;; Optionally hide the menu bar when comfortable without it.
;; (menu-bar-mode -1)


;;; Editing

;; Prefer spaces for indentation; major modes may override this.
(setq-default indent-tabs-mode nil)

;; Highlight trailing whitespace without removing it automatically.
;; Use M-x delete-trailing-whitespace to clean it manually.
(setq-default show-trailing-whitespace t)

;; Replace selected text when typing.
(delete-selection-mode 1)

;; Scroll just enough to keep the cursor visible.
(setq scroll-conservatively 101)


;;; Files & Backups

;; Keep backup files, but store them away from working directories.
(let ((dir (expand-file-name "backups/" user-emacs-directory)))
  (make-directory dir t)
  (setq backup-directory-alist `(("." . ,dir))))

;; Keep auto-save recovery files in a separate directory.
(let ((dir (expand-file-name "auto-saves/" user-emacs-directory)))
  (make-directory dir t)
  (setq auto-save-file-name-transforms `((".*" ,dir t))))

;; Automatically refresh buffers when files change on disk.
(global-auto-revert-mode 1)


;;; Persistence

;; Remember useful information between Emacs sessions.
(save-place-mode 1)   ;; Cursor positions in files.
(savehist-mode 1)     ;; Minibuffer history.
(recentf-mode 1)      ;; Recently visited files.


;;; Navigation & Completion

;; Accept y/n instead of requiring yes/no.
(setq use-short-answers t)

;; Show interactive, fuzzy completion candidates vertically.
(fido-vertical-mode 1)

;; Undo and redo window layout changes with C-c <left> and C-c <right>.
(winner-mode 1)


;;; .emacs ends here
