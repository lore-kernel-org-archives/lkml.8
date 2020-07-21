Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD245C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 14:06:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE5F420684
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 14:06:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728476AbgGUOF7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 10:05:59 -0400
Received: from mga07.intel.com ([134.134.136.100]:54766 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726120AbgGUOF7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 10:05:59 -0400
IronPort-SDR: 3dA7yP9YbIjZw7GjqI8pFYzPP2aKViNv1SLuTznOaZO4PWbhV0gGGH7/vbLaa0f5caOx6GTAQr
 5tx0MHYvtucA==
X-IronPort-AV: E=McAfee;i="6000,8403,9688"; a="214787154"
X-IronPort-AV: E=Sophos;i="5.75,379,1589266800"; 
   d="scan'208";a="214787154"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2020 07:05:57 -0700
IronPort-SDR: 8eC/48voajuzROVfO2NOK66pG4guDxsheMjDphDg/76LVob2xD5c5l6/IaO8AbI2GfNKUfFGET
 2NoRp/pIipow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,379,1589266800"; 
   d="scan'208";a="327881352"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga007.jf.intel.com with ESMTP; 21 Jul 2020 07:05:57 -0700
Received: from [10.254.76.99] (kliang2-mobl.ccr.corp.intel.com [10.254.76.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id DD12A580806;
        Tue, 21 Jul 2020 07:05:56 -0700 (PDT)
Subject: Re: [PATCH V6 07/14] perf/x86/intel: Generic support for hardware
 TopDown metrics
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     acme@redhat.com, mingo@kernel.org, linux-kernel@vger.kernel.org,
        jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com
References: <20200717140554.22863-1-kan.liang@linux.intel.com>
 <20200717140554.22863-8-kan.liang@linux.intel.com>
 <20200721094327.GW10769@hirez.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <3a6b082e-7906-9df1-28b9-c7639127e8a7@linux.intel.com>
Date:   Tue, 21 Jul 2020 10:05:55 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200721094327.GW10769@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/21/2020 5:43 AM, Peter Zijlstra wrote:
> On Fri, Jul 17, 2020 at 07:05:47AM -0700, kan.liang@linux.intel.com wrote:
>> @@ -1031,6 +1034,35 @@ int x86_schedule_events(struct cpu_hw_events *cpuc, int n, int *assign)
>>   	return unsched ? -EINVAL : 0;
>>   }
>>   
>> +static int add_nr_metric_event(struct cpu_hw_events *cpuc,
>> +			       struct perf_event *event,
>> +			       int *max_count, bool sibling)
>> +{
>> +	/* The TopDown metrics events cannot be shared. */
>> +	if (is_metric_event(event) &&
>> +	    (++cpuc->n_metric_event > INTEL_TD_METRIC_NUM)) {
>> +		cpuc->n_metric_event--;
>> +		return -EINVAL;
>> +	}
>> +
>> +	/*
>> +	 * Take the accepted metrics events into account for leader event.
>> +	 */
>> +	if (!sibling)
>> +		*max_count += cpuc->n_metric_event;
>> +	else if (is_metric_event(event))
>> +		(*max_count)++;
>> +
>> +	return 0;
>> +}
>> +
>> +static void del_nr_metric_event(struct cpu_hw_events *cpuc,
>> +				struct perf_event *event)
>> +{
>> +	if (is_metric_event(event))
>> +		cpuc->n_metric_event--;
>> +}
>> +
>>   /*
>>    * dogrp: true if must collect siblings events (group)
>>    * returns total number of events and error code
>> @@ -1066,6 +1098,10 @@ static int collect_events(struct cpu_hw_events *cpuc, struct perf_event *leader,
>>   		cpuc->pebs_output = is_pebs_pt(leader) + 1;
>>   	}
>>   
>> +	if (x86_pmu.intel_cap.perf_metrics &&
>> +	    add_nr_metric_event(cpuc, leader, &max_count, false))
>> +		return -EINVAL;
>> +
>>   	if (is_x86_event(leader)) {
>>   		if (n >= max_count)
>>   			return -EINVAL;
>> @@ -1082,6 +1118,10 @@ static int collect_events(struct cpu_hw_events *cpuc, struct perf_event *leader,
>>   		    event->state <= PERF_EVENT_STATE_OFF)
>>   			continue;
>>   
>> +		if (x86_pmu.intel_cap.perf_metrics &&
>> +		    add_nr_metric_event(cpuc, event, &max_count, true))
>> +			return -EINVAL;
>> +
>>   		if (n >= max_count)
>>   			return -EINVAL;
>>   
> 
> Something like so perhaps ?
> 
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -1035,24 +1035,14 @@ int x86_schedule_events(struct cpu_hw_ev
>   }
>   
>   static int add_nr_metric_event(struct cpu_hw_events *cpuc,
> -			       struct perf_event *event,
> -			       int *max_count, bool sibling)
> +			       struct perf_event *event)
>   {
> -	/* The TopDown metrics events cannot be shared. */
> -	if (is_metric_event(event) &&
> -	    (++cpuc->n_metric_event > INTEL_TD_METRIC_NUM)) {
> -		cpuc->n_metric_event--;
> -		return -EINVAL;
> +	if (is_metric_event(event)) {
> +		if (cpuc->n_metric == INTEL_TD_METRIC_NUM)
> +			return -EINVAL;
> +		cpuc->n_metric++;
>   	}
>   
> -	/*
> -	 * Take the accepted metrics events into account for leader event.
> -	 */
> -	if (!sibling)
> -		*max_count += cpuc->n_metric_event;
> -	else if (is_metric_event(event))
> -		(*max_count)++;
> -
>   	return 0;
>   }
>   
> @@ -1060,7 +1050,24 @@ static void del_nr_metric_event(struct c
>   				struct perf_event *event)
>   {
>   	if (is_metric_event(event))
> -		cpuc->n_metric_event--;
> +		cpuc->n_metric--;
> +}
> +
> +static int collect_event(struct cpu_hw_events *cpuc, struct perf_event *event,
> +			 int max_count, int n)
> +{
> +
> +	if (x86_pmu.intel_cap.perf_metrics && add_nr_metric_event(cpuc, event))
> +		return -EINVAL;
> +
> +	if (n >= max_count + cpuc->n_metric)
> +		return -EINVAL;
> +
> +	cpuc->event_list[n] = event;
> +	if (is_counter_pair(&event->hw))
> +		cpuc->n_pair++;
> +
> +	return 0;
>   }
>   
>   /*
> @@ -1098,37 +1105,20 @@ static int collect_events(struct cpu_hw_
>   		cpuc->pebs_output = is_pebs_pt(leader) + 1;
>   	}
>   
> -	if (x86_pmu.intel_cap.perf_metrics &&
> -	    add_nr_metric_event(cpuc, leader, &max_count, false))
> +	if (is_x86_event(leader) && collect_event(cpuc, leader, max_count, n))
>   		return -EINVAL;
> +	n++;

If a leader is not an x86 event, n will be mistakenly increased.
But is it possible that a leader is not an x86 event here?

Seems impossible for now. A SW event cannot be a leader for a mix group.
We don't allow the core PMU and the perf_invalid_context PMU in the same 
group.
If so, I think it deserves a comment, in case the situation changes 
later, e.g.,

  +	if (is_x86_event(leader) && collect_event(cpuc, leader, max_count, n))
   		return -EINVAL;
  +	/*
  +	 * Currently, for a x86 core event group, the leader must be a
  +	 * x86 core event. A SW event cannot be a leader for a mix
  +	 * group. We don't allow the core PMU and the perf_invalid_contex +	 
* PMU in the same group.
  +	 */
  +	n++;


Thanks,
Kan
>   
> -	if (is_x86_event(leader)) {
> -		if (n >= max_count)
> -			return -EINVAL;
> -		cpuc->event_list[n] = leader;
> -		n++;
> -		if (is_counter_pair(&leader->hw))
> -			cpuc->n_pair++;
> -	}
>   	if (!dogrp)
>   		return n;
>   
>   	for_each_sibling_event(event, leader) {
> -		if (!is_x86_event(event) ||
> -		    event->state <= PERF_EVENT_STATE_OFF)
> +		if (!is_x86_event(event) || event->state <= PERF_EVENT_STATE_OFF)
>   			continue;
>   
> -		if (x86_pmu.intel_cap.perf_metrics &&
> -		    add_nr_metric_event(cpuc, event, &max_count, true))
> -			return -EINVAL;
> -
> -		if (n >= max_count)
> +		if (collect_event(cpuc, event, max_count, n))
>   			return -EINVAL;
> -
> -		cpuc->event_list[n] = event;
>   		n++;
> -		if (is_counter_pair(&event->hw))
> -			cpuc->n_pair++;
>   	}
>   	return n;
>   }
> --- a/arch/x86/events/perf_event.h
> +++ b/arch/x86/events/perf_event.h
> @@ -313,7 +313,7 @@ struct cpu_hw_events {
>   	 * Perf Metrics
>   	 */
>   	/* number of accepted metrics events */
> -	int				n_metric_event;
> +	int				n_metric;
>   
>   	/*
>   	 * AMD specific bits
> 
