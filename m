Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC2EC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 07:04:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0ACFB221EE
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 07:04:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qXnUgR55";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pXUz3l9I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725837AbgIKHEI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 03:04:08 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:45114 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725784AbgIKHCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 03:02:33 -0400
Date:   Fri, 11 Sep 2020 07:02:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599807750;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x9xhOXO6hC2oi3qDXk3xOR2+jCWyVeHscYRW0pSrS18=;
        b=qXnUgR55PKquX5MOpORWwrtE6LSM0nAdHuDG/jLVGNKwltW9HL0x//91wj0qGr8Zzt8Obz
        K1935/mXN6sCVthTJB0EoIYfCbNY1BLx7a0lP9e6SOpJAOd2SXPkiqF1WBt1mkGQ+k8saR
        JpeggvKISpgHWI3AdDNza1+dFfAoS9BY5d7gg9ZgdVOlDmjcHtqSj9834K+mzOam+FIrxK
        ZWy15Wbj6z/uwgGZm4GTmJVm0j3I7c2XamBZo73jrbUs3v0wg98Zq1zmIFj7BGstP7Og8p
        BQbXh1bZ681LNEQoErlyAmS0+Ka534CO/kQMc8f6DEh9yQbILjXXkra0/xCJDQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599807750;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x9xhOXO6hC2oi3qDXk3xOR2+jCWyVeHscYRW0pSrS18=;
        b=pXUz3l9IpjjK2VUp5k1sV8wZCtT4rwnb81pQ+IvVQ6tC7DTO0MILrW7J7Xcy3AY1YQZqK2
        gZh0DRKiyswdjQBw==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/core: Pull pmu::sched_task() into
 perf_event_context_sched_in()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200821195754.20159-1-kan.liang@linux.intel.com>
References: <20200821195754.20159-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <159980774960.20229.6421010341102339837.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     556cccad389717d6eb4f5a24b45ff41cad3aaabf
Gitweb:        https://git.kernel.org/tip/556cccad389717d6eb4f5a24b45ff41cad3aaabf
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Fri, 21 Aug 2020 12:57:52 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 10 Sep 2020 11:19:34 +02:00

perf/core: Pull pmu::sched_task() into perf_event_context_sched_in()

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
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200821195754.20159-1-kan.liang@linux.intel.com
---
 kernel/events/core.c | 51 ++++++++++++++++++++++++++-----------------
 1 file changed, 31 insertions(+), 20 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 57efe3b..3f5fec4 100644
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
