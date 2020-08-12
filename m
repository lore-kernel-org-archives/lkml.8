Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA562C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 07:25:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFDEE20781
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 07:25:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbgHLHZP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 03:25:15 -0400
Received: from mga11.intel.com ([192.55.52.93]:5555 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726572AbgHLHZP (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 03:25:15 -0400
IronPort-SDR: u14/qyfGAN1M6+KdpO1le6oggWkQdMz52bnjheWVsa2pXwDd8QSXQgZwVXAG4u8Oe3N1zGd8Lt
 wdwCn+Bp3rxw==
X-IronPort-AV: E=McAfee;i="6000,8403,9710"; a="151564338"
X-IronPort-AV: E=Sophos;i="5.76,303,1592895600"; 
   d="scan'208";a="151564338"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2020 00:25:14 -0700
IronPort-SDR: qHt8VwgY50FkTckdc70a2iHnvd96zGZJpY0l7Echlm93Wf7ZwKzbLKs+ZtKDEAKg1J22lRNLT/
 u+dbZ7R33RXg==
X-IronPort-AV: E=Sophos;i="5.76,303,1592895600"; 
   d="scan'208";a="469717800"
Received: from likexu-mobl1.ccr.corp.intel.com (HELO [10.238.4.128]) ([10.238.4.128])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2020 00:25:10 -0700
Subject: Re: [PATCH v1 2/2] perf/core: Fake regs for leaked kernel samples
To:     "Jin, Yao" <yao.jin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>
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
 <56957a58-6292-e075-8c30-6230450e3518@linux.intel.com>
 <20200811075924.GU3982@worktop.programming.kicks-ass.net>
 <dbc68bbf-b1a8-77ab-c89c-2d890a0382cc@linux.intel.com>
 <20200811084548.GW3982@worktop.programming.kicks-ass.net>
 <8bedaac0-2db1-b59c-581f-62f6d7a31c48@linux.intel.com>
From:   Like Xu <like.xu@linux.intel.com>
Organization: Intel OTC
Message-ID: <aa38dc24-4496-2d26-071e-26e9fbc3dbd4@linux.intel.com>
Date:   Wed, 12 Aug 2020 15:25:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <8bedaac0-2db1-b59c-581f-62f6d7a31c48@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/8/12 11:52, Jin, Yao wrote:
> Hi Peter,
> 
> On 8/11/2020 4:45 PM, Peter Zijlstra wrote:
>> On Tue, Aug 11, 2020 at 04:31:10PM +0800, Jin, Yao wrote:
>>> Hi Peter,
>>>
>>> On 8/11/2020 3:59 PM, Peter Zijlstra wrote:
>>>> On Tue, Aug 11, 2020 at 03:50:43PM +0800, Jin, Yao wrote:
>>>>> Could I post v2 which basically refers to your patch but removes some
>>>>> conditions since I see some issues in test if we use these conditions.
>>>>>
>>>>>    1. Remove '!event->attr.exclude_hv || !event->attr.exclude_host ||
>>>>>       !event->attr.exclude_guest' at the entry of sanitize_sample_regs().
>>>>>
>>>>>    2. Remove '!attr.exclude_hv || !attr.exclude_host || 
>>>>> !attr.exclude_guest'
>>>>>       at the perf_event_open syscall entry.
>>>>
>>>> exclude_host, maybe -- due to the dodgy semantics of it, but the others
>>>> should definitely be there.
>>>>
>>>
>>> exclude_guest and exclude_hv are tricky too.
>>>
>>> If we do 'perf record -e cycles:u' in both host and guest, we can see:
>>>
>>> event->attr.exclude_guest = 0
>>>
>>> thus sanitize_sample_regs() returns regs directly even if exclude_kernel 
>>> = 1.
>>>
>>> And in guest, exclude_hv = 0, it's out of my expectation too.
>>
>> I'm confused, how can 'perf record -e cycles:u' _ever_ have
>> exclude_guest=0, exclude_hv=0 ? That simply makes no sense and is utterly
>> broken.
>>
>> You explicitly ask for userspace-only, reporting hypervisor or guest
>> events is a straight up bug.

Guest events = guest user-space events + guest kernel-space events.

Some perf users on the host may only want to count guest user space events.

>>
> 
> If we run 'perf record -e cycles:u',
> 
> 1. On host, exclude_guest = 0 and exclude_hv = 1
> 
> perf tool doesn't specially set 'exclude_guest' when it parses the 'u' 
> modifier. I agree that can be improved. I will post a perf tool patch to 
> fix that.
> 
> 2. On guest, exclude_guest = 0 and exclude_hv = 0.
> 
> For exclude_hv = 0, it looks like a bug but x86 doesn't use exclude_hv. But 
> yes, we should fix that.
> 
> CC Like Xu <like.xu@linux.intel.com>.
> 
> Thanks
> Jin Yao

