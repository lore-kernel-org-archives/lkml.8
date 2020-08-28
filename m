Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77CDDC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 19:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3776820936
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 19:55:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="XGZ1eDWW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbgH1TzW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 15:55:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725979AbgH1Twg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 15:52:36 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F41C061232
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 12:52:35 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id z2so402759qtv.12
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 12:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=IOsnVEUKN5ElwjZNhYo6zlGg0sm5AN2q1j/5XIEzpus=;
        b=XGZ1eDWWk30v3tHhWjtXa+wU70kL8b93p65upIcpZFriyC+7t39zjWUgvLs6JV3oNh
         C51kGhgmvxsgbUGt9nQhoi5QLFkD2isKYkp/PlFKxh/6+w0PGDgcikSlMHUYNVU5is56
         +YZwAxgABEucHK0FtVMOiz+AJVmyRg6cD5UpM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=IOsnVEUKN5ElwjZNhYo6zlGg0sm5AN2q1j/5XIEzpus=;
        b=f8YkIg3FB08QyxNiV9wCKTnmwBjEg4P2xRauQriLocXkb68LysEjcVXKGKEo5RYf5N
         nq2pYG/XEPCCOwuIEA8zPfzDUG8L8ikoaOakwQOkTYH88YWT0ZrKE6jnTrIHPz5iARJr
         cbBpYVPvRT8DZosFdixGV64btn/4dkFUzrQO8kVuRZ0Z0THpnRyTwTzilITLUhb6MJFp
         iqyu0/ABN4TO1jvRpBaT4t3xdSs198ERJEJWPHhoXyWiPD34baLnbuv5IAosGHMdEpQq
         agJExDs/ic7OT7A09pym6klPM3iYF8DuetY4l7Gz8DalGhOijuCBc5WcMC6j/ffBfe8p
         QOcg==
X-Gm-Message-State: AOAM530GSAvV8h8xZ7HA6wbhRqU291LKNJu+DActd5+IijWDHSjIwSjz
        etNSnLl3lFsifmOXB97IqlkHrg==
X-Google-Smtp-Source: ABdhPJyVNBbq1amCg0MGS7ZMF8visUd+aCoJiUGL1sTPYuu6GwZpg/PmjKPS01LTaA7agD2W9loNrg==
X-Received: by 2002:aed:36c8:: with SMTP id f66mr3125086qtb.6.1598644354733;
        Fri, 28 Aug 2020 12:52:34 -0700 (PDT)
Received: from [192.168.1.240] (192-222-189-155.qc.cable.ebox.net. [192.222.189.155])
        by smtp.gmail.com with ESMTPSA id r34sm150885qtr.18.2020.08.28.12.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 12:52:33 -0700 (PDT)
From:   Julien Desfossez <jdesfossez@digitalocean.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Joel Fernandes <joelaf@google.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Chris Hyser <chris.hyser@oracle.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>
Cc:     mingo@kernel.org, tglx@linutronix.de, pjt@google.com,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, joel@joelfernandes.org,
        vineeth@bitbyteword.org, Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Agata Gruza <agata.gruza@intel.com>,
        Antonio Gomez Iglesias <antonio.gomez.iglesias@intel.com>,
        graf@amazon.com, konrad.wilk@oracle.com, dfaggioli@suse.com,
        rostedt@goodmis.org, derkling@google.com, benbjiang@tencent.com,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Aaron Lu <aaron.lu@linux.alibaba.com>
Subject: [RFC PATCH v7 08/23] sched: Add core wide task selection and scheduling.
Date:   Fri, 28 Aug 2020 15:51:09 -0400
Message-Id: <df3af13cc820a3c2397b85cb7de08cb6a0780e1d.1598643276.git.jdesfossez@digitalocean.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1598643276.git.jdesfossez@digitalocean.com>
References: <cover.1598643276.git.jdesfossez@digitalocean.com>
In-Reply-To: <cover.1598643276.git.jdesfossez@digitalocean.com>
References: <cover.1598643276.git.jdesfossez@digitalocean.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

Instead of only selecting a local task, select a task for all SMT
siblings for every reschedule on the core (irrespective which logical
CPU does the reschedule).

During a CPU hotplug event, schedule would be called with the hotplugged
CPU not in the cpumask. So use for_each_cpu(_wrap)_or to include the
current cpu in the task pick loop.

