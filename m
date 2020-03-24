Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 175EFC4332B
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 12:03:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D54E120714
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 12:03:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbgCXMDg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 08:03:36 -0400
Received: from foss.arm.com ([217.140.110.172]:33214 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727066AbgCXMDg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 08:03:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9E6CE1FB;
        Tue, 24 Mar 2020 05:03:35 -0700 (PDT)
Received: from [10.163.1.71] (unknown [10.163.1.71])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 27AAE3F792;
        Tue, 24 Mar 2020 05:03:30 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH V2 2/2] arm64/mm: Enable vmem_altmap support for vmemmap
 mappings
To:     Robin Murphy <robin.murphy@arm.com>, linux-mm@kvack.org
Cc:     Mark Rutland <mark.rutland@arm.com>, Yu Zhao <yuzhao@google.com>,
        David Hildenbrand <david@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steve Capper <steve.capper@arm.com>,
        linux-kernel@vger.kernel.org, Hsin-Yi Wang <hsinyi@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org
References: <1583331030-7335-1-git-send-email-anshuman.khandual@arm.com>
 <1583331030-7335-3-git-send-email-anshuman.khandual@arm.com>
 <d428e636-0f48-6738-2296-91dba8fc6404@arm.com>
Message-ID: <57af8e0a-5e47-cf3f-19dc-ce047793cd1f@arm.com>
Date:   Tue, 24 Mar 2020 17:33:26 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <d428e636-0f48-6738-2296-91dba8fc6404@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 03/21/2020 01:05 AM, Robin Murphy wrote:
> On 2020-03-04 2:10 pm, Anshuman Khandual wrote:
>> Device memory ranges when getting hot added into ZONE_DEVICE, might require
>> their vmemmap mapping's backing memory to be allocated from their own range
>> instead of consuming system memory. This prevents large system memory usage
>> for potentially large device memory ranges. Device driver communicates this
>> request via vmem_altmap structure. Architecture needs to take this request
>> into account while creating and tearing down vemmmap mappings.
>>
>> This enables vmem_altmap support in vmemmap_populate() and vmemmap_free()
>> which includes vmemmap_populate_basepages() used for ARM64_16K_PAGES and
>> ARM64_64K_PAGES configs.
>>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Steve Capper <steve.capper@arm.com>
>> Cc: David Hildenbrand <david@redhat.com>
>> Cc: Yu Zhao <yuzhao@google.com>
>> Cc: Hsin-Yi Wang <hsinyi@chromium.org>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-kernel@vger.kernel.org
>>
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>>   arch/arm64/mm/mmu.c | 71 ++++++++++++++++++++++++++++++++-------------
>>   1 file changed, 51 insertions(+), 20 deletions(-)
>>
>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>> index 27cb95c471eb..0e0a0ecc812e 100644
>> --- a/arch/arm64/mm/mmu.c
>> +++ b/arch/arm64/mm/mmu.c
>> @@ -727,15 +727,30 @@ int kern_addr_valid(unsigned long addr)
>>   }
>>     #ifdef CONFIG_MEMORY_HOTPLUG
>> -static void free_hotplug_page_range(struct page *page, size_t size)
>> +static void free_hotplug_page_range(struct page *page, size_t size,
>> +                    struct vmem_altmap *altmap)
>>   {
>> -    WARN_ON(PageReserved(page));
>> -    free_pages((unsigned long)page_address(page), get_order(size));
>> +    if (altmap) {
>> +        /*
>> +         * Though unmap_hotplug_range() will tear down altmap based
>> +         * vmemmap mappings at all page table levels, these mappings
>> +         * should only have been created either at PTE or PMD level
>> +         * with vmemmap_populate_basepages() or vmemmap_populate()
>> +         * respectively. Unmapping requests at any other level will
>> +         * be problematic. Drop these warnings when vmemmap mapping
>> +         * is supported at PUD (even perhaps P4D) level.
>> +         */
>> +        WARN_ON((size != PAGE_SIZE) && (size != PMD_SIZE));
> 
> Isn't that comment equally true of the regular case? AFAICS we don't call vmemmap_alloc_block_buf() with larger than PMD_SIZE either. If the warnings are useful, shouldn't they cover both cases equally? However, given that we never warned before, and the code here appears that it would work fine anyway, *are* they really useful?

Sure, this is not something exclusively applicable for altmap based
vmemmap mappings alone. Will drop it from here.

> 
>> +        vmem_altmap_free(altmap, size >> PAGE_SHIFT);
>> +    } else {
>> +        WARN_ON(PageReserved(page));
>> +        free_pages((unsigned long)page_address(page), get_order(size));
>> +    }
>>   }
>>     static void free_hotplug_pgtable_page(struct page *page)
>>   {
>> -    free_hotplug_page_range(page, PAGE_SIZE);
>> +    free_hotplug_page_range(page, PAGE_SIZE, NULL);
>>   }
>>     static bool pgtable_range_aligned(unsigned long start, unsigned long end,
>> @@ -758,7 +773,8 @@ static bool pgtable_range_aligned(unsigned long start, unsigned long end,
>>   }
>>     static void unmap_hotplug_pte_range(pmd_t *pmdp, unsigned long addr,
>> -                    unsigned long end, bool free_mapped)
>> +                    unsigned long end, bool free_mapped,
>> +                    struct vmem_altmap *altmap)
>>   {
>>       pte_t *ptep, pte;
>>   @@ -772,12 +788,14 @@ static void unmap_hotplug_pte_range(pmd_t *pmdp, unsigned long addr,
>>           pte_clear(&init_mm, addr, ptep);
>>           flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
>>           if (free_mapped)
>> -            free_hotplug_page_range(pte_page(pte), PAGE_SIZE);
>> +            free_hotplug_page_range(pte_page(pte),
>> +                        PAGE_SIZE, altmap);
>>       } while (addr += PAGE_SIZE, addr < end);
>>   }
>>     static void unmap_hotplug_pmd_range(pud_t *pudp, unsigned long addr,
>> -                    unsigned long end, bool free_mapped)
>> +                    unsigned long end, bool free_mapped,
>> +                    struct vmem_altmap *altmap)
>>   {
>>       unsigned long next;
>>       pmd_t *pmdp, pmd;
>> @@ -800,16 +818,17 @@ static void unmap_hotplug_pmd_range(pud_t *pudp, unsigned long addr,
>>               flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
>>               if (free_mapped)
>>                   free_hotplug_page_range(pmd_page(pmd),
>> -                            PMD_SIZE);
>> +                            PMD_SIZE, altmap);
>>               continue;
>>           }
>>           WARN_ON(!pmd_table(pmd));
>> -        unmap_hotplug_pte_range(pmdp, addr, next, free_mapped);
>> +        unmap_hotplug_pte_range(pmdp, addr, next, free_mapped, altmap);
>>       } while (addr = next, addr < end);
>>   }
>>     static void unmap_hotplug_pud_range(p4d_t *p4dp, unsigned long addr,
>> -                    unsigned long end, bool free_mapped)
>> +                    unsigned long end, bool free_mapped,
>> +                    struct vmem_altmap *altmap)
>>   {
>>       unsigned long next;
>>       pud_t *pudp, pud;
>> @@ -832,16 +851,17 @@ static void unmap_hotplug_pud_range(p4d_t *p4dp, unsigned long addr,
>>               flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
>>               if (free_mapped)
>>                   free_hotplug_page_range(pud_page(pud),
>> -                            PUD_SIZE);
>> +                            PUD_SIZE, altmap);
>>               continue;
>>           }
>>           WARN_ON(!pud_table(pud));
>> -        unmap_hotplug_pmd_range(pudp, addr, next, free_mapped);
>> +        unmap_hotplug_pmd_range(pudp, addr, next, free_mapped, altmap);
>>       } while (addr = next, addr < end);
>>   }
>>     static void unmap_hotplug_p4d_range(pgd_t *pgdp, unsigned long addr,
>> -                    unsigned long end, bool free_mapped)
>> +                    unsigned long end, bool free_mapped,
>> +                    struct vmem_altmap *altmap)
>>   {
>>       unsigned long next;
>>       p4d_t *p4dp, p4d;
>> @@ -854,16 +874,24 @@ static void unmap_hotplug_p4d_range(pgd_t *pgdp, unsigned long addr,
>>               continue;
>>             WARN_ON(!p4d_present(p4d));
>> -        unmap_hotplug_pud_range(p4dp, addr, next, free_mapped);
>> +        unmap_hotplug_pud_range(p4dp, addr, next, free_mapped, altmap);
>>       } while (addr = next, addr < end);
>>   }
>>     static void unmap_hotplug_range(unsigned long addr, unsigned long end,
>> -                bool free_mapped)
>> +                bool free_mapped, struct vmem_altmap *altmap)
>>   {
>>       unsigned long next;
>>       pgd_t *pgdp, pgd;
>>   +    /*
>> +     * vmem_altmap can only be used as backing memory in a given
>> +     * page table mapping. In case backing memory itself is not
>> +     * being freed, then altmap is irrelevant. Warn about this
>> +     * inconsistency when encountered.
>> +     */
>> +    WARN_ON(!free_mapped && altmap);
> 
> Personally I find that comment a bit unclear (particularly the first sentence which just seems like a confusing tautology). Is the overall point that the altmap only matters when we're unmapping and freeing vmemmap pages (such that we free them to the right allocator)? At face value it doesn't seem to warrant a warning - it's not necessary to know which allocator owns pages that we aren't freeing, but it isn't harmful either.

Probably will change the comment to something like this instead.

        /*
         * altmap can only be used as vmemmap mapping backing memory.
         * In case the backing memory itself is not being freed, then
         * altmap is just irrelevant. Warn about this inconsistency
	 * when encountered.
         */

altmap does decide which allocator, the backing pages will get freed
into. The primary purpose here is to just warn about this invalid
combination i.e (!free_mapped && altmap) which the function should
never be called with.

> 
> That said, however, after puzzling through the code I get the distinct feeling it would be more useful if all those "free_mapped" arguments were actually named "is_vmemmap" instead. A that point, the conceptual inconsistency would be a little more obvious (and arguably might not even need commenting).

'free_mapped' was a conscious decision [1] that got added during hot
remove series V9. It avoided the name to be just vmemmap specific as
the unmapping and freeing functions are very generic in nature.

[1] https://lkml.org/lkml/2019/10/8/310

> 
> All the altmap plumbing itself looks pretty mechanical and hard to disagree with :)

Okay.

> 
> Robin.
