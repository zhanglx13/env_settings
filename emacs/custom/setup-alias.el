;; [EAB] It is also useful to create more convenient names for Emacs API
;; in a namsepace-like fashion that makes easier to find functions and
;; autocomplete functions, for instance:
;;
(defalias 'file/extension         'file-name-extension)
(defalias 'file/extension-sans    'file-name-sans-extension)
(defalias 'file/path-expand       'expand-file-name)
(defalias 'file/filename          'file-name-nondirectory)
(defalias 'file/path-relative     'file-relative-name)
(defalias 'file/rename            'rename-file)
(defalias 'file/delete            'delete-file)
(defalias 'file/copy              'copy-file)

;; The following useful emacs alias are from
;; [Emacs: Use Alias for Fast M-x]
;; [http://ergoemacs.org/emacs/emacs_alias.html]
;;
(defalias 'yes-or-no-p 'y-or-n-p)
(defalias 'list-buffers 'ibuffer) ; always use ibuffer

; elisp
(defalias 'eb 'eval-buffer)
(defalias 'er 'eval-region)
(defalias 'ed 'eval-defun)
(defalias 'eis 'elisp-index-search)
(defalias 'lf 'load-file)

; major modes
(defalias 'hm 'html-mode)
(defalias 'tm 'text-mode)
(defalias 'elm 'emacs-lisp-mode)
(defalias 'om 'org-mode)
(defalias 'ssm 'shell-script-mode)

; minor modes
(defalias 'wsm 'whitespace-mode)
(defalias 'gwsm 'global-whitespace-mode)
(defalias 'vlm 'visual-line-mode)
(defalias 'glm 'global-linum-mode)
