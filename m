Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12F09C3F2D1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 01:40:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE65F20836
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 01:40:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387552AbgCDBkN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 20:40:13 -0500
Received: from mga05.intel.com ([192.55.52.43]:23655 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727958AbgCDBkN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 20:40:13 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Mar 2020 17:40:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,511,1574150400"; 
   d="scan'208";a="351970143"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga001.fm.intel.com with ESMTP; 03 Mar 2020 17:40:12 -0800
Received: from [10.251.17.20] (kliang2-mobl.ccr.corp.intel.com [10.251.17.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id A7E47580372;
        Tue,  3 Mar 2020 17:40:11 -0800 (PST)
Subject: Re: [PATCH] perf/core: Fix endless multiplex timer
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org, irogers@google.com,
        eranian@google.com, ak@linux.intel.com
References: <20200303202819.3942-1-kan.liang@linux.intel.com>
 <20200303210812.GA4745@worktop.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <b71515e4-484e-d80a-37db-2e51abe69928@linux.intel.com>
Date:   Tue, 3 Mar 2020 20:40:10 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200303210812.GA4745@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/3/2020 4:08 PM, Peter Zijlstra wrote:
> On Tue, Mar 03, 2020 at 12:28:19PM -0800, kan.liang@linux.intel.com wrote:
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> A lot of time are spent in writing uncore MSRs even though no perf is
>> running.
>>
>>    4.66%  swapper      [kernel.kallsyms]        [k] native_write_msr
>>              |
>>               --4.56%--native_write_msr
>>                         |
>>                         |--1.68%--snbep_uncore_msr_enable_box
>>                         |          perf_mux_hrtimer_handler
>>                         |          __hrtimer_run_queues
>>                         |          hrtimer_interrupt
>>                         |          smp_apic_timer_interrupt
>>                         |          apic_timer_interrupt
>>                         |          cpuidle_enter_state
>>                         |          cpuidle_enter
>>                         |          do_idle
>>                         |          cpu_startup_entry
>>                         |          start_kernel
>>                         |          secondary_startup_64
>>
>> The root cause is that multiplex timer was not stopped when perf stat
>> finished.
>> Current perf relies on rotate_necessary to determine whether the
>> multiplex timer should be stopped. The variable only be reset in
>> ctx_sched_out(), which is not enough for system-wide event.
>> Perf stat invokes PERF_EVENT_IOC_DISABLE to stop system-wide event
>> before closing it.
>>    perf_ioctl()
>>      perf_event_disable()
>>        event_sched_out()
>> The rotate_necessary will never be reset.
>>
>> The issue is a generic issue, not just impact the uncore.
>>
>> Check whether we had been multiplexing. If yes, reset rotate_necessary
>> for the last active event in __perf_event_disable().
>>
>> Fixes: fd7d55172d1e ("perf/cgroups: Don't rotate events for cgroups unnecessarily")
>> Reported-by: Andi Kleen <ak@linux.intel.com>
>> Reviewed-by: Andi Kleen <ak@linux.intel.com>
>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
>> ---
>>   kernel/events/core.c | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>> index 3f1f77de7247..50688de56181 100644
>> --- a/kernel/events/core.c
>> +++ b/kernel/events/core.c
>> @@ -2242,6 +2242,16 @@ static void __perf_event_disable(struct perf_event *event,
>>   		update_cgrp_time_from_event(event);
>>   	}
>>   
>> +	/*
>> +	 * If we had been multiplexing,
>> +	 * stop the rotations for the last active event.
>> +	 * Only need to check system wide events.
>> +	 * For task events, it will be checked in ctx_sched_out().
>> +	 */
>> +	if ((cpuctx->ctx.nr_events != cpuctx->ctx.nr_active) &&
>> +	    (cpuctx->ctx.nr_active == 1))
>> +		cpuctx->ctx.rotate_necessary = 0;
>> +
>>   	if (event == event->group_leader)
>>   		group_sched_out(event, cpuctx, ctx);
>>   	else
> 
> 
> I'm thinking this is wrong.
> 
> That is, yes, this fixes the observed problem, but it also misses at
> least one other site. Which seems to suggest we ought to take a
> different approach.
> 
> But even with that; I wonder if the actual condition isn't wrong.
> Suppose the event was exclusive, and other events weren't scheduled
> because of that. Then you disable the one exclusive event _and_ kill
> rotation, so then nothing else will ever get on.
> 
> So what I think was supposed to happen is rotation killing itself;
> rotation will schedule out the context -- which will clear the flag, and
> then schedule the thing back in -- which will set the flag again when
> needed.
> 
> Now, that isn't happening, and I think I see why, because when we drop
> to !nr_active, we terminate ctx_sched_out() before we get to clearing
> the flag, oops!
> 
> So how about something like this?
> 
> ---
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index e453589da97c..7947bd3271a9 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -2182,6 +2182,7 @@ __perf_remove_from_context(struct perf_event *event,
>   
>   	if (!ctx->nr_events && ctx->is_active) {
>   		ctx->is_active = 0;
> +		ctx->rotate_necessary = 0;
>   		if (ctx->task) {
>   			WARN_ON_ONCE(cpuctx->task_ctx != ctx);
>   			cpuctx->task_ctx = NULL;


The patch can fix the observed problem with uncore PMU.
But it cannot fix all the cases with core PMU, especially when NMI 
watchdog is enabled.
Because the ctx->nr_events never be 0 with NMI watchdog enabled.

For example,
$echo 1 > /proc/sys/kernel/nmi_watchdog
$sudo perf stat -e ref-cycles,ref-cycles -a sleep 1
  Performance counter stats for 'system wide':
     549,432,900      ref-cycles   (50.01%) 

     545,358,967      ref-cycles   (49.99%) 

  1.002367894 seconds time elapsed
$perf probe --add perf_rotate_context
$perf record -e probe:perf_rotate_context -aR -g sleep 1
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.896 MB perf.data (1750 samples) ]
$perf report --stdio
    100.00%   100.00%  (ffffffffa5604e84)
             |
              --99.83%--0xffffffffa54000d4
                        start_secondary
                        cpu_startup_entry
                        do_idle
                        call_cpuidle
                        cpuidle_enter
                        cpuidle_enter_state
                        apic_timer_interrupt
                        smp_apic_timer_interrupt
                        hrtimer_interrupt
                        __hrtimer_run_queues
                        perf_mux_hrtimer_handler

Thanks,
Kan

> @@ -3074,15 +3075,15 @@ static void ctx_sched_out(struct perf_event_context *ctx,
>   
>   	is_active ^= ctx->is_active; /* changed bits */
>   
> -	if (!ctx->nr_active || !(is_active & EVENT_ALL))
> -		return;
> -
>   	/*
>   	 * If we had been multiplexing, no rotations are necessary, now no events
>   	 * are active.
>   	 */
>   	ctx->rotate_necessary = 0;
>   
> +	if (!ctx->nr_active || !(is_active & EVENT_ALL))
> +		return;
> +
>   	perf_pmu_disable(ctx->pmu);
>   	if (is_active & EVENT_PINNED) {
>   		list_for_each_entry_safe(event, tmp, &ctx->pinned_active, active_list)
> 
