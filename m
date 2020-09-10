Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A2BFC43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 09:32:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9549C207EA
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 09:32:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YP4z2hbT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4Ptbjgvf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730716AbgIJJce (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 05:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730486AbgIJJYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 05:24:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA07C0617A2;
        Thu, 10 Sep 2020 02:22:18 -0700 (PDT)
Date:   Thu, 10 Sep 2020 09:22:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599729734;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i8IRabgbO35oYdn90duYdWsNVWKMZWZ5E7cWyrVVsng=;
        b=YP4z2hbTFR7i013k7DgrKJi4uIAOREPVNvBcLG/UvliGV5O86fVPn1LTVkITCVnItAzB6o
        A+tUN6WznyndUAFomIkoP42cdnH9taEq9cva7RTswmUapVZOAzzkqMb0Ga1jBqCPcVRR/R
        sKm5tZ5E1LpFdF+snGTdXhTo6Aft2C8cSHUimU15kHGrDsHP8csfrRPCN8kAnoKbP4qQtD
        uijwo2VHI8Qi10MEKVmK7VHXSkhLl0w83i0+3rCzVMoJ9qWaT5LFpMc94itBjKGSl85UKL
        qkNo3z+EJOCOWrsvy/11bT5Y9zrgSXpWzHEmQmpSCxDjL3YU/PpXyRTkX7kmzA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599729734;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i8IRabgbO35oYdn90duYdWsNVWKMZWZ5E7cWyrVVsng=;
        b=4Ptbjgvf+3G157yHgro9CeW4BkZxIbSxs24Poq0CuX02YCUPXosIXk1DMaasdRzfBD00Qx
        E3OmpHKASyQUM4DQ==
From:   "tip-bot2 for Joerg Roedel" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/seves] x86/entry/64: Add entry code for #VC handler
Cc:     Joerg Roedel <jroedel@suse.de>, Borislav Petkov <bp@suse.de>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200907131613.12703-46-joro@8bytes.org>
References: <20200907131613.12703-46-joro@8bytes.org>
MIME-Version: 1.0
Message-ID: <159972973354.20229.4929553890417935062.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/seves branch of tip:

Commit-ID:     a13644f3a53de4e95a7bce6459f834e832ea44c5
Gitweb:        https://git.kernel.org/tip/a13644f3a53de4e95a7bce6459f834e832ea44c5
Author:        Joerg Roedel <jroedel@suse.de>
AuthorDate:    Mon, 07 Sep 2020 15:15:46 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 09 Sep 2020 11:33:19 +02:00

x86/entry/64: Add entry code for #VC handler

The #VC handler needs special entry code because:

	1. It runs on an IST stack

	2. It needs to be able to handle nested #VC exceptions

To make this work, the entry code is implemented to pretend it doesn't
use an IST stack. When entered from user-mode or early SYSCALL entry
path it switches to the task stack. If entered from kernel-mode it tries
to switch back to the previous stack in the IRET frame.

