Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C83EEC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 02:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B31C220658
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 02:15:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726585AbgHECPa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 22:15:30 -0400
Received: from mga17.intel.com ([192.55.52.151]:56132 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725904AbgHECPa (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 22:15:30 -0400
IronPort-SDR: TF1F0PLo+IIk0p6cDlQwCa6zz5WpXCepPGd9JAy//fLrGbQCdTDhQQl0qo/jHyeH9VKum7BSW0
 BORgOdiGzZHA==
X-IronPort-AV: E=McAfee;i="6000,8403,9703"; a="132527403"
X-IronPort-AV: E=Sophos;i="5.75,436,1589266800"; 
   d="scan'208";a="132527403"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2020 19:15:29 -0700
IronPort-SDR: ODAW8pQ7TE7CjEqwtVO8h+h5eloajf2QBZqXOd8uMvVvzxbvY6KaP8GpA4syL25WMWdY3Sq1Ue
 eZZ0bsHft1fg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,436,1589266800"; 
   d="scan'208";a="330790837"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.5.239]) ([10.238.5.239])
  by FMSMGA003.fm.intel.com with ESMTP; 04 Aug 2020 19:15:27 -0700
Subject: Re: [PATCH v1 2/2] perf/core: Fake regs for leaked kernel samples
To:     peterz@infradead.org
Cc:     mingo@redhat.com, oleg@redhat.com, acme@kernel.org,
        jolsa@kernel.org, Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        alexander.shishkin@linux.intel.com, mark.rutland@arm.com
References: <20200731025617.16243-1-yao.jin@linux.intel.com>
 <20200731025617.16243-2-yao.jin@linux.intel.com>
 <20200804114900.GI2657@hirez.programming.kicks-ass.net>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <4c958d61-11a7-9f3e-9e7d-d733270144a1@linux.intel.com>
Date:   Wed, 5 Aug 2020 10:15:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200804114900.GI2657@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 8/4/2020 7:49 PM, peterz@infradead.org wrote:
> On Fri, Jul 31, 2020 at 10:56:17AM +0800, Jin Yao wrote:
>> @@ -6973,7 +6973,8 @@ static struct perf_callchain_entry __empty_callchain = { .nr = 0, };
>>   struct perf_callchain_entry *
>>   perf_callchain(struct perf_event *event, struct pt_regs *regs)
>>   {
>> -	bool kernel = !event->attr.exclude_callchain_kernel;
>> +	bool kernel = !event->attr.exclude_callchain_kernel &&
>> +		      !event->attr.exclude_kernel;
> 
> This seems weird; how can we get there. Also it seems to me that if you
> have !exclude_callchain_kernel you already have permission for kernel
> bits, so who cares.
> 

In perf tool, exclude_callchain_kernel is set to 1 when perf-record only collects the user 
callchains and exclude_kernel is set to 1 when events are configured to run in user space.

So if an event is configured to run in user space, that should make sense we don't need it's kernel 
callchains.

But it seems to me there is no code logic in perf tool which can make sure !exclude_callchain_kernel 
-> !exclude_kernel.

Jiri, Arnaldo, is my understanding correct?

>>   	bool user   = !event->attr.exclude_callchain_user;
>>   	/* Disallow cross-task user callchains. */
>>   	bool crosstask = event->ctx->task && event->ctx->task != current;
>> @@ -6988,12 +6989,39 @@ perf_callchain(struct perf_event *event, struct pt_regs *regs)
>>   	return callchain ?: &__empty_callchain;
>>   }
>>   
>> +static struct pt_regs *leak_check(struct perf_event_header *header,
>> +				  struct perf_event *event,
>> +				  struct pt_regs *regs)
>> +{
>> +	struct pt_regs *regs_fake = NULL;
>> +
>> +	if (event->attr.exclude_kernel && !user_mode(regs)) {
>> +		if (!(current->flags & PF_KTHREAD)) {
>> +			regs_fake = task_pt_regs(current);
>> +			if (!user_mode(regs_fake)) {
>> +				regs_fake = NULL;
>> +				instruction_pointer_set(regs, -1L);
>> +			}
>> +		} else
>> +			instruction_pointer_set(regs, -1L);
> 
> That violates coding style, also:
> 

Thanks, I should use:

} else {
	instruction_pointer_set(regs, -1L);
}

> 		if (!(current->flags & PF_KTHREAD)) {
> 			regs_fake = task_pt_regs(current);
> 			if (!user_mode(regs_fake)) /* is this not a BUG?  */

We don't need !user_mode(regs_fake) check here, it's unnecessary check.

> 				regs_fake = NULL;
> 		}
> 
> 		if (!regs_fake)
> 			instruction_pointer_set(regs, -1L);
> 
> Seems simpler to me.
> 

So the new code looks like:

if (event->attr.exclude_kernel && !user_mode(regs)) {
	if (!(current->flags & PF_KTHREAD)) {
		regs_fake = task_pt_regs(current);
		if (!regs_fake)
			instruction_pointer_set(regs, -1L);
	} else {
		instruction_pointer_set(regs, -1L);
	}

>> +		if ((header->misc & PERF_RECORD_MISC_CPUMODE_MASK) ==
>> +		     PERF_RECORD_MISC_KERNEL) {
>> +			header->misc &= ~PERF_RECORD_MISC_CPUMODE_MASK;
>> +			header->misc |= PERF_RECORD_MISC_USER;
>> +		}
> 
> Why the conditional? At this point it had better be unconditionally
> user, no?
> 
> 		headers->misc &= ~PERF_RECORD_MISC_CPUMODE_MASK;
> 		headers->misc |= PERF_RECORD_MISC_USER;
> 

#define PERF_RECORD_MISC_CPUMODE_MASK		(7 << 0)
#define PERF_RECORD_MISC_CPUMODE_UNKNOWN	(0 << 0)
#define PERF_RECORD_MISC_KERNEL			(1 << 0)
#define PERF_RECORD_MISC_USER			(2 << 0)
#define PERF_RECORD_MISC_HYPERVISOR		(3 << 0)
#define PERF_RECORD_MISC_GUEST_KERNEL		(4 << 0)
#define PERF_RECORD_MISC_GUEST_USER		(5 << 0)

If we unconditionally set user, it will reset for hypervisor, guest kernel and guest_user.

Thanks
Jin Yao

>> +	}
>> +
>> +	return regs_fake;
>> +}
