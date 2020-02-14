Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 404D6C3B18F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 08:13:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0EDE222C4
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 08:13:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729162AbgBNINf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 03:13:35 -0500
Received: from outbound-smtp25.blacknight.com ([81.17.249.193]:54249 "EHLO
        outbound-smtp25.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729120AbgBNINe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 03:13:34 -0500
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp25.blacknight.com (Postfix) with ESMTPS id CBC28B8869
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 08:13:30 +0000 (GMT)
Received: (qmail 4980 invoked from network); 14 Feb 2020 08:13:30 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPA; 14 Feb 2020 08:13:30 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Phil Auld <pauld@redhat.com>, Hillf Danton <hdanton@sina.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 07/12] sched/fair: replace runnable load average by runnable average
Date:   Fri, 14 Feb 2020 08:13:19 +0000
Message-Id: <20200214081324.26859-8-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200214081324.26859-1-mgorman@techsingularity.net>
References: <20200214081324.26859-1-mgorman@techsingularity.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vincent Guittot <vincent.guittot@linaro.org>

Now that runnable_load_avg is not more used, we can replace it by a new
signal that will highlight the runnable pressure on a cfs_rq. This signal
track the waiting time of tasks on rq and can help to better define the
state of rqs.

At now, only util_avg is used to define the state of a rq:
  A rq with more that around 80% of utilization and more than 1 tasks is
  considered as overloaded.

But the util_avg signal of a rq can become temporaly low after that a task
migrated onto another rq which can bias the classification of the rq.

When tasks compete for the same rq, their runnable average signal will be
higher than util_avg as it will include the waiting time and we can use
this signal to better classify cfs_rqs.

The new runnable_avg will track the runnable time of a task which simply
adds the waiting time to the running time. The runnbale _avg of cfs_rq
will be the /Sum of se's runnable_avg and the runnable_avg of group entity
will follow the one of the rq similarly to util_avg.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 include/linux/sched.h |  17 +++--
 kernel/sched/core.c   |   2 -
 kernel/sched/debug.c  |  17 ++---
 kernel/sched/fair.c   | 181 +++++++++++++++++++-------------------------------
 kernel/sched/pelt.c   |  45 +++++++------
 kernel/sched/sched.h  |  29 ++++++--
 6 files changed, 136 insertions(+), 155 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 04278493bf15..5d633c807635 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -357,7 +357,7 @@ struct util_est {
 
 /*
  * The load_avg/util_avg accumulates an infinite geometric series
- * (see __update_load_avg() in kernel/sched/fair.c).
+ * (see __update_load_avg_cfs_rq() in kernel/sched/pelt.c).
  *
  * [load_avg definition]
  *
@@ -367,6 +367,14 @@ struct util_est {
  * For cfs_rq, it is the aggregated load_avg of all runnable and
  * blocked sched_entities.
  *
+ * [runnable_avg definition]
+ *
+ *   runnable_avg = runnable%
+ *
+ * where runnable% is the time ratio that a sched_entity is runnable.
+ * For cfs_rq, it is the aggregated runnable_avg of all runnable and
+ * blocked sched_entities.
+ *
  * [util_avg definition]
  *
  *   util_avg = running% * SCHED_CAPACITY_SCALE
@@ -401,11 +409,11 @@ struct util_est {
 struct sched_avg {
 	u64				last_update_time;
 	u64				load_sum;
-	u64				runnable_load_sum;
+	u64				runnable_sum;
 	u32				util_sum;
 	u32				period_contrib;
 	unsigned long			load_avg;
-	unsigned long			runnable_load_avg;
+	unsigned long			runnable_avg;
 	unsigned long			util_avg;
 	struct util_est			util_est;
 } ____cacheline_aligned;
@@ -449,7 +457,6 @@ struct sched_statistics {
 struct sched_entity {
 	/* For load-balancing: */
 	struct load_weight		load;
-	unsigned long			runnable_weight;
 	struct rb_node			run_node;
 	struct list_head		group_node;
 	unsigned int			on_rq;
@@ -470,6 +477,8 @@ struct sched_entity {
 	struct cfs_rq			*cfs_rq;
 	/* rq "owned" by this entity/group: */
 	struct cfs_rq			*my_q;
+	/* cached value of my_q->h_nr_running */
+	unsigned long			runnable_weight;
 #endif
 
 #ifdef CONFIG_SMP
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e94819d573be..8e6f38073ab3 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -761,7 +761,6 @@ static void set_load_weight(struct task_struct *p, bool update_load)
 	if (task_has_idle_policy(p)) {
 		load->weight = scale_load(WEIGHT_IDLEPRIO);
 		load->inv_weight = WMULT_IDLEPRIO;
-		p->se.runnable_weight = load->weight;
 		return;
 	}
 
@@ -774,7 +773,6 @@ static void set_load_weight(struct task_struct *p, bool update_load)
 	} else {
 		load->weight = scale_load(sched_prio_to_weight[prio]);
 		load->inv_weight = sched_prio_to_wmult[prio];
-		p->se.runnable_weight = load->weight;
 	}
 }
 
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 879d3ccf3806..8331bc04aea2 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -402,11 +402,10 @@ static void print_cfs_group_stats(struct seq_file *m, int cpu, struct task_group
 	}
 
 	P(se->load.weight);
