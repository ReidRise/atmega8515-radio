
; Setup stack
.macro setup_stack
LDI R16, 0x02   ; RAMEND = 0x025F
OUT 0x3E, R16   ; SPH (Stack Pointer High) = 0x02
LDI R16, 0x5f
OUT 0x3D, R16   ; SPL (Stack Pointer Low) = 0x5F

; Stand up Port B as a output
LDI R16, 0xff 
OUT 0x17, R16   ;PORTB IS OUTPUT
LDI R16, 0x55 
OUT 0x18, R16
.endmacro

; Set TCCR0 for Normal Mode and Prescaler 64
setup_timer: 
    LDS R16, 0x33
    ANDI R16, 0b00111111 ; ~((1<<FOC0) | (1<<WGM00)) 
    ORI R16, 0b00000110 ; (1<<CS02) | (1<<CS01) 
    STS 0x33, R16 
    RET

; sleep Function
sleep_ms: 
    LDI r22, 1
    ms_la: LDI r23, 1
    ms_l0: LDI r24, 1
    ms_l1: LDI r25, 1
    ms_l2: LDI r26, 5
    ms_l3: LDI r27, 100
    ms_l4: DEC r27
    NOP
    BRNE ms_l4
    DEC r26
    BRNE ms_l3
    DEC r25
    BRNE ms_l2
    DEC r24
    BRNE ms_l1
    DEC r23
    BRNE ms_l0
    DEC r22
    BREQ ms_la
    RET

; sleep Function
sleep_s: 
    LDI r22, 1
    la: LDI r23, 1
    l0: LDI r24, 1
    l1: LDI r25, 6
    l2: LDI r26, 90
    l3: LDI r27, 240
    l4: DEC r27
    NOP
    BRNE l4
    DEC r26
    BRNE l3
    DEC r25
    BRNE l2
    DEC r24
    BRNE l1
    DEC r23
    BRNE l0
    DEC r22
    BREQ la
    RET