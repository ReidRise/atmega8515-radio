; Set-up Interupt Vector Table (IVT)
.import ivt.S

; Safely past IVT start code
.org 0x50
.import atmega8515.S
.import common.S 
.import usart.S

main:
    setup_stack 
    RCALL setup_timer
    
    LDI r17, 0x00 ; Baud Rate set to 9600 for 8Mhz
    LDI r16, 0x05 ; Baud Rate set to 9600 for 8Mhz
    RCALL USART_Init
    LDI R16, 0x55

BACK:
    COM R16
    OUT $PORTB, r16
    LDI Z(HIGH), welcome(HIGH)
    LDI Z(LOW), welcome(LOW)
    RCALL ReadLoop
    LDI Z(HIGH), help(HIGH)
    LDI Z(LOW), help(LOW)
    RCALL ReadLoop
    RCALL sleep_s
    RJMP BACK

welcome:
    .db "WELCOME TO THE ATMEGA8515 RADIO\n"
help:
    .db "\tHelp Menu:\n\t[1] start\n\t[2] stop\n"