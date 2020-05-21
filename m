Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D88AC433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 20:31:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 633D021508
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 20:31:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729821AbgEUUb5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 16:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729634AbgEUUby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 16:31:54 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70EEBC061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 13:31:54 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jbrqd-0000M3-JI; Thu, 21 May 2020 22:31:23 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 1AB7C100C2D;
        Thu, 21 May 2020 22:31:22 +0200 (CEST)
Message-Id: <20200521202117.473597954@linutronix.de>
User-Agent: quilt/0.65
Date:   Thu, 21 May 2020 22:05:20 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        X86 ML <x86@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
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
        Tom Lendacky <thomas.lendacky@amd.com>,
        Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Jason Chen CJ <jason.cj.chen@intel.com>,
        Zhao Yakui <yakui.zhao@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [patch V9 07/39] x86/entry: Cleanup idtentry_enter/exit() leftovers
References: <20200521200513.656533920@linutronix.de>
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

Now that everything is converted to conditional RCU handling remove
idtentry_enter/exit() and tidy up the conditional functions.

This does not remove rcu_irq_exit_preempt() to avoid conflicts with the RCU
tree. Will be removed once all of this hit Linus tree.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V9: New patch
---
 arch/x86/entry/common.c         |   67 +++++++++++++++++-----------------------
 arch/x86/include/asm/idtentry.h |   12 -------
 2 files changed, 30 insertions(+), 49 deletions(-)

--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -515,7 +515,6 @@ SYSCALL_DEFINE0(ni_syscall)
  * idtentry_enter_cond_rcu - Handle state tracking on idtentry with conditional
  *			     RCU handling
  * @regs:	Pointer to pt_regs of interrupted context
- * @cond_rcu:	Invoke rcu_irq_enter() only if RCU is not watching
  *
  * Invokes:
  *  - lockdep irqflag state tracking as low level ASM entry disabled
@@ -545,12 +544,12 @@ SYSCALL_DEFINE0(ni_syscall)
  * The return value must be fed into the rcu_exit argument of
  * idtentry_exit_cond_rcu().
  */
-bool noinstr idtentry_enter_cond_rcu(struct pt_regs *regs, bool cond_rcu)
+bool noinstr idtentry_enter_cond_rcu(struct pt_regs *regs)
 {
 	if (user_mode(regs)) {
 		enter_from_user_mode();
 	} else {
-		if (!cond_rcu || !__rcu_is_watching()) {
+		if (!__rcu_is_watching()) {
 			/*
 			 * If RCU is not watching then the same careful
 			 * sequence vs. lockdep and tracing is required
@@ -605,52 +604,44 @@ void noinstr idtentry_exit_cond_rcu(stru
 	if (user_mode(regs)) {
 		prepare_exit_to_usermode(regs);
 	} else if (regs->flags & X86_EFLAGS_IF) {
+		/*
+		 * If RCU was not watching on entry this needs to be done
+		 * carefully and needs the same ordering of lockdep/tracing
+		 * and RCU as the return to user mode path.
+		 */
+		if (rcu_exit) {
+			instrumentation_begin();
+			/* Tell the tracer that IRET will enable interrupts */
+			trace_hardirqs_on_prepare();
+			lockdep_hardirqs_on_prepare(CALLER_ADDR0);
+			instrumentation_end();
+			rcu_irq_exit();
+			lockdep_hardirqs_on(CALLER_ADDR0);
+			return;
+		}
+
+		instrumentation_begin();
+
 		/* Check kernel preemption, if enabled */
 		if (IS_ENABLED(CONFIG_PREEMPTION)) {
-			/*
-			 * This needs to be done very carefully.
-			 * idtentry_enter() invoked rcu_irq_enter(). This
-			 * needs to be undone before scheduling.
-			 *
-			 * Preemption is disabled inside of RCU idle
-			 * sections. When the task returns from
-			 * preempt_schedule_irq(), RCU is still watching.
-			 *
-			 * rcu_irq_exit_preempt() has additional state
-			 * checking if CONFIG_PROVE_RCU=y
-			 */
 			if (!preempt_count()) {
+				/* Sanity check RCU and thread stack */
+				rcu_irq_exit_check_preempt();
 				if (IS_ENABLED(CONFIG_DEBUG_ENTRY))
 					WARN_ON_ONCE(!on_thread_stack());
-				instrumentation_begin();
-				if (rcu_exit)
-					rcu_irq_exit_preempt();
 				if (need_resched())
 					preempt_schedule_irq();
-				/* Covers both tracing and lockdep */
-				trace_hardirqs_on();
-				instrumentation_end();
-				return;
 			}
 		}
-		/*
-		 * If preemption is disabled then this needs to be done
-		 * carefully with respect to RCU. The exception might come
-		 * from a RCU idle section in the idle task due to the fact
-		 * that safe_halt() enables interrupts. So this needs the
-		 * same ordering of lockdep/tracing and RCU as the return
-		 * to user mode path.
-		 */
-		instrumentation_begin();
-		/* Tell the tracer that IRET will enable interrupts */
-		trace_hardirqs_on_prepare();
-		lockdep_hardirqs_on_prepare(CALLER_ADDR0);
+		/* Covers both tracing and lockdep */
+		trace_hardirqs_on();
+
 		instrumentation_end();
-		if (rcu_exit)
-			rcu_irq_exit();
-		lockdep_hardirqs_on(CALLER_ADDR0);
 	} else {
-		/* IRQ flags state is correct already. Just tell RCU. */
+		/*
+		 * IRQ flags state is correct already. Just tell RCU if it
+		 * was not watching on entry.
+		 */
 		if (rcu_exit)
 			rcu_irq_exit();
 	}
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -10,19 +10,9 @@
 void idtentry_enter_user(struct pt_regs *regs);
 void idtentry_exit_user(struct pt_regs *regs);
 
-bool idtentry_enter_cond_rcu(struct pt_regs *regs, bool cond_rcu);
+bool idtentry_enter_cond_rcu(struct pt_regs *regs);
 void idtentry_exit_cond_rcu(struct pt_regs *regs, bool rcu_exit);
 
-static __always_inline void idtentry_enter(struct pt_regs *regs)
-{
-	idtentry_enter_cond_rcu(regs, false);
-}
-
-static __always_inline void idtentry_exit(struct pt_regs *regs)
-{
-	idtentry_exit_cond_rcu(regs, true);
-}
-
 /**
  * DECLARE_IDTENTRY - Declare functions for simple IDT entry points
  *		      No error code pushed by hardware

