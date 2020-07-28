Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D404DC433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 14:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC61A206D4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 14:01:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730295AbgG1OB3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 10:01:29 -0400
Received: from mga05.intel.com ([192.55.52.43]:4697 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730248AbgG1OB3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 10:01:29 -0400
IronPort-SDR: AdXN3RxOhYXkZI+w16hAX+xx3zJz2eAnjSg4c7UKMJKkF5oIWDj8wkHACL/nccQJWXAIfLZ8Dl
 4vREmwOLlfCA==
X-IronPort-AV: E=McAfee;i="6000,8403,9695"; a="236073205"
X-IronPort-AV: E=Sophos;i="5.75,406,1589266800"; 
   d="scan'208";a="236073205"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2020 07:01:28 -0700
IronPort-SDR: w2etQZcEy/vnSpL4WuObiNTD4tpbcHE+V6FMLmCy8iibX5rsq1MxwmUIov44AtE1MjSSrwZ4tE
 SkXEbQGQ/Cgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,406,1589266800"; 
   d="scan'208";a="328348023"
Received: from linux.intel.com ([10.54.29.200])
  by FMSMGA003.fm.intel.com with ESMTP; 28 Jul 2020 07:01:28 -0700
Received: from [10.252.128.28] (kliang2-mobl.ccr.corp.intel.com [10.252.128.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 715F7580295;
        Tue, 28 Jul 2020 07:01:27 -0700 (PDT)
Subject: Re: [PATCH V7 08/14] perf/x86/intel: Generic support for hardware
 TopDown metrics
To:     peterz@infradead.org
Cc:     acme@redhat.com, mingo@kernel.org, linux-kernel@vger.kernel.org,
        jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com,
        like.xu@linux.intel.com
References: <20200723171117.9918-1-kan.liang@linux.intel.com>
 <20200723171117.9918-9-kan.liang@linux.intel.com>
 <20200724131906.GW119549@hirez.programming.kicks-ass.net>
 <20200724152755.GK43129@hirez.programming.kicks-ass.net>
 <d7ae2272-52ea-c5a9-2937-9a51c544ade8@linux.intel.com>
 <ddeae082-c38d-a961-4d90-1fbc1c9f2726@linux.intel.com>
 <20200728130956.GK10769@hirez.programming.kicks-ass.net>
 <25a630c6-2fa2-5dfd-bcd3-92e809c51d61@linux.intel.com>
 <20200728134412.GX119549@hirez.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <4313ed1f-03b2-48e7-36fe-6a112fa6c70f@linux.intel.com>
Date:   Tue, 28 Jul 2020 10:01:25 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200728134412.GX119549@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/28/2020 9:44 AM, peterz@infradead.org wrote:
> On Tue, Jul 28, 2020 at 09:28:39AM -0400, Liang, Kan wrote:
>>
>>
>> On 7/28/2020 9:09 AM, Peter Zijlstra wrote:
>>> On Fri, Jul 24, 2020 at 03:10:52PM -0400, Liang, Kan wrote:
>>>
>>>> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
>>>> index 6cb079e0c9d9..010ac74afc09 100644
>>>> --- a/arch/x86/events/intel/core.c
>>>> +++ b/arch/x86/events/intel/core.c
>>>> @@ -2405,27 +2405,18 @@ static u64 icl_update_topdown_event(struct
>>>> perf_event *event)
>>>>    	return slots;
>>>>    }
>>>>
>>>> -static void intel_pmu_read_topdown_event(struct perf_event *event)
>>>> +static void intel_pmu_read_event(struct perf_event *event)
>>>>    {
>>>> -	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
>>>> -
>>>> -	/* Only need to call update_topdown_event() once for group read. */
>>>> -	if ((cpuc->txn_flags & PERF_PMU_TXN_READ) &&
>>>> -	    !is_slots_event(event))
>>>>    		return;
>>>>
>>>> -	perf_pmu_disable(event->pmu);
>>>> -	x86_pmu.update_topdown_event(event);
>>>> -	perf_pmu_enable(event->pmu);
>>>> -}
>>>> -
>>>> -static void intel_pmu_read_event(struct perf_event *event)
>>>> -{
>>>>    	if (event->hw.flags & PERF_X86_EVENT_AUTO_RELOAD)
>>>>    		intel_pmu_auto_reload_read(event);
>>>> -	else if (is_topdown_count(event) && x86_pmu.update_topdown_event)
>>>> -		intel_pmu_read_topdown_event(event);
>>>> -	else
>>>> +	else if (is_slots_count(event) && x86_pmu.update_topdown_event) {
>>>> +		perf_pmu_disable(event->pmu);
>>>> +		x86_pmu.update_topdown_event(event);
>>>> +		perf_pmu_enable(event->pmu);
>>>> +	} else
>>>>    		x86_perf_event_update(event);
>>>>    }
>>>
>>> I'm a little puzzled by this; what happens if you:
>>>
>>> 	fd = sys_perf_event_open(&attr_slots);
>>> 	fd1 = sys_perf_event_open(&attr_metric, .group_fd=fd);
>>>
>>> 	read(fd1);
>>>
>>> ?
>>>
>>
>> I did a quick test. It depends on the .read_format of attr_metric.
>> If PERF_FORMAT_GROUP is applied for attr_metric, perf_read_group() will be
>> invoked. The value of fd1 is updated correctly.
>> If the flag is not applied, 0 will be returned.
> 
> Exactly :-), was that intentional?

Kind of, because a metric event must be in a group with the leader slots 
event. If a user reads (treats) the metric event as a singleton event, 
an invalid value should be expected.

> Because prior to this change that
> would've worked just fine.
> 
> Now, I agree it's a daft thing, because that value is pretty useless
> without also having the slots value, but I feel we should be explicit in
> our choices here.
> 
> If for example, we would've had hardware provide us the raw metric
> counters, instead of us having to reconstruct them, this would've been a
> semi useful thing.
> 
> So I'm tempted to leave things as it, and keep this 'working'.

I will update the perf tool document to force the PERF_FORMAT_GROUP flag 
for each metric events.

Thanks,
Kan

