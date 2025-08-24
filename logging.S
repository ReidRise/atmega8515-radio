USART_Init:
; Set baud rate

; Load r17 to URBBH 
    OUT 0x20, r17 
; Load r16 to URBBL 
    OUT 0x09, r16 

; Store current value to avoid bashing
    PUSH r16
    PUSH r17 

; Enable receiver and transmitter
    LDI r16, 0b00011000
    OUT 0x0a, r16

; Set frame format: 8data, 1stop bit
    LDI r16, 0b10001110
    OUT 0x20, r16
    POP r17
    POP r16
    RET

USART_Transmit:

; Wait for empty transmit buffer
    SBIS 0x0B, 5 ; UCSRA, UDRE
    RJMP USART_Transmit

; Put data (r16) into buffer, sends the data
    OUT 0x0C, r16
    RET

ReadLoop:
    PUSH r16
    PUSH r17

; Load next byte from flash to r16
ReadLoop1:
    LPM r16, Z+         
    LDI r17, 0x00
    SUB r16, r17
    BREQ Done
    RCALL sleep_ms

; e.g., send to UART
    RCALL USART_Transmit      
    RJMP ReadLoop1

Done:
    POP r16
    POP r17
    RET