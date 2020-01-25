Return-Path: <SRS0=aedO=3O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2728BC35243
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 10:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01B2B22464
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 10:42:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727964AbgAYKmp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jan 2020 05:42:45 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44091 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbgAYKmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jan 2020 05:42:44 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ivItm-0008Lg-Q8; Sat, 25 Jan 2020 11:42:42 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 61DB61C0105;
        Sat, 25 Jan 2020 11:42:42 +0100 (CET)
Date:   Sat, 25 Jan 2020 10:42:42 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Avoid tick_dep_set_cpu() misordering
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <157994896211.396.14885465096262437698.tip-bot2@tip-bot2>
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

Commit-ID:     5b14557b073c96a7cf79adc4d7b6c4a8c26b2a43
Gitweb:        https://git.kernel.org/tip/5b14557b073c96a7cf79adc4d7b6c4a8c26b2a43
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Tue, 26 Nov 2019 18:05:45 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Fri, 24 Jan 2020 10:27:33 -08:00

rcu: Avoid tick_dep_set_cpu() misordering

In the current code, rcu_nmi_enter_common() might decide to turn on
the tick using tick_dep_set_cpu(), but be delayed just before doing so.
Then the grace-period kthread might notice that the CPU in question had
in fact gone through a quiescent state, thus turning off the tick using
tick_dep_clear_cpu().  The later invocation of tick_dep_set_cpu() would
then incorrectly leave the tick on.

This commit therefore enlists the aid of the leaf rcu_node structure's
->lock to ensure that decisions to enable or disable the tick are
carried out before they can be reversed.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 5445da2..b0e0612 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -800,8 +800,8 @@ void rcu_user_exit(void)
  */
 static __always_inline void rcu_nmi_enter_common(bool irq)
 {
-	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
 	long incby = 2;
+	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
 
 	/* Complain about underflow. */
 	WARN_ON_ONCE(rdp->dynticks_nmi_nesting < 0);
@@ -828,8 +828,13 @@ static __always_inline void rcu_nmi_enter_common(bool irq)
 	} else if (tick_nohz_full_cpu(rdp->cpu) &&
 		   rdp->dynticks_nmi_nesting == DYNTICK_IRQ_NONIDLE &&
 		   READ_ONCE(rdp->rcu_urgent_qs) && !rdp->rcu_forced_tick) {
-		rdp->rcu_forced_tick = true;
-		tick_dep_set_cpu(rdp->cpu, TICK_DEP_BIT_RCU);
+		raw_spin_lock_rcu_node(rdp->mynode);
+		// Recheck under lock.
+		if (rdp->rcu_urgent_qs && !rdp->rcu_forced_tick) {
+			rdp->rcu_forced_tick = true;
+			tick_dep_set_cpu(rdp->cpu, TICK_DEP_BIT_RCU);
+		}
+		raw_spin_unlock_rcu_node(rdp->mynode);
 	}
 	trace_rcu_dyntick(incby == 1 ? TPS("Endirq") : TPS("++="),
 			  rdp->dynticks_nmi_nesting,
@@ -898,6 +903,7 @@ void rcu_irq_enter_irqson(void)
  */
 static void rcu_disable_urgency_upon_qs(struct rcu_data *rdp)
 {
+	raw_lockdep_assert_held_rcu_node(rdp->mynode);
 	WRITE_ONCE(rdp->rcu_urgent_qs, false);
 	WRITE_ONCE(rdp->rcu_need_heavy_qs, false);
 	if (tick_nohz_full_cpu(rdp->cpu) && rdp->rcu_forced_tick) {
