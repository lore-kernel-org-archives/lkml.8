Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E3A4C54FCC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 23:04:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 731D320B1F
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 23:04:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="m9w2cpb0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbgDTXE6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 19:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726006AbgDTXE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 19:04:58 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19517C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 16:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PQb0epH8yTSz1xCENR59B2/DLAWFHm/nDoH5eEd8Dm8=; b=m9w2cpb0glQVhcmU1zRA42UN5K
        rOuaImEJF8MnxUud8iaQFaMxj+zUjbWnTAA+i04gXsQcwvssm0y95M8higdJQGJAMNWdQOmVmyZ0R
        DKrg16QAn3HMtu1EcEulVqBCr6U2OM/64KhQi57CgmBAO93E90Gn63QRfMvRiXMexeXNXkIgyNFET
        SZTO79kf2do1GLUnHpQz8TmHhlC1x58RvRcd2Y8xk+8GTN7v+B/MwhhaVPjiCyDSnbDJREVyLQSZZ
        wU6R7GdCDnTJ3LFrQl7Rye3prdkNNE2g1zqsPnbl3xX7VggeY0J0ELOBrXo350auMbIJ1ZNMLxRzO
        z66HSaoQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jQfSp-00029B-W7; Mon, 20 Apr 2020 23:04:32 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 376CA9834D4; Tue, 21 Apr 2020 01:04:29 +0200 (CEST)
Date:   Tue, 21 Apr 2020 01:04:29 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>, Tejun Heo <tj@kernel.org>,
        kernel test robot <rong.a.chen@intel.com>
Subject: Re: [PATCH v12] perf: Sharing PMU counters across compatible events
Message-ID: <20200420230429.GT2483@worktop.programming.kicks-ass.net>
References: <20200331075533.2347393-1-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200331075533.2347393-1-songliubraving@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 31, 2020 at 12:55:33AM -0700, Song Liu wrote:
> @@ -1778,6 +1775,246 @@ perf_event_groups_next(struct perf_event *event)
>  		event = rb_entry_safe(rb_next(&event->group_node),	\
>  				typeof(*event), group_node))
>  
> +static inline bool perf_event_can_share(struct perf_event *event)
> +{
> +	/* only share hardware counting events */
> +	return !is_sampling_event(event);
> +	return !is_software_event(event) && !is_sampling_event(event);
> +}

ISTR pointing out before that one of those returns is superfluous.

> +/*
> + * Returns whether the two events can share a PMU counter.
> + *
> + * Note: This function does NOT check perf_event_can_share() for
> + * the two events, they should be checked before this function
> + */
> +static inline bool perf_event_compatible(struct perf_event *event_a,
> +					 struct perf_event *event_b)
> +{
> +	return memcmp(&event_a->attr, &event_b->attr, event_a->attr.size) == 0;
> +}
> +
> +static void perf_event_init_dup_master(struct perf_event *event)
> +{
> +	bool is_active = event->state == PERF_EVENT_STATE_ACTIVE;
> +	s64 count;
> +
> +	WARN_ON_ONCE(event->dup_active != 0);
> +	/*
> +	 * The event sharing scheme allows for duplicate events to be ACTIVE
> +	 * while the master is not. In order to facilitate this, the master
> +	 * will be put in the ENABLED state whenever it has active duplicates
> +	 * but is itself *not* ACTIVE.
> +	 *
> +	 * When ENABLED the master event is scheduled, but its counter must
> +	 * appear stalled. Since the PMU driver updates event->count, the
> +	 * master must keep a shadow counter for itself, this is
> +	 * event->master_count.
> +	 */
> +	count = local64_read(&event->count);
> +	local64_set(&event->master_count, count);
> +
> +	if (is_active) {
> +		local64_set(&event->dup_count, count);
> +		event->dup_active = 1;
> +	}
> +
> +	barrier();
> +
> +	WRITE_ONCE(event->dup_master, event);
> +	event->dup_master = event;
> +}

OK, set up master_count, dup_count, barrier, set dup_master.

> +/* tear down dup_master, no more sharing for this event */
> +static void perf_event_exit_dup_master(struct perf_event *event)
> +{
> +	WARN_ON_ONCE(event->state < PERF_EVENT_STATE_OFF ||
> +		     event->state > PERF_EVENT_STATE_INACTIVE);
> +
> +	/* restore event->count and event->child_count */
> +	local64_set(&event->count, local64_read(&event->master_count));
> +
> +	event->dup_active = 0;
> +	WRITE_ONCE(event->dup_master, NULL);
> +
> +	barrier();
> +}

XXX ordering doesn't make sense, I think you want the barrier() between
setting count and dup_master, that way you'll get the correct result out
of perf_event_count() no matter the timing.

