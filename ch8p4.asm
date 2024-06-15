; Chapter 8 Main Program
; Author: Kathryn Sheahen
; Date: 4/28/2024

INCLUDE Irvine32.inc 

FindThrees PROTO, 
	arr:PTR DWORD, 
	count:DWORD

.data
array1 DWORD 3, 2, 3, 1, 5, 3
array2 DWORD 3, 3, 3, 2, 1, 4
array3 DWORD 1, 2, 3, 3, 3, 6
arrayLength DWORD ?
prompt1 BYTE "Consecutive: ",0
prompt2 BYTE "Not consecutive: ",0
.code
main PROC
	
	mov arrayLength,LENGTHOF array1 ;length of array1
	INVOKE FindThrees, ADDR array1, arrayLength ;call FindThrees

    call Crlf   ;new line

    mov arrayLength,LENGTHOF array2 ;length of array2
	INVOKE FindThrees, ADDR array2, arrayLength ;call FindThrees
    
    call Crlf   ;new line

    mov arrayLength,LENGTHOF array3 ;length of array3
	INVOKE FindThrees, ADDR array3, arrayLength ;call FindThrees
        
    exit

main ENDP

FindThrees PROC USES eax esi ecx, arr:PTR DWORD, count:DWORD

    mov ecx,count   ;move count to ecx
    mov esi,arr     ;move arr to esi

    push ecx        ;push ecx to the stack
    push esi        ;push esi to the stack

    sub ecx,2       ;loop counter, stopped 2 elements before end

checkElement:
	mov edx,[esi]          ;current element
    cmp edx,3
    jne continueLoop       ;jump to continueLoop if not equal to 3

    mov edx,[esi + 4]       ;next element
    cmp edx,3
    jne continueLoop        ;jump to continueLoop if not equal to 3

    mov edx, [esi + 8]       ;next element
    cmp edx, 3
    jne continueLoop        ;jump to continueLoop if not equal to 3

    mov eax,1               ;set eax to 1 if consecutive
    jmp equal               ;jump to equal

continueLoop:
    add esi,4               ;move to the next element in the array
    loop checkElement        ;loop

equal:
    cmp eax,1       
    jne notEqual    ;if eax is not equal to 1, jump to notEqual

    mov edx,OFFSET prompt1
    call WriteString    ;display in console consecutive
    call WriteInt       ;return 1 in console
    jmp endLoop

notEqual:
    mov eax,0           ;set eax to 0 if not consecutive
    mov edx,OFFSET prompt2
    call WriteString    ;display in console not consecutive
    call WriteInt       ;return 0 in console
    jmp endLoop

endLoop:
    pop ecx
    pop esi
	ret
FindThrees ENDP
END main