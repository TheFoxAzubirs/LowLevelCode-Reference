.global _start
_start:
mov r0,$0
ldr r1,=mintaf
mov r2,$pjmintaf
mov r7,$4
svc #0
mov r0,$0
ldr r1,=nama
mov r2,$20
mov r7,$3
svc #0
ulang:
ldrb r2,[r1]
cmp r2,$0x0a
beq berinol
add r1,$1
b ulang
berinol:
mov r2,$0
strb r2,[r1]

ldr r0,=nama
mov r1,#0010 @bukatulis atau buat
ldr r2,=0666 @permissions
mov r7,#5 @ 5 is system call number for open 
svc #0
cmp r0,#0
blt exit @r0 contains fd (file descriptor, an integer)
mov r5,r0 @syscall @use stack as buffer 
sub sp, #8 @ stack is full descending, this is how we leave some  space 
/*
mov r1,#0x54
strb r1,[sp]
mov r1,#0x68
strb r1,[sp,#1]
mov r1,#0x65
strb r1,[sp,#2]
mov r1,#0x66
strb r1,[sp,#3]
mov r1,#'o'
strb r1,[sp,#4]
mov r1,#'x'
strb r1,[sp,#5]
mov r1,#'A'
strb r1,[sp,#6]
mov r1,#'z'
strb r1,[sp,#7]
mov r1,#'u'
strb r1,[sp,#8]
mov r1,#'b'
strb r1,[sp,#9]
mov r1,#'i'
strb r1,[sp,#10]
mov r1,#'r'
strb r1,[sp,#12]
mov r1,#'s'
strb r1,[sp,#13]
mov r1,#'\n'
strb r1,[sp,#14]
*/
mov r6,r0
mov r1,$0
mov r2,$2
mov r7,$19
svc #0
mov r8,r0
mov r0,r6

mov r2,$0
mov r7,$19
svc #0

mov r0,r6
mov r2,r8
mov r1,sp
mov r7, #3 @ 
svc #0 @fsync syscall

mov r0,$1
mov r7,$4
svc #0
mov r0,r5
mov r7,#118
svc #0 @close syscall
mov r7,#6 @ 6 is close
svc #0
exit: mov r0,$0
mov r7,$1
svc #0
.data
mintaf:
.ascii "Nama file : "
pjmintaf =.-mintaf
nama:
.byte  0x0a
