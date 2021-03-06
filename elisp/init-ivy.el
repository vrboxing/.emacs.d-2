;;; init-ivy.el --- -*- lexical-binding: t -*-
;;
;; Copyright (C) 2019 Mingde Zeng
;;
;; Filename: init-ivy.el
;; Description: Initialize Ivy
;; Author: Mingde (Matthew) Zeng
;; Created: Thu Mar 14 14:34:32 2019 (-0400)
;; Version: 1.2.0
;; URL: https://github.com/MatthewZMD/.emacs.d
;; Keywords: M-EMACS .emacs.d ivy amx counsel swiper
;; Compatibility: emacs-version >= 25.1
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Commentary:
;;
;; This initializes ivy, amx, counsel and swiper
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

;; IvyPackage
(def-package ivy
  :diminish ivy-mode
  :init (ivy-mode 1)
  :config
  (setq ivy-use-virtual-buffers t)
  (setq ivy-height 10)
  (setq ivy-on-del-error-function nil)
  (setq ivy-magic-slash-non-match-action 'ivy-magic-slash-non-match-create)
  (setq ivy-count-format "【%d/%d】")
  (setq ivy-wrap t))
;; -IvyPackage

;; AmxPac
(def-package amx
  :after (:any ivy ido)
  :config (amx-mode))
;; -AmxPac

;; CounselPac
(def-package counsel
  :after ivy
  :diminish counsel-mode
  :init (counsel-mode 1))
;; -CounselPac

;; SwiperPac
(def-package swiper
  :bind (("C-M-s" . swiper-isearch)
         ("C-s" . swiper)))
;; -SwiperPac

(provide 'init-ivy)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; init-ivy.el ends here
