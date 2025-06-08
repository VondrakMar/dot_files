;; Don't show the splash screen
(setq inhibit-startup-message t
      visible-bell nil) ; flashes when I cannot do anything

;; Require and initialize package.
(require 'package)
(package-initialize)

;; where to save custom values, so it is not makeing a mess of my init.el file
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

;; Add melpa to package-archives.
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; (package-refresh-contents)

(when (not (package-installed-p 'use-package))
  (package-refresh-contents)
  (package-install 'use-package))

;; Disable tool bar, menu bar, scroll bar.
(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 1)
(setq column-number-mode t)
(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode 1)
;; My themes
;; (use-package modus-themes
  ;; :config
  ;; (load-theme 'modus-vivendi t))
;; (load-theme 'doom-Iosvkem t)
;; (load-theme 'modus-vivendi t)
(load-theme 'gruber-darker)


(setq-default indent-tabs-mode t)
(setq x-stretch-cursor t)
(setq tab-width 4)
(setq-default c-basic-offset 4
              c-default-style '((awk-mode . "awk")))
(setq-default inhibit-splash-screen t
              make-backup-files nil
              tab-width 4
              indent-tabs-mode nil
              compilation-scroll-output t)
(global-set-key (kbd "C-c i m") 'imenu)
;; Keep recent files in buffer, I do not like it, so I am keeping it here commented out
;; (use-package recentf
;;   :config
;;   (setq recentf-auto-cleanup 'never
;;         recentf-max-saved-items 1000
;;         recentf-save-file (concat user-emacs-directory ".recentf"))
;;   (recentf-mode t)
;;   :diminish nil)

(add-hook 'after-init-hook 'global-company-mode)
(setq company-idle-delay 0)
(setq company-minimum-prefix-length 1)


;; Display possible completions at all places (this is not meant as writing a code, but autocomplition for writing a buffer name e.g.)
(use-package ido-completing-read+
 :ensure t
 :config
 ;; This enables ido in all contexts where it could be useful, not just
 ;; for selecting buffer and file names
 (ido-mode t)
 (ido-everywhere t)
 (ido-ubiquitous-mode 1))
 ;; This allows partial matches, e.g. "uzh" will match "Ustad Zakir Hussain"
 ;; (setq ido-enable-flex-matching t)
 ;; (setq ido-use-filename-at-point nil)
 ;; (setq magit-completing-read-function 'magit-ido-completing-read)
 ;; Includes buffer names of recently opened files, even if they're not open now.
 ;;(setq ido-use-virtual-buffers nil)
 ;; :diminish nil)

;; (setq history-length 25)
(setq history-length t) 		; if there is no limit in history
(savehist-mode -1)
(save-place-mode 1)


(defun move-line (n)
  "Move the current line up or down by N lines."
  (interactive "p")
  (setq col (current-column))
  (beginning-of-line) (setq start (point))
  (end-of-line) (forward-char) (setq end (point))
  (let ((line-text (delete-and-extract-region start end)))
    (forward-line n)
    (insert line-text)
    ;; restore point to original column in moved line
    (forward-line -1)
    (forward-char col)))

(defun move-line-up (n)
  "Move the current line up by N lines."
  (interactive "p")
  (move-line (if (null n) -1 (- n))))

(defun move-line-down (n)
  "Move the current line down by N lines."
  (interactive "p")
  (move-line (if (null n) 1 n)))

(global-set-key (kbd "M-<up>") 'move-line-up)
(global-set-key (kbd "M-<down>") 'move-line-down)

(require 'rust-mode)
(add-hook 'rust-mode-hook
          (lambda () (setq indent-tabs-mode nil)))

(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))
;;  :config 
;;  (setq flycheck-python-pylint-executable "pylint")
;;  (setq flycheck-python-pylint-args '("--errors-only")))

(use-package julia-mode
  :ensure t)

(require 'multiple-cursors)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->")         'mc/mark-next-like-this)
(global-set-key (kbd "C-<")         'mc/mark-previous-like-this)
(global-set-key (kbd "C-\"")        'mc/skip-to-next-like-this)
(global-set-key (kbd "C-:")         'mc/skip-to-previous-like-this)
(global-set-key (kbd "C-c C->")     'mc/mark-next-like-this-word)
(global-set-key (kbd "C-c C-<")     'mc/mark-next-like-this-symbol)


;; Helper for compilation. Close the compilation window if
;; there was no error at all. (emacs wiki)
;; (defun compilation-exit-autoclose (status code msg)
  ;; If M-x compile exists with a 0
  ;; (when (and (eq status 'exit) (zerop code))
    ;; then bury the *compilation* buffer, so that C-x b doesn't go there
    ;; (bury-buffer)
    ;; and delete the *compilation* window
    ;; (delete-window (get-buffer-window (get-buffer "*compilation*"))))
  ;; Always return the anticipated result of compilation-exit-message-function
  ;; (cons msg code))
;; Specify my function (maybe I should have done a lambda function)
;; (setq compilation-exit-message-function 'compilation-exit-autocloe)
