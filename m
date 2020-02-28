Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C21FC3F2D0
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 09:36:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00CBF246A8
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 09:36:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RbVCAHge"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbgB1JgO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 04:36:14 -0500
Received: from merlin.infradead.org ([205.233.59.134]:36586 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726538AbgB1JgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 04:36:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ktulIN/2Y/Th6kw1gj8Ul/Cp6ielyuYE0DjV2+/3Dfg=; b=RbVCAHgeQiRRL5Q2dyVEiNQz+O
        c2I4yRgURpZqJ4Quv85cDXAe6ZR7DKMHQ0Dj1RxqORo3hBW8O7lDPBh5NKjSH5P5NNSd6v/vSgKKf
        QSOsXsl5Ne6iCscH4YhelsRtNQODwZhUdfUaqAXEsDL/HhSA0nr9RBPDYKq8YoCwvDPBEzGLWnfYq
        MKiZBxe0hAuLKTmebG0OGijhQZdxyJSExaC7QrXBxJuZwFIcF99MRQu5amc+44BglMnS9V8H/VGHd
        RBtM7f8itYXprwtEyTe/Yhee4CmzTgiMKxALvAA+CTt9NsX7woqYP4YMxSsBAROVeaYSRofPtPeye
        Hm8ma4qQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j7c3z-0000ki-AH; Fri, 28 Feb 2020 09:36:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D16FA300478;
        Fri, 28 Feb 2020 10:34:07 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2A01F2B9DC304; Fri, 28 Feb 2020 10:36:04 +0100 (CET)
Date:   Fri, 28 Feb 2020 10:36:04 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v10] perf: Sharing PMU counters across compatible events
Message-ID: <20200228093604.GH18400@hirez.programming.kicks-ass.net>
References: <20200123083127.446105-1-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200123083127.446105-1-songliubraving@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 23, 2020 at 12:31:27AM -0800, Song Liu wrote:
> This patch tries to enable PMU sharing. When multiple perf_events are
> counting the same metric, they can share the hardware PMU counter. We
> call these events as "compatible events".
> 
> The PMU sharing are limited to events within the same perf_event_context
> (ctx). When a event is installed or enabled, search the ctx for compatible
> events. This is implemented in perf_event_setup_dup(). One of these
> compatible events are picked as the master (stored in event->dup_master).
> Similarly, when the event is removed or disabled, perf_event_remove_dup()
> is used to clean up sharing.
> 
> A new state PERF_EVENT_STATE_ENABLED is introduced for the master event.
> This state is used when the slave event is ACTIVE, but the master event
> is not.

This is maybe not as clear as it could be; how do we end up there and
what are the ramifications. I spend a fair amount of time trying to work
out WTH we need that master_count thing.

> On the critical paths (add, del read), sharing PMU counters doesn't
> increase the complexity. Helper functions event_pmu_[add|del|read]() are
> introduced to cover these cases. All these functions have O(1) time
> complexity.

So the good news is that this patch looked entirely reasonable, and so I
had a good look at it. The bad news is that it is completely and utterly
broken...

