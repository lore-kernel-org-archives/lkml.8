Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13E65C54E4B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 20:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E67EB24967
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 20:59:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731903AbgEKU7g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 16:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731824AbgEKU7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 16:59:25 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41819C061A0C;
        Mon, 11 May 2020 13:59:25 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jYFWF-0005gP-BY; Mon, 11 May 2020 22:59:23 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id F24131C001F;
        Mon, 11 May 2020 22:59:17 +0200 (CEST)
Date:   Mon, 11 May 2020 20:59:17 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Allow rcutorture to starve grace-period kthread
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158923075792.390.12819592949525581517.tip-bot2@tip-bot2>
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

Commit-ID:     55b2dcf58700041d6f0b037a98619222c825f004
Gitweb:        https://git.kernel.org/tip/55b2dcf58700041d6f0b037a98619222c825f004
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Wed, 01 Apr 2020 19:57:52 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Thu, 07 May 2020 10:15:28 -07:00

rcu: Allow rcutorture to starve grace-period kthread

This commit provides an rcutorture.stall_gp_kthread module parameter
to allow rcutorture to starve the grace-period kthread.  This allows
testing the code that detects such starvation.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt |  7 ++++-
 kernel/rcu/rcu.h                                |  2 +-
 kernel/rcu/rcutorture.c                         | 18 +++++++++--
 kernel/rcu/tree.c                               | 27 ++++++++++++++++-
 4 files changed, 51 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index ad12b39..be94358 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4221,6 +4221,13 @@
 	rcutorture.stall_cpu_irqsoff= [KNL]
 			Disable interrupts while stalling if set.
 
+	rcutorture.stall_gp_kthread= [KNL]
+			Duration (s) of forced sleep within RCU
+			grace-period kthread to test RCU CPU stall
+			warnings, zero to disable.  If both stall_cpu
+			and stall_gp_kthread are specified, the
+			kthread is starved first, then the CPU.
+
 	rcutorture.stat_interval= [KNL]
 			Time (s) between statistics printk()s.
 
diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index 00ddc92..cdbc5f9 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -454,6 +454,7 @@ void do_trace_rcu_torture_read(const char *rcutorturename,
 			       unsigned long secs,
 			       unsigned long c_old,
 			       unsigned long c);
+void rcu_gp_set_torture_wait(int duration);
 #else
 static inline void rcutorture_get_gp_data(enum rcutorture_type test_type,
 					  int *flags, unsigned long *gp_seq)
@@ -471,6 +472,7 @@ void do_trace_rcu_torture_read(const char *rcutorturename,
 #define do_trace_rcu_torture_read(rcutorturename, rhp, secs, c_old, c) \
 	do { } while (0)
 #endif
+static inline void rcu_gp_set_torture_wait(int duration) { }
 #endif
 
 #if IS_ENABLED(CONFIG_RCU_TORTURE_TEST) || IS_MODULE(CONFIG_RCU_TORTURE_TEST)
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 60dc368..3d47dca 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -115,6 +115,8 @@ torture_param(int, stall_cpu_holdoff, 10,
 	     "Time to wait before starting stall (s).");
 torture_param(int, stall_cpu_irqsoff, 0, "Disable interrupts while stalling.");
 torture_param(int, stall_cpu_block, 0, "Sleep while stalling.");
+torture_param(int, stall_gp_kthread, 0,
+	      "Grace-period kthread stall duration (s).");
 torture_param(int, stat_interval, 60,
 	     "Number of seconds between stats printk()s");
 torture_param(int, stutter, 5, "Number of seconds to run/halt test");
@@ -1623,7 +1625,17 @@ static int rcu_torture_stall(void *args)
 		schedule_timeout_interruptible(stall_cpu_holdoff * HZ);
 		VERBOSE_TOROUT_STRING("rcu_torture_stall end holdoff");
 	}
