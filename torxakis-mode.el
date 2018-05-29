;;; torxakis-mode.el --- Major mode for edditing TorXakis models.

;; Copyright © 2017, TNO

;; Author: Damian Nadales ( damian.nadales@gmail.com )
;; Version: 0.0.1
;; Created: 18 Sep 2017
;; Keywords: languages
;; Homepage: https://github.com/TorXakis/SupportEmacs

;; This file is not part of GNU Emacs.

;;; Commentary:

;;; Simple major mode for editing TorXakis models. Currently it only supports
;;; syntax highlighting.

;;; Code:

;; Custom faces

;; Define several category of keywords.
(defvar torxakis-keywords-regexp)
(setq torxakis-keywords-regexp
      (rx symbol-start
          (or "TYPEDEF"
              "FUNCDEF"
              "PROCDEF"
              "ENDDEF"
              "CHANDEF"
              "MODELDEF"
              "MAPPERDEF"
              "CNECTDEF"
              "CHAN"
              "ENCODE"
              "DECODE"
              "IN"
              "OUT"
              "HOST"
              "PORT"
              "CLIENTSOCK"
              "SERVERSOCK"
              "BEHAVIOUR"
              "IF"
              "THEN"
              "ELSE"
              "FI"
              "LET"
              "PURPDEF"
              "HIT"
              "MISS"
              "GOAL"
              "HIDE"
              "NI"
              "SYNC"
              "EXIT"
              "ACCEPT"
              "STAUTDEF"
              "VAR"
              "STATE"
              "INIT"
              "TRANS"
              "ISTEP"
              "QSTEP"
              "CONSTDEF"
              )
          symbol-end))

(defvar torxakis-types-regexp)
(setq torxakis-types-regexp
      (rx (or "::" "TYPEDEF" "#")
          (one-or-more space)
          (group symbol-start
                 (one-or-more alpha)
                 symbol-end)))

(defvar torxakis-channels-decl-regexp)
(setq torxakis-channels-decl-regexp
      (rx  (or "CHANDEF" (sequence "CHAN" (one-or-more space) (or "IN" "OUT")))
           (one-or-more space)
           (group symbol-start
                  (one-or-more alpha)
                  symbol-end)))

(defvar torxakis-channels-use-regexp)
(setq torxakis-channels-use-regexp
      (rx (group symbol-start
                 (one-or-more alpha)
                 symbol-end)
          (zero-or-more space)
          (any "\\?" "\\!")))

(defvar torxakis-ops-regexp)
(setq torxakis-ops-regexp
      (rx (group (or "[["
                     "]]"
                     "["
                     "]"
                     "/\\"
                     "\\/"
                     "not"
                     "-"
                     "+"
                     "*"
                     "/"
                     "::"
                     "::="
                     "="
                     "|"
                     "##"
                     "->"
                     "<-"
                     ">->"
                     "|||"
                     ">>>"
                     "=>>"
                     "("
                     ")"
                     "?"
                     "!"
                     "{"
                     "}"))))

;; Create the list for font-lock. Each category of keyword is given a
;; particular face
(defvar torxakis-font-lock)
(setq torxakis-font-lock
      `((,torxakis-keywords-regexp . font-lock-keyword-face)
        (,torxakis-types-regexp 1 'font-lock-type-face)
        (,torxakis-channels-decl-regexp 1 'font-lock-builtin-face)
        (,torxakis-channels-use-regexp 1 'font-lock-builtin-face)
        (,torxakis-ops-regexp 1 'font-lock-warning-face)
        ))

(defvar torxakis-mode-syntax-table)
(setq torxakis-mode-syntax-table
      (let ((table (make-syntax-table)))
        ;; Modifications in the syntax table for handling comments.
        (modify-syntax-entry ?\{ ". 1nb" table)
        (modify-syntax-entry ?\} ". 4nb" table)
        (modify-syntax-entry ?-  ". 123" table)
        (modify-syntax-entry ?\n ">"     table)
        table))

;;;###autoload
(define-derived-mode torxakis-mode prog-mode "TorXakis mode"
  "Major mode for editing TorXakis models."

  ;; Comments.
  (setq-local comment-start "-- ")
  (setq-local comment-padding 0)
  (setq-local comment-start-skip "[-{]-[ \t]*")
  (setq-local comment-end "")
  (setq-local comment-end-skip "[ \t]*\\(-}\\|\\s>\\)")

  ;; Code for syntax highlighting.
  (setq font-lock-defaults '((torxakis-font-lock) nil nil))

  (set-syntax-table torxakis-mode-syntax-table)

)

;; Clear memory. No longer needed.
(setq torxakis-keywords-regexp nil)
(setq torxakis-types-regexp nil)
(setq torxakis-channels-decl-regexp nil)
(setq torxakis-channels-use-regexp nil)
(setq torxakis-ops-regexp nil)

;; setup files ending in “.js” to open in js2-mode
(add-to-list 'auto-mode-alist '("\\.txs\\'" . torxakis-mode))

(provide 'torxakis-mode)

;;; torxakis-mode.el ends here
