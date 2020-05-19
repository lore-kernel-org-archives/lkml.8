Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC8FBC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 19:59:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4B9920878
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 19:59:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728489AbgEST7c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 15:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728351AbgEST7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 15:59:06 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8D9CC08C5C2;
        Tue, 19 May 2020 12:59:05 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jb8O9-00008K-Sz; Tue, 19 May 2020 21:58:58 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id F162E1C0858;
        Tue, 19 May 2020 21:58:41 +0200 (CEST)
Date:   Tue, 19 May 2020 19:58:41 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/entry: Move irq flags tracing to
 prepare_exit_to_usermode()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200505134340.703783926@linutronix.de>
References: <20200505134340.703783926@linutronix.de>
MIME-Version: 1.0
Message-ID: <158991832186.17951.17623933474637833032.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     59a42be78098ad1e212abb6eea5d05ed429b5a64
Gitweb:        https://git.kernel.org/tip/59a42be78098ad1e212abb6eea5d05ed429b5a64
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 04 Mar 2020 12:51:59 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 19 May 2020 16:03:51 +02:00

x86/entry: Move irq flags tracing to prepare_exit_to_usermode()

This is another step towards more C-code and less convoluted ASM.

Similar to the entry path, invoke the tracer before context tracking which
might turn off RCU and invoke lockdep as the last step before going back to
user space. Annotate the code sections in exit_to_user_mode() accordingly
so objtool won't complain about the tracer invocation.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Acked-by: Andy Lutomirski <luto@kernel.org>
Link: https://lkml.kernel.org/r/20200505134340.703783926@linutronix.de


---
 arch/x86/entry/common.c          | 19 ++++++++++++++++++-
 arch/x86/entry/entry_32.S        | 12 ++++--------
 arch/x86/entry/entry_64.S        |  4 ----
 arch/x86/entry/entry_64_compat.S | 14 +++++---------
 4 files changed, 27 insertions(+), 22 deletions(-)

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index 7473c12..e4f9f5f 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -72,10 +72,27 @@ static __always_inline void enter_from_user_mode(void)
 }
 #endif
 
-static noinstr void exit_to_user_mode(void)
+/**
+ * exit_to_user_mode - Fixup state when exiting to user mode
+ *
+ * Syscall exit enables interrupts, but the kernel state is interrupts
+ * disabled when this is invoked. Also tell RCU about it.
+ *
+ * 1) Trace interrupts on state
+ * 2) Invoke context tracking if enabled to adjust RCU state
+ * 3) Clear CPU buffers if CPU is affected by MDS and the migitation is on.
+ * 4) Tell lockdep that interrupts are enabled
+ */
+static __always_inline void exit_to_user_mode(void)
 {
+	instrumentation_begin();
+	trace_hardirqs_on_prepare();
+	lockdep_hardirqs_on_prepare(CALLER_ADDR0);
+	instrumentation_end();
+
 	user_enter_irqoff();
 	mds_user_clear_cpu_buffers();
+	lockdep_hardirqs_on(CALLER_ADDR0);
 }
 
 static void do_audit_syscall_entry(struct pt_regs *regs, u32 arch)
diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index 65704e0..d9da0b7 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -817,8 +817,7 @@ SYM_CODE_START(ret_from_fork)
 	/* When we fork, we trace the syscall return in the child, too. */
 	movl    %esp, %eax
 	call    syscall_return_slowpath
-	STACKLEAK_ERASE
-	jmp     restore_all
+	jmp     .Lsyscall_32_done
 
 	/* kernel thread */
 1:	movl	%edi, %eax
@@ -862,7 +861,7 @@ ret_from_intr:
 	TRACE_IRQS_OFF
 	movl	%esp, %eax
 	call	prepare_exit_to_usermode
-	jmp	restore_all
+	jmp	restore_all_switch_stack
 SYM_CODE_END(ret_from_exception)
 
 SYM_ENTRY(__begin_SYSENTER_singlestep_region, SYM_L_GLOBAL, SYM_A_NONE)
@@ -975,8 +974,7 @@ SYM_FUNC_START(entry_SYSENTER_32)
 
 	STACKLEAK_ERASE
 
