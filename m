Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D7A6C2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 16:50:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 015A32073D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 16:50:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729100AbgATQuU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 11:50:20 -0500
Received: from mga14.intel.com ([192.55.52.115]:62575 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726897AbgATQuT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 11:50:19 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Jan 2020 08:50:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,342,1574150400"; 
   d="scan'208";a="220714436"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga007.fm.intel.com with ESMTP; 20 Jan 2020 08:50:17 -0800
Received: from [10.251.23.107] (kliang2-mobl.ccr.corp.intel.com [10.251.23.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id E5B225802C1;
        Mon, 20 Jan 2020 08:50:17 -0800 (PST)
Subject: Re: [PATCH] perf/x86/intel/ds: Fix x86_pmu_stop warning for large
 PEBS
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, ak@linux.intel.com,
        like.xu@linux.intel.com
References: <20200113140935.3474-1-kan.liang@linux.intel.com>
 <20200120105008.GN14879@hirez.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <b721cfd3-8fb5-5225-1fb7-29b8cc85f417@linux.intel.com>
Date:   Mon, 20 Jan 2020 11:50:16 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200120105008.GN14879@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/20/2020 5:50 AM, Peter Zijlstra wrote:
> On Mon, Jan 13, 2020 at 06:09:35AM -0800, kan.liang@linux.intel.com wrote:
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> A warning as below may be triggered when sampling large PEBS.
> 
>> [  410.729822] WARNING: CPU: 0 PID: 16397 at arch/x86/events/core.c:1422
>> x86_pmu_stop+0x95/0xa0
> 
>> For large PEBS, the PEBS buffer can be drained from either NMI handler
>> or !NMI e.g. context switch. Current implementation doesn't handle them
>> differently. For !nmi, perf also call the generic overflow handler for
>> the last PEBS record. That may trigger the interrupt throttle, and stop
>> the event. That's wrong.
>>
>> Here is an example for !NMI scenario, context switch.
>> Let's say the max_samples_per_tick is adjusted to 2 for some reason.
>> A context switch happens right after a NMI.
>> When an old task is scheduled out, it will drain the PEBS buffer, and
>> then delete the event.
>> When draining the PEBS buffer, perf_event_overflow() will be called for
>> the last PEBS record. Since the max_samples_per_tick is only 2, the
>> interrupt throttle must be triggered. The event will be stopped.
>> After the draining, the scheduler will delete the event, which stops the
>> event again. The warning is triggered.
>>
>> Perf should handle the NMI and !NMI differently for large PEBS.
>> For NMI, the generic overflow handler is required for the last PEBS
>> record.
>> But, for !NMI, there is no overflow. The generic overflow handler should
>> not be invoked. Perf should treat the last record exactly the same as
>> the rest of PEBS records.
> 
> Hurmph. there's something there, but the above is hard to read.
>

It describes an example as below
//max_samples_per_tick is adjusted to 2
//NMI happens
intel_pmu_handle_irq()
   handle_pmi_common()
     drain_pebs()
       __intel_pmu_pebs_event()
         perf_event_overflow()
           __perf_event_account_interrupt()
             hwc->interrupts = 1
             return 0
//A context switch right after the NMI.
//In the same tick, perf_throttled_seq is not changed.
perf_event_task_sched_out()
   perf_pmu_sched_task()
     intel_pmu_drain_pebs_buffer()
       __intel_pmu_pebs_event()
         perf_event_overflow()
           __perf_event_account_interrupt()
             ++hwc->interrupts >= max_samples_per_tick
             return 1
       x86_pmu_stop();  # First stop
   perf_event_context_sched_out()
     task_ctx_sched_out()
       ctx_sched_out()
         event_sched_out()
           x86_pmu_del()
             x86_pmu_stop();  # Second stop and trigger the warning

> drain_pebs() is called from:
> 
>   - handle_pmi_common()		-- sample context
>   - intel_pmu_pebs_sched_task()  -- non sample context
>   - intel_pmu_pebs_disable()     -- non sample context
>   - intel_pmu_auto_reload_read() -- possible sample context
> > So the question is what to do for PERF_SAMPLE_READ + PERF_FORMAT_GROUP.
> 
> I don't think throttling there is right either, but that does mean the
> simple in_nmi() test you use is wrong.


I'm not sure if it's accurate to call it sample/non sample context.
Because for large PEBS, it should always output samples here for any cases.

As my understanding, the sample context you mean is actually the same as 
interrupt context.
   - handle_pmi_common(): -- NMI
   - intel_pmu_pebs_sched_task(): -- Can only be invoked in !NMI
   - intel_pmu_pebs_disable(): -- Can only be invoked in !NMI
     (I think there is only one case which the function will be called
      in NMI, throttling triggered x86_pmu_stop(). For this case, the
      PEBS buffer has been drained. __intel_pmu_pebs_event() will not
      be touched.)
   - intel_pmu_auto_reload_read(): Can only be invoked in NMI via
     PERF_SAMPLE_READ. For other cases, it will be only invoked in !NMI.

The throttling here is to control the number of interrupts. In NMI 
context, we should check the throttling. Otherwise, it's unnecessary.

I think the in_nmi() test should be enough here.

> 
> Perhaps we can do something with how intel_pmu_drain_pebs_buffer()
> passes in dummy regs pointer to distinguish between the sample and non
> sample context.
> 
>> ---
>>   arch/x86/events/intel/ds.c | 23 +++++++++++++++--------
>>   1 file changed, 15 insertions(+), 8 deletions(-)
>>
>> diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
>> index 7c896d7e8b6c..51baff083938 100644
>> --- a/arch/x86/events/intel/ds.c
>> +++ b/arch/x86/events/intel/ds.c
>> @@ -1780,15 +1780,22 @@ static void __intel_pmu_pebs_event(struct perf_event *event,
>>   
>>   	setup_sample(event, iregs, at, &data, regs);
>>   
>> -	/*
>> -	 * All but the last records are processed.
>> -	 * The last one is left to be able to call the overflow handler.
>> -	 */
>> -	if (perf_event_overflow(event, &data, regs)) {
>> -		x86_pmu_stop(event, 0);
>> -		return;
>> +	if (in_nmi()) {
>> +		/*
>> +		 * All but the last records are processed.
>> +		 * The last one is left to be able to call the overflow handler.
>> +		 */
>> +		if (perf_event_overflow(event, &data, regs))
>> +			x86_pmu_stop(event, 0);
>> +	} else {
>> +		/*
>> +		 * For !NMI, e.g context switch, there is no overflow.
>> +		 * The generic overflow handler should not be invoked.
>> +		 * Perf should treat the last record exactly the same as the
>> +		 * rest of PEBS records.
>> +		 */
>> +		perf_event_output(event, &data, regs);
>>   	}
> 
> Maybe write it like so?
> 
> diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
> index 4b94ae4ae369..b66be085c7a4 100644
> --- a/arch/x86/events/intel/ds.c
> +++ b/arch/x86/events/intel/ds.c
> @@ -1747,25 +1747,22 @@ static void __intel_pmu_pebs_event(struct perf_event *event,
>   	} else if (!intel_pmu_save_and_restart(event))
>   		return;
>   
> -	while (count > 1) {
> +	while (count > /* cond */) {

What's cond?
Could you please elaborate?

Thanks,
Kan

>   		setup_sample(event, iregs, at, &data, regs);
>   		perf_event_output(event, &data, regs);
>   		at += cpuc->pebs_record_size;
>   		at = get_next_pebs_record_by_bit(at, top, bit);
> -		count--;
> +		if (!--count)
> +			return; >   	}
>   
> -	setup_sample(event, iregs, at, &data, regs);
> -
>   	/*
>   	 * All but the last records are processed.
>   	 * The last one is left to be able to call the overflow handler.
>   	 */
> -	if (perf_event_overflow(event, &data, regs)) {
> +	setup_sample(event, iregs, at, &data, regs);
> +	if (perf_event_overflow(event, &data, regs))
>   		x86_pmu_stop(event, 0);
> -		return;
> -	}
> -
>   }
>   
>   static void intel_pmu_drain_pebs_core(struct pt_regs *iregs)
> 
