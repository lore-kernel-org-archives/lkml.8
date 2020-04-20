Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1980C3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 08:08:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74A3E218AC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 08:08:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BatcsPEQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbgDTIIM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 04:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbgDTIIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 04:08:11 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 478E7C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 01:08:10 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id p8so4674812pgi.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 01:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hoVKH6ngaHdmyIXVAl/nvZ/OZsT5yWpy5YL2iRSkQ+8=;
        b=BatcsPEQSaL7d0HrY4I9A5pB7ev3WdrNnqBfbM3uY9/YsmviFZcjwthcUdEI5ioYTg
         hfDA5zJBMaBp/QgqTlnVf+oTGkoyOLWjoy+GPP8Kw89XLU+AseLI1vec7Oto+N1Iymol
         72v2YoFh2g/nMSwPTcnbtcHpmlAnzjGePRulT9WskTzoUtdhEDZwdtaAJQSP9spehkbW
         1fCjaiUqDTSpy3sdR0JU5oQTVvRL9oIitz740yQbYkmPwSnnXClX/f2/gxEZXQMGC+g4
         4pwx5WqK9J02C93U9qNjlCeRxc+txBKTG10TaPPjjIbgNVdpopWVYQH5xHwLkvYd8Fml
         4HXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hoVKH6ngaHdmyIXVAl/nvZ/OZsT5yWpy5YL2iRSkQ+8=;
        b=Tmv4pyoft02XkXKpqCCdnGP+rXYqtKdLMrI43SgLMKsrH/UueOfkIgRUU6368ADBhj
         oae00kR5OkEkCx5mkZzmgHUzxEq7QUV88799iqObKiSgSaUi+DbDX7kGbsucdGihEEhL
         t8ILbs8Ks7tixGCiGsRRlo+CEaAohyzM+GFFc1hiQfx+fCzHiMiTTIeatILhnRAgjH6G
         Oc67spiaei7oLCYbwP8xWj9g/aos/qhHj0sDNBN4AkrQ6y/V3n2+5m2JynQaMZoSRFAX
         svhboZSrcHo+OuQFITRbSGy9fEHNt/zjGnziroIc8RuHkUROlpK/0nDmejccVUHUk/PY
         3QCw==
X-Gm-Message-State: AGi0Pub9/8tFnNAsAq2BBKFRI1ewAw+M+DcauSY+5svXsRvLCCOxZs61
        I9NqnmOxVLMyWZER3n68sqE=
X-Google-Smtp-Source: APiQypJQXtZhZBzpNVGlYZL+Q9h17mSbxGLmQEMyWCnFyVGZuQ1JO8C6ARNR5TorHWGC1so3HKvK9g==
X-Received: by 2002:a63:7d19:: with SMTP id y25mr14898994pgc.78.1587370089731;
        Mon, 20 Apr 2020 01:08:09 -0700 (PDT)
Received: from ziqianlu-desktop.localdomain ([47.89.83.64])
        by smtp.gmail.com with ESMTPSA id f6sm329914pfn.189.2020.04.20.01.08.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 01:08:08 -0700 (PDT)
Date:   Mon, 20 Apr 2020 16:07:59 +0800
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
Subject: [PATCH updated] sched/fair: core wide cfs task priority comparison
Message-ID: <20200420080759.GA224731@ziqianlu-desktop.localdomain>
References: <cover.1583332764.git.vpillai@digitalocean.com>
 <2f83d888890cec14be3a7aead0859dceebb4012f.1583332765.git.vpillai@digitalocean.com>
 <20200414135624.GU20730@hirez.programming.kicks-ass.net>
 <20200415033408.GA168322@ziqianlu-desktop.localdomain>
 <20200415040741.GA169001@ziqianlu-desktop.localdomain>
 <CANaguZAXsjD=X-bB7dvQZ3FSqLioiZU=YREHH_7JqiFsZCTxHA@mail.gmail.com>
 <20200417094045.GA197704@ziqianlu-desktop.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200417094045.GA197704@ziqianlu-desktop.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 17, 2020 at 05:40:45PM +0800, Aaron Lu wrote:
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -291,8 +280,13 @@ static int __sched_core_stopper(void *data)
>  	}
>  
>  	for_each_online_cpu(cpu) {
> -		if (!enabled || (enabled && cpumask_weight(cpu_smt_mask(cpu)) >= 2))
> -			cpu_rq(cpu)->core_enabled = enabled;
> +		if (!enabled || (enabled && cpumask_weight(cpu_smt_mask(cpu)) >= 2)) {
> +			struct rq *rq = cpu_rq(cpu);
> +
> +			rq->core_enabled = enabled;
> +			if (rq->core == rq)
> +				sched_core_adjust_se_vruntime(cpu);

The adjust is only needed when core scheduling is enabled while I
mistakenly called it on both enable and disable. And I come to think
normalize is a better name than adjust.

> +		}
>  	}
>  
>  	return 0;

> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index d99ea6ee7af2..7eecf590d6c0 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> +void sched_core_adjust_se_vruntime(int cpu)
> +{
> +	int i;
> +
> +	for_each_cpu(i, cpu_smt_mask(cpu)) {
> +		struct cfs_rq *cfs_rq, *sibling_cfs_rq;
> +		struct sched_entity *se, *next;
> +		s64 delta;
> +
> +		if (i == cpu)
> +			continue;
> +
> +		sibling_cfs_rq = &cpu_rq(i)->cfs;
> +		if (!sibling_cfs_rq->nr_running)
> +			continue;
> +
> +		cfs_rq = &cpu_rq(cpu)->cfs;
> +		delta = cfs_rq->min_vruntime - sibling_cfs_rq->min_vruntime;
> +		/*
> +		 * XXX Malicious user can create a ton of runnable tasks in root
> +		 * sibling_cfs_rq and cause the below vruntime normalization
> +		 * potentially taking a long time.
> +		 */

Testing on a qemu/kvm VM shows that normalizing 32268 sched entities
takes about 6ms time so I think the risk is low, therefore, I'm going to
remove the XXX comment.

(I disabled CONFIG_SCHED_AUTOGROUP and started 32268 cpuhog tasks on one
cpu using taskset, adding trace_printk() before and after the below loop
gives me:
migration/0-11    [000] d..1   674.546882: sched_core_normalize_se_vruntime: cpu5: normalize nr_running=32268
migration/0-11    [000] d..1   674.552364: sched_core_normalize_se_vruntime: cpu5: normalize done
)

> +		rbtree_postorder_for_each_entry_safe(se, next,
> +				&sibling_cfs_rq->tasks_timeline.rb_root,
> +				run_node) {
> +			se->vruntime += delta;
> +		}
> +	}
>  }
>  
>  static __always_inline

I also think the patch is not to make every sched entity's vruntime core
wide but to make it possible to do core wide priority comparison for cfs
tasks so I changed the subject. Here is the updated patch:

From d045030074247faf3b515fab21ac06236ce4bd74 Mon Sep 17 00:00:00 2001
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
 kernel/sched/core.c  | 24 +++++------
 kernel/sched/fair.c  | 96 +++++++++++++++++++++++++++++++++++++++++++-
 kernel/sched/sched.h |  3 ++
 3 files changed, 106 insertions(+), 17 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 5f322922f5ae..059add9a89ed 100644
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
@@ -291,8 +280,13 @@ static int __sched_core_stopper(void *data)
 	}
 
 	for_each_online_cpu(cpu) {
-		if (!enabled || (enabled && cpumask_weight(cpu_smt_mask(cpu)) >= 2))
-			cpu_rq(cpu)->core_enabled = enabled;
+		if (!enabled || (enabled && cpumask_weight(cpu_smt_mask(cpu)) >= 2)) {
+			struct rq *rq = cpu_rq(cpu);
+
+			rq->core_enabled = enabled;
+			if (enabled && rq->core == rq)
+				sched_core_normalize_se_vruntime(cpu);
+		}
 	}
 
 	return 0;
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d99ea6ee7af2..1b87d0c8b9ca 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -449,9 +449,98 @@ find_matching_se(struct sched_entity **se, struct sched_entity **pse)
 
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
 }
 
 static __always_inline
@@ -509,8 +598,11 @@ static void update_min_vruntime(struct cfs_rq *cfs_rq)
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
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 50a5675e941a..d8f0eb7f6e42 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2594,3 +2594,6 @@ static inline void membarrier_switch_mm(struct rq *rq,
 {
 }
 #endif
+
+bool cfs_prio_less(struct task_struct *a, struct task_struct *b);
+void sched_core_normalize_se_vruntime(int cpu);
-- 
2.19.1.3.ge56e4f7