-/* Opportunistic SYSEXIT */
-	TRACE_IRQS_ON			/* User mode traces as IRQs on. */
+	/* Opportunistic SYSEXIT */
 
 	/*
 	 * Setup entry stack - we keep the pointer in %eax and do the
@@ -1079,11 +1077,9 @@ SYM_FUNC_START(entry_INT80_32)
 	movl	%esp, %eax
 	call	do_int80_syscall_32
 .Lsyscall_32_done:
-
 	STACKLEAK_ERASE
 
-restore_all:
-	TRACE_IRQS_ON
+restore_all_switch_stack:
 	SWITCH_TO_ENTRY_STACK
 	CHECK_AND_APPLY_ESPFIX
 
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 9e34fe8..9866b54 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -172,8 +172,6 @@ SYM_INNER_LABEL(entry_SYSCALL_64_after_hwframe, SYM_L_GLOBAL)
 	movq	%rsp, %rsi
 	call	do_syscall_64		/* returns with IRQs disabled */
 
-	TRACE_IRQS_ON			/* return enables interrupts */
-
 	/*
 	 * Try to use SYSRET instead of IRET if we're returning to
 	 * a completely clean 64-bit userspace context.  If we're not,
@@ -342,7 +340,6 @@ SYM_CODE_START(ret_from_fork)
 	UNWIND_HINT_REGS
 	movq	%rsp, %rdi
 	call	syscall_return_slowpath	/* returns with IRQs disabled */
-	TRACE_IRQS_ON			/* user mode is traced as IRQS on */
 	jmp	swapgs_restore_regs_and_return_to_usermode
 
 1:
@@ -620,7 +617,6 @@ ret_from_intr:
 .Lretint_user:
 	mov	%rsp,%rdi
 	call	prepare_exit_to_usermode
-	TRACE_IRQS_ON
 
 SYM_INNER_LABEL(swapgs_restore_regs_and_return_to_usermode, SYM_L_GLOBAL)
 #ifdef CONFIG_DEBUG_ENTRY
diff --git a/arch/x86/entry/entry_64_compat.S b/arch/x86/entry/entry_64_compat.S
index e2e8bd7..7c29ed8 100644
--- a/arch/x86/entry/entry_64_compat.S
+++ b/arch/x86/entry/entry_64_compat.S
@@ -132,8 +132,8 @@ SYM_FUNC_START(entry_SYSENTER_compat)
 	movq	%rsp, %rdi
 	call	do_fast_syscall_32
 	/* XEN PV guests always use IRET path */
-	ALTERNATIVE "testl %eax, %eax; jz .Lsyscall_32_done", \
-		    "jmp .Lsyscall_32_done", X86_FEATURE_XENPV
+	ALTERNATIVE "testl %eax, %eax; jz swapgs_restore_regs_and_return_to_usermode", \
+		    "jmp swapgs_restore_regs_and_return_to_usermode", X86_FEATURE_XENPV
 	jmp	sysret32_from_system_call
 
 .Lsysenter_fix_flags:
@@ -244,8 +244,8 @@ SYM_INNER_LABEL(entry_SYSCALL_compat_after_hwframe, SYM_L_GLOBAL)
 	movq	%rsp, %rdi
 	call	do_fast_syscall_32
 	/* XEN PV guests always use IRET path */
-	ALTERNATIVE "testl %eax, %eax; jz .Lsyscall_32_done", \
-		    "jmp .Lsyscall_32_done", X86_FEATURE_XENPV
+	ALTERNATIVE "testl %eax, %eax; jz swapgs_restore_regs_and_return_to_usermode", \
+		    "jmp swapgs_restore_regs_and_return_to_usermode", X86_FEATURE_XENPV
 
 	/* Opportunistic SYSRET */
 sysret32_from_system_call:
@@ -254,7 +254,7 @@ sysret32_from_system_call:
 	 * stack. So let's erase the thread stack right now.
 	 */
 	STACKLEAK_ERASE
-	TRACE_IRQS_ON			/* User mode traces as IRQs on. */
+
 	movq	RBX(%rsp), %rbx		/* pt_regs->rbx */
 	movq	RBP(%rsp), %rbp		/* pt_regs->rbp */
 	movq	EFLAGS(%rsp), %r11	/* pt_regs->flags (in r11) */
@@ -393,9 +393,5 @@ SYM_CODE_START(entry_INT80_compat)
 
 	movq	%rsp, %rdi
 	call	do_int80_syscall_32
-.Lsyscall_32_done:
-
-	/* Go back to user mode. */
-	TRACE_IRQS_ON
 	jmp	swapgs_restore_regs_and_return_to_usermode
 SYM_CODE_END(entry_INT80_compat)