-	P(se->runnable_weight);
 #ifdef CONFIG_SMP
 	P(se->avg.load_avg);
 	P(se->avg.util_avg);
-	P(se->avg.runnable_load_avg);
+	P(se->avg.runnable_avg);
 #endif
 
 #undef PN_SCHEDSTAT
@@ -524,11 +523,10 @@ void print_cfs_rq(struct seq_file *m, int cpu, struct cfs_rq *cfs_rq)
 	SEQ_printf(m, "  .%-30s: %d\n", "nr_running", cfs_rq->nr_running);
 	SEQ_printf(m, "  .%-30s: %ld\n", "load", cfs_rq->load.weight);
 #ifdef CONFIG_SMP
-	SEQ_printf(m, "  .%-30s: %ld\n", "runnable_weight", cfs_rq->runnable_weight);
 	SEQ_printf(m, "  .%-30s: %lu\n", "load_avg",
 			cfs_rq->avg.load_avg);
-	SEQ_printf(m, "  .%-30s: %lu\n", "runnable_load_avg",
-			cfs_rq->avg.runnable_load_avg);
+	SEQ_printf(m, "  .%-30s: %lu\n", "runnable_avg",
+			cfs_rq->avg.runnable_avg);
 	SEQ_printf(m, "  .%-30s: %lu\n", "util_avg",
 			cfs_rq->avg.util_avg);
 	SEQ_printf(m, "  .%-30s: %u\n", "util_est_enqueued",
@@ -537,8 +535,8 @@ void print_cfs_rq(struct seq_file *m, int cpu, struct cfs_rq *cfs_rq)
 			cfs_rq->removed.load_avg);
 	SEQ_printf(m, "  .%-30s: %ld\n", "removed.util_avg",
 			cfs_rq->removed.util_avg);
-	SEQ_printf(m, "  .%-30s: %ld\n", "removed.runnable_sum",
-			cfs_rq->removed.runnable_sum);
+	SEQ_printf(m, "  .%-30s: %ld\n", "removed.runnable_avg",
+			cfs_rq->removed.runnable_avg);
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	SEQ_printf(m, "  .%-30s: %lu\n", "tg_load_avg_contrib",
 			cfs_rq->tg_load_avg_contrib);
@@ -947,13 +945,12 @@ void proc_sched_show_task(struct task_struct *p, struct pid_namespace *ns,
 		   "nr_involuntary_switches", (long long)p->nivcsw);
 
 	P(se.load.weight);
-	P(se.runnable_weight);
 #ifdef CONFIG_SMP
 	P(se.avg.load_sum);
-	P(se.avg.runnable_load_sum);
+	P(se.avg.runnable_sum);
 	P(se.avg.util_sum);
 	P(se.avg.load_avg);
-	P(se.avg.runnable_load_avg);
+	P(se.avg.runnable_avg);
 	P(se.avg.util_avg);
 	P(se.avg.last_update_time);
 	P(se.avg.util_est.ewma);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ae7870f71457..470afbb3e303 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -740,10 +740,10 @@ void init_entity_runnable_average(struct sched_entity *se)
 	 * Group entities are initialized with zero load to reflect the fact that
 	 * nothing has been attached to the task group yet.
 	 */
