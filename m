Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A08A4C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 05:32:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8757A2086A
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 05:32:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbgHGFcp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 01:32:45 -0400
Received: from mga18.intel.com ([134.134.136.126]:63274 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725379AbgHGFco (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 01:32:44 -0400
IronPort-SDR: OZj2mWmemSxL3M3jVB6tmNbDdos9PYyBchb8TJIlWVUHfedhT4ZpAjtIgYX/hZGohW41mCEReW
 xkqnqp8j5Q9g==
X-IronPort-AV: E=McAfee;i="6000,8403,9705"; a="140596035"
X-IronPort-AV: E=Sophos;i="5.75,444,1589266800"; 
   d="scan'208";a="140596035"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2020 22:32:43 -0700
IronPort-SDR: pLfGEBJpI7xx0p5sg0RMxkJZgy6UhOtl8I9/47/YNbBasKhay6fkpbB7i5Uc1RFBaRc9nlUSg9
 A922vMQpXvJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,444,1589266800"; 
   d="scan'208";a="323660042"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.5.239]) ([10.238.5.239])
  by orsmga008.jf.intel.com with ESMTP; 06 Aug 2020 22:32:40 -0700
Subject: Re: [PATCH v1 2/2] perf/core: Fake regs for leaked kernel samples
To:     peterz@infradead.org
Cc:     mingo@redhat.com, oleg@redhat.com, acme@kernel.org,
        jolsa@kernel.org, Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        alexander.shishkin@linux.intel.com, mark.rutland@arm.com
References: <20200731025617.16243-1-yao.jin@linux.intel.com>
 <20200731025617.16243-2-yao.jin@linux.intel.com>
 <20200804114900.GI2657@hirez.programming.kicks-ass.net>
 <4c958d61-11a7-9f3e-9e7d-d733270144a1@linux.intel.com>
 <20200805124454.GP2657@hirez.programming.kicks-ass.net>
 <797aa4de-c618-f340-ad7b-cef38c96b035@linux.intel.com>
 <20200806091827.GY2674@hirez.programming.kicks-ass.net>
 <20200806092454.GE35926@hirez.programming.kicks-ass.net>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <207564ba-6faa-e054-af3f-5af233cc0637@linux.intel.com>
Date:   Fri, 7 Aug 2020 13:32:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200806092454.GE35926@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 8/6/2020 5:24 PM, peterz@infradead.org wrote:
> On Thu, Aug 06, 2020 at 11:18:27AM +0200, peterz@infradead.org wrote:
>> On Thu, Aug 06, 2020 at 10:26:29AM +0800, Jin, Yao wrote:
>>
>>>> +static struct pt_regs *sanitize_sample_regs(struct perf_event *event, struct pt_regs *regs)
>>>> +{
>>>> +	struct pt_regs *sample_regs = regs;
>>>> +
>>>> +	/* user only */
>>>> +	if (!event->attr.exclude_kernel || !event->attr.exclude_hv ||
>>>> +	    !event->attr.exclude_host   || !event->attr.exclude_guest)
>>>> +		return sample_regs;
>>>> +
>>>
>>> Is this condition correct?
>>>
>>> Say counting user event on host, exclude_kernel = 1 and exclude_host = 0. It
>>> will go "return sample_regs" path.
>>
>> I'm not sure, I'm terminally confused on virt stuff.
> 
> [A]
> 
>> Suppose we have nested virt:
>>
>> 	L0-hv
>> 	|
>> 	G0/L1-hv
>> 	   |
>> 	   G1
>>
>> And we're running in G0, then:
>>
>>   - 'exclude_hv' would exclude L0 events
>>   - 'exclude_host' would ... exclude L1-hv events?
>>   - 'exclude_guest' would ... exclude G1 events?
> 
> [B]
> 
>> Then the next question is, if G0 is a host, does the L1-hv run in
>> G0 userspace or G0 kernel space?
>>
>> I was assuming G0 userspace would not include anything L1 (kvm is a
>> kernel module after all), but what do I know.
>>
>>>> @@ -11609,7 +11636,8 @@ SYSCALL_DEFINE5(perf_event_open,
>>>>    	if (err)
>>>>    		return err;
>>>> -	if (!attr.exclude_kernel) {
>>>> +	if (!attr.exclude_kernel || !attr.exclude_callchain_kernel ||
>>>> +	    !attr.exclude_hv || !attr.exclude_host || !attr.exclude_guest) {
>>>>    		err = perf_allow_kernel(&attr);
>>>>    		if (err)
>>>>    			return err;
>>>>
>>>
>>> I can understand the conditions "!attr.exclude_kernel || !attr.exclude_callchain_kernel".
>>>
>>> But I'm not very sure about the "!attr.exclude_hv || !attr.exclude_host || !attr.exclude_guest".
>>
>> Well, I'm very sure G0 userspace should never see L0 or G1 state, so
>> exclude_hv and exclude_guest had better be true.
>>
>>> On host, exclude_hv = 1, exclude_guest = 1 and exclude_host = 0, right?
>>
>> Same as above, is G0 host state G0 userspace?
>>
>>> So even exclude_kernel = 1 but exclude_host = 0, we will still go
>>> perf_allow_kernel path. Please correct me if my understanding is wrong.
>>
>> Yes, because with those permission checks in place it means you have
>> permission to see kernel bits.
> 
> So if I understand 'exclude_host' wrong -- a distinct possibility -- can
> we then pretty please have the above [A-B] corrected and put in a
> comment near perf_event_attr and the exclude_* comments changed to refer
> to that?
> 

In my previous mail, I explained what I understood for 'exclude_host', but not sure if it's correct. 
Needs more review comments.

Thanks
Jin Yao
