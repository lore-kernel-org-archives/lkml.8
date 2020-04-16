Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1893C352BE
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:12:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86F68214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:12:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qBeLRWoQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437343AbgDPPMn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 11:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2395054AbgDPPMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 11:12:02 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43DE9C061A10
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 08:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=IG/nVE4zG2Lkusx6thOou1MQoJ//EowyXRXxLYsxvLE=; b=qBeLRWoQIiAEKCjYp4saQdefdy
        V+pgF2lf94Zv2heCZfA9sFzTlPJGJn7qWoA2omPfXiM3y/FftkjlOd+4NgCRyayrZaFuewFG2IQj7
        e4QNNu+aqQvQcOuPOA5FXlYyliMq307vYBQEe9l8481361tQRHUMyq9jY8FCXnQa9LRNspxEGu3SQ
        KqL29wojAPS4NO1quNeyBs0B3U9gvE9c/alooDBWTh0AUbrm5dMJIbxoxK2Lq93/bHZ4jEeLlRicS
        ozXJdWagVW9GEhu6/8RAp05igFS/7tmEqXjYsio5SrbTtlU3wzaFV/NPcHHH20Vd50Te6Ggkcd2Bn
        IRDpbBnQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jP6BJ-0003Wq-Es; Thu, 16 Apr 2020 15:11:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 43AC3307479;
        Thu, 16 Apr 2020 17:11:54 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 16BA02B0DE4BD; Thu, 16 Apr 2020 17:11:54 +0200 (CEST)
Message-Id: <20200416151025.064291444@infradead.org>
User-Agent: quilt/0.65
Date:   Thu, 16 Apr 2020 17:07:58 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     jpoimboe@redhat.com, alexandre.chartre@oracle.com
Cc:     linux-kernel@vger.kernel.org, jthierry@redhat.com,
        tglx@linutronix.de, x86@kernel.org, peterz@infradead.org
Subject: [RFC][PATCH 6/7] x86/retpoline: Out-of-line retpoline
References: <20200416150752.569029800@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since GCC generated code already uses out-of-line retpolines and objtool
has trouble with retpolines in alternatives, out-of-line them entirely.

