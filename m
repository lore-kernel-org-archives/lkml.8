Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05558C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 13:03:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3A7A20727
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 13:03:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RiJQjM6I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726160AbgENNDM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 09:03:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726011AbgENNDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 09:03:11 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD21C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 06:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KeSwjN7AQ4hCBh+e7FgC+sDqnOGQJ4GTrovXq5bwJvs=; b=RiJQjM6IreZoIi6Lv4NKF/8De0
        UaZZ5n3D6SVWi1JPHstL45VKLff7Z70MyJ7xPyD0Xw9NZnC4gnSk5g7dR3VqjjReHclVRTGZ5V2UI
        IXyp05ec2zNHQcN83b2wMpzBBJ3lq0keBEFIqh5olLBSrOx34QH7zmVrV+Uum8iYOVunbpwGODNjH
        WWwcYCLLKtIVPjxfXpiSdgUTiMC3cIF0HPQ0JxD+7DoHkNWR5V60laUIInB1blVfBxYHL8vbgivMX
        NI4EK2KWCSWiC/RRjgk0xVfU27PtOUt6N4eTgNXy9llrQ35nX+r9ptXJq1LJicrvWFWxjentgcXA5
        UNojGoSw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jZDVk-0006pQ-3m; Thu, 14 May 2020 13:02:52 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 900D1301205;
        Thu, 14 May 2020 15:02:48 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 728F1213C8B7A; Thu, 14 May 2020 15:02:48 +0200 (CEST)
Date:   Thu, 14 May 2020 15:02:48 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Aaron Lu <aaron.lwe@gmail.com>
Cc:     Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Aaron Lu <aaron.lu@linux.alibaba.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        =?iso-8859-1?Q?Fr=E9d=E9ric?= Weisbecker <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        "Li, Aubrey" <aubrey.li@linux.intel.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joel Fernandes <joelaf@google.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH updated v2] sched/fair: core wide cfs task priority
 comparison
Message-ID: <20200514130248.GD2940@hirez.programming.kicks-ass.net>
References: <CANaguZAXsjD=X-bB7dvQZ3FSqLioiZU=YREHH_7JqiFsZCTxHA@mail.gmail.com>
 <20200417094045.GA197704@ziqianlu-desktop.localdomain>
 <20200420080759.GA224731@ziqianlu-desktop.localdomain>
 <CANaguZDP3nyBdjLeeCZGoUoYk6Lf0HUv19N2Qxo4CpZfrjPZHA@mail.gmail.com>
 <20200421025131.GA227300@aaronlu-desktop>
 <20200424142443.GA263207@aaronlu-desktop>
 <20200506143506.GH5298@hirez.programming.kicks-ass.net>
 <20200508084419.GA120223@aaronlu-desktop>
 <20200508090925.GV5298@hirez.programming.kicks-ass.net>
 <20200508123457.GA122180@aaronlu-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508123457.GA122180@aaronlu-desktop>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 08, 2020 at 08:34:57PM +0800, Aaron Lu wrote:
> With this said, I realized a workaround for the issue described above:
> when the core went from 'compatible mode'(step 1-3) to 'incompatible
> mode'(step 4), reset all root level sched entities' vruntime to be the
> same as the core wide min_vruntime. After all, the core is transforming
> from two runqueue mode to single runqueue mode... I think this can solve
> the issue to some extent but I may miss other scenarios.

A little something like so, this syncs min_vruntime when we switch to
single queue mode. This is very much SMT2 only, I got my head in twist
when thikning about more siblings, I'll have to try again later.

This very much retains the horrible approximation of S we always do.

