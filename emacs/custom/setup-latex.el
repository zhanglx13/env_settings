(packages-require 'auctex)

;; Enable doc parsing
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)


(add-hook 'LaTeX-mode-hook
          (lambda ()
            (define-key LaTeX-mode-map (kbd "<f5>") 'TeX-command-run-all)
            )
          )

(require 'reftex)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)   ; with AUCTeX LaTeX mode
(add-hook 'latex-mode-hook 'turn-on-reftex)   ; with Emacs latex mode



(provide 'setup-latex)
