Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6A93C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 10:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0BEC2071A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 10:47:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728419AbgGWKrf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 06:47:35 -0400
Received: from lgeamrelo12.lge.com ([156.147.23.52]:49902 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725911AbgGWKre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 06:47:34 -0400
X-Greylist: delayed 1800 seconds by postgrey-1.27 at vger.kernel.org; Thu, 23 Jul 2020 06:47:33 EDT
Received: from unknown (HELO lgemrelse6q.lge.com) (156.147.1.121)
        by 156.147.23.52 with ESMTP; 23 Jul 2020 19:17:31 +0900
X-Original-SENDERIP: 156.147.1.121
X-Original-MAILFROM: byungchul.park@lge.com
Received: from unknown (HELO localhost.localdomain) (10.177.222.33)
        by 156.147.1.121 with ESMTP; 23 Jul 2020 19:17:30 +0900
X-Original-SENDERIP: 10.177.222.33
X-Original-MAILFROM: byungchul.park@lge.com
From:   Byungchul Park <byungchul.park@lge.com>
To:     peterz@infradead.org, mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@lge.com
Subject: [RFC] sched: Consider higher or lower sched_class tasks on migration
Date:   Thu, 23 Jul 2020 19:17:39 +0900
Message-Id: <1595499459-30973-1-git-send-email-byungchul.park@lge.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello folks,

I found there's some problem on rt migration code while I was working
on a latency sensitive system.

I thought we need to consider not only tasks' priorty within the
sched_cass but also priorities between sched_classes on migration
at least for rt(or deadline) tasks.

Even though I worked against very low version of stable-tree (v4.4),
I will work on the newest mainline tree and re-submit it as a normal
patch (not RFC) if you agree with the approach.

BTW, am I misshing something on this?

Thanks,
Byungchul

----->8-----
From 785a569d705d8f743fc8bd58b810222cbb5f6eb1 Mon Sep 17 00:00:00 2001
From: Byungchul Park <byungchul.park@lge.com>
Date: Thu, 23 Jul 2020 18:42:05 +0900
Subject: [RFC] sched: Consider higher or lower sched_class tasks on
 migration

Scheduler should avoid to migrate rt(or deadline) tasks to other CPUs
having higher sched_class tasks but it doesn't.

In addition, when an upper sched_class task was picked using
->pick_next_task(), it should be taken into account that lower
sched_class tasks than the picked task should be moved to other CPUs.

For example, when a dl task was just picked, the scheduler should push
rt tasks to other CPUs if the preempted task is in rt sched_class and
its priority is high enough to run on another CPU.

While at it, rename queue_{push,pull}_* functions to reflect their
classes.

Signed-off-by: Byungchul Park <byungchul.park@lge.com>
---
 kernel/sched/core.c        | 15 +++++++++++++++
 kernel/sched/cpudeadline.c | 21 +++++++++++++++++++--
 kernel/sched/cpudeadline.h |  1 +
 kernel/sched/cpupri.c      |  2 ++
 kernel/sched/deadline.c    | 31 ++++++++++++++++++++-----------
 kernel/sched/rt.c          | 16 ++++++----------
 kernel/sched/sched.h       |  8 ++++++++
 kernel/sched/stop_task.c   | 28 ++++++++++++++++++++++++++++
 8 files changed, 99 insertions(+), 23 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index d99240f..a391eb2 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1157,6 +1157,21 @@ static int migration_cpu_stop(void *data)
 	return 0;
 }
 
+int exclude_higher_class(struct cpumask *dstp, struct task_struct *p)
+{
+	const struct sched_class *cur = p->sched_class;
+	const struct sched_class *class;
+	struct rq *rq = task_rq(p);
+
+	for_each_class(class) {
+		if (class == cur)
+			break;
+		if (class->exclude_higher_class)
+			class->exclude_higher_class(rq, dstp);
+	}
+	return !cpumask_empty(dstp);
+}
+
 /*
  * sched_class::set_cpus_allowed must do the below, but is not required to
  * actually call this function.
diff --git a/kernel/sched/cpudeadline.c b/kernel/sched/cpudeadline.c
index 5a75b08..19887ff 100644
--- a/kernel/sched/cpudeadline.c
+++ b/kernel/sched/cpudeadline.c
@@ -15,6 +15,7 @@
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include "cpudeadline.h"
+#include "sched.h"
 
 static inline int parent(int i)
 {
@@ -103,14 +104,25 @@ int cpudl_find(struct cpudl *cp, struct task_struct *p,
 	const struct sched_dl_entity *dl_se = &p->dl;
 
 	if (later_mask &&
-	    cpumask_and(later_mask, cp->free_cpus, &p->cpus_allowed)) {
+	    cpumask_and(later_mask, cp->free_cpus, &p->cpus_allowed) &&
+	    exclude_higher_class(later_mask, p)) {
 		best_cpu = cpumask_any(later_mask);
 		goto out;
 	} else if (cpumask_test_cpu(cpudl_maximum(cp), &p->cpus_allowed) &&
 			dl_time_before(dl_se->deadline, cp->elements[0].dl)) {
 		best_cpu = cpudl_maximum(cp);
-		if (later_mask)
+		if (later_mask) {
 			cpumask_set_cpu(best_cpu, later_mask);
+
+			/*
+			 * TODO: It would be better to pick the second best
+			 * in this case.
+			 */
+			if (!exclude_higher_class(later_mask, p)) {
+				best_cpu = -1;
+				cpumask_clear_cpu(best_cpu, later_mask);
+			}
+		}
 	}
 
 out:
@@ -201,6 +213,11 @@ void cpudl_clear_freecpu(struct cpudl *cp, int cpu)
 	cpumask_clear_cpu(cpu, cp->free_cpus);
 }
 
+void cpudl_exclude_dlcpus(struct cpudl *cp, struct cpumask *dstp)
+{
+	cpumask_and(dstp, dstp, cp->free_cpus);
+}
+
 /*
  * cpudl_init - initialize the cpudl structure
  * @cp: the cpudl max-heap context
diff --git a/kernel/sched/cpudeadline.h b/kernel/sched/cpudeadline.h
index fcbdf83..bc2510c 100644
--- a/kernel/sched/cpudeadline.h
+++ b/kernel/sched/cpudeadline.h
@@ -27,6 +27,7 @@ void cpudl_set(struct cpudl *cp, int cpu, u64 dl, int is_valid);
 int cpudl_init(struct cpudl *cp);
 void cpudl_set_freecpu(struct cpudl *cp, int cpu);
 void cpudl_clear_freecpu(struct cpudl *cp, int cpu);
+void cpudl_exclude_dlcpus(struct cpudl *cp, struct cpumask *dstp);
 void cpudl_cleanup(struct cpudl *cp);
 #endif /* CONFIG_SMP */
 
diff --git a/kernel/sched/cpupri.c b/kernel/sched/cpupri.c
index 981fcd7..a509a96 100644
--- a/kernel/sched/cpupri.c
+++ b/kernel/sched/cpupri.c
@@ -32,6 +32,7 @@
 #include <linux/sched/rt.h>
 #include <linux/slab.h>
 #include "cpupri.h"
+#include "sched.h"
 
 /* Convert between a 140 based task->prio, and our 102 based cpupri */
 static int convert_prio(int prio)
@@ -108,6 +109,7 @@ int cpupri_find(struct cpupri *cp, struct task_struct *p,
 
 		if (lowest_mask) {
 			cpumask_and(lowest_mask, &p->cpus_allowed, vec->mask);
+			exclude_higher_class(lowest_mask, p);
 
 			/*
 			 * We have to ensure that we have at least one bit
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index e12b0a4..5b43690 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -219,7 +219,7 @@ static DEFINE_PER_CPU(struct callback_head, dl_pull_head);
 static void push_dl_tasks(struct rq *);
 static void pull_dl_task(struct rq *);
 
-static inline void queue_push_tasks(struct rq *rq)
+void queue_push_dl_tasks(struct rq *rq)
 {
 	if (!has_pushable_dl_tasks(rq))
 		return;
@@ -227,7 +227,7 @@ static inline void queue_push_tasks(struct rq *rq)
 	queue_balance_callback(rq, &per_cpu(dl_push_head, rq->cpu), push_dl_tasks);
 }
 
-static inline void queue_pull_task(struct rq *rq)
+static inline void queue_pull_dl_task(struct rq *rq)
 {
 	queue_balance_callback(rq, &per_cpu(dl_pull_head, rq->cpu), pull_dl_task);
 }
@@ -314,11 +314,7 @@ static inline void pull_dl_task(struct rq *rq)
 {
 }
 
-static inline void queue_push_tasks(struct rq *rq)
-{
-}
-
-static inline void queue_pull_task(struct rq *rq)
+static inline void queue_pull_dl_task(struct rq *rq)
 {
 }
 #endif /* CONFIG_SMP */
@@ -1329,7 +1325,14 @@ struct task_struct *pick_next_task_dl(struct rq *rq, struct task_struct *prev)
 	if (hrtick_enabled(rq))
 		start_hrtick_dl(rq, p);
 
-	queue_push_tasks(rq);
+	/*
+	 * The callback queued earlier will be executed later. Let the
+	 * dl migration performed first in balance_callback().
+	 */
+	if (prev->sched_class == &rt_sched_class)
+		queue_push_rt_tasks(rq);
+
+	queue_push_dl_tasks(rq);
 
 	return p;
 }
@@ -1800,6 +1803,11 @@ static void task_woken_dl(struct rq *rq, struct task_struct *p)
 	}
 }
 
