Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B306C47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:15:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6DE1206FA
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:15:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729834AbgEEOP2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 10:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729822AbgEEOPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 10:15:24 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67F42C061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 07:15:24 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jVyLi-0001OD-5V; Tue, 05 May 2020 16:15:06 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id AF7E4FFC8D;
        Tue,  5 May 2020 16:15:05 +0200 (CEST)
Message-Id: <20200505134904.457578656@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 05 May 2020 15:44:06 +0200
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
Subject: [patch V4 part 3 12/29] x86/entry/common: Provide idtentry_enter/exit()
References: <20200505134354.774943181@linutronix.de>
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

Provide functions which handle the low level entry and exit similiar to
enter/exit from user mode.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/entry/common.c         |   89 ++++++++++++++++++++++++++++++++++++++++
 arch/x86/include/asm/idtentry.h |    3 +
 2 files changed, 92 insertions(+)

--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -510,3 +510,92 @@ SYSCALL_DEFINE0(ni_syscall)
 {
 	return -ENOSYS;
 }
+
+/**
+ * idtentry_enter - Handle state tracking on idtentry
+ * @regs:	Pointer to pt_regs of interrupted context
+ *
+ * Invokes:
+ *  - lockdep irqflag state tracking as low level ASM entry disabled
+ *    interrupts.
+ *
+ *  - Context tracking if the exception hit user mode.
+ *
+ *  - RCU notification if the exception hit kernel mode
+ *
+ *  - The hardirq tracer to keep the state consistent as low level ASM
+ *    entry disabled interrupts.
+ */
+void noinstr idtentry_enter(struct pt_regs *regs)
+{
+	if (user_mode(regs)) {
+		enter_from_user_mode();
+	} else {
+		lockdep_hardirqs_off(CALLER_ADDR0);
+		rcu_irq_enter();
+		instr_begin();
+		trace_hardirqs_off_prepare();
+		instr_end();
+	}
+}
+
+/**
+ * idtentry_exit - Common code to handle return from exceptions
+ * @regs:	Pointer to pt_regs (exception entry regs)
+ *
+ * Depending on the return target (kernel/user) this runs the necessary
+ * preemption and work checks if possible and reguired and returns to
+ * the caller with interrupts disabled and no further work pending.
+ *
+ * This is the last action before returning to the low level ASM code which
+ * just needs to return to the appropriate context.
+ *
+ * Invoked by all exception/interrupt IDTENTRY handlers which are not
+ * returning through the paranoid exit path (all except NMI, #DF and the IST
+ * variants of #MC and #DB).
+ */
+void noinstr idtentry_exit(struct pt_regs *regs)
+{
+	lockdep_assert_irqs_disabled();
+
+	/* Check whether this returns to user mode */
+	if (user_mode(regs)) {
+		prepare_exit_to_usermode(regs);
+	} else if (regs->flags & X86_EFLAGS_IF) {
+		/* Check kernel preemption, if enabled */
+		if (IS_ENABLED(CONFIG_PREEMPTION)) {
+			/*
+			 * This needs to be done very carefully.
+			 * idtentry_enter() invoked rcu_irq_enter(). This
+			 * needs to undone before scheduling.
+			 *
+			 * Preemption is disabled inside of RCU idle
+			 * sections. When the task returns from
+			 * preempt_schedule_irq(), RCU is still watching.
+			 *
+			 * rcu_irq_exit_preempt() has additional state
+			 * checking if CONFIG_PROVE_RCU=y
+			 */
+			if (!preempt_count()) {
+				instr_begin();
+				rcu_irq_exit_preempt();
+				if (need_resched())
+					preempt_schedule_irq();
+				/* Covers both tracing and lockdep */
+				trace_hardirqs_on();
+				instr_end();
+				return;
+			}
+		}
+		instr_begin();
+		/* Tell the tracer that IRET will enable interrupts */
+		trace_hardirqs_on_prepare();
+		lockdep_hardirqs_on_prepare(CALLER_ADDR0);
+		instr_end();
+		rcu_irq_exit();
+		lockdep_hardirqs_on(CALLER_ADDR0);
+	} else {
+		/* IRQ flags state is correct already. Just tell RCU */
+		rcu_irq_exit();
+	}
+}
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -7,6 +7,9 @@
 
 #ifndef __ASSEMBLY__
 
+void idtentry_enter(struct pt_regs *regs);
+void idtentry_exit(struct pt_regs *regs);
+
 /**
  * DECLARE_IDTENTRY - Declare functions for simple IDT entry points
  *		      No error code pushed by hardware

