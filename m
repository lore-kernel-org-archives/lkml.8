Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 972F8C47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 20:59:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D114208D5
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 20:59:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732018AbgEKU7x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 16:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731912AbgEKU7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 16:59:37 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53247C061A0C;
        Mon, 11 May 2020 13:59:37 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jYFWR-0005os-Ot; Mon, 11 May 2020 22:59:35 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 94A661C04E3;
        Mon, 11 May 2020 22:59:28 +0200 (CEST)
Date:   Mon, 11 May 2020 20:59:28 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu-tasks: Make rcutorture writer stall output
 include GP state
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158923076854.390.5067248714147992049.tip-bot2@tip-bot2>
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

Commit-ID:     af051ca4e4231fcf5f366e28453ac28208bb36c6
Gitweb:        https://git.kernel.org/tip/af051ca4e4231fcf5f366e28453ac28208bb36c6
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Mon, 16 Mar 2020 12:13:33 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 27 Apr 2020 11:03:52 -07:00

rcu-tasks: Make rcutorture writer stall output include GP state

This commit adds grace-period state and time to the rcutorture writer
stall output.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tasks.h | 77 ++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 72 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index e4f8942..c93fb29 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -17,7 +17,7 @@ typedef void (*pregp_func_t)(void);
 typedef void (*pertask_func_t)(struct task_struct *t, struct list_head *hop);
 typedef void (*postscan_func_t)(void);
 typedef void (*holdouts_func_t)(struct list_head *hop, bool ndrpt, bool *frptp);
-typedef void (*postgp_func_t)(void);
+typedef void (*postgp_func_t)(struct rcu_tasks *rtp);
 
 /**
  * Definition for a Tasks-RCU-like mechanism.
@@ -27,6 +27,9 @@ typedef void (*postgp_func_t)(void);
  * @cbs_lock: Lock protecting callback list.
  * @kthread_ptr: This flavor's grace-period/callback-invocation kthread.
  * @gp_func: This flavor's grace-period-wait function.
+ * @gp_state: Grace period's most recent state transition (debugging).
+ * @gp_jiffies: Time of last @gp_state transition.
+ * @gp_start: Most recent grace-period start in jiffies.
  * @pregp_func: This flavor's pre-grace-period function (optional).
  * @pertask_func: This flavor's per-task scan function (optional).
  * @postscan_func: This flavor's post-task scan function (optional).
@@ -41,6 +44,8 @@ struct rcu_tasks {
 	struct rcu_head **cbs_tail;
 	struct wait_queue_head cbs_wq;
 	raw_spinlock_t cbs_lock;
+	int gp_state;
+	unsigned long gp_jiffies;
 	struct task_struct *kthread_ptr;
 	rcu_tasks_gp_func_t gp_func;
 	pregp_func_t pregp_func;
@@ -73,10 +78,56 @@ DEFINE_STATIC_SRCU(tasks_rcu_exit_srcu);
 static int rcu_task_stall_timeout __read_mostly = RCU_TASK_STALL_TIMEOUT;
 module_param(rcu_task_stall_timeout, int, 0644);
 
+/* RCU tasks grace-period state for debugging. */
+#define RTGS_INIT		 0
+#define RTGS_WAIT_WAIT_CBS	 1
+#define RTGS_WAIT_GP		 2
+#define RTGS_PRE_WAIT_GP	 3
+#define RTGS_SCAN_TASKLIST	 4
+#define RTGS_POST_SCAN_TASKLIST	 5
+#define RTGS_WAIT_SCAN_HOLDOUTS	 6
+#define RTGS_SCAN_HOLDOUTS	 7
+#define RTGS_POST_GP		 8
+#define RTGS_WAIT_READERS	 9
+#define RTGS_INVOKE_CBS		10
+#define RTGS_WAIT_CBS		11
+static const char * const rcu_tasks_gp_state_names[] = {
+	"RTGS_INIT",
+	"RTGS_WAIT_WAIT_CBS",
+	"RTGS_WAIT_GP",
+	"RTGS_PRE_WAIT_GP",
+	"RTGS_SCAN_TASKLIST",
+	"RTGS_POST_SCAN_TASKLIST",
+	"RTGS_WAIT_SCAN_HOLDOUTS",
+	"RTGS_SCAN_HOLDOUTS",
+	"RTGS_POST_GP",
+	"RTGS_WAIT_READERS",
+	"RTGS_INVOKE_CBS",
+	"RTGS_WAIT_CBS",
+};
+
 ////////////////////////////////////////////////////////////////////////
 //
 // Generic code.
 
+/* Record grace-period phase and time. */
+static void set_tasks_gp_state(struct rcu_tasks *rtp, int newstate)
+{
+	rtp->gp_state = newstate;
+	rtp->gp_jiffies = jiffies;
+}
+
+/* Return state name. */
+static const char *tasks_gp_state_getname(struct rcu_tasks *rtp)
+{
+	int i = data_race(rtp->gp_state); // Let KCSAN detect update races
+	int j = READ_ONCE(i); // Prevent the compiler from reading twice
+
+	if (j >= ARRAY_SIZE(rcu_tasks_gp_state_names))
+		return "???";
+	return rcu_tasks_gp_state_names[j];
+}
+
 // Enqueue a callback for the specified flavor of Tasks RCU.
 static void call_rcu_tasks_generic(struct rcu_head *rhp, rcu_callback_t func,
 				   struct rcu_tasks *rtp)
