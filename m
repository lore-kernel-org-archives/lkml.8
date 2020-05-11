Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 174BBC47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 20:59:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF2622075E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 20:59:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731863AbgEKU73 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 16:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729215AbgEKU70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 16:59:26 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CB8AC061A0C;
        Mon, 11 May 2020 13:59:26 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jYFWG-0005gh-2l; Mon, 11 May 2020 22:59:24 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id B7D7F1C04D6;
        Mon, 11 May 2020 22:59:18 +0200 (CEST)
Date:   Mon, 11 May 2020 20:59:18 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcutorture: Add flag to produce non-busy-wait task stalls
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158923075865.390.790138197664975556.tip-bot2@tip-bot2>
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

Commit-ID:     19a8ff956c5abaaedfae23b8a951dd2d725a2171
Gitweb:        https://git.kernel.org/tip/19a8ff956c5abaaedfae23b8a951dd2d725a2171
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Wed, 11 Mar 2020 17:39:12 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Thu, 07 May 2020 10:15:28 -07:00

rcutorture: Add flag to produce non-busy-wait task stalls

This commit aids testing of RCU task stall warning messages by adding
an rcutorture.stall_cpu_block module parameter that results in the
induced stall sleeping within the RCU read-side critical section.
Spinning with interrupts disabled is still available via the
rcutorture.stall_cpu_irqsoff module parameter, and specifying neither
of these two module parameters will spin with preemption disabled.

Note that sleeping (as opposed to preemption) results in additional
complaints from RCU at context-switch time, so yet more testing.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt |  5 +++++-
 kernel/rcu/rcutorture.c                         | 17 ++++++++++------
 2 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index f2a93c8..ad12b39 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4210,6 +4210,11 @@
 			Duration of CPU stall (s) to test RCU CPU stall
 			warnings, zero to disable.
 
+	rcutorture.stall_cpu_block= [KNL]
+			Sleep while stalling if set.  This will result
+			in warnings from preemptible RCU in addition
+			to any other stall-related activity.
+
 	rcutorture.stall_cpu_holdoff= [KNL]
 			Time to wait (s) after boot before inducing stall.
 
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index d0345d1..60dc368 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -114,6 +114,7 @@ torture_param(int, stall_cpu, 0, "Stall duration (s), zero to disable.");
 torture_param(int, stall_cpu_holdoff, 10,
 	     "Time to wait before starting stall (s).");
 torture_param(int, stall_cpu_irqsoff, 0, "Disable interrupts while stalling.");
+torture_param(int, stall_cpu_block, 0, "Sleep while stalling.");
 torture_param(int, stat_interval, 60,
 	     "Number of seconds between stats printk()s");
 torture_param(int, stutter, 5, "Number of seconds to run/halt test");
@@ -1548,6 +1549,7 @@ rcu_torture_print_module_parms(struct rcu_torture_ops *cur_ops, const char *tag)
 		 "test_boost=%d/%d test_boost_interval=%d "
 		 "test_boost_duration=%d shutdown_secs=%d "
 		 "stall_cpu=%d stall_cpu_holdoff=%d stall_cpu_irqsoff=%d "
+		 "stall_cpu_block=%d "
 		 "n_barrier_cbs=%d "
 		 "onoff_interval=%d onoff_holdoff=%d\n",
 		 torture_type, tag, nrealreaders, nfakewriters,
@@ -1556,6 +1558,7 @@ rcu_torture_print_module_parms(struct rcu_torture_ops *cur_ops, const char *tag)
 		 test_boost, cur_ops->can_boost,
 		 test_boost_interval, test_boost_duration, shutdown_secs,
 		 stall_cpu, stall_cpu_holdoff, stall_cpu_irqsoff,
+		 stall_cpu_block,
 		 n_barrier_cbs,
 		 onoff_interval, onoff_holdoff);
 }
@@ -1611,6 +1614,7 @@ static int rcutorture_booster_init(unsigned int cpu)
  */
 static int rcu_torture_stall(void *args)
 {
+	int idx;
 	unsigned long stop_at;
 
 	VERBOSE_TOROUT_STRING("rcu_torture_stall task started");
@@ -1622,21 +1626,22 @@ static int rcu_torture_stall(void *args)
 	if (!kthread_should_stop()) {
 		stop_at = ktime_get_seconds() + stall_cpu;
 		/* RCU CPU stall is expected behavior in following code. */
-		rcu_read_lock();
+		idx = cur_ops->readlock();
 		if (stall_cpu_irqsoff)
 			local_irq_disable();
-		else
+		else if (!stall_cpu_block)
 			preempt_disable();
 		pr_alert("rcu_torture_stall start on CPU %d.\n",
-			 smp_processor_id());
+			 raw_smp_processor_id());
 		while (ULONG_CMP_LT((unsigned long)ktime_get_seconds(),
 				    stop_at))
-			continue;  /* Induce RCU CPU stall warning. */
+			if (stall_cpu_block)
+				schedule_timeout_uninterruptible(HZ);
 		if (stall_cpu_irqsoff)
 			local_irq_enable();
-		else
+		else if (!stall_cpu_block)
 			preempt_enable();
-		rcu_read_unlock();
+		cur_ops->readunlock(idx);
 		pr_alert("rcu_torture_stall end.\n");
 	}
 	torture_shutdown_absorb("rcu_torture_stall");