-	if (!kthread_should_stop()) {
+	if (!kthread_should_stop() && stall_gp_kthread > 0) {
+		VERBOSE_TOROUT_STRING("rcu_torture_stall begin GP stall");
+		rcu_gp_set_torture_wait(stall_gp_kthread * HZ);
+		for (idx = 0; idx < stall_gp_kthread + 2; idx++) {
+			if (kthread_should_stop())
+				break;
+			schedule_timeout_uninterruptible(HZ);
+		}
+	}
+	if (!kthread_should_stop() && stall_cpu > 0) {
+		VERBOSE_TOROUT_STRING("rcu_torture_stall begin CPU stall");
 		stop_at = ktime_get_seconds() + stall_cpu;
 		/* RCU CPU stall is expected behavior in following code. */
 		idx = cur_ops->readlock();
@@ -1642,8 +1654,8 @@ static int rcu_torture_stall(void *args)
 		else if (!stall_cpu_block)
 			preempt_enable();
 		cur_ops->readunlock(idx);
-		pr_alert("rcu_torture_stall end.\n");
 	}
+	pr_alert("rcu_torture_stall end.\n");
 	torture_shutdown_absorb("rcu_torture_stall");
 	while (!kthread_should_stop())
 		schedule_timeout_interruptible(10 * HZ);
@@ -1653,7 +1665,7 @@ static int rcu_torture_stall(void *args)
 /* Spawn CPU-stall kthread, if stall_cpu specified. */
 static int __init rcu_torture_stall_init(void)
 {
-	if (stall_cpu <= 0)
+	if (stall_cpu <= 0 && stall_gp_kthread <= 0)
 		return 0;
 	return torture_create_kthread(rcu_torture_stall, NULL, stall_task);
 }
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 156ac8d..be7dde8 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1486,6 +1486,31 @@ static void rcu_gp_slow(int delay)
 		schedule_timeout_uninterruptible(delay);
 }
 
+static unsigned long sleep_duration;
+
+/* Allow rcutorture to stall the grace-period kthread. */
+void rcu_gp_set_torture_wait(int duration)
+{
+	if (IS_ENABLED(CONFIG_RCU_TORTURE_TEST) && duration > 0)
+		WRITE_ONCE(sleep_duration, duration);
+}
+EXPORT_SYMBOL_GPL(rcu_gp_set_torture_wait);
+
+/* Actually implement the aforementioned wait. */
+static void rcu_gp_torture_wait(void)
+{
+	unsigned long duration;
+
+	if (!IS_ENABLED(CONFIG_RCU_TORTURE_TEST))
+		return;
+	duration = xchg(&sleep_duration, 0UL);
+	if (duration > 0) {
+		pr_alert("%s: Waiting %lu jiffies\n", __func__, duration);
+		schedule_timeout_uninterruptible(duration);
+		pr_alert("%s: Wait complete\n", __func__);
+	}
+}
+
 /*
  * Initialize a new grace period.  Return false if no grace period required.
  */
@@ -1686,6 +1711,7 @@ static void rcu_gp_fqs_loop(void)
 		rcu_state.gp_state = RCU_GP_WAIT_FQS;
 		ret = swait_event_idle_timeout_exclusive(
 				rcu_state.gp_wq, rcu_gp_fqs_check_wake(&gf), j);
+		rcu_gp_torture_wait();
 		rcu_state.gp_state = RCU_GP_DOING_FQS;
 		/* Locking provides needed memory barriers. */
 		/* If grace period done, leave loop. */
@@ -1834,6 +1860,7 @@ static int __noreturn rcu_gp_kthread(void *unused)
 			swait_event_idle_exclusive(rcu_state.gp_wq,
 					 READ_ONCE(rcu_state.gp_flags) &
 					 RCU_GP_FLAG_INIT);
+			rcu_gp_torture_wait();
 			rcu_state.gp_state = RCU_GP_DONE_GPS;
 			/* Locking provides needed memory barrier. */
 			if (rcu_gp_init())
