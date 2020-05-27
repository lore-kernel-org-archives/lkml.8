Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A6D7C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 08:13:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69DE721531
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 08:13:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387854AbgE0INC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 04:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729558AbgE0IMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 04:12:05 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66DF4C061A0F;
        Wed, 27 May 2020 01:12:05 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jdrAR-0002fO-Hu; Wed, 27 May 2020 10:12:03 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 79A371C04DD;
        Wed, 27 May 2020 10:11:59 +0200 (CEST)
Date:   Wed, 27 May 2020 08:11:59 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/entry: Clean up idtentry_enter/exit() leftovers
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200521202117.473597954@linutronix.de>
References: <20200521202117.473597954@linutronix.de>
MIME-Version: 1.0
Message-ID: <159056711921.17951.16542219470449240750.tip-bot2@tip-bot2>
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

Commit-ID:     1951bc04047a0ca5c88146c4b19b296d40e489ef
Gitweb:        https://git.kernel.org/tip/1951bc04047a0ca5c88146c4b19b296d40e489ef
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 21 May 2020 22:05:20 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 26 May 2020 19:06:27 +02:00

x86/entry: Clean up idtentry_enter/exit() leftovers

Now that everything is converted to conditional RCU handling remove
idtentry_enter/exit() and tidy up the conditional functions.

This does not remove rcu_irq_exit_preempt(), to avoid conflicts with the RCU
tree. Will be removed once all of this hits Linus's tree.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Andy Lutomirski <luto@kernel.org>
Link: https://lore.kernel.org/r/20200521202117.473597954@linutronix.de
---
 arch/x86/entry/common.c         | 67 +++++++++++++-------------------
 arch/x86/include/asm/idtentry.h | 12 +------
 2 files changed, 30 insertions(+), 49 deletions(-)

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index b7fcb13..2a80e4e 100644
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
@@ -545,14 +544,14 @@ SYSCALL_DEFINE0(ni_syscall)
  * The return value must be fed into the rcu_exit argument of
  * idtentry_exit_cond_rcu().
  */
-bool noinstr idtentry_enter_cond_rcu(struct pt_regs *regs, bool cond_rcu)
+bool noinstr idtentry_enter_cond_rcu(struct pt_regs *regs)
 {
 	if (user_mode(regs)) {
 		enter_from_user_mode();
 		return false;
 	}
 
-	if (!cond_rcu || !__rcu_is_watching()) {
+	if (!__rcu_is_watching()) {
 		/*
 		 * If RCU is not watching then the same careful
 		 * sequence vs. lockdep and tracing is required
@@ -608,52 +607,44 @@ void noinstr idtentry_exit_cond_rcu(struct pt_regs *regs, bool rcu_exit)
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
diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index 0f974e5..b056889 100644
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
