(packages-require 'cc-mode)
(packages-require 'semantic)

(global-semanticdb-minor-mode 1)
(global-semantic-idle-scheduler-mode 1)
(global-semantic-stickyfunc-mode 1)

(semantic-mode 1)

(defun alexott/cedet-hook ()
  (local-set-key "\C-c\C-j" 'semantic-ia-fast-jump)
  (local-set-key "\C-c\C-s" 'semantic-ia-show-summary))

(add-hook 'c-mode-common-hook 'alexott/cedet-hook)
(add-hook 'c-mode-hook 'alexott/cedet-hook)
(add-hook 'c++-mode-hook 'alexott/cedet-hook)

;; Add more system include path
;; By default, Semantic automatically includes some default system include paths
;; such as /usr/include, /usr/local/include… You can view the list of include
;; paths in semantic-dependency-system-include-path. To add more include paths,
;; for example Boost include paths, use the function semantic-add-system-include like this:

;; (semantic-add-system-include "/usr/include/boost" 'c++-mode)
;; (semantic-add-system-include "~/linux/kernel")
;; (semantic-add-system-include "~/linux/include")

;; If you want the system include paths to be available on both C/C++ modes,
;; then ignore the optional mode argument in semantic-add-system-include.

;; Enable EDE only in C/C++
(packages-require 'ede)
(global-ede-mode)

(provide 'setup-cedet)
