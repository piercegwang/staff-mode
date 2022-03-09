;;; staff.el --- Description -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2022 Pierce Wang
;;
;; Author: Pierce Wang <https://github.com/piercewang>
;; Maintainer: Pierce Wang <pierce.g.wang@gmail.com>
;; Created: February 16, 2022
;; Modified: February 16, 2022
;; Version: 0.0.1
;; Keywords: abbrev bib c calendar comm convenience data docs emulations extensions faces files frames games hardware help hypermedia i18n internal languages lisp local maint mail matching mouse multimedia news outlines processes terminals tex tools unix vc wp
;; Homepage: https://github.com/piercewang/staff
;; Package-Requires: ((emacs "24.3"))
;;
;; This file is not part of GNU Emacs.
;;
;;; Commentary:
;;
;;  Description
;;
;;; Code:

(defvar staff-notes nil
  "Information about notes on the staff")

(defvar staff-clef nil
  "Clef of staff. If nil, don't draw")

(defvar staff-timesig nil
  "Time signature of staff.")

(defvar staff-lastedit nil
  "UTC Time/date of last edit. If nil, is a new staff.
(format-time-string %Y-%m-%dT%H:%M:%S+0000 \"Africa/Abidjan\")")

;; This is used below to remap existing bindings for cursor motion to
;; blackbox-specific bindings in blackbox-mode-map.  This is so that
;; users who prefer non-default key bindings for cursor motion don't
;; lose that when they play Blackbox.
(defun staff-redefine-key (map oldfun newfun)
  "Redefine keys that run the function OLDFUN to run NEWFUN instead."
  (define-key map (vector 'remap oldfun) newfun))

(defvar staff-mode-map
  (let ((map (make-keymap)))
    (suppress-keymap map t)
    (staff-redefine-key map 'backward-char 'staff-prev-element)
    (staff-redefine-key map 'left-char 'staff-prev-element)
    (staff-redefine-key map 'forward-char 'staff-next-element)
    (staff-redefine-key map 'right-char 'staff-next-element)
    (define-key map " " 'staff-enter-note)
    map))

(define-derived-mode staff-mode special-mode "Staff"
  "Major mode for editing staff paper in plain text."
  (setq truncate-lines t))

;;;###autoload
(defun staff (num)
  "Make a buffer with new staff paper.
Optional prefix argument is the number of measures; the default is 1."
  (interactive "P")
  (switch-to-buffer "*Staff*")
  (staff-mode)
  (if (staff-new-p)
      (progn (staff-clear)
             (staff-create (or num 1)))))

(defun staff-new-p ()
  "Check if buffer already has staff elements. Do this by
  checking if there is an ISO UTC string at beginning.")

(defun staff-clear ()
  "Clears buffer")

(defun staff-create (num)
  "Create a staff paper"
  ;; Things
  )

(provide 'staff)
;;; staff.el ends here
