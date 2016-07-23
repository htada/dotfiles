;; 文字コード
(set-language-environment "Japanese")
(require 'ucs-normalize)
(prefer-coding-system 'utf-8)
(setq fine-name-coding-system 'utf-8-hfs)
(setq local-coding-system 'utf-8-hfs)

;; load-path
(defun add-to-load-path (&rest paths)
  (let (path)
    (dolist (path paths paths)
      (let ((default-directory (expand-file-name (concat user-emacs-directory path))))
	(add-to-list 'load-path default-directory)
	(if (fboundp 'normal-top-level-add-subdirs-to-load-path)
	    (normal-top-level-add-subdirs-to-load-path))))))
;; load-path
(add-to-load-path "elisp")

;; command <--> option
(setq ns-command-modifier (quote meta))
(setq ns-alternate-modifier (quote super))

;; C-h は、Backspace
(global-set-key "\C-h" 'delete-backward-char)

;; Tab は space 4つで
(setq-default tab-width 4 indent-tabs-mode nil)

;; 対応する括弧を光らせる
(show-paren-mode t)

;; beepしないようにする
(setq visible-bell t)

;; SKK
(require 'skk-autoloads)
;;; skk の「かなモードおよび変換の確定」
(setq skk-kakutei-key "\C-o")
;;; skk-server AquaSKK
;; (setq skk-server-portnum 1178)
;; (setq skk-server-host "localhost")
(setq skk-large-jisyo "~/.emacs.d/etc/skk/SKK-JISYO.L")
;;; skk起動コマンド
(global-set-key "\C-x\C-j" 'skk-mode)
;;; skk i-search
(add-hook 'isearch-mode-hook 'skk-isearch-mode-setup)
(add-hook 'isearch-mode-end-hook 'skk-isearch-mode-cleanup)
;; (setq skk-isearch-start-mode 'latin)
;;; Enterで改行しない
(setq skk-egg-like-newline t)

;; howm 一人お手軽 Wiki もどき
(setq howm-menu-lang 'ja)
(global-set-key "\C-c,," 'howm-menu)
(mapc
 (lambda (f)
   (autoload f
     "howm" "Hitori Otegaru Wiki Modoki" t))
 '(howm-menu howm-list-all howm-list-recent
             howm-list-grep howm-create
             howm-keyword-to-kill-ring))
(setq howm-directory "~/Dropbox/howm")

;; font
(create-fontset-from-ascii-font "Menlo-14:weight=normal:slant=normal" nil "menlokakugo")
(set-fontset-font "fontset-menlokakugo"
                  'unicode
                  (font-spec :family "Hiragino Kaku Gothic ProN" :size 16)
                  nil
                  'append)
(add-to-list 'default-frame-alist '(font . "fontset-menlokakugo"))

;; 透過
(set-frame-parameter (selected-frame) 'alpha '(88 50))

;; frame
(setq initial-frame-alist '((width . 150)(height . 40)(top . 0)(left . 0)))

;; color
(set-background-color "Black")
;; (set-foreground-color "White")
(set-foreground-color "Gray92")
(set-cursor-color "Yellow")

;; install-elisp
(require 'install-elisp)
(setq install-elisp-repository-directory "~/.emacs.d/elisp/")

;; auto-install
(require 'auto-install)
(setq auto-install-directory "~/.emacs.d/elisp/auto-install/")
(auto-install-update-emacswiki-package-name t)
(auto-install-compatibility-setup)

;; anything
(require 'anything-startup)

;; 現在行に色を付ける
;; (global-hl-line-mode t)
;; (set-face-background 'hl-line "darkolivegreen")

;; 行番号,桁番号を表示する
(line-number-mode t)
(column-number-mode t)

;; auto-complete
(require 'auto-complete-config)
(global-auto-complete-mode t)
(setq ac-use-menu-map t)
(define-key ac-menu-map "\C-n" 'ac-next)
(define-key ac-menu-map "\C-p" 'ac-previous)
