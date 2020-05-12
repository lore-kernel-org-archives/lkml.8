Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ADA8C2D0F8
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 22:24:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D6122492D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 22:24:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731546AbgELWYN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 18:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731806AbgELWXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 18:23:37 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79B39C061A0F
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 15:23:37 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jYdIl-00058n-R8; Wed, 13 May 2020 00:23:04 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 4CD2D1006A1;
        Wed, 13 May 2020 00:23:03 +0200 (CEST)
Message-Id: <20200512213813.087919792@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 12 May 2020 23:01:35 +0200
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
        Will Deacon <will@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Jason Chen CJ <jason.cj.chen@intel.com>,
        Zhao Yakui <yakui.zhao@intel.com>
Subject: [patch V5 36/38] x86/entry/64: Remove TRACE_IRQS_*_DEBUG
References: <20200512210059.056244513@linutronix.de>
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

From: Peter Zijlstra <peterz@infradead.org>

Since INT3/#BP no longer runs on an IST, this workaround is no longer
required.

Tested by running lockdep+ftrace as described in the initial commit:

  5963e317b1e9 ("ftrace/x86: Do not change stacks in DEBUG when calling lockdep")

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

---
 arch/x86/entry/entry_64.S |   48 ++--------------------------------------------
 1 file changed, 3 insertions(+), 45 deletions(-)

--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -68,44 +68,6 @@ SYM_CODE_END(native_usergs_sysret64)
 .endm
 
 /*
- * When dynamic function tracer is enabled it will add a breakpoint
- * to all locations that it is about to modify, sync CPUs, update
- * all the code, sync CPUs, then remove the breakpoints. In this time
- * if lockdep is enabled, it might jump back into the debug handler
- * outside the updating of the IST protection. (TRACE_IRQS_ON/OFF).
- *
- * We need to change the IDT table before calling TRACE_IRQS_ON/OFF to
- * make sure the stack pointer does not get reset back to the top
- * of the debug stack, and instead just reuses the current stack.
- */
-#if defined(CONFIG_DYNAMIC_FTRACE) && defined(CONFIG_TRACE_IRQFLAGS)
-
-.macro TRACE_IRQS_OFF_DEBUG
-	call	debug_stack_set_zero
-	TRACE_IRQS_OFF
-	call	debug_stack_reset
-.endm
-
-.macro TRACE_IRQS_ON_DEBUG
-	call	debug_stack_set_zero
-	TRACE_IRQS_ON
-	call	debug_stack_reset
-.endm
-
-.macro TRACE_IRQS_IRETQ_DEBUG
-	btl	$9, EFLAGS(%rsp)		/* interrupts off? */
-	jnc	1f
-	TRACE_IRQS_ON_DEBUG
-1:
-.endm
-
-#else
-# define TRACE_IRQS_OFF_DEBUG			TRACE_IRQS_OFF
-# define TRACE_IRQS_ON_DEBUG			TRACE_IRQS_ON
-# define TRACE_IRQS_IRETQ_DEBUG			TRACE_IRQS_IRETQ
-#endif
-
-/*
  * 64-bit SYSCALL instruction entry. Up to 6 arguments in registers.
  *
  * This is the only entry point used for 64-bit system calls.  The
@@ -500,11 +462,7 @@ SYM_CODE_START(\asmsym)
 
 	UNWIND_HINT_REGS
 
-	.if \vector == X86_TRAP_DB
-		TRACE_IRQS_OFF_DEBUG
-	.else
-		TRACE_IRQS_OFF
-	.endif
+	TRACE_IRQS_OFF
 
 	movq	%rsp, %rdi		/* pt_regs pointer */
 
@@ -924,7 +882,7 @@ SYM_CODE_END(paranoid_entry)
 SYM_CODE_START_LOCAL(paranoid_exit)
 	UNWIND_HINT_REGS
 	DISABLE_INTERRUPTS(CLBR_ANY)
-	TRACE_IRQS_OFF_DEBUG
+	TRACE_IRQS_OFF
 	testl	%ebx, %ebx			/* swapgs needed? */
 	jnz	.Lparanoid_exit_no_swapgs
 	TRACE_IRQS_IRETQ
@@ -933,7 +891,7 @@ SYM_CODE_START_LOCAL(paranoid_exit)
 	SWAPGS_UNSAFE_STACK
 	jmp	restore_regs_and_return_to_kernel
 .Lparanoid_exit_no_swapgs:
-	TRACE_IRQS_IRETQ_DEBUG
+	TRACE_IRQS_IRETQ
 	/* Always restore stashed CR3 value (see paranoid_entry) */
 	RESTORE_CR3	scratch_reg=%rbx save_reg=%r14
 	jmp restore_regs_and_return_to_kernel

