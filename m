Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3C91C47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:22:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C809E20675
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:22:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730188AbgEEOWi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 10:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729613AbgEEOOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 10:14:37 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6449EC061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 07:14:37 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jVyKx-0000zS-JQ; Tue, 05 May 2020 16:14:19 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 0E56AFFC8D;
        Tue,  5 May 2020 16:14:19 +0200 (CEST)
Message-Id: <20200505134340.611961721@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 05 May 2020 15:41:17 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>
Subject: [patch V4 part 2 05/18] x86/entry: Move irq tracing on syscall entry
 to C-code
References: <20200505134112.272268764@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the C entry points are safe, move the irq flags tracing code into
the entry helper:

    - Invoke lockdep before calling into context tracking

    - Use the safe trace_hardirqs_on_prepare() trace function after context
      tracking established state and RCU is watching.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/entry/common.c          |   21 +++++++++++++++++++--
 arch/x86/entry/entry_32.S        |   12 ------------
 arch/x86/entry/entry_64.S        |    2 --
 arch/x86/entry/entry_64_compat.S |   18 ------------------
 4 files changed, 19 insertions(+), 34 deletions(-)

--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -40,19 +40,36 @@
 #include <trace/events/syscalls.h>
 
 #ifdef CONFIG_CONTEXT_TRACKING
-/* Called on entry from user mode with IRQs off. */
+/**
+ * enter_from_user_mode - Establish state when coming from user mode
+ *
+ * Syscall entry disables interrupts, but user mode is traced as interrupts
+ * enabled. Also with NO_HZ_FULL RCU might be idle.
+ *
+ * 1) Tell lockdep that interrupts are disabled
+ * 2) Invoke context tracking if enabled to reactivate RCU
+ * 3) Trace interrupts off state
+ */
 __visible noinstr void enter_from_user_mode(void)
 {
 	enum ctx_state state = ct_state();
 
+	lockdep_hardirqs_off(CALLER_ADDR0);
 	user_exit_irqoff();
 
 	instr_begin();
 	CT_WARN_ON(state != CONTEXT_USER);
+	trace_hardirqs_off_prepare();
 	instr_end();
 }
 #else
-static inline void enter_from_user_mode(void) {}
+static __always_inline void enter_from_user_mode(void)
+{
+	lockdep_hardirqs_off(CALLER_ADDR0);
+	instr_begin();
+	trace_hardirqs_off_prepare();
+	instr_end();
+}
 #endif
 
 static noinstr void exit_to_user_mode(void)
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -967,12 +967,6 @@ SYM_FUNC_START(entry_SYSENTER_32)
 	jnz	.Lsysenter_fix_flags
 .Lsysenter_flags_fixed:
 
-	/*
-	 * User mode is traced as though IRQs are on, and SYSENTER
-	 * turned them off.
-	 */
-	TRACE_IRQS_OFF
-
 	movl	%esp, %eax
 	call	do_fast_syscall_32
 	/* XEN PV guests always use IRET path */
@@ -1082,12 +1076,6 @@ SYM_FUNC_START(entry_INT80_32)
 
 	SAVE_ALL pt_regs_ax=$-ENOSYS switch_stacks=1	/* save rest */
 
-	/*
-	 * User mode is traced as though IRQs are on, and the interrupt gate
-	 * turned them off.
-	 */
-	TRACE_IRQS_OFF
-
 	movl	%esp, %eax
 	call	do_int80_syscall_32
 .Lsyscall_32_done:
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -167,8 +167,6 @@ SYM_INNER_LABEL(entry_SYSCALL_64_after_h
 
 	PUSH_AND_CLEAR_REGS rax=$-ENOSYS
 
-	TRACE_IRQS_OFF
-
 	/* IRQs are off. */
 	movq	%rax, %rdi
 	movq	%rsp, %rsi
--- a/arch/x86/entry/entry_64_compat.S
+++ b/arch/x86/entry/entry_64_compat.S
@@ -129,12 +129,6 @@ SYM_FUNC_START(entry_SYSENTER_compat)
 	jnz	.Lsysenter_fix_flags
 .Lsysenter_flags_fixed:
 
-	/*
-	 * User mode is traced as though IRQs are on, and SYSENTER
-	 * turned them off.
-	 */
-	TRACE_IRQS_OFF
-
 	movq	%rsp, %rdi
 	call	do_fast_syscall_32
 	/* XEN PV guests always use IRET path */
@@ -247,12 +241,6 @@ SYM_INNER_LABEL(entry_SYSCALL_compat_aft
 	pushq   $0			/* pt_regs->r15 = 0 */
 	xorl	%r15d, %r15d		/* nospec   r15 */
 
-	/*
-	 * User mode is traced as though IRQs are on, and SYSENTER
-	 * turned them off.
-	 */
-	TRACE_IRQS_OFF
-
 	movq	%rsp, %rdi
 	call	do_fast_syscall_32
 	/* XEN PV guests always use IRET path */
@@ -403,12 +391,6 @@ SYM_CODE_START(entry_INT80_compat)
 	xorl	%r15d, %r15d		/* nospec   r15 */
 	cld
 
-	/*
-	 * User mode is traced as though IRQs are on, and the interrupt
-	 * gate turned them off.
-	 */
-	TRACE_IRQS_OFF
-
 	movq	%rsp, %rdi
 	call	do_int80_syscall_32
 .Lsyscall_32_done:

