; submitter: Chris Flodstrom
; Date: Oct 24, 2019
; Description: read each of the values from the array ‘input’ and place the values into the ‘output’ array but the location should be shifted by the amount in the ‘shift’ variable. 
; If the shift would cause a value to be outside of the bounds of ‘output’, then the values should “wrap around” to the front of ‘output’

.386
.model flat,stdcall
.stack 4096

ExitProcess proto,dwExitCode:dword

.data
shift dword 3
input byte 5,0ah,3,6,0ch
output byte lengthof input dup(?)


.code
	main proc

		mov eax, 0
		mov ebx, lengthof input
		sub ebx, shift
		mov ecx, shift
		mov esi, 0

	11:
		mov al, input[ebx] ;Move the value from input to al
		mov output[esi], al ;Move the value from al into output
		inc esi ;Increment the input index
		inc ebx;Increment the output index

	loop 11
		mov esi, 0 ;Start writing at index 0
		mov ebx, shift ;This loop will iterate shift times
		mov ecx, lengthof input ;Start reading at index length - shift.
		
	12:
		mov al, input[esi] ;Move the values from input into al
		mov output[ebx], al ;Move the value from al into output
		inc esi ;Increment the input index
		inc ebx ;Increment the output index
	loop 12

	mov esi, 0
	mov ecx, lengthof input
	13:
		mov al, output[esi]
		inc esi
	loop 13

		invoke ExitProcess, 0
	 main endp
end main
