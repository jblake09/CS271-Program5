TITLE Assignment 5     (PG5.asm)
; Author:
; Last Modified:			11/13/2018
; OSU email address:		blakejef@oregonstate.edu
; Course number/section:	CS271-400
; Project Number: 5                Due Date: 11/18/2018
; Description:	Introduce the program.
;				Get a user request in the range [min = 10 .. max = 200]
;				Generate request random integers in the range [lo = 100 .. hi = 999], storing them in consecutive elementsof an array
;				Display the list of integers before sorting, 10 numbers per line.
;				Sort the list in descending order (i.e., largest first).
;				Calculate and display the median value, rounded to the nearest integer.
;				Display the sorted list, 10 numbers per line.
INCLUDE Irvine32.inc

MIN = 10
MAX = 200
LO = 100
HI = 999

.data

programTitle		BYTE	"Sorting Random Integers			Programmed by Jeff Blake", 0
instruct1			BYTE	"This program generates random numbers in the range [100 .. 999],", 0
instruct2			BYTE	"displays the original list, sorts the list, and calculates the", 0
instruct3			BYTE	"median value. Finally, it displays the list sorted in descending order."
request				DWORD	?	; User inputted number that determines number of random integers to generate


.code
main PROC

	call	intro

exit  ; exit to operating system
main ENDP

; (insert additional procedures here)

;Procedure to introduce the program ,and give user instructions.
;receives: none
;returns: none
;preconditions:  none
;registers changed: edx
intro	PROC

;Display your name and program title on the output screen.
	mov		edx, OFFSET programTitle
	call	WriteString
	call	CrLf
	call	Crlf
	call	CrLf
;Give User insructions
	mov		edx, OFFSET instruct1
	call	WriteString
	Call	CrLf
	mov		edx, OFFSET instruct2
	call	WriteString
	call	CrLf
	mov		edx, OFFSET instruct3
	call	WriteString
	Call	CrLf
	call	CrLf


	ret
intro	ENDP

;Procedure to get value for number of random intergers to generate
;receives: none
;returns: user input values for global variables compNum
;preconditions:  none
;registers changed: eax, edx
getData	PROC

;get an integer for CompNum

	mov		edx, OFFSET instruct2
	call	WriteString
	call	ReadInt
	call	validate
	mov		compNum, eax

	ret
getData	ENDP

END main