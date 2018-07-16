;;; package -- Summary

;;; Commentary:
;;;  1. Part of the code here is from Emacs in A Box (EAB)
;;;     caiorss.github.io/Emacs-Elisp-Programming/Elisp_Programming.html
;;;  2. Part of the code here is from Emacs Mini Manial (EMM)
;;;     http://tuhdo.github.io/emacs-tutor3.html

;;; Code:

;; [EAB] Add and enable MELPA
(setq package-archives
      '(
        ("melpa" . "http://melpa.org/packages/")
        ;;("melpa-stable" . "http://stable.melpa.org/packages/")
        ;; ("org"       . "http://orgmode.org/elpa/")
        ("gnu"       . "http://elpa.gnu.org/packages/")
        ("marmalade" .  "https://marmalade-repo.org/packages/"))
      )

(package-initialize)
(package-refresh-contents)

(defun packages-require (&rest packs)
  "Install and load a package. If the package is not available install it automaticaly."
  (mapc  (lambda (package)
           (unless (package-installed-p package)
             (package-install package)
             ))
         packs
         ))

(packages-require 'paredit)
(packages-require 'rainbow-delimiters)
(packages-require 'cl)
(packages-require 'ggtags)
(packages-require 'use-package)

(setq use-package-always-ensure t)

;; add your modules path
(add-to-list 'load-path "~/.emacs.d/custom/")
(add-to-list 'load-path "~/.emacs.d/custom/nyan/")

;; load your modules
(load "emacs-in-a-box.el")
(require 'setup-editing)
(require 'setup-convenience)
(require 'setup-files)
(require 'setup-data)
(require 'setup-external)
(require 'setup-communication)
(require 'setup-programming)
(require 'setup-development)
(require 'setup-environment)
(require 'setup-faces-and-ui)
(require 'setup-help)
(require 'setup-helm)
(load "setup-alias.el")
(load "dired+.el") ;; dired+ is no longer supported by MELPA
(load "info+.el")
(require 'setup-helm-gtags)
;(require 'setup-cedet)


;; [EMM] Active ggtags-mode in a few programming mode
(add-hook 'c-mode-common-hook
    (lambda ()
      (when (derived-mode-p 'c-mode 'c++-mode 'java-mode 'asm-mode)
	(ggtags-mode 1))))

(add-hook 'dired-mode-hook 'ggtags-mode)

(global-linum-mode 1)

(packages-require 'nord-theme)
(setq nord-comment-brightness 20)
(load-theme 'nord t)

;; automatically maximize frame when start up
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; package: function-args ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(packages-require 'function-args)
(fa-config-default)

(provide 'init)
;;; init.el ends here
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (function-args highlight-numbers helm-projectile helm-config helm-lib discover-my-major info+ em-alias dired+ dired-x ibuffer-vc expand-region yasnippet ws-butler volatile-highlights use-package undo-tree smartparens rainbow-delimiters paredit nord-theme iedit helm ggtags duplicate-thing dtrt-indent diminish company clean-aindent-mode anzu))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
