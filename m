Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48DB4C433EA
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 13:43:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2314620714
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 13:43:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbgGXNnu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 09:43:50 -0400
Received: from mga02.intel.com ([134.134.136.20]:7892 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726852AbgGXNnt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 09:43:49 -0400
IronPort-SDR: +dG/8xtGWdbccpQOBVYczv5y0o7OzEt81ZA+Dtv/6Ee+won76IlbAReciqLnl79KQeNSyyVGSJ
 gw8+jHtIUm8A==
X-IronPort-AV: E=McAfee;i="6000,8403,9691"; a="138770241"
X-IronPort-AV: E=Sophos;i="5.75,390,1589266800"; 
   d="scan'208";a="138770241"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2020 06:43:47 -0700
IronPort-SDR: 77PS6YN2Z9zEKYZAwecVv00wH7qsKqTmHMA1Olk+cjWniGIgulVPT3DCcfmFLeTxeg4oqZ5DK5
 xU/k01Or9a+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,390,1589266800"; 
   d="scan'208";a="327331156"
Received: from linux.intel.com ([10.54.29.200])
  by FMSMGA003.fm.intel.com with ESMTP; 24 Jul 2020 06:43:47 -0700
Received: from [10.252.140.222] (kliang2-mobl.ccr.corp.intel.com [10.252.140.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 50DDF580638;
        Fri, 24 Jul 2020 06:43:46 -0700 (PDT)
Subject: Re: [PATCH V7 07/14] perf/core: Add a new PERF_EV_CAP_COEXIST event
 capability
To:     peterz@infradead.org
Cc:     acme@redhat.com, mingo@kernel.org, linux-kernel@vger.kernel.org,
        jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com,
        like.xu@linux.intel.com
References: <20200723171117.9918-1-kan.liang@linux.intel.com>
 <20200723171117.9918-8-kan.liang@linux.intel.com>
 <20200724105543.GV119549@hirez.programming.kicks-ass.net>
 <20200724114628.GJ43129@hirez.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <0d33a25c-cfe4-af7f-c915-a98dba17b53b@linux.intel.com>
Date:   Fri, 24 Jul 2020 09:43:44 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200724114628.GJ43129@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/24/2020 7:46 AM, peterz@infradead.org wrote:
> On Fri, Jul 24, 2020 at 12:55:43PM +0200, peterz@infradead.org wrote:
>>> +	event_sched_out(event, cpuctx, ctx);
>>> +	perf_event_set_state(event, PERF_EVENT_STATE_ERROR);
>>> +}
>>
>> Ah, so the problem here is that ERROR is actually recoverable using
>> IOC_ENABLE. We don't want that either. Let me try and figure out of EXIT
>> would work.
> 
> EXIT is difficult too.. Also, that COEXIST thing hurt my brian, can't we
> do a simpler SIBLING thing that simply requires the event to be a group
> sibling?
> 
> The consequence is that SLOTS must be the leader, is that really a
> problem? You keep providing the {cycles, slots, metric-things} example,
> but afaict {slots, metric-thing, cycles} should work just fine too. > PERF_SAMPLE_READ with PERF_FORMAT_GROUP doesn't need to the the leader.

I'm not sure I get your point.
For the PERF_SAMPLE_READ with PERF_FORMAT_GROUP case, other events can 
be the leader, e.g., {cycles, slots, metric-things}:S.
In this case, the SLOTS event is not a leader. I don't think we can 
assume that the SLOTS event must be the leader.

I think the case should be a useful case. Users may want to read the 
Topdown values for each sample.

Thanks,
Kan

> 
> The thing is, with COEXIST, if you have:
> 
> 	{cycles, slots, metric1, metric2}
> 
> and you say that COEXIST events need to co-exist with at least one other
> COEXIST event you end up with a problem when: close(fd_slots) happens,
> because in the above case, there's two more COEXIST events, so the
> requirement holds, even through this is very much not what we want.
> 
> You 'fixed' this by saying closing any COEXIST event will tear the group
> up, but that's 'weird' and unexpected if you were to do:
> close(fd_metric2).
> >
> So something like this.
> 
> ---
> Subject: perf/core: Add a new PERF_EV_CAP_SIBLING event capability
> 
> Current perf assumes that events in a group are independent. Close an
> event doesn't impact the value of the other events in the same group.
> If the closed event is a member, after the event closure, other events
> are still running like a group. If the closed event is a leader, other
> events are running as singleton events.
> 
> Add PERF_EV_CAP_SIBLING to allow events to indicate they require being
> part of a group, and when the leader dies they cannot exist
> independently.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>   include/linux/perf_event.h |    4 ++++
>   kernel/events/core.c       |   38 +++++++++++++++++++++++++++++++++-----
>   2 files changed, 37 insertions(+), 5 deletions(-)
> 
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -576,9 +576,13 @@ typedef void (*perf_overflow_handler_t)(
>    * PERF_EV_CAP_SOFTWARE: Is a software event.
>    * PERF_EV_CAP_READ_ACTIVE_PKG: A CPU event (or cgroup event) that can be read
>    * from any CPU in the package where it is active.
> + * PERF_EV_CAP_SIBLING: An event with this flag must be a group sibling and
> + * cannot be a group leader. If an event with this flag is detached from the
> + * group it is scheduled out and moved into an unrecoverable ERROR state.
>    */
>   #define PERF_EV_CAP_SOFTWARE		BIT(0)
>   #define PERF_EV_CAP_READ_ACTIVE_PKG	BIT(1)
> +#define PERF_EV_CAP_SIBLING		BIT(2)
>   
>   #define SWEVENT_HLIST_BITS		8
>   #define SWEVENT_HLIST_SIZE		(1 << SWEVENT_HLIST_BITS)
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -2133,8 +2133,24 @@ static inline struct list_head *get_even
>   	return event->attr.pinned ? &ctx->pinned_active : &ctx->flexible_active;
>   }
>   
> +/*
> + * Events that have PERF_EV_CAP_SIBLING require being part of a group and
> + * cannot exist on their own, schedule them out and move them into the ERROR
> + * state. Also see _perf_event_enable(), it will not be able to recover
> + * this ERROR state.
> + */
> +static inline void perf_remove_sibling_event(struct perf_event *event)
> +{
> +	struct perf_event_context *ctx = event->ctx;
> +	struct perf_cpu_context *cpuctx = __get_cpu_context(ctx);
> +
> +	event_sched_out(event, cpuctx, ctx);
> +	perf_event_set_state(event, PERF_EVENT_STATE_ERROR);
> +}
> +
>   static void perf_group_detach(struct perf_event *event)
>   {
> +	struct perf_event *leader = event->group_leader;
>   	struct perf_event *sibling, *tmp;
>   	struct perf_event_context *ctx = event->ctx;
>   
> @@ -2153,7 +2169,7 @@ static void perf_group_detach(struct per
>   	/*
>   	 * If this is a sibling, remove it from its group.
>   	 */
> -	if (event->group_leader != event) {
> +	if (leader != event) {
>   		list_del_init(&event->sibling_list);
>   		event->group_leader->nr_siblings--;
>   		goto out;
> @@ -2166,6 +2182,9 @@ static void perf_group_detach(struct per
>   	 */
>   	list_for_each_entry_safe(sibling, tmp, &event->sibling_list, sibling_list) {
>   
> +		if (sibling->event_caps & PERF_EV_CAP_SIBLING)
> +			perf_remove_sibling_event(sibling);
> +
>   		sibling->group_leader = sibling;
>   		list_del_init(&sibling->sibling_list);
>   
> @@ -2183,10 +2202,10 @@ static void perf_group_detach(struct per
>   	}
>   
>   out:
> -	perf_event__header_size(event->group_leader);
> -
> -	for_each_sibling_event(tmp, event->group_leader)
> +	for_each_sibling_event(tmp, leader)
>   		perf_event__header_size(tmp);
> +
> +	perf_event__header_size(leader);
>   }
>   
>   static bool is_orphaned_event(struct perf_event *event)
> @@ -2979,6 +2998,7 @@ static void _perf_event_enable(struct pe
>   	raw_spin_lock_irq(&ctx->lock);
>   	if (event->state >= PERF_EVENT_STATE_INACTIVE ||
>   	    event->state <  PERF_EVENT_STATE_ERROR) {
> +out:
>   		raw_spin_unlock_irq(&ctx->lock);
>   		return;
>   	}
> @@ -2990,8 +3010,16 @@ static void _perf_event_enable(struct pe
>   	 * has gone back into error state, as distinct from the task having
>   	 * been scheduled away before the cross-call arrived.
>   	 */
> -	if (event->state == PERF_EVENT_STATE_ERROR)
> +	if (event->state == PERF_EVENT_STATE_ERROR) {
> +		/*
> +		 * Detached SIBLING events cannot leave ERROR state.
> +		 */
> +		if (event->event_caps & PERF_EV_CAP_SIBLING &&
> +		    event->group_leader == event)
> +			goto out;
> +
>   		event->state = PERF_EVENT_STATE_OFF;
> +	}
>   	raw_spin_unlock_irq(&ctx->lock);
>   
>   	event_function_call(event, __perf_event_enable, NULL);
> 