> +/* prepare the dup_master, this event is its own dup_master */
> +static void perf_event_init_dup_master(struct perf_event *event)
> +{
> +	bool is_active = event->state == PERF_EVENT_STATE_ACTIVE;
> +	s64 count, child_count;
> +
> +	WARN_ON_ONCE(event->dup_active_count != 0);
> +	event->dup_master = event;
> +	/*
> +	 * dup_master->count is used by the hw PMC, and shared with other
> +	 * events, so we have to read from dup_master->master_count. Copy
> +	 * event->count to event->master_count.
> +	 *
> +	 * Same logic for child_count and master_child_count.

I _really_ don't see how that same applies to child_count, the PMU
driver does not ever touch that. In fact I think actually doing this for
the child_count is actively wrong.

> +	 */

One callsite does ->pmu->read() right before calling this, the other I'm
not sure about. It makes much more sense to do it here.

> +	count = local64_read(&event->count);

> +	child_count = atomic64_read(&event->child_count);
> +	local64_set(&event->master_count, count);
> +	atomic64_set(&event->master_child_count, child_count);
> +
> +	if (is_active) {
> +		event->dup_base_count = count;
> +		event->dup_base_child_count = child_count;
> +
> +		event->dup_active_count = 1;
> +	}

For active events, this function is completely buggered, fixable though.
See below.

> +}
> +
> +/* tear down dup_master, no more sharing for this event */
> +static void perf_event_exit_dup_master(struct perf_event *event)
> +{

This hard relies on event->state being <=INACTIVE, no assertion.

> +	event->dup_active_count = 0;
> +
> +	event->dup_master = NULL;
> +	/* restore event->count and event->child_count */
> +	local64_set(&event->count, local64_read(&event->master_count));
> +	atomic64_set(&event->child_count,
> +		     atomic64_read(&event->master_child_count));
> +}
> +
> +/*
> + * sync data count from dup_master to event, called on event_pmu_read()
> + * and event_pmu_del()
> + */
> +static void event_sync_dup_count(struct perf_event *event,
> +				 struct perf_event *master)
> +{
> +	u64 new_count;
> +	u64 new_child_count;
> +
> +	event->pmu->read(master);
> +	new_count = local64_read(&master->count);
> +	new_child_count = atomic64_read(&master->child_count);
> +
> +	if (event == master) {
> +		local64_add(new_count - event->dup_base_count,
> +			    &event->master_count);
> +		atomic64_add(new_child_count - event->dup_base_child_count,
> +			     &event->master_child_count);
> +	} else {
> +		local64_add(new_count - event->dup_base_count, &event->count);
> +		atomic64_add(new_child_count - event->dup_base_child_count,
> +			     &event->child_count);
> +	}
> +
> +	/* save dup_base_* for next sync */
> +	event->dup_base_count = new_count;
> +	event->dup_base_child_count = new_child_count;
> +}

This function is completely and utterly buggered. Even if you discount
all the child_count stuff.

See the thing is that while 'event->state == ACTIVE' an NMI can at all
times do pmu->read() on it. The above is trivially not NMI-safe.
Furthermore, the direct concequence of that is that ->dup_master and
->dup_count need to be consistent and *that* is violated pretty much all
over the place (perf_event_init_dup_master() for the active case for
instance).

> +
> +/* After adding a event to the ctx, try find compatible event(s). */
> +static void perf_event_setup_dup(struct perf_event *event,
> +				 struct perf_event_context *ctx)
> +
> +{
> +	struct perf_event *tmp;
> +
> +	if (!perf_event_can_share(event))
> +		return;
> +
> +	/* look for dup with other events */
> +	list_for_each_entry(tmp, &ctx->event_list, event_entry) {
> +		if (tmp == event ||
> +		    !perf_event_can_share(tmp) ||
> +		    !perf_event_compatible(event, tmp))
> +			continue;
> +
> +		/* first dup, pick tmp as the master */
> +		if (!tmp->dup_master) {
> +			if (tmp->state == PERF_EVENT_STATE_ACTIVE)
> +				tmp->pmu->read(tmp);
> +			perf_event_init_dup_master(tmp);

This is the one that does the read prior to init_dup_master().

> +		}
> +
> +		event->dup_master = tmp->dup_master;
> +		break;
> +	}
> +}
> +
> +static int event_pmu_add(struct perf_event *event,
> +			 struct perf_event_context *ctx);

AFAICT this fwd-decl is pointless.