+static void exclude_higher_class_dl(struct rq *rq, struct cpumask *dstp)
+{
+	cpudl_exclude_dlcpus(&rq->rd->cpudl, dstp);
+}
+
 static void set_cpus_allowed_dl(struct task_struct *p,
 				const struct cpumask *new_mask)
 {
@@ -1884,7 +1892,7 @@ static void switched_from_dl(struct rq *rq, struct task_struct *p)
 	if (!task_on_rq_queued(p) || rq->dl.dl_nr_running)
 		return;
 
-	queue_pull_task(rq);
+	queue_pull_dl_task(rq);
 }
 
 /*
@@ -1896,7 +1904,7 @@ static void switched_to_dl(struct rq *rq, struct task_struct *p)
 	if (task_on_rq_queued(p) && rq->curr != p) {
 #ifdef CONFIG_SMP
 		if (p->nr_cpus_allowed > 1 && rq->dl.overloaded)
-			queue_push_tasks(rq);
+			queue_push_dl_tasks(rq);
 #endif
 		if (dl_task(rq->curr))
 			check_preempt_curr_dl(rq, p, 0);
@@ -1921,7 +1929,7 @@ static void prio_changed_dl(struct rq *rq, struct task_struct *p,
 		 * or lowering its prio, so...
 		 */
 		if (!rq->dl.overloaded)
-			queue_pull_task(rq);
+			queue_pull_dl_task(rq);
 
 		/*
 		 * If we now have a earlier deadline task than p,
@@ -1959,6 +1967,7 @@ const struct sched_class dl_sched_class = {
 	.rq_online              = rq_online_dl,
 	.rq_offline             = rq_offline_dl,
 	.task_woken		= task_woken_dl,
+	.exclude_higher_class	= exclude_higher_class_dl,
 #endif
 
 	.set_curr_task		= set_curr_task_dl,
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 801b4ec..b789d4f 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -349,7 +349,7 @@ static DEFINE_PER_CPU(struct callback_head, rt_pull_head);
 static void push_rt_tasks(struct rq *);
 static void pull_rt_task(struct rq *);
 
-static inline void queue_push_tasks(struct rq *rq)
+void queue_push_rt_tasks(struct rq *rq)
 {
 	if (!has_pushable_tasks(rq))
 		return;
@@ -357,7 +357,7 @@ static inline void queue_push_tasks(struct rq *rq)
 	queue_balance_callback(rq, &per_cpu(rt_push_head, rq->cpu), push_rt_tasks);
 }
 
-static inline void queue_pull_task(struct rq *rq)
+static inline void queue_pull_rt_task(struct rq *rq)
 {
 	queue_balance_callback(rq, &per_cpu(rt_pull_head, rq->cpu), pull_rt_task);
 }
@@ -414,10 +414,6 @@ static inline bool need_pull_rt_task(struct rq *rq, struct task_struct *prev)
 static inline void pull_rt_task(struct rq *this_rq)
 {
 }
-
-static inline void queue_push_tasks(struct rq *rq)
-{
-}
 #endif /* CONFIG_SMP */
 
 static void enqueue_top_rt_rq(struct rt_rq *rt_rq);
@@ -1495,7 +1491,7 @@ pick_next_task_rt(struct rq *rq, struct task_struct *prev)
 	/* The running task is never eligible for pushing */
 	dequeue_pushable_task(rq, p);
 
-	queue_push_tasks(rq);
+	queue_push_rt_tasks(rq);
 
 	return p;
 }
@@ -2113,7 +2109,7 @@ static void switched_from_rt(struct rq *rq, struct task_struct *p)
 	if (!task_on_rq_queued(p) || rq->rt.rt_nr_running)
 		return;
 
-	queue_pull_task(rq);
+	queue_pull_rt_task(rq);
 }
 
 void __init init_sched_rt_class(void)
