Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD758C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 12:23:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCFDF20FC3
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 12:23:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729305AbgFPMXg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 08:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728945AbgFPMWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 08:22:08 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1141CC08C5C3;
        Tue, 16 Jun 2020 05:22:07 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jlAbK-0004j5-Ta; Tue, 16 Jun 2020 14:22:03 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 59C7D1C0478;
        Tue, 16 Jun 2020 14:21:54 +0200 (CEST)
Date:   Tue, 16 Jun 2020 12:21:54 -0000
From:   "tip-bot2 for Suren Baghdasaryan" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] psi: eliminate kthread_worker from psi trigger
 scheduling mechanism
Cc:     Suren Baghdasaryan <surenb@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200528195442.190116-1-surenb@google.com>
References: <20200528195442.190116-1-surenb@google.com>
MIME-Version: 1.0
Message-ID: <159231011414.16989.3532152953251397536.tip-bot2@tip-bot2>
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

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     461daba06bdcb9c7a3f92b9bbd110e1f7d093ffc
Gitweb:        https://git.kernel.org/tip/461daba06bdcb9c7a3f92b9bbd110e1f7d093ffc
Author:        Suren Baghdasaryan <surenb@google.com>
AuthorDate:    Thu, 28 May 2020 12:54:42 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 15 Jun 2020 14:10:03 +02:00

psi: eliminate kthread_worker from psi trigger scheduling mechanism

Each psi group requires a dedicated kthread_delayed_work and
kthread_worker. Since no other work can be performed using psi_group's
kthread_worker, the same result can be obtained using a task_struct and
a timer directly. This makes psi triggering simpler by removing lists
and locks involved with kthread_worker usage and eliminates the need for
poll_scheduled atomic use in the hot path.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200528195442.190116-1-surenb@google.com
---
 include/linux/psi_types.h |   7 +-
 kernel/sched/psi.c        | 113 ++++++++++++++++++++-----------------
 2 files changed, 68 insertions(+), 52 deletions(-)

diff --git a/include/linux/psi_types.h b/include/linux/psi_types.h
index 4b72584..b95f321 100644
--- a/include/linux/psi_types.h
+++ b/include/linux/psi_types.h
@@ -153,9 +153,10 @@ struct psi_group {
 	unsigned long avg[NR_PSI_STATES - 1][3];
 
 	/* Monitor work control */
-	atomic_t poll_scheduled;
-	struct kthread_worker __rcu *poll_kworker;
-	struct kthread_delayed_work poll_work;
+	struct task_struct __rcu *poll_task;
+	struct timer_list poll_timer;
+	wait_queue_head_t poll_wait;
+	atomic_t poll_wakeup;
 
 	/* Protects data used by the monitor */
 	struct mutex trigger_lock;
diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 8f45cdb..e53b711 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -190,7 +190,6 @@ static void group_init(struct psi_group *group)
 	INIT_DELAYED_WORK(&group->avgs_work, psi_avgs_work);
 	mutex_init(&group->avgs_lock);
 	/* Init trigger-related members */
-	atomic_set(&group->poll_scheduled, 0);
 	mutex_init(&group->trigger_lock);
 	INIT_LIST_HEAD(&group->triggers);
 	memset(group->nr_triggers, 0, sizeof(group->nr_triggers));
@@ -199,7 +198,7 @@ static void group_init(struct psi_group *group)
 	memset(group->polling_total, 0, sizeof(group->polling_total));
 	group->polling_next_update = ULLONG_MAX;
 	group->polling_until = 0;
-	rcu_assign_pointer(group->poll_kworker, NULL);
+	rcu_assign_pointer(group->poll_task, NULL);
 }
 
 void __init psi_init(void)
@@ -547,47 +546,38 @@ static u64 update_triggers(struct psi_group *group, u64 now)
 	return now + group->poll_min_period;
 }
 
-/*
- * Schedule polling if it's not already scheduled. It's safe to call even from
- * hotpath because even though kthread_queue_delayed_work takes worker->lock
- * spinlock that spinlock is never contended due to poll_scheduled atomic
- * preventing such competition.
- */
+/* Schedule polling if it's not already scheduled. */
 static void psi_schedule_poll_work(struct psi_group *group, unsigned long delay)
 {
-	struct kthread_worker *kworker;
+	struct task_struct *task;
 
-	/* Do not reschedule if already scheduled */
-	if (atomic_cmpxchg(&group->poll_scheduled, 0, 1) != 0)
+	/*
+	 * Do not reschedule if already scheduled.
+	 * Possible race with a timer scheduled after this check but before
+	 * mod_timer below can be tolerated because group->polling_next_update
+	 * will keep updates on schedule.
+	 */
+	if (timer_pending(&group->poll_timer))
 		return;
 
 	rcu_read_lock();
 
-	kworker = rcu_dereference(group->poll_kworker);
+	task = rcu_dereference(group->poll_task);
 	/*
 	 * kworker might be NULL in case psi_trigger_destroy races with
 	 * psi_task_change (hotpath) which can't use locks
 	 */
-	if (likely(kworker))
-		kthread_queue_delayed_work(kworker, &group->poll_work, delay);
-	else
-		atomic_set(&group->poll_scheduled, 0);
+	if (likely(task))
+		mod_timer(&group->poll_timer, jiffies + delay);
 
 	rcu_read_unlock();
 }
 
