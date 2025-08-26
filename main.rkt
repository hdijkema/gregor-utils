(module gregor-utils racket/base
  (require (prefix-in g: gregor)
           (prefix-in g: gregor/time)
           tzinfo
           racket/string
           )

  (provide date->moment
           moment->date
           racket-date?
           )

  (define (date*->moment dt)
    (unless (date*? dt)
      (error "dt must be of type date*"))
    ;; As date* will be localtime or UTC, we're working
    ;; with what we got. We can recognize UTC, but the
    ;; timezone name will be something OS specific, e.g.
    ;; on a dutch windows system: West-Europa (zomertijd)
    ;; which is reported e.g. by windows powershell command
    ;; get-timezone:
    ;;
    ;; Id                         : W. Europe Standard Time
    ;; DisplayName                : (UTC+01:00) Amsterdam, Berlijn, Bern, Rome, Stockholm, Wenen
    ;; StandardName               : West-Europa (standaardtijd)
    ;; DaylightName               : West-Europa (zomertijd)
    ;; BaseUtcOffset              : 01:00:00
    ;; SupportsDaylightSavingTime : True
    ;;
    ;; but, as the racket standard date functions only
    ;; work with UTC and localtime, we can request the current timezone
    ;; tzinfo's (system-tzid) for localtime
    ;; and use UTC for univeral time.
    (let ((dt-tz (string-downcase (string-trim (date*-time-zone-name dt)))))
      (g:moment (date-year dt)
                (date-month dt)
                (date-day dt)
                (date-hour dt)
                (date-minute dt)
                (date-second dt)
                (date*-nanosecond dt)
                #:tz (if (string=? dt-tz "utc")
                         "UTC"
                         (system-tzid))
                )
      )
    )

  (define (date->moment dt)
    (if (date*? dt)
        (date*->moment dt)
        (g:moment (date-year dt)
                  (date-month dt)
                  (date-day dt)
                  (date-hour dt)
                  (date-minute dt)
                  (date-second dt)
                  #:tz (date-time-zone-offset dt)))
    )

  (define (moment->date m)
    (make-date* (g:->seconds m)
               (g:->minutes m)
               (g:->hours m)
               (g:->day m)
               (g:->month m)
               (g:->year m)
               (g:->wday m)
               (g:->yday m)
               #f
               (g:->utc-offset m)
               0
               (g:->timezone m)
               )
    )

  (define (racket-date? dt)
    (date? dt))

  ); end of module