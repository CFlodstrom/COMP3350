; Author: Chris Flodstrom
; Username: czf0038
; Project4
; 15 November 2019
; Description create a program that will determine if two strings are anagrams. If the two strings are anagrams, then EAX will have the value 1 after the code has completed. 
; If they are not anagrams, then EAX will have the value 0. 
;
; I referenced StackOverflow for assistance with jumps and which one to use for each situation


.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

.data
    s1 byte "GARDEN"
    s2 byte "DANGER"
    c1 byte 26 dup(0)               ;counter for each letter in s1
    c2 byte 26 dup(0)               ;counter for each letter in s2
.code
    main proc
        mov eax, 0                  ;we will assume that we do not have an anagram
        mov ecx, lengthof s1        ;(1) iterate lengthof s1 times
        mov esi, 0                  ;start at the first byte of s1 and s2

        CounterLoop:                           ;this will increment the proper 'elements' of c1 and c2
				movzx edi, s1[esi]		       ;move the value from s1 into edi
				inc c1[edi - 65]               ;(2) increment the counter at the value - 65. 
											   ;subtract 65 because the ASCII value of A is 65, B is 66, C is 67...
											   ;when you subtract 65 then the sum of all the As will be stored in 'index' 0
											   ;Bs in 'index' 1, Cs in 'index' 2...
				movzx edi, s2[esi]             ;(3) Do the same procedure for s2
				inc c2[edi - 65]               ;(4) increment the second counter at the value - 65.
				inc esi						   ;increment esi
            loop CounterLoop				   ;after this loop terminates our couter arrays will have the proper values
            
			cmp edi, 0							       ;(5) start checking the counter arrays at 'index' 0
            mov ecx, lengthof c1                       ;(6)iterate lengthof c1 times

        VerifyLoop:			
				mov b1, c1[ecx]                       ;(7) move value of c1 into bl
				cmp b1, c2[ecx]                       ;(8) check bl vs the value of c2
				jne NoAna						      ;(9) if they are not equal then we do not have an anagram.  jump to NoAna
				inc esi							      ;increment esi
            loop VerifyLoop
            mov eax, 1							;if the loop terminates and we have not jumped then we know we have an anagram

            ; you can uncomment the following line to print out the result
            ; call WriteInt

        NoAna:
            invoke ExitProcess, 0

    main endp
end main