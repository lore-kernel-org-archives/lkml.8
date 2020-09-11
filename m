Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8C4BC43461
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 07:04:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EA1F221EE
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 07:04:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MIYF9bXY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uMUcAMuJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725844AbgIKHEI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 03:04:08 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:45110 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725786AbgIKHCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 03:02:33 -0400
Date:   Fri, 11 Sep 2020 07:02:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599807749;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=daWq2XO2fjGJ3kJ6pYkaVRIuo6C4pUxuCjADseWC16s=;
        b=MIYF9bXY/bj+VO1C4hSnS8X3bX44zZ+gkS/NVJTDCKDl5+wEkTfmLbJKSnE+eh7wP0mDzE
        oAapFkLHPp0+i2fTALa9SfebXQIw/XfddjK6ecdudSOUvSt79y/gff72X4cBLrCE9cBvq9
        ecI16ePH/qE/Fij9BRC7DVv5+Uqtk5efWrDPBv4bLmFGpeXFWl+9o8X6VxwsuAwYyOCMec
        puI/ExNlaiTBlpkYv2H7UUdGW2Trhw1xUI4P2eK2LNfGeU4pAJCy7YKxLp9LZyrKsUS95U
        CLu/E/KnALO+12mlT8fRmbHUQ/FtO8okLwPQAVxJ9eOlN5ehGR779t/nQo+dkg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599807749;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=daWq2XO2fjGJ3kJ6pYkaVRIuo6C4pUxuCjADseWC16s=;
        b=uMUcAMuJcsY3nvh6oDZmJrJHdfd3fsP3Ta1IdKitQOelMVuerq7WRpgm363vID3Bmuq3Ji
        P0KDfsvN1TcnJLDQ==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/core: Pull pmu::sched_task() into
 perf_event_context_sched_out()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200821195754.20159-2-kan.liang@linux.intel.com>
References: <20200821195754.20159-2-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <159980774909.20229.18111367837276580444.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     44fae179ce73a26733d9e2d346da4e1a1cb94647
Gitweb:        https://git.kernel.org/tip/44fae179ce73a26733d9e2d346da4e1a1cb94647
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Fri, 21 Aug 2020 12:57:53 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 10 Sep 2020 11:19:34 +02:00

perf/core: Pull pmu::sched_task() into perf_event_context_sched_out()

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
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200821195754.20159-2-kan.liang@linux.intel.com
---
 include/linux/perf_event.h |  1 +-
 kernel/events/core.c       | 47 +++++++++++++------------------------
 2 files changed, 17 insertions(+), 31 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 46a3974..0c19d27 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -872,7 +872,6 @@ struct perf_cpu_context {
 	struct list_head		cgrp_cpuctx_entry;
 #endif
 
-	struct list_head		sched_cb_entry;
 	int				sched_cb_usage;
 
 	int				online;
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 3f5fec4..45edb85 100644
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
@@ -3455,21 +3462,22 @@ unlock:
 
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
 
@@ -12867,7 +12855,6 @@ static void __init perf_event_init_all_cpus(void)
 #ifdef CONFIG_CGROUP_PERF
 		INIT_LIST_HEAD(&per_cpu(cgrp_cpuctx_list, cpu));
 #endif
-		INIT_LIST_HEAD(&per_cpu(sched_cb_list, cpu));
 	}
 }
 
