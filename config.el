;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-
;;;
;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;                        DOOM CONFIG
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; WHENEVER YOU reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
;; ______________________________________________________________________________
;;
;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;                              APPEARANCE
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq user-full-name "Curtis Bowman"
      user-mail-address "c.bowman1711@gmail.com")

(defconst my-font-size (cond ((<= 3840 (display-pixel-width)) 28)
                             ((<= 2560 (display-pixel-width)) 24)
                             ((<= 1980 (display-pixel-width)) 20)
                             ((<= 1440 (display-pixel-width)) 16)))

(setq doom-font (font-spec :family "Fira Code" :size my-font-size :weight 'medium)
      doom-variable-pitch-font (font-spec :family "Fira Sans" :size my-font-size))

(setq doom-unicode-font (font-spec :family "MesloLGS NF" :size my-font-size))

(setq doom-theme 'doom-rouge)

(setq display-line-numbers-type 'relative)

(when window-system
  (set-frame-position (selected-frame) 0 0)
  (set-frame-size (selected-frame) 159 90))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;                                   ORG
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(after! org-mode
  (setq org-directory "~/org/")
  (setq org-babel-sh-command "zsh"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;                                   LISP
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;(load (expand-file-name "~/.config/roswell/helper.el"))
;;(setq inferior-lisp-program "ros -Q run")

;; Smartparens bindings set to be called with SPC + l as prefix
;; (map!
;;  :map smartparens-mode-map
;;  :leader (:prefix ("l" . "Lisps")
;;           :nvie "f" #'sp-forward-sexp
;;           :nvie "b" #'sp-backward-sexp
;;           :nvim "u" #'sp-unwrap-sexp
;;           :nie "k" #'sp-kill-sexp
;;           :nie "s" #'sp-split-sexp
;;           :nie "(" #'sp-wrap-round
;;           :nie "[" #'sp-wrap-square
;;           :nie "{" #'sp-wrap-curly))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;                              KEYBINDINGS
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(map! ("C-w" #'backward-kill-word)
      ("C-c C-k" #'kill-region))

;; (global-set-key [f5] 'call-last-kbd-macro)

(defalias 'qrr 'query-replace-regexp)

(use-package! dired-single
  :config
  (define-key dired-mode-map [remap dired-find-file]
     'dired-single-buffer)
   (define-key dired-mode-map [remap dired-mouse-find-file-other-window]
     'dired-single-buffer-mouse)
   (define-key dired-mode-map [remap dired-up-directory]
     'dired-single-up-directory)
  (global-set-key [(f5)] 'dired-single-magic-buffer)
  (global-set-key [(control f5)]
                  (function (lambda nil (interactive)
                            (dired-single-magic-buffer default-directory))))
  (global-set-key [(meta f5)] 'dired-single-toggle-buffer-name))

(use-package! fix-word
    :config
    (global-set-key (kbd "M-u") #'fix-word-upcase)
    (global-set-key (kbd "M-l") #'fix-word-downcase)
    (global-set-key (kbd "M-c") #'fix-word-capitalize))

  (add-hook 'prog-mode-hook 'highlight-indent-guides-mode) 
  (setq highlight-indent-guides-method 'bitmap)
