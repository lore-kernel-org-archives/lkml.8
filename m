Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F843C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 05:23:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85DA42177B
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 05:23:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726175AbgHGFXO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 01:23:14 -0400
Received: from mga18.intel.com ([134.134.136.126]:62442 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726126AbgHGFXN (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 01:23:13 -0400
IronPort-SDR: +M9k1FLPEn48nFZr6Mk36CAHjbkuAFUA3+irpNgmwb+YrTjWXQAO2GbvkaniEPjHxQPmgHZpU5
 crG8VpSabGYw==
X-IronPort-AV: E=McAfee;i="6000,8403,9705"; a="140593998"
X-IronPort-AV: E=Sophos;i="5.75,444,1589266800"; 
   d="scan'208";a="140593998"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2020 22:23:13 -0700
IronPort-SDR: srx7j9xD8L3kwHnBSk3uQkkVaHdxhwMp8fpz/GUdYeYhNEai4rBYz8SxZyVvvfVLc1/HNMUjSU
 drcvr9wNMvTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,444,1589266800"; 
   d="scan'208";a="323658062"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.5.239]) ([10.238.5.239])
  by orsmga008.jf.intel.com with ESMTP; 06 Aug 2020 22:23:09 -0700
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
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <a9175efa-e74b-ac92-869e-996e289bf018@linux.intel.com>
Date:   Fri, 7 Aug 2020 13:23:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200806091827.GY2674@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 8/6/2020 5:18 PM, peterz@infradead.org wrote:
> On Thu, Aug 06, 2020 at 10:26:29AM +0800, Jin, Yao wrote:
> 
>>> +static struct pt_regs *sanitize_sample_regs(struct perf_event *event, struct pt_regs *regs)
>>> +{
>>> +	struct pt_regs *sample_regs = regs;
>>> +
>>> +	/* user only */
>>> +	if (!event->attr.exclude_kernel || !event->attr.exclude_hv ||
>>> +	    !event->attr.exclude_host   || !event->attr.exclude_guest)
>>> +		return sample_regs;
>>> +
>>
>> Is this condition correct?
>>
>> Say counting user event on host, exclude_kernel = 1 and exclude_host = 0. It
>> will go "return sample_regs" path.
> 
> I'm not sure, I'm terminally confused on virt stuff.
> 
> Suppose we have nested virt:
> 
> 	L0-hv
> 	|
> 	G0/L1-hv
> 	   |
> 	   G1
> 
> And we're running in G0, then:
> 
>   - 'exclude_hv' would exclude L0 events
>   - 'exclude_host' would ... exclude L1-hv events?

I think the exclude_host is generally set by guest (/arch/x86/kvm/pmu.c, pmc_reprogram_counter).

If G0 is a host, if we set exclude_host in G0, I think we will not be able to count the events on G0.

The appropriate usage is, G1 sets the exclude_host, then the events on G0 will not be collected by 
guest G1.

That's my understanding for the usage of exclude_host.

>   - 'exclude_guest' would ... exclude G1 events?
> 

Similarly, the appropriate usage is, the host (G0) sets the exclude_guest, then the events on G1 
will not be collected by host G0.

If G1 sets exclude_guest, since no guest is under G1, that's ineffective.

> Then the next question is, if G0 is a host, does the L1-hv run in
> G0 userspace or G0 kernel space?
> 

I'm not very sure. Maybe some in kernel, some in userspace(qemu)? Maybe some KVM experts can help to 
answer this question.

> I was assuming G0 userspace would not include anything L1 (kvm is a
> kernel module after all), but what do I know.
> 

I have tested following conditions in native environment (not in KVM guests), the result is not 
expected.

/* user only */
if (!event->attr.exclude_kernel || !event->attr.exclude_hv ||
     !event->attr.exclude_host   || !event->attr.exclude_guest)
         return sample_regs;

perf record -e cycles:u ./div
perf report --stdio

  # Overhead  Command  Shared Object     Symbol
  # ........  .......  ................  .......................
  #
      49.51%  div      libc-2.27.so      [.] __random_r
      33.93%  div      libc-2.27.so      [.] __random
       8.13%  div      libc-2.27.so      [.] rand
       4.29%  div      div               [.] main
       4.14%  div      div               [.] rand@plt
       0.00%  div      [unknown]         [k] 0xffffffffbd600cb0
       0.00%  div      [unknown]         [k] 0xffffffffbd600df0
       0.00%  div      ld-2.27.so        [.] _dl_relocate_object
       0.00%  div      ld-2.27.so        [.] _dl_start
       0.00%  div      ld-2.27.so        [.] _start

0xffffffffbd600cb0 and 0xffffffffbd600df0 are leaked kernel addresses.

 From debug, I can see:

[ 6272.320258] jinyao: sanitize_sample_regs: event->attr.exclude_kernel = 1, event->attr.exclude_hv 
= 1, event->attr.exclude_host = 0, event->attr.exclude_guest = 0

So it goes "return sample_regs;" path.

>>> @@ -11609,7 +11636,8 @@ SYSCALL_DEFINE5(perf_event_open,
>>>    	if (err)
>>>    		return err;
>>> -	if (!attr.exclude_kernel) {
>>> +	if (!attr.exclude_kernel || !attr.exclude_callchain_kernel ||
>>> +	    !attr.exclude_hv || !attr.exclude_host || !attr.exclude_guest) {
>>>    		err = perf_allow_kernel(&attr);
>>>    		if (err)
>>>    			return err;
>>>
>>
>> I can understand the conditions "!attr.exclude_kernel || !attr.exclude_callchain_kernel".
>>
>> But I'm not very sure about the "!attr.exclude_hv || !attr.exclude_host || !attr.exclude_guest".
> 
> Well, I'm very sure G0 userspace should never see L0 or G1 state, so
> exclude_hv and exclude_guest had better be true.
> 
>> On host, exclude_hv = 1, exclude_guest = 1 and exclude_host = 0, right?
> 
> Same as above, is G0 host state G0 userspace?
> 
>> So even exclude_kernel = 1 but exclude_host = 0, we will still go
>> perf_allow_kernel path. Please correct me if my understanding is wrong.
> 
> Yes, because with those permission checks in place it means you have
> permission to see kernel bits.
> 

At the syscall entry, I also added some printk.

Aug  7 03:37:40 kbl-ppc kernel: [  854.688045] syscall: attr.exclude_kernel = 1, 
attr.exclude_callchain_kernel = 0, attr.exclude_hv = 0, attr.exclude_host = 0, attr.exclude_guest = 0

For my test case ("perf record -e cycles:u ./div"), the perf_allow_kernel() is also executed.

Thanks
Jin Yao
