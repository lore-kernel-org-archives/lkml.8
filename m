Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84F61C47253
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 18:23:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 657E824961
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 18:23:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730687AbgEASW3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 14:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730654AbgEASWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 14:22:25 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11847C08E859;
        Fri,  1 May 2020 11:22:25 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jUaIl-0003dy-AG; Fri, 01 May 2020 20:22:19 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id DCA6E1C0085;
        Fri,  1 May 2020 20:22:18 +0200 (CEST)
Date:   Fri, 01 May 2020 18:22:18 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] x86/retpoline: Fix retpoline unwind
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200428191700.210835357@infradead.org>
References: <20200428191700.210835357@infradead.org>
MIME-Version: 1.0
Message-ID: <158835733887.8414.11783900146770461292.tip-bot2@tip-bot2>
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

Commit-ID:     cc1ac9c792810b93783a7de344f428922af8d98c
Gitweb:        https://git.kernel.org/tip/cc1ac9c792810b93783a7de344f428922af8d98c
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 16 Apr 2020 14:34:26 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 30 Apr 2020 20:14:34 +02:00

x86/retpoline: Fix retpoline unwind

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
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lkml.kernel.org/r/20200428191700.210835357@infradead.org
---
 arch/x86/include/asm/asm-prototypes.h |  7 +++-
 arch/x86/include/asm/nospec-branch.h  | 56 +++-----------------------
 arch/x86/lib/retpoline.S              | 26 ++++++++++--
 3 files changed, 38 insertions(+), 51 deletions(-)

diff --git a/arch/x86/include/asm/asm-prototypes.h b/arch/x86/include/asm/asm-prototypes.h
index aa7585e..9bf2620 100644
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
diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index d3269b6..d52d1aa 100644
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
diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
index 9cc5480..b4c43a9 100644
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
