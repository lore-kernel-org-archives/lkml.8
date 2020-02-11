Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA061C352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 17:47:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77C2720661
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 17:47:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Le/kV/Tx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730026AbgBKRrS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 12:47:18 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44237 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729798AbgBKRrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 12:47:12 -0500
Received: by mail-wr1-f67.google.com with SMTP id m16so13475619wrx.11
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 09:47:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YwHCz4zDyRMTOSPaO6KcteZmDV6BAYC7et408ZcRgoI=;
        b=Le/kV/TxhpGNaXUna3Ou4DEbXdF8mI19m+KPrpf5PEzSt5BQfjR7SBjvQgDC+J0JQ8
         c0FcTcIpuqYEAhnIPrx/MGFJEGhf5dDvhbkg8IxTzXs486++Ddp4CcoV4PB5bWew8/RY
         vBO4MK6ugljizMuq4hAP5rZ3ygZa3+0vX3fJFwKpdvfxTEyDMcLxKKhaBIoyY3zev+hY
         MRoaXGLIZg+Cb7iGF4+fXI6F32ofMUD8twWlU/Q5G6B5V+s1220hUL4JWOyD7aBfFwbB
         RaYk+GAX5Y5HRPa1Yb+EeyorpZPlOC8Aqo7lMlQJ4nv8l7UBnCJ2pvj+9DRmtAAv26aB
         O/Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YwHCz4zDyRMTOSPaO6KcteZmDV6BAYC7et408ZcRgoI=;
        b=tt4PYQesdd+V9Cyr/2IsdSwISfVzUZDXqm4LgTaSiheS/xOu4tk/jRy51BRKV9+WdS
         Fhq9YokPK6l8npRysle6k6WxOaMeT9/OuMY4cqbpFhbknwXQYaaJ42/FRFiCzM1qTSzJ
         AxkyB2DOihbxv0ZQ9i7kvT4fOJZMmgZTzhS0fTxD/reQmrva+xpwJwIdPPSmJivxsVbu
         0XRWQEbuv0oMtuPwOWpyUmKgvZ6FkebTkdAAhI8ji6z8vEGbHKq7C9+H43hx9YzqVae0
         luU3OB3XzEPwJ4ZTZim/meQmH5pbm3wmIujNfaCTm+YbfYAOWD6aP8dEh+2Su/q/U/Eu
         4O8g==
X-Gm-Message-State: APjAAAXBUOe65T1w8WLR8nffdzn2abRbtSCS+R4RWh8FJDD9AhDD1yDm
        zOWch5GoOW274cePwXh8JGmuVQ==
X-Google-Smtp-Source: APXvYqy0NVHIF1kY42FnIsF92Fi4M8QpNbND8lnPf6zcc4dokSiFPenoHe8N8WXZkkZ8naQD+Mh62Q==
X-Received: by 2002:a5d:4a48:: with SMTP id v8mr9620442wrs.42.1581443227923;
        Tue, 11 Feb 2020 09:47:07 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:39bd:f3e9:9eaa:e898])
        by smtp.gmail.com with ESMTPSA id s12sm6104764wrw.20.2020.02.11.09.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 09:47:06 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org
Cc:     pauld@redhat.com, parth@linux.ibm.com, valentin.schneider@arm.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [RFC 3/4] sched/fair: replace runnable load average by runnable average
Date:   Tue, 11 Feb 2020 18:46:50 +0100
Message-Id: <20200211174651.10330-4-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200211174651.10330-1-vincent.guittot@linaro.org>
References: <20200211174651.10330-1-vincent.guittot@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 include/linux/sched.h |  17 +++-
 kernel/sched/core.c   |   2 -
 kernel/sched/debug.c  |  17 ++--
 kernel/sched/fair.c   | 185 ++++++++++++++++--------------------------
 kernel/sched/pelt.c   |  45 +++++-----
 kernel/sched/sched.h  |  29 +++++--
 6 files changed, 138 insertions(+), 157 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 467d26046416..a49db03d56bc 100644
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
index 45f79bcc3146..5d1bec3d8ce7 100644
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
index 6e4c2b012c48..7d7cb207be30 100644
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
@@ -2877,25 +2877,6 @@ account_entity_dequeue(struct cfs_rq *cfs_rq, struct sched_entity *se)
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
@@ -2911,28 +2892,22 @@ dequeue_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se)
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
@@ -2940,15 +2915,12 @@ static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
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
 
@@ -2959,7 +2931,7 @@ void reweight_task(struct task_struct *p, int prio)
 	struct load_weight *load = &se->load;
 	unsigned long weight = scale_load(sched_prio_to_weight[prio]);
 
-	reweight_entity(cfs_rq, se, weight, weight);
+	reweight_entity(cfs_rq, se, weight);
 	load->inv_weight = sched_prio_to_wmult[prio];
 }
 
