        .arch armv8-a
        .file   "myfma.c"
        .text
        .align  2
        .global myFMA
        .type   myFMA, %function
myFMA:
        sub     sp, sp, #48
        str     w0, [sp, 28]
        str     x1, [sp, 16]
        str     x2, [sp, 8]
        str     x3, [sp]
        str     wzr, [sp, 44]
        b       .L2
.L3:
        ldr x1, [sp, 16]

        ld1 {v0.2s}, [x1], 8
        ld1 {v1.2s}, [x2], 8
        fmul  v0.2s, v0.2s, v1.2s
        ld1 {v2.2s}, [x3], 8
        fadd  v0.2s, v0.2s, v2.2s
        st1 {v0.2s}, [x1], 8

        ld1 {v0.2s}, [x1], 8
        ld1 {v1.2s}, [x2], 8
        fmul  v0.2s, v0.2s, v1.2s
        ld1 {v2.2s}, [x3], 8
        fadd  v0.2s, v0.2s, v2.2s
        st1 {v0.2s}, [x1], 8

        ldr     w0, [sp, 44]
        add     w0, w0, 4
        str     w0, [sp, 44]
.L2:
        ldr     w1, [sp, 44]
        ldr     w0, [sp, 28]
        cmp     w1, w0
        blt     .L3
        nop
        add     sp, sp, 48
        ret
        .size   myFMA, .-myFMA
        .ident  "GCC: (Ubuntu/Linaro 7.5.0-3ubuntu1~18.04) 7.5.0"
        .section        .note.GNU-stack,"",@progbits
