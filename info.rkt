#lang info

(define pkg-authors '(hnmdijkema))
(define version "0.1.2")
(define license 'Apache-2.0)
(define pkg-desc "A few utility functions around the gregor date module")

(define scribblings
  '(
    ("scribblings/gregor-utils.scrbl" () (library) "gregor-utils")
    )
  )

(define deps
  '("base" "gregor" "tzinfo"))

(define build-deps
  '("racket-doc"
    "rackunit-lib"
    "scribble-lib"))