> +/* Remove dup_master for the event */
> +static void perf_event_remove_dup(struct perf_event *event,
> +				  struct perf_event_context *ctx)
> +
> +{
> +	struct perf_event *tmp, *new_master;
> +
> +	int dup_count, active_count;
> +
> +	/* no sharing */
> +	if (!event->dup_master)
> +		return;
> +
> +	WARN_ON_ONCE(event->state < PERF_EVENT_STATE_OFF ||
> +		     event->state > PERF_EVENT_STATE_ENABLED);

The below has code that relies on the event actually being inactive; and
while we know we've done event_sched_out() when we get here, this is
rather unfortunate.

I've not gone through this yet to see if we can simply move the call
until after we've set state. Also, list_del_event() actively deals with
<OFF, so I'm thinking that part of the WARN is just plain wrong.

> +
> +	/* this event is not the master */
> +	if (event->dup_master != event) {
> +		event->dup_master = NULL;
> +		return;
> +	}
> +
> +	/* this event is the master */
> +	dup_count = 0;
> +	new_master = NULL;
> +	list_for_each_entry(tmp, &ctx->event_list, event_entry) {
> +		if (tmp->dup_master != event || tmp == event)
> +			continue;
> +		if (!new_master)
> +			new_master = tmp;
> +
> +		/* only init new_master when we need to (dup_count > 1) */
> +		if (dup_count == 1)
> +			perf_event_init_dup_master(new_master);
> +
> +		if (tmp->state == PERF_EVENT_STATE_ACTIVE) {
> +			/* sync read from old master */
> +			event_sync_dup_count(tmp, event);
> +
> +			/* prepare to read from new master */
> +			tmp->dup_base_count = local64_read(&new_master->count);
> +			tmp->dup_base_child_count =
> +				atomic64_read(&new_master->child_count);
> +		}
> +		tmp->dup_master = new_master;
> +		dup_count++;
> +	}

Now consider that for ACTIVE events we need ->dup_master and ->dup_count
to be consistent at all times and cry. Please see below; I've made an
attempt at fixing all that.

> +	active_count = event->dup_active_count;
> +	perf_event_exit_dup_master(event);
> +
> +	if (!dup_count)
> +		return;
> +
> +	if (dup_count == 1)  /* no more sharing */
> +		new_master->dup_master = NULL;
> +	else
> +		new_master->dup_active_count = active_count;
> +
> +	if (active_count) {
> +		/* copy hardware configure to switch faster */
> +		if (event->pmu->copy_hw_config)
> +			event->pmu->copy_hw_config(event, new_master);
> +
> +		perf_pmu_disable(new_master->pmu);
> +		WARN_ON_ONCE(new_master->pmu->add(new_master, PERF_EF_START));
> +		perf_pmu_enable(new_master->pmu);
> +		if (new_master->state == PERF_EVENT_STATE_INACTIVE)
> +			/*
> +			 * We don't need to update time, so don't call
> +			 * perf_event_set_state().
> +			 */
> +			new_master->state = PERF_EVENT_STATE_ENABLED;

CodingStyle wants { } on any multi-line. The comment fails to mention
the critical bit though; *WHY* ?!?

> +	}
> +}


> @@ -2106,13 +2358,15 @@ event_sched_out(struct perf_event *event,
>  
>  	perf_pmu_disable(event->pmu);
>  
> -	event->pmu->del(event, 0);
> +	event_pmu_del(event, ctx);
>  	event->oncpu = -1;
>  
>  	if (READ_ONCE(event->pending_disable) >= 0) {
>  		WRITE_ONCE(event->pending_disable, -1);
>  		state = PERF_EVENT_STATE_OFF;
> -	}
> +	} else if (event->dup_master == event &&
> +		   event->dup_active_count)
> +		state = PERF_EVENT_STATE_ENABLED;

That can simply be: 'else if (event->dup_active) {', dup_active being
non-zero implies event->dup_master==event.

Also, I think you've stumbled on a pre-existing bug here. We have
->state==ACTIVE after pmu->del(), this means an NMI hitting at this spot
can call pmu->read() on an unscheduled event, which is *fail*.

I'll go think about how to fix that.


Find below the delta I ended up with. Note that I didn't nearly fix
everything I found wrong, nor do I have a high confidence in the things
I did do fix, I've been suffering horrible head-aches the past few days
:/

---