There are multiple loops in pick_next_task that iterate over CPUs in
smt_mask. During a hotplug event, sibling could be removed from the
smt_mask while pick_next_task is running. So we cannot trust the mask
across the different loops. This can confuse the logic. Add a retry logic
if smt_mask changes between the loops.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Julien Desfossez <jdesfossez@digitalocean.com>
Signed-off-by: Vineeth Remanan Pillai <vpillai@digitalocean.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Aaron Lu <aaron.lu@linux.alibaba.com>
Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 kernel/sched/core.c  | 284 ++++++++++++++++++++++++++++++++++++++++++-
 kernel/sched/sched.h |   6 +-
 2 files changed, 288 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index eea18956a9ef..1f480b6025cd 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4537,7 +4537,7 @@ static void put_prev_task_balance(struct rq *rq, struct task_struct *prev,
  * Pick up the highest-prio task:
  */
 static inline struct task_struct *
-pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
+__pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 {
 	const struct sched_class *class;
 	struct task_struct *p;
@@ -4577,6 +4577,283 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
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
+	int smt_weight;
+	bool need_sync;
+
+	if (!sched_core_enabled(rq))
+		return __pick_next_task(rq, prev, rf);
+
+	/*
+	 * If there were no {en,de}queues since we picked (IOW, the task
+	 * pointers are all still valid), and we haven't scheduled the last
+	 * pick yet, do so now.
+	 */
+	if (rq->core_pick_seq == rq->core->core_task_seq &&
+	    rq->core_pick_seq != rq->core_sched_seq) {
+		WRITE_ONCE(rq->core_sched_seq, rq->core_pick_seq);
+
+		next = rq->core_pick;
+		if (next != prev) {
+			put_prev_task(rq, prev);
+			set_next_task(rq, next);
+		}
+		return next;
+	}
+
+	put_prev_task_balance(rq, prev, rf);
+
+	cpu = cpu_of(rq);
+	smt_mask = cpu_smt_mask(cpu);
+
+	/*
+	 * core->core_task_seq, rq->core_pick_seq, rq->core_sched_seq
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
+retry_select:
+	smt_weight = cpumask_weight(smt_mask);
+
+	/* reset state */
+	rq->core->core_cookie = 0UL;
+	for_each_cpu_or(i, smt_mask, cpumask_of(cpu)) {
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
+		for_each_cpu_wrap_or(i, smt_mask, cpumask_of(cpu), cpu) {
+			struct rq *rq_i = cpu_rq(i);
+			struct task_struct *p;
+
+			/*
+			 * During hotplug online a sibling can be added in
+			 * the smt_mask * while we are here. If so, we would
+			 * need to restart selection by resetting all over.
+			 */
+			if (unlikely(smt_weight != cpumask_weight(smt_mask)))
+				goto retry_select;
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
+	next = rq->core_pick;
+
+	/* Something should have been selected for current CPU */
+	WARN_ON_ONCE(!next);
+
+	/*
+	 * Reschedule siblings
+	 *
+	 * NOTE: L1TF -- at this point we're no longer running the old task and
+	 * sending an IPI (below) ensures the sibling will no longer be running
+	 * their task. This ensures there is no inter-sibling overlap between
+	 * non-matching user state.
+	 */
+	for_each_cpu_or(i, smt_mask, cpumask_of(cpu)) {
+		struct rq *rq_i = cpu_rq(i);
+
+		WARN_ON_ONCE(smt_weight == cpumask_weight(smt_mask) && !rq->core_pick);
+
+		/*
+		 * During hotplug online a sibling can be added in the smt_mask
+		 * while we are here. We might have missed picking a task for it.
+		 * Ignore it now as a schedule on that sibling will correct itself.
+		 */
+		if (!rq_i->core_pick)
+			continue;
+
+		if (is_idle_task(rq_i->core_pick) && rq_i->nr_running)
+			rq_i->core_forceidle = true;
+
+		if (i == cpu)
+			continue;
+
+		if (rq_i->curr != rq_i->core_pick) {
+			WRITE_ONCE(rq_i->core_pick_seq, rq->core->core_task_seq);
+			resched_curr(rq_i);
+		}
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
@@ -7433,7 +7710,12 @@ void __init sched_init(void)
 
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
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 92e0b8679eef..def442f2c690 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1052,11 +1052,16 @@ struct rq {
 #ifdef CONFIG_SCHED_CORE
 	/* per rq */
 	struct rq		*core;
+	struct task_struct	*core_pick;
+	unsigned int		core_pick_seq;
 	unsigned int		core_enabled;
+	unsigned int		core_sched_seq;
 	struct rb_root		core_tree;
+	unsigned char		core_forceidle;
 
 	/* shared state */
 	unsigned int		core_task_seq;
+	unsigned long		core_cookie;
 #endif
 };
 
@@ -1929,7 +1934,6 @@ static inline void put_prev_task(struct rq *rq, struct task_struct *prev)
 
 static inline void set_next_task(struct rq *rq, struct task_struct *next)
 {
-	WARN_ON_ONCE(rq->curr != next);
 	next->sched_class->set_next_task(rq, next, false);
 }
 
-- 
2.17.1