-static void psi_poll_work(struct kthread_work *work)
+static void psi_poll_work(struct psi_group *group)
 {
-	struct kthread_delayed_work *dwork;
-	struct psi_group *group;
 	u32 changed_states;
 	u64 now;
 
-	dwork = container_of(work, struct kthread_delayed_work, work);
-	group = container_of(dwork, struct psi_group, poll_work);
-
-	atomic_set(&group->poll_scheduled, 0);
-
 	mutex_lock(&group->trigger_lock);
 
 	now = sched_clock();
@@ -623,6 +613,35 @@ out:
 	mutex_unlock(&group->trigger_lock);
 }
 
+static int psi_poll_worker(void *data)
+{
+	struct psi_group *group = (struct psi_group *)data;
+	struct sched_param param = {
+		.sched_priority = 1,
+	};
+
+	sched_setscheduler_nocheck(current, SCHED_FIFO, &param);
+
+	while (true) {
+		wait_event_interruptible(group->poll_wait,
+				atomic_cmpxchg(&group->poll_wakeup, 1, 0) ||
+				kthread_should_stop());
+		if (kthread_should_stop())
+			break;
+
+		psi_poll_work(group);
+	}
+	return 0;
+}
+
+static void poll_timer_fn(struct timer_list *t)
+{
+	struct psi_group *group = from_timer(group, t, poll_timer);
+
+	atomic_set(&group->poll_wakeup, 1);
+	wake_up_interruptible(&group->poll_wait);
+}
+
 static void record_times(struct psi_group_cpu *groupc, int cpu,
 			 bool memstall_tick)
 {
@@ -1099,22 +1118,20 @@ struct psi_trigger *psi_trigger_create(struct psi_group *group,
 
 	mutex_lock(&group->trigger_lock);
 
-	if (!rcu_access_pointer(group->poll_kworker)) {
-		struct sched_param param = {
-			.sched_priority = 1,
-		};
-		struct kthread_worker *kworker;
+	if (!rcu_access_pointer(group->poll_task)) {
+		struct task_struct *task;
 
-		kworker = kthread_create_worker(0, "psimon");
-		if (IS_ERR(kworker)) {
+		task = kthread_create(psi_poll_worker, group, "psimon");
+		if (IS_ERR(task)) {
 			kfree(t);
 			mutex_unlock(&group->trigger_lock);
-			return ERR_CAST(kworker);
+			return ERR_CAST(task);
 		}
-		sched_setscheduler_nocheck(kworker->task, SCHED_FIFO, &param);
-		kthread_init_delayed_work(&group->poll_work,
-				psi_poll_work);
-		rcu_assign_pointer(group->poll_kworker, kworker);
+		atomic_set(&group->poll_wakeup, 0);
+		init_waitqueue_head(&group->poll_wait);
+		wake_up_process(task);
+		timer_setup(&group->poll_timer, poll_timer_fn, 0);
+		rcu_assign_pointer(group->poll_task, task);
 	}
 
 	list_add(&t->node, &group->triggers);
@@ -1132,7 +1149,7 @@ static void psi_trigger_destroy(struct kref *ref)
 {
 	struct psi_trigger *t = container_of(ref, struct psi_trigger, refcount);
 	struct psi_group *group = t->group;
-	struct kthread_worker *kworker_to_destroy = NULL;
+	struct task_struct *task_to_destroy = NULL;
 
 	if (static_branch_likely(&psi_disabled))
 		return;
@@ -1158,13 +1175,13 @@ static void psi_trigger_destroy(struct kref *ref)
 			period = min(period, div_u64(tmp->win.size,
 					UPDATES_PER_WINDOW));
 		group->poll_min_period = period;
-		/* Destroy poll_kworker when the last trigger is destroyed */
+		/* Destroy poll_task when the last trigger is destroyed */
 		if (group->poll_states == 0) {
 			group->polling_until = 0;
-			kworker_to_destroy = rcu_dereference_protected(
-					group->poll_kworker,
+			task_to_destroy = rcu_dereference_protected(
+					group->poll_task,
 					lockdep_is_held(&group->trigger_lock));
-			rcu_assign_pointer(group->poll_kworker, NULL);
+			rcu_assign_pointer(group->poll_task, NULL);
 		}
 	}
 
@@ -1172,25 +1189,23 @@ static void psi_trigger_destroy(struct kref *ref)
 
 	/*
 	 * Wait for both *trigger_ptr from psi_trigger_replace and
-	 * poll_kworker RCUs to complete their read-side critical sections
-	 * before destroying the trigger and optionally the poll_kworker
+	 * poll_task RCUs to complete their read-side critical sections
+	 * before destroying the trigger and optionally the poll_task
 	 */
 	synchronize_rcu();
 	/*
 	 * Destroy the kworker after releasing trigger_lock to prevent a
 	 * deadlock while waiting for psi_poll_work to acquire trigger_lock
 	 */
-	if (kworker_to_destroy) {
+	if (task_to_destroy) {
 		/*
 		 * After the RCU grace period has expired, the worker
-		 * can no longer be found through group->poll_kworker.
+		 * can no longer be found through group->poll_task.
 		 * But it might have been already scheduled before
 		 * that - deschedule it cleanly before destroying it.
 		 */
-		kthread_cancel_delayed_work_sync(&group->poll_work);
-		atomic_set(&group->poll_scheduled, 0);
-
-		kthread_destroy_worker(kworker_to_destroy);
+		del_timer_sync(&group->poll_timer);
+		kthread_stop(task_to_destroy);
 	}
 	kfree(t);
 }
