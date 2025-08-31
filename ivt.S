.org 0x00
RJMP main ; Reset Handler

;.org 0x01
;RJMP EXT_INT0 ; IRQ0 Handler

;.org 0x02
;RJMP EXT_INT1 ; IRQ1 Handler

;.org 0x03
;RJMP TIM1_CAPT ; Timer1 Capture Handler

;.org 0x04
;RJMP TIM1_COMPA ; Timer1 Compare A Handler

;.org 0x05
;RJMP TIM1_COMPB ; Timer1 Compare B Handler

;.org 0x06
;RJMP TIM1_OVF ; Timer1 Overflow Handler

;.org 0x07
;RJMP TIM0_OVF ; Timer0 Overflow Handler

;.org 0x08
;RJMP SPI_STC ; SPI Transfer Complete Handler

;.org 0x09
;RJMP USART_RXC ; USART RX Complete Handler

;.org 0x0a
;RJMP USART_UDRE ; UDR0 Empty Handler

;.org 0x0b
;RJMP USART_TXC ; USART TX Complete Handler

;.org 0x0c
;RJMP ANA_COMP ; Analog Comparator Handler

;.org 0x0d
;RJMP EXT_INT2 ; IRQ2 Handler

;.org 0x0e
;RJMP TIM0_COMP ; Timer0 Compare Handler

;.org 0x0f
;RJMP EE_RDY ; EEPROM Ready Handler
