Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDB70C4332B
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 09:16:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA76021707
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 09:16:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727621AbgCXJQx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 05:16:53 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43962 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727527AbgCXJQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 05:16:47 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jGffv-00081F-GW; Tue, 24 Mar 2020 10:16:43 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id CF0741C04CC;
        Tue, 24 Mar 2020 10:16:37 +0100 (CET)
Date:   Tue, 24 Mar 2020 09:16:37 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcutorture: Suppress forward-progress complaints
 during early boot
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Borislav Petkov <bp@alien8.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158504139747.28353.15332194037888557917.tip-bot2@tip-bot2>
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

Commit-ID:     59ee0326ccf712f9a637d5df2465a16a784cbfb0
Gitweb:        https://git.kernel.org/tip/59ee0326ccf712f9a637d5df2465a16a784cbfb0
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Thu, 28 Nov 2019 18:54:06 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Thu, 20 Feb 2020 16:03:30 -08:00

rcutorture: Suppress forward-progress complaints during early boot

Some larger systems can take in excess of 50 seconds to complete their
early boot initcalls prior to spawing init.  This does not in any way
help the forward-progress judgments of built-in rcutorture (when
rcutorture is built as a module, the insmod or modprobe command normally
cannot happen until some time after boot completes).  This commit
therefore suppresses such complaints until about the time that init
is spawned.

This also includes a fix to a stupid error located by kbuild test robot.

[ paulmck: Apply kbuild test robot feedback. ]
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
[ paulmck: Fix to nohz_full slow-expediting recovery logic, per bpetkov. ]
[ paulmck: Restrict splat to CONFIG_PREEMPT_RT=y kernels and simplify. ]
Tested-by: Borislav Petkov <bp@alien8.de>
---
 include/linux/rcutiny.h |  1 +
 include/linux/rcutree.h |  1 +
 kernel/rcu/rcutorture.c |  3 ++-
 kernel/rcu/tree_exp.h   |  7 ++++++-
 kernel/rcu/update.c     | 12 ++++++++++++
 5 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
index b2b2dc9..045c28b 100644
--- a/include/linux/rcutiny.h
+++ b/include/linux/rcutiny.h
@@ -83,6 +83,7 @@ void rcu_scheduler_starting(void);
 static inline void rcu_scheduler_starting(void) { }
 #endif /* #else #ifndef CONFIG_SRCU */
 static inline void rcu_end_inkernel_boot(void) { }
+static inline bool rcu_inkernel_boot_has_ended(void) { return true; }
 static inline bool rcu_is_watching(void) { return true; }
 static inline void rcu_momentary_dyntick_idle(void) { }
 static inline void kfree_rcu_scheduler_running(void) { }
diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
index 2f787b9..45f3f66 100644
--- a/include/linux/rcutree.h
+++ b/include/linux/rcutree.h
@@ -54,6 +54,7 @@ void exit_rcu(void);
 void rcu_scheduler_starting(void);
 extern int rcu_scheduler_active __read_mostly;
 void rcu_end_inkernel_boot(void);
+bool rcu_inkernel_boot_has_ended(void);
 bool rcu_is_watching(void);
 #ifndef CONFIG_PREEMPTION
 void rcu_all_qs(void);
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 1aeecc1..9ba4978 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1067,7 +1067,8 @@ rcu_torture_writer(void *arg)
 		if (stutter_wait("rcu_torture_writer") &&
 		    !READ_ONCE(rcu_fwd_cb_nodelay) &&
 		    !cur_ops->slow_gps &&
-		    !torture_must_stop())
+		    !torture_must_stop() &&
+		    rcu_inkernel_boot_has_ended())
 			for (i = 0; i < ARRAY_SIZE(rcu_tortures); i++)
 				if (list_empty(&rcu_tortures[i].rtort_free) &&
 				    rcu_access_pointer(rcu_torture_current) !=
diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index dcbd757..a72d16e 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -485,6 +485,7 @@ static bool synchronize_rcu_expedited_wait_once(long tlimit)
 static void synchronize_rcu_expedited_wait(void)
 {
 	int cpu;
+	unsigned long j;
 	unsigned long jiffies_stall;
 	unsigned long jiffies_start;
 	unsigned long mask;
@@ -496,7 +497,7 @@ static void synchronize_rcu_expedited_wait(void)
 	trace_rcu_exp_grace_period(rcu_state.name, rcu_exp_gp_seq_endval(), TPS("startwait"));
 	jiffies_stall = rcu_jiffies_till_stall_check();
 	jiffies_start = jiffies;
-	if (IS_ENABLED(CONFIG_NO_HZ_FULL)) {
+	if (tick_nohz_full_enabled() && rcu_inkernel_boot_has_ended()) {
 		if (synchronize_rcu_expedited_wait_once(1))
 			return;
 		rcu_for_each_leaf_node(rnp) {
@@ -508,6 +509,10 @@ static void synchronize_rcu_expedited_wait(void)
 				tick_dep_set_cpu(cpu, TICK_DEP_BIT_RCU_EXP);
 			}
 		}
+		j = READ_ONCE(jiffies_till_first_fqs);
+		if (synchronize_rcu_expedited_wait_once(j + HZ))
+			return;
+		WARN_ON_ONCE(IS_ENABLED(CONFIG_PREEMPT_RT));
 	}
 
 	for (;;) {
diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index 6c4b862..feaaec5 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -183,6 +183,8 @@ void rcu_unexpedite_gp(void)
 }
 EXPORT_SYMBOL_GPL(rcu_unexpedite_gp);
 
+static bool rcu_boot_ended __read_mostly;
+
 /*
  * Inform RCU of the end of the in-kernel boot sequence.
  */
@@ -191,7 +193,17 @@ void rcu_end_inkernel_boot(void)
 	rcu_unexpedite_gp();
 	if (rcu_normal_after_boot)
 		WRITE_ONCE(rcu_normal, 1);
+	rcu_boot_ended = 1;
+}
+
+/*
+ * Let rcutorture know when it is OK to turn it up to eleven.
+ */
+bool rcu_inkernel_boot_has_ended(void)
+{
+	return rcu_boot_ended;
 }
+EXPORT_SYMBOL_GPL(rcu_inkernel_boot_has_ended);
 
 #endif /* #ifndef CONFIG_TINY_RCU */
 
