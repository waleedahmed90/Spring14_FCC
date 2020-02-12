;;waleedahmed(16-10876)
.MODEL SMALL
.STACK 100H
.DATA
   MSG1  DB  'Enter First No : $'
   MSG2  DB  'Enter Second No : $'
   MSG3  DB  'The GCD is : $'
 
.CODE
   MAIN PROC
     MOV AX, @DATA                
     MOV DS, AX

     LEA DX, MSG1             
     MOV AH, 9
     INT 21H

     CALL INDEC                  

     PUSH AX     	
   	 CALL NEXTLINE
		
     LEA DX, MSG2             
     MOV AH, 9
     INT 21H

     CALL INDEC                  

     MOV BX, AX                   

     POP AX                       
    
     @A:                   
       XOR DX, DX                 
       DIV BX                    

       CMP DX, 0                 
       JE @END               

       MOV AX, BX                 
       MOV BX, DX                 
     JMP @A                  

     @END:               
	
	CALL NEXTLINE 	
     LEA DX, MSG3             
     MOV AH, 9
     INT 21H

     MOV AX, BX                  

     CALL OUTDEC                 
	 CALL NEXTLINE
	 
     MOV AH, 4CH              
     INT 21H
	 
   MAIN ENDP

INDEC PROC
     ; Reads a decimal integer.
     ; input : from user
     ; output: AX = decimal 
     ; uses: Nil
    PUSH BX
    PUSH CX
    PUSH DX

@BEGIN:
    XOR BX, BX       ;BX holds the num
    XOR CX, CX       ;CX holds the sign
        ; Read a character
    MOV AH, 1
    INT 21H
        ; is character - or '+'
    CMP AL, '-'
   JE @MINUS
   CMP AL, '+'
   JE @PLUS
  JMP @FOR2
  @MINUS:
        MOV CX, 1
  @PLUS:
       INT 21H
@FOR2:
   CMP AL, '0'
    JNGE @NOTDIGIT
    CMP AL, '9'
    JNLE @NOTDIGIT
    
    AND AX, 000FH
    PUSH AX
    MOV AX, 10
    MUL BX
    POP BX
    ADD BX, AX
    MOV AH, 1
    INT 21H
    CMP AL, 0DH
    JNE @FOR2

    MOV AX, BX
    OR CX, CX
    JE @EXIT
    NEG AX
    
@EXIT:
    POP DX
    POP CX
    POP BX
    RET
@NOTDIGIT:
   MOV AH, 2
   MOV DL, 0DH
   INT 21H
   MOV DL, 0AH
   INT 21H 
   JMP @BEGIN   
INDEC ENDP                                  
 
 OUTDEC PROC
  ; Display the contents of a register in decimal form.
   ; input : AX
   ; output: Contents of AX are displayed in decimal form.
   ; uses: Nil
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    
    OR AX, AX          ;Is AX negative?
    JGE @ENDIF      ;No
    PUSH AX
    MOV AH, 2
    MOV DL, '-'
    INT 21H
    POP AX
    NEG AX
@ENDIF:
XOR CX, CX
  MOV BX, 10D
@FOR:
  XOR DX, DX
  DIV BX
  PUSH DX
  INC CX
  OR AX, AX
  JNE @FOR 

MOV AH, 2
   
@FOR1:
    POP DX
    OR DL, 30H
    INT 21H
    LOOP @FOR1

    POP DX
    POP CX
    POP BX
    POP AX
    RET
OUTDEC ENDP

NEXTLINE PROC 
	MOV AH, 2
	MOV DL, 0DH
	INT 21H
	MOV DL, 0AH
	INT 21H
	RET
	NEXTLINE ENDP
 END MAIN