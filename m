Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54097C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 19:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 362442072D
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 19:59:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbgHUT7W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 15:59:22 -0400
Received: from mga03.intel.com ([134.134.136.65]:3372 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726693AbgHUT7I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 15:59:08 -0400
IronPort-SDR: t1X6C1YG89zdUDz2yWyo85E5CIhojqnHChcevDuSxnmSun+RDn9aTbZwEG7QDUs38/aMwsvcMj
 axXnQ1WuD6Mg==
X-IronPort-AV: E=McAfee;i="6000,8403,9720"; a="155604697"
X-IronPort-AV: E=Sophos;i="5.76,338,1592895600"; 
   d="scan'208";a="155604697"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2020 12:59:07 -0700
IronPort-SDR: inzqbO0QA4Zl+zgpSh/70TY2Cq5BdNCVpJk0L6HVtq0q2j5hYxkEQRD6SSqyifQalJfCO4VGkd
 j+epq2KLE1Dg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,338,1592895600"; 
   d="scan'208";a="330137755"
Received: from labuser-ice-lake-client-platform.jf.intel.com ([10.54.55.65])
  by fmsmga002.fm.intel.com with ESMTP; 21 Aug 2020 12:59:06 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ak@linux.intel.com, mark.rutland@arm.com, luto@amacapital.net,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V2 1/3] perf/core: Pull pmu::sched_task() into perf_event_context_sched_in()
Date:   Fri, 21 Aug 2020 12:57:52 -0700
Message-Id: <20200821195754.20159-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The pmu::sched_task() is a context switch callback. It passes the
cpuctx->task_ctx as a parameter to the lower code. To find the
cpuctx->task_ctx, the current code iterates a cpuctx list.

The same context was just iterated in perf_event_context_sched_in(),
which is invoked right before the pmu::sched_task().

Reuse the cpuctx->task_ctx from perf_event_context_sched_in() can avoid
the unnecessary iteration of the cpuctx list.

Both pmu::sched_task and perf_event_context_sched_in() have to disable
PMU. Pull the pmu::sched_task into perf_event_context_sched_in() can
also save the overhead from the PMU disable and reenable.

The new and old tasks may have equivalent contexts. The current code
optimize this case by swapping the context, which avoids the scheduling.
For this case, pmu::sched_task() is still required, e.g., restore the
LBR content.

Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

New patch for V2

 kernel/events/core.c | 51 +++++++++++++++++++++++++++-----------------
 1 file changed, 31 insertions(+), 20 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 0fbf17ff7cc5..c785cbadbdb8 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -3491,30 +3491,36 @@ void perf_sched_cb_inc(struct pmu *pmu)
  * PEBS requires this to provide PID/TID information. This requires we flush
  * all queued PEBS records before we context switch to a new task.
  */
+static void __perf_pmu_sched_task(struct perf_cpu_context *cpuctx, bool sched_in)
+{
+	struct pmu *pmu;
+
+	pmu = cpuctx->ctx.pmu; /* software PMUs will not have sched_task */
+
+	if (WARN_ON_ONCE(!pmu->sched_task))
+		return;
+
+	perf_ctx_lock(cpuctx, cpuctx->task_ctx);
+	perf_pmu_disable(pmu);
+
+	pmu->sched_task(cpuctx->task_ctx, sched_in);
+
+	perf_pmu_enable(pmu);
+	perf_ctx_unlock(cpuctx, cpuctx->task_ctx);
+}
+
 static void perf_pmu_sched_task(struct task_struct *prev,
 				struct task_struct *next,
 				bool sched_in)
 {
 	struct perf_cpu_context *cpuctx;
-	struct pmu *pmu;
 
 	if (prev == next)
 		return;
 
-	list_for_each_entry(cpuctx, this_cpu_ptr(&sched_cb_list), sched_cb_entry) {
-		pmu = cpuctx->ctx.pmu; /* software PMUs will not have sched_task */
-
-		if (WARN_ON_ONCE(!pmu->sched_task))
-			continue;
-
-		perf_ctx_lock(cpuctx, cpuctx->task_ctx);
-		perf_pmu_disable(pmu);
-
-		pmu->sched_task(cpuctx->task_ctx, sched_in);
+	list_for_each_entry(cpuctx, this_cpu_ptr(&sched_cb_list), sched_cb_entry)
+		__perf_pmu_sched_task(cpuctx, sched_in);
 
-		perf_pmu_enable(pmu);
-		perf_ctx_unlock(cpuctx, cpuctx->task_ctx);
-	}
 }
 
 static void perf_event_switch(struct task_struct *task,
@@ -3773,10 +3779,14 @@ static void perf_event_context_sched_in(struct perf_event_context *ctx,
 					struct task_struct *task)
 {
 	struct perf_cpu_context *cpuctx;
+	struct pmu *pmu = ctx->pmu;
 
 	cpuctx = __get_cpu_context(ctx);
-	if (cpuctx->task_ctx == ctx)
+	if (cpuctx->task_ctx == ctx) {
+		if (cpuctx->sched_cb_usage)
+			__perf_pmu_sched_task(cpuctx, true);
 		return;
+	}
 
 	perf_ctx_lock(cpuctx, ctx);
 	/*
@@ -3786,7 +3796,7 @@ static void perf_event_context_sched_in(struct perf_event_context *ctx,
 	if (!ctx->nr_events)
 		goto unlock;
 
-	perf_pmu_disable(ctx->pmu);
+	perf_pmu_disable(pmu);
 	/*
 	 * We want to keep the following priority order:
 	 * cpu pinned (that don't need to move), task pinned,
@@ -3798,7 +3808,11 @@ static void perf_event_context_sched_in(struct perf_event_context *ctx,
 	if (!RB_EMPTY_ROOT(&ctx->pinned_groups.tree))
 		cpu_ctx_sched_out(cpuctx, EVENT_FLEXIBLE);
 	perf_event_sched_in(cpuctx, ctx, task);
-	perf_pmu_enable(ctx->pmu);
+
+	if (cpuctx->sched_cb_usage && pmu->sched_task)
+		pmu->sched_task(cpuctx->task_ctx, true);
+
+	perf_pmu_enable(pmu);
 
 unlock:
 	perf_ctx_unlock(cpuctx, ctx);
@@ -3841,9 +3855,6 @@ void __perf_event_task_sched_in(struct task_struct *prev,
 
 	if (atomic_read(&nr_switch_events))
 		perf_event_switch(task, prev, true);
-
-	if (__this_cpu_read(perf_sched_cb_usages))
-		perf_pmu_sched_task(prev, task, true);
 }
 
 static u64 perf_calculate_period(struct perf_event *event, u64 nsec, u64 count)
-- 
2.17.1

