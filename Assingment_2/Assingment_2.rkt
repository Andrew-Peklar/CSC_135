; Author:       Andrew Peklar
; Teacher:      Doctor Gordon
; Assingment:   Homework Number 2
; Assign. Date: 02 November, 2016

;---------------------------------------------------------------------------------------------------- A,B

; Parts A and B: digit incrementer

; Combination of parts A and B from assingment. Takes input of an arbitrary number of digits
; and returns an integer constructed of o the original inputs digits, each incremented by one.

(define (digitinc x)
	(if (< x 10)(modulo (+ 1 x)10)
            ; recursively deconstructs the integer until the first digit is reached and increments it.
            ; That number is then multiplied by 10 and the next digit is added. Process repeats.
            ; modulo 10 is used to keep the digit at a value {0, 1, 2,..., 9} while "round" is used in 
            ; order to make lisp perform the division and return a whole number instead of leaving it as
            ; a fraction and crashing. 
            (+ (* 10 (digitinc (round (/ x 10))))(modulo (+ 1 x)10))))

; Test Case: (digitinc 1234) --> 2345
;---------------------------------------------------------------------------------------------------- C

; Part C: listPicker

; Takes 2 lists as inputs and outputs another list consisting of the values in the data
; list referenced by the values in the picker list.
(define (listPicker D P)
	(if (null? P)'() ;If Data is empty, noting is returned
 		(cons (listref D (car P))(listPicker D (cdr P)))))
                 ;call helper and recurse until items are found.

; Helper method which finds the element in the list
(define (listref firs secon)
	(if (= secon 1)(car firs)
                ; If the first element in list is the one we are looking for, return it.
                ; Otherwise cdr until found and decrement secon by one until true.
		(listref (cdr firs) (- secon 1))))

; Test Input : (listPicker '(42 3 "hello" 99 "bye" 7) '(4 3 3))
; Test Output: (99 "hello" "hello")
;---------------------------------------------------------------------------------------------------- D

; Part D: neshtlist.

; This helper method is a recursive implementation of the primitive "length" function.
(define (listSize L)
  (if (null? L) 0
      (+ 1 (listSize(cdr L)))))

; This second helper method is a recursive implementation of the primitive "reverse" function.
(define (reverseList L)
  (define (inner S E)
    (if (null? S) E
        (inner (cdr S) (cons( car S) E))))
  (inner L '()))

; The main "neshted" method takes in list parameter, surrounds the leftmost and rightmost elements
; in parens, and then repeats the process inward until "neshted". 
(define (neshtlist L)
  (define (aux L R n)
    (cond ((= n 0) '())
          ; If zero, return nothing
          ; If one , list the first element 
          ((= n 1) (list (car L)))
          ; Otherwise return the list
          ; Note parameter n is decresed by 2 at each recursion to allow for both the even & odd cases.
          (else (list (car L) (aux (cdr L) (cdr R) (- n 2)) (car R))))) 
  (aux L (reverseList L) (listSize L)))

; Test case even: (neshtlist '(1 2 3 4))   --> (1 (2 () 3) 4)
; Test case Odd : (neshtlist '(1 2 3 4 5)) --> (1 (2 (3) 4) 5) 
;---------------------------------------------------------------------------------------------------- E

; Part E: repChildren.

; This method takes in 4 inputs: (1) a tree in a list T
;        |                       (2) A key value K
;       \|/                      (3) A replacement Left  Branch value
;      \\|//                     (4) A replacement Right Branch value
;     \\\Y///
;     \\\|///                     The repchildren method takes searches for the
;    \\\\Y////                    key value in the tree and replaces the associated
;    \\\\|////                    branch with a new one. The Helper method insertNew 
;     `\\Y//`                     constructs the replacment branch to be inserted while 
;       `#`                       the main traverses the list recursively and searches for 
;      __#__                      the key value.


; Helper method that constructs the replacement.
; Method is really just here for clarity and sanity. 
(define (insertNew K L R)
  (list K (list L () ()) (list R () ())))

(define (repChildren T K L R)
        ;L and R children are empty == at a leaf ()
  (cond ((and (null? (car (cdr T))) (null? (car (cdr (cdr T))))) T)
        ;When the first element is equal to Key, insertNew branch
        ((= (car T) K) (list (insertNew K L R)))
        ;If it is not the key, cdr and recurse
        (else (cons (car T) (cons (repChildren (car (cdr T)) K L R)
                                  (repChildren (car (cdr (cdr T))) K L R))))))

; Test Input : (repChildren '(7 (3 () ()) (6 (5 () ()) ())) 6 1 2)
; Test Output:               (7 (3 () ()) (6 (1 () ()) (2 () ())))
;---------------------------------------------------------------------------------------------------- E

; Part F: Function majority

; Boolean check to see if odd
(define (isOdd E)
  (if (= 0 (modulo E 2)) #f
      ;If E % 2 = 0, not odd
      ;.......... 1, is  odd
                         #t))

; Boolean for even call (not sure if required)
(define (isEven E)
  (if (even? E) #t
                #f))

; Helper method to count the number of odd values in the list.
; More specifically, the number of returns that are true.
(define (countOdds B L)
  (cond ((null? L) 0)
        ; If null then zed
        ; else if element is false, increment and cdr.
        ((B (car L)) (+ 1 (countOdds B (cdr L))))
        ; Otherwise don't increment and go to next element
        (else (+ 0 (countOdds B (cdr L))))))


; Main method which determines if  a majority of the elements in a given list are even or odd.
(define (functionMajority B L)
  ; Checks number of odds vs the size of the list to determine if the majority are odd
  ; by dividing the listSize (function written in neshlist, part D) by 2 and comparing.
  (if (>= (countOdds B L) (/ (listSize L) 2)) #t
                                              #f))


; Test isOdd : (functionMajority isOdd '(4 8 3 6))  --> #f
; Test isEven: (functionMajority isEven '(4 8 3 6)) --> #t

 