@@ -141,15 +192,18 @@ static int __noreturn rcu_tasks_kthread(void *arg)
 						 READ_ONCE(rtp->cbs_head));
 			if (!rtp->cbs_head) {
 				WARN_ON(signal_pending(current));
+				set_tasks_gp_state(rtp, RTGS_WAIT_WAIT_CBS);
 				schedule_timeout_interruptible(HZ/10);
 			}
 			continue;
 		}
 
 		// Wait for one grace period.
+		set_tasks_gp_state(rtp, RTGS_WAIT_GP);
 		rtp->gp_func(rtp);
 
 		/* Invoke the callbacks. */
+		set_tasks_gp_state(rtp, RTGS_INVOKE_CBS);
 		while (list) {
 			next = list->next;
 			local_bh_disable();
@@ -160,6 +214,8 @@ static int __noreturn rcu_tasks_kthread(void *arg)
 		}
 		/* Paranoid sleep to keep this from entering a tight loop */
 		schedule_timeout_uninterruptible(HZ/10);
+
+		set_tasks_gp_state(rtp, RTGS_WAIT_CBS);
 	}
 }
 
@@ -222,8 +278,11 @@ static void __init rcu_tasks_bootup_oddness(void)
 /* Dump out rcutorture-relevant state common to all RCU-tasks flavors. */
 static void show_rcu_tasks_generic_gp_kthread(struct rcu_tasks *rtp, char *s)
 {
-	pr_info("%s %c%c %s\n",
+	pr_info("%s: %s(%d) since %lu %c%c %s\n",
 		rtp->kname,
+		tasks_gp_state_getname(rtp),
+		data_race(rtp->gp_state),
+		jiffies - data_race(rtp->gp_jiffies),
 		".k"[!!data_race(rtp->kthread_ptr)],
 		".C"[!!data_race(rtp->cbs_head)],
 		s);
@@ -243,6 +302,7 @@ static void rcu_tasks_wait_gp(struct rcu_tasks *rtp)
 	LIST_HEAD(holdouts);
 	int fract;
 
+	set_tasks_gp_state(rtp, RTGS_PRE_WAIT_GP);
 	rtp->pregp_func();
 
 	/*
@@ -251,11 +311,13 @@ static void rcu_tasks_wait_gp(struct rcu_tasks *rtp)
 	 * that are not already voluntarily blocked.  Mark these tasks
 	 * and make a list of them in holdouts.
 	 */
+	set_tasks_gp_state(rtp, RTGS_SCAN_TASKLIST);
 	rcu_read_lock();
 	for_each_process_thread(g, t)
 		rtp->pertask_func(t, &holdouts);
 	rcu_read_unlock();
 
+	set_tasks_gp_state(rtp, RTGS_POST_SCAN_TASKLIST);
 	rtp->postscan_func();
 
 	/*
@@ -277,6 +339,7 @@ static void rcu_tasks_wait_gp(struct rcu_tasks *rtp)
 			break;
 
 		/* Slowly back off waiting for holdouts */
+		set_tasks_gp_state(rtp, RTGS_WAIT_SCAN_HOLDOUTS);
 		schedule_timeout_interruptible(HZ/fract);
 
 		if (fract > 1)
@@ -288,10 +351,12 @@ static void rcu_tasks_wait_gp(struct rcu_tasks *rtp)
 			lastreport = jiffies;
 		firstreport = true;
 		WARN_ON(signal_pending(current));
+		set_tasks_gp_state(rtp, RTGS_SCAN_HOLDOUTS);
 		rtp->holdouts_func(&holdouts, needreport, &firstreport);
 	}
 
-	rtp->postgp_func();
+	set_tasks_gp_state(rtp, RTGS_POST_GP);
+	rtp->postgp_func(rtp);
 }
 
 ////////////////////////////////////////////////////////////////////////
@@ -394,7 +459,7 @@ static void check_all_holdout_tasks(struct list_head *hop,
 }
 
 /* Finish off the Tasks-RCU grace period. */
-static void rcu_tasks_postgp(void)
+static void rcu_tasks_postgp(struct rcu_tasks *rtp)
 {
 	/*
 	 * Because ->on_rq and ->nvcsw are not guaranteed to have a full
@@ -881,7 +946,7 @@ static void check_all_holdout_tasks_trace(struct list_head *hop,
 }
 
 /* Wait for grace period to complete and provide ordering. */
-static void rcu_tasks_trace_postgp(void)
+static void rcu_tasks_trace_postgp(struct rcu_tasks *rtp)
 {
 	bool firstreport;
 	struct task_struct *g, *t;
@@ -894,6 +959,7 @@ static void rcu_tasks_trace_postgp(void)
 	smp_mb__after_atomic();  // Order vs. later atomics
 
 	// Wait for readers.
+	set_tasks_gp_state(rtp, RTGS_WAIT_READERS);
 	for (;;) {
 		ret = wait_event_idle_exclusive_timeout(
 				trc_wait,
@@ -901,6 +967,7 @@ static void rcu_tasks_trace_postgp(void)
 				READ_ONCE(rcu_task_stall_timeout));
 		if (ret)
 			break;  // Count reached zero.
+		// Stall warning time, so make a list of the offenders.
 		for_each_process_thread(g, t)
 			if (READ_ONCE(t->trc_reader_need_end))
 				trc_add_holdout(t, &holdouts);
