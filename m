Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83331C83007
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 19:20:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5ABED2070B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 19:20:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="e0NKFa83"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729105AbgD1TUC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 15:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729019AbgD1TTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 15:19:53 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4973DC03C1AD
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 12:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=5YgQtQCUtVGS9kzMe6SLPbJYLmwHlRLif9PX8QeAZ8E=; b=e0NKFa83sllsU/D7m3gvoZkVWy
        iXZwRKz8WoSxJYaEn3g4g8DHVZOZ+3+WLSav+Ak8o2zsP3AZfeZD41nC/kS2lnYCFoDFi+pejUnLk
        xt9RJCHjPoFUzCHIZkNhgzkFBVvHHnonOSFfJhqpd2KNXOGL1du0bex8L8ct6Yu0NOn6MDRpxsRJH
        x8yR7aTvtPMrzHNVeNC9PCa8655Yn6tKOkl9GhENNs8EqQtKxxNkjI7oCWAFoMeS4M+LP5+ZWqetw
        00559xhAFWCPDiq0jP05NRoVmI/TvUfCdI1XpyYFdUIPfdDVQl74QWezxw1XQaW6IKh+vL4JiWnvx
        KeEN5khQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jTVlR-0007l1-MR; Tue, 28 Apr 2020 19:19:30 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BF8EF30794F;
        Tue, 28 Apr 2020 21:19:26 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id A8B2523CFDE43; Tue, 28 Apr 2020 21:19:26 +0200 (CEST)
Message-Id: <20200428191700.151623523@infradead.org>
User-Agent: quilt/0.65
Date:   Tue, 28 Apr 2020 21:11:14 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     jpoimboe@redhat.com, alexandre.chartre@oracle.com
Cc:     linux-kernel@vger.kernel.org, jthierry@redhat.com,
        tglx@linutronix.de, x86@kernel.org, mbenes@suse.cz,
        peterz@infradead.org
Subject: [PATCH v2 13/14] x86: Change {JMP,CALL}_NOSPEC argument
References: <20200428191101.886208539@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to change the {JMP,CALL}_NOSPEC macros to call out-of-line
versions of the retpoline magic, we need to remove the '%' from the
argument, such that we can paste it onto symbol names.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/crypto/aesni-intel_asm.S            |    4 ++--
 arch/x86/crypto/camellia-aesni-avx-asm_64.S  |    2 +-
 arch/x86/crypto/camellia-aesni-avx2-asm_64.S |    2 +-
 arch/x86/crypto/crc32c-pcl-intel-asm_64.S    |   26 +++++++++++++-------------
 arch/x86/entry/entry_32.S                    |    6 +++---
 arch/x86/entry/entry_64.S                    |    2 +-
 arch/x86/include/asm/nospec-branch.h         |   16 ++++++++--------
 arch/x86/kernel/ftrace_32.S                  |    2 +-
 arch/x86/kernel/ftrace_64.S                  |    4 ++--
 arch/x86/lib/checksum_32.S                   |    4 ++--
 arch/x86/platform/efi/efi_stub_64.S          |    2 +-
 11 files changed, 35 insertions(+), 35 deletions(-)

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


