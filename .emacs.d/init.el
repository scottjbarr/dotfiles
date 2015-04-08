;; package config
(require 'package)
(package-initialize)

(add-to-list 'package-archives
  '("marmalade" . "http://marmalade-repo.org/packages/") t)

;; basic stuff
(setq-default tab-width 4)
(setq require-final-newline 't)
(setq column-number-mode t)
(global-auto-revert-mode 1)

;; show trailing whitespace
(setq-default show-trailing-whitespace t)

;; delete trailing whitespace on save
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; key bindings
(global-set-key (kbd "C-c r") 'revert-buffer)
;; (global-set-key (kbd "C-c C-f") 'find-file-in-project)

;;(display-graphic-p &optional DISPLAY
;; (unless window-system
;;   ;; hide the menu bar
;;   (menu-bar-mode -1)
;;   )

(if window-system
  ;; theme
  (load-theme 'flatland t)
  )

;; projectile - see https://github.com/bbatsov/projectile
(projectile-global-mode)
(projectile-mode t)
(setq projectile-enable-caching t)

;; mac key bindings
(when (eq system-type 'darwin)
    (setq mac-command-modifier 'meta)
    (global-set-key [kp-delete] 'delete-char) ;; sets fn-delete to be right-delete
    )

;; enable gofmt on save for go-mode
(add-hook 'go-mode-hook
          (lambda ()
			(add-hook 'before-save-hook 'gofmt-before-save nil 'make-it-local)))

;; Set default font
(set-face-attribute 'default nil
					:family "Inconsolata"
					:height 160
					:weight 'normal
					:width 'normal)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes (quote ("923faef2c7ed017e63f517703c846c6190c31400261e8abdb1be06d5b46ea19a" "246a51f19b632c27d7071877ea99805d4f8131b0ff7acb8a607d4fd1c101e163" "fe243221e262fe5144e89bb5025e7848cd9fb857ff5b2d8447d115e58fede8f7" default))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
