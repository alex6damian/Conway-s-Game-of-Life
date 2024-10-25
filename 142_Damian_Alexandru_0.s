.data
 element: .space 4
 m: .space 4 
 n: .space 4 
 p: .space 4 
 poz1: .space 4 
 poz2: .space 4 
 k: .space 4
 cn: .space 4
 index: .long 0
 matrix: .space 1600
 next_gen: .space 1600
 linie: .space 4
 sum: .long 0
 coloane: .space 4
 formatScanf: .asciz "%d"
 formatPrintf: .asciz "%d "
 linieNoua: .asciz "\n"

.text

.global main

main:
	lea matrix, %edi
citire_mnp:

	 pushl $m
	 pushl $formatScanf
	 call scanf 
	 addl $8, %esp 
	 addl $2, m
	 
	 pushl $n
	 pushl $formatScanf
	 call scanf
	 addl $8, %esp
	 addl $2, n

	 pushl $p
	 pushl $formatScanf
	 call scanf 
	 addl $8, %esp 

	xor %ecx, %ecx

citire_celule:
	
	cmp p, %ecx
	je citire_k
	
	pushl %ecx
	pushl $poz1
	pushl $formatScanf
	call scanf 
	addl $8, %esp 
	popl %ecx
	incl poz1
		
	pushl %ecx
	pushl $poz2
	pushl $formatScanf
	call scanf
	addl $8, %esp
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
	addl $8, %esp 
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
        je prelucrare_matrix
        lea matrix, %edi
        movl (%edi,%ecx,4), %ebx
        lea next_gen, %edi
        movl %ebx,(%edi,%ecx,4)
        incl %ecx
        jmp for1

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
  je afis_matrix
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
	
afis_matrix:
	
	movl $1, linie
	for_linii:
	   movl linie, %ecx
	   cmp %ecx, m
	   je exit
	   movl $1, coloane
	   for_coloane:
	      movl coloane, %ecx
	      cmp %ecx, %ebp
	      je continuare
	      movl linie, %eax
	      mull n
	      addl coloane, %eax
	     	
	     	lea matrix, %edi
	     	movl (%edi,%eax,4), %ebx
	     	push %ebx
	     	push $formatPrintf
	     	call printf
	     	pop %ebx
	     	pop %ebx
	     	
	     	pushl $0
	     	call fflush
	     	popl %ebx
	     	
	     	incl coloane
	     	jmp for_coloane
	     	
	continuare:
		movl $4, %eax
		movl $1, %ebx
		movl $linieNoua, %ecx
		movl $2, %edx
		int $0x80
		
		incl linie
		jmp for_linii
exit:

pushl $0
call fflush
addl $4, %esp

 movl $1,%eax
 movl $0, %ebx
 int $0x80
