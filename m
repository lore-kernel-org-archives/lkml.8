Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E23E2C54E4B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 21:01:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA9C32078A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 21:01:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731872AbgEKVBO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 17:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732095AbgEKVAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 17:00:06 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D82EC061A0E;
        Mon, 11 May 2020 14:00:06 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jYFWo-0005wo-8H; Mon, 11 May 2020 22:59:58 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 1890B1C0868;
        Mon, 11 May 2020 22:59:39 +0200 (CEST)
Date:   Mon, 11 May 2020 20:59:39 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Add rcu_gp_might_be_stalled()
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158923077902.390.658670894294893905.tip-bot2@tip-bot2>
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

Commit-ID:     6be7436d2245d3dd8b9a8f949367c13841c23308
Gitweb:        https://git.kernel.org/tip/6be7436d2245d3dd8b9a8f949367c13841c23308
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Fri, 10 Apr 2020 13:47:41 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 27 Apr 2020 11:02:50 -07:00

rcu: Add rcu_gp_might_be_stalled()

This commit adds rcu_gp_might_be_stalled(), which returns true if there
is some reason to believe that the RCU grace period is stalled.  The use
case is where an RCU free-memory path needs to allocate memory in order
to free it, a situation that should be avoided where possible.

But where it is necessary, there is always the alternative of using
synchronize_rcu() to wait for a grace period in order to avoid the
allocation.  And if the grace period is stalled, allocating memory to
asynchronously wait for it is a bad idea of epic proportions: Far better
to let others use the memory, because these others might actually be
able to free that memory before the grace period ends.

Thus, rcu_gp_might_be_stalled() can be used to help decide whether
allocating memory on an RCU free path is a semi-reasonable course
of action.

Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Uladzislau Rezki <urezki@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/rcutiny.h |  1 +-
 include/linux/rcutree.h |  1 +-
 kernel/rcu/tree_stall.h | 40 ++++++++++++++++++++++++++++++++++++----
 3 files changed, 38 insertions(+), 4 deletions(-)

diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
index 045c28b..dbf5ac4 100644
--- a/include/linux/rcutiny.h
+++ b/include/linux/rcutiny.h
@@ -87,6 +87,7 @@ static inline bool rcu_inkernel_boot_has_ended(void) { return true; }
 static inline bool rcu_is_watching(void) { return true; }
 static inline void rcu_momentary_dyntick_idle(void) { }
 static inline void kfree_rcu_scheduler_running(void) { }
+static inline bool rcu_gp_might_be_stalled(void) { return false; }
 
 /* Avoid RCU read-side critical sections leaking across. */
 static inline void rcu_all_qs(void) { barrier(); }
diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
index 45f3f66..fbc2627 100644
--- a/include/linux/rcutree.h
+++ b/include/linux/rcutree.h
@@ -39,6 +39,7 @@ void rcu_barrier(void);
 bool rcu_eqs_special_set(int cpu);
 void rcu_momentary_dyntick_idle(void);
 void kfree_rcu_scheduler_running(void);
+bool rcu_gp_might_be_stalled(void);
 unsigned long get_state_synchronize_rcu(void);
 void cond_synchronize_rcu(unsigned long oldstate);
 
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 119ed6a..4dede00 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -15,10 +15,12 @@
 int sysctl_panic_on_rcu_stall __read_mostly;
 
 #ifdef CONFIG_PROVE_RCU
-#define RCU_STALL_DELAY_DELTA	       (5 * HZ)
+#define RCU_STALL_DELAY_DELTA		(5 * HZ)
 #else
-#define RCU_STALL_DELAY_DELTA	       0
+#define RCU_STALL_DELAY_DELTA		0
 #endif
+#define RCU_STALL_MIGHT_DIV		8
+#define RCU_STALL_MIGHT_MIN		(2 * HZ)
 
 /* Limit-check stall timeouts specified at boottime and runtime. */
 int rcu_jiffies_till_stall_check(void)
@@ -40,6 +42,36 @@ int rcu_jiffies_till_stall_check(void)
 }
 EXPORT_SYMBOL_GPL(rcu_jiffies_till_stall_check);
 
+/**
+ * rcu_gp_might_be_stalled - Is it likely that the grace period is stalled?
+ *
+ * Returns @true if the current grace period is sufficiently old that
+ * it is reasonable to assume that it might be stalled.  This can be
+ * useful when deciding whether to allocate memory to enable RCU-mediated
+ * freeing on the one hand or just invoking synchronize_rcu() on the other.
+ * The latter is preferable when the grace period is stalled.
+ *
+ * Note that sampling of the .gp_start and .gp_seq fields must be done
+ * carefully to avoid false positives at the beginnings and ends of
+ * grace periods.
+ */
+bool rcu_gp_might_be_stalled(void)
+{
+	unsigned long d = rcu_jiffies_till_stall_check() / RCU_STALL_MIGHT_DIV;
+	unsigned long j = jiffies;
+
+	if (d < RCU_STALL_MIGHT_MIN)
+		d = RCU_STALL_MIGHT_MIN;
+	smp_mb(); // jiffies before .gp_seq to avoid false positives.
+	if (!rcu_gp_in_progress())
+		return false;
+	// Long delays at this point avoids false positive, but a delay
+	// of ULONG_MAX/4 jiffies voids your no-false-positive warranty.
+	smp_mb(); // .gp_seq before second .gp_start
+	// And ditto here.
+	return !time_before(j, READ_ONCE(rcu_state.gp_start) + d);
+}
+
 /* Don't do RCU CPU stall warnings during long sysrq printouts. */
 void rcu_sysrq_start(void)
 {
@@ -104,8 +136,8 @@ static void record_gp_stall_check_time(void)
 
 	WRITE_ONCE(rcu_state.gp_start, j);
 	j1 = rcu_jiffies_till_stall_check();
-	/* Record ->gp_start before ->jiffies_stall. */
-	smp_store_release(&rcu_state.jiffies_stall, j + j1); /* ^^^ */
+	smp_mb(); // ->gp_start before ->jiffies_stall and caller's ->gp_seq.
+	WRITE_ONCE(rcu_state.jiffies_stall, j + j1);
 	rcu_state.jiffies_resched = j + j1 / 2;
 	rcu_state.n_force_qs_gpstart = READ_ONCE(rcu_state.n_force_qs);
 }
