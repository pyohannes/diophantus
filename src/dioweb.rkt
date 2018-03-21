#lang racket/base

(require xml
         racket/string
         racket/format
         symalg
         "dioweb-templates.rkt")

; ---------------------------------------
; functions returning HTML xexpr entities

(define (maintable formula)
  (with-handlers ([exn:fail? <errormessage>])
    (cond ((equal? formula "about")
           template-about)
          ((equal? formula "help")
           template-help)
          ((non-empty-string? formula)
           (xexpr->string (<formulaoutput> formula)))
          (else
            ""))))

(define (<errormessage> e)
  `(p ((class "error"))
      ,(exn-message e)))

(define (<formulainput> formula)
  (define js/submit "javascript:diowebOpen(document.getElementById('formula').value);")
  `(form ((action ,js/submit))
     (input ((type "text")
             (id "formula")
             (value ,formula)))
     (input ((type "submit")
             (value ">")))))

(define (<formulaoutput> formula)
  (define f/dexpr (parse formula))
  (define f/dexpr-simple (simplify f/dexpr))
  (define f/dexpr-deriv (simplify (differentiate f/dexpr-simple)))
  (list-non-null
    'table '((class "base main"))
    (<caption/tablerow> "Input")
    (<formula/tablerow> formula)
    (<caption/tablerow> "Formula")
    (<formula/tablerow> (format-math (latex f/dexpr-simple)
                                     f/dexpr-simple))
    (when (linear? f/dexpr-simple)
          (<caption/tablerow> "Plot"))
    (when (linear? f/dexpr-simple)
          (<formula/tablerow> (<plot> f/dexpr-simple)))
    (<caption/tablerow> "Derivative")
    (<formula/tablerow> (format-math (string-append
                                       "\\frac{\\delta}{\\delta x} = "
                                       (latex f/dexpr-deriv))
                                     f/dexpr-deriv))))

(define (<caption/tablerow> text)
   `(tr ((class "caption"))
      (td ,text)
      (td)))

(define (<formula/tablerow> text)
   `(tr ((class "formula"))
      (td)
      (td ,text)))

(define (<plot> f)
  `(div
     (span ((id "plot")))
     (script ((type "text/javascript"))
       ,(make-cdata #f #f (format "
           functionPlot({
               width: 550,
               height: 350,
               target: '#plot',
               data: [{
                   fn: '~a',
                   graphType: 'polyline',
                   color: 'red'
               }]
           })" (infix f #t))))))

; -----------------
; Utility functions

(define (formula-from-command-line)
  (decode-uri-arg
    (string-join
      (vector->list (current-command-line-arguments))
      "&")))

(define (decode-uri-arg s)
  (for/fold ([s s])
            ([char '("(" ")" "*" "^" )])
    (string-replace s (string-append "\\" char) char)))

(define (list-non-null . args)
  (define (non-null? l)
    (not (or (null? l) (void? l))))
  (apply list
         (filter non-null? args)))

(define (format-math latex dexpr)
  (define formula 
    (string-append "$$" latex "$$"))
  (define href
    (string-append "javascript:diowebOpen('"
                   (~a (infix dexpr))
                   "');"))
  `(a ((href ,href))
      ,formula))

(define (parse s)
  (with-handlers ([exn:fail? (lambda (e)
                               (parse-infix s))])
    (parse-sexpr (string->sexpr s))))

(define (string->sexpr s)
  (define port (open-input-string s))
  (define sexpr (read port))
  (if (eof-object? (read port))
      sexpr
      (error "Not a valid s-expressions: " s)))

; -----------------
; main invocation

(define (main)
  (define formula (formula-from-command-line))
  (printf template-main formula (maintable formula)))

(main)
