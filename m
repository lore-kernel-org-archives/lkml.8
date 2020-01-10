Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18BFDC33CA2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 12:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBE1D2080D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 12:59:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FXG42iVg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbgAJM74 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 07:59:56 -0500
Received: from merlin.infradead.org ([205.233.59.134]:39724 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727174AbgAJM74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 07:59:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=gMEIn5cfU0kguddr2CfamNQ6FPFiWCJ2CFUWs8P896A=; b=FXG42iVgUmLsG6XR7cph0kjt2
        2TwwaBftKcDNwkLe1nZ4amPWmRBENVNdWbVcr0qQFrbKMQowfXiR4V0BtNq9LS+jRNrryNSoEtg4r
        82lrjYDtSM71/394QOCrHX4bn8/V6+2LeLMcvPUfDXsX9q/jVeAAWFlG85ySQJYestdBApdU5iDRQ
        gSCglaru5ft5sQU5oWcaYlrng2/BuUM2Q0+dUtm2bEVo4JHGvHjmUSObxEBdTiLuz3yO1lactCH8N
        F4HHabCPB2wOZXV3Ojs0LQETzPxOE6LyzcJ49HOn/THD2Hq6Xr2l94vB0lxTQ0P7TPHNNFcY5D7jr
        ZgHMmb9/A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ipttF-0003MO-6N; Fri, 10 Jan 2020 12:59:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9C96F30025A;
        Fri, 10 Jan 2020 13:58:10 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8A4942B5FCA6A; Fri, 10 Jan 2020 13:59:44 +0100 (CET)
Date:   Fri, 10 Jan 2020 13:59:44 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v9] perf: Sharing PMU counters across compatible events
Message-ID: <20200110125944.GJ2844@hirez.programming.kicks-ass.net>
References: <20191217175948.3298747-1-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191217175948.3298747-1-songliubraving@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2019 at 09:59:48AM -0800, Song Liu wrote:

This is starting to look good, find a few comments below.

>  include/linux/perf_event.h |  13 +-
>  kernel/events/core.c       | 363 ++++++++++++++++++++++++++++++++-----
>  2 files changed, 332 insertions(+), 44 deletions(-)
> 
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index 6d4c22aee384..45a346ee33d2 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -547,7 +547,9 @@ enum perf_event_state {
>  	PERF_EVENT_STATE_ERROR		= -2,
>  	PERF_EVENT_STATE_OFF		= -1,
>  	PERF_EVENT_STATE_INACTIVE	=  0,
> -	PERF_EVENT_STATE_ACTIVE		=  1,
> +	/* the hw PMC is enabled, but this event is not counting */
> +	PERF_EVENT_STATE_ENABLED	=  1,
> +	PERF_EVENT_STATE_ACTIVE		=  2,
>  };

It's probably best to extend the comment above instead of adding a
comment for one of the states.

>  
>  struct file;

> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 4ff86d57f9e5..7d4b6ac46de5 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -1657,6 +1657,181 @@ perf_event_groups_next(struct perf_event *event)
>  		event = rb_entry_safe(rb_next(&event->group_node),	\
>  				typeof(*event), group_node))
>  
> +static inline bool perf_event_can_share(struct perf_event *event)
> +{
> +	/* only share hardware counting events */
> +	return !is_sampling_event(event);
> +	return !is_software_event(event) && !is_sampling_event(event);

One of those return statements is too many; I'm thinking you meant to
only have the second.

> +}
> +

