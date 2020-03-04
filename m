Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6D3DC3F2D7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 17:00:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D3B824654
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 17:00:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="NcxDjuk/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388457AbgCDRAq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 12:00:46 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:41230 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388332AbgCDRAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 12:00:15 -0500
Received: by mail-qk1-f196.google.com with SMTP id b5so2310316qkh.8
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 09:00:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=jGv9ehZ0NVD60rqSzmgf7v+bYqgzxwsgEpPabyNKMAw=;
        b=NcxDjuk/g9I749CnW+w+veoxyGrc0CoEdU61iSKKPm96qYJ0qQljkN2LzG4uPaaYc4
         aibQ/5t9aWL1qLulncGHkGxjf/rCmcIsrYINZFa0866BfQYTqOkB+z7ZqIB56NeVlP+Q
         lhubpHY9xMigfmdQC0yXd4bo2/5YEIDz4ON8A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=jGv9ehZ0NVD60rqSzmgf7v+bYqgzxwsgEpPabyNKMAw=;
        b=PaO4D8KM3cMdVxwSfkmMA2zCntqpoqDrODHaMRGgkxo54BJzmEbx0liFwgyJS1RHmb
         S+YvayVyqtEx0/lw186QXZ7W+b/b7GPad5X5wRswxvpRmq+TFnkjgDauT0F7t+mc9s9P
         7H/HVhlGxkV3pkpo96u4791OHG3IodGT8nKwvtqTWLKQoZZP5UTlsSjHAAL/Yowce9Ut
         MXO/ELfod5cAGAEAIb+yTkDO42INIKvI+FjGcOOnJo6EIdb15lPY7sBnE2DNWSJtVfpv
         UZk27U3Yz16aiZlhjbd4km+fiCP4qrrBQIKTdND1l4HGdL7bW2E0A6mirVYSDnlzrR+D
         R8bw==
X-Gm-Message-State: ANhLgQ1HK+RxXNIXk89n7SqzgdxINl0bNhIKI6SZ6ws3uL6fy+1Pvvl+
        M7mLvFMtH4MoUJFqVI2w2f3Eow==
X-Google-Smtp-Source: ADFU+vuz4qmnWQrqWeBlMtOtIO13/QfYLCdJ8P+WphTCk7ZjYr201cqDFrVAb3PIWPloYoCu+rseTg==
X-Received: by 2002:a37:5943:: with SMTP id n64mr3693192qkb.411.1583341214471;
        Wed, 04 Mar 2020 09:00:14 -0800 (PST)
Received: from s2r5node9 ([162.243.188.99])
        by smtp.gmail.com with ESMTPSA id 11sm13848616qko.76.2020.03.04.09.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 09:00:14 -0800 (PST)
From:   vpillai <vpillai@digitalocean.com>
To:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, fweisbec@gmail.com,
        keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>, Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>, aubrey.li@linux.intel.com,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joel Fernandes <joelaf@google.com>, joel@joelfernandes.org,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Aaron Lu <aaron.lu@linux.alibaba.com>
Subject: [RFC PATCH 07/13] sched: Add core wide task selection and scheduling.
Date:   Wed,  4 Mar 2020 16:59:57 +0000
Message-Id: <e942da7fd881977923463f19648085c1bfaa37f8.1583332765.git.vpillai@digitalocean.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1583332764.git.vpillai@digitalocean.com>
References: <cover.1583332764.git.vpillai@digitalocean.com>
In-Reply-To: <cover.1583332764.git.vpillai@digitalocean.com>
References: <cover.1583332764.git.vpillai@digitalocean.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

Instead of only selecting a local task, select a task for all SMT
siblings for every reschedule on the core (irrespective which logical
CPU does the reschedule).

There could be races in core scheduler where a CPU is trying to pick
a task for its sibling in core scheduler, when that CPU has just been
offlined.  We should not schedule any tasks on the CPU in this case.
Return an idle task in pick_next_task for this situation.

NOTE: there is still potential for siblings rivalry.
NOTE: this is far too complicated; but thus far I've failed to
      simplify it further.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Julien Desfossez <jdesfossez@digitalocean.com>
