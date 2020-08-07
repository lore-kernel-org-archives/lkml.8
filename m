Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6C28C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 06:24:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA0D022D00
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 06:24:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbgHGGYf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 02:24:35 -0400
Received: from mga03.intel.com ([134.134.136.65]:57393 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725379AbgHGGYf (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 02:24:35 -0400
IronPort-SDR: 31i3ylkGB3hKMkCLwwl7zL4105EViOSCJOPAGVmGXTbED3wketAtP3/+n35i8pkOSYRC0tm99W
 YHs8/CRWN3vA==
X-IronPort-AV: E=McAfee;i="6000,8403,9705"; a="152977193"
X-IronPort-AV: E=Sophos;i="5.75,444,1589266800"; 
   d="scan'208";a="152977193"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2020 23:24:34 -0700
IronPort-SDR: huJd/lVVwUtCWnSKGLh7ckeH+x+Y58COZcTNohZIkopRpa4YH9GaJO5+Rc0wia8Ylek+jqD4N9
 dDzDp97VQBsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,444,1589266800"; 
   d="scan'208";a="323671588"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.5.239]) ([10.238.5.239])
  by orsmga008.jf.intel.com with ESMTP; 06 Aug 2020 23:24:31 -0700
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
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <1d03d443-b187-bc1f-2601-a54037a64eff@linux.intel.com>
Date:   Fri, 7 Aug 2020 14:24:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200806110046.GF35926@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 8/6/2020 7:00 PM, peterz@infradead.org wrote:
> On Thu, Aug 06, 2020 at 11:18:27AM +0200, peterz@infradead.org wrote:
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
> So in arch/x86/events/intel/core.c we have:
> 
> static inline void intel_set_masks(struct perf_event *event, int idx)
> {
> 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
> 
> 	if (event->attr.exclude_host)
> 		__set_bit(idx, (unsigned long *)&cpuc->intel_ctrl_guest_mask);
> 	if (event->attr.exclude_guest)
> 		__set_bit(idx, (unsigned long *)&cpuc->intel_ctrl_host_mask);
> 	if (event_is_checkpointed(event))
> 		__set_bit(idx, (unsigned long *)&cpuc->intel_cp_status);
> }
> 

exclude_host is now set by guest (pmc_reprogram_counter, arch/x86/kvm/pmu.c). When enabling the 
event, we can check exclude_host to know if it's a guest.

Otherwise we may need more flags in event->attr to indicate the status.

> which is, afaict, just plain wrong. Should that not be something like:
> 
> 	if (!event->attr.exclude_host)
> 		__set_bit(idx, (unsigned long *)&cpuc->intel_ctrl_host_mask);
> 	if (!event->attr.exclude_guest)
> 		__set_bit(idx, (unsigned long *)&cpuc->intel_ctrl_guest_mask);
> 
> 

How can we know it's guest or host even if exclude_host is set in guest?

Thanks
Jin Yao

> Also, ARM64 seems to also implement this stuff, Mark, do you have any
> insight on how all this is 'supposed' to work?
> 
