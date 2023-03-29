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
      user-mail-address "curtis@partiallapplied.tech")

(defconst my-frame-width (/ (display-pixel-width) 2))
(defconst my-frame-height (/ (display-pixel-height) 2))

(defconst my-font-size (cond ((<= 2880 (display-pixel-height)) 28)
                             ((<= 2560 (display-pixel-height)) 24)
                             ((<= 1980 (display-pixel-height)) 20)
                             ((<= 1440 (display-pixel-height)) 16)
                             ((<= 1080 (display-pixel-height)) 14)))

(defvar my-themes '(doom-dracula
                    doom-rouge
                    deeper-blue
                    doom-material
                    doom-laserwave
                    doom-outrun-electric
                    doom-dark+
                    ;;light
                    leuven
                    tango
                    solarized-light
                    tsdh-light
                    default))

(setq frame-resize-pixelwise t)
(when window-system
  (set-frame-position (selected-frame) 0 0)
  (set-frame-size (selected-frame)
                  (- my-frame-width 16)
                  my-frame-height
                  t))

(setq doom-font (font-spec :family "Fira Code" :size my-font-size :weight 'medium)
      doom-variable-pitch-font (font-spec :family "Fira Sans" :size my-font-size))
(setq doom-unicode-font (font-spec :family "MesloLGS NF" :size my-font-size))

(setq display-line-numbers-type 'relative)
(setq column-number-mode t)
(setq display-time-mode t)
(setq delete-selection-mode nil)
(setq evil-default-state 'emacs)
(setq doom-modeline-buffer-file-name-style 'relative-from-project)

(use-package! doom-themes
  :config
  (setq doom-themes-enable-bolt t
        doom-themes-enable-italic t)
  (setq doom-theme 'doom-henna)
  (doom-themes-visual-bell-config)
  (doom-themes-org-config))

(use-package! centered-window
  :custom
  (cwm-centered-window-width 180))

(use-package! server
  :config
  (unless (server-running-p)
    (server-start)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;                                 VTERM
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Install cmake, libtool, and libtool-bin before having emacs compile vterm.
;;
;; If there are compilation issues you may have to purge the packages from
;; ~/.config/emacs/.local/

(setq vterm-module-cmake-args "-DUSE_SYSTEM_LIBVTERM=no")

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

(if (file-exists-p "/home/curtis/.config/roswell/helper.el")
    (cl-do (load (expand-file-name "~/.config/roswell/helper.el"))
           (setq inferior-lisp-program "ros -Q run"))
    (setq inferior-lisp-program "/usr/local/bin/sbcl"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;                              KEYBINDINGS
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; OS Specific
(if (equal system-type 'darwin)
    (progn
      (setq mac-command-modifier 'meta)
      (setq mac-option-modifier 'super)
      (setq mac-function-modifier 'hyper)))

(global-set-key (kbd "<f9>") (lambda ()
                             (interactive)
                             (other-window -1)))
(global-set-key (kbd "<f10>") (lambda ()
                             (interactive)
                             (other-window 1)))

;; Use super-<left>|<right>|<up>|<down> to change windows
(windmove-default-keybindings 'super)

;; Function Keys
(global-set-key [f1] 'god-mode-all)
(global-set-key [C-f1] 'god-mode-all)
(global-set-key [f2] 'smartparens-strict-mode)
(global-set-key [f3] 'delete-trailing-whitespace)
(global-set-key [f4] 'comment-or-uncomment-region)
(global-set-key [f5] 'dired-single-magic-buffer)
(global-set-key [C-f5] 'projectile-dired)
(global-set-key [f6] 'magit-status)
(global-set-key [f7] '+eshell/toggle)
(global-set-key [f8] 'treemacs)
(global-set-key [f9] '+fold/toggle)
(global-set-key [f10] 'treemacs)
(global-set-key [f11] 'toggle-frame-fullscreen)
(global-set-key [f12] 'undo-tree-undo)
(global-set-key [C-f12] 'vundo)
(global-set-key [f13] 'call-last-kbd-macro)
(global-set-key [f14] '+fold/close-all)
(global-set-key [f15] '+fold/open-all)
(global-set-key [home] 'beginning-of-buffer)
(global-set-key [end] 'end-of-buffer)
;; Logitech G710+ G-keys
(global-set-key [s-f1] 'isearch-backward)
(global-set-key [s-f2] 'isearch-forward)
(global-set-key [s-f3] 'isearch-query-replace)
(global-set-key [s-f4] 'org-babel-tangle)

(map! ("C-w" #'backward-kill-word)
      ("M-k" #'kill-region))

;; Smartparens
(global-set-key (kbd "C-M-f") 'sp-forward-sexp)
(global-set-key (kbd "C-M-b") 'sp-backward-sexp)
(global-set-key (kbd "C-M-d") 'sp-down-sexp)
(global-set-key (kbd "C-M-a") 'sp-backward-down-sexp)
(global-set-key (kbd "C-S-d") 'sp-beginning-of-sexp)
(global-set-key (kbd "C-S-a") 'sp-end-of-sexp)
(global-set-key (kbd "C-M-e") 'sp-up-sexp)
(global-set-key (kbd "C-M-u") 'sp-backward-up-sexp)
(global-set-key (kbd "C-M-t") 'sp-transpose-sexp)
(global-set-key (kbd "C-M-n") 'sp-forward-hybrid-sexp)
(global-set-key (kbd "C-M-p") 'sp-backward-hybrid-sexp)
(global-set-key (kbd "C-M-k") 'sp-kill-sexp)
(global-set-key (kbd "C-M-w") 'sp-copy-sexp)
(global-set-key (kbd "M-<delete>") 'sp-unwrap-sexp)
(global-set-key (kbd "M-<backspace>") 'sp-backward-unwrap-sexp)
(global-set-key (kbd "C-0") 'sp-forward-slurp-sexp)
(global-set-key (kbd "C-M-0") 'sp-forward-barf-sexp)
(global-set-key (kbd "C-9") 'sp-backward-slurp-sexp)
(global-set-key (kbd "C-M-9") 'sp-backward-barf-sexp)
(global-set-key (kbd "M-D") 'sp-splice-sexp)
(global-set-key (kbd "C-M-<delete>") 'sp-splice-sexp-killing-forward)
(global-set-key (kbd "C-M-<backspace>") 'sp-splice-sexp-killing-backward)
(global-set-key (kbd "C-S-<backspace>") 'sp-splice-sexp-killing-around)
(global-set-key (kbd "C-]") 'sp-select-next-thing-exchange)
(global-set-key (kbd "C-<left_bracket>") 'sp-select-previous-thing)
(global-set-key (kbd "C-M-]") 'sp-select-next-thing)
(global-set-key (kbd "M-F") 'sp-forward-symbol)
(global-set-key (kbd "M-B") 'sp-backward-symbol)
(global-set-key (kbd "C-\"") 'sp-change-inner)
(global-set-key (kbd "M-i") 'sp-change-enclosing)
(bind-key "C-c f" (lambda () (interactive) (sp-beginning-of-sexp 2)) smartparens-mode-map)
(bind-key "C-c b" (lambda () (interactive) (sp-beginning-of-sexp -2)) smartparens-mode-map)
(global-set-key (kbd "H-<delete>") (lambda ()
                                     (smartparens-strict-mode nil)
                                     (delete-char -1)
                                     (smartparens-strict-mode t)))

(use-package! fix-word
    :config
    (global-set-key (kbd "M-u") #'fix-word-upcase)
    (global-set-key (kbd "M-l") #'fix-word-downcase)
    (global-set-key (kbd "M-c") #'fix-word-capitalize))

(use-package! dired-single
  :config
  (define-key dired-mode-map [remap dired-find-file]
     'dired-single-buffer)
   (define-key dired-mode-map [remap dired-mouse-find-file-other-window]
     'dired-single-buffer-mouse)
   (define-key dired-mode-map [remap dired-up-directory]
     'dired-single-up-directory))
  ;; (global-set-key [(control f5)]
  ;;                 (function (lambda nil (interactive)
  ;;                           (dired-single-magic-buffer default-directory))))
  ;;(global-set-key [(meta f5)] 'dired-single-toggle-buffer-name)

(defalias 'qrr 'query-replace-regexp)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;                 DIRED COMPANY ETC...
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Hide boring buffers by regex
;; (setq helm-boring-buffer-regexp-list
;;       (quote
;;        ("\\*.+\\*"
;;         "\\` \\*"
;;         "magit.+")))

;; ;; Hide additional buffers based on mode
;; (defun my-filter-dired-buffers (buffer-list)
;;   (delq nil (mapcar
;;              (lambda (buffer)
;;                (if (eq (with-current-buffer buffer major-mode)  'dired-mode)
;;                    nil
;;                  buffer))
;;              buffer-list)))

;; (advice-add 'helm-skip-boring-buffers :filter-return 'my-filter-dired-buffers)

;; ;; Whitelist buffers that shouldn't be hidden
;; (setq helm-white-buffer-regexp-list
;;       (quote
;;        ("\\*Messages\\*"
;;         "\\*Warnings\\*"
;;         "\\*ansi-term"
;;         "\\*cider-repl.+\\*"
;;         "\\*cider-error.+\\*"
;;         "\\*spacemacs\\*"
;;         "magit:.+")))

(use-package! dired-single
  :config
  (define-key dired-mode-map [remap dired-find-file]
     'dired-single-buffer)
   (define-key dired-mode-map [remap dired-mouse-find-file-other-window]
     'dired-single-buffer-mouse)
   (define-key dired-mode-map [remap dired-up-directory]
     'dired-single-up-directory)
  ;; (global-set-key [(f5)] 'dired-single-magic-buffer)
  ;; (global-set-key [(control f5)]
  ;;                 (function (lambda nil (interactive)
  ;;                           (dired-single-magic-buffer default-directory))))
  ;; (global-set-key [(meta f5)] 'dired-single-toggle-buffer-name)
  )

(use-package! undo-tree
  :diminish
  :bind (("C-c _" . undo-tree-visualize))
  :config
  (global-undo-tree-mode +1)
  (undo-tree-auto-save-history))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;                           CHATGPT
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 🔑 Obtaining API key
;;
;; To use this extension, you will need an API key from OpenAI. To obtain one,
;; follow these steps:
;;
;; 1. Go to [OpenAI's website](https://beta.openai.com/account/api-keys). If you
;; don't have an account, you will need to create one or sign up using your Google
;; or Microsoft account.
;; 2. Click on the `Create new secret key` button.
;; 3. Copy the key and paste into the 'API Key' field under the 'openai' custom group settings.

;; When you create a new account, you receive $18 in free credits for the API which
;; you must use in the first 90 days. You can see pricing information
;; [here](https://openai.com/api/pricing/). 1000 tokens are about 700 words, and
;; you can see the token count for each request at the end of the response in the
;; sidebar.
;;
;; 📝 Customization
;;
;;  🧪 Variables
;;
;; - `chatgpt-model` - ID of the model to use. (Default: `"gpt-3.5-turbo"`)
;; - `chatgpt-max-tokens` - The maximum number of tokens to generate in the completion. (Default: `2000`)
;; - `chatgpt-temperature` - What sampling temperature to use. (Default: `1.0`)
;; - `chatgpt-input-method` - Method to receive input. (Default: `'window`)
;; - `chatgpt-spinner-type` - Type of the spinner. (Default: `'moon`)
;; - `chatgpt-display-tokens-info` - Non-nil we display tokens information for each request. (Default: `t`)
;; - `chatgpt-animate-text` - Display text gradually instead of output it all at once. (Default: `t`)
;; - `chatgpt-animate-fps` - Frame per seconds to display text animation. (Default: `5`)

;; (use-package! copilot)

;; (use-package! openai)
;; ;;    (setq openai-key "[YOU API KEY]")
;; ;;    (setq openai-user "[YOUR USER UID]"))

;; (use-package! chatgpt
;;   :config
;;   (setq catgpt-max-tokens 2000)
;;   (setq catgpt-model "gpt-3.5-turbo"))
