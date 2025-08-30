; Register Definitions
.define OSCCAL 0x04
.define PINE   0x05
.define DDRE   0x06
.define ACSR   0x08
.define UBRRL  0x09
.define UCSRB  0x0b
.define UCSRA  0x0a
.define UDR    0x0c
.define SPCR   0x0d
.define SPSR   0x0e
.define PIND   0x10
.define DDRD   0x11
.define PORTD  0x12
.define PINC   0x13
.define DDRC   0x14
.define PORTC  0x15
.define PINB   0x16
.define DDRB   0x17
.define PORTB  0x18
.define PINA   0x19
.define DDRA   0x1a
.define PORTA  0x1b
.define EECR   0x1c
.define EEDR   0x1d
.define EEARL  0x1e
.define EEARH  0x1f
.define UCSRC  0x20
.define UBRRH  0x20
.define WDTCR  0x21
.define ICR1L  0x24
.define ICR1H  0x25
.define OCR1BL 0x28
.define OCR1BH 0x29
.define OCR1AL 0x2a
.define OCR1AH 0x2b
.define TCNT1L 0x2c
.define TCNT1H 0x2d
.define TCCR1B 0x2e
.define TCCR1A 0x2f
.define SFIOR  0x30
.define OCR0   0x31
.define TCNT0  0x32
.define TCCR0  0x33
.define MCUCSR 0x34
.define MCUCR  0x35
.define EMCUCR 0x36
.define TIFRTO 0x38
.define TIMSK  0x39
.define GIFR   0x3a
.define GICR   0x3b
.define SPL    0x3d
.define SPH    0x3e
.define SREG   0x3f

; Setup stack
.macro setup_stack
LDI R16, 0x02   ; RAMEND = 0x025F
OUT $SPH, R16   ; SPH (Stack Pointer High) = 0x02
LDI R16, 0x5f
OUT $SPL, R16   ; SPL (Stack Pointer Low) = 0x5F

; Stand up Port B as a output
LDI R16, 0xff 
OUT $DDRB, R16   ;PORTB IS OUTPUT
LDI R16, 0x55 
OUT $PORTB, R16
.endmacro

; Set TCCR0 for Normal Mode and Prescaler 64
setup_timer: 
    LDS R16, $TCCR0
    ANDI R16, 0b00111111 ; ~((1<<FOC0) | (1<<WGM00)) 
    ORI R16, 0b00000110 ; (1<<CS02) | (1<<CS01) 
    STS $TCCR0, R16 
    RET

; sleep Function
sleep_ms: 
    LDI r22, 1
    ms_la: LDI r23, 1
    ms_l0: LDI r24, 1
    ms_l1: LDI r25, 1
    ms_l2: LDI r26, 3
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
    l1: LDI r25, 2
    l2: LDI r26, 255
    l3: LDI r27, 255
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