USART_Init:
; Set baud Rate
    OUT $UBRRH, r17 
    OUT $UBRRL, r16 

; Store current value to avoid bashing
    PUSH r16

; Enable receiver and transmitter
    LDI r16, 0b00011000
    OUT $UCSRB, r16

; Set frame format: 8data, 1stop bit
    LDI r16, 0b10001110
    OUT $UCSRC, r16
    POP r16
    RET

USART_Transmit:

; Wait for empty transmit buffer
    SBIS $UCSRB, 5
    RJMP USART_Transmit

; Put data (r16) into buffer, sends the data
    OUT $UDR, r16
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
    POP r17
    POP r16
    RET

USART_Receive:
    ; Wait for data to be received
    SBIS $UCSRA, 7
    RJMP USART_Receive
    ; Get and return received data from buffer
    IN r16, $UDR
    RET