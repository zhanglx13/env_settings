;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; GROUP: Data -> Saveplace ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; saveplace remembers your location in a file when saving files
(packages-require 'saveplace)
(setq-default save-place t)
;; use (toggle-save-place-globally 1) in Emacs above 24.4

(provide 'setup-data)