-	if (entity_is_task(se))
-		sa->runnable_load_avg = sa->load_avg = scale_load_down(se->load.weight);
-
-	se->runnable_weight = se->load.weight;
+	if (entity_is_task(se)) {
+		sa->runnable_avg = SCHED_CAPACITY_SCALE;
+		sa->load_avg = scale_load_down(se->load.weight);
+	}
 
 	/* when this task enqueue'ed, it will contribute to its cfs_rq's load_avg */
 }
@@ -2893,25 +2893,6 @@ account_entity_dequeue(struct cfs_rq *cfs_rq, struct sched_entity *se)
 } while (0)
 
 #ifdef CONFIG_SMP
-static inline void
-enqueue_runnable_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se)
-{
-	cfs_rq->runnable_weight += se->runnable_weight;
-
-	cfs_rq->avg.runnable_load_avg += se->avg.runnable_load_avg;
-	cfs_rq->avg.runnable_load_sum += se_runnable(se) * se->avg.runnable_load_sum;
-}
-
-static inline void
-dequeue_runnable_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se)
-{
-	cfs_rq->runnable_weight -= se->runnable_weight;
-
-	sub_positive(&cfs_rq->avg.runnable_load_avg, se->avg.runnable_load_avg);
-	sub_positive(&cfs_rq->avg.runnable_load_sum,
-		     se_runnable(se) * se->avg.runnable_load_sum);
-}
-
 static inline void
 enqueue_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
@@ -2927,28 +2908,22 @@ dequeue_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se)
 }
 #else
 static inline void
-enqueue_runnable_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se) { }
-static inline void
-dequeue_runnable_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se) { }
-static inline void
 enqueue_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se) { }
 static inline void
 dequeue_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se) { }
 #endif
 
 static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
-			    unsigned long weight, unsigned long runnable)
+			    unsigned long weight)
 {
 	if (se->on_rq) {
 		/* commit outstanding execution time */
 		if (cfs_rq->curr == se)
 			update_curr(cfs_rq);
 		account_entity_dequeue(cfs_rq, se);
-		dequeue_runnable_load_avg(cfs_rq, se);
 	}
 	dequeue_load_avg(cfs_rq, se);
 
-	se->runnable_weight = runnable;
 	update_load_set(&se->load, weight);
 
 #ifdef CONFIG_SMP
@@ -2956,15 +2931,12 @@ static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
 		u32 divider = LOAD_AVG_MAX - 1024 + se->avg.period_contrib;
 
 		se->avg.load_avg = div_u64(se_weight(se) * se->avg.load_sum, divider);
-		se->avg.runnable_load_avg =
-			div_u64(se_runnable(se) * se->avg.runnable_load_sum, divider);
 	} while (0);
 #endif
 
 	enqueue_load_avg(cfs_rq, se);
 	if (se->on_rq) {
 		account_entity_enqueue(cfs_rq, se);
-		enqueue_runnable_load_avg(cfs_rq, se);
 	}
 }
 
@@ -2975,7 +2947,7 @@ void reweight_task(struct task_struct *p, int prio)
 	struct load_weight *load = &se->load;
 	unsigned long weight = scale_load(sched_prio_to_weight[prio]);
 
-	reweight_entity(cfs_rq, se, weight, weight);
+	reweight_entity(cfs_rq, se, weight);
 	load->inv_weight = sched_prio_to_wmult[prio];
 }
 
@@ -3087,50 +3059,6 @@ static long calc_group_shares(struct cfs_rq *cfs_rq)
 	 */
 	return clamp_t(long, shares, MIN_SHARES, tg_shares);
 }
