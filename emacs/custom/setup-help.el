;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; GROUP: Help -> Info+               ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(packages-require 'discover-my-major)
;; A quick major mode help with discover-my-major
(global-unset-key (kbd "C-h h"))        ; original "C-h h" displays "hello world" in different languages
(define-key 'help-command (kbd "h m") 'discover-my-major)

(provide 'setup-help)
