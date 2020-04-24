Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78AFFC54FD0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 14:24:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 439DA2084D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 14:24:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sJJBgSiJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbgDXOYz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 10:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726667AbgDXOYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 10:24:54 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA8E3C09B045
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 07:24:54 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id fu13so3353628pjb.5
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 07:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=blChg09holroEWZaQTqhOAhwsrEg+kGv0gQ7KelhZY8=;
        b=sJJBgSiJ28xOEeefMuO6Qk9qU8nNae8S9/fgOKzJRUsj/f6pOk74pklxVFo6y+1KTT
         EcIF45pcNnCoyC2GcT4XcZgfysaRAPIpgTqg5T4OjgT16UheFr5yJyK/D0lOnMYrfF3+
         2jFOek5Qu9A6vB+UlaCM6sNvM7HBb8QKvYChIY1LNzggNn+4d6bOXJVgBWfEyxcYkbLk
         0M7FIFLsf/+9ynjzvLxNGNSUWv8sTfoTXUPQ3HReeVWqSw18WJMKZzOLPQ1vB7x8eXwq
         kQXJWTpxCF7tNOM09egKEsxNYbQFglhFG9bC8TSwplRw0tfwLh3F2ifMZ4EYPN62GX73
         fjLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=blChg09holroEWZaQTqhOAhwsrEg+kGv0gQ7KelhZY8=;
        b=nkU6P/DQ53QvQdsF9E/NNwMXoW90VnVlLBzgbKnHaRcyRrFqP0uR5Fe/WZMIPK+tx1
         qHH3riFfS4v9OeNb4VFXf4jrq7zoBb8eRlD4Bkb0Hn/dCm/c/TDhybjbrzstj1Lva1hu
         3mbi9UoqhVAckfq4lkOtw+3sr0xq2MnW5gKM+Lp/bXsjnn+cjHJ07/2QSjwhT4ByY62+
         wv7clpAbtbAxERM59eWLLy7HXvsycIdJraxTYhXRF44TuJYtURaIuJJIKObPoThwxOxN
         GT67epD2zwwUtbuczLwnBd98ud/QNkyFUQo8QDoRqjPzWPRIilPe46iTzBGy9oqrwqGd
         t3FQ==
X-Gm-Message-State: AGi0PuanD3rHaM/DKzGizF+YLDK3XH8h2OdzD4jguxLBqZusuWSc/7pn
        GW38LAhAQFXQu+oxJmhhZRc=
X-Google-Smtp-Source: APiQypIAnYIxqJEM93gIwW1Dd3W5F9loLRFpLhmJZ2u/K4Up4VwW9nXG20XnpWiJU13BBa2lyercqQ==
X-Received: by 2002:a17:902:8487:: with SMTP id c7mr8624138plo.251.1587738294143;
        Fri, 24 Apr 2020 07:24:54 -0700 (PDT)
Received: from aaronlu-desktop ([47.89.83.64])
        by smtp.gmail.com with ESMTPSA id p64sm4912465pjp.7.2020.04.24.07.24.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 07:24:52 -0700 (PDT)
Date:   Fri, 24 Apr 2020 22:24:43 +0800
From:   Aaron Lu <aaron.lwe@gmail.com>
To:     Vineeth Remanan Pillai <vpillai@digitalocean.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
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
Subject: [PATCH updated v2] sched/fair: core wide cfs task priority comparison
Message-ID: <20200424142443.GA263207@aaronlu-desktop>
References: <cover.1583332764.git.vpillai@digitalocean.com>
 <2f83d888890cec14be3a7aead0859dceebb4012f.1583332765.git.vpillai@digitalocean.com>
 <20200414135624.GU20730@hirez.programming.kicks-ass.net>
 <20200415033408.GA168322@ziqianlu-desktop.localdomain>
 <20200415040741.GA169001@ziqianlu-desktop.localdomain>
 <CANaguZAXsjD=X-bB7dvQZ3FSqLioiZU=YREHH_7JqiFsZCTxHA@mail.gmail.com>
 <20200417094045.GA197704@ziqianlu-desktop.localdomain>
 <20200420080759.GA224731@ziqianlu-desktop.localdomain>
 <CANaguZDP3nyBdjLeeCZGoUoYk6Lf0HUv19N2Qxo4CpZfrjPZHA@mail.gmail.com>
 <20200421025131.GA227300@aaronlu-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200421025131.GA227300@aaronlu-desktop>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 21, 2020 at 10:51:31AM +0800, Aaron Lu wrote:
> On Mon, Apr 20, 2020 at 06:26:34PM -0400, Vineeth Remanan Pillai wrote:
> > On Mon, Apr 20, 2020 at 4:08 AM Aaron Lu <aaron.lwe@gmail.com> wrote:
> > >
> > > On Fri, Apr 17, 2020 at 05:40:45PM +0800, Aaron Lu wrote:
> > 
> > > The adjust is only needed when core scheduling is enabled while I
> > > mistakenly called it on both enable and disable. And I come to think
> > > normalize is a better name than adjust.
> > >
> > I guess we would also need to update the min_vruntime of the sibling
> > to match the rq->core->min_vruntime on coresched disable. Otherwise
> > a new enqueue on root cfs of the sibling would inherit the very old
> > min_vruntime before coresched enable and thus would starve all the
> > already queued tasks until the newly enqueued se's vruntime catches up.
> 
> Yes this is a concern but AFAICS, there is no problem. Consider:
> - when there is no queued task across the disable boundary, the stale
>   min_vruntime doesn't matter as you said;
> - when there are queued tasks across the disable boundary, the newly
>   queued task will normalize its vruntime against the sibling_cfs_rq's
>   min_vruntime, if the min_vruntime is stale and problem would occur.
>   But my reading of the code made me think this min_vruntime should
>   have already been updated by update_curr() in enqueue_entity() before
>   being used by this newly enqueued task and update_curr() would bring
>   the stale min_vruntime to the smallest vruntime of the queued ones so
>   again, no problem should occur.

After discussion with Vineeth, I now tend to add the syncing of
sibling_cfs_rq min_vruntime on core disable because analysing all the
code is time consuming and though I didn't find any problems now, I
might miss something and future code change may also break the
expectations so adding it seems a safe thing to do, also, it didn't
bring any performance downgrade as it is a one time disable stuff.

Vineeth also pointed out a problem of misusing cfs_rq->min_vruntime for
!CONFIG_64BIT kernel in migrate_task_rq_fair(), this is also fixed.

(only compile tested for !CONFIG_64BIT kernel)

From cda051ed33e6b88f28b44147cc7c894994c9d991 Mon Sep 17 00:00:00 2001
From: Aaron Lu <ziqian.lzq@antfin.com>
Date: Mon, 20 Apr 2020 10:27:17 +0800
Subject: [PATCH] sched/fair: core wide cfs task priority comparison

This patch provides a vruntime based way to compare two cfs task's
priority, be it on the same cpu or different threads of the same core.

When the two tasks are on the same CPU, we just need to find a common
cfs_rq both sched_entities are on and then do the comparison.

When the two tasks are on differen threads of the same core, each thread
will choose the next task to run the usual way and then the root level
sched entities which the two tasks belong to will be used to decide
which task runs next core wide.

An illustration for the cross CPU case:

   cpu0         cpu1
 /   |  \     /   |  \
se1 se2 se3  se4 se5 se6
    /  \            /   \
  se21 se22       se61  se62
  (A)                    /
                       se621
                        (B)

Assume CPU0 and CPU1 are smt siblings and cpu0 has decided task A to
run next and cpu1 has decided task B to run next. To compare priority
of task A and B, we compare priority of se2 and se6. Whose vruntime is
smaller, who wins.

To make this work, the root level sched entities' vruntime of the two
threads must be directly comparable. So one of the hyperthread's root
cfs_rq's min_vruntime is chosen as the core wide one and all root level
sched entities' vruntime is normalized against it.

All sub cfs_rqs and sched entities are not interesting in cross cpu
priority comparison as they will only participate in the usual cpu local
schedule decision so no need to normalize their vruntimes.

