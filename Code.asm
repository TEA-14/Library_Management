.model small
print macro m
    mov ah, 09
    lea dx, m
    int 21h
endm

.STACK 100H
.DATA
menu_header db 10,13, 'library management system$' 
menu_prompt db 10,13, 'enter your choice: $'

fiction_category db 10,13,' 1.fiction books$' 
nonfiction_category db 10,13,' 2.non fiction books$'
educational_category db 10,13,' 3.educational books$'
newline db 10,13,'3-for same menu$'                

book_number_prompt db 10,13,'enter the book number $'

; FICTION
fiction_1 db 10,13,'             1.to kill a mockingbird      10$    $' 
fiction_2 db 10,13,'             2.1984                      10$    $'
fiction_3 db 10,13,'             3.the great gatsby         10$    $'
fiction_4 db 10,13,'             4.moby dick                 20$    $'

; NON-FICTION
nonfiction_1 db 10,13,'   1.sapiens: a brief history of humankind  20$    $'
nonfiction_2 db 10,13,'   2.becoming                            20$    $' 
nonfiction_3 db 10,13,'   3.educated                            30$    $' 
nonfiction_4 db 10,13,'   4.the immortal life of henrietta lacks 30$    $'

; EDUCATIONAL
educational_1 db 10,13,'    1.introduction to algorithms             30$    $'
educational_2 db 10,13,'    2.the elements of style                  10$    $'
educational_3 db 10,13,'    3.campbell biology                      30$    $' 
educational_4 db 10,13,'    4.fundamentals of physics               20$    $'

; INVALID
invalid_option db 10,13,10,13,'  invalid option selected $'
try_again db 10,13,'      try again $'

order_prompt db 10,13,10,13,'enter your order: $'
quantity_prompt db 10,13,'quantity: $'
total_price_prompt db 10,13,'total price: $'

drink db ?  
quantity db ?  
price db ? 

go_back db 10,13,10,13,'1.go back to main menu$'
exit_option db 10,13,'2.exit$'

separator db 10,13,10,13,' $'

.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
    
TOP:
    print menu_header
    print separator ;NEWLINE
    mov price,'0'
     
    print fiction_category
    print nonfiction_category
    print educational_category
    print menu_prompt ; choice
    
    MOV AH,1    ; input
    INT 21H
    MOV BH,AL
    SUB BH,48
    
    CMP BH,1
    JE FICTION
    
    CMP BH,2
    JE NON_FICTION
    
    CMP BH,3
    JE EDUCATIONAL
    
    JMP INVALID
    
FICTION:
    LEA DX,separator ;NEWLINE
    MOV AH,9
    INT 21H

    print fiction_1
    print fiction_2
    print fiction_3
    print fiction_4
    print order_prompt
    
    MOV AH,1
    INT 21H
    MOV BL,AL
    SUB BL,48 
    
    CMP BL,1
    JE PRICE_10
    CMP BL,2
    JE PRICE_10
    CMP BL,3
    JE PRICE_10
    CMP BL,4
    JE PRICE_20
    JMP INVALID

NON_FICTION:
    LEA DX,separator ;NEWLINE
    MOV AH,9
    INT 21H

    print nonfiction_1
    print nonfiction_2
    print nonfiction_3
    print nonfiction_4
    print order_prompt
    
    MOV AH,1
    INT 21H
    MOV BL,AL
    SUB BL,48 
    
    CMP BL,1
   ; JE PRICE_90
    CMP BL,2
   ; JE PRICE_90
    CMP BL,3
    JE PRICE_30
    CMP BL,4
    ;JE PRICE_90
    JMP INVALID
    
EDUCATIONAL:
    LEA DX,separator ;NEWLINE
    MOV AH,9
    INT 21H

    print educational_1
    print educational_2
    print educational_3
    print educational_4
    print order_prompt
    
    MOV AH,1
    INT 21H
    MOV BL,AL
    SUB BL,48 
    
    CMP BL,1
   ; JE PRICE_90
    CMP BL,2
    JE PRICE_10
    CMP BL,3
    JE PRICE_30
    CMP BL,4
  
    JMP INVALID
    
PRICE_10:
    MOV BL,1
    LEA DX,quantity_prompt
    MOV AH,9
    INT 21H 
    
    MOV AH,1
    INT 21H
    SUB AL,48
    MUL BL 
    AAM 
    MOV CX,AX 
    ADD CH,48
    ADD CL,48
    
    print total_price_prompt
    MOV AH,2
    MOV DL,CH
    INT 21H
    MOV DL,CL
    INT 21H
    MOV DL,'0'
    INT 21H  
    
    MOV DL,47
    INT 21H
    MOV DL,45
    INT 21H

    LEA DX,go_back
    MOV AH,9
    INT 21H
    
    LEA DX,exit_option
    MOV AH,9
    INT 21H
    
    lea dx,separator
    mov ah,09
    int 21h 
    
    LEA DX,menu_prompt
    MOV AH,9
    INT 21H 
    
    MOV AH,1
    INT 21H          
    SUB AL,48
    CMP AL,1
    JE TOP
    cmp AL,3
    JE FICTION
    JMP EXIT

PRICE_20:
    MOV BL,2
    LEA DX,quantity_prompt
    MOV AH,9
    INT 21H 
    
    MOV AH,1
    INT 21H
    SUB AL,48
    MUL BL 
    AAM 
    MOV CX,AX 
    ADD CH,48
    ADD CL,48
    
    LEA DX,total_price_prompt
    MOV AH,9
    INT 21H
    MOV AH,2
    MOV DL,CH
    INT 21H
    MOV DL,CL
    INT 21H
    MOV DL,'0'
    INT 21H
    
    MOV DL,47
    INT 21H
    MOV DL,45
    INT 21H
    
    LEA DX,go_back
    MOV AH,9
    INT 21H
    
    LEA DX,exit_option
    MOV AH,9
    INT 21H
    
    LEA DX,menu_prompt
    MOV AH,9
    INT 21H 
    
    MOV AH,1
    INT 21H
    SUB AL,48
    CMP AL,1
    JE TOP
    JMP EXIT
    
PRICE_30:
    MOV BL,3
    LEA DX,quantity_prompt
    MOV AH,9
    INT 21H 
    
    MOV AH,1
    INT 21H
    SUB AL,48
    MUL BL 
    AAM 
    MOV CX,AX 
    ADD CH,48
    ADD CL,48
    
    LEA DX,total_price_prompt
    MOV AH,9
    INT 21H
    MOV AH,2
    MOV DL,CH
    INT 21H
    MOV DL,CL
    INT 21H
    MOV DL,'0'
    INT 21H
    
    MOV DL,47
    INT 21H
    MOV DL,45
    INT 21H
    
    LEA DX,go_back
    MOV AH,9
    INT 21H
    
    LEA DX,exit_option
    MOV AH,9
    INT 21H
    
    LEA DX,menu_prompt
    MOV AH,9
    INT 21H 
    
    MOV AH,1
    INT 21H
    SUB AL,48
    CMP AL,1
    JE TOP
    JMP EXIT
INVALID:
    LEA DX,invalid_option
    MOV AH,9
    INT 21H
    LEA DX,try_again
    MOV AH,9
    INT 21H
    JMP TOP

EXIT:
    MOV AH,4Ch
    INT 21H
MAIN ENDP
END MAIN