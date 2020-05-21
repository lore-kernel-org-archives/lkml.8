Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4DFDC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 20:31:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97E76207F9
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 20:31:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729543AbgEUUbv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 16:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728577AbgEUUbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 16:31:50 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E71C061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 13:31:50 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jbrqZ-0000Gd-4a; Thu, 21 May 2020 22:31:19 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 58526100606;
        Thu, 21 May 2020 22:31:18 +0200 (CEST)
Message-Id: <20200521202117.181397835@linutronix.de>
User-Agent: quilt/0.65
Date:   Thu, 21 May 2020 22:05:17 +0200
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
Subject: [patch V9 04/39] x86/entry: Provide idtentry_entry/exit_cond_rcu()
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

From: Thomas Gleixner <tglx@linutronix.de>

After a lengthy discussion [1] it turned out that RCU does not need a full
rcu_irq_enter/exit() when RCU is already watching. All it needs if
NOHZ_FULL is active is to check whether the tick needs to be restarted.

This allows to avoid a separate variant for the pagefault handler which
cannot invoke rcu_irq_enter() on a kernel pagefault which might sleep.

The cond_rcu argument is only temporary and will be removed once the
existing users of idtentry_enter/exit() have been cleaned up. After that
the code can be significantly simplified.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: [1] https://lkml.kernel.org/r/20200515235125.628629605@linutronix.de
---
V9: Reworked to the new RCU mode
---
 arch/x86/entry/common.c         |   84 ++++++++++++++++++++++++++++++----------
 arch/x86/include/asm/idtentry.h |   14 +++++-
 2 files changed, 77 insertions(+), 21 deletions(-)

--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -512,8 +512,10 @@ SYSCALL_DEFINE0(ni_syscall)
 }
 
 /**
- * idtentry_enter - Handle state tracking on idtentry
+ * idtentry_enter_cond_rcu - Handle state tracking on idtentry with conditional
+ *			     RCU handling
  * @regs:	Pointer to pt_regs of interrupted context
+ * @cond_rcu:	Invoke rcu_irq_enter() only if RCU is not watching
  *
  * Invokes:
  *  - lockdep irqflag state tracking as low level ASM entry disabled
@@ -521,40 +523,81 @@ SYSCALL_DEFINE0(ni_syscall)
  *
  *  - Context tracking if the exception hit user mode.
  *
- *  - RCU notification if the exception hit kernel mode.
- *
  *  - The hardirq tracer to keep the state consistent as low level ASM
  *    entry disabled interrupts.
+ *
+ * For kernel mode entries RCU handling is done conditional. If RCU is
+ * watching then the only RCU requirement is to check whether the tick has
+ * to be restarted. If RCU is not watching then rcu_irq_enter() has to be
+ * invoked on entry and rcu_irq_exit() on exit.
+ *
+ * Avoiding the rcu_irq_enter/exit() calls is an optimization but also
+ * solves the problem of kernel mode pagefaults which can schedule, which
+ * is not possible after invoking rcu_irq_enter() without undoing it.
+ *
+ * For user mode entries enter_from_user_mode() must be invoked to
+ * establish the proper context for NOHZ_FULL. Otherwise scheduling on exit
+ * would not be possible.
+ *
+ * Returns: True if RCU has been adjusted on a kernel entry
+ *	    False otherwise
+ *
+ * The return value must be fed into the rcu_exit argument of
+ * idtentry_exit_cond_rcu().
  */
