;; package config
(require 'package)

(add-to-list 'package-archives
  '("marmalade" . "http://marmalade-repo.org/packages/") t)

(require 'package) ;; You might already have this line
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))

(package-initialize) ;; You might already have this line

;; any custom packages (things that can't be downloaded from melpa etc) can
;; be placed here any manually required
(add-to-list 'load-path "~/.emacs.d/custom/")

;; basic stuff
(setq-default tab-width 2)
(setq require-final-newline 't)
(setq column-number-mode t)
(global-auto-revert-mode 1)

(setq-default indent-tabs-mode nil)

(setq-default fill-column 76)

;; disable backup
(setq backup-inhibited t)

;; disable auto save
(setq auto-save-default nil)

;; show trailing whitespace
(setq-default show-trailing-whitespace t)

;; delete trailing whitespace on save
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; key bindings
(global-set-key (kbd "C-c r") 'revert-buffer)

;; this works, always saves
(defadvice save-buffer (before save-buffer-always activate)
  "always save buffer"
  (set-buffer-modified-p t))

;;(display-graphic-p &optional DISPLAY
(unless window-system
    ;; hide the menu bar
    (menu-bar-mode -1)
    )

(load-theme 'atom-dark t)

;; projectile package - see https://github.com/bbatsov/projectile
(projectile-global-mode)
(projectile-mode t)
(setq projectile-enable-caching t)

;; company package - see http://company-mode.github.io
(add-hook 'after-init-hook 'global-company-mode)

;; mac key bindings
(when (eq system-type 'darwin)
    (setq mac-command-modifier 'meta)
    (global-set-key [kp-delete] 'delete-char) ;; sets fn-delete to be right-delete
    )

(add-hook 'cc-mode-hook
		  (setq tab-width 4)
      (setq indent-tabs-mode 'nil)
		  )

(add-to-list 'auto-mode-alist '("\\.scss\\'" . scss-mode))
(add-hook 'scss-mode-hook
          (setq tab-width 2)
          )

(setq gofmt-command "goimports")
(add-hook 'before-save-hook 'gofmt-before-save)

(add-hook 'python-mode-hook
          (setq indent-tabs-mode nil)
          (setq tab-width 4)
          )

;; (add-hook 'javascript-mode-hook
;;           (setq indent-tabs-mode nil)
;;           (setq tab-width 4)
;;           )
(add-hook 'javascript-mode-hook
          (lambda ()
            (setq indent-tabs-mode nil)
            (tab-width 2)
            (js-indent-level 2)))

;; (add-hook 'javascript-mode-hook 'my-javascript-mode-hook)
(add-to-list 'auto-mode-alist '("\\.babelrc\\'" . javascript-mode))

;; See http://web-mode.org/
;; (require 'web-mode)
;; (add-to-list 'auto-mode-alist '("\\.jsx?$" . web-mode))

(add-to-list 'auto-mode-alist '("\\.jsx?$" . js-jsx-mode))

(setq web-mode-markup-indent-offset 2
      web-mode-css-indent-offset 2
      web-mode-code-indent-offset 2)

(setq js-indent-level 2)

(add-hook 'go-mode-hook
          (lambda ()
            (setq-default)
            (setq tab-width 4)
            (setq standard-indent 4)
            (setq indent-tabs-mode nil)))

;; load company-go which uses gocode (must already be running)
(add-hook 'go-mode-hook 'company-mode)
(add-hook 'go-mode-hook (lambda ()
                          (set (make-local-variable 'company-backends) '(company-go))
                            (company-mode)))

;; (require 'go-eldoc) ;; Don't need to require, if you install by package.el
(add-hook 'go-mode-hook 'go-eldoc-setup)
(add-hook 'go-mode-hook (lambda ()
                          (local-set-key (kbd "M-.") 'godef-jump)))

(defun my-go-mode-hook ()
  (load-file (concat (getenv "HOME") "/.emacs.d/custom/go-rename.el"))
  )

(add-hook 'go-mode-hook 'my-go-mode-hook)

;; from http://emacsredux.com/blog/2013/03/30/kill-other-buffers/
(defun kill-other-buffers ()
  "Kill all buffers but the current one.
Don't mess with special buffers."
  (interactive)
  (dolist (buffer (buffer-list))
    (unless (or (eql buffer (current-buffer)) (not (buffer-file-name buffer)))
      (kill-buffer buffer))))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(coffee-tab-width 2)
 '(custom-safe-themes
   (quote
    ("a1289424bbc0e9f9877aa2c9a03c7dfd2835ea51d8781a0bf9e2415101f70a7e" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "54ece5659cc7acdcd529dddd78675c2972a5ac69260af4a6aec517dcea16208b" "135bbd2e531f067ed6a25287a47e490ea5ae40b7008211c70385022dbab3ab2a" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" "a27c00821ccfd5a78b01e4f35dc056706dd9ede09a8b90c6955ae6a390eb1c1e" default)))
 '(package-selected-packages
   (quote
    (exec-path-from-shell js2-mode yaml-mode web-mode scss-mode ruby-hash-syntax robe python-mode projectile-rails markdown-mode lua-mode json-reformat jinja2-mode haml-mode go-projectile company-go autopair atom-one-dark-theme atom-dark-theme))))

(defadvice inf-ruby-console-auto (before activate-rvm-for-robe activate)
  (rvm-activate-corresponding-ruby))

(add-hook 'ruby-mode-hook 'robe-mode)
;; (add-hook 'ruby-mode-hook 'projectile-rails-mode)

;; autopair brackets
(require 'autopair)
(autopair-global-mode 1)
(setq autopair-autowrap t)

(require 'markdown-mode)
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

;; disable scss compilation
(setq scss-compile-at-save nil)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
