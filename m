Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72C90C83007
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 19:19:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BF452070B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 19:19:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MIPoo8BW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728936AbgD1TTt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 15:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728491AbgD1TTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 15:19:38 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EC50C035494
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 12:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=pvbD5vqRjX2pcfuYIS5+a/68HRnERC/D4UnPaMn9xKc=; b=MIPoo8BWy2RJ9P6wZl+11yXVNj
        Yj1UVSglAcbWxBbqaENdrEO6bTuF3Ih3knY/qC3q1yy4FdvaJXFd8wWBnbRZ7rABM54sZxQDkWf5i
        Yquqn+4H7fOyV9tyMHL0EZhKwYnH6uyBTQEQKzNSrx4gkKvSaAG8CcAi7B0YU8TpLlkdHrBC4xza6
        xKcOFsh+RqLrZCBtkT6nC5JT6xGoQoPZBhVRxLhdDBGAjnyf/VNPulYNP0E87mb4AAzXl7FNYUGtP
        Z3WtBTVjztW6FhaCZV4ssFGLjI/CMQ46K5Y4dF00d6dsiyShnZe+8SqFbA/oBuS4jgVpHS6ybWIXw
        dl3+P1CQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jTVlS-0006WF-1C; Tue, 28 Apr 2020 19:19:30 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C265A307966;
        Tue, 28 Apr 2020 21:19:26 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id B026323CFDE41; Tue, 28 Apr 2020 21:19:26 +0200 (CEST)
Message-Id: <20200428191700.210835357@infradead.org>
User-Agent: quilt/0.65
Date:   Tue, 28 Apr 2020 21:11:15 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     jpoimboe@redhat.com, alexandre.chartre@oracle.com
Cc:     linux-kernel@vger.kernel.org, jthierry@redhat.com,
        tglx@linutronix.de, x86@kernel.org, mbenes@suse.cz,
        peterz@infradead.org
Subject: [PATCH v2 14/14] x86/retpoline: Fix retpoline unwind
References: <20200428191101.886208539@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently objtool cannot understand retpolines, and thus cannot
generate ORC unwind information for them. This means that we cannot
unwind from the middle of a retpoline.

The recent ANNOTATE_INTRA_FUNCTION_CALL and UNWIND_HINT_RET_OFFSET
support in objtool enables it to understand the basic retpoline
construct. A further problem is that the ORC unwind information is
alternative invariant; IOW. every alternative should have the same
ORC, retpolines obviously violate this. This means we need to
out-of-line them.

Since all GCC generated code already uses out-of-line retpolines, this
should not affect performance much, if anything.

This will enable objtool to generate valid ORC data for the
out-of-line copies, which means we can correctly and reliably unwind
through a retpoline.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/asm-prototypes.h |    7 ++++
 arch/x86/include/asm/nospec-branch.h  |   56 ++++------------------------------
 arch/x86/lib/retpoline.S              |   26 +++++++++++++--
 3 files changed, 38 insertions(+), 51 deletions(-)

--- a/arch/x86/include/asm/asm-prototypes.h
+++ b/arch/x86/include/asm/asm-prototypes.h
@@ -21,8 +21,15 @@ extern void cmpxchg8b_emu(void);
 #define DECL_INDIRECT_THUNK(reg) \
 	extern asmlinkage void __x86_indirect_thunk_ ## reg (void);
 
+#define DECL_RETPOLINE(reg) \
+	extern asmlinkage void __x86_retpoline_ ## reg (void);
+
 #undef GEN
 #define GEN(reg) DECL_INDIRECT_THUNK(reg)
 #include <asm/GEN-for-each-reg.h>
 