-void noinstr idtentry_enter(struct pt_regs *regs)
+bool noinstr idtentry_enter_cond_rcu(struct pt_regs *regs, bool cond_rcu)
 {
 	if (user_mode(regs)) {
 		enter_from_user_mode();
 	} else {
-		lockdep_hardirqs_off(CALLER_ADDR0);
-		rcu_irq_enter();
-		instrumentation_begin();
-		trace_hardirqs_off_prepare();
-		instrumentation_end();
+		if (!cond_rcu || !__rcu_is_watching()) {
+			/*
+			 * If RCU is not watching then the same careful
+			 * sequence vs. lockdep and tracing is required
+			 * as in enter_from_user_mode().
+			 *
+			 * This only happens for IRQs that hits the idle
+			 * loop, i.e. if idle is not using MWAIT.
+			 */
+			lockdep_hardirqs_off(CALLER_ADDR0);
+			rcu_irq_enter();
+			instrumentation_begin();
+			trace_hardirqs_off_prepare();
+			instrumentation_end();
+			return true;
+		} else {
+			/*
+			 * If RCU is watching then RCU only wants to check
+			 * whether it needs to restart the tick in NOHZ
+			 * mode.
+			 */
+			instrumentation_begin();
+			rcu_irq_enter_check_tick();
+			/* Use the combo lockdep/tracing function */
+			trace_hardirqs_off();
+			instrumentation_end();
+		}
 	}
+	return false;
 }
 
 /**
- * idtentry_exit - Common code to handle return from exceptions
+ * idtentry_exit_cond_rcu - Handle return from exception with conditional RCU
+ *			    handling
  * @regs:	Pointer to pt_regs (exception entry regs)
+ * @rcu_exit:	Invoke rcu_irq_exit() if true
  *
  * Depending on the return target (kernel/user) this runs the necessary
- * preemption and work checks if possible and required and returns to
+ * preemption and work checks if possible and reguired and returns to
  * the caller with interrupts disabled and no further work pending.
  *
  * This is the last action before returning to the low level ASM code which
  * just needs to return to the appropriate context.
  *
- * Invoked by all exception/interrupt IDTENTRY handlers which are not
- * returning through the paranoid exit path (all except NMI, #DF and the IST
- * variants of #MC and #DB) and are therefore on the thread stack.
+ * Counterpart to idtentry_enter_cond_rcu(). The return value of the entry
+ * function must be fed into the @rcu_exit argument.
  */
-void noinstr idtentry_exit(struct pt_regs *regs)
+void noinstr idtentry_exit_cond_rcu(struct pt_regs *regs, bool rcu_exit)
 {
 	lockdep_assert_irqs_disabled();
 
@@ -580,7 +623,8 @@ void noinstr idtentry_exit(struct pt_reg
 				if (IS_ENABLED(CONFIG_DEBUG_ENTRY))
 					WARN_ON_ONCE(!on_thread_stack());
 				instrumentation_begin();
-				rcu_irq_exit_preempt();
+				if (rcu_exit)
+					rcu_irq_exit_preempt();
 				if (need_resched())
 					preempt_schedule_irq();
 				/* Covers both tracing and lockdep */
@@ -602,10 +646,12 @@ void noinstr idtentry_exit(struct pt_reg
 		trace_hardirqs_on_prepare();
 		lockdep_hardirqs_on_prepare(CALLER_ADDR0);
 		instrumentation_end();
-		rcu_irq_exit();
+		if (rcu_exit)
+			rcu_irq_exit();
 		lockdep_hardirqs_on(CALLER_ADDR0);
 	} else {
-		/* IRQ flags state is correct already. Just tell RCU */
-		rcu_irq_exit();
+		/* IRQ flags state is correct already. Just tell RCU. */
+		if (rcu_exit)
+			rcu_irq_exit();
 	}
 }
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -7,8 +7,18 @@
 
 #ifndef __ASSEMBLY__
 
-void idtentry_enter(struct pt_regs *regs);
-void idtentry_exit(struct pt_regs *regs);
+bool idtentry_enter_cond_rcu(struct pt_regs *regs, bool cond_rcu);
+void idtentry_exit_cond_rcu(struct pt_regs *regs, bool rcu_exit);
+
+static __always_inline void idtentry_enter(struct pt_regs *regs)
+{
+	idtentry_enter_cond_rcu(regs, false);
+}
+
+static __always_inline void idtentry_exit(struct pt_regs *regs)
+{
+	idtentry_exit_cond_rcu(regs, true);
+}
 
 /**
  * DECLARE_IDTENTRY - Declare functions for simple IDT entry points