The stack found in the IRET frame is validated first, and if it is not
safe to use it for the #VC handler, the code will switch to a
fall-back stack (the #VC2 IST stack). From there, it can cause nested
exceptions again.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200907131613.12703-46-joro@8bytes.org
---
 arch/x86/entry/entry_64.S       | 80 ++++++++++++++++++++++++++++++++-
 arch/x86/include/asm/idtentry.h | 44 ++++++++++++++++++-
 arch/x86/include/asm/proto.h    |  1 +-
 arch/x86/include/asm/traps.h    |  1 +-
 arch/x86/kernel/traps.c         | 45 ++++++++++++++++++-
 5 files changed, 171 insertions(+)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 70dea93..15aa189 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -101,6 +101,8 @@ SYM_CODE_START(entry_SYSCALL_64)
 	SWITCH_TO_KERNEL_CR3 scratch_reg=%rsp
 	movq	PER_CPU_VAR(cpu_current_top_of_stack), %rsp
 
+SYM_INNER_LABEL(entry_SYSCALL_64_safe_stack, SYM_L_GLOBAL)
+
 	/* Construct struct pt_regs on stack */
 	pushq	$__USER_DS				/* pt_regs->ss */
 	pushq	PER_CPU_VAR(cpu_tss_rw + TSS_sp2)	/* pt_regs->sp */
@@ -446,6 +448,84 @@ _ASM_NOKPROBE(\asmsym)
 SYM_CODE_END(\asmsym)
 .endm
 
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+/**
+ * idtentry_vc - Macro to generate entry stub for #VC
+ * @vector:		Vector number
+ * @asmsym:		ASM symbol for the entry point
+ * @cfunc:		C function to be called
+ *
+ * The macro emits code to set up the kernel context for #VC. The #VC handler
+ * runs on an IST stack and needs to be able to cause nested #VC exceptions.
+ *
+ * To make this work the #VC entry code tries its best to pretend it doesn't use
+ * an IST stack by switching to the task stack if coming from user-space (which
+ * includes early SYSCALL entry path) or back to the stack in the IRET frame if
+ * entered from kernel-mode.
+ *
+ * If entered from kernel-mode the return stack is validated first, and if it is
+ * not safe to use (e.g. because it points to the entry stack) the #VC handler
+ * will switch to a fall-back stack (VC2) and call a special handler function.
+ *
+ * The macro is only used for one vector, but it is planned to be extended in
+ * the future for the #HV exception.
+ */
+.macro idtentry_vc vector asmsym cfunc
+SYM_CODE_START(\asmsym)
+	UNWIND_HINT_IRET_REGS
+	ASM_CLAC
+
+	/*
+	 * If the entry is from userspace, switch stacks and treat it as
+	 * a normal entry.
+	 */
+	testb	$3, CS-ORIG_RAX(%rsp)
+	jnz	.Lfrom_usermode_switch_stack_\@
+
+	/*
+	 * paranoid_entry returns SWAPGS flag for paranoid_exit in EBX.
+	 * EBX == 0 -> SWAPGS, EBX == 1 -> no SWAPGS
+	 */
+	call	paranoid_entry
+
+	UNWIND_HINT_REGS
+
+	/*
+	 * Switch off the IST stack to make it free for nested exceptions. The
+	 * vc_switch_off_ist() function will switch back to the interrupted
+	 * stack if it is safe to do so. If not it switches to the VC fall-back
+	 * stack.
+	 */
+	movq	%rsp, %rdi		/* pt_regs pointer */
+	call	vc_switch_off_ist
+	movq	%rax, %rsp		/* Switch to new stack */
+
+	UNWIND_HINT_REGS
+
+	/* Update pt_regs */
+	movq	ORIG_RAX(%rsp), %rsi	/* get error code into 2nd argument*/
+	movq	$-1, ORIG_RAX(%rsp)	/* no syscall to restart */
+
+	movq	%rsp, %rdi		/* pt_regs pointer */
+
+	call	\cfunc
+
+	/*
+	 * No need to switch back to the IST stack. The current stack is either
+	 * identical to the stack in the IRET frame or the VC fall-back stack,
+	 * so it is definitly mapped even with PTI enabled.
+	 */
+	jmp	paranoid_exit
+
+	/* Switch to the regular task stack */
+.Lfrom_usermode_switch_stack_\@:
+	idtentry_body safe_stack_\cfunc, has_error_code=1
+
+_ASM_NOKPROBE(\asmsym)
+SYM_CODE_END(\asmsym)
+.endm
+#endif
+
 /*
  * Double fault entry. Straight paranoid. No checks from which context
  * this comes because for the espfix induced #DF this would do the wrong
diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index a433661..840faaf 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -309,6 +309,18 @@ static __always_inline void __##func(struct pt_regs *regs)
 	__visible void noist_##func(struct pt_regs *regs)
 
 /**
+ * DECLARE_IDTENTRY_VC - Declare functions for the VC entry point
+ * @vector:	Vector number (ignored for C)
+ * @func:	Function name of the entry point
+ *
+ * Maps to DECLARE_IDTENTRY_RAW_ERRORCODE, but declares also the
+ * safe_stack C handler.
+ */
+#define DECLARE_IDTENTRY_VC(vector, func)				\
+	DECLARE_IDTENTRY_RAW_ERRORCODE(vector, func);			\
+	__visible noinstr void safe_stack_##func(struct pt_regs *regs, unsigned long error_code)
+
+/**
  * DEFINE_IDTENTRY_IST - Emit code for IST entry points
  * @func:	Function name of the entry point
  *
@@ -347,6 +359,35 @@ static __always_inline void __##func(struct pt_regs *regs)
 #define DEFINE_IDTENTRY_DF(func)					\
 	DEFINE_IDTENTRY_RAW_ERRORCODE(func)
 
+/**
+ * DEFINE_IDTENTRY_VC_SAFE_STACK - Emit code for VMM communication handler
+				   which runs on a safe stack.
+ * @func:	Function name of the entry point
+ *
+ * Maps to DEFINE_IDTENTRY_RAW_ERRORCODE
+ */
+#define DEFINE_IDTENTRY_VC_SAFE_STACK(func)				\
+	DEFINE_IDTENTRY_RAW_ERRORCODE(safe_stack_##func)
+
+/**
+ * DEFINE_IDTENTRY_VC_IST - Emit code for VMM communication handler
+			    which runs on the VC fall-back stack
+ * @func:	Function name of the entry point
+ *
+ * Maps to DEFINE_IDTENTRY_RAW_ERRORCODE
+ */
+#define DEFINE_IDTENTRY_VC_IST(func)				\
+	DEFINE_IDTENTRY_RAW_ERRORCODE(ist_##func)
+
+/**
+ * DEFINE_IDTENTRY_VC - Emit code for VMM communication handler
+ * @func:	Function name of the entry point
+ *
+ * Maps to DEFINE_IDTENTRY_RAW_ERRORCODE
+ */
+#define DEFINE_IDTENTRY_VC(func)					\
+	DEFINE_IDTENTRY_RAW_ERRORCODE(func)
+
 #else	/* CONFIG_X86_64 */
 
 /**
@@ -433,6 +474,9 @@ __visible noinstr void func(struct pt_regs *regs,			\
 # define DECLARE_IDTENTRY_XENCB(vector, func)				\
 	DECLARE_IDTENTRY(vector, func)
 
+# define DECLARE_IDTENTRY_VC(vector, func)				\
+	idtentry_vc vector asm_##func func
+
 #else
 # define DECLARE_IDTENTRY_MCE(vector, func)				\
 	DECLARE_IDTENTRY(vector, func)
diff --git a/arch/x86/include/asm/proto.h b/arch/x86/include/asm/proto.h
index 28996fe..2c35f1c 100644
--- a/arch/x86/include/asm/proto.h
+++ b/arch/x86/include/asm/proto.h
@@ -10,6 +10,7 @@ void syscall_init(void);
 
 #ifdef CONFIG_X86_64
 void entry_SYSCALL_64(void);
+void entry_SYSCALL_64_safe_stack(void);
 long do_arch_prctl_64(struct task_struct *task, int option, unsigned long arg2);
 #endif
 
diff --git a/arch/x86/include/asm/traps.h b/arch/x86/include/asm/traps.h
index 6a30835..1b86bb3 100644
--- a/arch/x86/include/asm/traps.h
+++ b/arch/x86/include/asm/traps.h
@@ -15,6 +15,7 @@ asmlinkage __visible notrace struct pt_regs *sync_regs(struct pt_regs *eregs);
 asmlinkage __visible notrace
 struct bad_iret_stack *fixup_bad_iret(struct bad_iret_stack *s);
 void __init trap_init(void);
+asmlinkage __visible noinstr struct pt_regs *vc_switch_off_ist(struct pt_regs *eregs);
 #endif
 
 #ifdef CONFIG_X86_F00F_BUG
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 2dc32b0..fc1ed40 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -43,6 +43,7 @@
 #include <asm/stacktrace.h>
 #include <asm/processor.h>
 #include <asm/debugreg.h>
+#include <asm/realmode.h>
 #include <asm/text-patching.h>
 #include <asm/ftrace.h>
 #include <asm/traps.h>
@@ -673,6 +674,50 @@ asmlinkage __visible noinstr struct pt_regs *sync_regs(struct pt_regs *eregs)
 	return regs;
 }
 
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+asmlinkage __visible noinstr struct pt_regs *vc_switch_off_ist(struct pt_regs *regs)
+{
+	unsigned long sp, *stack;
+	struct stack_info info;
+	struct pt_regs *regs_ret;
+
+	/*
+	 * In the SYSCALL entry path the RSP value comes from user-space - don't
+	 * trust it and switch to the current kernel stack
+	 */
+	if (regs->ip >= (unsigned long)entry_SYSCALL_64 &&
+	    regs->ip <  (unsigned long)entry_SYSCALL_64_safe_stack) {
+		sp = this_cpu_read(cpu_current_top_of_stack);
+		goto sync;
+	}
+
+	/*
+	 * From here on the RSP value is trusted. Now check whether entry
+	 * happened from a safe stack. Not safe are the entry or unknown stacks,
+	 * use the fall-back stack instead in this case.
+	 */
+	sp    = regs->sp;
+	stack = (unsigned long *)sp;
+
+	if (!get_stack_info_noinstr(stack, current, &info) || info.type == STACK_TYPE_ENTRY ||
+	    info.type >= STACK_TYPE_EXCEPTION_LAST)
+		sp = __this_cpu_ist_top_va(VC2);
+
+sync:
+	/*
+	 * Found a safe stack - switch to it as if the entry didn't happen via
+	 * IST stack. The code below only copies pt_regs, the real switch happens
+	 * in assembly code.
+	 */
+	sp = ALIGN_DOWN(sp, 8) - sizeof(*regs_ret);
+
+	regs_ret = (struct pt_regs *)sp;
+	*regs_ret = *regs;
+
+	return regs_ret;
+}
+#endif
+
 struct bad_iret_stack {
 	void *error_entry_ret;
 	struct pt_regs regs;
