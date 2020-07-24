Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A9E1C433EA
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 16:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32B4D20674
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 16:07:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728468AbgGXQHp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 12:07:45 -0400
Received: from mga11.intel.com ([192.55.52.93]:29460 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728039AbgGXQHo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 12:07:44 -0400
IronPort-SDR: 2LZSb+pHBH4e0hsToUChW+STfm3t2sa+P/MU+3fuDxxvBkLgKOmzCKYNwOIgI5U5hvsnHyqudL
 qV4fMIqfgw6g==
X-IronPort-AV: E=McAfee;i="6000,8403,9692"; a="148647110"
X-IronPort-AV: E=Sophos;i="5.75,391,1589266800"; 
   d="scan'208";a="148647110"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2020 09:07:42 -0700
IronPort-SDR: F8rEoAEGq1fN4gk0Q14cjgMCsVHsaBylkk6sPID/0kXCPqyCJsarDM/BvHHzboPXcM87GFtgrB
 u4IioW+MOr2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,391,1589266800"; 
   d="scan'208";a="433124626"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga004.jf.intel.com with ESMTP; 24 Jul 2020 09:07:42 -0700
Received: from [10.252.140.222] (kliang2-mobl.ccr.corp.intel.com [10.252.140.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id AC3F2580638;
        Fri, 24 Jul 2020 09:07:41 -0700 (PDT)
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
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <d7ae2272-52ea-c5a9-2937-9a51c544ade8@linux.intel.com>
Date:   Fri, 24 Jul 2020 12:07:40 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200724152755.GK43129@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/24/2020 11:27 AM, peterz@infradead.org wrote:
> On Fri, Jul 24, 2020 at 03:19:06PM +0200, peterz@infradead.org wrote:
>> On Thu, Jul 23, 2020 at 10:11:11AM -0700, kan.liang@linux.intel.com wrote:
>>> @@ -3375,6 +3428,72 @@ static int intel_pmu_hw_config(struct perf_event *event)
>>>   	if (event->attr.type != PERF_TYPE_RAW)
>>>   		return 0;
>>>   
>>> +	/*
>>> +	 * Config Topdown slots and metric events
>>> +	 *
>>> +	 * The slots event on Fixed Counter 3 can support sampling,
>>> +	 * which will be handled normally in x86_perf_event_update().
>>> +	 *
>>> +	 * The metric events don't support sampling.
>>> +	 *
>>> +	 * For counting, topdown slots and metric events will be
>>> +	 * handled specially for event update.
>>> +	 * A flag PERF_X86_EVENT_TOPDOWN is applied for the case.
>>> +	 */
>>> +	if (x86_pmu.intel_cap.perf_metrics && is_topdown_event(event)) {
>>> +		if (is_metric_event(event)) {
>>> +			struct perf_event *leader = event->group_leader;
>>> +			struct perf_event *sibling;
>>> +
>>> +			/* The metric events don't support sampling. */
>>> +			if (is_sampling_event(event))
>>> +				return -EINVAL;
>>> +
>>> +			/* The metric events cannot be a group leader. */
>>> +			if (leader == event)
>>> +				return -EINVAL;
>>> +
>>> +			/*
>>> +			 * The slots event cannot be the leader of a topdown
>>> +			 * sample-read group, e.g., {slots, topdown-retiring}:S
>>> +			 */
>>> +			if (is_slots_event(leader) && is_sampling_event(leader))
>>> +				return -EINVAL;
>>
>> This has nothing to do with sample-read; SLOTS cannot be sampling when
>> coupled with the METRIC stuff because hardware is daft.
>>
>> And you can have SAMPLE_READ on non-leader events just fine.
>>
>>> +
>>> +			/*
>>> +			 * The slots event must be before the metric events,
>>> +			 * because we only update the values of a topdown
>>> +			 * group once with the slots event.
>>> +			 */
>>> +			if (!is_slots_event(leader)) {
>>> +				for_each_sibling_event(sibling, leader) {
>>> +					if (is_slots_event(sibling))
>>> +						break;
>>> +					if (is_metric_event(sibling))
>>> +						return -EINVAL;
>>> +				}
>>> +			}
>>
>> Per the SIBLING patch this then wants to be:
>>
>> 			if (!is_slots_event(leader))
>> 				return -EINVAL;
>>
>> 			event->event_caps |= PERF_EV_CAP_SIBLING.
>> 			/*
>> 			 * Only once we have a METRICs sibling to we
>> 			 * need TopDown magic.
>> 			 */
>> 			leader->hw.flags |= PERF_X86_EVENT_TOPDOWN;
>>> +		}
>>> +
>>> +		if (!is_sampling_event(event)) {
>>> +			if (event->attr.config1 != 0)
>>> +				return -EINVAL;
>>
>> How does this depend on sampling?
>>
>>> +			/*
>>> +			 * The TopDown metrics events and slots event don't
>>> +			 * support any filters.
>>> +			 */
>>> +			if (event->attr.config & X86_ALL_EVENT_FLAGS)
>>> +				return -EINVAL;
>>
>> That seems independent of sampling too. Even a sampling SLOTS shouldn't
>> be having any of those afaict.
>>
>>> +
>>> +			event->hw.flags |= PERF_X86_EVENT_TOPDOWN;
>>
>> This is confusing too, a !sampling SLOTS event without METRIC siblings
>> shouldn't have this set, right? So arguably, this should be like above.
>>
>>> +
>>> +			event->event_caps |= PERF_EV_CAP_COEXIST;
>>> +
>>> +			if (is_metric_event(event))
>>> +				event->hw.flags &= ~PERF_X86_EVENT_RDPMC_ALLOWED;
>>
>> This too seems like something that should be in the is_metric_event()
>> branch above.
>>
>>> +		}
>>> +	}
>>> +
>>>   	if (!(event->attr.config & ARCH_PERFMON_EVENTSEL_ANY))
>>>   		return 0;
>>>   
> 
> FWIW, I pushed out a branch with all these changes in:
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git perf/metric
> 
> Just to get it some build love, if you want it differently, I'm happy to
> throw it all out again.

Thanks Peter.

I will pull the branch and do more tests.

Thanks,
Kan