Signed-off-by: Vineeth Remanan Pillai <vpillai@digitalocean.com>
Signed-off-by: Aaron Lu <aaron.lu@linux.alibaba.com>
Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 kernel/sched/core.c  | 274 ++++++++++++++++++++++++++++++++++++++++++-
 kernel/sched/fair.c  |  40 +++++++
 kernel/sched/sched.h |   6 +-
 3 files changed, 318 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 445f0d519336..9a1bd236044e 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4253,7 +4253,7 @@ static inline void schedule_debug(struct task_struct *prev, bool preempt)
  * Pick up the highest-prio task:
  */
 static inline struct task_struct *
-pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
+__pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 {
 	const struct sched_class *class;
 	struct task_struct *p;
@@ -4309,6 +4309,273 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 	BUG();
 }
 
+#ifdef CONFIG_SCHED_CORE
+
+static inline bool cookie_equals(struct task_struct *a, unsigned long cookie)
+{
+	return is_idle_task(a) || (a->core_cookie == cookie);
+}
+
+static inline bool cookie_match(struct task_struct *a, struct task_struct *b)
+{
+	if (is_idle_task(a) || is_idle_task(b))
+		return true;
+
+	return a->core_cookie == b->core_cookie;
+}
+
+// XXX fairness/fwd progress conditions
+/*
+ * Returns
+ * - NULL if there is no runnable task for this class.
+ * - the highest priority task for this runqueue if it matches
+ *   rq->core->core_cookie or its priority is greater than max.
+ * - Else returns idle_task.
+ */
+static struct task_struct *
+pick_task(struct rq *rq, const struct sched_class *class, struct task_struct *max)
+{
+	struct task_struct *class_pick, *cookie_pick;
+	unsigned long cookie = rq->core->core_cookie;
+
+	class_pick = class->pick_task(rq);
+	if (!class_pick)
+		return NULL;
+
+	if (!cookie) {
+		/*
+		 * If class_pick is tagged, return it only if it has
+		 * higher priority than max.
+		 */
+		if (max && class_pick->core_cookie &&
+		    prio_less(class_pick, max))
+			return idle_sched_class.pick_task(rq);
+
+		return class_pick;
+	}
+
+	/*
+	 * If class_pick is idle or matches cookie, return early.
+	 */
+	if (cookie_equals(class_pick, cookie))
+		return class_pick;
+
+	cookie_pick = sched_core_find(rq, cookie);
+
+	/*
+	 * If class > max && class > cookie, it is the highest priority task on
+	 * the core (so far) and it must be selected, otherwise we must go with
+	 * the cookie pick in order to satisfy the constraint.
+	 */
+	if (prio_less(cookie_pick, class_pick) &&
+	    (!max || prio_less(max, class_pick)))
+		return class_pick;
+
+	return cookie_pick;
+}
+
+static struct task_struct *
+pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
+{
+	struct task_struct *next, *max = NULL;
+	const struct sched_class *class;
+	const struct cpumask *smt_mask;
+	int i, j, cpu;
+	bool need_sync = false;
+
+	cpu = cpu_of(rq);
+	if (cpu_is_offline(cpu))
+		return idle_sched_class.pick_next_task(rq);
+
+	if (!sched_core_enabled(rq))
+		return __pick_next_task(rq, prev, rf);
+
+	/*
+	 * If there were no {en,de}queues since we picked (IOW, the task
+	 * pointers are all still valid), and we haven't scheduled the last
+	 * pick yet, do so now.
+	 */
+	if (rq->core->core_pick_seq == rq->core->core_task_seq &&
+	    rq->core->core_pick_seq != rq->core_sched_seq) {
+		WRITE_ONCE(rq->core_sched_seq, rq->core->core_pick_seq);
+
+		next = rq->core_pick;
+		if (next != prev) {
+			put_prev_task(rq, prev);
+			set_next_task(rq, next);
+		}
+		return next;
+	}
+
+	prev->sched_class->put_prev_task(rq, prev);
+	if (!rq->nr_running)
+		newidle_balance(rq, rf);
+
+	smt_mask = cpu_smt_mask(cpu);
+
+	/*
+	 * core->core_task_seq, core->core_pick_seq, rq->core_sched_seq
+	 *
+	 * @task_seq guards the task state ({en,de}queues)
+	 * @pick_seq is the @task_seq we did a selection on
+	 * @sched_seq is the @pick_seq we scheduled
+	 *
+	 * However, preemptions can cause multiple picks on the same task set.
+	 * 'Fix' this by also increasing @task_seq for every pick.
+	 */
+	rq->core->core_task_seq++;
+	need_sync = !!rq->core->core_cookie;
+
+	/* reset state */
+	rq->core->core_cookie = 0UL;
+	for_each_cpu(i, smt_mask) {
+		struct rq *rq_i = cpu_rq(i);
+
+		rq_i->core_pick = NULL;
+
+		if (rq_i->core_forceidle) {
+			need_sync = true;
+			rq_i->core_forceidle = false;
+		}
+
+		if (i != cpu)
+			update_rq_clock(rq_i);
+	}
+
+	/*
+	 * Try and select tasks for each sibling in decending sched_class
+	 * order.
+	 */
+	for_each_class(class) {
+again:
+		for_each_cpu_wrap(i, smt_mask, cpu) {
+			struct rq *rq_i = cpu_rq(i);
+			struct task_struct *p;
+
+			if (cpu_is_offline(i)) {
+				rq_i->core_pick = rq_i->idle;
+				continue;
+			}
+
+			if (rq_i->core_pick)
+				continue;
+
+			/*
+			 * If this sibling doesn't yet have a suitable task to
+			 * run; ask for the most elegible task, given the
+			 * highest priority task already selected for this
+			 * core.
+			 */
+			p = pick_task(rq_i, class, max);
+			if (!p) {
+				/*
+				 * If there weren't no cookies; we don't need
+				 * to bother with the other siblings.
+				 */
+				if (i == cpu && !need_sync)
+					goto next_class;
+
+				continue;
+			}
+
+			/*
+			 * Optimize the 'normal' case where there aren't any
+			 * cookies and we don't need to sync up.
+			 */
+			if (i == cpu && !need_sync && !p->core_cookie) {
+				next = p;
+				goto done;
+			}
+
+			rq_i->core_pick = p;
+
+			/*
+			 * If this new candidate is of higher priority than the
+			 * previous; and they're incompatible; we need to wipe
+			 * the slate and start over. pick_task makes sure that
+			 * p's priority is more than max if it doesn't match
+			 * max's cookie.
+			 *
+			 * NOTE: this is a linear max-filter and is thus bounded
+			 * in execution time.
+			 */
+			if (!max || !cookie_match(max, p)) {
+				struct task_struct *old_max = max;
+
+				rq->core->core_cookie = p->core_cookie;
+				max = p;
+
+				if (old_max) {
+					for_each_cpu(j, smt_mask) {
+						if (j == i)
+							continue;
+
+						cpu_rq(j)->core_pick = NULL;
+					}
+					goto again;
+				} else {
+					/*
+					 * Once we select a task for a cpu, we
+					 * should not be doing an unconstrained
+					 * pick because it might starve a task
+					 * on a forced idle cpu.
+					 */
+					need_sync = true;
+				}
+
+			}
+		}
+next_class:;
+	}
+
+	rq->core->core_pick_seq = rq->core->core_task_seq;
+	next = rq->core_pick;
+	rq->core_sched_seq = rq->core->core_pick_seq;
+
+	/*
+	 * Reschedule siblings
+	 *
+	 * NOTE: L1TF -- at this point we're no longer running the old task and
+	 * sending an IPI (below) ensures the sibling will no longer be running
+	 * their task. This ensures there is no inter-sibling overlap between
+	 * non-matching user state.
+	 */
+	for_each_cpu(i, smt_mask) {
+		struct rq *rq_i = cpu_rq(i);
+
+		if (cpu_is_offline(i))
+			continue;
+
+		WARN_ON_ONCE(!rq_i->core_pick);
+
+		if (is_idle_task(rq_i->core_pick) && rq_i->nr_running)
+			rq_i->core_forceidle = true;
+
+		if (i == cpu)
+			continue;
+
+		if (rq_i->curr != rq_i->core_pick)
+			resched_curr(rq_i);
+
+		/* Did we break L1TF mitigation requirements? */
+		WARN_ON_ONCE(!cookie_match(next, rq_i->core_pick));
+	}
+
+done:
+	set_next_task(rq, next);
+	return next;
+}
+
+#else /* !CONFIG_SCHED_CORE */
+
+static struct task_struct *
+pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
+{
+	return __pick_next_task(rq, prev, rf);
+}
+
+#endif /* CONFIG_SCHED_CORE */
+
 /*
  * __schedule() is the main scheduler function.
  *
@@ -7074,7 +7341,12 @@ void __init sched_init(void)
 
 #ifdef CONFIG_SCHED_CORE
 		rq->core = NULL;
+		rq->core_pick = NULL;
 		rq->core_enabled = 0;
+		rq->core_tree = RB_ROOT;
+		rq->core_forceidle = false;
+
+		rq->core_cookie = 0UL;
 #endif
 	}
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a9eeef896c78..8432de767730 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4080,6 +4080,13 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 		update_min_vruntime(cfs_rq);
 }
 
+static inline bool
+__entity_slice_used(struct sched_entity *se)
+{
+	return (se->sum_exec_runtime - se->prev_sum_exec_runtime) >
+		sched_slice(cfs_rq_of(se), se);
+}
+
 /*
  * Preempt the current task with a newly woken task if needed:
  */
