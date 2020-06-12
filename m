Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4742C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 19:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C4F320723
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 19:50:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbgFLTuX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 15:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbgFLTuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 15:50:11 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93923C08C5C1;
        Fri, 12 Jun 2020 12:50:11 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jjpgn-0003Pe-KY; Fri, 12 Jun 2020 21:50:09 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 303291C009C;
        Fri, 12 Jun 2020 21:50:08 +0200 (CEST)
Date:   Fri, 12 Jun 2020 19:50:07 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/entry: Force rcu_irq_enter() when in idle task
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <87wo4cxubv.fsf@nanos.tec.linutronix.de>
References: <87wo4cxubv.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Message-ID: <159199140796.16989.8322013716817906984.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     0bf3924bfabd13ba21aa702344fc00b3b3263e5a
Gitweb:        https://git.kernel.org/tip/0bf3924bfabd13ba21aa702344fc00b3b3263e5a
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 12 Jun 2020 15:55:00 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 12 Jun 2020 21:36:33 +02:00

x86/entry: Force rcu_irq_enter() when in idle task

The idea of conditionally calling into rcu_irq_enter() only when RCU is
not watching turned out to be not completely thought through.

Paul noticed occasional premature end of grace periods in RCU torture
testing. Bisection led to the commit which made the invocation of
rcu_irq_enter() conditional on !rcu_is_watching().

It turned out that this conditional breaks RCU assumptions about the idle
task when the scheduler tick happens to be a nested interrupt. Nested
interrupts can happen when the first interrupt invokes softirq processing
on return which enables interrupts.

If that nested tick interrupt does not invoke rcu_irq_enter() then the
RCU's irq-nesting checks will believe that this interrupt came directly
from idle, which will cause RCU to report a quiescent state.  Because this
interrupt instead came from a softirq handler which might have been
executing an RCU read-side critical section, this can cause the grace
period to end prematurely.

Change the condition from !rcu_is_watching() to is_idle_task(current) which
enforces that interrupts in the idle task unconditionally invoke
rcu_irq_enter() independent of the RCU state.

This is also correct vs. user mode entries in NOHZ full scenarios because
user mode entries bring RCU out of EQS and force the RCU irq nesting state
accounting to nested. As only the first interrupt can enter from user mode
a nested tick interrupt will enter from kernel mode and as the nesting
state accounting is forced to nesting it will not do anything stupid even
if rcu_irq_enter() has not been invoked.

Fixes: 3eeec3858488 ("x86/entry: Provide idtentry_entry/exit_cond_rcu()")
Reported-by: "Paul E. McKenney" <paulmck@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: "Paul E. McKenney" <paulmck@kernel.org>
Reviewed-by: "Paul E. McKenney" <paulmck@kernel.org>
Acked-by: Andy Lutomirski <luto@kernel.org>
Acked-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lkml.kernel.org/r/87wo4cxubv.fsf@nanos.tec.linutronix.de

---
 arch/x86/entry/common.c | 35 ++++++++++++++++++++++++++++-------
 1 file changed, 28 insertions(+), 7 deletions(-)

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index f4d5778..bd3f141 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -557,14 +557,34 @@ bool noinstr idtentry_enter_cond_rcu(struct pt_regs *regs)
 		return false;
 	}
 
-	if (!__rcu_is_watching()) {
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
 		/*
 		 * If RCU is not watching then the same careful
 		 * sequence vs. lockdep and tracing is required
 		 * as in enter_from_user_mode().
-		 *
-		 * This only happens for IRQs that hit the idle
-		 * loop, i.e. if idle is not using MWAIT.
 		 */
 		lockdep_hardirqs_off(CALLER_ADDR0);
 		rcu_irq_enter();
@@ -576,9 +596,10 @@ bool noinstr idtentry_enter_cond_rcu(struct pt_regs *regs)
 	}
 
 	/*
-	 * If RCU is watching then RCU only wants to check
-	 * whether it needs to restart the tick in NOHZ
-	 * mode.
+	 * If RCU is watching then RCU only wants to check whether it needs
+	 * to restart the tick in NOHZ mode. rcu_irq_enter_check_tick()
+	 * already contains a warning when RCU is not watching, so no point
+	 * in having another one here.
 	 */
 	instrumentation_begin();
 	rcu_irq_enter_check_tick();
