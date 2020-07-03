Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA09DC433E1
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 01:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 945C8207E8
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 01:34:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbgGCBem (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 21:34:42 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:35125 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726017AbgGCBel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 21:34:41 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0U1XFdqr_1593740075;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0U1XFdqr_1593740075)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 03 Jul 2020 09:34:36 +0800
Date:   Fri, 3 Jul 2020 09:34:35 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Wei Yang <richard.weiyang@linux.alibaba.com>,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        akpm@linux-foundation.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-mm@kvack.org
Subject: Re: [PATCH] mm: define pte_add_end for consistency
Message-ID: <20200703013435.GA11340@L-31X9LVDL-1304.local>
Reply-To: Wei Yang <richard.weiyang@linux.alibaba.com>
References: <20200630031852.45383-1-richard.weiyang@linux.alibaba.com>
 <40362e99-a354-c44f-8645-e2326a6df680@redhat.com>
 <20200701021113.GA51306@L-31X9LVDL-1304.local>
 <da4a470e-f34c-fbf8-c95a-93a7d30a215b@redhat.com>
 <20200701115441.GA4979@L-31X9LVDL-1304.local>
 <7562991b-c1e7-4037-a3f0-124acd0669b7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7562991b-c1e7-4037-a3f0-124acd0669b7@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 02, 2020 at 06:28:19PM +0200, David Hildenbrand wrote:
>On 01.07.20 13:54, Wei Yang wrote:
>> On Wed, Jul 01, 2020 at 10:29:08AM +0200, David Hildenbrand wrote:
>>> On 01.07.20 04:11, Wei Yang wrote:
>>>> On Tue, Jun 30, 2020 at 02:44:00PM +0200, David Hildenbrand wrote:
>>>>> On 30.06.20 05:18, Wei Yang wrote:
>>>>>> When walking page tables, we define several helpers to get the address of
>>>>>> the next boundary. But we don't have one for pte level.
>>>>>>
>>>>>> Let's define it and consolidate the code in several places.
>>>>>>
>>>>>> Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>
>>>>>> ---
>>>>>>  arch/x86/mm/init_64.c   | 6 ++----
>>>>>>  include/linux/pgtable.h | 7 +++++++
>>>>>>  mm/kasan/init.c         | 4 +---
>>>>>>  3 files changed, 10 insertions(+), 7 deletions(-)
>>>>>>
>>>>>> diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
>>>>>> index dbae185511cd..f902fbd17f27 100644
>>>>>> --- a/arch/x86/mm/init_64.c
>>>>>> +++ b/arch/x86/mm/init_64.c
>>>>>> @@ -973,9 +973,7 @@ remove_pte_table(pte_t *pte_start, unsigned long addr, unsigned long end,
>>>>>>  
>>>>>>  	pte = pte_start + pte_index(addr);
>>>>>>  	for (; addr < end; addr = next, pte++) {
>>>>>> -		next = (addr + PAGE_SIZE) & PAGE_MASK;
>>>>>> -		if (next > end)
>>>>>> -			next = end;
>>>>>> +		next = pte_addr_end(addr, end);
>>>>>>  
>>>>>>  		if (!pte_present(*pte))
>>>>>>  			continue;
>>>>>> @@ -1558,7 +1556,7 @@ void register_page_bootmem_memmap(unsigned long section_nr,
>>>>>>  		get_page_bootmem(section_nr, pud_page(*pud), MIX_SECTION_INFO);
>>>>>>  
>>>>>>  		if (!boot_cpu_has(X86_FEATURE_PSE)) {
>>>>>> -			next = (addr + PAGE_SIZE) & PAGE_MASK;
>>>>>> +			next = pte_addr_end(addr, end);
>>>>>>  			pmd = pmd_offset(pud, addr);
>>>>>>  			if (pmd_none(*pmd))
>>>>>>  				continue;
>>>>>> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
>>>>>> index 32b6c52d41b9..0de09c6c89d2 100644
>>>>>> --- a/include/linux/pgtable.h
>>>>>> +++ b/include/linux/pgtable.h
>>>>>> @@ -706,6 +706,13 @@ static inline pgprot_t pgprot_modify(pgprot_t oldprot, pgprot_t newprot)
>>>>>>  })
>>>>>>  #endif
>>>>>>  
>>>>>> +#ifndef pte_addr_end
>>>>>> +#define pte_addr_end(addr, end)						\
>>>>>> +({	unsigned long __boundary = ((addr) + PAGE_SIZE) & PAGE_MASK;	\
>>>>>> +	(__boundary - 1 < (end) - 1) ? __boundary : (end);		\
>>>>>> +})
>>>>>> +#endif
>>>>>> +
>>>>>>  /*
>>>>>>   * When walking page tables, we usually want to skip any p?d_none entries;
>>>>>>   * and any p?d_bad entries - reporting the error before resetting to none.
>>>>>> diff --git a/mm/kasan/init.c b/mm/kasan/init.c
>>>>>> index fe6be0be1f76..89f748601f74 100644
>>>>>> --- a/mm/kasan/init.c
>>>>>> +++ b/mm/kasan/init.c
>>>>>> @@ -349,9 +349,7 @@ static void kasan_remove_pte_table(pte_t *pte, unsigned long addr,
>>>>>>  	unsigned long next;
>>>>>>  
>>>>>>  	for (; addr < end; addr = next, pte++) {
>>>>>> -		next = (addr + PAGE_SIZE) & PAGE_MASK;
>>>>>> -		if (next > end)
>>>>>> -			next = end;
>>>>>> +		next = pte_addr_end(addr, end);
>>>>>>  
>>>>>>  		if (!pte_present(*pte))
>>>>>>  			continue;
>>>>>>
>>>>>
>>>>> I'm not really a friend of this I have to say. We're simply iterating
>>>>> over single pages, not much magic ....
>>>>
>>>> Hmm... yes, we are iterating on Page boundary, while we many have the case
>>>> when addr or end is not PAGE_ALIGN.
>>>
>>> I really do wonder if not having page aligned addresses actually happens
>>> in real life. Page tables operate on page granularity, and
>>> adding/removing unaligned parts feels wrong ... and that's also why I
>>> dislike such a helper.
>>>
>>> 1. kasan_add_zero_shadow()/kasan_remove_zero_shadow(). If I understand
>>> the logic (WARN_ON()) correctly, we bail out in case we would ever end
>>> up in such a scenario, where we would want to add/remove things not
>>> aligned to PAGE_SIZE.
>>>
>>> 2. remove_pagetable()...->remove_pte_table()
>>>
>>> vmemmap_free() should never try to de-populate sub-pages. Even with
>>> sub-section hot-add/remove (2MB / 512 pages), with valid struct page
>>> sizes (56, 64, 72, 80), we always end up with full pages.
>>>
>>> kernel_physical_mapping_remove() is only called via
>>> arch_remove_memory(). That will never remove unaligned parts.
>>>
>> 
>> I don't have a very clear mind now, while when you look into
>> remove_pte_table(), it has two cases based on alignment of addr and next.
>> 
>> If we always remove a page, the second case won't happen?
>
>So, the code talks about that the second case can only happen for
>vmemmap, never for direct mappings.
>
>I don't see a way how this could ever happen with current page sizes,
>even with sub-section hotadd (2MB). Maybe that is a legacy leftover or
>was never relevant? Or I am missing something important, where we could
>have sub-4k-page vmemmap data.
>

I took a calculation on the sub-section page struct size, it is page size (4K)
aligned. This means you are right, which we won't depopulate a sub-page.

And yes, I am not sure all those variants would fit this case. So I would like
to leave as it now. How about your opinion?

>-- 
>Thanks,
>
>David / dhildenb

-- 
Wei Yang
Help you, Help me
