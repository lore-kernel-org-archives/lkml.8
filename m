Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B31EC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 19:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 671832088E
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 19:54:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EhpPm+AC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406821AbgE1Tyz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 15:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406687AbgE1Tyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 15:54:54 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C412C08C5C6
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 12:54:54 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id i1so239666qvo.21
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 12:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=j/zpUZP6UuXadr7itIBgX40hggOYhdz2f619pDpYUzs=;
        b=EhpPm+ACq/YYmuSLs50vyUL7wc2VP3HoufTjDyjcJ+cMY14wn2vX8k8CfzFgX1V7cm
         WJwxYzdq1EtW5vjm6gDZc1FtVpFjAQpNEnuKVl4+mxRJcGwa31QTKuEQ+4jtdFFrX5Lf
         4+zG3cHh/IgKyfuiSNpdIwPRLUslGKvIRIGvJUxfEwfsiP6/IEYmYWXv+/1JABHo8Zcb
         +0rExkoZDChA+ig4e6hNti9sJOTdfOXwXiu2MxJEA9evf+Nk58nP1oQYZn+jsEqfGQtR
         z/i+eOscdNJe2JubRkKkBkbgA31Uw17FhbaYRPdWaUj5+tcC9QtO3gBL9IuEsu0AAor+
         JL1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=j/zpUZP6UuXadr7itIBgX40hggOYhdz2f619pDpYUzs=;
        b=BNdslkoZXeYohryOxHtaJXXGorMAUCmE4oCDhnu5tvebparQ91zRRiadh/rrXfUpCZ
         1DlBTeFNmE4ZGY0RNsunhmsWh2aXvxGOqAQL29jJ01jcwTKp3F28Nfyq7/ot/WeB7OCu
         KwRyE8h7AlI/kfYDVgY0KhfpyfIU2RdFpXvuDqvUz45EbOU9Ke3y2XrCa+WA+bQ/44XP
         TrrXFBAkLu7fj8103rUDKgZE1K+sB6ILxV+g1mn2rVM2dkBud0b3fYdfzA/XdIe4DM55
         fZqsFpJoDg+/TXQXhU7jIYRJ7tZwhMjYzEBnZy58cyCofW9gwS1fss9RKgpP5IFxSZPi
         fzqA==
X-Gm-Message-State: AOAM531zfFKtQW8avdfazs4gPiyjK5owlox1DH/v4omKh4bKi7w37Iff
        7ybjAu3ioXTlz7paGQ+SzUt85axsF1M=
X-Google-Smtp-Source: ABdhPJy3BkpsUdu2Ai7UuJ4LOynPV+XxC3wYOfKxLwB+xlNPy5kDnSoYzrHlzbFijRU6Jgov3IOL2XGRZGg=
X-Received: by 2002:a0c:b797:: with SMTP id l23mr5009185qve.160.1590695693219;
 Thu, 28 May 2020 12:54:53 -0700 (PDT)
Date:   Thu, 28 May 2020 12:54:42 -0700
Message-Id: <20200528195442.190116-1-surenb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.rc0.183.gde8f92d652-goog
Subject: [PATCH 1/1] psi: eliminate kthread_worker from psi trigger scheduling mechanism
From:   Suren Baghdasaryan <surenb@google.com>
To:     surenb@google.com
Cc:     peterz@infradead.org, mingo@redhat.com, hannes@cmpxchg.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, shakeelb@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Each psi group requires a dedicated kthread_delayed_work and
kthread_worker. Since no other work can be performed using psi_group's
kthread_worker, the same result can be obtained using a task_struct and
a timer directly. This makes psi triggering simpler by removing lists
and locks involved with kthread_worker usage and eliminates the need for
poll_scheduled atomic use in the hot path.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
This patch is meant to address Peter's request in [1] to pull
kthread_queue_delayed_work() out from under rq->lock. This should also address
the lockdep warning about possibility of a circular dependency described in [2]

[1]: https://lore.kernel.org/lkml/20200428163125.GC16910@hirez.programming.kicks-ass.net/
[2]: https://lore.kernel.org/lkml/CAJuCfpG4NkhpQvZjgXZ_3gm6Hf1QgN_eUOQ8iX9Cv1k9whLwSQ@mail.gmail.com
---
 include/linux/psi_types.h |   7 ++-
 kernel/sched/psi.c        | 113 +++++++++++++++++++++-----------------
 2 files changed, 68 insertions(+), 52 deletions(-)

diff --git a/include/linux/psi_types.h b/include/linux/psi_types.h
index 4b7258495a04..b95f3211566a 100644
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
index 8f45cdb6463b..e53b711bd643 100644
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
@@ -623,6 +613,35 @@ static void psi_poll_work(struct kthread_work *work)
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
-- 
2.27.0.rc0.183.gde8f92d652-goog

