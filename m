Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCC3CC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 19:09:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97458206F0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 19:09:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="o/CtxMUA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="X2FhEJ8v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbgGXTI7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 15:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbgGXTI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 15:08:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09870C0619E4;
        Fri, 24 Jul 2020 12:08:58 -0700 (PDT)
Date:   Fri, 24 Jul 2020 19:08:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595617735;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SXe/UQHKQaWP/pYEVNahzv7DQinBpfDnTwGGWtx+skI=;
        b=o/CtxMUA40KrWnvGS5c+AvhytGIB3yHyV3MovnjlLW+HpHs+3sLCLcWR+I6CDTmIsFdPMt
        KvB5hizxn6V5ChbptKDLZf1cklSrAfd+JzeHhpRrolw5WlK7jeBcxe61vLVMm6Jq1foBQ+
        xZ2Ot5pTQOpDymC8kQd4kEeoclI/mHYQXgHHoEXZPo7xhj6vvH+5tFl3egyXlyLqprKErK
        ewhghvpBFVh2w4uB0t/0+cct4XLOHlVYaDTZ5q/TodhsmPCGZVbnRYr8avJFALQuUGNow7
        auwAKLShpM5Ym2KiWJRdLUh9Ca/iK2aPftDIUwbAF0BiaYO56IBwOb6wSBzg3A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595617735;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SXe/UQHKQaWP/pYEVNahzv7DQinBpfDnTwGGWtx+skI=;
        b=X2FhEJ8vZmGsydW052Uip2xNvUcXt0KlDyYMytdreLxLOjI8/w57HXLkTAxPtDreqmy3+4
        R7WaPtMNZFMlm8Ag==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/entry] entry: Provide generic interrupt entry/exit code
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200722220519.723703209@linutronix.de>
References: <20200722220519.723703209@linutronix.de>
MIME-Version: 1.0
Message-ID: <159561773507.4006.8156612998582412316.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/entry branch of tip:

Commit-ID:     a5497bab5f72dce38a259a53fd3ac1239a7ecf40
Gitweb:        https://git.kernel.org/tip/a5497bab5f72dce38a259a53fd3ac1239a7ecf40
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 22 Jul 2020 23:59:58 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 24 Jul 2020 14:59:04 +02:00

entry: Provide generic interrupt entry/exit code

Like the syscall entry/exit code interrupt/exception entry after the real
low level ASM bits should not be different accross architectures.

Provide a generic version based on the x86 code.

irqentry_enter() is called after the low level entry code and
irqentry_exit() must be invoked right before returning to the low level
code which just contains the actual return logic. The code before
irqentry_enter() and irqentry_exit() must not be instrumented. Code after
irqentry_enter() and before irqentry_exit() can be instrumented.

irqentry_enter() invokes irqentry_enter_from_user_mode() if the
interrupt/exception came from user mode. If if entered from kernel mode it
handles the kernel mode variant of establishing state for lockdep, RCU and
tracing depending on the kernel context it interrupted (idle, non-idle).

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20200722220519.723703209@linutronix.de


---
 include/linux/entry-common.h |  62 ++++++++++++++++++-
 kernel/entry/common.c        | 117 ++++++++++++++++++++++++++++++++++-
 2 files changed, 179 insertions(+)

diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index c4a57be..efebbff 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -307,4 +307,66 @@ void irqentry_enter_from_user_mode(struct pt_regs *regs);
  */
 void irqentry_exit_to_user_mode(struct pt_regs *regs);
 
+#ifndef irqentry_state
+typedef struct irqentry_state {
+	bool	exit_rcu;
+} irqentry_state_t;
+#endif
+
+/**
+ * irqentry_enter - Handle state tracking on ordinary interrupt entries
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
+ * As a precondition, this requires that the entry came from user mode,
+ * idle, or a kernel context in which RCU is watching.
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
+ * For user mode entries irqentry_enter_from_user_mode() is invoked to
+ * establish the proper context for NOHZ_FULL. Otherwise scheduling on exit
+ * would not be possible.
+ *
+ * Returns: An opaque object that must be passed to idtentry_exit()
+ */
+irqentry_state_t noinstr irqentry_enter(struct pt_regs *regs);
+
+/**
+ * irqentry_exit_cond_resched - Conditionally reschedule on return from interrupt
+ *
+ * Conditional reschedule with additional sanity checks.
+ */
+void irqentry_exit_cond_resched(void);
+
+/**
+ * irqentry_exit - Handle return from exception that used irqentry_enter()
+ * @regs:	Pointer to pt_regs (exception entry regs)
+ * @state:	Return value from matching call to irqentry_enter()
+ *
+ * Depending on the return target (kernel/user) this runs the necessary
+ * preemption and work checks if possible and reguired and returns to
+ * the caller with interrupts disabled and no further work pending.
+ *
+ * This is the last action before returning to the low level ASM code which
+ * just needs to return to the appropriate context.
+ *
+ * Counterpart to irqentry_enter().
+ */
+void noinstr irqentry_exit(struct pt_regs *regs, irqentry_state_t state);
+
 #endif
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index 0a051bb..495f5c0 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -255,3 +255,120 @@ noinstr void irqentry_exit_to_user_mode(struct pt_regs *regs)
 	instrumentation_end();
 	exit_to_user_mode();
 }