@@ -3071,50 +3043,6 @@ static long calc_group_shares(struct cfs_rq *cfs_rq)
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
@@ -3126,7 +3054,7 @@ static inline int throttled_hierarchy(struct cfs_rq *cfs_rq);
 static void update_cfs_group(struct sched_entity *se)
 {
 	struct cfs_rq *gcfs_rq = group_cfs_rq(se);
-	long shares, runnable;
+	long shares;
 
 	if (!gcfs_rq)
 		return;
@@ -3135,16 +3063,15 @@ static void update_cfs_group(struct sched_entity *se)
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
@@ -3269,11 +3196,11 @@ void set_task_rq_fair(struct sched_entity *se,
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
@@ -3355,10 +3282,36 @@ update_tg_cfs_util(struct cfs_rq *cfs_rq, struct sched_entity *se, struct cfs_rq
 
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
@@ -3406,20 +3359,6 @@ update_tg_cfs_runnable(struct cfs_rq *cfs_rq, struct sched_entity *se, struct cf
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
@@ -3448,6 +3387,7 @@ static inline int propagate_entity_load_avg(struct sched_entity *se)
 
 	update_tg_cfs_util(cfs_rq, se, gcfs_rq);
 	update_tg_cfs_runnable(cfs_rq, se, gcfs_rq);
+	update_tg_cfs_load(cfs_rq, se, gcfs_rq);
 
 	trace_pelt_cfs_tp(cfs_rq);
 	trace_pelt_se_tp(se);
@@ -3517,7 +3457,7 @@ static inline void add_tg_cfs_propagate(struct cfs_rq *cfs_rq, long runnable_sum
 static inline int
 update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
 {
-	unsigned long removed_load = 0, removed_util = 0, removed_runnable_sum = 0;
+	unsigned long removed_load = 0, removed_util = 0, removed_runnable = 0;
 	struct sched_avg *sa = &cfs_rq->avg;
 	int decayed = 0;
 
@@ -3528,7 +3468,7 @@ update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
 		raw_spin_lock(&cfs_rq->removed.lock);
 		swap(cfs_rq->removed.util_avg, removed_util);
 		swap(cfs_rq->removed.load_avg, removed_load);
-		swap(cfs_rq->removed.runnable_sum, removed_runnable_sum);
+		swap(cfs_rq->removed.runnable_avg, removed_runnable);
 		cfs_rq->removed.nr = 0;
 		raw_spin_unlock(&cfs_rq->removed.lock);
 
@@ -3540,7 +3480,16 @@ update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
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
@@ -3586,17 +3535,19 @@ static void attach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
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
 
@@ -3618,6 +3569,8 @@ static void detach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
 	dequeue_load_avg(cfs_rq, se);
 	sub_positive(&cfs_rq->avg.util_avg, se->avg.util_avg);
 	sub_positive(&cfs_rq->avg.util_sum, se->avg.util_sum);
+	sub_positive(&cfs_rq->avg.runnable_avg, se->avg.runnable_avg);
+	sub_positive(&cfs_rq->avg.runnable_sum, se->avg.runnable_sum);
 
 	add_tg_cfs_propagate(cfs_rq, -se->avg.load_sum);
 
@@ -3724,13 +3677,13 @@ static void remove_entity_load_avg(struct sched_entity *se)
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
@@ -4065,8 +4018,8 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	 *   - Add its new weight to cfs_rq->load.weight
 	 */
 	update_load_avg(cfs_rq, se, UPDATE_TG | DO_ATTACH);
+	se_update_runnable(se);
 	update_cfs_group(se);
-	enqueue_runnable_load_avg(cfs_rq, se);
 	account_entity_enqueue(cfs_rq, se);
 
 	if (flags & ENQUEUE_WAKEUP)
@@ -4149,7 +4102,7 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	 *     of its group cfs_rq.
 	 */
 	update_load_avg(cfs_rq, se, UPDATE_TG);
-	dequeue_runnable_load_avg(cfs_rq, se);
+	se_update_runnable(se);
 
 	update_stats_dequeue(cfs_rq, se, flags);
 
@@ -5320,6 +5273,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 			goto enqueue_throttle;
 
 		update_load_avg(cfs_rq, se, UPDATE_TG);
+		se_update_runnable(se);
 		update_cfs_group(se);
 
 		cfs_rq->h_nr_running++;
@@ -5417,6 +5371,7 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 			goto dequeue_throttle;
 
 		update_load_avg(cfs_rq, se, UPDATE_TG);
+		se_update_runnable(se);
 		update_cfs_group(se);
 
 		cfs_rq->h_nr_running--;
@@ -5489,9 +5444,9 @@ static unsigned long cpu_load_without(struct rq *rq, struct task_struct *p)
 	return load;
 }
 
-static unsigned long cpu_runnable_load(struct rq *rq)
+static unsigned long cpu_runnable(struct rq *rq)
 {
-	return cfs_rq_runnable_load_avg(&rq->cfs);
+	return cfs_rq_runnable_avg(&rq->cfs);
 }
 
 static unsigned long capacity_of(int cpu)
@@ -7597,7 +7552,7 @@ static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
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
index 0844e81964e5..9811563df9b2 100644
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
2.17.1