Signed-off-by: Aaron Lu <ziqian.lzq@antfin.com>
---
 kernel/sched/core.c  |  28 +++++----
 kernel/sched/fair.c  | 135 +++++++++++++++++++++++++++++++++++++++++--
 kernel/sched/sched.h |   4 ++
 3 files changed, 148 insertions(+), 19 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 5f322922f5ae..d8bedddef6fb 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -119,19 +119,8 @@ static inline bool prio_less(struct task_struct *a, struct task_struct *b)
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
+	if (pa == MAX_RT_PRIO + MAX_NICE) /* fair */
+		return cfs_prio_less(a, b);
 
 	return false;
 }
@@ -291,8 +280,17 @@ static int __sched_core_stopper(void *data)
 	}
 
 	for_each_online_cpu(cpu) {
-		if (!enabled || (enabled && cpumask_weight(cpu_smt_mask(cpu)) >= 2))
-			cpu_rq(cpu)->core_enabled = enabled;
+		if (!enabled || (enabled && cpumask_weight(cpu_smt_mask(cpu)) >= 2)) {
+			struct rq *rq = cpu_rq(cpu);
+
+			rq->core_enabled = enabled;
+			if (rq->core == rq) {
+				if (enabled)
+					sched_core_normalize_se_vruntime(cpu);
+				else
+					sched_core_sync_cfs_vruntime(cpu);
+			}
+		}
 	}
 
 	return 0;
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d99ea6ee7af2..a5774f495d97 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -449,9 +449,133 @@ find_matching_se(struct sched_entity **se, struct sched_entity **pse)
 
 #endif	/* CONFIG_FAIR_GROUP_SCHED */
 
+static inline struct cfs_rq *root_cfs_rq(struct cfs_rq *cfs_rq)
+{
+	return &rq_of(cfs_rq)->cfs;
+}
+
+static inline bool is_root_cfs_rq(struct cfs_rq *cfs_rq)
+{
+	return cfs_rq == root_cfs_rq(cfs_rq);
+}
+
+static inline struct cfs_rq *core_cfs_rq(struct cfs_rq *cfs_rq)
+{
+	return &rq_of(cfs_rq)->core->cfs;
+}
+
 static inline u64 cfs_rq_min_vruntime(struct cfs_rq *cfs_rq)
 {
-	return cfs_rq->min_vruntime;
+	if (!sched_core_enabled(rq_of(cfs_rq)) || !is_root_cfs_rq(cfs_rq))
+		return cfs_rq->min_vruntime;
+
+	return core_cfs_rq(cfs_rq)->min_vruntime;
+}
+
+#ifndef CONFIG_64BIT
+static inline u64 cfs_rq_min_vruntime_copy(struct cfs_rq *cfs_rq)
+{
+	if (!sched_core_enabled(rq_of(cfs_rq)) || !is_root_cfs_rq(cfs_rq))
+		return cfs_rq->min_vruntime_copy;
+
+	return core_cfs_rq(cfs_rq)->min_vruntime_copy;
+}
+#endif
+
+bool cfs_prio_less(struct task_struct *a, struct task_struct *b)
+{
+	struct sched_entity *sea = &a->se;
+	struct sched_entity *seb = &b->se;
+	bool samecpu = task_cpu(a) == task_cpu(b);
+	s64 delta;
+
+	if (samecpu) {
+		/* vruntime is per cfs_rq */
+		while (!is_same_group(sea, seb)) {
+			int sea_depth = sea->depth;
+			int seb_depth = seb->depth;
+
+			if (sea_depth >= seb_depth)
+				sea = parent_entity(sea);
+			if (sea_depth <= seb_depth)
+				seb = parent_entity(seb);
+		}
+
+		delta = (s64)(sea->vruntime - seb->vruntime);
+		goto out;
+	}
+
+	/* crosscpu: compare root level se's vruntime to decide priority */
+	while (sea->parent)
+		sea = sea->parent;
+	while (seb->parent)
+		seb = seb->parent;
+	delta = (s64)(sea->vruntime - seb->vruntime);
+
+out:
+	return delta > 0;
+}
+
+/*
+ * This is called in stop machine context so no need to take the rq lock.
+ *
+ * Core scheduling is going to be enabled and the root level sched entities
+ * of both siblings will use cfs_rq->min_vruntime as the common cfs_rq
+ * min_vruntime, so it's necessary to normalize vruntime of existing root
+ * level sched entities in sibling_cfs_rq.
+ *
+ * Update of sibling_cfs_rq's min_vruntime isn't necessary as we will be
+ * only using cfs_rq->min_vruntime during the entire run of core scheduling.
+ */
+void sched_core_normalize_se_vruntime(int cpu)
+{
+	struct cfs_rq *cfs_rq = &cpu_rq(cpu)->cfs;
+	int i;
+
+	for_each_cpu(i, cpu_smt_mask(cpu)) {
+		struct sched_entity *se, *next;
+		struct cfs_rq *sibling_cfs_rq;
+		s64 delta;
+
+		if (i == cpu)
+			continue;
+
+		sibling_cfs_rq = &cpu_rq(i)->cfs;
+		if (!sibling_cfs_rq->nr_running)
+			continue;
+
+		delta = cfs_rq->min_vruntime - sibling_cfs_rq->min_vruntime;
+		rbtree_postorder_for_each_entry_safe(se, next,
+				&sibling_cfs_rq->tasks_timeline.rb_root,
+				run_node) {
+			se->vruntime += delta;
+		}
+	}
+}
+
+/*
+ * During the entire run of core scheduling, sibling_cfs_rq's min_vruntime
+ * is left unused and could lag far behind its still queued sched entities.
+ * Sync it to the up2date core wide one to avoid problems.
+ */
+void sched_core_sync_cfs_vruntime(int cpu)
+{
+	struct cfs_rq *cfs_rq = &cpu_rq(cpu)->cfs;
+	int i;
+
+	for_each_cpu(i, cpu_smt_mask(cpu)) {
+		struct cfs_rq *sibling_cfs_rq;
+
+		if (i == cpu)
+			continue;
+
+		sibling_cfs_rq = &cpu_rq(i)->cfs;
+		sibling_cfs_rq->min_vruntime = cfs_rq->min_vruntime;
+#ifndef CONFIG_64BIT
+		smp_wmb();
+		sibling_cfs_rq->min_vruntime_copy = cfs_rq->min_vruntime;
+#endif
+	}
 }
 
 static __always_inline
@@ -509,8 +633,11 @@ static void update_min_vruntime(struct cfs_rq *cfs_rq)
 			vruntime = min_vruntime(vruntime, se->vruntime);
 	}
 
+	if (sched_core_enabled(rq_of(cfs_rq)) && is_root_cfs_rq(cfs_rq))
+		cfs_rq = core_cfs_rq(cfs_rq);
+
 	/* ensure we never gain time by being placed backwards. */
-	cfs_rq->min_vruntime = max_vruntime(cfs_rq_min_vruntime(cfs_rq), vruntime);
+	cfs_rq->min_vruntime = max_vruntime(cfs_rq->min_vruntime, vruntime);
 #ifndef CONFIG_64BIT
 	smp_wmb();
 	cfs_rq->min_vruntime_copy = cfs_rq->min_vruntime;
@@ -6396,9 +6523,9 @@ static void migrate_task_rq_fair(struct task_struct *p, int new_cpu)
 		u64 min_vruntime_copy;
 
 		do {
-			min_vruntime_copy = cfs_rq->min_vruntime_copy;
+			min_vruntime_copy = cfs_rq_min_vruntime_copy(cfs_rq);
 			smp_rmb();
-			min_vruntime = cfs_rq->min_vruntime;
+			min_vruntime = cfs_rq_min_vruntime(cfs_rq);
 		} while (min_vruntime != min_vruntime_copy);
 #else
 		min_vruntime = cfs_rq_min_vruntime(cfs_rq);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 50a5675e941a..5517ca92b5bd 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2594,3 +2594,7 @@ static inline void membarrier_switch_mm(struct rq *rq,
 {
 }
 #endif
+
+bool cfs_prio_less(struct task_struct *a, struct task_struct *b);
+void sched_core_normalize_se_vruntime(int cpu);
+void sched_core_sync_cfs_vruntime(int cpu);
-- 
2.19.1.3.ge56e4f7

