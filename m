Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ACD4C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 02:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 695D720823
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 02:26:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbgHFC0f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 22:26:35 -0400
Received: from mga18.intel.com ([134.134.136.126]:43952 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726005AbgHFC0e (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 22:26:34 -0400
IronPort-SDR: q2i9GI7K+MI8CZjwKAYJlqye2EbpCFYolos/mjhCiN5QGt6XNP5x8nP0mdIrt1nfPGG7rvXOhc
 ovzbTx1Qfr/A==
X-IronPort-AV: E=McAfee;i="6000,8403,9704"; a="140302011"
X-IronPort-AV: E=Sophos;i="5.75,440,1589266800"; 
   d="scan'208";a="140302011"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2020 19:26:33 -0700
IronPort-SDR: eteMGA0s2kFKljO5qpRAA1xpJY5M6m9Dnh87psf9zQ/SzIcbv04wpjiLcgnq4gGs58+uf9NU2g
 29hBP8OFZYFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,440,1589266800"; 
   d="scan'208";a="323288687"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.5.239]) ([10.238.5.239])
  by orsmga008.jf.intel.com with ESMTP; 05 Aug 2020 19:26:30 -0700
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
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <797aa4de-c618-f340-ad7b-cef38c96b035@linux.intel.com>
Date:   Thu, 6 Aug 2020 10:26:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200805124454.GP2657@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 8/5/2020 8:44 PM, peterz@infradead.org wrote:
> On Wed, Aug 05, 2020 at 10:15:26AM +0800, Jin, Yao wrote:
>> Hi Peter,
>>
>> On 8/4/2020 7:49 PM, peterz@infradead.org wrote:
>>> On Fri, Jul 31, 2020 at 10:56:17AM +0800, Jin Yao wrote:
>>>> @@ -6973,7 +6973,8 @@ static struct perf_callchain_entry __empty_callchain = { .nr = 0, };
>>>>    struct perf_callchain_entry *
>>>>    perf_callchain(struct perf_event *event, struct pt_regs *regs)
>>>>    {
>>>> -	bool kernel = !event->attr.exclude_callchain_kernel;
>>>> +	bool kernel = !event->attr.exclude_callchain_kernel &&
>>>> +		      !event->attr.exclude_kernel;
>>>
>>> This seems weird; how can we get there. Also it seems to me that if you
>>> have !exclude_callchain_kernel you already have permission for kernel
>>> bits, so who cares.
>>>
>>
>> In perf tool, exclude_callchain_kernel is set to 1 when perf-record only
>> collects the user callchains and exclude_kernel is set to 1 when events are
>> configured to run in user space.
>>
>> So if an event is configured to run in user space, that should make sense we
>> don't need it's kernel callchains.
>>
>> But it seems to me there is no code logic in perf tool which can make sure
>> !exclude_callchain_kernel -> !exclude_kernel.
>>
>> Jiri, Arnaldo, is my understanding correct?
> 
> What the perf tool does or does not do is irrelevant. It is a valid,
> (albeit slightly silly) configuration to have:
> 
> 	exclude_kernel && !exclude_callchain_kernel
> 
> You're now saying that when you configure things like this you're not
> allowed kernel IPs, that's wrong I think.
> 
> Also, !exclude_callchain_kernel should require privilidge, whcih needs
> fixing, see below.
> 

I see you add '!exclude_callchain_kernel' check before perf_allow_kernel() at syscall entry in below 
code.

So if we allow callchain_kernel collection that means we allow kernel by default. That makes sense, 
thanks!

>> So the new code looks like:
>>
>> if (event->attr.exclude_kernel && !user_mode(regs)) {
>> 	if (!(current->flags & PF_KTHREAD)) {
>> 		regs_fake = task_pt_regs(current);
>> 		if (!regs_fake)
>> 			instruction_pointer_set(regs, -1L);
>> 	} else {
>> 		instruction_pointer_set(regs, -1L);
>> 	}
> 
> Again:
> 
> 	if (!(current->flags & PF_KTHREAD))
> 		regs_fake = task_pt_regs(current);
> 
> 	if (!regs_fake)
> 		instruction_pointer_set(regs, -1L);
> 
> Is much simpler and more readable.
> 

Yes, agree. Your code is much simpler and better.

>>>> +		if ((header->misc & PERF_RECORD_MISC_CPUMODE_MASK) ==
>>>> +		     PERF_RECORD_MISC_KERNEL) {
>>>> +			header->misc &= ~PERF_RECORD_MISC_CPUMODE_MASK;
>>>> +			header->misc |= PERF_RECORD_MISC_USER;
>>>> +		}
>>>
>>> Why the conditional? At this point it had better be unconditionally
>>> user, no?
>>>
>>> 		headers->misc &= ~PERF_RECORD_MISC_CPUMODE_MASK;
>>> 		headers->misc |= PERF_RECORD_MISC_USER;
>>>
>>
>> #define PERF_RECORD_MISC_CPUMODE_MASK		(7 << 0)
>> #define PERF_RECORD_MISC_CPUMODE_UNKNOWN	(0 << 0)
>> #define PERF_RECORD_MISC_KERNEL			(1 << 0)
>> #define PERF_RECORD_MISC_USER			(2 << 0)
>> #define PERF_RECORD_MISC_HYPERVISOR		(3 << 0)
>> #define PERF_RECORD_MISC_GUEST_KERNEL		(4 << 0)
>> #define PERF_RECORD_MISC_GUEST_USER		(5 << 0)
>>
>> If we unconditionally set user, it will reset for hypervisor, guest
>> kernel and guest_user.
> 
> At the same time :u had better not get any of those either. Which seems
> to suggest we're going about this wrong.
> 
> Also, if we call this before perf_misc_flags() we don't need to fix it
> up.
> 
> How's this?
> 
> ---
>   kernel/events/core.c | 38 +++++++++++++++++++++++++++++++++-----
>   1 file changed, 33 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 7c436d705fbd..3e4e328b521a 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -6988,23 +6988,49 @@ perf_callchain(struct perf_event *event, struct pt_regs *regs)
>   	return callchain ?: &__empty_callchain;
>   }
>   
> +/*
> + * Due to interrupt latency (skid), we may enter the kernel before taking the
> + * PMI, even if the PMU is configured to only count user events. To avoid
> + * leaking kernel addresses, use task_pt_regs(), when available.
> + */
> +static struct pt_regs *sanitize_sample_regs(struct perf_event *event, struct pt_regs *regs)
> +{
> +	struct pt_regs *sample_regs = regs;
> +
> +	/* user only */
> +	if (!event->attr.exclude_kernel || !event->attr.exclude_hv ||
> +	    !event->attr.exclude_host   || !event->attr.exclude_guest)
> +		return sample_regs;
> +

Is this condition correct?

Say counting user event on host, exclude_kernel = 1 and exclude_host = 0. It will go "return 
sample_regs" path.

> +	if (sample_regs(regs))
> +		return sample_regs;
> +

In your another mail, you said it should be:

	if (user_regs(regs))
		return sample_regs;

> +	if (!(current->flags & PF_KTHREAD)) {

No '{', you mentioned in another mail.

> +		sample_regs = task_pt_regs(current);
> +	else
> +		instruction_pointer_set(regs, -1L);
> +
> +	return sample_regs;
> +}
> +
>   void perf_prepare_sample(struct perf_event_header *header,
>   			 struct perf_sample_data *data,
>   			 struct perf_event *event,
>   			 struct pt_regs *regs)
>   {
> +	struct pt_regs *sample_regs = sanitize_sample_regs(event, regs);
>   	u64 sample_type = event->attr.sample_type;
>   
>   	header->type = PERF_RECORD_SAMPLE;
>   	header->size = sizeof(*header) + event->header_size;
>   
>   	header->misc = 0;
> -	header->misc |= perf_misc_flags(regs);
> +	header->misc |= perf_misc_flags(sample_regs);
>   
>   	__perf_event_header__init_id(header, data, event);
>   
>   	if (sample_type & PERF_SAMPLE_IP)
> -		data->ip = perf_instruction_pointer(regs);
> +		data->ip = perf_instruction_pointer(sample_regs);
>   
>   	if (sample_type & PERF_SAMPLE_CALLCHAIN) {
>   		int size = 1;
> @@ -7054,9 +7080,10 @@ void perf_prepare_sample(struct perf_event_header *header,
>   		header->size += size;
>   	}
>   
> -	if (sample_type & (PERF_SAMPLE_REGS_USER | PERF_SAMPLE_STACK_USER))
> +	if (sample_type & (PERF_SAMPLE_REGS_USER | PERF_SAMPLE_STACK_USER)) {
>   		perf_sample_regs_user(&data->regs_user, regs,
>   				      &data->regs_user_copy);
> +	}
>   
>   	if (sample_type & PERF_SAMPLE_REGS_USER) {
>   		/* regs dump ABI info */
> @@ -7099,7 +7126,7 @@ void perf_prepare_sample(struct perf_event_header *header,
>   		/* regs dump ABI info */
>   		int size = sizeof(u64);
>   
> -		perf_sample_regs_intr(&data->regs_intr, regs);
> +		perf_sample_regs_intr(&data->regs_intr, sample_regs);
>   
>   		if (data->regs_intr.regs) {
>   			u64 mask = event->attr.sample_regs_intr;
> @@ -11609,7 +11636,8 @@ SYSCALL_DEFINE5(perf_event_open,
>   	if (err)
>   		return err;
>   
> -	if (!attr.exclude_kernel) {
> +	if (!attr.exclude_kernel || !attr.exclude_callchain_kernel ||
> +	    !attr.exclude_hv || !attr.exclude_host || !attr.exclude_guest) {
>   		err = perf_allow_kernel(&attr);
>   		if (err)
>   			return err;
> 

I can understand the conditions "!attr.exclude_kernel || !attr.exclude_callchain_kernel".

But I'm not very sure about the "!attr.exclude_hv || !attr.exclude_host || !attr.exclude_guest".

On host, exclude_hv = 1, exclude_guest = 1 and exclude_host = 0, right?

So even exclude_kernel = 1 but exclude_host = 0, we will still go perf_allow_kernel path. Please 
correct me if my understanding is wrong.

Thanks
Jin Yao
