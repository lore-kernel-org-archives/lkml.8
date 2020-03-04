Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26525C3F2CD
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 14:20:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 011DC20866
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 14:20:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729509AbgCDOUq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 09:20:46 -0500
Received: from mga01.intel.com ([192.55.52.88]:11104 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726378AbgCDOUp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 09:20:45 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Mar 2020 06:20:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,514,1574150400"; 
   d="scan'208";a="234134159"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga008.fm.intel.com with ESMTP; 04 Mar 2020 06:20:44 -0800
Received: from [10.251.18.151] (kliang2-mobl.ccr.corp.intel.com [10.251.18.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 0AF0C5803E3;
        Wed,  4 Mar 2020 06:20:43 -0800 (PST)
Subject: Re: [PATCH] perf/core: Fix endless multiplex timer
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org, irogers@google.com,
        eranian@google.com, ak@linux.intel.com
References: <20200303202819.3942-1-kan.liang@linux.intel.com>
 <20200303210812.GA4745@worktop.programming.kicks-ass.net>
 <b71515e4-484e-d80a-37db-2e51abe69928@linux.intel.com>
 <20200304093344.GJ2596@hirez.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <6a271c19-9575-24ca-8ebc-9ff5a65bbe3d@linux.intel.com>
Date:   Wed, 4 Mar 2020 09:20:42 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200304093344.GJ2596@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/4/2020 4:33 AM, Peter Zijlstra wrote:
> On Tue, Mar 03, 2020 at 08:40:10PM -0500, Liang, Kan wrote:
>>> I'm thinking this is wrong.
>>>
>>> That is, yes, this fixes the observed problem, but it also misses at
>>> least one other site. Which seems to suggest we ought to take a
>>> different approach.
>>>
>>> But even with that; I wonder if the actual condition isn't wrong.
>>> Suppose the event was exclusive, and other events weren't scheduled
>>> because of that. Then you disable the one exclusive event _and_ kill
>>> rotation, so then nothing else will ever get on.
>>>
>>> So what I think was supposed to happen is rotation killing itself;
>>> rotation will schedule out the context -- which will clear the flag, and
>>> then schedule the thing back in -- which will set the flag again when
>>> needed.
>>>
>>> Now, that isn't happening, and I think I see why, because when we drop
>>> to !nr_active, we terminate ctx_sched_out() before we get to clearing
>>> the flag, oops!
>>>
>>> So how about something like this?
>>>
>>> ---
>>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>>> index e453589da97c..7947bd3271a9 100644
>>> --- a/kernel/events/core.c
>>> +++ b/kernel/events/core.c
>>> @@ -2182,6 +2182,7 @@ __perf_remove_from_context(struct perf_event *event,
>>>    	if (!ctx->nr_events && ctx->is_active) {
>>>    		ctx->is_active = 0;
>>> +		ctx->rotate_necessary = 0;
>>>    		if (ctx->task) {
>>>    			WARN_ON_ONCE(cpuctx->task_ctx != ctx);
>>>    			cpuctx->task_ctx = NULL;
>>
>>
>> The patch can fix the observed problem with uncore PMU.
>> But it cannot fix all the cases with core PMU, especially when NMI watchdog
>> is enabled.
>> Because the ctx->nr_events never be 0 with NMI watchdog enabled.
> 
> But, I'm confused.. why do we care about nr_events==0 ? The below: vvvv
> 
>>> @@ -3074,15 +3075,15 @@ static void ctx_sched_out(struct perf_event_context *ctx,
>>>    	is_active ^= ctx->is_active; /* changed bits */
>>> -	if (!ctx->nr_active || !(is_active & EVENT_ALL))
>>> -		return;
>>> -
>>>    	/*
>>>    	 * If we had been multiplexing, no rotations are necessary, now no events
>>>    	 * are active.
>>>    	 */
>>>    	ctx->rotate_necessary = 0;
>>> +	if (!ctx->nr_active || !(is_active & EVENT_ALL))
>>> +		return;
>>> +
>>>    	perf_pmu_disable(ctx->pmu);
>>>    	if (is_active & EVENT_PINNED) {
>>>    		list_for_each_entry_safe(event, tmp, &ctx->pinned_active, active_list)
> 
> Makes sure we clear the flag when we ctx_sched_out(), and as long as
> ctx->rotate_necessary is set, perf_rotate_context() will do exactly
> that.
>

NMI watchdog is pinned event.
ctx_event_to_rotate() will only pick an event from the flexible_groups.
So the cpu_ctx_sched_out() in perf_rotate_context() will never be called.


Thanks,
Kan


> Then ctx_sched_in() will re-set the flag if it failed to schedule a
> counter.
> 
> So where is that going wrong?

