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
prompt				BYTE	"How many numbers should be generated? [10 .. 200]: ", 0
randomNums			DWORD	MAX		DUP(?)


.code
main PROC

	call	intro
	push	OFFSET request
	call	getData
	push	OFFSET randomNums
	push	request
	call	fillArray
	push	OFFSET randomNums
	push	request
	call	displayList

exit  ; exit to operating system
main ENDP

; (insert additional procedures here)
;*********************************************************************************************
;Procedure to introduce the program ,and give user instructions.
;receives: none
;returns: none
;preconditions:  none
;registers changed: edx
;*********************************************************************************************
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

;*********************************************************************************************
;Procedure to get value for number of random intergers to generate
;receives: addresses of parameters on the system stack
;returns: user input values number of random integers to genrate
;preconditions:  none
;registers changed: eax, ebx, edx
;*********************************************************************************************
getData	PROC

;get an integer for CompNum

	push	ebp
	mov		ebp, esp						;set up stack
	mov		ebx, [ebp+8]
	mov		edx, OFFSET prompt				; prompt user
	call	WriteString
	call	ReadInt							; get users number
	mov		[ebx], eax						; tore in global variable request
	pop		ebp
	ret		4
getData	ENDP

;*********************************************************************************************
;Procedure to fill the array with random integers
;receives: addresses of array and value of request on the system stack
;returns: array filled with random integers
;preconditions:  none
;registers changed: eax, ebx, ecx, edi
;*********************************************************************************************
fillArray	PROC

;get an integer for CompNum

	call	Randomize
	push	ebp
	mov		ebp, esp						;set up stack
	mov		ecx, [ebp+8]
	mov		edi, [ebp+12]
	mov		ebx, 5

again:
	mov		eax, ebx
	mov		[edi], eax
	add		edi, 4
	inc		ebx
	loop	again

	pop		ebp
	ret		8
fillArray	ENDP

;*********************************************************************************************
;Procedure to display contents of array
;receives: address of array and value of request on system stack
;returns: printed array 10 items per line
;preconditions:  none
;registers changed: eax, ebx, edx, esi
;*********************************************************************************************
displayList	PROC


displayList	ENDP

END main