;;; package -- Summary

;;; Commentary:
;;;  1. Part of the code here is from Emacs in A Box (EAB)
;;;     caiorss.github.io/Emacs-Elisp-Programming/Elisp_Programming.html
;;;  2. Part of the code here is from Emacs Mini Manial (EMM)
;;;     http://tuhdo.github.io/emacs-tutor3.html

;;; Code:
(load-file "~/Dropbox/env_settings/emacs/init.el")

(autoload 'notmuch "notmuch" "notmuch mail" t)

;;
;; Configure message-mode when composing emails
;;
;; setup the mail address and use name
(setq mail-user-agent 'message-user-agent)
(setq user-mail-address "zhanglx@utexas.edu"
      user-full-name "Lixun Zhang")
;; smtp config
(setq smtpmail-smtp-server "smtp.gmail.com"
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
(setq notmuch-search-oldest-first nil)

;; If I'm going to send email then I would like address completion. Therefore I'm going to
;; use Big Brother database, for contacts:
(when (not (require 'bbdb nil t))
  (package-refresh-contents)
  (package-install 'bbdb))

(require 'bbdb)

(add-hook 'notmuch-message-mode-hook
          (lambda () (local-set-key (kbd "C-c l") #'notmuch-draft-postpone)))


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (bbdb auctex surfraw function-args highlight-numbers helm-projectile helm-config helm-lib discover-my-major info+ em-alias dired+ dired-x ibuffer-vc expand-region yasnippet ws-butler volatile-highlights use-package undo-tree smartparens rainbow-delimiters paredit nord-theme iedit helm ggtags duplicate-thing dtrt-indent diminish company clean-aindent-mode anzu))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