-
-/*
- * This calculates the effective runnable weight for a group entity based on
- * the group entity weight calculated above.
- *
- * Because of the above approximation (2), our group entity weight is
- * an load_avg based ratio (3). This means that it includes blocked load and
- * does not represent the runnable weight.
- *
- * Approximate the group entity's runnable weight per ratio from the group
- * runqueue:
- *
- *					     grq->avg.runnable_load_avg
- *   ge->runnable_weight = ge->load.weight * -------------------------- (7)
- *						 grq->avg.load_avg
- *
- * However, analogous to above, since the avg numbers are slow, this leads to
- * transients in the from-idle case. Instead we use:
- *
- *   ge->runnable_weight = ge->load.weight *
- *
- *		max(grq->avg.runnable_load_avg, grq->runnable_weight)
- *		-----------------------------------------------------	(8)
- *		      max(grq->avg.load_avg, grq->load.weight)
- *
- * Where these max() serve both to use the 'instant' values to fix the slow
- * from-idle and avoid the /0 on to-idle, similar to (6).
- */
-static long calc_group_runnable(struct cfs_rq *cfs_rq, long shares)
-{
-	long runnable, load_avg;
-
-	load_avg = max(cfs_rq->avg.load_avg,
-		       scale_load_down(cfs_rq->load.weight));
-
-	runnable = max(cfs_rq->avg.runnable_load_avg,
-		       scale_load_down(cfs_rq->runnable_weight));
-
-	runnable *= shares;
-	if (load_avg)
-		runnable /= load_avg;
-
-	return clamp_t(long, runnable, MIN_SHARES, shares);
-}
 #endif /* CONFIG_SMP */
 
 static inline int throttled_hierarchy(struct cfs_rq *cfs_rq);
@@ -3142,7 +3070,7 @@ static inline int throttled_hierarchy(struct cfs_rq *cfs_rq);
 static void update_cfs_group(struct sched_entity *se)
 {
 	struct cfs_rq *gcfs_rq = group_cfs_rq(se);
-	long shares, runnable;
+	long shares;
 
 	if (!gcfs_rq)
 		return;
@@ -3151,16 +3079,15 @@ static void update_cfs_group(struct sched_entity *se)
 		return;
 
 #ifndef CONFIG_SMP
-	runnable = shares = READ_ONCE(gcfs_rq->tg->shares);
+	shares = READ_ONCE(gcfs_rq->tg->shares);
 
 	if (likely(se->load.weight == shares))
 		return;
 #else
 	shares   = calc_group_shares(gcfs_rq);
-	runnable = calc_group_runnable(gcfs_rq, shares);
 #endif
 
-	reweight_entity(cfs_rq_of(se), se, shares, runnable);
+	reweight_entity(cfs_rq_of(se), se, shares);
 }
 
 #else /* CONFIG_FAIR_GROUP_SCHED */
