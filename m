Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B422AC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 02:03:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 936D9206A5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 02:03:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbgHJCDX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Aug 2020 22:03:23 -0400
Received: from mga06.intel.com ([134.134.136.31]:24679 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726219AbgHJCDW (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Sun, 9 Aug 2020 22:03:22 -0400
IronPort-SDR: oDIF1CWv0rUzgibNQC4yCqMRCNLrfR4BNbywVtIk6Me2idiLRrUDi/hUwlu7FMdu0FP3Prsk7+
 8+gslKx6ZDlw==
X-IronPort-AV: E=McAfee;i="6000,8403,9708"; a="214984593"
X-IronPort-AV: E=Sophos;i="5.75,455,1589266800"; 
   d="scan'208";a="214984593"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2020 19:03:22 -0700
IronPort-SDR: 36fqRi0/Gkm43CKfmLqTRVeYkeljVwTSIvp7/seIz35ubL44gQ0ytkBSaWHY5s5+MplnjanG7T
 ssTEZVaGagHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,455,1589266800"; 
   d="scan'208";a="332075838"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.5.239]) ([10.238.5.239])
  by FMSMGA003.fm.intel.com with ESMTP; 09 Aug 2020 19:03:19 -0700
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
 <20200806110046.GF35926@hirez.programming.kicks-ass.net>
 <1d03d443-b187-bc1f-2601-a54037a64eff@linux.intel.com>
 <20200807090232.GE2674@hirez.programming.kicks-ass.net>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <c7f02b26-3417-c692-5f03-120642bf8910@linux.intel.com>
Date:   Mon, 10 Aug 2020 10:03:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200807090232.GE2674@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 8/7/2020 5:02 PM, peterz@infradead.org wrote:
> On Fri, Aug 07, 2020 at 02:24:30PM +0800, Jin, Yao wrote:
>> Hi Peter,
>>
>> On 8/6/2020 7:00 PM, peterz@infradead.org wrote:
>>> On Thu, Aug 06, 2020 at 11:18:27AM +0200, peterz@infradead.org wrote:
>>>
>>>> Suppose we have nested virt:
>>>>
>>>> 	L0-hv
>>>> 	|
>>>> 	G0/L1-hv
>>>> 	   |
>>>> 	   G1
>>>>
>>>> And we're running in G0, then:
>>>>
>>>>    - 'exclude_hv' would exclude L0 events
>>>>    - 'exclude_host' would ... exclude L1-hv events?
>>>>    - 'exclude_guest' would ... exclude G1 events?
>>>
>>> So in arch/x86/events/intel/core.c we have:
>>>
>>> static inline void intel_set_masks(struct perf_event *event, int idx)
>>> {
>>> 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
>>>
>>> 	if (event->attr.exclude_host)
>>> 		__set_bit(idx, (unsigned long *)&cpuc->intel_ctrl_guest_mask);
>>> 	if (event->attr.exclude_guest)
>>> 		__set_bit(idx, (unsigned long *)&cpuc->intel_ctrl_host_mask);
>>> 	if (event_is_checkpointed(event))
>>> 		__set_bit(idx, (unsigned long *)&cpuc->intel_cp_status);
>>> }
>>>
>>
>> exclude_host is now set by guest (pmc_reprogram_counter,
>> arch/x86/kvm/pmu.c). When enabling the event, we can check exclude_host to
>> know if it's a guest.
>>
>> Otherwise we may need more flags in event->attr to indicate the status.
>>
>>> which is, afaict, just plain wrong. Should that not be something like:
>>>
>>> 	if (!event->attr.exclude_host)
>>> 		__set_bit(idx, (unsigned long *)&cpuc->intel_ctrl_host_mask);
>>> 	if (!event->attr.exclude_guest)
>>> 		__set_bit(idx, (unsigned long *)&cpuc->intel_ctrl_guest_mask);
>>>
>>>
>>
>> How can we know it's guest or host even if exclude_host is set in guest?
> 
> I'm not following you, consider:
> 
> 	xh	xg	h	g	h'	g'
> 	0	0	0	0	1	1
> 	0	1	1	0	1	0
> 	1	0	0	1	0	1
> 	1	1	1	1	0	0
> 
> 

Thanks for the table! It clearly shows the combinations of different conditions.

My understanding is:

xh = exclude_host
xg = exclude_guest
h = intel_ctrl_host_mask (before)
g = intel_ctrl_guest_mask (before)
h' = intel_ctrl_host_mask (after)
g' = intel_ctrl_guest_mask (after)


For guest, exclude_host = 1 and exclude_guest = 0

xh	xg	h	g	h'	g'
1	0	0	1	0	1

before/after values are not changed.

For host, exclude_host = 0 and exclude_guest = 1

xh	xg	h	g	h'	g'
0	1	1	0	1	0

before/after values are not changed.

> So the 0,0 and 1,1 cases get flipped. I have a suspicion, but this
> _really_ should have fat comments all over :-(
> 

I'm not very sure about other cases.

xh	xg	h	g	h'	g'
0	0	0	0	1	1
1	1	1	1	0	0

The before/after values are just reversed. I don't know if there will be some negative impacts? 
Maybe we need more reviews here.

> What a sodding trainwreck..
> 

:(

Thanks
Jin Yao
