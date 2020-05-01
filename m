Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B56BC47253
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 18:23:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A24424968
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 18:23:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730698AbgEASWa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 14:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730595AbgEASWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 14:22:25 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F8DC061A0C;
        Fri,  1 May 2020 11:22:24 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jUaIl-0003dz-J5; Fri, 01 May 2020 20:22:19 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 4161B1C0330;
        Fri,  1 May 2020 20:22:19 +0200 (CEST)
Date:   Fri, 01 May 2020 18:22:19 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] x86: Change {JMP,CALL}_NOSPEC argument
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200428191700.151623523@infradead.org>
References: <20200428191700.151623523@infradead.org>
MIME-Version: 1.0
Message-ID: <158835733922.8414.7895958565407788672.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     34fdce6981b96920ced4e0ee56e9db3fb03a33f0
Gitweb:        https://git.kernel.org/tip/34fdce6981b96920ced4e0ee56e9db3fb03a33f0
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 22 Apr 2020 17:16:40 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 30 Apr 2020 20:14:34 +02:00

x86: Change {JMP,CALL}_NOSPEC argument

In order to change the {JMP,CALL}_NOSPEC macros to call out-of-line
versions of the retpoline magic, we need to remove the '%' from the
argument, such that we can paste it onto symbol names.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lkml.kernel.org/r/20200428191700.151623523@infradead.org
---
 arch/x86/crypto/aesni-intel_asm.S            |  4 +--
 arch/x86/crypto/camellia-aesni-avx-asm_64.S  |  2 +-
 arch/x86/crypto/camellia-aesni-avx2-asm_64.S |  2 +-
 arch/x86/crypto/crc32c-pcl-intel-asm_64.S    | 26 +++++++++----------
 arch/x86/entry/entry_32.S                    |  6 ++--
 arch/x86/entry/entry_64.S                    |  2 +-
 arch/x86/include/asm/nospec-branch.h         | 16 ++++++------
 arch/x86/kernel/ftrace_32.S                  |  2 +-
 arch/x86/kernel/ftrace_64.S                  |  4 +--
 arch/x86/lib/checksum_32.S                   |  4 +--
 arch/x86/platform/efi/efi_stub_64.S          |  2 +-
 11 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/arch/x86/crypto/aesni-intel_asm.S b/arch/x86/crypto/aesni-intel_asm.S
index cad6e1b..54e7d15 100644
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
index d01ddd7..ecc0a9a 100644
--- a/arch/x86/crypto/camellia-aesni-avx-asm_64.S
+++ b/arch/x86/crypto/camellia-aesni-avx-asm_64.S
@@ -1228,7 +1228,7 @@ SYM_FUNC_START_LOCAL(camellia_xts_crypt_16way)
 	vpxor 14 * 16(%rax), %xmm15, %xmm14;
 	vpxor 15 * 16(%rax), %xmm15, %xmm15;
 
-	CALL_NOSPEC %r9;
+	CALL_NOSPEC r9;
 
 	addq $(16 * 16), %rsp;
 
diff --git a/arch/x86/crypto/camellia-aesni-avx2-asm_64.S b/arch/x86/crypto/camellia-aesni-avx2-asm_64.S
index 563ef6e..0907243 100644
--- a/arch/x86/crypto/camellia-aesni-avx2-asm_64.S
+++ b/arch/x86/crypto/camellia-aesni-avx2-asm_64.S
@@ -1339,7 +1339,7 @@ SYM_FUNC_START_LOCAL(camellia_xts_crypt_32way)
 	vpxor 14 * 32(%rax), %ymm15, %ymm14;
 	vpxor 15 * 32(%rax), %ymm15, %ymm15;
 
-	CALL_NOSPEC %r9;
+	CALL_NOSPEC r9;
 
 	addq $(16 * 32), %rsp;
 
diff --git a/arch/x86/crypto/crc32c-pcl-intel-asm_64.S b/arch/x86/crypto/crc32c-pcl-intel-asm_64.S
index 0e6690e..8501ec4 100644
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
index b67bae7..7e7ffb7 100644
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
index 0e9504f..168b798 100644
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
diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index b8890e1..d3269b6 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -118,22 +118,22 @@
 .macro JMP_NOSPEC reg:req
 #ifdef CONFIG_RETPOLINE
 	ANNOTATE_NOSPEC_ALTERNATIVE
-	ALTERNATIVE_2 __stringify(ANNOTATE_RETPOLINE_SAFE; jmp *\reg),	\
-		__stringify(RETPOLINE_JMP \reg), X86_FEATURE_RETPOLINE,	\
-		__stringify(lfence; ANNOTATE_RETPOLINE_SAFE; jmp *\reg), X86_FEATURE_RETPOLINE_AMD
+	ALTERNATIVE_2 __stringify(ANNOTATE_RETPOLINE_SAFE; jmp *%\reg),	\
+		__stringify(RETPOLINE_JMP %\reg), X86_FEATURE_RETPOLINE,\
+		__stringify(lfence; ANNOTATE_RETPOLINE_SAFE; jmp *%\reg), X86_FEATURE_RETPOLINE_AMD
 #else
-	jmp	*\reg
+	jmp	*%\reg
 #endif
 .endm
 
 .macro CALL_NOSPEC reg:req
 #ifdef CONFIG_RETPOLINE
 	ANNOTATE_NOSPEC_ALTERNATIVE
-	ALTERNATIVE_2 __stringify(ANNOTATE_RETPOLINE_SAFE; call *\reg),	\
-		__stringify(RETPOLINE_CALL \reg), X86_FEATURE_RETPOLINE,\
-		__stringify(lfence; ANNOTATE_RETPOLINE_SAFE; call *\reg), X86_FEATURE_RETPOLINE_AMD
+	ALTERNATIVE_2 __stringify(ANNOTATE_RETPOLINE_SAFE; call *%\reg),\
+		__stringify(RETPOLINE_CALL %\reg), X86_FEATURE_RETPOLINE,\
+		__stringify(lfence; ANNOTATE_RETPOLINE_SAFE; call *%\reg), X86_FEATURE_RETPOLINE_AMD
 #else
-	call	*\reg
+	call	*%\reg
 #endif
 .endm
 
diff --git a/arch/x86/kernel/ftrace_32.S b/arch/x86/kernel/ftrace_32.S
index e8a9f83..e405fe1 100644
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
index 9738ed2..aa5d28a 100644
--- a/arch/x86/kernel/ftrace_64.S
+++ b/arch/x86/kernel/ftrace_64.S
@@ -301,7 +301,7 @@ trace:
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
diff --git a/arch/x86/lib/checksum_32.S b/arch/x86/lib/checksum_32.S
index 4742e8f..d1d7689 100644
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
diff --git a/arch/x86/platform/efi/efi_stub_64.S b/arch/x86/platform/efi/efi_stub_64.S
index 15da118..90380a1 100644
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
