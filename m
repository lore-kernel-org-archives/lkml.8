Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39E73C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 21:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13FF9207FB
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 21:28:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388475AbgEXV24 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 17:28:56 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:43756 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388344AbgEXV2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 17:28:22 -0400
Received: by mail-qt1-f193.google.com with SMTP id o19so12555625qtr.10
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 14:28:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EiNylztOQpBR6wCf3cKAl0Ta/21Bjc2Z7ItuHMVbZTo=;
        b=QH3zYNevjYc5PuFRaKRw3XqrHRJwOgmxfIgM9wQ4dfMmSVjphEzvkLe4d16YlLjMPM
         UkeAoFD1KTfxvjQ30+SzWpMlVbESxGJrHJG+NfsnUPZqCDBchKJZcZMCBP5uuGw9iLZP
         oLg7OJrVNAX+/rApOU3JXUzc2nHVsSPq67es7KEUepG7kL9EOexjPjedtT36yz90jb4/
         01fIhAdVAnvb/4biPcPMtE4womfdKiGQSd36lvKo2F6qx3TY8eHFLemYRRLh56/ISumv
         dGT8l31eMzWGUdIC2sTguDeYWJeusUfrK3l25JeTOeNED2a6fi1IjdZBJZR6DSNoHk4t
         4WSA==
X-Gm-Message-State: AOAM530QitCQ/dEKK0Zivh3JV+BgBfPg4MgO9OlUzFg/vQV37uOpAf5w
        2qDlV/O3vCzDXBWDd/8D9ptjzftz
X-Google-Smtp-Source: ABdhPJz3wFThnHTRYrGaIB8hmrWaF1euo1aJZwwjRmupTgf5Nrthvhosir6At23rgDByU++5/IhzCg==
X-Received: by 2002:ac8:17e6:: with SMTP id r35mr26004054qtk.182.1590355700398;
        Sun, 24 May 2020 14:28:20 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id d14sm3665729qkg.25.2020.05.24.14.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2020 14:28:19 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Fangrui Song <maskray@google.com>,
        Dmitry Golovin <dima@golovin.in>,
        clang-built-linux@googlegroups.com,
        Ard Biesheuvel <ardb@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] x86/boot: Remove runtime relocations from .head.text code
Date:   Sun, 24 May 2020 17:28:14 -0400
Message-Id: <20200524212816.243139-3-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <CAKwvOd=qB+EoJwfAYUA9Hg7f9op4Q4W+TDnht8pLRG5bPX=29Q@mail.gmail.com>
References: <CAKwvOd=qB+EoJwfAYUA9Hg7f9op4Q4W+TDnht8pLRG5bPX=29Q@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The assembly code in head_{32,64}.S, while meant to be
position-independent, generates run-time relocations because it uses
instructions such as
	leal	gdt(%edx), %eax
which make the assembler and linker think that the code is using %edx as
an index into gdt, and hence gdt needs to be relocated to its run-time
address.

With the BFD linker, this generates a warning during the build:
  LD      arch/x86/boot/compressed/vmlinux
