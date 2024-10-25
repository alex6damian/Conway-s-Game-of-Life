.data
 m: .space 4 
 n: .space 4 
 p: .space 4 
 poz1: .space 4 
 poz2: .space 4 
 litere: .long 0
 k: .space 4
 cf: .space 4
 index: .long 0
 cnt: .long 3
 lungime_cheie: .long 0
 lungime_parola: .long 0
 matrix: .space 1600
 binary: .space 400
 sum: .long 0
 cheie: .space 1600
 next_gen: .space 1600
 linie: .space 4
 elm: .long 0
 coloane: .space 4
 cript: .space 40
 c: .byte
 caracter: .asciz "A"
 formatScanf: .asciz "%d"
 formatPrintf: .asciz "%d"
 linieNoua: .asciz "\n"
 formatchr: .asciz "%c"
 formatcript: .asciz "%s"
 prefix: .asciz "0x"

.text

.global main

main:
	lea matrix, %edi
citire_mnp:

	 pushl $m
	 pushl $formatScanf
	 call scanf
	 popl %ebx
	 popl %ebx
	 addl $2, m
	 
	 pushl $n
	 pushl $formatScanf
	 call scanf
	 popl %ebx
	 popl %ebx
	 addl $2, n

	 pushl $p
	 pushl $formatScanf
	 call scanf
	 popl %ebx
	 popl %ebx

	xor %ecx, %ecx
citire_celule:
	
	cmp p, %ecx
	je citire_k
	
	pushl %ecx
	pushl $poz1
	pushl $formatScanf
	call scanf
	popl %ebx
	popl %ebx
	popl %ecx
	incl poz1
		
	pushl %ecx
	pushl $poz2
	pushl $formatScanf
	call scanf
	popl %ebx
	popl %ebx
	popl %ecx
	incl poz2

	movl poz1, %eax
	movl $0, %edx
	mull n
	addl poz2, %eax
	
	movl $1, (%edi, %eax, 4)
	incl %ecx
	jmp citire_celule
citire_k:
	pushl $k
	pushl $formatScanf
	call scanf
	popl %ebx
	popl %ebx
	
	decl m
	movl n, %ebp
	decl %ebp
	xor %ecx, %ecx
        movl m, %eax
        movl $0, %edx
        incl %eax
        mull n
        for1:
        cmp %ecx, %eax
        je parc1
        lea matrix, %edi
        movl (%edi,%ecx,4), %ebx
        lea next_gen, %edi
        movl %ebx,(%edi,%ecx,4)
        incl %ecx
        jmp for1
        
        parc1:
	pushl $cf
	pushl $formatScanf
	call scanf
	addl $8,%esp
	
	push $cript
	push $formatcript
	call scanf
	add $8, %esi
	decl litere
	jmp prelucrare_matrix
	
inc_index:
        incl index
        xor %ecx, %ecx
        movl m, %eax
        incl %eax
        movl $0, %edx
        mull n
        for:
        cmp %ecx, %eax
        je prelucrare_matrix
        lea next_gen, %edi
        movl (%edi,%ecx,4), %ebx
        lea matrix, %edi
        movl %ebx,(%edi,%ecx,4)
        incl %ecx
        jmp for
prelucrare_matrix:
  movl index, %ecx
  cmp %ecx, k
  je parc2
  movl $1, linie
	for_linie:
	   movl linie, %ecx
	   cmp %ecx, m
	   je inc_index
	   movl $1, coloane
	   for_coloana:
	      movl coloane, %ecx
	      cmp %ecx, %ebp
	      je continuare1
	      movl linie, %eax
	      movl $0, %edx
	      mull n
	      addl coloane, %eax
	      lea matrix, %edi
	      	 movl $0, sum
	      	 movl n, %ecx
		 incl %ecx
		 subl %ecx, %eax
		 movl (%edi,%eax,4), %ebx
		 addl %ebx,sum
		 incl %eax
		 movl (%edi,%eax,4), %ebx
		 addl %ebx,sum
		 incl %eax
		 movl (%edi,%eax,4), %ebx
		 addl %ebx,sum
		 subl $2, %eax
		 addl n, %eax
		 movl (%edi,%eax,4), %ebx
		 addl %ebx,sum
		 addl $2, %eax
		 movl (%edi,%eax,4), %ebx
		 addl %ebx,sum
		 addl n, %eax
		 movl (%edi,%eax,4), %ebx
		 addl %ebx,sum
		 decl %eax
		 movl (%edi,%eax,4), %ebx
		 addl %ebx,sum
		 decl %eax
		 movl (%edi,%eax,4), %ebx
		 addl %ebx,sum
		 subl n, %eax
		 incl %eax   
	      movl sum, %ecx
	      movl (%edi, %eax, 4), %ebx
	      movl $0, %esi
	      cmp %ebx, %esi
	      je verif0
	      verif1:
	      	movl $2, %esi
		cmp %esi, %ecx
		je urm_elm
		movl $3, %esi
		cmp %esi, %ecx
		je urm_elm
		lea next_gen, %edi
		movl $0,(%edi,%eax,4)
	      verif0:
	      	movl $3, %esi
		cmp %ecx, %esi
		jne urm_elm
		lea next_gen, %edi
		movl $1, (%edi,%eax,4)
	 urm_elm:
	      incl coloane
	      jmp for_coloana
	continuare1:
		incl linie
		jmp for_linie
	

parc2:
 movl $0, index
 incl m
 mov $cript, %esi
 decl %esi
 movl cf, %ecx
 cmp $1, %ecx
 je parcurgere1_b4
 
