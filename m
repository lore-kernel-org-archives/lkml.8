Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF2F3C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 15:51:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A04B2064B
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 15:51:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730552AbgIIPuo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 11:50:44 -0400
Received: from mga06.intel.com ([134.134.136.31]:23424 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730531AbgIIPr2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 11:47:28 -0400
IronPort-SDR: 1/HSBCQ/StzPDNXfGqndVhLv5wz+JthTlNteEjBy5hXPbd0+M90M1cHLwBHv1mJOMHY4+iwXoc
 ok4ZD9+gxxrw==
X-IronPort-AV: E=McAfee;i="6000,8403,9738"; a="219883494"
X-IronPort-AV: E=Sophos;i="5.76,409,1592895600"; 
   d="scan'208";a="219883494"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2020 06:24:50 -0700
IronPort-SDR: UMs5gRWYyWyrlSkp57ES8g69bpH63/Ng4aWNnwVVoPO447Duk2J7/L/ecK7HOYLW8wBNJJvwqn
 AJWfVSYi7SAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,409,1592895600"; 
   d="scan'208";a="328907722"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP; 09 Sep 2020 06:24:49 -0700
Received: from [10.252.140.133] (kliang2-MOBL.ccr.corp.intel.com [10.252.140.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 08737580709;
        Wed,  9 Sep 2020 06:24:48 -0700 (PDT)
Subject: Re: [PATCH V2 3/3] perf/x86: Reset the dirty counter to prevent the
 leak for an RDPMC task
To:     peterz@infradead.org
Cc:     mingo@redhat.com, acme@kernel.org, linux-kernel@vger.kernel.org,
        ak@linux.intel.com, mark.rutland@arm.com, luto@amacapital.net
References: <20200821195754.20159-1-kan.liang@linux.intel.com>
 <20200821195754.20159-3-kan.liang@linux.intel.com>
 <20200907160115.GS2674@hirez.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <8157c3b0-e22c-fff1-0a3c-b2ad57a7abcb@linux.intel.com>
Date:   Wed, 9 Sep 2020 09:24:47 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200907160115.GS2674@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/8/2020 11:58 AM, peterz@infradead.org wrote:
 > On Mon, Sep 07, 2020 at 06:01:15PM +0200, peterz@infradead.org wrote:
 >> On Fri, Aug 21, 2020 at 12:57:54PM -0700, kan.liang@linux.intel.com
 >>> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
 >>> index 0f3d01562ded..fa08d810dcd2 100644
 >>> --- a/arch/x86/events/core.c
 >>> +++ b/arch/x86/events/core.c
 >>> @@ -1440,7 +1440,10 @@ static void x86_pmu_start(struct perf_event
 >>> *event, int flags)
 >>>
 >>>   	cpuc->events[idx] = event;
 >>>   	__set_bit(idx, cpuc->active_mask);
 >>> -	__set_bit(idx, cpuc->running);
 >>> +	/* The cpuc->running is only used by the P4 PMU */
 >>> +	if (!cpu_has(&boot_cpu_data, X86_FEATURE_ARCH_PERFMON) &&
 >>> +	    (boot_cpu_data.x86 == 0xf))
 >>> +		__set_bit(idx, cpuc->running);
 >>>   	x86_pmu.enable(event);
 >>>   	perf_event_update_userpage(event);
 >>>   }
 >>
 >> Yuck! Use a static_branch() or something. This is a gnarly nest of
 >> code
 >> that runs 99.9% of the time to conclude a negative. IOW a complete
 >> waste
 >> of cycles for everybody not running a P4 space heater.
 >
 > Better still, move it into p4_pmu_enable_event().
 >

Sure, I will move the "cpuc->running" into P4 specific code.

On 9/7/2020 12:01 PM, peterz@infradead.org wrote:
>> @@ -1544,6 +1547,9 @@ static void x86_pmu_del(struct perf_event *event, int flags)
>>   	if (cpuc->txn_flags & PERF_PMU_TXN_ADD)
>>   		goto do_del;
>>   
>> +	if (READ_ONCE(x86_pmu.attr_rdpmc) && x86_pmu.sched_task &&
>> +	    test_bit(event->hw.idx, cpuc->active_mask))
>> +		__set_bit(event->hw.idx, cpuc->dirty);
> 
> And that too seems like an overly complicated set of tests and branches.
> This should be effectivly true for the 99% common case.

I made a mistake in the V2 version regarding whether P4 PMU supports 
RDPMC. SDM explicitly documents that the RDPMC instruction was 
introduced in P6. I once thought P4 is older than P6, but I'm wrong. P4 
should have NetBurst microarchitecture which is the successor to the P6.
So P4 should also support the RDPMC instruction.

We should not share the memory space between the 'dirty' and the 
'running' variable. I will modify it in V3

I will also unconditionally set cpuc->dirty here. The worst case for an 
RDPMC task is that we may have to clear all counters for the first time 
in x86_pmu_event_mapped. After that, the sched_task() will clear/update 
the 'dirty'. Only the real 'dirty' counters are clear. For non-RDPMC 
task, it's harmless to unconditionally set the cpuc->dirty.


>>   static void x86_pmu_event_mapped(struct perf_event *event, struct mm_struct *mm)
>>   {
>>   	if (!(event->hw.flags & PERF_X86_EVENT_RDPMC_ALLOWED))
>>   		return;
>>   
>> +	/*
>> +	 * Enable sched_task() for the RDPMC task,
>> +	 * and clear the existing dirty counters.
>> +	 */
>> +	if (x86_pmu.sched_task && event->hw.target && !is_sampling_event(event)) {
>> +		perf_sched_cb_inc(event->ctx->pmu);
>> +		x86_pmu_clear_dirty_counters();
>> +	}
> 
> I'm failing to see the correctness of the !is_sampling_event() part
> there.

It looks like an RDPMC task can do sampling as well? I once thought it 
only does counting. I will fix it in V3.


> 
>>   	/*
>>   	 * This function relies on not being called concurrently in two
>>   	 * tasks in the same mm.  Otherwise one task could observe
>> @@ -2246,6 +2286,9 @@ static void x86_pmu_event_unmapped(struct perf_event *event, struct mm_struct *m
>>   	if (!(event->hw.flags & PERF_X86_EVENT_RDPMC_ALLOWED))
>>   		return;
>>   
>> +	if (x86_pmu.sched_task && event->hw.target && !is_sampling_event(event))
>> +		perf_sched_cb_dec(event->ctx->pmu);
>> +
> 
> Idem.
> 
>>   	if (atomic_dec_and_test(&mm->context.perf_rdpmc_allowed))
>>   		on_each_cpu_mask(mm_cpumask(mm), cr4_update_pce, NULL, 1);
>>   }
>> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
>> index c72e4904e056..e67713bfa33a 100644
>> --- a/arch/x86/events/intel/core.c
>> +++ b/arch/x86/events/intel/core.c
>> @@ -4166,11 +4166,39 @@ static void intel_pmu_cpu_dead(int cpu)
>>   	intel_cpuc_finish(&per_cpu(cpu_hw_events, cpu));
>>   }
>>   
>> +static void intel_pmu_rdpmc_sched_task(struct perf_event_context *ctx)
>> +{
>> +	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
>> +	struct perf_event *event;
>> +
>> +	if (bitmap_empty(cpuc->dirty, X86_PMC_IDX_MAX))
>> +		return;
>> +
>> +	/*
>> +	 * If the new task has the RDPMC enabled, clear the dirty counters to
>> +	 * prevent the potential leak. If the new task doesn't have the RDPMC
>> +	 * enabled, do nothing.
>> +	 */
>> +	list_for_each_entry(event, &ctx->event_list, event_entry) {
>> +		if (event->hw.target &&
>> +		    (event->hw.flags & PERF_X86_EVENT_RDPMC_ALLOWED) &&
>> +		    !is_sampling_event(event) &&
>> +		    atomic_read(&event->mmap_count))
>> +			break;
>> +	}
>> +	if (&event->event_entry == &ctx->event_list)
>> +		return;
> 
> That's horrific, what's wrong with something like:
> 
> 	if (!atomic_read(&current->mm->context.perf_rdpmc_allowed))
> 		return;
>

After removing the !is_sampling_event() part, I think we can use this.
I will use it in V3.

>> +
>> +	x86_pmu_clear_dirty_counters();
>> +}
> 
> How is this Intel specific code? IIRC AMD has RDPMC too.
> 

Sure, I will move the code to X86 generic code.

Thanks,
Kan