> +#define EVENT_TOMBSTONE ((void *)-1L)
> +
> +/*
> + * sync data count from dup_master to event, called on event_pmu_read()
> + * and event_pmu_del()
> + */
> +static void
> +event_pmu_read_dup(struct perf_event *event, struct perf_event *master)
> +{
> +	u64 prev_count, new_count;
> +
> +	if (master == EVENT_TOMBSTONE)
> +		return;
> +
> +again:
> +	prev_count = local64_read(&event->dup_count);
> +	if (master->state > PERF_EVENT_STATE_INACTIVE)
> +		master->pmu->read(master);
> +	new_count = local64_read(&master->count);
> +	if (local64_cmpxchg(&event->dup_count, prev_count, new_count) != prev_count)
> +		goto again;
> +
> +	if (event == master)
> +		local64_add(new_count - prev_count, &event->master_count);
> +	else
> +		local64_add(new_count - prev_count, &event->count);
> +}
> +
> +/* After adding a event to the ctx, try find compatible event(s). */
> +static void
> +perf_event_setup_dup(struct perf_event *event, struct perf_event_context *ctx)
> +{
> +	struct perf_event *tmp;
> +
> +	if (event->state < PERF_EVENT_STATE_OFF ||
> +	    !perf_event_can_share(event))
> +		return;
> +
> +	/* look for dup with other events */
> +	list_for_each_entry(tmp, &ctx->event_list, event_entry) {
> +		if (tmp == event ||
> +		    !perf_event_can_share(tmp) ||
> +		    !perf_event_compatible(event, tmp))
> +			continue;
> +		if (tmp->state < PERF_EVENT_STATE_INACTIVE)
> +			continue;
> +
> +		/* first dup, pick tmp as the master */
> +		if (!tmp->dup_master) {
> +			if (tmp->state == PERF_EVENT_STATE_ACTIVE)
> +				tmp->pmu->read(tmp);
> +			perf_event_init_dup_master(tmp);
> +		}
> +
> +		event->dup_master = tmp->dup_master;
> +
> +		break;
> +	}
> +}
> +
> +/* Remove dup_master for the event */
> +static void
> +perf_event_remove_dup(struct perf_event *event, struct perf_event_context *ctx)
> +
> +{
> +	struct perf_event *tmp, *new_master;
> +	int dup_count, active_count;
> +	int ret;
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
> +		event->dup_master = NULL;
> +		return;
> +	}
> +
> +	active_count = event->dup_active;
> +	if (active_count) {
> +		perf_pmu_disable(event->pmu);
> +		event->pmu->del(event, 0);
> +	}
> +
> +	/* this event is the master */
> +	dup_count = 0;
> +	new_master = NULL;
> +	list_for_each_entry(tmp, &ctx->event_list, event_entry) {
> +		u64 count;
> +
> +		if (tmp->dup_master != event || tmp == event)
> +			continue;
> +		if (!new_master) {
> +			new_master = tmp;
> +			list_del_init(&new_master->dup_active_list);
> +		}
> +
> +		if (tmp->state == PERF_EVENT_STATE_ACTIVE) {
> +			/* sync read from old master */
> +			event_pmu_read_dup(tmp, event);
> +		}
> +		/*
> +		 * Flip an active event to a new master; this is tricky
> +		 * because for an active event event_pmu_read() can be
> +		 * called at any time from NMI context.
> +		 *
> +		 * This means we need to have ->dup_master and ->dup_count
> +		 * consistent at all times. Of course we cannot do two
> +		 * writes at once :/
> +		 *
> +		 * Instead, flip ->dup_master to EVENT_TOMBSTONE, this will
> +		 * make event_pmu_read_dup() NOP. Then we can set
> +		 * ->dup_count and finally set ->dup_master to the
> +		 * new_master to let event_pmu_read_dup() rip.
> +		 */
> +		WRITE_ONCE(tmp->dup_master, EVENT_TOMBSTONE);
> +		barrier();
> +
> +		count = local64_read(&new_master->count);
> +		local64_set(&tmp->dup_count, count);
> +
> +		if (tmp == new_master)
> +			local64_set(&tmp->master_count, count);
> +		else if (tmp->state == PERF_EVENT_STATE_ACTIVE)
> +			list_move_tail(&tmp->dup_active_list,
> +				       &new_master->dup_active_list);
> +
> +		barrier();
> +		WRITE_ONCE(tmp->dup_master, new_master);
> +		dup_count++;
> +	}
> +
> +	perf_event_exit_dup_master(event);
> +
> +	if (!dup_count)
> +		return;
> +
> +	if (active_count) {
> +		/* copy hardware configure to switch faster */
> +		if (event->pmu->copy_hw_config)
> +			event->pmu->copy_hw_config(event, new_master);
> +
> +		ret = new_master->pmu->add(new_master, PERF_EF_START);
> +		/*
> +		 * Since we just removed the old master (@event), it should be
> +		 * impossible to fail to schedule the new master, an identical
> +		 * event.
> +		 */
> +		WARN_ON_ONCE(ret);
> +		if (new_master->state == PERF_EVENT_STATE_INACTIVE) {
> +			/*
> +			 * We don't need to update time, so don't call
> +			 * perf_event_set_state().
> +			 */
> +			new_master->state = PERF_EVENT_STATE_ENABLED;
> +		}
> +		perf_pmu_enable(new_master->pmu);
> +	}
> +
> +	if (dup_count == 1) {
> +		/*
> +		 * We set up as a master, but there aren't any more duplicates.
> +		 * Simply clear ->dup_master, as ->master_count == ->count per
> +		 * the above.
> +		 */
> +		WRITE_ONCE(new_master->dup_master, NULL);
> +	} else {
> +		new_master->dup_active = active_count;
> +	}
> +}
> +
>  /*
>   * Add an event from the lists for its context.
>   * Must be called with ctx->mutex and ctx->lock held.

> @@ -4223,7 +4534,14 @@ static void __perf_event_read(void *info)
>  
>  static inline u64 perf_event_count(struct perf_event *event)
>  {
> -	return local64_read(&event->count) + atomic64_read(&event->child_count);
> +	u64 count;
> +
> +	if (likely(event->dup_master != event))
> +		count = local64_read(&event->count);
> +	else
> +		count = local64_read(&event->master_count);
> +
> +	return count + atomic64_read(&event->child_count);
>  }

So lsat time I said something about SMP ordering here. Where did that
go?

Specifically, without ordering it is possible to observe dup_master and
dup_count out of order. So while we might then see dup_master, we might
then also see an old dup_count, which would give 'interesting' effects.

Granted, adding memory barriers all over this will suck :/