parcurgere0:

	incl %esi
	incl litere
	mov (%esi), %eax
	cmp $0, %eax
	je afis_are
	xor %ecx, %ecx
	et_for:
		cmp $8, %ecx
		je next
		
		xor %edx, %edx
		movl $2, %ebx
		divl %ebx
		lea binary, %edi
		movl %edx,(%edi,%ecx,4)
		incl %ecx
		jmp et_for
 
next:

 xor %ecx, %ecx

incarcare_stiva:

  cmp $8, %ecx
  je zero
  lea binary, %edi
  movl (%edi,%ecx,4),%ebx
  pushl %ebx
  incl %ecx
  jmp incarcare_stiva

zero:

 xor %ecx, %ecx

next1:

 movl $8, %eax
 mull litere
 addl %ecx, %eax
 cmp $8, %ecx
 je parcurgere0
 popl %ebx
 lea cheie, %edi
 movl %ebx, (%edi, %eax, 4)
 incl %ecx
 jmp next1

val_litere:
 movl litere, %eax
 shr $1, %eax
 movl %eax, litere
 jmp afis 
afis_are:
 movl cf, %ecx
 cmp $1, %ecx
 je val_litere
afis: 
 movl litere, %eax
 shl $3, %eax
 movl %eax, lungime_parola
 movl m, %eax
 mull n
 movl %eax, lungime_cheie
 xor %ecx, %ecx
 movl $0,index

main1:

 movl index, %ecx
 cmp lungime_parola, %ecx
 je nextq

 lea cheie, %edi
 movl (%edi, %ecx, 4), %ebx
 movl %ecx, %eax
 xorl %edx, %edx
 divl lungime_cheie

 lea matrix, %edi
 pushl %ecx
 movl (%edi,%edx,4), %ecx
 xor %ecx, %ebx

 lea cheie, %edi
 popl %ecx

 movl %ebx, (%edi,%ecx,4)
 incl index
 jmp main1

nextq:
 movl cf, %ecx
 cmp $1, %ecx
 je afis_bin
 movl $0, index

a1:
 movl $4, %eax
 movl $1, %ebx
 movl $prefix, %ecx
 movl $3, %edx
 int $0x80
 movl litere, %ecx
 shl $1, %ecx
 movl %ecx, litere
transformare:

 movl $0, elm
 movl index, %ecx
 cmp litere, %ecx
 je afis_linie1
 
 movl index, %eax
 shl $2, %eax
 
 lea cheie, %edi
 
 movl (%edi,%eax,4),%ebx
 shl $3,%ebx
 addl %ebx, elm
 incl %eax
 
 movl (%edi,%eax,4),%ebx
 shl $2, %ebx
 addl %ebx, elm
 incl %eax
 
 movl (%edi,%eax,4),%ebx
 shl $1, %ebx
 addl %ebx, elm
 incl %eax
 
 movl (%edi,%eax,4),%ebx
 addl %ebx, elm
 movl elm, %ebx
 cmp $10, %ebx
 jge A
 addl $48, %ebx
 contafis:
 pushl %ebx
 pushl $formatchr
 call printf
 addl $8, %esp
 pushl $0
 call fflush
 addl $4, %esp
 inapoi:
 incl index
 jmp transformare
 
A:
 addl $55, %ebx
 jmp contafis

parcurgere1_b4:

 addl $2, %esi

parcurgere1:

 incl litere
 incl %esi
 mov (%esi), %al
 movb %al, c
 cmpb $0, c  
 je afis_are
 cmpb $65, c
 jl ceva
 subl $55, c 
 ceva: 
 movl $3, cnt
 movl c, %eax
 xorl %ecx, %ecx
 add_litere:

  cmp $4, %ecx
  je parcurgere1
  movl $2, %ebx
  xorl %edx, %edx
  divl %ebx
  
  pushl %eax 
  pushl %edx 
  	
	movl $4, %eax	# aici 
    mull litere
   	lea cheie,%edi
  	addl cnt, %eax
	popl %edx 
	movl %edx,(%edi,%eax,4)

  popl %eax 

  incl %ecx
  decl cnt
  jmp add_litere
 
afis_bin:

 movl $0, index

afisare:

 movl $0, sum
 movl $8, %eax
 mull index
 movl index, %ecx
 cmp litere, %ecx
 je afis_linie1
 lea cheie, %edi
 
 movl (%edi, %eax, 4), %ebx
 shl $7, %ebx
 addl %ebx, sum
 incl %eax
 
 movl (%edi, %eax, 4), %ebx
 shl $6, %ebx
 addl %ebx, sum
 incl %eax
 
 movl (%edi, %eax, 4), %ebx
 shl $5, %ebx
 addl %ebx, sum
 incl %eax
 
 movl (%edi, %eax, 4), %ebx
 shl $4, %ebx
 addl %ebx, sum
 incl %eax
 
 movl (%edi, %eax, 4), %ebx
 shl $3, %ebx
 addl %ebx, sum
 incl %eax
 
 movl (%edi, %eax, 4), %ebx
 shl $2, %ebx
 addl %ebx, sum
 incl %eax
 
 movl (%edi, %eax, 4), %ebx
 shl $1, %ebx
 addl %ebx, sum
 incl %eax
 
 movl (%edi, %eax, 4), %ebx
 addl %ebx, sum
 incl %eax
 
 movl $4, %eax
 movl $1, %ebx
 movl $sum, %ecx
 movl $1, %edx
 int $0x80

 pushl $0
 call fflush
 addl $4, %esp

 incl index
 jmp afisare
 
afis_linie1:

 movl $4, %eax
 movl $1, %ebx
 movl $linieNoua, %ecx
 movl $2, %edx
 int $0x80

exit:

 pushl $0
 call fflush
 addl $4, %esp

 movl $1, %eax
 xor %ebx, %ebx
 int $0x80
