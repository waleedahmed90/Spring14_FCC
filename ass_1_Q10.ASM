;;binary input
.MODEL SMALL
.STACK 100H
.CODE
MAIN PROC
  MOV AH, 2
  MOV DL, '?'
  INT 21H
  XOR BX, BX
  MOV AH, 1
  INT 21H

CALL BINARYINPUT


; Move the cursor to next line
   MOV AH, 2
   MOV DL,0DH
   INT 21H
   MOV DL, 0AH
   INT 21H
    ; display the contents of BX in binary
   MOV AH, 2
   MOV CX, 16
  @FOR:
     ROL BX, 1
     JNC @DISPLAY_ZERO
       ; Display 1
     MOV DL, 31H
     INT 21H
    JMP @ENDFOR
   @DISPLAY_ZERO:
    MOV DL, 30H
    INT 21H
 @ENDFOR:
  LOOP @FOR
  MOV AH, 4CH
  INT 21H
MAIN ENDP

BINARYINPUT PROC

 @WHILE:
   CMP AL,0DH
   JE @ENDWHILE
   AND AL, 0FH
   SHL BX, 1
   OR BL, AL
   INT 21H
   JMP @WHILE
 @ENDWHILE:
RET

END MAIN
