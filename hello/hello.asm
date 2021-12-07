    org 0              ; The memory address to place the following instructions 

    ld      a,0xab     ; load the accumulator with the hex value AB
    ld      b,0x10     ; load the B register with the hex value 10
loop:                  ; a label used in a jump instruction below
    add     a,b        ; A = A + B
    jp      loop       ; load the PC with the address represented by 'loop'

    ds      0x100,0    ; reserve 256 bytes of space and initialize them all to zero 

    end
