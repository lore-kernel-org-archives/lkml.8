Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D6DAC4BA04
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 23:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04FB924680
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 23:30:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730690AbgBYXaZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 18:30:25 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55545 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729553AbgBYXZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 18:25:53 -0500
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j6ja8-0004bl-Aq; Wed, 26 Feb 2020 00:25:40 +0100
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id DD5DF104089;
        Wed, 26 Feb 2020 00:25:33 +0100 (CET)
Message-Id: <20200225221306.026841950@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 25 Feb 2020 23:08:09 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [patch 8/8] x86/entry: Move irqflags tracing to do_int80_syscall_32()
References: <20200225220801.571835584@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

which cleans up the ASM maze.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/entry/common.c          |    8 +++++++-
 arch/x86/entry/entry_32.S        |    9 ++-------
 arch/x86/entry/entry_64_compat.S |   14 +++++---------
 3 files changed, 14 insertions(+), 17 deletions(-)

--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -333,6 +333,7 @@ void do_syscall_64_irqs_on(unsigned long
 {
 	syscall_entry_fixups();
 	do_syscall_64_irqs_on(nr, regs);
+	trace_hardirqs_on();
 }
 NOKPROBE_SYMBOL(do_syscall_64);
 #endif
@@ -389,6 +390,7 @@ static __always_inline void do_syscall_3
 {
 	syscall_entry_fixups();
 	do_syscall_32_irqs_on(regs);
+	trace_hardirqs_on();
 }
 NOKPROBE_SYMBOL(do_int80_syscall_32);
 
@@ -468,8 +470,12 @@ static __always_inline long do_fast_sysc
 /* Returns 0 to return using IRET or 1 to return using SYSEXIT/SYSRETL. */
 __visible notrace long do_fast_syscall_32(struct pt_regs *regs)
 {
+	long ret;
+
 	syscall_entry_fixups();
-	return do_fast_syscall_32_irqs_on(regs);
+	ret = do_fast_syscall_32_irqs_on(regs);
+	trace_hardirqs_on();
+	return ret;
 }
 NOKPROBE_SYMBOL(do_fast_syscall_32);
 
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -811,8 +811,7 @@ SYM_CODE_START(ret_from_fork)
 	/* When we fork, we trace the syscall return in the child, too. */
 	movl    %esp, %eax
 	call    syscall_return_slowpath
-	STACKLEAK_ERASE
-	jmp     restore_all_switch_stack
+	jmp     .Lsyscall_32_done
 
 	/* kernel thread */
 1:	movl	%edi, %eax
@@ -968,8 +967,7 @@ SYM_FUNC_START(entry_SYSENTER_32)
 
 	STACKLEAK_ERASE
 
-/* Opportunistic SYSEXIT */
-	TRACE_IRQS_ON			/* User mode traces as IRQs on. */
+	/* Opportunistic SYSEXIT */
 
 	/*
 	 * Setup entry stack - we keep the pointer in %eax and do the
@@ -1072,11 +1070,8 @@ SYM_FUNC_START(entry_INT80_32)
 	movl	%esp, %eax
 	call	do_int80_syscall_32
 .Lsyscall_32_done:
-
 	STACKLEAK_ERASE
 
-restore_all:
-	TRACE_IRQS_IRET
 restore_all_switch_stack:
 	SWITCH_TO_ENTRY_STACK
 	CHECK_AND_APPLY_ESPFIX
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