+#undef GEN
+#define GEN(reg) DECL_RETPOLINE(reg)
+#include <asm/GEN-for-each-reg.h>
+
 #endif /* CONFIG_RETPOLINE */
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -13,15 +13,6 @@
 #include <asm/unwind_hints.h>
 
 /*
- * This should be used immediately before a retpoline alternative. It tells
- * objtool where the retpolines are so that it can make sense of the control
- * flow by just reading the original instruction(s) and ignoring the
- * alternatives.
- */
-#define ANNOTATE_NOSPEC_ALTERNATIVE \
-	ANNOTATE_IGNORE_ALTERNATIVE
-
-/*
  * Fill the CPU return stack buffer.
  *
  * Each entry in the RSB, if used for a speculative 'ret', contains an
@@ -83,44 +74,15 @@
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
-	ALTERNATIVE_2 __stringify(ANNOTATE_RETPOLINE_SAFE; jmp *%\reg),	\
-		__stringify(RETPOLINE_JMP %\reg), X86_FEATURE_RETPOLINE,\
-		__stringify(lfence; ANNOTATE_RETPOLINE_SAFE; jmp *%\reg), X86_FEATURE_RETPOLINE_AMD
+	ALTERNATIVE_2 __stringify(ANNOTATE_RETPOLINE_SAFE; jmp *%\reg), \
+		      __stringify(jmp __x86_retpoline_\reg), X86_FEATURE_RETPOLINE, \
+		      __stringify(lfence; ANNOTATE_RETPOLINE_SAFE; jmp *%\reg), X86_FEATURE_RETPOLINE_AMD
 #else
 	jmp	*%\reg
 #endif
@@ -128,10 +90,9 @@
 
 .macro CALL_NOSPEC reg:req
 #ifdef CONFIG_RETPOLINE
-	ANNOTATE_NOSPEC_ALTERNATIVE
-	ALTERNATIVE_2 __stringify(ANNOTATE_RETPOLINE_SAFE; call *%\reg),\
-		__stringify(RETPOLINE_CALL %\reg), X86_FEATURE_RETPOLINE,\
-		__stringify(lfence; ANNOTATE_RETPOLINE_SAFE; call *%\reg), X86_FEATURE_RETPOLINE_AMD
+	ALTERNATIVE_2 __stringify(ANNOTATE_RETPOLINE_SAFE; call *%\reg), \
+		      __stringify(call __x86_retpoline_\reg), X86_FEATURE_RETPOLINE, \
+		      __stringify(lfence; ANNOTATE_RETPOLINE_SAFE; call *%\reg), X86_FEATURE_RETPOLINE_AMD
 #else
 	call	*%\reg
 #endif
@@ -165,16 +126,16 @@
  * which is ensured when CONFIG_RETPOLINE is defined.
  */
 # define CALL_NOSPEC						\
-	ANNOTATE_NOSPEC_ALTERNATIVE				\
 	ALTERNATIVE_2(						\
 	ANNOTATE_RETPOLINE_SAFE					\
 	"call *%[thunk_target]\n",				\
-	"call __x86_indirect_thunk_%V[thunk_target]\n",		\
+	"call __x86_retpoline_%V[thunk_target]\n",		\
 	X86_FEATURE_RETPOLINE,					\
 	"lfence;\n"						\
 	ANNOTATE_RETPOLINE_SAFE					\
 	"call *%[thunk_target]\n",				\
 	X86_FEATURE_RETPOLINE_AMD)
+
 # define THUNK_TARGET(addr) [thunk_target] "r" (addr)
 
 #else /* CONFIG_X86_32 */
@@ -184,7 +145,6 @@
  * here, anyway.
  */
 # define CALL_NOSPEC						\
-	ANNOTATE_NOSPEC_ALTERNATIVE				\
 	ALTERNATIVE_2(						\
 	ANNOTATE_RETPOLINE_SAFE					\
 	"call *%[thunk_target]\n",				\
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -7,15 +7,31 @@
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
+	UNWIND_HINT_EMPTY
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
@@ -32,6 +48,7 @@ SYM_FUNC_END(__x86_indirect_thunk_\reg)
 
 #define __EXPORT_THUNK(sym)	_ASM_NOKPROBE(sym); EXPORT_SYMBOL(sym)
 #define EXPORT_THUNK(reg)	__EXPORT_THUNK(__x86_indirect_thunk_ ## reg)
+#define EXPORT_RETPOLINE(reg)  __EXPORT_THUNK(__x86_retpoline_ ## reg)
 
 #undef GEN
 #define GEN(reg) THUNK reg
@@ -41,3 +58,6 @@ SYM_FUNC_END(__x86_indirect_thunk_\reg)
 #define GEN(reg) EXPORT_THUNK(reg)
 #include <asm/GEN-for-each-reg.h>
 
+#undef GEN
+#define GEN(reg) EXPORT_RETPOLINE(reg)
+#include <asm/GEN-for-each-reg.h>


