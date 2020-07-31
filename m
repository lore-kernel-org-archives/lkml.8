Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 685CAC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 18:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 574232177B
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 18:08:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387726AbgGaSIk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 14:08:40 -0400
Received: from mga12.intel.com ([192.55.52.136]:9821 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730040AbgGaSIj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 14:08:39 -0400
IronPort-SDR: mQgeWOw847zrXApQy7nDEuDmN7VgCF8EOVxyMnCrwGccP/zKCpo7VtULfR5+haxmuuLhlvHGqd
 +KlE4uqsPKyg==
X-IronPort-AV: E=McAfee;i="6000,8403,9698"; a="131415340"
X-IronPort-AV: E=Sophos;i="5.75,419,1589266800"; 
   d="scan'208";a="131415340"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2020 11:08:38 -0700
IronPort-SDR: qfjmM3S7zYwEkQ1lAntFZ8K5yBnB5hcnKkxu6nHgSMFPyu9GEFogDo+QyptTUp5YfIaZ+e77Fo
 T7iVU93o9TsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,419,1589266800"; 
   d="scan'208";a="287249965"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga003.jf.intel.com with ESMTP; 31 Jul 2020 11:08:38 -0700
Received: from [10.251.2.62] (kliang2-mobl.ccr.corp.intel.com [10.251.2.62])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 2474F58027C;
        Fri, 31 Jul 2020 11:08:38 -0700 (PDT)
Subject: Re: [PATCH] perf/x86: Reset the counter to prevent the leak for a
 RDPMC task
To:     peterz@infradead.org
Cc:     mingo@redhat.com, acme@kernel.org, linux-kernel@vger.kernel.org,
        ak@linux.intel.com, Mark Rutland <mark.rutland@arm.com>,
        Andy Lutomirski <luto@amacapital.net>
References: <20200730123815.18518-1-kan.liang@linux.intel.com>
 <20200730125817.GL2655@hirez.programming.kicks-ass.net>
 <cd65635b-d226-3089-cb4a-8f60ae408db5@linux.intel.com>
 <20200730164425.GO2655@hirez.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <5810ec13-7b40-b97f-c52b-31d1510c57c9@linux.intel.com>
Date:   Fri, 31 Jul 2020 14:08:36 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200730164425.GO2655@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/30/2020 12:44 PM, peterz@infradead.org wrote:
> On Thu, Jul 30, 2020 at 11:54:35AM -0400, Liang, Kan wrote:
>> On 7/30/2020 8:58 AM, peterz@infradead.org wrote:
>>> On Thu, Jul 30, 2020 at 05:38:15AM -0700, kan.liang@linux.intel.com wrote:
>>>> From: Kan Liang <kan.liang@linux.intel.com>
>>>>
>>>> The counter value of a perf task may leak to another RDPMC task.
>>>
>>> Sure, but nowhere did you explain why that is a problem.
>>>
>>>> The RDPMC instruction is only available for the X86 platform. Only apply
>>>> the fix for the X86 platform.
>>>
>>> ARM64 can also do it, although I'm not sure what the current state of
>>> things is here.
>>>
>>>> After applying the patch,
>>>>
>>>>       $ taskset -c 0 ./rdpmc_read_all_counters
>>>>       index 0x0 value 0x0
>>>>       index 0x1 value 0x0
>>>>       index 0x2 value 0x0
>>>>       index 0x3 value 0x0
>>>>
>>>>       index 0x0 value 0x0
>>>>       index 0x1 value 0x0
>>>>       index 0x2 value 0x0
>>>>       index 0x3 value 0x0
>>>
>>> You forgot about:
>>>
>>>    - telling us why it's a problem,
>>
>> The non-privileged RDPMC user can get the counter information from other
>> perf users. It is a security issue. I will add it in the next version.
> 
> You don't know what it counted and you don't know the offset, what can
> you do with it?

We cannot guarantee that an attacker doesn't know what the other thread 
is doing. Once they know the event name, they may take advantage of the 
perfmon counters to attack on a cryptosystem.

Here is one paper I googled. https://dl.acm.org/doi/pdf/10.1145/3156015
It mentioned that some events, e.g., cache misses and branch miss, can 
be used as a side channel to attack on cryptosystems.

There are potential security issues.
> 
>>>    - telling us how badly it affects performance.
>>
>> I once did performance test on a HSX machine. There is no notable slow down
>> with the patch. I will add the performance data in the next version.
> 
> It's still up to [4..8]+[3,4] extra WRMSRs per context switch, that's pretty naf.

I will do more performance test on a ICL with full GP counters and fixed 
counters enabled.

> 
>>> I would feel much better if we only did this on context switches to
>>> tasks that have RDPMC enabled.
>>
>> AFAIK, at least for X86, we can only enable/disable RDPMC globally.
>> How can we know if a specific task that have RDPMC enabled/disabled?
> 
> It has mm->context.pref_rdpmc_allowed non-zero, go read x86_pmu_event_{,un}mapped().
> Without that CR4.PCE is 0 and RDPMC won't work, which is most of the
> actual tasks.
> 

Thanks for pointing it out.

I think I can use event->mmap_count and PERF_X86_EVENT_RDPMC_ALLOWED to 
check whether the events of the task have RDPMC enabled.

> Arguably we should have perf_mmap_open() check if 'event->hw.target ==
> current', because without that RDPMC is still pointless. >
>>> So on del() mark the counter dirty (if we don't already have state that
>>> implies this), but don't WRMSR. And then on
>>> __perf_event_task_sched_in(), _after_ programming the new tasks'
>>> counters, check for inactive dirty counters and wipe those -- IFF RDPMC
>>> is on for that task.
>>>
>>
>> The generic code doesn't have counters' information. It looks like we need
>> to add a new callback to cleanup the dirty counters as below.
>>
>> In the specific implementation of pmu_cleanup(), we can check and wipe all
>> inactive dirty counters.
> 
> What about pmu::sched_task(), can't we rejig that a little?
> 
> The way I'm reading it now, it's like we iterate the task context for
> calling perf_event_context_sched_*(), and then iterate a cpuctx list to
> find cpuctx->task_ctx, which would be the exact same contexts we've just
> iterated.
> 
> So can't we pull the pmu::sched_task() call into
> perf_event_context_sched_*() ? That would save a round of
> pmu_disable/enable() too afaict.
> 

I think it's doable. I will do more test.

Thanks,
Kan

