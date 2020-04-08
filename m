Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E6AC2D0F4
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 21:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61A97206C0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 21:35:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mEFx6Fs/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728873AbgDHVfW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 17:35:22 -0400
Received: from merlin.infradead.org ([205.233.59.134]:44694 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728104AbgDHVfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 17:35:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hYvpeD8ViJpWeau2fKZ54CUW8DmbaBq6FzH3Gjdv0iA=; b=mEFx6Fs/atUlscqDPu9RyF1PB+
        SYhGBNnnTg6wCUTvJGAK0F7WkAVVGG40GTCvGVDRlFubpqT6JEw+mBLTHShddR7QePwb9WsYM8pBn
        xlx9bck+8M+QeU8yowymxtyWXFjjk75ktSKM/6WeqSiIRKSuzhgut9yHNuktetnqCQpHIN2tRPpsf
        AjQ952P822OxMz41uscMDS2EwyAdW7qqte59dAZQfHcpwjpkZwIsNez5O9zsdjezMCQbtEq3VIOue
        f7kY6UsX4jPp7w0bv3GBgTy7oSm0KutaggJlglePGd0kkY5+WWMaD+RQt8IWAudZKBLcBeN6ZFtmg
        R36k395Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jMILn-0004EQ-L1; Wed, 08 Apr 2020 21:35:12 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7AC789810C0; Wed,  8 Apr 2020 23:35:08 +0200 (CEST)
Date:   Wed, 8 Apr 2020 23:35:08 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Alexandre Chartre <alexandre.chartre@oracle.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, jthierry@redhat.com,
        tglx@linutronix.de
Subject: Re: [PATCH V2 9/9] x86/speculation: Remove all
 ANNOTATE_NOSPEC_ALTERNATIVE directives
Message-ID: <20200408213508.GA4496@worktop.programming.kicks-ass.net>
References: <20200407073142.20659-1-alexandre.chartre@oracle.com>
 <20200407073142.20659-10-alexandre.chartre@oracle.com>
 <20200407132837.GA20730@hirez.programming.kicks-ass.net>
 <20200407133454.n55u5nx33ruj73gx@treble>
 <89b10eb8-c030-b954-6be3-8830fc6a8daa@oracle.com>
 <3eb36fd2-9827-4c1b-681c-9c1d65c7582f@oracle.com>
 <20200407162838.5hlh6oom4oa45ugt@treble>
 <20200407172739.GI20730@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200407172739.GI20730@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 07, 2020 at 07:27:39PM +0200, Peter Zijlstra wrote:
> On Tue, Apr 07, 2020 at 11:28:38AM -0500, Josh Poimboeuf wrote:
> > Again, we should warn on stack changes inside alternatives, and then
> > look at converting RSB and retpolines to use static branches so they
> > have deterministic stacks.
> 
> I don't think we need static brancher, we should just out-of-line the
> whole thing.
> 
> Let me sort this CFI error Thomas is getting and then I'll attempt a
> patch along the lines I outlined in earlier emails.

Something like so.. seems to build and boot.

---
From: Peter Zijlstra (Intel) <peterz@infradead.org>
Subject: x86: Out-of-line retpoline

Since GCC generated code already uses out-of-line retpolines and objtool
has trouble with retpolines in alternatives, out-of-line them entirely.

This will enable objtool (once it's been taught a few more tricks) to
generate valid ORC data for the out-of-line copies, which means we can
correctly and reliably unwind through a retpoline.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/crypto/aesni-intel_asm.S            |  4 +--
 arch/x86/crypto/camellia-aesni-avx-asm_64.S  |  2 +-
 arch/x86/crypto/camellia-aesni-avx2-asm_64.S |  2 +-
 arch/x86/crypto/crc32c-pcl-intel-asm_64.S    | 26 ++++++++---------
 arch/x86/entry/entry_32.S                    |  6 ++--
 arch/x86/entry/entry_64.S                    |  2 +-
 arch/x86/include/asm/asm-prototypes.h        |  8 ++++--
 arch/x86/include/asm/nospec-branch.h         | 42 ++++------------------------
 arch/x86/kernel/ftrace_32.S                  |  2 +-
 arch/x86/kernel/ftrace_64.S                  |  4 +--
 arch/x86/lib/checksum_32.S                   |  4 +--
 arch/x86/lib/retpoline.S                     | 27 +++++++++++++++---
 arch/x86/platform/efi/efi_stub_64.S          |  2 +-
 13 files changed, 62 insertions(+), 69 deletions(-)

diff --git a/arch/x86/crypto/aesni-intel_asm.S b/arch/x86/crypto/aesni-intel_asm.S
index cad6e1bfa7d5..54e7d15dbd0d 100644
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
diff --git a/arch/x86/crypto/camellia-aesni-avx-asm_64.S b/arch/x86/crypto/camellia-aesni-avx-asm_64.S
index d01ddd73de65..ecc0a9a905c4 100644
--- a/arch/x86/crypto/camellia-aesni-avx-asm_64.S
+++ b/arch/x86/crypto/camellia-aesni-avx-asm_64.S
@@ -1228,7 +1228,7 @@ SYM_FUNC_START_LOCAL(camellia_xts_crypt_16way)
 	vpxor 14 * 16(%rax), %xmm15, %xmm14;
 	vpxor 15 * 16(%rax), %xmm15, %xmm15;

-	CALL_NOSPEC %r9;
+	CALL_NOSPEC r9;

 	addq $(16 * 16), %rsp;

diff --git a/arch/x86/crypto/camellia-aesni-avx2-asm_64.S b/arch/x86/crypto/camellia-aesni-avx2-asm_64.S
index 563ef6e83cdd..0907243c501c 100644
--- a/arch/x86/crypto/camellia-aesni-avx2-asm_64.S
+++ b/arch/x86/crypto/camellia-aesni-avx2-asm_64.S
@@ -1339,7 +1339,7 @@ SYM_FUNC_START_LOCAL(camellia_xts_crypt_32way)
 	vpxor 14 * 32(%rax), %ymm15, %ymm14;
 	vpxor 15 * 32(%rax), %ymm15, %ymm15;

-	CALL_NOSPEC %r9;
+	CALL_NOSPEC r9;

 	addq $(16 * 32), %rsp;

diff --git a/arch/x86/crypto/crc32c-pcl-intel-asm_64.S b/arch/x86/crypto/crc32c-pcl-intel-asm_64.S
index 0e6690e3618c..8501ec4532f4 100644
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
@@ -169,10 +169,10 @@ continue_block:
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

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index b67bae7091d7..7e7ffb7a5147 100644
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
@@ -1501,7 +1501,7 @@ SYM_CODE_START_LOCAL_NOALIGN(common_exception_read_cr2)

 	TRACE_IRQS_OFF
 	movl	%esp, %eax			# pt_regs pointer
-	CALL_NOSPEC %edi
+	CALL_NOSPEC edi
 	jmp	ret_from_exception
 SYM_CODE_END(common_exception_read_cr2)

@@ -1522,7 +1522,7 @@ SYM_CODE_START_LOCAL_NOALIGN(common_exception)

 	TRACE_IRQS_OFF
 	movl	%esp, %eax			# pt_regs pointer
-	CALL_NOSPEC %edi
+	CALL_NOSPEC edi
 	jmp	ret_from_exception
 SYM_CODE_END(common_exception)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 0e9504fabe52..168b798913bc 100644
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
diff --git a/arch/x86/include/asm/asm-prototypes.h b/arch/x86/include/asm/asm-prototypes.h
index ce92c4acc913..a75195f159cc 100644
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
diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 07e95dcb40ad..0a3ceab5e0ec 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -76,34 +76,6 @@
 	.popsection
 .endm

-/*
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
 /*
  * JMP_NOSPEC and CALL_NOSPEC macros can be used instead of a simple
  * indirect jmp/call which may be susceptible to the Spectre variant 2
@@ -111,10 +83,9 @@
  */
 .macro JMP_NOSPEC reg:req
 #ifdef CONFIG_RETPOLINE
-	ANNOTATE_NOSPEC_ALTERNATIVE
-	ALTERNATIVE_2 __stringify(ANNOTATE_RETPOLINE_SAFE; jmp *\reg),	\
-		__stringify(RETPOLINE_JMP \reg), X86_FEATURE_RETPOLINE,	\
-		__stringify(lfence; ANNOTATE_RETPOLINE_SAFE; jmp *\reg), X86_FEATURE_RETPOLINE_AMD
+	ALTERNATIVE_2 __stringify(ANNOTATE_RETPOLINE_SAFE; jmp *%\reg),	\
+		__stringify(jmp __x86_retpoline_\()\reg), X86_FEATURE_RETPOLINE,	\
+		__stringify(lfence; ANNOTATE_RETPOLINE_SAFE; jmp *%\reg), X86_FEATURE_RETPOLINE_AMD
 #else
 	jmp	*\reg
 #endif
@@ -122,10 +93,9 @@

 .macro CALL_NOSPEC reg:req
 #ifdef CONFIG_RETPOLINE
-	ANNOTATE_NOSPEC_ALTERNATIVE
-	ALTERNATIVE_2 __stringify(ANNOTATE_RETPOLINE_SAFE; call *\reg),	\
-		__stringify(RETPOLINE_CALL \reg), X86_FEATURE_RETPOLINE,\
-		__stringify(lfence; ANNOTATE_RETPOLINE_SAFE; call *\reg), X86_FEATURE_RETPOLINE_AMD
+	ALTERNATIVE_2 __stringify(ANNOTATE_RETPOLINE_SAFE; call *%\reg),	\
+		__stringify(call __x86_retpoline_\()\reg), X86_FEATURE_RETPOLINE,\
+		__stringify(lfence; ANNOTATE_RETPOLINE_SAFE; call *%\reg), X86_FEATURE_RETPOLINE_AMD
 #else
 	call	*\reg
 #endif
diff --git a/arch/x86/kernel/ftrace_32.S b/arch/x86/kernel/ftrace_32.S
index e8a9f8370112..e405fe1a8bf4 100644
--- a/arch/x86/kernel/ftrace_32.S
+++ b/arch/x86/kernel/ftrace_32.S
@@ -189,5 +189,5 @@ return_to_handler:
 	movl	%eax, %ecx
 	popl	%edx
 	popl	%eax
-	JMP_NOSPEC %ecx
+	JMP_NOSPEC ecx
 #endif
diff --git a/arch/x86/kernel/ftrace_64.S b/arch/x86/kernel/ftrace_64.S
index 369e61faacfe..2f2b5702e6cf 100644
--- a/arch/x86/kernel/ftrace_64.S
+++ b/arch/x86/kernel/ftrace_64.S
@@ -303,7 +303,7 @@ trace:
 	 * function tracing is enabled.
 	 */
 	movq ftrace_trace_function, %r8
-	CALL_NOSPEC %r8
+	CALL_NOSPEC r8
 	restore_mcount_regs

 	jmp fgraph_trace
@@ -340,6 +340,6 @@ SYM_CODE_START(return_to_handler)
 	movq 8(%rsp), %rdx
 	movq (%rsp), %rax
 	addq $24, %rsp
-	JMP_NOSPEC %rdi
+	JMP_NOSPEC rdi
 SYM_CODE_END(return_to_handler)
 #endif
diff --git a/arch/x86/lib/checksum_32.S b/arch/x86/lib/checksum_32.S
index 4742e8fa7ee7..d1d768912368 100644
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
@@ -436,7 +436,7 @@ SYM_FUNC_START(csum_partial_copy_generic)
 	andl $-32,%edx
 	lea 3f(%ebx,%ebx), %ebx
 	testl %esi, %esi
-	JMP_NOSPEC %ebx
+	JMP_NOSPEC ebx
 1:	addl $64,%esi
 	addl $64,%edi
 	SRC(movb -32(%edx),%bl)	; SRC(movb (%edx),%bl)
diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
index 363ec132df7e..d4aef0c856a6 100644
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -8,14 +8,31 @@
 #include <asm/export.h>
 #include <asm/nospec-branch.h>

+/*
+ * This is the bare retpoline primitive.
+ */
+.macro RETPOLINE_JMP reg:req
+	call	.Ldo_rop_\@
+.Lspec_trap_\@:
+	pause
+	lfence
+	jmp	.Lspec_trap_\@
+.Ldo_rop_\@:
+	mov	\reg, (%_ASM_SP)
+	ret
+.endm
+
 .macro THUNK reg
 	.section .text.__x86.indirect_thunk

+SYM_FUNC_START(__x86_retpoline_\reg)
+	RETPOLINE_JMP %\reg
+SYM_FUNC_END(__x86_retpoline_\reg)
+
 SYM_FUNC_START(__x86_indirect_thunk_\reg)
-	CFI_STARTPROC
-	JMP_NOSPEC %\reg
-	CFI_ENDPROC
+	JMP_NOSPEC \reg
 SYM_FUNC_END(__x86_indirect_thunk_\reg)
+
 .endm

 /*
@@ -26,7 +43,9 @@ SYM_FUNC_END(__x86_indirect_thunk_\reg)
  * the simple and nasty way...
  */
 #define __EXPORT_THUNK(sym) _ASM_NOKPROBE(sym); EXPORT_SYMBOL(sym)
-#define EXPORT_THUNK(reg) __EXPORT_THUNK(__x86_indirect_thunk_ ## reg)
+#define EXPORT_THUNK(reg)				\
+	__EXPORT_THUNK(__x86_retpoline_ ## reg);	\
+	__EXPORT_THUNK(__x86_indirect_thunk_ ## reg)
 #define GENERATE_THUNK(reg) THUNK reg ; EXPORT_THUNK(reg)

 GENERATE_THUNK(_ASM_AX)
diff --git a/arch/x86/platform/efi/efi_stub_64.S b/arch/x86/platform/efi/efi_stub_64.S
index 15da118f04f0..90380a17ab23 100644
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