@@ -2144,7 +2140,7 @@ static void switched_to_rt(struct rq *rq, struct task_struct *p)
 	if (task_on_rq_queued(p) && rq->curr != p) {
 #ifdef CONFIG_SMP
 		if (p->nr_cpus_allowed > 1 && rq->rt.overloaded)
-			queue_push_tasks(rq);
+			queue_push_rt_tasks(rq);
 #endif /* CONFIG_SMP */
 		if (p->prio < rq->curr->prio && cpu_online(cpu_of(rq)))
 			resched_curr(rq);
@@ -2168,7 +2164,7 @@ prio_changed_rt(struct rq *rq, struct task_struct *p, int oldprio)
 		 * may need to pull tasks to this runqueue.
 		 */
 		if (oldprio < p->prio)
-			queue_pull_task(rq);
+			queue_pull_rt_task(rq);
 
 		/*
 		 * If there's a higher priority task waiting to run
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 0c9ebd8..d164f54 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -789,6 +789,9 @@ queue_balance_callback(struct rq *rq,
 	rq->balance_callback = head;
 }
 
+extern void queue_push_rt_tasks(struct rq *rq);
+extern void queue_push_dl_tasks(struct rq *rq);
+
 extern void sched_ttwu_pending(void);
 
 #define rcu_dereference_check_sched_domain(p) \
@@ -910,6 +913,9 @@ extern int group_balance_cpu(struct sched_group *sg);
 
 #else
 
+static inline void queue_push_rt_tasks(struct rq *rq) { }
+static inline void queue_push_dl_tasks(struct rq *rq) { }
+
 static inline void sched_ttwu_pending(void) { }
 
 #endif /* CONFIG_SMP */
@@ -1212,6 +1218,7 @@ struct sched_class {
 
 	void (*set_cpus_allowed)(struct task_struct *p,
 				 const struct cpumask *newmask);
+	void (*exclude_higher_class)(struct rq *rq, struct cpumask *dstp);
 
 	void (*rq_online)(struct rq *rq);
 	void (*rq_offline)(struct rq *rq);
@@ -1269,6 +1276,7 @@ extern void idle_exit_fair(struct rq *this_rq);
 
 extern void set_cpus_allowed_common(struct task_struct *p, const struct cpumask *new_mask);
 
+extern int exclude_higher_class(struct cpumask *dstp, struct task_struct *p);
 #else
 
 static inline void idle_enter_fair(struct rq *rq) { }
diff --git a/kernel/sched/stop_task.c b/kernel/sched/stop_task.c
index cbc67da..e6694cb 100644
--- a/kernel/sched/stop_task.c
+++ b/kernel/sched/stop_task.c
@@ -15,6 +15,26 @@ select_task_rq_stop(struct task_struct *p, int cpu, int sd_flag, int flags)
 {
 	return task_cpu(p); /* stop tasks as never migrate */
 }
+
+static cpumask_t stop_runnable_mask;
+
+static void exclude_higher_class_stop(struct rq *rq, struct cpumask *dstp)
+{
+	cpumask_andnot(dstp, dstp, &stop_runnable_mask);
+}
+
+static inline void set_stop_runnable_mask(int cpu)
+{
+	cpumask_set_cpu(cpu, &stop_runnable_mask);
+}
+
+static inline void clear_stop_runnable_mask(int cpu)
+{
+	cpumask_clear_cpu(cpu, &stop_runnable_mask);
+}
+#else
+static inline void set_stop_runnable_mask(int cpu) { }
+static inline void clear_stop_runnable_mask(int cpu) { }
 #endif /* CONFIG_SMP */
 
 static void
@@ -33,6 +53,11 @@ pick_next_task_stop(struct rq *rq, struct task_struct *prev)
 
 	put_prev_task(rq, prev);
 
+	if (prev->sched_class == &dl_sched_class)
+		queue_push_dl_tasks(rq);
+	else if (prev->sched_class == &rt_sched_class)
+		queue_push_rt_tasks(rq);
+
 	stop->se.exec_start = rq_clock_task(rq);
 
 	return stop;
@@ -42,12 +67,14 @@ static void
 enqueue_task_stop(struct rq *rq, struct task_struct *p, int flags)
 {
 	add_nr_running(rq, 1);
+	set_stop_runnable_mask(cpu_of(rq));
 }
 
 static void
 dequeue_task_stop(struct rq *rq, struct task_struct *p, int flags)
 {
 	sub_nr_running(rq, 1);
+	clear_stop_runnable_mask(cpu_of(rq));
 }
 
 static void yield_task_stop(struct rq *rq)
@@ -124,6 +151,7 @@ const struct sched_class stop_sched_class = {
 #ifdef CONFIG_SMP
 	.select_task_rq		= select_task_rq_stop,
 	.set_cpus_allowed	= set_cpus_allowed_common,
+	.exclude_higher_class	= exclude_higher_class_stop,
 #endif
 
 	.set_curr_task          = set_curr_task_stop,
-- 
1.9.1

