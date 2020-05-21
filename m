Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 690BDC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 20:33:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 403FA20874
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 20:33:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730603AbgEUUdq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 16:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729683AbgEUUbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 16:31:55 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A6B1C061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 13:31:55 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jbrqW-0000GW-HZ; Thu, 21 May 2020 22:31:16 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id D28ED100606;
        Thu, 21 May 2020 22:31:15 +0200 (CEST)
Message-Id: <20200521202116.996113173@linutronix.de>
User-Agent: quilt/0.65
Date:   Thu, 21 May 2020 22:05:15 +0200
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
Subject: [patch V9 02/39] rcu: Abstract out rcu_irq_enter_check_tick() from
 rcu_nmi_enter()
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

From: Paul E. McKenney <paulmck@kernel.org>

There will likely be exception handlers that can sleep, which rules
out the usual approach of invoking rcu_nmi_enter() on entry and also
rcu_nmi_exit() on all exit paths.  However, the alternative approach of
just not calling anything can prevent RCU from coaxing quiescent states
from nohz_full CPUs that are looping in the kernel:  RCU must instead
IPI them explicitly.  It would be better to enable the scheduler tick
on such CPUs to interact with RCU in a lighter-weight manner, and this
enabling is one of the things that rcu_nmi_enter() currently does.

What is needed is something that helps RCU coax quiescent states while
not preventing subsequent sleeps.  This commit therefore splits out the
nohz_full scheduler-tick enabling from the rest of the rcu_nmi_enter()
logic into a new function named rcu_irq_enter_check_tick().

[ tglx: Renamed the function and made it a nop when context tracking is off ]

Suggested-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V9: New patch
---
 include/linux/hardirq.h |    9 +++++
 kernel/rcu/tree.c       |   82 ++++++++++++++++++++++++++++++++++++------------
 2 files changed, 71 insertions(+), 20 deletions(-)

--- a/include/linux/hardirq.h
+++ b/include/linux/hardirq.h
@@ -2,6 +2,7 @@
 #ifndef LINUX_HARDIRQ_H
 #define LINUX_HARDIRQ_H
 
+#include <linux/context_tracking_state.h>
 #include <linux/preempt.h>
 #include <linux/lockdep.h>
 #include <linux/ftrace_irq.h>
@@ -27,6 +28,14 @@ extern void rcu_nmi_enter(void);
 extern void rcu_nmi_exit(void);
 #endif
 
+void __rcu_irq_enter_check_tick(void);
+
+static __always_inline void rcu_irq_enter_check_tick(void)
+{
+	if (context_tracking_enabled())
+		__rcu_irq_enter_check_tick();
+}
+
 /*
  * It is safe to do non-atomic ops on ->hardirq_context,
  * because NMI handlers may not preempt and the ops are
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -848,6 +848,67 @@ void noinstr rcu_user_exit(void)
 {
 	rcu_eqs_exit(1);
 }
+
+/**
+ * __rcu_irq_enter_check_tick - Enable scheduler tick on CPU if RCU needs it.
+ *
+ * The scheduler tick is not normally enabled when CPUs enter the kernel
+ * from nohz_full userspace execution.  After all, nohz_full userspace
+ * execution is an RCU quiescent state and the time executing in the kernel
+ * is quite short.  Except of course when it isn't.  And it is not hard to
+ * cause a large system to spend tens of seconds or even minutes looping
+ * in the kernel, which can cause a number of problems, include RCU CPU
+ * stall warnings.
+ *
+ * Therefore, if a nohz_full CPU fails to report a quiescent state
+ * in a timely manner, the RCU grace-period kthread sets that CPU's
+ * ->rcu_urgent_qs flag with the expectation that the next interrupt or
+ * exception will invoke this function, which will turn on the scheduler
+ * tick, which will enable RCU to detect that CPU's quiescent states,
+ * for example, due to cond_resched() calls in CONFIG_PREEMPT=n kernels.
+ * The tick will be disabled once a quiescent state is reported for
+ * this CPU.
+ *
+ * Of course, in carefully tuned systems, there might never be an
+ * interrupt or exception.  In that case, the RCU grace-period kthread
+ * will eventually cause one to happen.  However, in less carefully
+ * controlled environments, this function allows RCU to get what it
+ * needs without creating otherwise useless interruptions.
+ */
+void __rcu_irq_enter_check_tick(void)
+{
+	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
+
+	 // Enabling the tick is unsafe in NMI handlers.
+	if (WARN_ON_ONCE(in_nmi()))
+		return;
+
+	RCU_LOCKDEP_WARN(rcu_dynticks_curr_cpu_in_eqs(),
+			 "Illegal rcu_irq_enter_check_tick() from extended quiescent state");
+
+	if (!tick_nohz_full_cpu(rdp->cpu) ||
+	    !READ_ONCE(rdp->rcu_urgent_qs) ||
+	    READ_ONCE(rdp->rcu_forced_tick)) {
+		// RCU doesn't need nohz_full help from this CPU, or it is
+		// already getting that help.
+		return;
+	}
+
+	// We get here only when not in an extended quiescent state and
+	// from interrupts (as opposed to NMIs).  Therefore, (1) RCU is
+	// already watching and (2) The fact that we are in an interrupt
+	// handler and that the rcu_node lock is an irq-disabled lock
+	// prevents self-deadlock.  So we can safely recheck under the lock.
+	// Note that the nohz_full state currently cannot change.
+	raw_spin_lock_rcu_node(rdp->mynode);
+	if (rdp->rcu_urgent_qs && !rdp->rcu_forced_tick) {
+		// A nohz_full CPU is in the kernel and RCU needs a
+		// quiescent state.  Turn on the tick!
+		WRITE_ONCE(rdp->rcu_forced_tick, true);
+		tick_dep_set_cpu(rdp->cpu, TICK_DEP_BIT_RCU);
+	}
+	raw_spin_unlock_rcu_node(rdp->mynode);
+}
 #endif /* CONFIG_NO_HZ_FULL */
 
 /**
@@ -894,26 +955,7 @@ noinstr void rcu_nmi_enter(void)
 		incby = 1;
 	} else if (!in_nmi()) {
 		instrumentation_begin();
-		if (tick_nohz_full_cpu(rdp->cpu) &&
-		    rdp->dynticks_nmi_nesting == DYNTICK_IRQ_NONIDLE &&
-		    READ_ONCE(rdp->rcu_urgent_qs) &&
-		    !READ_ONCE(rdp->rcu_forced_tick)) {
-			// We get here only if we had already exited the
-			// extended quiescent state and this was an
-			// interrupt (not an NMI).  Therefore, (1) RCU is
-			// already watching and (2) The fact that we are in
-			// an interrupt handler and that the rcu_node lock
-			// is an irq-disabled lock prevents self-deadlock.
-			// So we can safely recheck under the lock.
-			raw_spin_lock_rcu_node(rdp->mynode);
-			if (rdp->rcu_urgent_qs && !rdp->rcu_forced_tick) {
-				// A nohz_full CPU is in the kernel and RCU
-				// needs a quiescent state.  Turn on the tick!
-				WRITE_ONCE(rdp->rcu_forced_tick, true);
-				tick_dep_set_cpu(rdp->cpu, TICK_DEP_BIT_RCU);
-			}
-			raw_spin_unlock_rcu_node(rdp->mynode);
-		}
+		rcu_irq_enter_check_tick();
 		instrumentation_end();
 	}
 	instrumentation_begin();

