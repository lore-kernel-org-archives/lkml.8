Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D648C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 18:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB3E7206E2
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 18:14:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbgGHSN7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 14:13:59 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:45502 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725978AbgGHSN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 14:13:59 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R471e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04397;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0U28W.i._1594232033;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0U28W.i._1594232033)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 09 Jul 2020 02:13:55 +0800
Subject: Re: [RFC PATCH] mm: avoid access flag update TLB flush for retried
 page fault
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Will Deacon <will@kernel.org>, hannes@cmpxchg.org,
        will.deacon@arm.com, akpm@linux-foundation.org,
        xuyu@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <1594148072-91273-1-git-send-email-yang.shi@linux.alibaba.com>
 <20200708075959.GA25498@willie-the-truck>
 <7cf3b3fe-76bb-edc4-7421-9313ef949d7b@linux.alibaba.com>
 <20200708172912.GE6308@gaia>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <dee57dea-d216-654e-5a00-053ba28578bb@linux.alibaba.com>
Date:   Wed, 8 Jul 2020 11:13:50 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20200708172912.GE6308@gaia>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/8/20 10:29 AM, Catalin Marinas wrote:
> On Wed, Jul 08, 2020 at 09:40:11AM -0700, Yang Shi wrote:
>> On 7/8/20 1:00 AM, Will Deacon wrote:
>>> On Wed, Jul 08, 2020 at 02:54:32AM +0800, Yang Shi wrote:
>>>> Recently we found regression when running will_it_scale/page_fault3 test
>>>> on ARM64.  Over 70% down for the multi processes cases and over 20% down
>>>> for the multi threads cases.  It turns out the regression is caused by commit
>>>> 89b15332af7c0312a41e50846819ca6613b58b4c ("mm: drop mmap_sem before
>>>> calling balance_dirty_pages() in write fault").
>>>>
>>>> The test mmaps a memory size file then write to the mapping, this would
>>>> make all memory dirty and trigger dirty pages throttle, that upstream
>>>> commit would release mmap_sem then retry the page fault.  The retried
>>>> page fault would see correct PTEs installed by the first try then update
>>>> access flags and flush TLBs.  The regression is caused by the excessive
>>>> TLB flush.  It is fine on x86 since x86 doesn't need flush TLB for
>>>> access flag update.
>>>>
>>>> The page fault would be retried due to:
>>>> 1. Waiting for page readahead
>>>> 2. Waiting for page swapped in
>>>> 3. Waiting for dirty pages throttling
>>>>
>>>> The first two cases don't have PTEs set up at all, so the retried page
>>>> fault would install the PTEs, so they don't reach there.  But the #3
>>>> case usually has PTEs installed, the retried page fault would reach the
>>>> access flag update.  But it seems not necessary to update access flags
>>>> for #3 since retried page fault is not real "second access", so it
>>>> sounds safe to skip access flag update for retried page fault.
> Is this the access flag or the dirty flag? On arm64 we distinguish
> between the two. Setting the access flag on arm64 doesn't need TLB
> flushing since an inaccessible entry is not allowed to be cached in the
> TLB. However, setting the dirty bit (clearing read-only on arm64) does
> require a TLB flush and ptep_set_access_flags() takes care of this.

I think it is dirty bit if updating access bit doesn't need flush TLB.

>
>>>> With this fix the test result get back to normal.
>>>>
>>>> Reported-by: Xu Yu <xuyu@linux.alibaba.com>
>>>> Debugged-by: Xu Yu <xuyu@linux.alibaba.com>
>>>> Tested-by: Xu Yu <xuyu@linux.alibaba.com>
>>>> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
>>>> ---
>>>> I'm not sure if this is safe for non-x86 machines, we did some tests on arm64, but
>>>> there may be still corner cases not covered.
>>>>
>>>>    mm/memory.c | 7 ++++++-
>>>>    1 file changed, 6 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/mm/memory.c b/mm/memory.c
>>>> index 87ec87c..3d4e671 100644
>>>> --- a/mm/memory.c
>>>> +++ b/mm/memory.c
>>>> @@ -4241,8 +4241,13 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
>>>>    	if (vmf->flags & FAULT_FLAG_WRITE) {
>>>>    		if (!pte_write(entry))
>>>>    			return do_wp_page(vmf);
>>>> -		entry = pte_mkdirty(entry);
>>>>    	}
>>>> +
>>>> +	if ((vmf->flags & FAULT_FLAG_WRITE) && !(vmf->flags & FAULT_FLAG_TRIED))
>>>> +		entry = pte_mkdirty(entry);
>>>> +	else if (vmf->flags & FAULT_FLAG_TRIED)
>>>> +		goto unlock;
>>>> +
>>> Can you rewrite this as:
>>>
>>> 	if (vmf->flags & FAULT_FLAG_TRIED)
>>> 		goto unlock;
>>>
>>> 	if (vmf->flags & FAULT_FLAG_WRITE)
>>> 		entry = pte_mkdirty(entry);
>> Yes, it does the same.
>>
>>> ? (I'm half-asleep this morning and there are people screaming and shouting
>>> outside my window, so this might be rubbish)
>>>
>>> If you _can_make that change, then I don't understand why the existing
>>> pte_mkdirty() line needs to move at all. Couldn't you just add:
>>>
>>> 	if (vmf->flags & FAULT_FLAG_TRIED)
>>> 		goto unlock;
>>>
>>> after the existing "vmf->flags & FAULT_FLAG_WRITE" block?
>> The intention is to not set dirty bit if it is in retried page fault since
>> the bit should be already set in the first try. And, I'm not quite sure if
>> TLB needs to be flushed on non-x86 if dirty bit is set. If it is
>> unnecessary, then the above change does make sense.
> It is necessary on arm32/arm64 since pte_mkdirty() clears the read-only
> bit.

Thanks for confirming this. I didn't realize pte_mkdirty() also clears 
read-only bit on arm.

>
> But do we have guarantee that every time handle_mm_fault() returns
> VM_FAULT_RETRY, the pte has already been updated?

I think so if I understand the code correctly.

As I mentioned in the commit log, there 3 places which could return 
VM_FAULT_RETRY then retry page fault.

The first two cases (swap and readahead) just return before PTEs are 
installed, so the retried page fault should not reach here at all (just 
finish the handling in do_fault() or do_swap_page() like the first try).

So only dirty pages throttling may reach here since the throttling 
happens after PTEs are setup. The write fault handler already set PTEs 
with dirty bit, please see the below code snippet from alloc_set_pte():

entry = mk_pte(page, vma->vm_page_prot);
         entry = pte_sw_mkyoung(entry);
         if (write)
                 entry = maybe_mkwrite(pte_mkdirty(entry), vma);

So the retried page fault should come in with dirty bit set.

Of course the parallel page fault may set up PTEs, but we just need care 
about write fault. If the parallel page fault setup a writable and dirty 
PTE then the retried fault doesn't need do anything extra. If the 
parallel page fault setup a clean read-only PTE, the below code should 
be executed in the retried page fault:

if (vmf->flags & FAULT_FLAG_WRITE) {
         if (!pte_write(entry))
             return do_wp_page(vmf);
         entry = pte_mkdirty(entry);

The retried fault should just call do_wp_page() then return.

>

