Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33F8BC38A29
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 09:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0381F208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 09:40:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sLgDiYV6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730342AbgDQJk5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 05:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726793AbgDQJk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 05:40:56 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DEACC061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 02:40:56 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id q16so2167532pje.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 02:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rp2zA7lHbFC17WqECuW3w5OxAkBIBah8sB3hTDrnRFE=;
        b=sLgDiYV6HbP9c4HyIIkUNls/qjnH//y7MXK+FBkhPmuzD+lksvIif/Qf3g9QoeAKTk
         gBuFRIYINWrbCALUxVj1CL/5i1PGpRIWw1fh+ldhUXrhHwfZAuAnpriWFfYAh8unVS+Q
         G2b5iE663/fXGgcKUZbcvqtl52UJRfNKhw2m+vUs9IQyGYwsKf1VWnn+IHxDSR35uPKO
         9KaT7izFePK87pfxMOm95xhDRiDq5tChB36bFPIwqeHQt9oEcmzDMZXqRmkdN7lG//yR
         KrpKQrRCVqeM/Sw3LZoj6EMx1YSlVuKE53FZ3pEILTXJaqGtZJV4QsWlPgy+Tfh+1JMi
         ubhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rp2zA7lHbFC17WqECuW3w5OxAkBIBah8sB3hTDrnRFE=;
        b=lbLm8YuiIrY/hQru5fxw90bLzyttUy+ajGO2O1og5OclWskoh5/d7UouuVVlsukGkR
         orqOG0j+T46jz/o3s5b3SXJHKKuBYOwUCauVoj0+FzLcAD2g9ardo+pusPBFRg3aAiOY
         mXE+pZ2zTD8hkY41uKNA1AviTU9aA0Av9DeN6pRI4U4dEznFrZPiUZDieLki77nAy1qb
         ulCWvMfAictFhwadP8qlztVoRjs8EiQfpw0vSgBHdZfVFaYLXYlvHHpydMLfr8VIKfJd
         DRIdpEOcf3FQqUqG6k2Pp4F6/HZnDVRRKbBRx00xtFLN5x6h7nmdkK1sJ7HQQ+PqsjaS
         afMw==
X-Gm-Message-State: AGi0Pub6nxh+ETGmoGqUo4n1hdmrZYefyMzGnKYnc7C2YFCjRHeRqAzT
        WlVwkWxOZXc63O3e76z6OYE=
X-Google-Smtp-Source: APiQypLNZ8ujI36FQIjDkcOptLko6qpdyzaB8dZm32q+YQqzS9Li0pH7pCeVRTqE6Mxox5a6NoMYeQ==
X-Received: by 2002:a17:902:7047:: with SMTP id h7mr2513362plt.337.1587116455713;
        Fri, 17 Apr 2020 02:40:55 -0700 (PDT)
Received: from ziqianlu-desktop.localdomain ([47.89.83.64])
        by smtp.gmail.com with ESMTPSA id p24sm4807976pjo.43.2020.04.17.02.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2020 02:40:54 -0700 (PDT)
Date:   Fri, 17 Apr 2020 17:40:45 +0800
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
Subject: Re: [RFC PATCH 09/13] sched/fair: core wide vruntime comparison
Message-ID: <20200417094045.GA197704@ziqianlu-desktop.localdomain>
References: <cover.1583332764.git.vpillai@digitalocean.com>
 <2f83d888890cec14be3a7aead0859dceebb4012f.1583332765.git.vpillai@digitalocean.com>
 <20200414135624.GU20730@hirez.programming.kicks-ass.net>
 <20200415033408.GA168322@ziqianlu-desktop.localdomain>
 <20200415040741.GA169001@ziqianlu-desktop.localdomain>
 <CANaguZAXsjD=X-bB7dvQZ3FSqLioiZU=YREHH_7JqiFsZCTxHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANaguZAXsjD=X-bB7dvQZ3FSqLioiZU=YREHH_7JqiFsZCTxHA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 15, 2020 at 05:24:30PM -0400, Vineeth Remanan Pillai wrote:
> > > > You forgot the time complexity analysis.
> > >
> > > This is a mistake and the adjust should be needed only once when core
> > > scheduling is initially enabled. It is an initialization thing and there
> > > is no reason to do it in every invocation of coresched_adjust_vruntime().
> >
> > Correction...
> > I meant there is no need to call coresched_adjust_vruntime() in every
> > invocation of update_core_cfs_rq_min_vruntime().
> 
> Due to the checks in place, update_core_cfs_rq_min_vruntime should
> not be calling coresched_adjust_vruntime more than once between a
> coresched enable/disable. Once the min_vruntime is adjusted, we depend
> only on rq->core and the other sibling's min_vruntime will not grow
> until coresched disable.

OK, but I prefer to make it clear that this is an initialization only
stuff. Below is what I cooked, I also enhanced the changelog while at
it.

From e80121e61953da717da074ea2a097194f6d29ef4 Mon Sep 17 00:00:00 2001
From: Aaron Lu <ziqian.lzq@antfin.com>
Date: Thu, 25 Jul 2019 22:32:48 +0800
Subject: [PATCH] sched/fair: core vruntime comparison

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
threads must be directly comparable. So a new core wide cfs_rq
min_vruntime is introduced to serve the purpose of normalizing these
root level sched entities' vruntime.

All sub cfs_rqs and sched entities are not interesting in cross cpu
priority comparison as they will only participate in the usual cpu local
schedule decision so no need to normalize their vruntimes.

Signed-off-by: Aaron Lu <ziqian.lzq@antfin.com>
---
 kernel/sched/core.c  |  24 ++++------
 kernel/sched/fair.c  | 101 ++++++++++++++++++++++++++++++++++++++++++-
 kernel/sched/sched.h |   3 ++
 3 files changed, 111 insertions(+), 17 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 5f322922f5ae..d6c8c76cb07a 100644
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
+			if (rq->core == rq)
+				sched_core_adjust_se_vruntime(cpu);
+		}
 	}
 
 	return 0;
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d99ea6ee7af2..7eecf590d6c0 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -449,9 +449,103 @@ find_matching_se(struct sched_entity **se, struct sched_entity **pse)
 
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
+void sched_core_adjust_se_vruntime(int cpu)
+{
+	int i;
+
+	for_each_cpu(i, cpu_smt_mask(cpu)) {
+		struct cfs_rq *cfs_rq, *sibling_cfs_rq;
+		struct sched_entity *se, *next;
+		s64 delta;
+
+		if (i == cpu)
+			continue;
+
+		sibling_cfs_rq = &cpu_rq(i)->cfs;
+		if (!sibling_cfs_rq->nr_running)
+			continue;
+
+		cfs_rq = &cpu_rq(cpu)->cfs;
+		delta = cfs_rq->min_vruntime - sibling_cfs_rq->min_vruntime;
+		/*
+		 * XXX Malicious user can create a ton of runnable tasks in root
+		 * sibling_cfs_rq and cause the below vruntime normalization
+		 * potentially taking a long time.
+		 */
+		rbtree_postorder_for_each_entry_safe(se, next,
+				&sibling_cfs_rq->tasks_timeline.rb_root,
+				run_node) {
+			se->vruntime += delta;
+		}
+	}
 }
 
 static __always_inline
@@ -509,8 +603,11 @@ static void update_min_vruntime(struct cfs_rq *cfs_rq)
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
index 50a5675e941a..24bae760f764 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2594,3 +2594,6 @@ static inline void membarrier_switch_mm(struct rq *rq,
 {
 }
 #endif
+
+bool cfs_prio_less(struct task_struct *a, struct task_struct *b);
+void sched_core_adjust_se_vruntime(int cpu);
-- 
2.19.1.3.ge56e4f7

