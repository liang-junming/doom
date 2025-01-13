;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
(setq doom-font (font-spec :family "Courier" :size 20))
(if (display-graphic-p)
    (set-fontset-font t 'han "Lantinghei SC"))

;; frame size
;;(add-to-list 'default-frame-alist '(fullscreen . maximized))
(setq default-frame-alist '((width . 120)
                            (height . 40)))

;; frame location
(defun center-frame ()
  "Center the current frame on the screen."
  (interactive)
  (let* ((frame (selected-frame))
         (width (frame-pixel-width frame))
         (height (frame-pixel-height frame))
         (pos-x (/ (- (x-display-pixel-width) width) 2))
         (pos-y (/ (- (x-display-pixel-height) height) 2)))
    (set-frame-position frame pos-x pos-y)))

(add-hook 'window-setup-hook 'center-frame)

;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-solarized-light)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


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
(after! which-key
  ;; The delay for first open which-key window when press leader-key.
  (setq which-key-idle-delay 0.2)
  ;; The delay for switch which-key window when press folder key.
  (setq which-key-idle-secondary-delay 0))

(after! doom-themes
  (setq doom-themes-enable-bold nil)
  (setq doom-themes-enable-italic nil))

(use-package! google-translate
  :config
  (setq google-translate-default-source-language "en")
  (setq google-translate-default-target-language "zh-CN")
  (setq google-translate-output-destination 'nil)
  (setq google-translate-pop-up-buffer-set-focus t)
  (map!
   :leader :desc "translate at point" "l p" #'google-translate-at-point))

(use-package! vertico
  :config
  (map! :when (modulep! :editor evil +everywhere)
        :map vertico-map
        "C-h"   #'vertico-next
        "C-M-h" #'vertico-next-group
        "C-t"   #'vertico-previous
        "C-M-t" #'vertico-previous-group))

(define-minor-mode dvorak-dhtn-mode
  "dvorak-dhtn-mode allows you to use 'dhtn' insterd of 'hjkl' wen you use dvorak keyboard layout."
  :lighter " ED"
  :keymap (make-sparse-keymap)
  :global t)

(evil-define-key '(normal visual motion) dvorak-dhtn-mode-map
  "d" 'evil-backward-char
  "h" 'evil-next-line
  "t" 'evil-previous-line
  "n" 'evil-forward-char
  "D" 'evil-window-top
  "N" 'evil-window-bottom
  "l" 'evil-ex-search-next
  "L" 'evil-ex-search-previous

  "j" 'join-line
  "k" 'evil-delete
  "K" 'evil-delete-line
  "H" '+lookup/documentation
  )

(dvorak-dhtn-mode)