@@ -10285,6 +10292,34 @@ static void core_sched_deactivate_fair(struct rq *rq)
 #endif
 #endif /* CONFIG_SMP */
 
+#ifdef CONFIG_SCHED_CORE
+/*
+ * If runqueue has only one task which used up its slice and
+ * if the sibling is forced idle, then trigger schedule
+ * to give forced idle task a chance.
+ */
+static void resched_forceidle_sibling(struct rq *rq, struct sched_entity *se)
+{
+	int cpu = cpu_of(rq), sibling_cpu;
+	if (rq->cfs.nr_running > 1 || !__entity_slice_used(se))
+		return;
+
+	for_each_cpu(sibling_cpu, cpu_smt_mask(cpu)) {
+		struct rq *sibling_rq;
+		if (sibling_cpu == cpu)
+			continue;
+		if (cpu_is_offline(sibling_cpu))
+			continue;
+
+		sibling_rq = cpu_rq(sibling_cpu);
+		if (sibling_rq->core_forceidle) {
+			resched_curr(sibling_rq);
+		}
+	}
+}
+#endif
+
+
 /*
  * scheduler tick hitting a task of our scheduling class.
  *
@@ -10308,6 +10343,11 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
 
 	update_misfit_status(curr, rq);
 	update_overutilized_status(task_rq(curr));
+
+#ifdef CONFIG_SCHED_CORE
+	if (sched_core_enabled(rq))
+		resched_forceidle_sibling(rq, &curr->se);
+#endif
 }
 
 /*
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 03d502357599..a829e26fa43a 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1003,11 +1003,16 @@ struct rq {
 #ifdef CONFIG_SCHED_CORE
 	/* per rq */
 	struct rq		*core;
+	struct task_struct	*core_pick;
 	unsigned int		core_enabled;
+	unsigned int		core_sched_seq;
 	struct rb_root		core_tree;
+	bool			core_forceidle;
 
 	/* shared state */
 	unsigned int		core_task_seq;
+	unsigned int		core_pick_seq;
+	unsigned long		core_cookie;
 #endif
 };
 
@@ -1867,7 +1872,6 @@ static inline void put_prev_task(struct rq *rq, struct task_struct *prev)
 
 static inline void set_next_task(struct rq *rq, struct task_struct *next)
 {
-	WARN_ON_ONCE(rq->curr != next);
 	next->sched_class->set_next_task(rq, next, false);
 }
 
-- 
2.17.1

