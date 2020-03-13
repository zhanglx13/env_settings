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

;; This sets $MANPATH, $PATH and exec-path from your shell, but only on OS X and Linux.
(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))

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
(add-to-list 'load-path "~/Dropbox/env_settings/emacs/custom/")
(add-to-list 'load-path "~/Dropbox/env_settings/emacs/custom/nyan/")

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
(require 'setup-cedet)
(require 'setup-latex)

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

;;
;; Auto load notmuch
;;
(autoload 'notmuch "notmuch" "notmuch mail" t)
(setq notmuch-search-oldest-first nil)
(add-hook 'notmuch-message-mode-hook
          (lambda () (local-set-key (kbd "C-c l") #'notmuch-draft-postpone)))

;;
;; Configure message-mode when composing emails
;;
;; setup the mail address and use name
(setq mail-user-agent 'message-user-agent)
(setq user-mail-address "zhanglx@utexas.edu"
      user-full-name "Lixun Zhang")
;; smtp config
(setq smtpmail-smtp-server "mail2.cs.utexas.edu"
      message-send-mail-function 'message-smtpmail-send-it)

;; report problems with the smtp server
(setq smtpmail-debug-info t)
;; add Cc and Bcc headers to the message buffer
(setq message-default-mail-headers "Cc: \nBcc: \n")
;; postponed message is put in the following draft directory
(setq message-auto-save-directory "~/.maildirl/draft")
(setq message-kill-buffer-on-exit t)
;; change the directory to store the sent mail
;;(setq message-directory "~/.maildir/sent")
;; Show newest email first


;; If I'm going to send email then I would like address completion. Therefore I'm going to
;; use Big Brother database, for contacts:
(when (not (require 'bbdb nil t))
  (package-refresh-contents)
  (package-install 'bbdb))

(require 'bbdb)

;; Restore the arrow key behavior for Helm
;; since it is changed in a recent update of helm
(define-key helm-map (kbd "<left>") 'helm-previous-source)
(define-key helm-map (kbd "<right>") 'helm-next-source)
;; for helm-find-files
(customize-set-variable 'helm-ff-lynx-style-map t)
;; for helm-imenu
(customize-set-variable 'helm-imenu-lynx-style-map t)
;; for semantic
(customize-set-variable 'helm-semantic-lynx-style-map t)
;; for helm-occur
(customize-set-variable 'helm-occur-use-ioccur-style-keys t)
;; for helm-grep
(customize-set-variable 'helm-grep-use-ioccur-style-keys t)
;; Done restoring arrow key behavior of helm

;; setup key bindings for multiple cursors
(global-set-key (kbd "C-c m c") 'mc/edit-lines)

(provide 'init)
;;; init.el ends here
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (auctex surfraw function-args highlight-numbers helm-projectile helm-config helm-lib discover-my-major info+ em-alias dired+ dired-x ibuffer-vc expand-region yasnippet ws-butler volatile-highlights use-package undo-tree smartparens rainbow-delimiters paredit nord-theme iedit helm ggtags duplicate-thing dtrt-indent diminish company clean-aindent-mode anzu))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