+
+irqentry_state_t noinstr irqentry_enter(struct pt_regs *regs)
+{
+	irqentry_state_t ret = {
+		.exit_rcu = false,
+	};
+
+	if (user_mode(regs)) {
+		irqentry_enter_from_user_mode(regs);
+		return ret;
+	}
+
+	/*
+	 * If this entry hit the idle task invoke rcu_irq_enter() whether
+	 * RCU is watching or not.
+	 *
+	 * Interupts can nest when the first interrupt invokes softirq
+	 * processing on return which enables interrupts.
+	 *
+	 * Scheduler ticks in the idle task can mark quiescent state and
+	 * terminate a grace period, if and only if the timer interrupt is
+	 * not nested into another interrupt.
+	 *
+	 * Checking for __rcu_is_watching() here would prevent the nesting
+	 * interrupt to invoke rcu_irq_enter(). If that nested interrupt is
+	 * the tick then rcu_flavor_sched_clock_irq() would wrongfully
+	 * assume that it is the first interupt and eventually claim
+	 * quiescient state and end grace periods prematurely.
+	 *
+	 * Unconditionally invoke rcu_irq_enter() so RCU state stays
+	 * consistent.
+	 *
+	 * TINY_RCU does not support EQS, so let the compiler eliminate
+	 * this part when enabled.
+	 */
+	if (!IS_ENABLED(CONFIG_TINY_RCU) && is_idle_task(current)) {
+		/*
+		 * If RCU is not watching then the same careful
+		 * sequence vs. lockdep and tracing is required
+		 * as in irq_enter_from_user_mode().
+		 */
+		lockdep_hardirqs_off(CALLER_ADDR0);
+		rcu_irq_enter();
+		instrumentation_begin();
+		trace_hardirqs_off_finish();
+		instrumentation_end();
+
+		ret.exit_rcu = true;
+		return ret;
+	}
+
+	/*
+	 * If RCU is watching then RCU only wants to check whether it needs
+	 * to restart the tick in NOHZ mode. rcu_irq_enter_check_tick()
+	 * already contains a warning when RCU is not watching, so no point
+	 * in having another one here.
+	 */
+	instrumentation_begin();
+	rcu_irq_enter_check_tick();
+	/* Use the combo lockdep/tracing function */
+	trace_hardirqs_off();
+	instrumentation_end();
+
+	return ret;
+}
+
+void irqentry_exit_cond_resched(void)
+{
+	if (!preempt_count()) {
+		/* Sanity check RCU and thread stack */
+		rcu_irq_exit_check_preempt();
+		if (IS_ENABLED(CONFIG_DEBUG_ENTRY))
+			WARN_ON_ONCE(!on_thread_stack());
+		if (need_resched())
+			preempt_schedule_irq();
+	}
+}
+
+void noinstr irqentry_exit(struct pt_regs *regs, irqentry_state_t state)
+{
+	lockdep_assert_irqs_disabled();
+
+	/* Check whether this returns to user mode */
+	if (user_mode(regs)) {
+		irqentry_exit_to_user_mode(regs);
+	} else if (!regs_irqs_disabled(regs)) {
+		/*
+		 * If RCU was not watching on entry this needs to be done
+		 * carefully and needs the same ordering of lockdep/tracing
+		 * and RCU as the return to user mode path.
+		 */
+		if (state.exit_rcu) {
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
+		if (IS_ENABLED(CONFIG_PREEMPTION))
+			irqentry_exit_cond_resched();
+		/* Covers both tracing and lockdep */
+		trace_hardirqs_on();
+		instrumentation_end();
+	} else {
+		/*
+		 * IRQ flags state is correct already. Just tell RCU if it
+		 * was not watching on entry.
+		 */
+		if (state.exit_rcu)
+			rcu_irq_exit();
+	}
+}
