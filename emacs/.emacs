;; -*- lexical-binding: t; -*-

;;; Interface

(setq inhibit-startup-screen t
      initial-scratch-message nil
      use-short-answers t
      display-line-numbers-type 'relative
      scroll-conservatively 101)

(menu-bar-mode -1)

;; Underline the current line without highlighting.
(global-hl-line-mode 1)
(set-face-attribute 'hl-line nil
		    :inherit nil
		    :underline t
		    :extend nil)

;; Relative line numbers in programming buffers.
(add-hook 'prog-mode-hook #'display-line-numbers-mode)

(set-face-attribute 'line-number nil :foreground "yellow")
(set-face-attribute 'line-number-current-line nil
		    :foreground "yellow" :weight 'bold)

;; Hide line continuation indicators.
(unless standard-display-table
  (setq standard-display-table (make-display-table)))
(set-display-table-slot standard-display-table 'wrap ?\s)

;;; Editing

(setq-default show-trailing-whitespace t)

;;; Files

(let ((dir (expand-file-name "var/" user-emacs-directory)))
  (make-directory dir t)
  (setq backup-directory-alist `(("." . ,dir))
	auto-save-file-name-transforms `((".*" ,dir sha1))
	lock-file-name-transforms `((".*" ,dir sha1))))

;;; C programming

(add-hook 'c-mode-hook #'eglot-ensure)

;;; Diagnostics & documentation

(setq flymake-show-diagnostics-at-end-of-line 'short
      eldoc-echo-area-use-multiline-p nil)

;;; Completion

(use-package corfu
  :ensure t
  :hook (c-mode . corfu-mode)
  :custom
  (corfu-auto t)
  (corfu-auto-prefix 1)
  (corfu-auto-delay 0.2)
  (corfu-cycle t)
  (corfu-preselect 'prompt)
  (corfu-preview-current nil)
  :bind (:map corfu-map
	      ("TAB" . corfu-next)
	      ([tab] . corfu-next)
	      ("S-TAB" . corfu-previous)
	      ([backtab] . corfu-previous)))

;;; .emacs ends here
