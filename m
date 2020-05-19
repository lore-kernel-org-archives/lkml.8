Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8FC6C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 19:52:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6FB620888
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 19:52:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbgESTwq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 15:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726940AbgESTwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 15:52:40 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 788BAC08C5C3;
        Tue, 19 May 2020 12:52:40 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jb8Hx-0007pB-3o; Tue, 19 May 2020 21:52:33 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 9ADB81C0178;
        Tue, 19 May 2020 21:52:32 +0200 (CEST)
Date:   Tue, 19 May 2020 19:52:32 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Make RCU IRQ enter/exit functions rely on in_nmi()
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200505134101.617130349@linutronix.de>
References: <20200505134101.617130349@linutronix.de>
MIME-Version: 1.0
Message-ID: <158991795254.17951.5903947139387946517.tip-bot2@tip-bot2>
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

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     9ea366f669ded353ae49754216c042e7d2f72ba6
Gitweb:        https://git.kernel.org/tip/9ea366f669ded353ae49754216c042e7d2f72ba6
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Thu, 13 Feb 2020 12:31:16 -08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 19 May 2020 15:51:21 +02:00

rcu: Make RCU IRQ enter/exit functions rely on in_nmi()

The rcu_nmi_enter_common() and rcu_nmi_exit_common() functions take an
"irq" parameter that indicates whether these functions have been invoked from
an irq handler (irq==true) or an NMI handler (irq==false).

However, recent changes have applied notrace to a few critical functions
such that rcu_nmi_enter_common() and rcu_nmi_exit_common() many now rely on
in_nmi().  Note that in_nmi() works no differently than before, but rather
that tracing is now prohibited in code regions where in_nmi() would
incorrectly report NMI state.

Therefore remove the "irq" parameter and inline rcu_nmi_enter_common() and
rcu_nmi_exit_common() into rcu_nmi_enter() and rcu_nmi_exit(),
respectively.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Link: https://lkml.kernel.org/r/20200505134101.617130349@linutronix.de


---
 kernel/rcu/tree.c | 47 ++++++++++++++--------------------------------
 1 file changed, 15 insertions(+), 32 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 0713ef3..9454016 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -664,16 +664,18 @@ noinstr void rcu_user_enter(void)
 }
 #endif /* CONFIG_NO_HZ_FULL */
 
-/*
+/**
+ * rcu_nmi_exit - inform RCU of exit from NMI context
+ *
  * If we are returning from the outermost NMI handler that interrupted an
  * RCU-idle period, update rdp->dynticks and rdp->dynticks_nmi_nesting
  * to let the RCU grace-period handling know that the CPU is back to
  * being RCU-idle.
  *
- * If you add or remove a call to rcu_nmi_exit_common(), be sure to test
+ * If you add or remove a call to rcu_nmi_exit(), be sure to test
  * with CONFIG_RCU_EQS_DEBUG=y.
  */
-static __always_inline void rcu_nmi_exit_common(bool irq)
+noinstr void rcu_nmi_exit(void)
 {
 	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
 
@@ -704,7 +706,7 @@ static __always_inline void rcu_nmi_exit_common(bool irq)
 	trace_rcu_dyntick(TPS("Startirq"), rdp->dynticks_nmi_nesting, 0, atomic_read(&rdp->dynticks));
 	WRITE_ONCE(rdp->dynticks_nmi_nesting, 0); /* Avoid store tearing. */
 
-	if (irq)
+	if (!in_nmi())
 		rcu_prepare_for_idle();
 	instrumentation_end();
 
@@ -712,22 +714,11 @@ static __always_inline void rcu_nmi_exit_common(bool irq)
 	rcu_dynticks_eqs_enter();
 	// ... but is no longer watching here.
 
-	if (irq)
+	if (!in_nmi())
 		rcu_dynticks_task_enter();
 }
 
 /**
- * rcu_nmi_exit - inform RCU of exit from NMI context
- *
- * If you add or remove a call to rcu_nmi_exit(), be sure to test
- * with CONFIG_RCU_EQS_DEBUG=y.
- */
-void noinstr rcu_nmi_exit(void)
-{
-	rcu_nmi_exit_common(false);
-}
-
-/**
  * rcu_irq_exit - inform RCU that current CPU is exiting irq towards idle
  *
  * Exit from an interrupt handler, which might possibly result in entering
@@ -749,7 +740,7 @@ void noinstr rcu_nmi_exit(void)
 void noinstr rcu_irq_exit(void)
 {
 	lockdep_assert_irqs_disabled();
-	rcu_nmi_exit_common(true);
+	rcu_nmi_exit();
 }
 
 /*
@@ -838,7 +829,7 @@ void noinstr rcu_user_exit(void)
 #endif /* CONFIG_NO_HZ_FULL */
 
 /**
- * rcu_nmi_enter_common - inform RCU of entry to NMI context
+ * rcu_nmi_enter - inform RCU of entry to NMI context
  * @irq: Is this call from rcu_irq_enter?
  *
  * If the CPU was idle from RCU's viewpoint, update rdp->dynticks and
@@ -847,10 +838,10 @@ void noinstr rcu_user_exit(void)
  * long as the nesting level does not overflow an int.  (You will probably
  * run out of stack space first.)
  *
- * If you add or remove a call to rcu_nmi_enter_common(), be sure to test
+ * If you add or remove a call to rcu_nmi_enter(), be sure to test
  * with CONFIG_RCU_EQS_DEBUG=y.
  */
-static __always_inline void rcu_nmi_enter_common(bool irq)
+noinstr void rcu_nmi_enter(void)
 {
 	long incby = 2;
 	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
@@ -868,18 +859,18 @@ static __always_inline void rcu_nmi_enter_common(bool irq)
 	 */
 	if (rcu_dynticks_curr_cpu_in_eqs()) {
 
-		if (irq)
+		if (!in_nmi())
 			rcu_dynticks_task_exit();
 
 		// RCU is not watching here ...
 		rcu_dynticks_eqs_exit();
 		// ... but is watching here.
 
-		if (irq)
+		if (!in_nmi())
 			rcu_cleanup_after_idle();
 
 		incby = 1;
-	} else if (irq) {
+	} else if (!in_nmi()) {
 		instrumentation_begin();
 		if (tick_nohz_full_cpu(rdp->cpu) &&
 		    rdp->dynticks_nmi_nesting == DYNTICK_IRQ_NONIDLE &&
@@ -914,14 +905,6 @@ static __always_inline void rcu_nmi_enter_common(bool irq)
 }
 
 /**
- * rcu_nmi_enter - inform RCU of entry to NMI context
- */
-noinstr void rcu_nmi_enter(void)
-{
-	rcu_nmi_enter_common(false);
-}
-
-/**
  * rcu_irq_enter - inform RCU that current CPU is entering irq away from idle
  *
  * Enter an interrupt handler, which might possibly result in exiting
@@ -946,7 +929,7 @@ noinstr void rcu_nmi_enter(void)
 noinstr void rcu_irq_enter(void)
 {
 	lockdep_assert_irqs_disabled();
-	rcu_nmi_enter_common(true);
+	rcu_nmi_enter();
 }
 
 /*
