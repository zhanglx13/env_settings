;; [EAB] Enable paredit, rainbow-delimiters and show-paren-mode
;; for Emacs lisp mode (mode to edit Emacs files *.el) and
;; lisp-interaction-mode (mode to edit *scratch* buffer)

(add-hook 'emacs-lisp-mode-hook
          (lambda ()
            (paredit-mode t)
            (rainbow-delimiters-mode t)
            (show-paren-mode 1)
            ))

(add-hook 'lisp-interaction-mode
          (lambda ()
            (paredit-mode t)
            (rainbow-delimiters-mode t)
            (show-paren-mode 1)
            ))


;; [EAB] Set useful key bindings for IELM
(require 'ielm)

(defun ielm/clear-repl ()
  "Clear current REPL buffer."
  (interactive)
  (let ((inhibit-read-only t))
      (erase-buffer)
      (ielm-send-input)))

(define-key inferior-emacs-lisp-mode-map
  (kbd "M-RET")
  #'ielm-return)

(define-key inferior-emacs-lisp-mode-map
  (kbd "C-j")
  #'ielm-return)

(define-key inferior-emacs-lisp-mode-map
  (kbd "RET")
  #'electric-newline-and-maybe-indent)

(define-key inferior-emacs-lisp-mode-map
  (kbd "<up>")
  #'previous-line)

(define-key inferior-emacs-lisp-mode-map
  (kbd "<down>")
  #'next-line)

(define-key inferior-emacs-lisp-mode-map
  (kbd "C-c C-q")
  #'ielm/clear-repl
  )

;; [EAB] Smart window switch
;; The traditional window switch with C-x o can be cumbersome
;; to use in the long run. The windmove commands provide a more
;; convenient way to do this. All you have to do is to hold down
;; Shift while pointing at a window with the arrow keys.
(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings))

;; [EAB] Self closing parenthesis
(defun close-paren ()
    (interactive)
    (insert "()")               ;; Advance current char + 2
    (goto-char (1- (point))))   ;; (current-char position) + 2- 1

(global-set-key (kbd "(") #'close-paren)

;; [EAB] macro for lambda-interactive function definition
(defmacro $li (func &rest args)
      `(lambda ()
         (interactive)
         (,func  ,@args)))

;; [EAB] Open a Emacs Lisp developement window
(global-set-key (kbd "C-c M-w")
    ($li progn
       (delete-other-windows)
       (split-window-horizontally)
       (switch-to-buffer "*scratch*")
       (switch-to-buffer-other-window "*ielm*")
       (ielm)
       (other-window 1)
       ))

;; [EAB] Author defined functions
;;
;; List recursive functions
;; Alist to plist
(defun plist->alist (plist)
  (if (null plist)
      '()
    (cons
     (list (car plist) (cadr plist))
     (plist->alist (cddr plist)))))

;;; Converts association list to plist
(defun alist->plist (assocl)
  (if (null assocl)
      '()
    (let
        ((hd (car assocl))
         (tl (cdr assocl)))
      (cons (car hd)
            (cons (cadr hd)
                  (alist->plist tl))))))

;;; Converts plist to clist (List of cons pairs)
(defun plist->clist (plist)
  (if (null plist)
      '()
    (cons
     (cons (car plist) (cadr plist))
     (plist->clist (cddr plist)))))

(defun map (fun xs)
  (if (null xs)
      '()
    (cons (funcall fun (car xs))
          (map fun (cdr xs)))))

(defun filter (fun xs)
  (if (null xs)
      '()
    (let ((hd (car xs))
          (tl (cdr xs)))
      (if (funcall fun hd)
          (cons hd (filter fun tl))
        (filter fun tl)))))

(defun take (n xs)
  (if (or (null xs) (zerop n))
      '()
    (cons (car xs)
          (take (- n 1) (cdr xs)))))

(defun drop (n xs)
  (if (or (null xs) (zerop n))
      xs
    (drop (- n 1)  (cdr xs))))

(defun map-apply (fun xss)
  (mapcar (lambda (xs) (apply fun xs)) xss))

(defun zip (&rest xss)
  (if (null (car xss))
      '()
    (cons
     (mapcar #'car xss)
     (apply #'zip (mapcar #'cdr xss)))))

(defun zipwith (f &rest xss)
  (map-apply f (apply #'zip xss)))

;;           f :: x -> acc -> acc
;; foldr :: (a -> b -> b) -> b -> [a] -> b
;; foldr :: (x -> acc -> acc) -> acc -> [x] -> acc
;; foldr f z []     = z
;; foldr f z (x:xs) = f x (foldr f z xs)
;;
;;  x = (car xss) , xs = (cdr xss)
(defun foldr (f acc xss)
  (if (null xss)
      ;; foldr f z []     = z
      acc
    ;; foldr f z (x:xs) = f x (foldr f z xs)
    (funcall f (car xss)
             (foldr f acc (cdr xss)))))

;; foldl :: (b -> a -> b) -> b -> [a] -> b
;; foldl f z []     = z
;; foldl f z (x:xs) = foldl f (f z x) xs
(defun foldl (f acc xss)
  (if (null xss)
      acc
    (foldl f (funcall f acc (car xss)) (cdr xss))))

(defun map-pair (func xs)
  (mapcar (lambda (x) (cons x (funcall func x))) xs))

(defun buffer-mode (buffer-or-string)
  "Returns the major mode associated with a buffer."
  (with-current-buffer buffer-or-string
    major-mode))

(defun map-xypair (func-x func-y xs)
  (mapcar
   (lambda (x)
     (cons (funcall func-x x) (funcall func-y x)))
   xs))

(defmacro juxt (&rest xs_f)
  `(lambda (x)
     (list ,@(mapcar (lambda (f) `(funcall ,f x)) xs_f))))

(defmacro map-juxt (xs_f xs)
  `(mapcar (juxt ,@xs_f) ,xs))

(defmacro $f (f &rest params)
  `(lambda ($) (,f ,@params)))

(defmacro $c (f  &rest params)
  `(lambda (__x) (,f ,@params __x)))

;;;;;;;;;;;;
;; Macros ;;
;;;;;;;;;;;;
(defmacro λ (args body)
  `(lambda ,args ,body))

(defmacro nil! (var)
  `(setq ,var nil))

(defmacro fn (args body)
  `(lambda ,args ,body))

(defmacro def (name value)
  `(setq ,name ,value))

(defmacro defn (name args body)
  `(defun ,name ,args ,body))

(defun foldl (f acc xss)
  (if (null xss)
      acc
    (foldl f (funcall f acc (car xss)) (cdr xss))))

(defun pass-result (x sexp)
  (if (listp sexp)
      `(,(car sexp) ,x ,@(cdr sexp))
    `(,sexp ,x)))

(defmacro -> (x &rest exprs)
  (foldl #'pass-result x exprs))

(defun pass-result-last (x sexp)
  (if (listp sexp)
      `(,(car sexp) ,@(cdr sexp) ,x)
    `(,sexp ,x)))

(defmacro --> (x &rest exprs)
  (foldl #'pass-result-last x exprs))

(defun replace (targ subst lst)
  (if (null lst)
      '()
    (let ((hd (car lst))
          (tl (cdr lst)))
      (if (equal targ hd)
          (cons subst (replace targ subst tl))
        (cons (if (listp hd) (replace targ subst hd) hd)
              (replace targ subst tl))))))

(defun pass-result-subst (x sexp)
  (if (listp sexp)
      (replace '$ x sexp)
    `(,sexp ,x)))

(defmacro $-> (x &rest exprs)
  (foldl #'pass-result-subst x exprs))

(defmacro letc (bindings &rest body)
  `(let*
       ,(plist->alist bindings)
     ,@body))

(defmacro define (args body)
  (if (listp args)
      `(defun ,(car args) ,(cdr args) ,body)
    `(setq  ,args ,body)))

(defmacro rebindfun (new-name old-name)
  `(setf (symbol-function ,new-name) ,old-name))

(defmacro $ (a op b)
  `(,op ,a ,b))

(defmacro $debug (func &rest params)
  `(let
       ((__r (,func ,@params)))
     (progn
       (print (format "%s = %s"
                      (quote (,func ,@params))
                      __r))
       __r)))

;;;;;;;;;;;;;;;;;;;;;;
;; Buffer functions ;;
;;;;;;;;;;;;;;;;;;;;;;
(defun opened-files ()
  "List all opened files in the current session"
  (interactive)
  (remove-if 'null (mapcar 'buffer-file-name  (buffer-list))))

(defun find-buffer-file (filename)
  (car (remove-if-not
        (lambda (b) (equal (buffer-file-name b) filename)) (buffer-list))))

(defun close-files (filelist)
  (mapcar (lambda (f) (kill-buffer (find-buffer-file f))) filelist))

(defun within-buffer (name function)
  (let (curbuff (current-buffer))
    (switch-to-buffer name)
    (funcall function)
    (switch-to-buffer current-buffer)
    ))

(defun buffer-content (name)
  (with-current-buffer name
    (buffer-substring-no-properties (point-min) (point-max)  )))

(defun get-selection ()
  "Get the text selected in current buffer as string"
  (interactive)
  (buffer-substring-no-properties (region-beginning) (region-end))
  )

(defun get-current-line ()
  (interactive)
  "Get current line, where the cursor lies in the current buffer"
  (replace-regexp-in-string "[\n|\s\t]+$" "" (thing-at-point 'line t))
  )

(defun replace-regexp-entire-buffer (pattern replacement)
  "Perform regular-expression replacement throughout buffer."
  (interactive
   (let ((args (query-replace-read-args "Replace" t)))
     (setcdr (cdr args) nil)    ; remove third value returned from query---args
     args))
  (save-excursion
    (goto-char (point-min))
    (while (re-search-forward pattern nil t)
      (replace-match replacement))))

;;;;;;;;;;;;;;;;;;;;;;;;
;; useful keybindings ;;
;;;;;;;;;;;;;;;;;;;;;;;;
(global-set-key (kbd "C-c M-r")
                ($li insert (format-time-string "%Y-%m-%d")))

;;; Type C-c M-e to open Ielm (Emacs Lisp Shell)
(global-set-key (kbd "C-c M-e") #'ielm)

(defun url-at-point ()
  (interactive)
  (browse-url (thing-at-point 'url)))

(global-set-key (kbd "C-c M-u") #'url-at-point)

(defun open-file-at-point ()
  (interactive)
  (find-file (thing-at-point 'filename)))

(global-set-key (kbd "C-c M-f") #'open-file-at-point)

;; Set may keys at same time. A macro in Clojure-style
;; with minimum amount of parenthesis as possible.
;;
(defmacro set-gl-keys (&rest keylist)
  `(progn
     ,@(map-apply (lambda (key fun)
                    `(global-set-key (kbd ,key) ,fun))
                  (plist->alist keylist))))
