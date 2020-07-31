Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CDDBC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61A9E22B40
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:27:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CjskdNfA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gfCvgNHP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732331AbgGaJXD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 05:23:03 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56350 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732211AbgGaJWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 05:22:50 -0400
Date:   Fri, 31 Jul 2020 09:22:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596187368;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=ue54eTL1R4eGegowg8WfgNypXo1HAgsyxCEY+iDP2HI=;
        b=CjskdNfAVHpDoqUn+QbEfpDjoSv8lKsBiPGMkbvUx/UpNs5BWW7Uk9EGwbHJeHGuP7Y7ac
        cQMK8PRcGMvHuWWNyOVyxrZWjwdd8v5MzzbDKcRXByYTkzzoOssKQ7SOzXm8plZlctfEhL
        TT8p+lWiGbFAVlmNuQx5utnV1yn5iFthHFs4/2NDXAac/xYNAuALKzCO/mUYn8eN11fccB
        PXu8U7HOgMjg5DC8cd8dfbI8qCwEGd/4IuH8ABaZgZTIKT9gHU1I9btAjEcJvYMTiI1uF5
        L0CBix+xkWYyB+rW7ZTxrjtDGEHS7t4GzjX3Y9J3p8vFE95vR2LYBloZdU2hiA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596187368;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=ue54eTL1R4eGegowg8WfgNypXo1HAgsyxCEY+iDP2HI=;
        b=gfCvgNHPloP++vZDbAqq0qo7UH/GWwL7+GXdWWp1JJezTZXTPW3fKaWQWovf+78eUPNZur
        h8j4rW4pcWS9FAAA==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcutorture: Add races with task-exit processing
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159618736734.4006.626525149957225271.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     4a5f133c15b77c4018e8d7996541868ac94afb4f
Gitweb:        https://git.kernel.org/tip/4a5f133c15b77c4018e8d7996541868ac94afb4f
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Fri, 24 Apr 2020 11:21:40 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 29 Jun 2020 12:01:44 -07:00

rcutorture: Add races with task-exit processing

Several variants of Linux-kernel RCU interact with task-exit processing,
including preemptible RCU, Tasks RCU, and Tasks Trace RCU.  This commit
therefore adds testing of this interaction to rcutorture by adding
rcutorture.read_exit_burst and rcutorture.read_exit_delay kernel-boot
parameters.  These kernel parameters control the frequency and spacing
of special read-then-exit kthreads that are spawned.

