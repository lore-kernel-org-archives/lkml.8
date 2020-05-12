Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65911C2D0F8
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 22:25:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4549523126
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 22:25:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732074AbgELWZc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 18:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731703AbgELWXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 18:23:21 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 101E0C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 15:23:21 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jYdIH-0004kH-RR; Wed, 13 May 2020 00:22:35 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 543C91001FC;
        Wed, 13 May 2020 00:22:33 +0200 (CEST)
Message-Id: <20200512213810.611305682@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 12 May 2020 23:01:11 +0200
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
        Tom Lendacky <thomas.lendacky@amd.com>,
        Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Jason Chen CJ <jason.cj.chen@intel.com>,
        Zhao Yakui <yakui.zhao@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [patch V5 12/38] x86/entry: Provide idtentry_entry/exit_cond_rcu()
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

The pagefault handler cannot use the regular idtentry_enter() because that
invokes rcu_irq_enter() if the pagefault was caused in the kernel. Not a
problem per se, but kernel side page faults can schedule which is not
possible without invoking rcu_irq_exit().

Adding rcu_irq_exit() and a matching rcu_irq_enter() into the actual
pagefault handling code would be possible, but not pretty either.

Provide idtentry_entry/exit_cond_rcu() which calls rcu_irq_enter() only
when RCU is not watching. The conditional RCU enabling is a correctness
issue: A kernel page fault which hits a RCU idle reason can neither
schedule nor is it likely to survive. But avoiding RCU warnings or RCU side
effects is at least increasing the chance for useful debug output.

The function is also useful for implementing lightweight reschedule IPI and
KVM posted interrupt IPI entry handling later.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V5: Add comments about the rcu_exit conditional and make changelog readable.
---
 arch/x86/entry/common.c         |  142 +++++++++++++++++++++++++++++++++++-----
 arch/x86/include/asm/idtentry.h |    3 
 2 files changed, 128 insertions(+), 17 deletions(-)

--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -515,6 +515,36 @@ SYSCALL_DEFINE0(ni_syscall)
 	return -ENOSYS;
 }
 
+static __always_inline bool __idtentry_enter(struct pt_regs *regs,
+					     bool cond_rcu)
+{
+	if (user_mode(regs)) {
+		enter_from_user_mode();
+	} else {
+		if (!cond_rcu || !__rcu_is_watching()) {
+			/*
+			 * If RCU is not watching then the same careful
+			 * sequence vs. lockdep and tracing is required.
+			 */
+			lockdep_hardirqs_off(CALLER_ADDR0);
+			rcu_irq_enter();
+			instrumentation_begin();
+			trace_hardirqs_off_prepare();
+			instrumentation_end();
+			return true;
+		} else {
+			/*
+			 * If RCU is watching then the combo function
+			 * can be used.
+			 */
+			instrumentation_begin();
+			trace_hardirqs_off();
+			instrumentation_end();
+		}
+	}
+	return false;
+}
+
 /**
  * idtentry_enter - Handle state tracking on idtentry
  * @regs:	Pointer to pt_regs of interrupted context
@@ -532,19 +562,60 @@ SYSCALL_DEFINE0(ni_syscall)
  */
 void noinstr idtentry_enter(struct pt_regs *regs)
 {
-	if (user_mode(regs)) {
-		enter_from_user_mode();
-	} else {
-		lockdep_hardirqs_off(CALLER_ADDR0);
-		rcu_irq_enter();
-		instrumentation_begin();
-		trace_hardirqs_off_prepare();
-		instrumentation_end();
-	}
+	__idtentry_enter(regs, false);
+}
+
+/**
+ * idtentry_enter_cond_rcu - Handle state tracking on idtentry with conditional
+ *			     RCU handling
+ * @regs:	Pointer to pt_regs of interrupted context
+ *
+ * Invokes:
+ *  - lockdep irqflag state tracking as low level ASM entry disabled
+ *    interrupts.
+ *
+ *  - Context tracking if the exception hit user mode.
+ *
+ *  - The hardirq tracer to keep the state consistent as low level ASM
+ *    entry disabled interrupts.
+ *
+ * For kernel mode entries the conditional RCU handling is useful for two
+ * purposes
+ *
+ * 1) Pagefaults: Kernel code can fault and sleep, e.g. on exec. This code
+ *    is not in an RCU idle section. If rcu_irq_enter() would be invoked
+ *    then nothing would invoke rcu_irq_exit() before scheduling.
+ *
+ *   If the kernel faults in a RCU idle section then all bets are off
+ *   anyway but at least avoiding a subsequent issue vs. RCU is helpful for
+ *   debugging.
+ *
+ * 2) Scheduler IPI: To avoid the overhead of a regular idtentry vs. RCU
+ *    and irq_enter() the IPI can be made lightweight if the tracepoints
+ *    are not enabled. While the IPI functionality itself does not require
+ *    RCU (folding preempt count) it still calls out into instrumentable
+ *    functions, e.g. ack_APIC_irq(). The scheduler IPI can hit RCU idle
+ *    sections, so RCU needs to be adjusted. For the fast path case, e.g.
+ *    KVM kicking a vCPU out of guest mode this can be avoided because the
+ *    IPI is handled after KVM reestablished kernel context including RCU.
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
+ */
+bool noinstr idtentry_enter_cond_rcu(struct pt_regs *regs)
+{
+	return __idtentry_enter(regs, true);
 }
 
 static __always_inline void __idtentry_exit(struct pt_regs *regs,
-					    bool preempt_hcall)
+					    bool preempt_hcall, bool rcu_exit)
 {
 	lockdep_assert_irqs_disabled();
 
@@ -570,7 +641,12 @@ static __always_inline void __idtentry_e
 				if (IS_ENABLED(CONFIG_DEBUG_ENTRY))
 					WARN_ON_ONCE(!on_thread_stack());
 				instrumentation_begin();
-				rcu_irq_exit_preempt();
+				/*
+				 * Conditional for idtentry_exit_cond_rcu(),
+				 * unconditional for all other users.
+				 */
+				if (rcu_exit)
+					rcu_irq_exit_preempt();
 				if (need_resched())
 					preempt_schedule_irq();
 				/* Covers both tracing and lockdep */
@@ -602,11 +678,22 @@ static __always_inline void __idtentry_e
 		trace_hardirqs_on_prepare();
 		lockdep_hardirqs_on_prepare(CALLER_ADDR0);
 		instrumentation_end();
-		rcu_irq_exit();
+		/*
+		 * Conditional for idtentry_exit_cond_rcu(), unconditional
+		 * for all other users.
+		 */
+		if (rcu_exit)
+			rcu_irq_exit();
 		lockdep_hardirqs_on(CALLER_ADDR0);
 	} else {
-		/* IRQ flags state is correct already. Just tell RCU */
-		rcu_irq_exit();
+		/*
+		 * IRQ flags state is correct already. Just tell RCU.
+		 *
+		 * Conditional for idtentry_exit_cond_rcu(), unconditional
+		 * for all other users.
+		 */
+		if (rcu_exit)
+			rcu_irq_exit();
 	}
 }
 
