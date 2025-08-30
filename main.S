RJMP main

.import atmega8515.S
.import logging.S

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
    LDI r31, welcome(HIGH)
    LDI r30, welcome(LOW)
    RCALL ReadLoop
    LDI r31, help(HIGH)
    LDI r30, help(LOW)
    RCALL ReadLoop
    RCALL sleep_s
    RJMP BACK

.org 0x400
welcome:
    .db "WELCOME TO THE ATMEGA8515 RADIO\n"
help:
    .db "\tHelp Menu:\n\t[1] start\n\t[2] stop\n"