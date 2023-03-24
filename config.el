;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!
(setq user-full-name "Curtis Bowman"
      user-mail-address "c.bowman1711@gmail.com")

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.



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

(defconst my-font-size (cond ((<= 3840 (display-pixel-width)) 28)
                             ((<= 2560 (display-pixel-width)) 24)
                             ((<= 1980 (display-pixel-width)) 20)
                             ((<= 1440 (display-pixel-width)) 16)))

(setq doom-font (font-spec :family "Fira Code" :size my-font-size :weight 'medium)
      doom-variable-pitch-font (font-spec :family "Fira Sans" :size my-font-size))

(setq doom-unicode-font (font-spec :family "MesloLGS NF" :size my-font-size))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;;
;; (defconst dracula-background "#282a36")
;; (defconst dracula-curren-line "#44475a")
;; (defconst dracula-selection "#44475a")
;; (defconst dracula-foreground "#f8f8f2")
;; (defconst dracula-comment "#6272a4")
;; (defconst dracula-white "#bfbfbf")
;; (defconst dracula-black "#000000")
;; (defconst dracula-cyan "#8be9fd")
;; (defconst dracula-blue "#caa9fa")
;; (defconst dracula-green "#50fa7b")
;; (defconst dracula-orange "#ffb86c")
;; (defconst dracula-pink "#ff79c6")
;; (defconst dracula-purple "#bd93f9")
;; (defconst dracula-red "#ff5555")
;; (defconst dracula-yellow "#f1fa8c")
;; (defconst dracula-magenta "#ff79c6")

(setq doom-theme 'doom-moonlight)

(setq default-frame-alist '((undecorated. t)
                            (fulscreen . maximixed)))

;;(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type `relative)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")
(setq org-babel-sh-command "zsh")

;; Whenever you reconfigure a package, make sure to wrap your config in an
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

(load (expand-file-name "~/.config/roswell/helper.el"))
(setq inferior-lisp-program "ros -Q run")
