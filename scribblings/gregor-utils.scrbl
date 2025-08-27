#lang scribble/manual

@(require
   scribble/example
   scribble/core
   (for-label racket/base
              racket/string
              ))

@title[#:tag "gregor-utils"]{
 Some utility functions around gregor
}

See also @Secref["time-scale" #:doc "gregor-doc"] gregor.

@author[@author+email["Hans Dijkema" "hans@dijkewijk.nl"]]

@defmodule[gregor-utils]{This module provides some utility functions around the gregor date module}

@section{Utility functions}

@defproc[(date->moment [dt (or/c date? date*?)]) moment?]{
  Converts a racket @racket{date} or @racket{date*} structure to a gregor @racket{moment}.
  When it converts, it will assumes two kinds of dates.

 @itemlist[
     @item{The first being a standard racket date structure with a time zone offset.}
     @item{The second for a date* structure, that will hold a named local timezone or 'UTC'.}
     ]

 This function will check if the date* structure is UTC time or local timezone. If it is
 local timezone, it will use the function @racket{(system-tzid)} of tzinfo to determine the
 local timezone id, that can be used to create a new gregor @racket{moment}.

 As date* will be either localtime or UTC, we're working with what we got. We can recognize UTC, but the
 timezone name will be something OS specific, e.g. on a dutch windows system: "West-Europa (zomertijd)".
 This is reported e.g. in the windows powershell command:

@#reader scribble/comment-reader
[racketblock
> get-timezone:

  Id                         : W. Europe Standard Time
  DisplayName                : (UTC+01:00) Amsterdam, Berlijn, Bern, Rome, Stockholm, Wenen
  StandardName               : West-Europa (standaardtijd)
  DaylightName               : West-Europa (zomertijd)
  BaseUtcOffset              : 01:00:00
  SupportsDaylightSavingTime : True
]

But, as the racket standard date functions only work with UTC and localtime, we can request the current timezone
tzinfo's @racket{(system-tzid)} for localtime and use UTC for univeral time.
}

@defproc[(moment->date [m moment?]) date*?]{
  Converts a gregor @racket{moment} to a standard racket @racket{date*}.
}

@defproc[(racket-date? [d any/c?]) boolean?]{
  Returns #t, if d is of racket's standard type @racket{date} or racket{date*}.
}