--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -562,6 +562,7 @@ struct perf_addr_filter_range {
  *
  * PERF_EVENT_STATE_ENABLED:	Special state for PMC sharing: the hw PMC
  *				is enabled, but this event is not counting.
+ *				See perf_event_init_dup_master().
  */
 enum perf_event_state {
 	PERF_EVENT_STATE_DEAD		= -4,
@@ -775,13 +776,11 @@ struct perf_event {
 #endif
 	struct list_head		sb_list;
 
-	/* check event_sync_dup_count() for the use of dup_base_* */
-	u64				dup_base_count;
-	u64				dup_base_child_count;
-	/* when this event is master,  read from master*count */
+	int				dup_active;
+	/* See event_pmu_read_dup() */
+	local64_t			dup_count;
+	/* See perf_event_init_dup_master() */
 	local64_t			master_count;
-	atomic64_t			master_child_count;
-	int				dup_active_count;
 #endif /* CONFIG_PERF_EVENTS */
 };
 
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1783,80 +1783,87 @@ static inline bool perf_event_compatible
 	return memcmp(&event_a->attr, &event_b->attr, event_a->attr.size) == 0;
 }
 
-/* prepare the dup_master, this event is its own dup_master */
 static void perf_event_init_dup_master(struct perf_event *event)
 {
 	bool is_active = event->state == PERF_EVENT_STATE_ACTIVE;
-	s64 count, child_count;
+	u64 count;
+
+	WARN_ON_ONCE(event->dup_active != 0);
 
-	WARN_ON_ONCE(event->dup_active_count != 0);
-	event->dup_master = event;
 	/*
-	 * dup_master->count is used by the hw PMC, and shared with other
-	 * events, so we have to read from dup_master->master_count. Copy
-	 * event->count to event->master_count.
+	 * The event sharing scheme allows for duplicate events to be ACTIVE
+	 * while the master is not. In order to facilitate this, the master
+	 * will be put in the ENABLED state whenever it has active duplicates
+	 * but is itself *not* ACTIVE.
 	 *
-	 * Same logic for child_count and master_child_count.
+	 * When ENABLED the master event is scheduled, but its counter must
+	 * appear stalled. Since the PMU driver updates event->count, the
+	 * master must keep a shadow counter for itself, this is
+	 * event->master_count.
 	 */
+
+	if (is_active)
+		event->pmu->read(event);
+
 	count = local64_read(&event->count);
-	child_count = atomic64_read(&event->child_count);
 	local64_set(&event->master_count, count);
-	atomic64_set(&event->master_child_count, child_count);
 
 	if (is_active) {
-		event->dup_base_count = count;
-		event->dup_base_child_count = child_count;
-
-		event->dup_active_count = 1;
+		local64_set(&event->dup_count, count);
+		event->dup_active = 1;
 	}
+
+	barrier();
+
+	WRITE_ONCE(event->dup_master, event);
 }
 
 /* tear down dup_master, no more sharing for this event */
 static void perf_event_exit_dup_master(struct perf_event *event)
 {
-	event->dup_active_count = 0;
+	WARN_ON_ONCE(event->state < PERF_EVENT_STATE_OFF ||
+		     event->state > PERF_EVENT_STATE_INACTIVE);
+
+	event->dup_active = 0;
+	WRITE_ONCE(event->dup_master, NULL);
+
+	barrier();
 
-	event->dup_master = NULL;
 	/* restore event->count and event->child_count */
 	local64_set(&event->count, local64_read(&event->master_count));
-	atomic64_set(&event->child_count,
-		     atomic64_read(&event->master_child_count));
 }
 
+#define EVENT_TOMBSTONE	((void *)-1L)
+
 /*
  * sync data count from dup_master to event, called on event_pmu_read()
  * and event_pmu_del()
  */
-static void event_sync_dup_count(struct perf_event *event,
-				 struct perf_event *master)
+static void
+event_pmu_read_dup(struct perf_event *event, struct perf_event *master)
 {
-	u64 new_count;
-	u64 new_child_count;
+	u64 prev_count, new_count;
 
-	event->pmu->read(master);
-	new_count = local64_read(&master->count);
-	new_child_count = atomic64_read(&master->child_count);
+	if (master == EVENT_TOMBSTONE)
+		return;
 
-	if (event == master) {
-		local64_add(new_count - event->dup_base_count,
-			    &event->master_count);
-		atomic64_add(new_child_count - event->dup_base_child_count,
-			     &event->master_child_count);
-	} else {
-		local64_add(new_count - event->dup_base_count, &event->count);
-		atomic64_add(new_child_count - event->dup_base_child_count,
-			     &event->child_count);
-	}
+again:
+	prev_count = local64_read(&event->dup_count);
+	if (master->state > PERF_EVENT_STATE_INACTIVE)
+		master->pmu->read(master);
+	new_count = local64_read(&master->count);
+	if (local64_cmpxchg(&event->dup_count, prev_count, new_count) != prev_count)
+		goto again;
 
-	/* save dup_base_* for next sync */
-	event->dup_base_count = new_count;
-	event->dup_base_child_count = new_child_count;
+	if (event == master)
+		local64_add(new_count - prev_count, &event->master_count);
+	else
+		local64_add(new_count - prev_count, &event->count);
 }
 
 /* After adding a event to the ctx, try find compatible event(s). */
-static void perf_event_setup_dup(struct perf_event *event,
-				 struct perf_event_context *ctx)
-
+static void
+perf_event_setup_dup(struct perf_event *event, struct perf_event_context *ctx)
 {
 	struct perf_event *tmp;
 
@@ -1871,28 +1878,21 @@ static void perf_event_setup_dup(struct
 			continue;
 
 		/* first dup, pick tmp as the master */
-		if (!tmp->dup_master) {
-			if (tmp->state == PERF_EVENT_STATE_ACTIVE)
-				tmp->pmu->read(tmp);
+		if (!tmp->dup_master)
 			perf_event_init_dup_master(tmp);
-		}
 
 		event->dup_master = tmp->dup_master;
 		break;
 	}
 }
 
-static int event_pmu_add(struct perf_event *event,
-			 struct perf_event_context *ctx);
-
 /* Remove dup_master for the event */
-static void perf_event_remove_dup(struct perf_event *event,
-				  struct perf_event_context *ctx)
-
+static void
+perf_event_remove_dup(struct perf_event *event, struct perf_event_context *ctx)
 {
 	struct perf_event *tmp, *new_master;
-
 	int dup_count, active_count;
+	int ret;
 
 	/* no sharing */
 	if (!event->dup_master)
@@ -1911,38 +1911,62 @@ static void perf_event_remove_dup(struct
 	dup_count = 0;
 	new_master = NULL;
 	list_for_each_entry(tmp, &ctx->event_list, event_entry) {
+		u64 count;
+
 		if (tmp->dup_master != event || tmp == event)
 			continue;
 		if (!new_master)
 			new_master = tmp;
 
-		/* only init new_master when we need to (dup_count > 1) */
-		if (dup_count == 1)
-			perf_event_init_dup_master(new_master);
-
 		if (tmp->state == PERF_EVENT_STATE_ACTIVE) {
 			/* sync read from old master */
-			event_sync_dup_count(tmp, event);
-
-			/* prepare to read from new master */
-			tmp->dup_base_count = local64_read(&new_master->count);
-			tmp->dup_base_child_count =
-				atomic64_read(&new_master->child_count);
+			event_pmu_read_dup(tmp, event);
 		}
-		tmp->dup_master = new_master;
+
+		/*
+		 * Flip an active event to a new master; this is tricky because
+		 * for an active event event_pmu_read() can be called at any
+		 * time from NMI context.
+		 *
+		 * This means we need to have ->dup_master and
+		 * ->dup_count consistent at all times. Of course we cannot do
+		 * two writes at once :/
+		 *
+		 * Instead, flip ->dup_master to EVENT_TOMBSTONE, this will
+		 * make event_pmu_read_dup() NOP. Then we can set
+		 * ->dup_count and finally set ->dup_master to the new_master
+		 * to let event_pmu_read_dup() rip.
+		 */
+		WRITE_ONCE(tmp->dup_master, EVENT_TOMBSTONE);
+		barrier();
+
+		count = local64_read(&new_master->count);
+		local64_set(&tmp->dup_count, count);
+
+		if (tmp == new_master)
+			local64_set(&tmp->master_count, count);
+
+		barrier();
+		WRITE_ONCE(tmp->dup_master, new_master);
 		dup_count++;
 	}
 
-	active_count = event->dup_active_count;
+	active_count = event->dup_active;
 	perf_event_exit_dup_master(event);
 
 	if (!dup_count)
 		return;
 
-	if (dup_count == 1)  /* no more sharing */
-		new_master->dup_master = NULL;
-	else
-		new_master->dup_active_count = active_count;
+	if (dup_count == 1) {
+		/*
+		 * We set up as a master, but there aren't any more duplicates.
+		 * Simply clear ->dup_master, as ->master_count == ->count per
+		 * the above.
+		 */
+		WRITE_ONCE(new_master->dup_master, NULL);
+	} else {
+		new_master->dup_active = active_count;
+	}
 
 	if (active_count) {
 		/* copy hardware configure to switch faster */
@@ -1950,14 +1974,21 @@ static void perf_event_remove_dup(struct
 			event->pmu->copy_hw_config(event, new_master);
 
 		perf_pmu_disable(new_master->pmu);
-		WARN_ON_ONCE(new_master->pmu->add(new_master, PERF_EF_START));
-		perf_pmu_enable(new_master->pmu);
-		if (new_master->state == PERF_EVENT_STATE_INACTIVE)
+		ret = new_master->pmu->add(new_master, PERF_EF_START);
+		/*
+		 * Since we just removed the old master (@event), it should be
+		 * impossible to fail to schedule the new master, an identical
+		 * event.
+		 */
+		WARN_ON_ONCE(ret);
+		if (new_master->state == PERF_EVENT_STATE_INACTIVE) {
 			/*
 			 * We don't need to update time, so don't call
 			 * perf_event_set_state().
 			 */
 			new_master->state = PERF_EVENT_STATE_ENABLED;
+		}
+		perf_pmu_enable(new_master->pmu);
 	}
 }
 
@@ -2403,8 +2434,7 @@ static int event_pmu_add(struct perf_eve
 		return event->pmu->add(event, PERF_EF_START);
 
 	master = event->dup_master;
-
-	if (!master->dup_active_count) {
+	if (!master->dup_active) {
 		ret = event->pmu->add(master, PERF_EF_START);
 		if (ret)
 			return ret;
@@ -2413,10 +2443,10 @@ static int event_pmu_add(struct perf_eve
 			perf_event_set_state(master, PERF_EVENT_STATE_ENABLED);
 	}
 
-	master->dup_active_count++;
+	master->dup_active++;
 	master->pmu->read(master);
-	event->dup_base_count = local64_read(&master->count);
-	event->dup_base_child_count = atomic64_read(&master->child_count);
+	local64_set(&event->dup_count, local64_read(&master->count));
+
 	return 0;
 }
 
@@ -2430,11 +2460,11 @@ static void event_pmu_del(struct perf_ev
 		return event->pmu->del(event, 0);
 
 	master = event->dup_master;
-	event_sync_dup_count(event, master);
-	if (--master->dup_active_count == 0) {
+	if (!--master->dup_active) {
 		event->pmu->del(master, 0);
 		perf_event_set_state(master, PERF_EVENT_STATE_INACTIVE);
 	}
+	event_pmu_read_dup(event, master);
 }
 
 /* PMU sharing aware version of event->pmu->read() */
@@ -2443,7 +2473,7 @@ static void event_pmu_read(struct perf_e
 	if (!event->dup_master)
 		return event->pmu->read(event);
 
-	event_sync_dup_count(event, event->dup_master);
+	event_pmu_read_dup(event, event->dup_master);
 }
 
 static void
@@ -2474,9 +2504,10 @@ event_sched_out(struct perf_event *event
 	if (READ_ONCE(event->pending_disable) >= 0) {
 		WRITE_ONCE(event->pending_disable, -1);
 		state = PERF_EVENT_STATE_OFF;
-	} else if (event->dup_master == event &&
-		   event->dup_active_count)
+	} else if (event->dup_active) {
+		WARN_ON_ONCE(event->dup_master != event);
 		state = PERF_EVENT_STATE_ENABLED;
+	}
 	perf_event_set_state(event, state);
 
 	if (!is_software_event(event))
@@ -4453,12 +4484,14 @@ static void __perf_event_read(void *info
 
 static inline u64 perf_event_count(struct perf_event *event)
 {
-	if (event->dup_master == event) {
-		return local64_read(&event->master_count) +
-			atomic64_read(&event->master_child_count);
-	}
+	u64 count;
 
-	return local64_read(&event->count) + atomic64_read(&event->child_count);
+	if (likely(event->dup_master != event))
+		count = local64_read(&event->count);
+	else
+		count = local64_read(&event->master_count);
+
+	return count + atomic64_read(&event->child_count);
 }
 
 /*
@@ -12207,10 +12240,7 @@ static void sync_child_event(struct perf
 	/*
 	 * Add back the child's count to the parent's count:
 	 */
-	if (parent_event->dup_master == parent_event)
-		atomic64_add(child_val, &parent_event->master_child_count);
-	else
-		atomic64_add(child_val, &parent_event->child_count);
+	atomic64_add(child_val, &parent_event->child_count);
 	atomic64_add(child_event->total_time_enabled,
 		     &parent_event->child_total_time_enabled);
 	atomic64_add(child_event->total_time_running,
