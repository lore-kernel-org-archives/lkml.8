Return-Path: <SRS0=tZRF=4Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5E71C10DCE
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 23:24:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B50412086A
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 23:24:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbgCHXYC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Mar 2020 19:24:02 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57247 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726720AbgCHXX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 19:23:58 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jB5Gl-00036O-7x; Mon, 09 Mar 2020 00:23:40 +0100
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id AD5EA1040B3;
        Mon,  9 Mar 2020 00:23:30 +0100 (CET)
Message-Id: <20200308222610.150951641@linutronix.de>
User-Agent: quilt/0.65
Date:   Sun, 08 Mar 2020 23:24:11 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>
Subject: [patch part-II V2 12/13] x86/entry: Move irq flags tracing to prepare_exit_to_usermode()
References: <20200308222359.370649591@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is another step towards more C-code and less convoluted ASM.

Note, that trace_hardirqs_on() is still incorrect vs. RCU idle when the
tracepoint is used by e.g. BPF. Will be addressed in the next step.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---

V2: New patch simplifying the conversion and addressing Alex' review
    comment of redundant tracing.
---
 arch/x86/entry/common.c          |    1 +
 arch/x86/entry/entry_32.S        |   12 ++++--------
 arch/x86/entry/entry_64.S        |    4 ----
 arch/x86/entry/entry_64_compat.S |   14 +++++---------
 4 files changed, 10 insertions(+), 21 deletions(-)

--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -253,6 +253,7 @@ static noinline void __prepare_exit_to_u
 
 	user_enter_irqoff();
 	mds_user_clear_cpu_buffers();
+	trace_hardirqs_on();
 }
 NOKPROBE_SYMBOL(prepare_exit_to_usermode);
 
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -811,8 +811,7 @@ SYM_CODE_START(ret_from_fork)
 	/* When we fork, we trace the syscall return in the child, too. */
 	movl    %esp, %eax
 	call    syscall_return_slowpath
-	STACKLEAK_ERASE
-	jmp     restore_all
+	jmp     .Lsyscall_32_done
 
 	/* kernel thread */
 1:	movl	%edi, %eax
@@ -855,7 +854,7 @@ SYM_CODE_START_LOCAL(ret_from_exception)
 	TRACE_IRQS_OFF
 	movl	%esp, %eax
 	call	prepare_exit_to_usermode
-	jmp	restore_all
+	jmp	restore_all_switch_stack
 SYM_CODE_END(ret_from_exception)
 
 SYM_ENTRY(__begin_SYSENTER_singlestep_region, SYM_L_GLOBAL, SYM_A_NONE)
@@ -968,8 +967,7 @@ SYM_FUNC_START(entry_SYSENTER_32)
 
 	STACKLEAK_ERASE
 
-/* Opportunistic SYSEXIT */
-	TRACE_IRQS_ON			/* User mode traces as IRQs on. */
+	/* Opportunistic SYSEXIT */
 
 	/*
 	 * Setup entry stack - we keep the pointer in %eax and do the
@@ -1072,11 +1070,9 @@ SYM_FUNC_START(entry_INT80_32)
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
 
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -172,8 +172,6 @@ SYM_INNER_LABEL(entry_SYSCALL_64_after_h
 	movq	%rsp, %rsi
 	call	do_syscall_64		/* returns with IRQs disabled */
 
-	TRACE_IRQS_ON			/* return enables interrupts */
-
 	/*
 	 * Try to use SYSRET instead of IRET if we're returning to
 	 * a completely clean 64-bit userspace context.  If we're not,
@@ -340,7 +338,6 @@ SYM_CODE_START(ret_from_fork)
 	UNWIND_HINT_REGS
 	movq	%rsp, %rdi
 	call	syscall_return_slowpath	/* returns with IRQs disabled */
-	TRACE_IRQS_ON			/* user mode is traced as IRQS on */
 	jmp	swapgs_restore_regs_and_return_to_usermode
 
 1:
@@ -617,7 +614,6 @@ SYM_CODE_START_LOCAL(common_interrupt)
 .Lretint_user:
 	mov	%rsp,%rdi
 	call	prepare_exit_to_usermode
-	TRACE_IRQS_ON
 
 SYM_INNER_LABEL(swapgs_restore_regs_and_return_to_usermode, SYM_L_GLOBAL)
 #ifdef CONFIG_DEBUG_ENTRY
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
@@ -244,8 +244,8 @@ SYM_INNER_LABEL(entry_SYSCALL_compat_aft
 	movq	%rsp, %rdi
 	call	do_fast_syscall_32
 	/* XEN PV guests always use IRET path */
-	ALTERNATIVE "testl %eax, %eax; jz .Lsyscall_32_done", \
-		    "jmp .Lsyscall_32_done", X86_FEATURE_XENPV
+	ALTERNATIVE "testl %eax, %eax; jz swapgs_restore_regs_and_return_to_usermode", \
+		    "jmp swapgs_restore_regs_and_return_to_usermode", X86_FEATURE_XENPV
 
 	/* Opportunistic SYSRET */
 sysret32_from_system_call:
@@ -254,7 +254,7 @@ SYM_INNER_LABEL(entry_SYSCALL_compat_aft
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

