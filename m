Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0351C10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 19:33:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DE8720724
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 19:33:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lA3WU+5y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbgCRTdw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 15:33:52 -0400
Received: from merlin.infradead.org ([205.233.59.134]:37906 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbgCRTdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 15:33:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/PXrI2NzI48Au3agJng47sb06euiDY6rgfHR67odMe0=; b=lA3WU+5y3nx6Cbhbku85ivI8+/
        wdYwjhki9ojXpHFiY4xGvRwgfttQuRqtMOQBGlFuAXknCFSQzE8MSF/hCDpy/AE36x7kRjkn9HYDw
        mg4Cw/j5AUW0BzJxgBqGq7CN815RCgjbmEXFCDZ6OmGRUHKGUqsMbuZYm0MdcxePrsg8c04ISCSpJ
        eJs8t7dSrTfI2P0tAgLSJ7CUYs/ZpDFLl8mUxkuD2PGqOm/+k+s7sC+88JOS5thSi6LJhHgKVyxHy
        PxQCs/n4X4tmT0reqoohYqDLVQwOMosJIoA046VnaV3btIGE3T92SYgpjjYjMF+LsR5X+y3/0Fv5o
        /EYEoBRQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jEeRg-0002YL-ME; Wed, 18 Mar 2020 19:33:41 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 52937300606;
        Wed, 18 Mar 2020 20:33:37 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 40DFB284DBF6E; Wed, 18 Mar 2020 20:33:37 +0100 (CET)
Date:   Wed, 18 Mar 2020 20:33:37 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Andi Kleen <andi@firstfloor.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2] perf/core: install cgroup events to correct cpuctx
Message-ID: <20200318193337.GB20760@hirez.programming.kicks-ass.net>
References: <20200122195027.2112449-1-songliubraving@fb.com>
 <20200124091552.GB14914@hirez.programming.kicks-ass.net>
 <83AF3F97-7F98-4D52-A230-F04A0AB67284@fb.com>
 <7BA78C8F-9D71-4BDB-BCCE-3036DCF3C653@fb.com>
 <20200318180535.GJ20730@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200318180535.GJ20730@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 18, 2020 at 07:05:35PM +0100, Peter Zijlstra wrote:
> On Wed, Mar 18, 2020 at 07:07:29AM +0000, Song Liu wrote:

> > Could you please share your thoughts on this? I think we cannot use current
> > in list_update_cgroup_event(), unless we call it on the target CPU. 
> 
> Bah, that cgroup crap is 'wrong'. It's pointless to track the
> cpuctx->cgrp state for disabled events.
> 
> Let me see if I can unravel that crud.

This compiles, but I've no clue how to operate cgroups. Please test.

---
 kernel/events/core.c | 70 ++++++++++++++++++++++++++++++++--------------------
 1 file changed, 43 insertions(+), 27 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index ccf8d4fc6374..9f0713292cba 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -981,16 +981,10 @@ perf_cgroup_set_shadow_time(struct perf_event *event, u64 now)
 	event->shadow_ctx_time = now - t->timestamp;
 }
 
-/*
- * Update cpuctx->cgrp so that it is set when first cgroup event is added and
- * cleared when last cgroup event is removed.
- */
 static inline void
