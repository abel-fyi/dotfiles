;;; Interface

;; Start with an empty scratch buffer.
(setq inhibit-startup-screen t
      initial-scratch-message nil)

;; Relative line numbers and current column.
(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode 1)
(column-number-mode 1)

;; Subtle line highlighting, limited to the text.
(global-hl-line-mode 1)
(set-face-attribute 'hl-line nil :background "gray15" :extend nil)

;; Hide the menu bar; F9 toggles it, F10 opens it.
(menu-bar-mode -1)
(global-set-key (kbd "<f9>") #'menu-bar-mode)

;; Hide line continuation indicators.
(unless standard-display-table
  (setq standard-display-table (make-display-table)))
(set-display-table-slot standard-display-table 'wrap ?\s)


;;; Editing

(setq-default indent-tabs-mode nil
              show-trailing-whitespace t)

(delete-selection-mode 1)
(setq scroll-conservatively 101)


;;; Files

;; Keep backups and auto-saves out of working directories.
(let ((dir (expand-file-name "backups/" user-emacs-directory)))
  (make-directory dir t)
  (setq backup-directory-alist `(("." . ,dir))))

(let ((dir (expand-file-name "auto-saves/" user-emacs-directory)))
  (make-directory dir t)
  (setq auto-save-file-name-transforms `((".*" ,dir t))))

(global-auto-revert-mode 1)


;;; Navigation & Persistence

(save-place-mode 1)
(savehist-mode 1)
(recentf-mode 1)

(setq use-short-answers t)
(fido-vertical-mode 1)
(winner-mode 1)

;;; .emacs ends here
