;;waleedahmed(16-10876)
.MODEL SMALL
.STACK 100H  
.DATA 
 ST1 DB 'ENTER N: $' 
 ST2 DB 'ENTER R: $'
 ST3 DB 'NcR is: $'
 .CODE
                       
MAIN PROC       
      MOV AX,@DATA
      MOV DS,AX 
	  
      LEA DX,ST1
      MOV AH,9
      INT 21H    
      
      CALL INDEC 
      
      MOV BX, AX
      MOV CX,AX

      CALL FACTORIAL
      PUSH AX      
      
      CALL NEXTLINE
	  MOV AX, @DATA
      MOV DS,AX 

      LEA DX,ST2
      MOV AH,9
      INT 21H   
      	
      CALL INDEC 
	  
      MOV DX,AX
      SUB BX,AX
                            
      MOV CX,DX
      CALL FACTORIAL
      PUSH AX
             
      MOV CX,BX
      CALL FACTORIAL
      POP DX
      MUL DX
      MOV BX,AX
      POP AX
	  
      DIV BX                
	
	CALL OUTDEC
  
    MOV AH , 4CH
    INT 21H
   
MAIN ENDP
       
INDEC PROC
; Reads a decimal integer.
; input : user
; output: AX 
; uses: Nil
PUSH BX
PUSH CX
PUSH DX
; Display ? as a prompt
@BEGIN:

XOR BX, BX ;BX holds the num
XOR CX, CX ;CX holds the sign
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
          
        
 FACTORIAL PROC
; Compute factorial of N.
; input: CX = N
; output AX = N!
MOV AX,1
@FOR:
MUL CX
LOOP @FOR
RET
FACTORIAL ENDP
  
    
    
    OUTDEC PROC
; Display the contents of a register in decimal form.
; input : AX
; output: Contents of AX are displayed in decimal form.
; uses: Nil
PUSH AX
PUSH BX
PUSH CX
PUSH DX
OR AX, AX ;Is AX negative?
JGE @ENDIF ;No
PUSH AX
MOV AH, 2
MOV DL, '-'
INT 21H
POP AX
NEG AX
@ENDIF:
XOR CX, CX
MOV BX, 10D
@FORNEW:
XOR DX, DX
DIV BX
PUSH DX
INC CX
OR AX, AX
JNE @FORNEW
CALL NEXTLINE
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
          PUSH AX
          PUSH DX
 NEXTLINE PROC
    MOV AH ,2
    MOV DL,0DH
    INT 21H
    
    
    MOV AH ,2
    MOV DL,0AH
    INT 21H     
    
    RET
    POP DX
    POP AX
    NEXTLINE ENDP
  
END MAIN