This will enable objtool (once it's been taught a few more tricks) to
generate valid ORC data for the out-of-line copies, which means we can
correctly and reliably unwind through a retpoline.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/crypto/aesni-intel_asm.S            |    4 -
 arch/x86/crypto/camellia-aesni-avx-asm_64.S  |    2 
 arch/x86/crypto/camellia-aesni-avx2-asm_64.S |    2 
 arch/x86/crypto/crc32c-pcl-intel-asm_64.S    |   26 +++++-----
 arch/x86/entry/entry_32.S                    |    6 +-
 arch/x86/entry/entry_64.S                    |    2 
 arch/x86/include/asm/asm-prototypes.h        |    8 ++-
 arch/x86/include/asm/nospec-branch.h         |   68 ++++++++-------------------
 arch/x86/kernel/ftrace_32.S                  |    2 
 arch/x86/kernel/ftrace_64.S                  |    4 -
 arch/x86/lib/checksum_32.S                   |    4 -
 arch/x86/lib/retpoline.S                     |   25 ++++++++-
 arch/x86/platform/efi/efi_stub_64.S          |    2 
 13 files changed, 75 insertions(+), 80 deletions(-)

--- a/arch/x86/crypto/aesni-intel_asm.S
+++ b/arch/x86/crypto/aesni-intel_asm.S
@@ -2758,7 +2758,7 @@ SYM_FUNC_START(aesni_xts_crypt8)
 	pxor INC, STATE4
 	movdqu IV, 0x30(OUTP)
 
-	CALL_NOSPEC %r11
+	CALL_NOSPEC r11
 
 	movdqu 0x00(OUTP), INC
 	pxor INC, STATE1
@@ -2803,7 +2803,7 @@ SYM_FUNC_START(aesni_xts_crypt8)
 	_aesni_gf128mul_x_ble()
 	movups IV, (IVP)
 
-	CALL_NOSPEC %r11
+	CALL_NOSPEC r11
 
 	movdqu 0x40(OUTP), INC
 	pxor INC, STATE1
--- a/arch/x86/crypto/camellia-aesni-avx-asm_64.S
+++ b/arch/x86/crypto/camellia-aesni-avx-asm_64.S
@@ -1228,7 +1228,7 @@ SYM_FUNC_START_LOCAL(camellia_xts_crypt_
 	vpxor 14 * 16(%rax), %xmm15, %xmm14;
 	vpxor 15 * 16(%rax), %xmm15, %xmm15;
 
-	CALL_NOSPEC %r9;
+	CALL_NOSPEC r9;
 
 	addq $(16 * 16), %rsp;
 
--- a/arch/x86/crypto/camellia-aesni-avx2-asm_64.S
+++ b/arch/x86/crypto/camellia-aesni-avx2-asm_64.S
@@ -1339,7 +1339,7 @@ SYM_FUNC_START_LOCAL(camellia_xts_crypt_
 	vpxor 14 * 32(%rax), %ymm15, %ymm14;
 	vpxor 15 * 32(%rax), %ymm15, %ymm15;
 
-	CALL_NOSPEC %r9;
+	CALL_NOSPEC r9;
 
 	addq $(16 * 32), %rsp;
 
--- a/arch/x86/crypto/crc32c-pcl-intel-asm_64.S
+++ b/arch/x86/crypto/crc32c-pcl-intel-asm_64.S
@@ -75,7 +75,7 @@
 
 .text
 SYM_FUNC_START(crc_pcl)
-#define    bufp		%rdi
+#define    bufp		rdi
 #define    bufp_dw	%edi
 #define    bufp_w	%di
 #define    bufp_b	%dil
@@ -105,9 +105,9 @@ SYM_FUNC_START(crc_pcl)
 	## 1) ALIGN:
 	################################################################
 
-	mov     bufp, bufptmp		# rdi = *buf
-	neg     bufp
-	and     $7, bufp		# calculate the unalignment amount of
+	mov     %bufp, bufptmp		# rdi = *buf
+	neg     %bufp
+	and     $7, %bufp		# calculate the unalignment amount of
 					# the address
 	je      proc_block		# Skip if aligned
 
@@ -123,13 +123,13 @@ SYM_FUNC_START(crc_pcl)
 do_align:
 	#### Calculate CRC of unaligned bytes of the buffer (if any)
 	movq    (bufptmp), tmp		# load a quadward from the buffer
-	add     bufp, bufptmp		# align buffer pointer for quadword
+	add     %bufp, bufptmp		# align buffer pointer for quadword
 					# processing
-	sub     bufp, len		# update buffer length
+	sub     %bufp, len		# update buffer length
 align_loop:
 	crc32b  %bl, crc_init_dw 	# compute crc32 of 1-byte
 	shr     $8, tmp			# get next byte
-	dec     bufp
+	dec     %bufp
 	jne     align_loop
 
 proc_block:
@@ -169,10 +169,10 @@ SYM_FUNC_START(crc_pcl)
 	xor     crc2, crc2
 
 	## branch into array
-	lea	jump_table(%rip), bufp
-	movzxw  (bufp, %rax, 2), len
-	lea	crc_array(%rip), bufp
-	lea     (bufp, len, 1), bufp
+	lea	jump_table(%rip), %bufp
+	movzxw  (%bufp, %rax, 2), len
+	lea	crc_array(%rip), %bufp
+	lea     (%bufp, len, 1), %bufp
 	JMP_NOSPEC bufp
 
 	################################################################
@@ -218,9 +218,9 @@ LABEL crc_ %i
 	## 4) Combine three results:
 	################################################################
 
-	lea	(K_table-8)(%rip), bufp		# first entry is for idx 1
+	lea	(K_table-8)(%rip), %bufp		# first entry is for idx 1
 	shlq    $3, %rax			# rax *= 8
-	pmovzxdq (bufp,%rax), %xmm0		# 2 consts: K1:K2
+	pmovzxdq (%bufp,%rax), %xmm0		# 2 consts: K1:K2
 	leal	(%eax,%eax,2), %eax		# rax *= 3 (total *24)
 	subq    %rax, tmp			# tmp -= rax*24
 
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -816,7 +816,7 @@ SYM_CODE_START(ret_from_fork)
 
 	/* kernel thread */
 1:	movl	%edi, %eax
-	CALL_NOSPEC %ebx
+	CALL_NOSPEC ebx
 	/*
 	 * A kernel thread is allowed to return here after successfully
 	 * calling do_execve().  Exit to userspace to complete the execve()
@@ -1501,7 +1501,7 @@ SYM_CODE_START_LOCAL_NOALIGN(common_exce
 
 	TRACE_IRQS_OFF
 	movl	%esp, %eax			# pt_regs pointer
-	CALL_NOSPEC %edi
+	CALL_NOSPEC edi
 	jmp	ret_from_exception
 SYM_CODE_END(common_exception_read_cr2)
 
@@ -1522,7 +1522,7 @@ SYM_CODE_START_LOCAL_NOALIGN(common_exce
 
 	TRACE_IRQS_OFF
 	movl	%esp, %eax			# pt_regs pointer
-	CALL_NOSPEC %edi
+	CALL_NOSPEC edi
 	jmp	ret_from_exception
 SYM_CODE_END(common_exception)
 
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -349,7 +349,7 @@ SYM_CODE_START(ret_from_fork)
 	/* kernel thread */
 	UNWIND_HINT_EMPTY
 	movq	%r12, %rdi
-	CALL_NOSPEC %rbx
+	CALL_NOSPEC rbx
 	/*
 	 * A kernel thread is allowed to return here after successfully
 	 * calling do_execve().  Exit to userspace to complete the execve()
--- a/arch/x86/include/asm/asm-prototypes.h
+++ b/arch/x86/include/asm/asm-prototypes.h
@@ -18,9 +18,13 @@ extern void cmpxchg8b_emu(void);
 
 #ifdef CONFIG_RETPOLINE
 #ifdef CONFIG_X86_32
-#define INDIRECT_THUNK(reg) extern asmlinkage void __x86_indirect_thunk_e ## reg(void);
+#define INDIRECT_THUNK(reg) \
+	extern asmlinkage void __x86_retpoline_e ## reg(void); \
+	extern asmlinkage void __x86_indirect_thunk_e ## reg(void);
 #else
-#define INDIRECT_THUNK(reg) extern asmlinkage void __x86_indirect_thunk_r ## reg(void);
+#define INDIRECT_THUNK(reg) \
+	extern asmlinkage void __x86_retpoline_r ## reg(void); \
+	extern asmlinkage void __x86_indirect_thunk_r ## reg(void);
 INDIRECT_THUNK(8)
 INDIRECT_THUNK(9)
 INDIRECT_THUNK(10)
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -80,57 +80,34 @@
 .endm
 
 /*
- * These are the bare retpoline primitives for indirect jmp and call.
- * Do not use these directly; they only exist to make the ALTERNATIVE
- * invocation below less ugly.
- */
-.macro RETPOLINE_JMP reg:req
-	call	.Ldo_rop_\@
-.Lspec_trap_\@:
-	pause
-	lfence
-	jmp	.Lspec_trap_\@
-.Ldo_rop_\@:
-	mov	\reg, (%_ASM_SP)
-	ret
-.endm
-
-/*
- * This is a wrapper around RETPOLINE_JMP so the called function in reg
- * returns to the instruction after the macro.
- */
-.macro RETPOLINE_CALL reg:req
-	jmp	.Ldo_call_\@
-.Ldo_retpoline_jmp_\@:
-	RETPOLINE_JMP \reg
-.Ldo_call_\@:
-	call	.Ldo_retpoline_jmp_\@
-.endm
-
-/*
  * JMP_NOSPEC and CALL_NOSPEC macros can be used instead of a simple
  * indirect jmp/call which may be susceptible to the Spectre variant 2
  * attack.
  */
 .macro JMP_NOSPEC reg:req
 #ifdef CONFIG_RETPOLINE
-	ANNOTATE_NOSPEC_ALTERNATIVE
-	ALTERNATIVE_2 __stringify(ANNOTATE_RETPOLINE_SAFE; jmp *\reg),	\
-		__stringify(RETPOLINE_JMP \reg), X86_FEATURE_RETPOLINE,	\
-		__stringify(lfence; ANNOTATE_RETPOLINE_SAFE; jmp *\reg), X86_FEATURE_RETPOLINE_AMD
+	ALTERNATIVE_2 __stringify(ANNOTATE_RETPOLINE_SAFE; jmp *%\reg), \
+		      __stringify(jmp __x86_retpoline_\()\reg), X86_FEATURE_RETPOLINE, \
+		      __stringify(lfence; ANNOTATE_RETPOLINE_SAFE; jmp *%\reg), X86_FEATURE_RETPOLINE_AMD
 #else
-	jmp	*\reg
+	jmp	*%\reg
 #endif
 .endm
 
 .macro CALL_NOSPEC reg:req
 #ifdef CONFIG_RETPOLINE
-	ANNOTATE_NOSPEC_ALTERNATIVE
-	ALTERNATIVE_2 __stringify(ANNOTATE_RETPOLINE_SAFE; call *\reg),	\
-		__stringify(RETPOLINE_CALL \reg), X86_FEATURE_RETPOLINE,\
-		__stringify(lfence; ANNOTATE_RETPOLINE_SAFE; call *\reg), X86_FEATURE_RETPOLINE_AMD
+	/*
+	 * This cannot be ALTERNATIVE_2 like with JMP_NOSPEC, because ORC
+	 * unwind data is alternative invariant and needs stack modifying
+	 * instructions to be in the same place for all alternatives.
+	 *
+	 * IOW the CALL instruction must be at the same offset for all cases.
+	 */
+	ALTERNATIVE "", "lfence", X86_FEATURE_RETPOLINE_AMD
+	ALTERNATIVE __stringify(ANNOTATE_RETPOLINE_SAFE; call *%\reg), \
+		    __stringify(call __x86_retpoline_\reg), X86_FEATURE_RETPOLINE
 #else
-	call	*\reg
+	call	*%\reg
 #endif
 .endm
 
@@ -165,15 +142,12 @@
  */
 # define CALL_NOSPEC						\
 	ANNOTATE_NOSPEC_ALTERNATIVE				\
-	ALTERNATIVE_2(						\
-	ANNOTATE_RETPOLINE_SAFE					\
-	"call *%[thunk_target]\n",				\
-	"call __x86_indirect_thunk_%V[thunk_target]\n",		\
-	X86_FEATURE_RETPOLINE,					\
-	"lfence;\n"						\
-	ANNOTATE_RETPOLINE_SAFE					\
-	"call *%[thunk_target]\n",				\
-	X86_FEATURE_RETPOLINE_AMD)
+	ALTERNATIVE("", "lfence", X86_FEATURE_RETPOLINE_AMD)	\
+	ALTERNATIVE(ANNOTATE_RETPOLINE_SAFE			\
+		    "call *%[thunk_target]\n",			\
+		    "call __x86_indirect_thunk_%V[thunk_target]\n", \
+		    X86_FEATURE_RETPOLINE)
+
 # define THUNK_TARGET(addr) [thunk_target] "r" (addr)
 
 #else /* CONFIG_X86_32 */
--- a/arch/x86/kernel/ftrace_32.S
+++ b/arch/x86/kernel/ftrace_32.S
@@ -189,5 +189,5 @@ SYM_CODE_END(ftrace_graph_caller)
 	movl	%eax, %ecx
 	popl	%edx
 	popl	%eax
-	JMP_NOSPEC %ecx
+	JMP_NOSPEC ecx
 #endif
--- a/arch/x86/kernel/ftrace_64.S
+++ b/arch/x86/kernel/ftrace_64.S
@@ -301,7 +301,7 @@ SYM_INNER_LABEL(ftrace_stub, SYM_L_GLOBA
 	 * function tracing is enabled.
 	 */
 	movq ftrace_trace_function, %r8
-	CALL_NOSPEC %r8
+	CALL_NOSPEC r8
 	restore_mcount_regs
 
 	jmp fgraph_trace
@@ -338,6 +338,6 @@ SYM_CODE_START(return_to_handler)
 	movq 8(%rsp), %rdx
 	movq (%rsp), %rax
 	addq $24, %rsp
-	JMP_NOSPEC %rdi
+	JMP_NOSPEC rdi
 SYM_CODE_END(return_to_handler)
 #endif
--- a/arch/x86/lib/checksum_32.S
+++ b/arch/x86/lib/checksum_32.S
@@ -153,7 +153,7 @@ SYM_FUNC_START(csum_partial)
 	negl %ebx
 	lea 45f(%ebx,%ebx,2), %ebx
 	testl %esi, %esi
-	JMP_NOSPEC %ebx
+	JMP_NOSPEC ebx
 
 	# Handle 2-byte-aligned regions
 20:	addw (%esi), %ax
@@ -436,7 +436,7 @@ SYM_FUNC_START(csum_partial_copy_generic
 	andl $-32,%edx
 	lea 3f(%ebx,%ebx), %ebx
 	testl %esi, %esi 
-	JMP_NOSPEC %ebx
+	JMP_NOSPEC ebx
 1:	addl $64,%esi
 	addl $64,%edi 
 	SRC(movb -32(%edx),%bl)	; SRC(movb (%edx),%bl)
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -7,15 +7,30 @@
 #include <asm/alternative-asm.h>
 #include <asm/export.h>
 #include <asm/nospec-branch.h>
+#include <asm/unwind_hints.h>
+#include <asm/frame.h>
 
 .macro THUNK reg
 	.section .text.__x86.indirect_thunk
 
+	.align 32
 SYM_FUNC_START(__x86_indirect_thunk_\reg)
-	CFI_STARTPROC
-	JMP_NOSPEC %\reg
-	CFI_ENDPROC
+	JMP_NOSPEC \reg
 SYM_FUNC_END(__x86_indirect_thunk_\reg)
+
+SYM_FUNC_START_NOALIGN(__x86_retpoline_\reg)
+	ANNOTATE_INTRA_FUNCTION_CALL
+	call	.Ldo_rop_\@
+.Lspec_trap_\@:
+	pause
+	lfence
+	jmp	.Lspec_trap_\@
+.Ldo_rop_\@:
+	mov	%\reg, (%_ASM_SP)
+	UNWIND_HINT_RET_OFFSET
+	ret
+SYM_FUNC_END(__x86_retpoline_\reg)
+
 .endm
 
 /*
@@ -26,7 +41,9 @@ SYM_FUNC_END(__x86_indirect_thunk_\reg)
  * the simple and nasty way...
  */
 #define __EXPORT_THUNK(sym) _ASM_NOKPROBE(sym); EXPORT_SYMBOL(sym)
-#define EXPORT_THUNK(reg) __EXPORT_THUNK(__x86_indirect_thunk_ ## reg)
+#define EXPORT_THUNK(reg)				\
+	__EXPORT_THUNK(__x86_retpoline_ ## reg);	\
+	__EXPORT_THUNK(__x86_indirect_thunk_ ## reg)
 #define GENERATE_THUNK(reg) THUNK reg ; EXPORT_THUNK(reg)
 
 GENERATE_THUNK(_ASM_AX)
--- a/arch/x86/platform/efi/efi_stub_64.S
+++ b/arch/x86/platform/efi/efi_stub_64.S
@@ -21,7 +21,7 @@ SYM_FUNC_START(__efi_call)
 	mov %r8, %r9
 	mov %rcx, %r8
 	mov %rsi, %rcx
-	CALL_NOSPEC %rdi
+	CALL_NOSPEC rdi
 	leave
 	ret
 SYM_FUNC_END(__efi_call)


