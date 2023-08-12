.data
v: .4byte 0x52,0x10,0x30,0x91,0x00,0x87
.4byte 0x78,0x00,0x19,0x03,0x01,0x25
.text
main:
    addi x11 x0 128
    addi x12 x0 132
    addi x13 x0 136
    addi x4 x0 0
    lw x15 0(x4)
    lw x16 0(x4)
    addi x8 x0 15
    j l
ed:
    lw x20 0 x13
    sw x20 0 x13  
fi:
    j fi
l2:
    beq x8 x0 ed
    lw x14 4(x4)
    add x16 x16 x14
    addi x4 x4 4
    addi x8 x8 -1
    sw x16 0 x12
    j l2
l2set:
    addi x8 x0 15
    addi x4 x0 0
    j l2
l:
    beq x8 x0 l2set
    lw x14 4(x4)
    add x15 x15 x14
    addi x4 x4 4
    addi x8 x8 -1
    sw x15 0 x11
    j l