@@ -3285,11 +3212,11 @@ void set_task_rq_fair(struct sched_entity *se,
  * _IFF_ we look at the pure running and runnable sums. Because they
  * represent the very same entity, just at different points in the hierarchy.
  *
- * Per the above update_tg_cfs_util() is trivial and simply copies the running
- * sum over (but still wrong, because the group entity and group rq do not have
- * their PELT windows aligned).
+ * Per the above update_tg_cfs_util() and update_tg_cfs_runnable() are trivial
+ * and simply copies the running/runnable sum over (but still wrong, because
+ * the group entity and group rq do not have their PELT windows aligned).
  *
- * However, update_tg_cfs_runnable() is more complex. So we have:
+ * However, update_tg_cfs_load() is more complex. So we have:
  *
  *   ge->avg.load_avg = ge->load.weight * ge->avg.runnable_avg		(2)
  *
@@ -3371,10 +3298,36 @@ update_tg_cfs_util(struct cfs_rq *cfs_rq, struct sched_entity *se, struct cfs_rq
 
 static inline void
 update_tg_cfs_runnable(struct cfs_rq *cfs_rq, struct sched_entity *se, struct cfs_rq *gcfs_rq)
+{
+	long delta = gcfs_rq->avg.runnable_avg - se->avg.runnable_avg;
+
+	/* Nothing to update */
+	if (!delta)
+		return;
+
+	/*
+	 * The relation between sum and avg is:
+	 *
+	 *   LOAD_AVG_MAX - 1024 + sa->period_contrib
+	 *
+	 * however, the PELT windows are not aligned between grq and gse.
+	 */
+
+	/* Set new sched_entity's runnable */
+	se->avg.runnable_avg = gcfs_rq->avg.runnable_avg;
+	se->avg.runnable_sum = se->avg.runnable_avg * LOAD_AVG_MAX;
+
+	/* Update parent cfs_rq runnable */
+	add_positive(&cfs_rq->avg.runnable_avg, delta);
+	cfs_rq->avg.runnable_sum = cfs_rq->avg.runnable_avg * LOAD_AVG_MAX;
+}
+
+static inline void
+update_tg_cfs_load(struct cfs_rq *cfs_rq, struct sched_entity *se, struct cfs_rq *gcfs_rq)
 {
 	long delta_avg, running_sum, runnable_sum = gcfs_rq->prop_runnable_sum;
-	unsigned long runnable_load_avg, load_avg;
-	u64 runnable_load_sum, load_sum = 0;
+	unsigned long load_avg;
+	u64 load_sum = 0;
 	s64 delta_sum;
 
 	if (!runnable_sum)
@@ -3422,20 +3375,6 @@ update_tg_cfs_runnable(struct cfs_rq *cfs_rq, struct sched_entity *se, struct cf
 	se->avg.load_avg = load_avg;
 	add_positive(&cfs_rq->avg.load_avg, delta_avg);
 	add_positive(&cfs_rq->avg.load_sum, delta_sum);
-
-	runnable_load_sum = (s64)se_runnable(se) * runnable_sum;
-	runnable_load_avg = div_s64(runnable_load_sum, LOAD_AVG_MAX);
-
-	if (se->on_rq) {
-		delta_sum = runnable_load_sum -
-				se_weight(se) * se->avg.runnable_load_sum;
-		delta_avg = runnable_load_avg - se->avg.runnable_load_avg;
-		add_positive(&cfs_rq->avg.runnable_load_avg, delta_avg);
-		add_positive(&cfs_rq->avg.runnable_load_sum, delta_sum);
-	}
-
-	se->avg.runnable_load_sum = runnable_sum;
-	se->avg.runnable_load_avg = runnable_load_avg;
 }
 
 static inline void add_tg_cfs_propagate(struct cfs_rq *cfs_rq, long runnable_sum)
@@ -3464,6 +3403,7 @@ static inline int propagate_entity_load_avg(struct sched_entity *se)
 
 	update_tg_cfs_util(cfs_rq, se, gcfs_rq);
 	update_tg_cfs_runnable(cfs_rq, se, gcfs_rq);
+	update_tg_cfs_load(cfs_rq, se, gcfs_rq);
 
 	trace_pelt_cfs_tp(cfs_rq);
 	trace_pelt_se_tp(se);
@@ -3533,7 +3473,7 @@ static inline void add_tg_cfs_propagate(struct cfs_rq *cfs_rq, long runnable_sum
 static inline int
 update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
 {
-	unsigned long removed_load = 0, removed_util = 0, removed_runnable_sum = 0;
+	unsigned long removed_load = 0, removed_util = 0, removed_runnable = 0;
 	struct sched_avg *sa = &cfs_rq->avg;
 	int decayed = 0;
 
@@ -3544,7 +3484,7 @@ update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
 		raw_spin_lock(&cfs_rq->removed.lock);
 		swap(cfs_rq->removed.util_avg, removed_util);
 		swap(cfs_rq->removed.load_avg, removed_load);
-		swap(cfs_rq->removed.runnable_sum, removed_runnable_sum);
+		swap(cfs_rq->removed.runnable_avg, removed_runnable);
 		cfs_rq->removed.nr = 0;
 		raw_spin_unlock(&cfs_rq->removed.lock);
 
@@ -3556,7 +3496,16 @@ update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
 		sub_positive(&sa->util_avg, r);
 		sub_positive(&sa->util_sum, r * divider);
 
-		add_tg_cfs_propagate(cfs_rq, -(long)removed_runnable_sum);
+		r = removed_runnable;
+		sub_positive(&sa->runnable_avg, r);
+		sub_positive(&sa->runnable_sum, r * divider);
+
+		/*
+		 * removed_runnable is the unweighted version of removed_load so we
+		 * can use it to estimate removed_load_sum.
+		 */
+		add_tg_cfs_propagate(cfs_rq,
+			-(long)(removed_runnable * divider) >> SCHED_CAPACITY_SHIFT);
 
 		decayed = 1;
 	}
@@ -3602,17 +3551,19 @@ static void attach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
 	 */
 	se->avg.util_sum = se->avg.util_avg * divider;
 
+	se->avg.runnable_sum = se->avg.runnable_avg * divider;
+
 	se->avg.load_sum = divider;
 	if (se_weight(se)) {
 		se->avg.load_sum =
 			div_u64(se->avg.load_avg * se->avg.load_sum, se_weight(se));
 	}
 
-	se->avg.runnable_load_sum = se->avg.load_sum;
-
 	enqueue_load_avg(cfs_rq, se);
 	cfs_rq->avg.util_avg += se->avg.util_avg;
 	cfs_rq->avg.util_sum += se->avg.util_sum;
+	cfs_rq->avg.runnable_avg += se->avg.runnable_avg;
+	cfs_rq->avg.runnable_sum += se->avg.runnable_sum;
 
 	add_tg_cfs_propagate(cfs_rq, se->avg.load_sum);
 
@@ -3634,6 +3585,8 @@ static void detach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
 	dequeue_load_avg(cfs_rq, se);
 	sub_positive(&cfs_rq->avg.util_avg, se->avg.util_avg);
 	sub_positive(&cfs_rq->avg.util_sum, se->avg.util_sum);
+	sub_positive(&cfs_rq->avg.runnable_avg, se->avg.runnable_avg);
+	sub_positive(&cfs_rq->avg.runnable_sum, se->avg.runnable_sum);
 
 	add_tg_cfs_propagate(cfs_rq, -se->avg.load_sum);
 
@@ -3740,13 +3693,13 @@ static void remove_entity_load_avg(struct sched_entity *se)
 	++cfs_rq->removed.nr;
 	cfs_rq->removed.util_avg	+= se->avg.util_avg;
 	cfs_rq->removed.load_avg	+= se->avg.load_avg;
-	cfs_rq->removed.runnable_sum	+= se->avg.load_sum; /* == runnable_sum */
+	cfs_rq->removed.runnable_avg	+= se->avg.runnable_avg;
 	raw_spin_unlock_irqrestore(&cfs_rq->removed.lock, flags);
 }
 
-static inline unsigned long cfs_rq_runnable_load_avg(struct cfs_rq *cfs_rq)
+static inline unsigned long cfs_rq_runnable_avg(struct cfs_rq *cfs_rq)
 {
-	return cfs_rq->avg.runnable_load_avg;
+	return cfs_rq->avg.runnable_avg;
 }
 
 static inline unsigned long cfs_rq_load_avg(struct cfs_rq *cfs_rq)
@@ -4081,8 +4034,8 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	 *   - Add its new weight to cfs_rq->load.weight
 	 */
 	update_load_avg(cfs_rq, se, UPDATE_TG | DO_ATTACH);
+	se_update_runnable(se);
 	update_cfs_group(se);
-	enqueue_runnable_load_avg(cfs_rq, se);
 	account_entity_enqueue(cfs_rq, se);
 
 	if (flags & ENQUEUE_WAKEUP)
@@ -4165,7 +4118,7 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	 *     of its group cfs_rq.
 	 */
 	update_load_avg(cfs_rq, se, UPDATE_TG);
-	dequeue_runnable_load_avg(cfs_rq, se);
+	se_update_runnable(se);
 
 	update_stats_dequeue(cfs_rq, se, flags);
 
@@ -5336,6 +5289,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 			goto enqueue_throttle;
 
 		update_load_avg(cfs_rq, se, UPDATE_TG);
+		se_update_runnable(se);
 		update_cfs_group(se);
 
 		cfs_rq->h_nr_running++;
@@ -5433,6 +5387,7 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 			goto dequeue_throttle;
 
 		update_load_avg(cfs_rq, se, UPDATE_TG);
+		se_update_runnable(se);
 		update_cfs_group(se);
 
 		cfs_rq->h_nr_running--;
@@ -7650,7 +7605,7 @@ static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
 	if (cfs_rq->avg.util_sum)
 		return false;
 
-	if (cfs_rq->avg.runnable_load_sum)
+	if (cfs_rq->avg.runnable_sum)
 		return false;
 
 	return true;
diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
index bd006b79b360..d6ec21450ffa 100644
--- a/kernel/sched/pelt.c
+++ b/kernel/sched/pelt.c
@@ -121,8 +121,8 @@ accumulate_sum(u64 delta, struct sched_avg *sa,
 	 */
 	if (periods) {
 		sa->load_sum = decay_load(sa->load_sum, periods);
-		sa->runnable_load_sum =
-			decay_load(sa->runnable_load_sum, periods);
+		sa->runnable_sum =
+			decay_load(sa->runnable_sum, periods);
 		sa->util_sum = decay_load((u64)(sa->util_sum), periods);
 
 		/*
@@ -149,7 +149,7 @@ accumulate_sum(u64 delta, struct sched_avg *sa,
 	if (load)
 		sa->load_sum += load * contrib;
 	if (runnable)
-		sa->runnable_load_sum += runnable * contrib;
+		sa->runnable_sum += runnable * contrib << SCHED_CAPACITY_SHIFT;
 	if (running)
 		sa->util_sum += contrib << SCHED_CAPACITY_SHIFT;
 
@@ -246,7 +246,7 @@ ___update_load_avg(struct sched_avg *sa, unsigned long load, unsigned long runna
 	 * Step 2: update *_avg.
 	 */
 	sa->load_avg = div_u64(load * sa->load_sum, divider);
-	sa->runnable_load_avg =	div_u64(runnable * sa->runnable_load_sum, divider);
+	sa->runnable_avg =	div_u64(runnable * sa->runnable_sum, divider);
 	WRITE_ONCE(sa->util_avg, sa->util_sum / divider);
 }
 
@@ -254,33 +254,34 @@ ___update_load_avg(struct sched_avg *sa, unsigned long load, unsigned long runna
  * sched_entity:
  *
  *   task:
- *     se_runnable() == se_weight()
+ *     se_weight()   = se->load.weight
+ *     se_runnable() = !!on_rq
  *
  *   group: [ see update_cfs_group() ]
  *     se_weight()   = tg->weight * grq->load_avg / tg->load_avg
- *     se_runnable() = se_weight(se) * grq->runnable_load_avg / grq->load_avg
+ *     se_runnable() = grq->h_nr_running
  *
- *   load_sum := runnable_sum
- *   load_avg = se_weight(se) * runnable_avg
+ *   runnable_sum = se_runnable() * runnable = grq->runnable_sum
+ *   runnable_avg = runnable_sum
  *
- *   runnable_load_sum := runnable_sum
- *   runnable_load_avg = se_runnable(se) * runnable_avg
+ *   load_sum := runnable
+ *   load_avg = se_weight(se) * load_sum
  *
  * XXX collapse load_sum and runnable_load_sum
  *
  * cfq_rq:
  *
+ *   runnable_sum = \Sum se->avg.runnable_sum
+ *   runnable_avg = \Sum se->avg.runnable_avg
+ *
  *   load_sum = \Sum se_weight(se) * se->avg.load_sum
  *   load_avg = \Sum se->avg.load_avg
- *
- *   runnable_load_sum = \Sum se_runnable(se) * se->avg.runnable_load_sum
- *   runnable_load_avg = \Sum se->avg.runable_load_avg
  */
 
 int __update_load_avg_blocked_se(u64 now, struct sched_entity *se)
 {
 	if (___update_load_sum(now, &se->avg, 0, 0, 0)) {
-		___update_load_avg(&se->avg, se_weight(se), se_runnable(se));
+		___update_load_avg(&se->avg, se_weight(se), 1);
 		trace_pelt_se_tp(se);
 		return 1;
 	}
@@ -290,10 +291,10 @@ int __update_load_avg_blocked_se(u64 now, struct sched_entity *se)
 
 int __update_load_avg_se(u64 now, struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
-	if (___update_load_sum(now, &se->avg, !!se->on_rq, !!se->on_rq,
+	if (___update_load_sum(now, &se->avg, !!se->on_rq, se_runnable(se),
 				cfs_rq->curr == se)) {
 
-		___update_load_avg(&se->avg, se_weight(se), se_runnable(se));
+		___update_load_avg(&se->avg, se_weight(se), 1);
 		cfs_se_util_change(&se->avg);
 		trace_pelt_se_tp(se);
 		return 1;
@@ -306,7 +307,7 @@ int __update_load_avg_cfs_rq(u64 now, struct cfs_rq *cfs_rq)
 {
 	if (___update_load_sum(now, &cfs_rq->avg,
 				scale_load_down(cfs_rq->load.weight),
-				scale_load_down(cfs_rq->runnable_weight),
+				cfs_rq->h_nr_running,
 				cfs_rq->curr != NULL)) {
 
 		___update_load_avg(&cfs_rq->avg, 1, 1);
@@ -322,7 +323,7 @@ int __update_load_avg_cfs_rq(u64 now, struct cfs_rq *cfs_rq)
  *
  *   util_sum = \Sum se->avg.util_sum but se->avg.util_sum is not tracked
  *   util_sum = cpu_scale * load_sum
- *   runnable_load_sum = load_sum
+ *   runnable_sum = util_sum
  *
  *   load_avg and runnable_load_avg are not supported and meaningless.
  *
@@ -348,7 +349,9 @@ int update_rt_rq_load_avg(u64 now, struct rq *rq, int running)
  *
  *   util_sum = \Sum se->avg.util_sum but se->avg.util_sum is not tracked
  *   util_sum = cpu_scale * load_sum
- *   runnable_load_sum = load_sum
+ *   runnable_sum = util_sum
+ *
+ *   load_avg and runnable_load_avg are not supported and meaningless.
  *
  */
 
@@ -373,7 +376,9 @@ int update_dl_rq_load_avg(u64 now, struct rq *rq, int running)
  *
  *   util_sum = \Sum se->avg.util_sum but se->avg.util_sum is not tracked
  *   util_sum = cpu_scale * load_sum
- *   runnable_load_sum = load_sum
+ *   runnable_sum = util_sum
+ *
+ *   load_avg and runnable_load_avg are not supported and meaningless.
  *
  */
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 2be96f9e5b1e..5f6f5de03764 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -489,7 +489,6 @@ struct cfs_bandwidth { };
 /* CFS-related fields in a runqueue */
 struct cfs_rq {
 	struct load_weight	load;
-	unsigned long		runnable_weight;
 	unsigned int		nr_running;
 	unsigned int		h_nr_running;      /* SCHED_{NORMAL,BATCH,IDLE} */
 	unsigned int		idle_h_nr_running; /* SCHED_IDLE */
@@ -528,7 +527,7 @@ struct cfs_rq {
 		int		nr;
 		unsigned long	load_avg;
 		unsigned long	util_avg;
-		unsigned long	runnable_sum;
+		unsigned long	runnable_avg;
 	} removed;
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
@@ -688,8 +687,30 @@ struct dl_rq {
 #ifdef CONFIG_FAIR_GROUP_SCHED
 /* An entity is a task if it doesn't "own" a runqueue */
 #define entity_is_task(se)	(!se->my_q)
+
+static inline void se_update_runnable(struct sched_entity *se)
+{
+	if (!entity_is_task(se))
+		se->runnable_weight = se->my_q->h_nr_running;
+}
+
+static inline long se_runnable(struct sched_entity *se)
+{
+	if (entity_is_task(se))
+		return !!se->on_rq;
+	else
+		return se->runnable_weight;
+}
+
 #else
 #define entity_is_task(se)	1
+
+static inline void se_update_runnable(struct sched_entity *se) {}
+
+static inline long se_runnable(struct sched_entity *se)
+{
+	return !!se->on_rq;
+}
 #endif
 
 #ifdef CONFIG_SMP
@@ -701,10 +722,6 @@ static inline long se_weight(struct sched_entity *se)
 	return scale_load_down(se->load.weight);
 }
 
-static inline long se_runnable(struct sched_entity *se)
-{
-	return scale_load_down(se->runnable_weight);
-}
 
 static inline bool sched_asym_prefer(int a, int b)
 {
-- 
2.16.4

