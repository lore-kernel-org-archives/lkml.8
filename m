Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4D05C3F2D1
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 21:08:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A09EB208C3
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 21:08:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Jj3yieUh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732379AbgCCVIV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 16:08:21 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:43292 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732305AbgCCVIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 16:08:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6O6fbkfkYGCe9b79ekUjZYR81XFo81dBGsl7YghXNvU=; b=Jj3yieUhLOGVX8uFIwdAAZlj3N
        Oac1Nqw1P7MUBmhk4kCkmZwA/Y8d1Sp9Zowvb/3Pan4OStjIuHiGPJVNb+V46XhtF2GRH43BgPVcM
        EqH/k5KN/3r2IrFnbFOcgULl8gqrWbX/Ex7ks/IJQkxI1Qw8wzcK4fXIhxeZMlthjcKrRV2nU81jr
        dxjblvMzmG+THgmwHOLzmwFKzZeHYUpjXvL1B3VKy8p04RIjOE7yA1cmolh9InmTpy8i5cBDov3iy
        fE3ylbdcvo8pkV0Vdv1Js5JmNJVlsTE3JGaojazCC1TKylDpdEh01hxkbQuHHuQxfRXhjeuPJ0qsE
        yugZFpiw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j9Elz-0007Wz-1M; Tue, 03 Mar 2020 21:08:15 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 87460980E5A; Tue,  3 Mar 2020 22:08:12 +0100 (CET)
Date:   Tue, 3 Mar 2020 22:08:12 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org, irogers@google.com,
        eranian@google.com, ak@linux.intel.com
Subject: Re: [PATCH] perf/core: Fix endless multiplex timer
Message-ID: <20200303210812.GA4745@worktop.programming.kicks-ass.net>
References: <20200303202819.3942-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200303202819.3942-1-kan.liang@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 03, 2020 at 12:28:19PM -0800, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> A lot of time are spent in writing uncore MSRs even though no perf is
> running.
> 
>   4.66%  swapper      [kernel.kallsyms]        [k] native_write_msr
>             |
>              --4.56%--native_write_msr
>                        |
>                        |--1.68%--snbep_uncore_msr_enable_box
>                        |          perf_mux_hrtimer_handler
>                        |          __hrtimer_run_queues
>                        |          hrtimer_interrupt
>                        |          smp_apic_timer_interrupt
>                        |          apic_timer_interrupt
>                        |          cpuidle_enter_state
>                        |          cpuidle_enter
>                        |          do_idle
>                        |          cpu_startup_entry
>                        |          start_kernel
>                        |          secondary_startup_64
> 
> The root cause is that multiplex timer was not stopped when perf stat
> finished.
> Current perf relies on rotate_necessary to determine whether the
> multiplex timer should be stopped. The variable only be reset in
> ctx_sched_out(), which is not enough for system-wide event.
> Perf stat invokes PERF_EVENT_IOC_DISABLE to stop system-wide event
> before closing it.
>   perf_ioctl()
>     perf_event_disable()
>       event_sched_out()
> The rotate_necessary will never be reset.
> 
> The issue is a generic issue, not just impact the uncore.
> 
> Check whether we had been multiplexing. If yes, reset rotate_necessary
> for the last active event in __perf_event_disable().
> 
> Fixes: fd7d55172d1e ("perf/cgroups: Don't rotate events for cgroups unnecessarily")
> Reported-by: Andi Kleen <ak@linux.intel.com>
> Reviewed-by: Andi Kleen <ak@linux.intel.com>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
>  kernel/events/core.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 3f1f77de7247..50688de56181 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -2242,6 +2242,16 @@ static void __perf_event_disable(struct perf_event *event,
>  		update_cgrp_time_from_event(event);
>  	}
>  
> +	/*
> +	 * If we had been multiplexing,
> +	 * stop the rotations for the last active event.
> +	 * Only need to check system wide events.
> +	 * For task events, it will be checked in ctx_sched_out().
> +	 */
> +	if ((cpuctx->ctx.nr_events != cpuctx->ctx.nr_active) &&
> +	    (cpuctx->ctx.nr_active == 1))
> +		cpuctx->ctx.rotate_necessary = 0;
> +
>  	if (event == event->group_leader)
>  		group_sched_out(event, cpuctx, ctx);
>  	else


I'm thinking this is wrong.

That is, yes, this fixes the observed problem, but it also misses at
least one other site. Which seems to suggest we ought to take a
different approach.

But even with that; I wonder if the actual condition isn't wrong.
Suppose the event was exclusive, and other events weren't scheduled
because of that. Then you disable the one exclusive event _and_ kill
rotation, so then nothing else will ever get on.

So what I think was supposed to happen is rotation killing itself;
rotation will schedule out the context -- which will clear the flag, and
then schedule the thing back in -- which will set the flag again when
needed.

Now, that isn't happening, and I think I see why, because when we drop
to !nr_active, we terminate ctx_sched_out() before we get to clearing
the flag, oops!

So how about something like this?

---
diff --git a/kernel/events/core.c b/kernel/events/core.c
index e453589da97c..7947bd3271a9 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2182,6 +2182,7 @@ __perf_remove_from_context(struct perf_event *event,
 
 	if (!ctx->nr_events && ctx->is_active) {
 		ctx->is_active = 0;
+		ctx->rotate_necessary = 0;
 		if (ctx->task) {
 			WARN_ON_ONCE(cpuctx->task_ctx != ctx);
 			cpuctx->task_ctx = NULL;
@@ -3074,15 +3075,15 @@ static void ctx_sched_out(struct perf_event_context *ctx,
 
 	is_active ^= ctx->is_active; /* changed bits */
 
-	if (!ctx->nr_active || !(is_active & EVENT_ALL))
-		return;
-
 	/*
 	 * If we had been multiplexing, no rotations are necessary, now no events
 	 * are active.
 	 */
 	ctx->rotate_necessary = 0;
 
+	if (!ctx->nr_active || !(is_active & EVENT_ALL))
+		return;
+
 	perf_pmu_disable(ctx->pmu);
 	if (is_active & EVENT_PINNED) {
 		list_for_each_entry_safe(event, tmp, &ctx->pinned_active, active_list)