[ paulmck: Apply feedback from Dan Carpenter's static checker. ]
[ paulmck: Reduce latency to avoid false-positive shutdown hangs. ]
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt |  14 ++-
 include/linux/torture.h                         |   5 +-
 kernel/rcu/rcutorture.c                         | 112 ++++++++++++++-
 3 files changed, 128 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index fb95fad..a0dcc92 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4258,6 +4258,20 @@
 			Set time (jiffies) between CPU-hotplug operations,
 			or zero to disable CPU-hotplug testing.
 
+	rcutorture.read_exit= [KNL]
+			Set the number of read-then-exit kthreads used
+			to test the interaction of RCU updaters and
+			task-exit processing.
+
+	rcutorture.read_exit_burst= [KNL]
+			The number of times in a given read-then-exit
+			episode that a set of read-then-exit kthreads
+			is spawned.
+
+	rcutorture.read_exit_delay= [KNL]
+			The delay, in seconds, between successive
+			read-then-exit testing episodes.
+
 	rcutorture.shuffle_interval= [KNL]
 			Set task-shuffle interval (s).  Shuffling tasks
 			allows some CPUs to go into dyntick-idle mode
diff --git a/include/linux/torture.h b/include/linux/torture.h
index 629b66e..7f65bd1 100644
--- a/include/linux/torture.h
+++ b/include/linux/torture.h
@@ -55,6 +55,11 @@ struct torture_random_state {
 #define DEFINE_TORTURE_RANDOM_PERCPU(name) \
 	DEFINE_PER_CPU(struct torture_random_state, name)
 unsigned long torture_random(struct torture_random_state *trsp);
+static inline void torture_random_init(struct torture_random_state *trsp)
+{
+	trsp->trs_state = 0;
+	trsp->trs_count = 0;
+}
 
 /* Task shuffler, which causes CPUs to occasionally go idle. */
 void torture_shuffle_task_register(struct task_struct *tp);
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index efb792e..2621a33 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -109,6 +109,10 @@ torture_param(int, object_debug, 0,
 torture_param(int, onoff_holdoff, 0, "Time after boot before CPU hotplugs (s)");
 torture_param(int, onoff_interval, 0,
 	     "Time between CPU hotplugs (jiffies), 0=disable");
+torture_param(int, read_exit_delay, 13,
+	      "Delay between read-then-exit episodes (s)");
+torture_param(int, read_exit_burst, 16,
+	      "# of read-then-exit bursts per episode, zero to disable");
 torture_param(int, shuffle_interval, 3, "Number of seconds between shuffles");
 torture_param(int, shutdown_secs, 0, "Shutdown time (s), <= zero to disable.");
 torture_param(int, stall_cpu, 0, "Stall duration (s), zero to disable.");
@@ -146,6 +150,7 @@ static struct task_struct *stall_task;
 static struct task_struct *fwd_prog_task;
 static struct task_struct **barrier_cbs_tasks;
 static struct task_struct *barrier_task;
+static struct task_struct *read_exit_task;
 
 #define RCU_TORTURE_PIPE_LEN 10
 
@@ -177,6 +182,7 @@ static long n_rcu_torture_boosts;
 static atomic_long_t n_rcu_torture_timers;
 static long n_barrier_attempts;
 static long n_barrier_successes; /* did rcu_barrier test succeed? */
+static unsigned long n_read_exits;
 static struct list_head rcu_torture_removed;
 static unsigned long shutdown_jiffies;
 
@@ -1539,10 +1545,11 @@ rcu_torture_stats_print(void)
 		n_rcu_torture_boosts,
 		atomic_long_read(&n_rcu_torture_timers));
 	torture_onoff_stats();
-	pr_cont("barrier: %ld/%ld:%ld\n",
+	pr_cont("barrier: %ld/%ld:%ld ",
 		data_race(n_barrier_successes),
 		data_race(n_barrier_attempts),
 		data_race(n_rcu_torture_barrier_error));
+	pr_cont("read-exits: %ld\n", data_race(n_read_exits));
 
 	pr_alert("%s%s ", torture_type, TORTURE_FLAG);
 	if (atomic_read(&n_rcu_torture_mberror) ||
@@ -1634,7 +1641,8 @@ rcu_torture_print_module_parms(struct rcu_torture_ops *cur_ops, const char *tag)
 		 "stall_cpu=%d stall_cpu_holdoff=%d stall_cpu_irqsoff=%d "
 		 "stall_cpu_block=%d "
 		 "n_barrier_cbs=%d "
-		 "onoff_interval=%d onoff_holdoff=%d\n",
+		 "onoff_interval=%d onoff_holdoff=%d "
+		 "read_exit_delay=%d read_exit_burst=%d\n",
 		 torture_type, tag, nrealreaders, nfakewriters,
 		 stat_interval, verbose, test_no_idle_hz, shuffle_interval,
 		 stutter, irqreader, fqs_duration, fqs_holdoff, fqs_stutter,
@@ -1643,7 +1651,8 @@ rcu_torture_print_module_parms(struct rcu_torture_ops *cur_ops, const char *tag)
 		 stall_cpu, stall_cpu_holdoff, stall_cpu_irqsoff,
 		 stall_cpu_block,
 		 n_barrier_cbs,
-		 onoff_interval, onoff_holdoff);
+		 onoff_interval, onoff_holdoff,
+		 read_exit_delay, read_exit_burst);
 }
 
 static int rcutorture_booster_cleanup(unsigned int cpu)
@@ -2338,6 +2347,99 @@ static bool rcu_torture_can_boost(void)
 	return true;
 }
 