Also, it is _completely_ untested...

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -102,7 +102,6 @@ static inline int __task_prio(struct tas
 /* real prio, less is less */
 static inline bool prio_less(struct task_struct *a, struct task_struct *b)
 {
-
 	int pa = __task_prio(a), pb = __task_prio(b);
 
 	if (-pa < -pb)
@@ -114,19 +113,8 @@ static inline bool prio_less(struct task
 	if (pa == -1) /* dl_prio() doesn't work because of stop_class above */
 		return !dl_time_before(a->dl.deadline, b->dl.deadline);
 
-	if (pa == MAX_RT_PRIO + MAX_NICE)  { /* fair */
-		u64 vruntime = b->se.vruntime;
-
-		/*
-		 * Normalize the vruntime if tasks are in different cpus.
-		 */
-		if (task_cpu(a) != task_cpu(b)) {
-			vruntime -= task_cfs_rq(b)->min_vruntime;
-			vruntime += task_cfs_rq(a)->min_vruntime;
-		}
-
-		return !((s64)(a->se.vruntime - vruntime) <= 0);
-	}
+	if (pa == MAX_RT_PRIO + MAX_NICE)
+		return cfs_prio_less(a, b);
 
 	return false;
 }
@@ -4293,10 +4281,11 @@ static struct task_struct *
 pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 {
 	struct task_struct *next, *max = NULL;
+	int old_active = 0, new_active = 0;
 	const struct sched_class *class;
 	const struct cpumask *smt_mask;
-	int i, j, cpu;
 	bool need_sync = false;
+	int i, j, cpu;
 
 	cpu = cpu_of(rq);
 	if (cpu_is_offline(cpu))
@@ -4349,10 +4338,14 @@ pick_next_task(struct rq *rq, struct tas
 		rq_i->core_pick = NULL;
 
 		if (rq_i->core_forceidle) {
+			// XXX is_idle_task(rq_i->curr) && rq_i->nr_running ??
 			need_sync = true;
 			rq_i->core_forceidle = false;
 		}
 
+		if (!is_idle_task(rq_i->curr))
+			old_active++;
+
 		if (i != cpu)
 			update_rq_clock(rq_i);
 	}
@@ -4463,8 +4456,12 @@ next_class:;
 
 		WARN_ON_ONCE(!rq_i->core_pick);
 
-		if (is_idle_task(rq_i->core_pick) && rq_i->nr_running)
-			rq_i->core_forceidle = true;
+		if (is_idle_task(rq_i->core_pick)) {
+			if (rq_i->nr_running)
+				rq_i->core_forceidle = true;
+		} else {
+			new_active++;
+		}
 
 		if (i == cpu)
 			continue;
@@ -4476,6 +4473,16 @@ next_class:;
 		WARN_ON_ONCE(!cookie_match(next, rq_i->core_pick));
 	}
 
+	/* XXX SMT2 only */
+	if (new_active == 1 && old_active > 1) {
+		/*
+		 * We just dropped into single-rq mode, increment the sequence
+		 * count to trigger the vruntime sync.
+		 */
+		rq->core->core_sync_seq++;
+	}
+	rq->core->core_active = new_active;
+
 done:
 	set_next_task(rq, next);
 	return next;
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -386,6 +386,12 @@ is_same_group(struct sched_entity *se, s
 	return NULL;
 }
 
+static inline bool
+is_same_tg(struct sched_entity *se, struct sched_entity *pse)
+{
+	return se->cfs_rq->tg == pse->cfs_rq->tg;
+}
+
 static inline struct sched_entity *parent_entity(struct sched_entity *se)
 {
 	return se->parent;
@@ -394,8 +400,6 @@ static inline struct sched_entity *paren
 static void
 find_matching_se(struct sched_entity **se, struct sched_entity **pse)
 {
-	int se_depth, pse_depth;
-
 	/*
 	 * preemption test can be made between sibling entities who are in the
 	 * same cfs_rq i.e who have a common parent. Walk up the hierarchy of
@@ -403,23 +407,16 @@ find_matching_se(struct sched_entity **s
 	 * parent.
 	 */
 
-	/* First walk up until both entities are at same depth */
-	se_depth = (*se)->depth;
-	pse_depth = (*pse)->depth;
-
-	while (se_depth > pse_depth) {
-		se_depth--;
-		*se = parent_entity(*se);
-	}
-
-	while (pse_depth > se_depth) {
-		pse_depth--;
-		*pse = parent_entity(*pse);
-	}
+	/* XXX we now have 3 of these loops, C stinks */
 
 	while (!is_same_group(*se, *pse)) {
-		*se = parent_entity(*se);
-		*pse = parent_entity(*pse);
+		int se_depth = (*se)->depth;
+		int pse_depth = (*pse)->depth;
+
+		if (se_depth <= pse_depth)
+			*pse = parent_entity(*pse);
+		if (se_depth >= pse_depth)
+			*se = parent_entity(*se);
 	}
 }
 
@@ -455,6 +452,12 @@ static inline struct sched_entity *paren
 	return NULL;
 }
 
+static inline bool
+is_same_tg(struct sched_entity *se, struct sched_entity *pse)
+{
+	return true;
+}
+
 static inline void
 find_matching_se(struct sched_entity **se, struct sched_entity **pse)
 {
@@ -462,6 +465,31 @@ find_matching_se(struct sched_entity **s
 
 #endif	/* CONFIG_FAIR_GROUP_SCHED */
 
+bool cfs_prio_less(struct task_struct *a, struct task_struct *b)
+{
+	struct sched_entity *se_a = &a->se, *se_b = &b->se;
+	struct cfs_rq *cfs_rq_a, *cfa_rq_b;
+	u64 vruntime_a, vruntime_b;
+
+	while (!is_same_tg(se_a, se_b)) {
+		int se_a_depth = se_a->depth;
+		int se_b_depth = se_b->depth;
+
+		if (se_a_depth <= se_b_depth)
+			se_b = parent_entity(se_b);
+		if (se_a_depth >= se_b_depth)
+			se_a = parent_entity(se_a);
+	}
+
+	cfs_rq_a = cfs_rq_of(se_a);
+	cfs_rq_b = cfs_rq_of(se_b);
+
+	vruntime_a = se_a->vruntime - cfs_rq_a->core_vruntime;
+	vruntime_b = se_b->vruntime - cfs_rq_b->core_vruntime;
+
+	return !((s64)(vruntime_a - vruntime_b) <= 0);
+}
+
 static __always_inline
 void account_cfs_rq_runtime(struct cfs_rq *cfs_rq, u64 delta_exec);
 
@@ -6891,6 +6919,18 @@ static void check_preempt_wakeup(struct
 		set_last_buddy(se);
 }
 
+static void core_sync_entity(struct rq *rq, struct cfs_rq *cfs_rq)
+{
+	if (!sched_core_enabled())
+		return;
+
+	if (rq->core->core_sync_seq == cfs_rq->core_sync_seq)
+		return;
+
+	cfs_rq->core_sync_seq = rq->core->core_sync_seq;
+	cfs_rq->core_vruntime = cfs_rq->min_vruntime;
+}
+
 static struct task_struct *pick_task_fair(struct rq *rq)
 {
 	struct cfs_rq *cfs_rq = &rq->cfs;
@@ -6902,6 +6942,14 @@ static struct task_struct *pick_task_fai
 	do {
 		struct sched_entity *curr = cfs_rq->curr;
 
+		/*
+		 * Propagate the sync state down to whatever cfs_rq we need,
+		 * the active cfs_rq's will have been done by
+		 * set_next_task_fair(), the rest is inactive and will not have
+		 * changed due to the current running task.
+		 */
+		core_sync_entity(rq, cfs_rq);
+
 		se = pick_next_entity(cfs_rq, NULL);
 
 		if (curr) {
@@ -10825,7 +10873,8 @@ static void switched_to_fair(struct rq *
 	}
 }
 
-/* Account for a task changing its policy or group.
+/*
+ * Account for a task changing its policy or group.
  *
  * This routine is mostly called to set cfs_rq->curr field when a task
  * migrates between groups/classes.
@@ -10847,6 +10896,9 @@ static void set_next_task_fair(struct rq
 	for_each_sched_entity(se) {
 		struct cfs_rq *cfs_rq = cfs_rq_of(se);
 
+		/* snapshot vruntime before using it */
+		core_sync_entity(rq, cfs_rq);
+
 		set_next_entity(cfs_rq, se);
 		/* ensure bandwidth has been allocated on our new cfs_rq */
 		account_cfs_rq_runtime(cfs_rq, 0);
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -503,6 +503,10 @@ struct cfs_rq {
 	unsigned int		h_nr_running;      /* SCHED_{NORMAL,BATCH,IDLE} */
 	unsigned int		idle_h_nr_running; /* SCHED_IDLE */
 
+#ifdef CONFIG_SCHED_CORE
+	unsigned int		core_sync_seq;
+	u64			core_vruntime;
+#endif
 	u64			exec_clock;
 	u64			min_vruntime;
 #ifndef CONFIG_64BIT
@@ -1035,12 +1039,15 @@ struct rq {
 	unsigned int		core_enabled;
 	unsigned int		core_sched_seq;
 	struct rb_root		core_tree;
-	bool			core_forceidle;
+	unsigned int		core_forceidle;
 
 	/* shared state */
 	unsigned int		core_task_seq;
 	unsigned int		core_pick_seq;
 	unsigned long		core_cookie;
+	unsigned int		core_sync_seq;
+	unsigned int		core_active;
+
 #endif
 };
 
@@ -2592,6 +2599,8 @@ static inline bool sched_energy_enabled(
 
 #endif /* CONFIG_ENERGY_MODEL && CONFIG_CPU_FREQ_GOV_SCHEDUTIL */
 
+extern bool cfs_prio_less(struct task_struct *a, struct task_struct *b);
+
 #ifdef CONFIG_MEMBARRIER
 /*
  * The scheduler provides memory barriers required by membarrier between:
