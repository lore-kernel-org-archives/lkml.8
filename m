Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0930C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 19:59:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F76E2072D
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 19:59:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbgHUT7Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 15:59:25 -0400
Received: from mga03.intel.com ([134.134.136.65]:3374 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726728AbgHUT7K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 15:59:10 -0400
IronPort-SDR: eOnTRdEuuc3uI2H3XNJK64l33cA5lXC1DRyNgL1BBQeo9skJKa0PfQ+mXobAsiUVcQs3YsC8D0
 W0Vy2FaguB5Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9720"; a="155604701"
X-IronPort-AV: E=Sophos;i="5.76,338,1592895600"; 
   d="scan'208";a="155604701"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2020 12:59:09 -0700
IronPort-SDR: a93tArqQIx0SZzoD5XKgCFct+CR8zmkVs9h50/fXSHNVM/kHVz8O1S5Ea+UijAH4RR0+1GRfOH
 GrJQSnLv7GLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,338,1592895600"; 
   d="scan'208";a="330137763"
Received: from labuser-ice-lake-client-platform.jf.intel.com ([10.54.55.65])
  by fmsmga002.fm.intel.com with ESMTP; 21 Aug 2020 12:59:08 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ak@linux.intel.com, mark.rutland@arm.com, luto@amacapital.net,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V2 2/3] perf/core: Pull pmu::sched_task() into perf_event_context_sched_out()
Date:   Fri, 21 Aug 2020 12:57:53 -0700
Message-Id: <20200821195754.20159-2-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200821195754.20159-1-kan.liang@linux.intel.com>
References: <20200821195754.20159-1-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The pmu::sched_task() is a context switch callback. It passes the
cpuctx->task_ctx as a parameter to the lower code. To find the
cpuctx->task_ctx, the current code iterates a cpuctx list.
The same context will iterated in perf_event_context_sched_out() soon.
Share the cpuctx->task_ctx can avoid the unnecessary iteration of the
cpuctx list.

The pmu::sched_task() is also required for the optimization case for
equivalent contexts.

The task_ctx_sched_out() will eventually disable and reenable the PMU
when schedule out events. Add perf_pmu_disable() and perf_pmu_enable()
around task_ctx_sched_out() don't break anything.

Drop the cpuctx->ctx.lock for the pmu::sched_task(). The lock is for
per-CPU context, which is not necessary for the per-task context
schedule.

No one uses sched_cb_entry, perf_sched_cb_usages, sched_cb_list, and
perf_pmu_sched_task() any more.

Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

New patch for V2

 include/linux/perf_event.h |  1 -
 kernel/events/core.c       | 47 ++++++++++++++------------------------
 2 files changed, 17 insertions(+), 31 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 3737e653f47e..9357720df7de 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -872,7 +872,6 @@ struct perf_cpu_context {
 	struct list_head		cgrp_cpuctx_entry;
 #endif
 
-	struct list_head		sched_cb_entry;
 	int				sched_cb_usage;
 
 	int				online;
diff --git a/kernel/events/core.c b/kernel/events/core.c
index c785cbadbdb8..d0393d1970b7 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -382,7 +382,6 @@ static DEFINE_MUTEX(perf_sched_mutex);
 static atomic_t perf_sched_count;
 
 static DEFINE_PER_CPU(atomic_t, perf_cgroup_events);
-static DEFINE_PER_CPU(int, perf_sched_cb_usages);
 static DEFINE_PER_CPU(struct pmu_event_list, pmu_sb_events);
 
 static atomic_t nr_mmap_events __read_mostly;
@@ -3384,10 +3383,12 @@ static void perf_event_context_sched_out(struct task_struct *task, int ctxn,
 	struct perf_event_context *parent, *next_parent;
 	struct perf_cpu_context *cpuctx;
 	int do_switch = 1;
+	struct pmu *pmu;
 
 	if (likely(!ctx))
 		return;
 
+	pmu = ctx->pmu;
 	cpuctx = __get_cpu_context(ctx);
 	if (!cpuctx->task_ctx)
 		return;
@@ -3417,11 +3418,15 @@ static void perf_event_context_sched_out(struct task_struct *task, int ctxn,
 		raw_spin_lock(&ctx->lock);
 		raw_spin_lock_nested(&next_ctx->lock, SINGLE_DEPTH_NESTING);
 		if (context_equiv(ctx, next_ctx)) {
-			struct pmu *pmu = ctx->pmu;
 
 			WRITE_ONCE(ctx->task, next);
 			WRITE_ONCE(next_ctx->task, task);
 
+			perf_pmu_disable(pmu);
+
+			if (cpuctx->sched_cb_usage && pmu->sched_task)
+				pmu->sched_task(ctx, false);
+
 			/*
 			 * PMU specific parts of task perf context can require
 			 * additional synchronization. As an example of such
@@ -3433,6 +3438,8 @@ static void perf_event_context_sched_out(struct task_struct *task, int ctxn,
 			else
 				swap(ctx->task_ctx_data, next_ctx->task_ctx_data);
 
+			perf_pmu_enable(pmu);
+
 			/*
 			 * RCU_INIT_POINTER here is safe because we've not
 			 * modified the ctx and the above modification of
@@ -3455,21 +3462,22 @@ static void perf_event_context_sched_out(struct task_struct *task, int ctxn,
 
 	if (do_switch) {
 		raw_spin_lock(&ctx->lock);
+		perf_pmu_disable(pmu);
+
+		if (cpuctx->sched_cb_usage && pmu->sched_task)
+			pmu->sched_task(ctx, false);
 		task_ctx_sched_out(cpuctx, ctx, EVENT_ALL);
+
+		perf_pmu_enable(pmu);
 		raw_spin_unlock(&ctx->lock);
 	}
 }
 
-static DEFINE_PER_CPU(struct list_head, sched_cb_list);
-
 void perf_sched_cb_dec(struct pmu *pmu)
 {
 	struct perf_cpu_context *cpuctx = this_cpu_ptr(pmu->pmu_cpu_context);
 
-	this_cpu_dec(perf_sched_cb_usages);
-
-	if (!--cpuctx->sched_cb_usage)
-		list_del(&cpuctx->sched_cb_entry);
+	--cpuctx->sched_cb_usage;
 }
 
 
@@ -3477,10 +3485,7 @@ void perf_sched_cb_inc(struct pmu *pmu)
 {
 	struct perf_cpu_context *cpuctx = this_cpu_ptr(pmu->pmu_cpu_context);
 
-	if (!cpuctx->sched_cb_usage++)
-		list_add(&cpuctx->sched_cb_entry, this_cpu_ptr(&sched_cb_list));
-
-	this_cpu_inc(perf_sched_cb_usages);
+	cpuctx->sched_cb_usage++;
 }
 
 /*
@@ -3509,20 +3514,6 @@ static void __perf_pmu_sched_task(struct perf_cpu_context *cpuctx, bool sched_in
 	perf_ctx_unlock(cpuctx, cpuctx->task_ctx);
 }
 
-static void perf_pmu_sched_task(struct task_struct *prev,
-				struct task_struct *next,
-				bool sched_in)
-{
-	struct perf_cpu_context *cpuctx;
-
-	if (prev == next)
-		return;
-
-	list_for_each_entry(cpuctx, this_cpu_ptr(&sched_cb_list), sched_cb_entry)
-		__perf_pmu_sched_task(cpuctx, sched_in);
-
-}
-
 static void perf_event_switch(struct task_struct *task,
 			      struct task_struct *next_prev, bool sched_in);
 
@@ -3545,9 +3536,6 @@ void __perf_event_task_sched_out(struct task_struct *task,
 {
 	int ctxn;
 
-	if (__this_cpu_read(perf_sched_cb_usages))
-		perf_pmu_sched_task(task, next, false);
-
 	if (atomic_read(&nr_switch_events))
 		perf_event_switch(task, next, false);
 
@@ -12850,7 +12838,6 @@ static void __init perf_event_init_all_cpus(void)
 #ifdef CONFIG_CGROUP_PERF
 		INIT_LIST_HEAD(&per_cpu(cgrp_cpuctx_list, cpu));
 #endif
-		INIT_LIST_HEAD(&per_cpu(sched_cb_list, cpu));
 	}
 }
 
-- 
2.17.1