ld: arch/x86/boot/compressed/head_32.o: warning: relocation in read-only section `.head.text'
ld: warning: creating a DT_TEXTREL in object

With lld, Dmitry Golovin reports that this results in a link-time error
with default options (i.e. unless -z notext is explicitly passed):
  LD      arch/x86/boot/compressed/vmlinux
ld.lld: error: can't create dynamic relocation R_386_32 against local
symbol in readonly segment; recompile object files with -fPIC or pass
'-Wl,-z,notext' to allow text relocations in the output

Start fixing this by removing relocations from .head.text:
- On 32-bit, use a base register that holds the address of the GOT and
  reference symbol addresses using @GOTOFF, i.e.
	leal	gdt@GOTOFF(%edx), %eax
- On 64-bit, most of the code can (and already does) use %rip-relative
  addressing, however the .code32 bits can't, and the 64-bit code also
  needs to reference symbol addresses as they will be after moving the
  compressed kernel to the end of the decompression buffer.
  For these cases, reference the symbols as an offset to startup_32 to
  avoid creating relocations, i.e.
  	leal	(gdt-startup_32)(%bp), %eax
  This only works in .head.text as the subtraction cannot be represented
  as a PC-relative relocation unless startup_32 is in the same section
  as the code. Move efi32_pe_entry into .head.text so that it can use
  the same method to avoid relocations.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 arch/x86/boot/compressed/head_32.S | 40 +++++++------
 arch/x86/boot/compressed/head_64.S | 95 ++++++++++++++++++------------
 2 files changed, 77 insertions(+), 58 deletions(-)

diff --git a/arch/x86/boot/compressed/head_32.S b/arch/x86/boot/compressed/head_32.S
index dfa4131c65df..66657bb99aae 100644
--- a/arch/x86/boot/compressed/head_32.S
+++ b/arch/x86/boot/compressed/head_32.S
@@ -73,10 +73,10 @@ SYM_FUNC_START(startup_32)
 	leal	(BP_scratch+4)(%esi), %esp
 	call	1f
 1:	popl	%edx
-	subl	$1b, %edx
+	addl	$_GLOBAL_OFFSET_TABLE_+(.-1b), %edx
 
 	/* Load new GDT */
-	leal	gdt(%edx), %eax
+	leal	gdt@GOTOFF(%edx), %eax
 	movl	%eax, 2(%eax)
 	lgdt	(%eax)
 
@@ -89,14 +89,16 @@ SYM_FUNC_START(startup_32)
 	movl	%eax, %ss
 
 /*
- * %edx contains the address we are loaded at by the boot loader and %ebx
- * contains the address where we should move the kernel image temporarily
- * for safe in-place decompression. %ebp contains the address that the kernel
- * will be decompressed to.
+ * %edx contains the address we are loaded at by the boot loader (plus the
+ * offset to the GOT).  The below code calculates %ebx to be the address where
+ * we should move the kernel image temporarily for safe in-place decompression
+ * (again, plus the offset to the GOT).
+ *
+ * %ebp is calculated to be the address that the kernel will be decompressed to.
  */
 
 #ifdef CONFIG_RELOCATABLE
-	movl	%edx, %ebx
+	leal	startup_32@GOTOFF(%edx), %ebx
 
 #ifdef CONFIG_EFI_STUB
 /*
@@ -107,7 +109,7 @@ SYM_FUNC_START(startup_32)
  *	image_offset = startup_32 - image_base
  * Otherwise image_offset will be zero and has no effect on the calculations.
  */
-	subl    image_offset(%edx), %ebx
+	subl    image_offset@GOTOFF(%edx), %ebx
 #endif
 
 	movl	BP_kernel_alignment(%esi), %eax
@@ -124,10 +126,10 @@ SYM_FUNC_START(startup_32)
 	movl	%ebx, %ebp	// Save the output address for later
 	/* Target address to relocate to for decompression */
 	addl    BP_init_size(%esi), %ebx
-	subl    $_end, %ebx
+	subl    $_end@GOTOFF, %ebx
 
 	/* Set up the stack */
-	leal	boot_stack_end(%ebx), %esp
+	leal	boot_stack_end@GOTOFF(%ebx), %esp
 
 	/* Zero EFLAGS */
 	pushl	$0
@@ -138,8 +140,8 @@ SYM_FUNC_START(startup_32)
  * where decompression in place becomes safe.
  */
 	pushl	%esi
-	leal	(_bss-4)(%edx), %esi
-	leal	(_bss-4)(%ebx), %edi
+	leal	(_bss@GOTOFF-4)(%edx), %esi
+	leal	(_bss@GOTOFF-4)(%ebx), %edi
 	movl	$(_bss - startup_32), %ecx
 	shrl	$2, %ecx
 	std
@@ -152,14 +154,14 @@ SYM_FUNC_START(startup_32)
 	 * during extract_kernel below. To avoid any issues, repoint the GDTR
 	 * to the new copy of the GDT.
 	 */
-	leal	gdt(%ebx), %eax
+	leal	gdt@GOTOFF(%ebx), %eax
 	movl	%eax, 2(%eax)
 	lgdt	(%eax)
 
 /*
  * Jump to the relocated address.
  */
-	leal	.Lrelocated(%ebx), %eax
+	leal	.Lrelocated@GOTOFF(%ebx), %eax
 	jmp	*%eax
 SYM_FUNC_END(startup_32)
 
@@ -169,7 +171,7 @@ SYM_FUNC_START_ALIAS(efi_stub_entry)
 	add	$0x4, %esp
 	movl	8(%esp), %esi	/* save boot_params pointer */
 	call	efi_main
-	leal	startup_32(%eax), %eax
+	/* efi_main returns the possibly relocated address of startup_32 */
 	jmp	*%eax
 SYM_FUNC_END(efi32_stub_entry)
 SYM_FUNC_END_ALIAS(efi_stub_entry)
@@ -182,8 +184,8 @@ SYM_FUNC_START_LOCAL_NOALIGN(.Lrelocated)
  * Clear BSS (stack is currently empty)
  */
 	xorl	%eax, %eax
-	leal	_bss(%ebx), %edi
-	leal	_ebss(%ebx), %ecx
+	leal	_bss@GOTOFF(%ebx), %edi
+	leal	_ebss@GOTOFF(%ebx), %ecx
 	subl	%edi, %ecx
 	shrl	$2, %ecx
 	rep	stosl
@@ -197,9 +199,9 @@ SYM_FUNC_START_LOCAL_NOALIGN(.Lrelocated)
 	pushl	%ebp		/* output address */
 
 	pushl	$z_input_len	/* input_len */
-	leal	input_data(%ebx), %eax
+	leal	input_data@GOTOFF(%ebx), %eax
 	pushl	%eax		/* input_data */
-	leal	boot_heap(%ebx), %eax
+	leal	boot_heap@GOTOFF(%ebx), %eax
 	pushl	%eax		/* heap area */
 	pushl	%esi		/* real mode pointer */
 	call	extract_kernel	/* returns kernel location in %eax */
diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index 706fbf6eef53..f6ba32cd5702 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -42,6 +42,23 @@
 	.hidden _ebss
 
 	__HEAD
+
+/*
+ * This macro gives the link address of X. It's the same as X, since startup_32
+ * has link address 0, but defining it this way tells the assembler/linker that
+ * we want the link address, and not the run-time address of X. This prevents
+ * the linker from creating a run-time relocation entry for this reference.
+ *
+ * The macro should be used as a displacement with a base register containing
+ * the run-time address of startup_32 [i.e. la(X)(%reg)], or as an
+ * immediate [$ la(X)].
+ *
+ * This macro can only be used from within the .head.text section, since the
+ * expression requires startup_32 to be in the same section as the code being
+ * assembled.
+ */
+#define la(X) ((X) - startup_32)
+
 	.code32
 SYM_FUNC_START(startup_32)
 	/*
@@ -64,10 +81,10 @@ SYM_FUNC_START(startup_32)
 	leal	(BP_scratch+4)(%esi), %esp
 	call	1f
 1:	popl	%ebp
-	subl	$1b, %ebp
+	subl	$ la(1b), %ebp
 
 	/* Load new GDT with the 64bit segments using 32bit descriptor */
-	leal	gdt(%ebp), %eax
+	leal	la(gdt)(%ebp), %eax
 	movl	%eax, 2(%eax)
 	lgdt	(%eax)
 
@@ -80,7 +97,7 @@ SYM_FUNC_START(startup_32)
 	movl	%eax, %ss
 
 /* setup a stack and make sure cpu supports long mode. */
-	leal	boot_stack_end(%ebp), %esp
+	leal	la(boot_stack_end)(%ebp), %esp
 
 	call	verify_cpu
 	testl	%eax, %eax
@@ -107,7 +124,7 @@ SYM_FUNC_START(startup_32)
  *	image_offset = startup_32 - image_base
  * Otherwise image_offset will be zero and has no effect on the calculations.
  */
-	subl    image_offset(%ebp), %ebx
+	subl    la(image_offset)(%ebp), %ebx
 #endif
 
 	movl	BP_kernel_alignment(%esi), %eax
@@ -123,7 +140,7 @@ SYM_FUNC_START(startup_32)
 
 	/* Target address to relocate to for decompression */
 	addl	BP_init_size(%esi), %ebx
-	subl	$_end, %ebx
+	subl	$ la(_end), %ebx
 
 /*
  * Prepare for entering 64 bit mode
@@ -151,19 +168,19 @@ SYM_FUNC_START(startup_32)
 1:
 
 	/* Initialize Page tables to 0 */
-	leal	pgtable(%ebx), %edi
+	leal	la(pgtable)(%ebx), %edi
 	xorl	%eax, %eax
 	movl	$(BOOT_INIT_PGT_SIZE/4), %ecx
 	rep	stosl
 
 	/* Build Level 4 */
-	leal	pgtable + 0(%ebx), %edi
+	leal	la(pgtable + 0)(%ebx), %edi
 	leal	0x1007 (%edi), %eax
 	movl	%eax, 0(%edi)
 	addl	%edx, 4(%edi)
 
 	/* Build Level 3 */
-	leal	pgtable + 0x1000(%ebx), %edi
+	leal	la(pgtable + 0x1000)(%ebx), %edi
 	leal	0x1007(%edi), %eax
 	movl	$4, %ecx
 1:	movl	%eax, 0x00(%edi)
@@ -174,7 +191,7 @@ SYM_FUNC_START(startup_32)
 	jnz	1b
 
 	/* Build Level 2 */
-	leal	pgtable + 0x2000(%ebx), %edi
+	leal	la(pgtable + 0x2000)(%ebx), %edi
 	movl	$0x00000183, %eax
 	movl	$2048, %ecx
 1:	movl	%eax, 0(%edi)
@@ -185,7 +202,7 @@ SYM_FUNC_START(startup_32)
 	jnz	1b
 
 	/* Enable the boot page tables */
-	leal	pgtable(%ebx), %eax
+	leal	la(pgtable)(%ebx), %eax
 	movl	%eax, %cr3
 
 	/* Enable Long mode in EFER (Extended Feature Enable Register) */
@@ -211,17 +228,17 @@ SYM_FUNC_START(startup_32)
 	 * used to perform that far jump.
 	 */
 	pushl	$__KERNEL_CS
-	leal	startup_64(%ebp), %eax
+	leal	la(startup_64)(%ebp), %eax
 #ifdef CONFIG_EFI_MIXED
-	movl	efi32_boot_args(%ebp), %edi
+	movl	la(efi32_boot_args)(%ebp), %edi
 	cmp	$0, %edi
 	jz	1f
-	leal	efi64_stub_entry(%ebp), %eax
-	movl	efi32_boot_args+4(%ebp), %esi
-	movl	efi32_boot_args+8(%ebp), %edx	// saved bootparams pointer
+	leal	la(efi64_stub_entry)(%ebp), %eax
+	movl	la(efi32_boot_args+4)(%ebp), %esi
+	movl	la(efi32_boot_args+8)(%ebp), %edx	// saved bootparams pointer
 	cmpl	$0, %edx
 	jnz	1f
-	leal	efi_pe_entry(%ebp), %eax
+	leal	la(efi_pe_entry)(%ebp), %eax
 	movl	%edi, %ecx			// MS calling convention
 	movl	%esi, %edx
 1:
@@ -246,18 +263,18 @@ SYM_FUNC_START(efi32_stub_entry)
 
 	call	1f
 1:	pop	%ebp
-	subl	$1b, %ebp
+	subl	$ la(1b), %ebp
 
-	movl	%esi, efi32_boot_args+8(%ebp)
+	movl	%esi, la(efi32_boot_args+8)(%ebp)
 SYM_INNER_LABEL(efi32_pe_stub_entry, SYM_L_LOCAL)
-	movl	%ecx, efi32_boot_args(%ebp)
-	movl	%edx, efi32_boot_args+4(%ebp)
-	movb	$0, efi_is64(%ebp)
+	movl	%ecx, la(efi32_boot_args)(%ebp)
+	movl	%edx, la(efi32_boot_args+4)(%ebp)
+	movb	$0, la(efi_is64)(%ebp)
 
 	/* Save firmware GDTR and code/data selectors */
-	sgdtl	efi32_boot_gdt(%ebp)
-	movw	%cs, efi32_boot_cs(%ebp)
-	movw	%ds, efi32_boot_ds(%ebp)
+	sgdtl	la(efi32_boot_gdt)(%ebp)
+	movw	%cs, la(efi32_boot_cs)(%ebp)
+	movw	%ds, la(efi32_boot_ds)(%ebp)
 
 	/* Disable paging */
 	movl	%cr0, %eax
@@ -336,11 +353,11 @@ SYM_CODE_START(startup_64)
 
 	/* Target address to relocate to for decompression */
 	movl	BP_init_size(%rsi), %ebx
-	subl	$_end, %ebx
+	subl	$ la(_end), %ebx
 	addq	%rbp, %rbx
 
 	/* Set up the stack */
-	leaq	boot_stack_end(%rbx), %rsp
+	leaq	la(boot_stack_end)(%rbx), %rsp
 
 	/*
 	 * At this point we are in long mode with 4-level paging enabled,
@@ -406,7 +423,7 @@ SYM_CODE_START(startup_64)
 	lretq
 trampoline_return:
 	/* Restore the stack, the 32-bit trampoline uses its own stack */
-	leaq	boot_stack_end(%rbx), %rsp
+	leaq	la(boot_stack_end)(%rbx), %rsp
 
 	/*
 	 * cleanup_trampoline() would restore trampoline memory.
@@ -418,7 +435,7 @@ trampoline_return:
 	 * this function call.
 	 */
 	pushq	%rsi
-	leaq	top_pgtable(%rbx), %rdi
+	leaq	la(top_pgtable)(%rbx), %rdi
 	call	cleanup_trampoline
 	popq	%rsi
 
@@ -432,9 +449,9 @@ trampoline_return:
  */
 	pushq	%rsi
 	leaq	(_bss-8)(%rip), %rsi
-	leaq	(_bss-8)(%rbx), %rdi
-	movq	$_bss /* - $startup_32 */, %rcx
-	shrq	$3, %rcx
+	leaq	la(_bss-8)(%rbx), %rdi
+	movl	$(_bss - startup_32), %ecx
+	shrl	$3, %ecx
 	std
 	rep	movsq
 	cld
@@ -445,15 +462,15 @@ trampoline_return:
 	 * during extract_kernel below. To avoid any issues, repoint the GDTR
 	 * to the new copy of the GDT.
 	 */
-	leaq	gdt64(%rbx), %rax
-	leaq	gdt(%rbx), %rdx
+	leaq	la(gdt64)(%rbx), %rax
+	leaq	la(gdt)(%rbx), %rdx
 	movq	%rdx, 2(%rax)
 	lgdt	(%rax)
 
 /*
  * Jump to the relocated address.
  */
-	leaq	.Lrelocated(%rbx), %rax
+	leaq	la(.Lrelocated)(%rbx), %rax
 	jmp	*%rax
 SYM_CODE_END(startup_64)
 
@@ -465,7 +482,7 @@ SYM_FUNC_START_ALIAS(efi_stub_entry)
 	movq	%rdx, %rbx			/* save boot_params pointer */
 	call	efi_main
 	movq	%rbx,%rsi
-	leaq	startup_64(%rax), %rax
+	leaq	la(startup_64)(%rax), %rax
 	jmp	*%rax
 SYM_FUNC_END(efi64_stub_entry)
 SYM_FUNC_END_ALIAS(efi_stub_entry)
@@ -628,7 +645,7 @@ SYM_DATA(efi_is64, .byte 1)
 #define BS32_handle_protocol	88 // offsetof(efi_boot_services_32_t, handle_protocol)
 #define LI32_image_base		32 // offsetof(efi_loaded_image_32_t, image_base)
 
-	.text
+	__HEAD
 	.code32
 SYM_FUNC_START(efi32_pe_entry)
 /*
@@ -650,12 +667,12 @@ SYM_FUNC_START(efi32_pe_entry)
 
 	call	1f
 1:	pop	%ebx
-	subl	$1b, %ebx
+	subl	$ la(1b), %ebx
 
 	/* Get the loaded image protocol pointer from the image handle */
 	leal	-4(%ebp), %eax
 	pushl	%eax				// &loaded_image
-	leal	loaded_image_proto(%ebx), %eax
+	leal	la(loaded_image_proto)(%ebx), %eax
 	pushl	%eax				// pass the GUID address
 	pushl	8(%ebp)				// pass the image handle
 
@@ -690,7 +707,7 @@ SYM_FUNC_START(efi32_pe_entry)
 	 * use it before we get to the 64-bit efi_pe_entry() in C code.
 	 */
 	subl	%esi, %ebx
-	movl	%ebx, image_offset(%ebp)	// save image_offset
+	movl	%ebx, la(image_offset)(%ebp)	// save image_offset
 	jmp	efi32_pe_stub_entry
 
 2:	popl	%edi				// restore callee-save registers
-- 
2.26.2

