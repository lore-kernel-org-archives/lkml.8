Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25FB5C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 13:28:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BBCF206D7
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 13:28:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730043AbgG1N2m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 09:28:42 -0400
Received: from mga14.intel.com ([192.55.52.115]:54568 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729433AbgG1N2m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 09:28:42 -0400
IronPort-SDR: P9DUjue29246UqiUbJVdovYfwT5Fg5MbQH4NXPRdcIfZmunff0IScT0jqArFndkomn7GsxRquU
 61eTr2qV08Jw==
X-IronPort-AV: E=McAfee;i="6000,8403,9695"; a="150376537"
X-IronPort-AV: E=Sophos;i="5.75,406,1589266800"; 
   d="scan'208";a="150376537"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2020 06:28:41 -0700
IronPort-SDR: 8896puvFZHSAmhO2JF43a4j24PxeEq8M38lm6yYFk5ZAQdaa/lJ1xF+sSCy5xS6mfPee1HX77l
 mUPMeLulsIBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,406,1589266800"; 
   d="scan'208";a="273567504"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga008.fm.intel.com with ESMTP; 28 Jul 2020 06:28:41 -0700
Received: from [10.252.128.28] (kliang2-mobl.ccr.corp.intel.com [10.252.128.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id D23975807B5;
        Tue, 28 Jul 2020 06:28:40 -0700 (PDT)
Subject: Re: [PATCH V7 08/14] perf/x86/intel: Generic support for hardware
 TopDown metrics
To:     Peter Zijlstra <peterz@infradead.org>
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
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <25a630c6-2fa2-5dfd-bcd3-92e809c51d61@linux.intel.com>
Date:   Tue, 28 Jul 2020 09:28:39 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200728130956.GK10769@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/28/2020 9:09 AM, Peter Zijlstra wrote:
> On Fri, Jul 24, 2020 at 03:10:52PM -0400, Liang, Kan wrote:
> 
>> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
>> index 6cb079e0c9d9..010ac74afc09 100644
>> --- a/arch/x86/events/intel/core.c
>> +++ b/arch/x86/events/intel/core.c
>> @@ -2405,27 +2405,18 @@ static u64 icl_update_topdown_event(struct
>> perf_event *event)
>>   	return slots;
>>   }
>>
>> -static void intel_pmu_read_topdown_event(struct perf_event *event)
>> +static void intel_pmu_read_event(struct perf_event *event)
>>   {
>> -	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
>> -
>> -	/* Only need to call update_topdown_event() once for group read. */
>> -	if ((cpuc->txn_flags & PERF_PMU_TXN_READ) &&
>> -	    !is_slots_event(event))
>>   		return;
>>
>> -	perf_pmu_disable(event->pmu);
>> -	x86_pmu.update_topdown_event(event);
>> -	perf_pmu_enable(event->pmu);
>> -}
>> -
>> -static void intel_pmu_read_event(struct perf_event *event)
>> -{
>>   	if (event->hw.flags & PERF_X86_EVENT_AUTO_RELOAD)
>>   		intel_pmu_auto_reload_read(event);
>> -	else if (is_topdown_count(event) && x86_pmu.update_topdown_event)
>> -		intel_pmu_read_topdown_event(event);
>> -	else
>> +	else if (is_slots_count(event) && x86_pmu.update_topdown_event) {
>> +		perf_pmu_disable(event->pmu);
>> +		x86_pmu.update_topdown_event(event);
>> +		perf_pmu_enable(event->pmu);
>> +	} else
>>   		x86_perf_event_update(event);
>>   }
> 
> I'm a little puzzled by this; what happens if you:
> 
> 	fd = sys_perf_event_open(&attr_slots);
> 	fd1 = sys_perf_event_open(&attr_metric, .group_fd=fd);
> 
> 	read(fd1);
> 
> ?
> 

I did a quick test. It depends on the .read_format of attr_metric.
If PERF_FORMAT_GROUP is applied for attr_metric, perf_read_group() will 
be invoked. The value of fd1 is updated correctly.
If the flag is not applied, 0 will be returned.

static ssize_t
__perf_read(struct perf_event *event, char __user *buf, size_t count)
{
	u64 read_format = event->attr.read_format;
	int ret;

	/*
	 * Return end-of-file for a read on an event that is in
	 * error state (i.e. because it was pinned but it couldn't be
	 * scheduled on to the CPU at some point).
	 */
	if (event->state == PERF_EVENT_STATE_ERROR)
		return 0;

	if (count < event->read_size)
		return -ENOSPC;

	WARN_ON_ONCE(event->ctx->parent_ctx);
	if (read_format & PERF_FORMAT_GROUP)
		ret = perf_read_group(event, read_format, buf);
	else
		ret = perf_read_one(event, read_format, buf);

	return ret;
}


Thanks,
Kan