-list_update_cgroup_event(struct perf_event *event,
-			 struct perf_event_context *ctx, bool add)
+perf_cgroup_event_enable(struct perf_event *event, struct perf_event_context *ctx)
 {
 	struct perf_cpu_context *cpuctx;
-	struct list_head *cpuctx_entry;
 
 	if (!is_cgroup_event(event))
 		return;
@@ -1007,28 +1001,41 @@ list_update_cgroup_event(struct perf_event *event,
 	 * because if the first would mismatch, the second would not try again
 	 * and we would leave cpuctx->cgrp unset.
 	 */
-	if (add && !cpuctx->cgrp) {
+	if (ctx->is_active && !cpuctx->cgrp) {
 		struct perf_cgroup *cgrp = perf_cgroup_from_task(current, ctx);
 
 		if (cgroup_is_descendant(cgrp->css.cgroup, event->cgrp->css.cgroup))
 			cpuctx->cgrp = cgrp;
 	}
 
-	if (add && ctx->nr_cgroups++)
+	if (ctx->nr_cgroups++)
 		return;
-	else if (!add && --ctx->nr_cgroups)
+
+	list_add(&cpuctx->cgrp_cpuctx_entry,
+			per_cpu_ptr(&cgrp_cpuctx_list, event->cpu));
+}
+
+static inline void
+perf_cgroup_event_disable(struct perf_event *event, struct perf_event_context *ctx)
+{
+	struct perf_cpu_context *cpuctx;
+
+	if (!is_cgroup_event(event))
 		return;
 
-	/* no cgroup running */
-	if (!add)
+	/*
+	 * Because cgroup events are always per-cpu events,
+	 * @ctx == &cpuctx->ctx.
+	 */
+	cpuctx = container_of(ctx, struct perf_cpu_context, ctx);
+
+	if (--ctx->nr_cgroups)
+		return;
+
+	if (ctx->is_active && cpuctx->cgrp)
 		cpuctx->cgrp = NULL;
 
-	cpuctx_entry = &cpuctx->cgrp_cpuctx_entry;
-	if (add)
-		list_add(cpuctx_entry,
-			 per_cpu_ptr(&cgrp_cpuctx_list, event->cpu));
-	else
-		list_del(cpuctx_entry);
+	list_del(&cpuctx->cgrp_cpuctx_entry);
 }
 
 #else /* !CONFIG_CGROUP_PERF */
@@ -1094,11 +1101,14 @@ static inline u64 perf_cgroup_event_time(struct perf_event *event)
 }
 
 static inline void
-list_update_cgroup_event(struct perf_event *event,
-			 struct perf_event_context *ctx, bool add)
+perf_cgroup_event_enable(struct perf_event *event, struct perf_event_context *ctx)
 {
 }
 
+static inline void
+perf_cgroup_event_disable(struct perf_event *event, struct perf_event_context *ctx)
+{
+}
 #endif
 
 /*
@@ -1789,13 +1799,14 @@ list_add_event(struct perf_event *event, struct perf_event_context *ctx)
 		add_event_to_groups(event, ctx);
 	}
 
-	list_update_cgroup_event(event, ctx, true);
-
 	list_add_rcu(&event->event_entry, &ctx->event_list);
 	ctx->nr_events++;
 	if (event->attr.inherit_stat)
 		ctx->nr_stat++;
 
+	if (event->state > PERF_EVENT_STATE_OFF)
+		perf_cgroup_event_enable(event, ctx);
+
 	ctx->generation++;
 }
 
@@ -1971,8 +1982,6 @@ list_del_event(struct perf_event *event, struct perf_event_context *ctx)
 
 	event->attach_state &= ~PERF_ATTACH_CONTEXT;
 
-	list_update_cgroup_event(event, ctx, false);
-
 	ctx->nr_events--;
 	if (event->attr.inherit_stat)
 		ctx->nr_stat--;
@@ -1989,8 +1998,10 @@ list_del_event(struct perf_event *event, struct perf_event_context *ctx)
 	 * of error state is by explicit re-enabling
 	 * of the event
 	 */
-	if (event->state > PERF_EVENT_STATE_OFF)
+	if (event->state > PERF_EVENT_STATE_OFF) {
+		perf_cgroup_event_disable(event, ctx);
 		perf_event_set_state(event, PERF_EVENT_STATE_OFF);
+	}
 
 	ctx->generation++;
 }
@@ -2221,6 +2232,7 @@ event_sched_out(struct perf_event *event,
 
 	if (READ_ONCE(event->pending_disable) >= 0) {
 		WRITE_ONCE(event->pending_disable, -1);
+		perf_cgroup_event_disable(event, ctx);
 		state = PERF_EVENT_STATE_OFF;
 	}
 	perf_event_set_state(event, state);
@@ -2357,6 +2369,7 @@ static void __perf_event_disable(struct perf_event *event,
 		event_sched_out(event, cpuctx, ctx);
 
 	perf_event_set_state(event, PERF_EVENT_STATE_OFF);
+	perf_cgroup_event_disable(event, ctx);
 }
 
 /*
@@ -2740,7 +2753,7 @@ static int  __perf_install_in_context(void *info)
 	}
 
 #ifdef CONFIG_CGROUP_PERF
-	if (is_cgroup_event(event)) {
+	if (event->state > PERF_EVENT_STATE_OFF && is_cgroup_event(event)) {
 		/*
 		 * If the current cgroup doesn't match the event's
 		 * cgroup, we should not try to schedule it.
@@ -2900,6 +2913,7 @@ static void __perf_event_enable(struct perf_event *event,
 		ctx_sched_out(ctx, cpuctx, EVENT_TIME);
 
 	perf_event_set_state(event, PERF_EVENT_STATE_INACTIVE);
+	perf_cgroup_event_enable(event, ctx);
 
 	if (!ctx->is_active)
 		return;
@@ -3609,8 +3623,10 @@ static int merge_sched_in(struct perf_event *event, void *data)
 	}
 
 	if (event->state == PERF_EVENT_STATE_INACTIVE) {
-		if (event->attr.pinned)
+		if (event->attr.pinned) {
+			perf_cgroup_event_disable(event, ctx);
 			perf_event_set_state(event, PERF_EVENT_STATE_ERROR);
+		}
 
 		*can_add_hw = 0;
 		ctx->rotate_necessary = 1;
