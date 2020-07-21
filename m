Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1D80C433E7
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 16:07:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92FD22077D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 16:07:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730225AbgGUQHd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 12:07:33 -0400
Received: from mga12.intel.com ([192.55.52.136]:61091 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726919AbgGUQHc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 12:07:32 -0400
IronPort-SDR: dytW+NQ8S8AKrgEvnJVVHi3/or3NpVYwTYQqp/0LkBmza7as9RLAfM0zMIo8pE0PSqkCxHkW1H
 Ohxa0CqG2N5A==
X-IronPort-AV: E=McAfee;i="6000,8403,9689"; a="129730195"
X-IronPort-AV: E=Sophos;i="5.75,379,1589266800"; 
   d="scan'208";a="129730195"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2020 09:07:32 -0700
IronPort-SDR: BZgi8pRxecwjluMjlbtpRSkG/SvlD7Rln6mjzYftGmnMAT2fiJaxkMz23W7EQA7jp23u+5oHe4
 +/QdyUYrSC3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,379,1589266800"; 
   d="scan'208";a="487668467"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga006.fm.intel.com with ESMTP; 21 Jul 2020 09:07:32 -0700
Received: from [10.254.76.99] (kliang2-mobl.ccr.corp.intel.com [10.254.76.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 3A950580299;
        Tue, 21 Jul 2020 09:07:31 -0700 (PDT)
Subject: Re: [PATCH V6 11/14] perf/x86/intel: Disable sample-read the slots
 and metrics events
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     acme@redhat.com, mingo@kernel.org, linux-kernel@vger.kernel.org,
        jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com
References: <20200717140554.22863-1-kan.liang@linux.intel.com>
 <20200717140554.22863-12-kan.liang@linux.intel.com>
 <20200721131011.GY10769@hirez.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <b24b9bd3-bbfb-98d4-4df3-c263e002dcf5@linux.intel.com>
Date:   Tue, 21 Jul 2020 12:07:29 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200721131011.GY10769@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/21/2020 9:10 AM, Peter Zijlstra wrote:
> On Fri, Jul 17, 2020 at 07:05:51AM -0700, kan.liang@linux.intel.com wrote:
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> Users fail to sample-read the slots and metrics events, e.g.,
>> perf record -e '{slots, topdown-retiring}:S'.
>>
>> When reading the metrics event, the fixed counter 3 (slots) has to be
>> reset, which impacts the sampling of the slots event.
>>
>> Add a specific validate_group() support to reject the case and error out
>> for Ice Lake.
>>
>> An alternative fix may unconditionally disable slots sampling, but it's
>> not a decent fix. Users may want to only sample the slot events
>> without the topdown metrics events.
>>
>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> 
> I'm confused by this; it doesn't make sense.
> 
> Should not patch 7 have something like the below instead?
> > Also, I think there is a bug when we create a group like this and then
> kill the leader, in that case the core code will 'promote' the sibling
> metric events to their own individual events, see perf_group_detach().

I'm trying to produce the bug mentioned above, but I'm not sure under 
what situation, the core code will 'promote' the sibling metric events?

I tried the suggested code below. It works well for the sample-read 
case. Perf tool errors out as expected.

   perf record -e '{slots,topdown-fe-bound}:S' sleep 1
   Error:
   The sys_perf_event_open() syscall returned with 22 (Invalid argument) 
for event (topdown-fe-bound).
   /bin/dmesg | grep -i perf may provide additional information.

Thanks,
Kan

> 
> We need additional code to move those events into unrecoverable ERROR
> state. A new group_caps flag could indicate this promotion isn't
> allowed.
> 
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -3441,8 +3441,22 @@ static int intel_pmu_hw_config(struct pe
>   	 * A flag PERF_X86_EVENT_TOPDOWN is applied for the case.
>   	 */
>   	if (x86_pmu.intel_cap.perf_metrics && is_topdown_event(event)) {
> -		if (is_metric_event(event) && is_sampling_event(event))
> -			return -EINVAL;
> +
> +		if (is_metric_event(event)) {
> +			struct perf_event *leader = event->group_leader;
> +
> +			if (is_sampling_event(event))
> +				return -EINVAL;
> +
> +			if (leader == event)
> +				return -EINVAL;
> +
> +			if (!is_slots_event(leader))
> +				return -EINVAL;
> +
> +			if (is_sampling_event(leader))
> +				return -EINVAL;
> +		}
>   
>   		if (!is_sampling_event(event)) {
>   			if (event->attr.config1 != 0)
> 