> +/* After adding a event to the ctx, try find compatible event(s). */
> +static void perf_event_setup_dup(struct perf_event *event,
> +				 struct perf_event_context *ctx)
> +
> +{
> +	struct perf_event *tmp;
> +
> +	if (event->dup_master ||
> +	    event->state != PERF_EVENT_STATE_INACTIVE ||
> +	    !perf_event_can_share(event))
> +		return;
> +
> +	/* look for dup with other events */
> +	list_for_each_entry(tmp, &ctx->event_list, event_entry) {
> +		WARN_ON_ONCE(tmp->state > PERF_EVENT_STATE_INACTIVE);
> +
> +		if (tmp == event ||
> +		    tmp->state != PERF_EVENT_STATE_INACTIVE ||
> +		    !perf_event_can_share(tmp) ||
> +		    !perf_event_compatible(event, tmp))
> +			continue;
> +
> +		/* first dup, pick tmp as the master */
> +		if (!tmp->dup_master)
> +			perf_event_init_dup_master(tmp);
> +
> +		event->dup_master = tmp->dup_master;
> +		break;
> +	}
> +}
> +
> +static int event_pmu_add(struct perf_event *event,
> +			 struct perf_event_context *ctx);
> +
> +/* Remove dup_master for the event */
> +static void perf_event_remove_dup(struct perf_event *event,
> +				  struct perf_cpu_context *cpuctx,
> +				  struct perf_event_context *ctx)
> +
> +{
> +	struct perf_event *tmp, *new_master;
> +	int count, active_count;
> +
> +	/* no sharing */
> +	if (!event->dup_master)
> +		return;
> +
> +	WARN_ON_ONCE(event->state < PERF_EVENT_STATE_OFF ||
> +		     event->state > PERF_EVENT_STATE_ENABLED);
> +
> +	/* this event is not the master */
> +	if (event->dup_master != event) {
> +		event_sync_dup_count(event, event->dup_master);
> +		event->dup_master = NULL;
> +		return;
> +	}
> +
> +	/* this event is the master */
> +	count = 0;
> +	new_master = NULL;
> +	list_for_each_entry(tmp, &ctx->event_list, event_entry) {
> +		if (tmp->dup_master != event || tmp == event)
> +			continue;
> +		if (!new_master)
> +			new_master = tmp;
> +		if (tmp->state == PERF_EVENT_STATE_ACTIVE) {
> +			event_sync_dup_count(tmp, event);
> +			tmp->dup_base_count = local64_read(&new_master->count);
> +			tmp->dup_base_child_count =
> +				atomic64_read(&new_master->child_count);
> +		}
> +		tmp->dup_master = new_master;
> +		count++;
> +	}
> +
> +	active_count = event->dup_active_count;
> +	perf_event_exit_dup_master(event);
> +
> +	if (!count)
> +		return;
> +
> +	if (count == 1) {
> +		/* no more sharing */
> +		new_master->dup_master = NULL;
> +	} else {
> +		perf_event_init_dup_master(new_master);
> +		new_master->dup_active_count = active_count;
> +	}
> +
> +	if (active_count) {

Would it make sense to do something like:

		new_master->hw.idx = event->hw.idx;

That should ensure x86_schedule_events() can do with the fast path;
after all, we're adding back the 'same' event. If we do this; this wants
a comment though.

> +		WARN_ON_ONCE(event->pmu->add(new_master, PERF_EF_START));

For consistency that probably ought to be:

		new_master->pmu->add(new_master, PERF_EF_START);

> +		if (new_master->state == PERF_EVENT_STATE_INACTIVE)
> +			new_master->state = PERF_EVENT_STATE_ENABLED;

If this really should not be perf_event_set_state() we need a comment
explaining why -- I think I see, but it's still early and I've not had
nearly enough tea to wake me up.

> +	}
> +}
> +
>  /*
>   * Add an event from the lists for its context.
>   * Must be called with ctx->mutex and ctx->lock held.
> @@ -1902,7 +2077,8 @@ perf_aux_output_match(struct perf_event *event, struct perf_event *aux_event)
>  static void put_event(struct perf_event *event);
>  static void event_sched_out(struct perf_event *event,
>  			    struct perf_cpu_context *cpuctx,
> -			    struct perf_event_context *ctx);
> +			    struct perf_event_context *ctx,
> +			    bool remove_dup);
>  
>  static void perf_put_aux_event(struct perf_event *event)
>  {

>  static void
>  event_sched_out(struct perf_event *event,
>  		  struct perf_cpu_context *cpuctx,
> -		  struct perf_event_context *ctx)
> +		struct perf_event_context *ctx,
> +		bool remove_dup)
>  {
>  	enum perf_event_state state = PERF_EVENT_STATE_INACTIVE;
>  
>  	WARN_ON_ONCE(event->ctx != ctx);
>  	lockdep_assert_held(&ctx->lock);
>  
> -	if (event->state != PERF_EVENT_STATE_ACTIVE)
> +	if (event->state < PERF_EVENT_STATE_ENABLED) {
> +		if (remove_dup)
> +			perf_event_remove_dup(event, cpuctx, ctx);
>  		return;
> +	}
>  
>  	/*
>  	 * Asymmetry; we only schedule events _IN_ through ctx_sched_in(), but
> @@ -2106,15 +2343,20 @@ event_sched_out(struct perf_event *event,
>  
>  	perf_pmu_disable(event->pmu);
>  
> -	event->pmu->del(event, 0);
> +	event_pmu_del(event, ctx, remove_dup);
>  	event->oncpu = -1;
>  
>  	if (READ_ONCE(event->pending_disable) >= 0) {
>  		WRITE_ONCE(event->pending_disable, -1);
>  		state = PERF_EVENT_STATE_OFF;
> -	}
> +	} else if (event->dup_master == event &&
> +		   event->dup_active_count)
> +		state = PERF_EVENT_STATE_ENABLED;
>  	perf_event_set_state(event, state);
>  
> +	if (remove_dup)
> +		perf_event_remove_dup(event, cpuctx, ctx);
> +
>  	if (!is_software_event(event))
>  		cpuctx->active_oncpu--;
>  	if (!--ctx->nr_active)

> @@ -2174,7 +2426,7 @@ __perf_remove_from_context(struct perf_event *event,
>  		update_cgrp_time_from_cpuctx(cpuctx);
>  	}
>  
> -	event_sched_out(event, cpuctx, ctx);
> +	event_sched_out(event, cpuctx, ctx, true);
>  	if (flags & DETACH_GROUP)
>  		perf_group_detach(event);
>  	list_del_event(event, ctx);
> @@ -2242,9 +2494,9 @@ static void __perf_event_disable(struct perf_event *event,
>  	}
>  
>  	if (event == event->group_leader)
> -		group_sched_out(event, cpuctx, ctx);
> +		group_sched_out(event, cpuctx, ctx, true);
>  	else
> -		event_sched_out(event, cpuctx, ctx);
> +		event_sched_out(event, cpuctx, ctx, true);
>  
>  	perf_event_set_state(event, PERF_EVENT_STATE_OFF);
>  }

So the above event_sched_out(.remove_dup) is very inconsistent with the
below ctx_resched(.event_add_dup).

> @@ -2544,7 +2793,8 @@ static void perf_event_sched_in(struct perf_cpu_context *cpuctx,
>   */
>  static void ctx_resched(struct perf_cpu_context *cpuctx,
>  			struct perf_event_context *task_ctx,
> -			enum event_type_t event_type)
> +			enum event_type_t event_type,
> +			struct perf_event *event_add_dup)
>  {
>  	enum event_type_t ctx_event_type;
>  	bool cpu_event = !!(event_type & EVENT_CPU);
> @@ -2574,6 +2824,12 @@ static void ctx_resched(struct perf_cpu_context *cpuctx,
>  	else if (ctx_event_type & EVENT_PINNED)
>  		cpu_ctx_sched_out(cpuctx, EVENT_FLEXIBLE);
>  
> +	if (event_add_dup) {
> +		if (event_add_dup->ctx->is_active)
> +			ctx_sched_out(event_add_dup->ctx, cpuctx, EVENT_ALL);
> +		perf_event_setup_dup(event_add_dup, event_add_dup->ctx);
> +	}
> +
>  	perf_event_sched_in(cpuctx, task_ctx, current);
>  	perf_pmu_enable(cpuctx->ctx.pmu);
>  }

> @@ -2642,9 +2898,10 @@ static int  __perf_install_in_context(void *info)
>  	if (reprogram) {
>  		ctx_sched_out(ctx, cpuctx, EVENT_TIME);
>  		add_event_to_ctx(event, ctx);
> -		ctx_resched(cpuctx, task_ctx, get_event_type(event));
> +		ctx_resched(cpuctx, task_ctx, get_event_type(event), event);
>  	} else {
>  		add_event_to_ctx(event, ctx);
> +		perf_event_setup_dup(event, ctx);
>  	}
>  
>  unlock:
> @@ -2789,8 +3046,10 @@ static void __perf_event_enable(struct perf_event *event,
>  
>  	perf_event_set_state(event, PERF_EVENT_STATE_INACTIVE);
>  
> -	if (!ctx->is_active)
> +	if (!ctx->is_active) {
> +		perf_event_setup_dup(event, ctx);
>  		return;
> +	}
>  
>  	if (!event_filter_match(event)) {
>  		ctx_sched_in(ctx, cpuctx, EVENT_TIME, current);
> @@ -2801,7 +3060,7 @@ static void __perf_event_enable(struct perf_event *event,
>  	 * If the event is in a group and isn't the group leader,
>  	 * then don't put it on unless the group is on.
>  	 */
> -	if (leader != event && leader->state != PERF_EVENT_STATE_ACTIVE) {
> +	if (leader != event && leader->state <= PERF_EVENT_STATE_INACTIVE) {
>  		ctx_sched_in(ctx, cpuctx, EVENT_TIME, current);
>  		return;
>  	}
> @@ -2810,7 +3069,7 @@ static void __perf_event_enable(struct perf_event *event,
>  	if (ctx->task)
>  		WARN_ON_ONCE(task_ctx != ctx);
>  
> -	ctx_resched(cpuctx, task_ctx, get_event_type(event));
> +	ctx_resched(cpuctx, task_ctx, get_event_type(event), event);
>  }
>  
>  /*

We basically need:

 * perf_event_setup_dup() after add_event_to_ctx(), but before *sched_in()
   - perf_install_in_context()
   - perf_event_enable()
   - inherit_event()

 * perf_event_remove_dup() after *sched_out(), but before list_del_event()
   - perf_remove_from_context()
   - perf_event_disable()

AFAICT we can do that without changing *sched_out() and ctx_resched(),
with probably less lines changed over all.

> @@ -4051,6 +4310,9 @@ static void __perf_event_read(void *info)
>  
>  static inline u64 perf_event_count(struct perf_event *event)
>  {
> +	if (event->dup_master == event)
> +		return local64_read(&event->master_count) +
> +			atomic64_read(&event->master_child_count);

Wants {}

>  	return local64_read(&event->count) + atomic64_read(&event->child_count);
>  }
