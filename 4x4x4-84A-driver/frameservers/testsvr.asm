;
; test animation
;

.set testsvr_byte_index = server_working_mem + 0    ; width 1
.set testsvr_byte       = server_working_mem + 1    ; width 1

.cseg
testsvr_init:
    ldi uprtempL, $07
    sts testsvr_byte_index, uprtempL
    ldi uprtempL, $01
    sts testsvr_byte, uprtempL

testsvr:
    ldi XH, BUFFER_ADDR_HIGH
    lds XL, back_buffer

    adiw XH:XL, FRAME_SIZE

    ldi uprtempL, FRAME_SIZE

testsvr_clear_loop:
    st -X, zeroreg
    dec uprtempL
    brne testsvr_clear_loop
    
    lds uprtempL, testsvr_byte_index
    lds uprtempH, testsvr_byte

    lsr uprtempH
    brcc testsvr_skip_layer_inc

    ori uprtempH, $80

    inc uprtempL
    andi uprtempL, 0b111

testsvr_skip_layer_inc:
    sts testsvr_byte_index, uprtempL
    sts testsvr_byte, uprtempH

    add XL, uprtempL
    st X, uprtempH

    ret
