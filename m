Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F4CAC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 02:11:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB2802074D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 02:11:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726145AbgGACLT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 22:11:19 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:50935 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725805AbgGACLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 22:11:19 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01355;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0U1E10Wi_1593569473;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0U1E10Wi_1593569473)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 01 Jul 2020 10:11:13 +0800
Date:   Wed, 1 Jul 2020 10:11:13 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Wei Yang <richard.weiyang@linux.alibaba.com>,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        akpm@linux-foundation.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-mm@kvack.org
Subject: Re: [PATCH] mm: define pte_add_end for consistency
Message-ID: <20200701021113.GA51306@L-31X9LVDL-1304.local>
Reply-To: Wei Yang <richard.weiyang@linux.alibaba.com>
References: <20200630031852.45383-1-richard.weiyang@linux.alibaba.com>
 <40362e99-a354-c44f-8645-e2326a6df680@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40362e99-a354-c44f-8645-e2326a6df680@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 30, 2020 at 02:44:00PM +0200, David Hildenbrand wrote:
>On 30.06.20 05:18, Wei Yang wrote:
>> When walking page tables, we define several helpers to get the address of
>> the next boundary. But we don't have one for pte level.
>> 
>> Let's define it and consolidate the code in several places.
>> 
>> Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>
>> ---
>>  arch/x86/mm/init_64.c   | 6 ++----
>>  include/linux/pgtable.h | 7 +++++++
>>  mm/kasan/init.c         | 4 +---
>>  3 files changed, 10 insertions(+), 7 deletions(-)
>> 
>> diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
>> index dbae185511cd..f902fbd17f27 100644
>> --- a/arch/x86/mm/init_64.c
>> +++ b/arch/x86/mm/init_64.c
>> @@ -973,9 +973,7 @@ remove_pte_table(pte_t *pte_start, unsigned long addr, unsigned long end,
>>  
>>  	pte = pte_start + pte_index(addr);
>>  	for (; addr < end; addr = next, pte++) {
>> -		next = (addr + PAGE_SIZE) & PAGE_MASK;
>> -		if (next > end)
>> -			next = end;
>> +		next = pte_addr_end(addr, end);
>>  
>>  		if (!pte_present(*pte))
>>  			continue;
>> @@ -1558,7 +1556,7 @@ void register_page_bootmem_memmap(unsigned long section_nr,
>>  		get_page_bootmem(section_nr, pud_page(*pud), MIX_SECTION_INFO);
>>  
>>  		if (!boot_cpu_has(X86_FEATURE_PSE)) {
>> -			next = (addr + PAGE_SIZE) & PAGE_MASK;
>> +			next = pte_addr_end(addr, end);
>>  			pmd = pmd_offset(pud, addr);
>>  			if (pmd_none(*pmd))
>>  				continue;
>> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
>> index 32b6c52d41b9..0de09c6c89d2 100644
>> --- a/include/linux/pgtable.h
>> +++ b/include/linux/pgtable.h
>> @@ -706,6 +706,13 @@ static inline pgprot_t pgprot_modify(pgprot_t oldprot, pgprot_t newprot)
>>  })
>>  #endif
>>  
>> +#ifndef pte_addr_end
>> +#define pte_addr_end(addr, end)						\
>> +({	unsigned long __boundary = ((addr) + PAGE_SIZE) & PAGE_MASK;	\
>> +	(__boundary - 1 < (end) - 1) ? __boundary : (end);		\
>> +})
>> +#endif
>> +
>>  /*
>>   * When walking page tables, we usually want to skip any p?d_none entries;
>>   * and any p?d_bad entries - reporting the error before resetting to none.
>> diff --git a/mm/kasan/init.c b/mm/kasan/init.c
>> index fe6be0be1f76..89f748601f74 100644
>> --- a/mm/kasan/init.c
>> +++ b/mm/kasan/init.c
>> @@ -349,9 +349,7 @@ static void kasan_remove_pte_table(pte_t *pte, unsigned long addr,
>>  	unsigned long next;
>>  
>>  	for (; addr < end; addr = next, pte++) {
>> -		next = (addr + PAGE_SIZE) & PAGE_MASK;
>> -		if (next > end)
>> -			next = end;
>> +		next = pte_addr_end(addr, end);
>>  
>>  		if (!pte_present(*pte))
>>  			continue;
>> 
>
>I'm not really a friend of this I have to say. We're simply iterating
>over single pages, not much magic ....

Hmm... yes, we are iterating on Page boundary, while we many have the case
when addr or end is not PAGE_ALIGN.

>
>What would definitely make sense is replacing (addr + PAGE_SIZE) &
>PAGE_MASK; by PAGE_ALIGN() ...
>

No, PAGE_ALIGN() is expanded to be 

	(addr + PAGE_SIZE - 1) & PAGE_MASK;

If we change the code to PAGE_ALIGN(), we would end up with infinite loop.

>-- 
>Thanks,
>
>David / dhildenb

-- 
Wei Yang
Help you, Help me
