;;; init-lsp.el --- -*- lexical-binding: t -*-
;;
;; Copyright (C) 2019 Mingde Zeng
;;
;; Filename: init-lsp.el
;; Description: Initialize LSP
;; Author: Mingde (Matthew) Zeng
;; Created: Fri Mar 15 10:42:09 2019 (-0400)
;; Version: 1.2.0
;; URL: https://github.com/MatthewZMD/.emacs.d
;; Keywords: M-EMACS .emacs.d lsp lsp-java lsp-python
;; Compatibility: emacs-version >= 25.1
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Commentary:
;;
;; This initializes LSP mode , DAP mode, and its language-specific modes
;;
;; All of the current language-specfic modes:
;; LSP-Java
;; LSP-Python
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Change Log:
;;
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or (at
;; your option) any later version.
;;
;; This program is distributed in the hope that it will be useful, but
;; WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs.  If not, see <https://www.gnu.org/licenses/>.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Code:

(require 'init-package)
(require 'init-const)

;; LSPPac
(def-package lsp-mode
  :defer t
  :commands lsp
  :init
  (setq lsp-auto-guess-root nil)
  (setq lsp-prefer-flymake nil) ; Use flycheck instead of flymake
  (setq lsp-message-project-root-warning t)
  :hook ((java-mode . lsp)
         (python-mode . lsp)
         (js-mode . lsp)
         (typescript-mode . lsp)
         (html-mode . lsp)
         (c-mode . lsp)
         (c++-mode . lsp)))
;; -LSPPac

;; LSPUI
(def-package lsp-ui
  :after lsp-mode
  :diminish
  :commands lsp-ui-mode
  :custom-face
  (lsp-ui-doc-background ((t (:background nil))))
  (lsp-ui-doc-header ((t (:inherit (font-lock-string-face italic)))))
  :bind (:map lsp-ui-mode-map
              ([remap xref-find-definitions] . lsp-ui-peek-find-definitions)
              ([remap xref-find-references] . lsp-ui-peek-find-references)
              ("C-c u" . lsp-ui-imenu))
  :init
  (setq lsp-ui-doc-enable t
        lsp-ui-doc-header t
        lsp-ui-doc-include-signature t
        lsp-ui-doc-position 'top
        lsp-ui-doc-use-webkit t
        lsp-ui-doc-border (face-foreground 'default)
        lsp-ui-sideline-enable nil
        lsp-ui-sideline-ignore-duplicate t
        lsp-ui-sideline-show-code-actions nil)
  :config
  ;; WORKAROUND Hide mode-line of the lsp-ui-imenu buffer
  ;; https://github.com/emacs-lsp/lsp-ui/issues/243
  (defadvice lsp-ui-imenu (after hide-lsp-ui-imenu-mode-line activate)
    (setq mode-line-format nil)))
;; -LSPUI

;; LSPCompany
(def-package company-lsp
  :defer t
  :config
  (setq company-lsp-cache-candidates 'auto))
;; -LSPCompany

;; DAPPac
(def-package dap-mode
  :after lsp-mode
  :defer t
  :config
  (dap-mode t)
  (dap-ui-mode t))
;; -DAPPac


;; Language Specific Modes:

;; LSPJavaPac
(when *mvn*
  (def-package lsp-java
    :after lsp-mode
    :init
    (def-package request :defer t)
    :config
    (setq
     lsp-java-server-install-dir (expand-file-name "~/eclipse.jdt.ls/server/")
     lsp-java-workspace-dir (expand-file-name "~/eclipse.jdt.ls/workspace/"))))
;; -LSPJavaPac

;; LSPPythonPac
(def-package lsp-python-ms
  :after lsp-mode
  :config
  ;; for dev build of language server
  (setq lsp-python-ms-dir
        (expand-file-name "~/.emacs.d/python-language-server/output/bin/Release/"))
  ;; for executable of language server, if it's not symlinked on your PATH
  (setq lsp-python-ms-executable
        "~/.emacs.d/python-language-server/output/bin/Release/win10-x64/publish/Microsoft.Python.LanguageServer"))
;; -LSPPythonPac

(provide 'init-lsp)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; init-lsp.el ends here