+static bool read_exit_child_stop;
+static bool read_exit_child_stopped;
+static wait_queue_head_t read_exit_wq;
+
+// Child kthread which just does an rcutorture reader and exits.
+static int rcu_torture_read_exit_child(void *trsp_in)
+{
+	struct torture_random_state *trsp = trsp_in;
+
+	set_user_nice(current, MAX_NICE);
+	// Minimize time between reading and exiting.
+	while (!kthread_should_stop())
+		schedule_timeout_uninterruptible(1);
+	(void)rcu_torture_one_read(trsp);
+	return 0;
+}
+
+// Parent kthread which creates and destroys read-exit child kthreads.
+static int rcu_torture_read_exit(void *unused)
+{
+	int count = 0;
+	bool errexit = false;
+	int i;
+	struct task_struct *tsp;
+	DEFINE_TORTURE_RANDOM(trs);
+
+	// Allocate and initialize.
+	set_user_nice(current, MAX_NICE);
+	VERBOSE_TOROUT_STRING("rcu_torture_read_exit: Start of test");
+
+	// Each pass through this loop does one read-exit episode.
+	do {
+		if (++count > read_exit_burst) {
+			VERBOSE_TOROUT_STRING("rcu_torture_read_exit: End of episode");
+			rcu_barrier(); // Wait for task_struct free, avoid OOM.
+			for (i = 0; i < read_exit_delay; i++) {
+				schedule_timeout_uninterruptible(HZ);
+				if (READ_ONCE(read_exit_child_stop))
+					break;
+			}
+			if (!READ_ONCE(read_exit_child_stop))
+				VERBOSE_TOROUT_STRING("rcu_torture_read_exit: Start of episode");
+			count = 0;
+		}
+		if (READ_ONCE(read_exit_child_stop))
+			break;
+		// Spawn child.
+		tsp = kthread_run(rcu_torture_read_exit_child,
+				     &trs, "%s",
+				     "rcu_torture_read_exit_child");
+		if (IS_ERR(tsp)) {
+			VERBOSE_TOROUT_ERRSTRING("out of memory");
+			errexit = true;
+			tsp = NULL;
+			break;
+		}
+		cond_resched();
+		kthread_stop(tsp);
+		n_read_exits ++;
+		stutter_wait("rcu_torture_read_exit");
+	} while (!errexit && !READ_ONCE(read_exit_child_stop));
+
+	// Clean up and exit.
+	smp_store_release(&read_exit_child_stopped, true); // After reaping.
+	smp_mb(); // Store before wakeup.
+	wake_up(&read_exit_wq);
+	while (!torture_must_stop())
+		schedule_timeout_uninterruptible(1);
+	torture_kthread_stopping("rcu_torture_read_exit");
+	return 0;
+}
+
+static int rcu_torture_read_exit_init(void)
+{
+	if (read_exit_burst <= 0)
+		return -EINVAL;
+	init_waitqueue_head(&read_exit_wq);
+	read_exit_child_stop = false;
+	read_exit_child_stopped = false;
+	return torture_create_kthread(rcu_torture_read_exit, NULL,
+				      read_exit_task);
+}
+
+static void rcu_torture_read_exit_cleanup(void)
+{
+	if (!read_exit_task)
+		return;
+	WRITE_ONCE(read_exit_child_stop, true);
+	smp_mb(); // Above write before wait.
+	wait_event(read_exit_wq, smp_load_acquire(&read_exit_child_stopped));
+	torture_stop_kthread(rcutorture_read_exit, read_exit_task);
+}
+
 static enum cpuhp_state rcutor_hp;
 
 static void
@@ -2359,6 +2461,7 @@ rcu_torture_cleanup(void)
 	}
 
 	show_rcu_gp_kthreads();
+	rcu_torture_read_exit_cleanup();
 	rcu_torture_barrier_cleanup();
 	torture_stop_kthread(rcu_torture_fwd_prog, fwd_prog_task);
 	torture_stop_kthread(rcu_torture_stall, stall_task);
@@ -2682,6 +2785,9 @@ rcu_torture_init(void)
 	firsterr = rcu_torture_barrier_init();
 	if (firsterr)
 		goto unwind;
+	firsterr = rcu_torture_read_exit_init();
+	if (firsterr)
+		goto unwind;
 	if (object_debug)
 		rcu_test_debug_objects();
 	torture_init_end();