@@ -627,7 +714,28 @@ static __always_inline void __idtentry_e
  */
 void noinstr idtentry_exit(struct pt_regs *regs)
 {
-	__idtentry_exit(regs, false);
+	__idtentry_exit(regs, false, true);
+}
+
+/**
+ * idtentry_exit_cond_rcu - Handle return from exception with conditional RCU
+ *			    handling
+ * @regs:	Pointer to pt_regs (exception entry regs)
+ * @rcu_exit:	Invoke rcu_irq_exit() if true
+ *
+ * Depending on the return target (kernel/user) this runs the necessary
+ * preemption and work checks if possible and reguired and returns to
+ * the caller with interrupts disabled and no further work pending.
+ *
+ * This is the last action before returning to the low level ASM code which
+ * just needs to return to the appropriate context.
+ *
+ * Counterpart to idtentry_enter_cond_rcu(). The return value of the entry
+ * function must be fed into the @rcu_exit argument.
+ */
+void noinstr idtentry_exit_cond_rcu(struct pt_regs *regs, bool rcu_exit)
+{
+	__idtentry_exit(regs, false, rcu_exit);
 }
 
 #ifdef CONFIG_XEN_PV
@@ -659,11 +767,11 @@ static void __xen_pv_evtchn_do_upcall(vo
 	set_irq_regs(old_regs);
 
 	if (IS_ENABLED(CONFIG_PREEMPTION)) {
-		__idtentry_exit(regs, false);
+		__idtentry_exit(regs, false, true);
 	} else {
 		bool inhcall = __this_cpu_read(xen_in_preemptible_hcall);
 
-		__idtentry_exit(regs, inhcall && need_resched());
+		__idtentry_exit(regs, inhcall && need_resched(), true);
 	}
 }
 #endif /* CONFIG_XEN_PV */
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -10,6 +10,9 @@
 void idtentry_enter(struct pt_regs *regs);
 void idtentry_exit(struct pt_regs *regs);
 
+bool idtentry_enter_cond_rcu(struct pt_regs *regs);
+void idtentry_exit_cond_rcu(struct pt_regs *regs, bool rcu_exit);
+
 /**
  * DECLARE_IDTENTRY - Declare functions for simple IDT entry points
  *		      No error code pushed by hardware

