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
outRange			BYTE	"Invalid Input", 0
randomNums			DWORD	MAX		DUP(?)
title1				BYTE	"The unsorted random numbers:", 0
title2				BYTE	"The sorted list:", 0

.code
main PROC

	push	OFFSET instruct3
	push	OFFSET instruct2
	push	OFFSET instruct1
	push	OFFSET programTitle
	call	intro
	push	OFFSET outRange
	push	OFFSET prompt
	push	OFFSET request
	call	getData
	push	OFFSET randomNums
	push	request
	call	fillArray
	push	OFFSET title1
	push	OFFSET randomNums
	push	request
	call	displayList
	push	OFFSET randomNums
	push	request
	call	sortList
	push	OFFSET title2
	push	OFFSET randomNums
	push	request
	call	displayList

exit  ; exit to operating system
main ENDP

; (insert additional procedures here)
;*********************************************************************************************
;Procedure to introduce the program ,and give user instructions.
;receives: the program title and intructions
;returns: prints the program title and instructions
;preconditions:  none
;registers changed: edx
;*********************************************************************************************
intro	PROC

	push	ebp
	mov		ebp, esp
;Display your name and program title on the output screen.
	mov		edx, [ebp+8]
	call	WriteString
	call	CrLf
	call	Crlf
	call	CrLf
;Give User insructions
	mov		edx, [ebp+12]
	call	WriteString
	Call	CrLf
	mov		edx, [ebp+16]
	call	WriteString
	call	CrLf
	mov		edx, [ebp+20]
	call	WriteString
	Call	CrLf
	call	CrLf

	pop		ebp
	ret		16
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
UserInput:
	mov		edx, [ebp+12]			; prompt user
	call	WriteString
	call	ReadInt							; get users number
	mov		[ebx], eax						; tore in global variable request
	jmp		Valid1
Valid1:
	cmp		eax, MIN
	jl		NotValid
	jmp		Valid2
Valid2:
	cmp		eax, MAX
	jg		NotValid
	jmp		Valid
NotValid:
	mov		edx, [ebp+16]			; warn user input is not valid
	call	WriteString
	call	CrLf
	jmp		UserInput
Valid:

	pop		ebp
	ret		12

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
	mov		ebx, 0

again:
	mov		eax, HI				;From lecture 20 Random Rnge Example
	sub		eax, LO				;
	inc		eax					;
	call	RandomRange			;
	add		eax, LO				;
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

	push	ebp
	mov		ebp,esp
	mov		edx,[ebp+16]		; display title
	call	WriteString
	call	Crlf
	mov		ecx,[ebp+8]		;count in ecx
	mov		esi,[ebp+12]		;address of array in esi
	mov		edx, 0

more:
	cmp		ecx, 0
	je		quitt
	mov		eax,[esi]	;start with last element
	call	WriteDec			;display n-squared
	mov		al,' '
	call	WriteChar
	mov		al,32
	call	WriteChar
	call	WriteChar
	add		esi, 4
	cmp		edx, 9
	jge		NewLine
	inc		edx
	loop	more
moreDone:
	jmp		quitt
NewLine:
	call	CrLf
	mov		edx, 0
	dec		ecx
	jmp		more
quitt:
	call	Crlf
	
	pop	ebp
	ret	12

displayList	ENDP

;*********************************************************************************************
;Procedure to sort the array in decending order
;receives: address of array and value of request on system stack
;returns: a sorted array
:Notes: Bubble Sort implemented from book example
;preconditions:  none
;registers changed: eax, ebx, edx, esi
;*********************************************************************************************
sortList	PROC

	push	ebp
	mov		ebp,esp
	mov		ecx, [ebp+8]	
	dec		ecx				; decrement value by 1
L1:
	push	ecx				; save outer loop count
	mov		esi, [ebp+12]	; point to first value
L2:
	mov		eax, [esi]		; get array value
	cmp		[esi+4], eax	; compare arrary value with value next to it
	jl		L3				; if ESI > ESI+4, no swap
	xchg	eax, [esi+4]	; exchange the pair of values
	mov		[esi], eax
L3:
	add		esi, 4			; move both pointers forward
	loop	L2				; inner loop

	pop		ecx				; retrieve outer loop count
	loop	L1				; repeat the outer loop
	
	pop	ebp
	ret	8

sortList	ENDP



END main