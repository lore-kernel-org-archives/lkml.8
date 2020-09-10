Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 553AFC07548
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 10:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1191620C09
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 10:54:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730165AbgIJKyY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 06:54:24 -0400
Received: from foss.arm.com ([217.140.110.172]:32832 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730328AbgIJKvY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 06:51:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8D34D1063;
        Thu, 10 Sep 2020 03:51:18 -0700 (PDT)
Received: from [10.163.71.250] (unknown [10.163.71.250])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B0CE13F68F;
        Thu, 10 Sep 2020 03:51:15 -0700 (PDT)
Subject: Re: [PATCH] arm64/mm: add fallback option to allocate virtually
 contiguous memory
To:     Steven Price <steven.price@arm.com>,
        Sudarshan Rajagopalan <sudaraja@codeaurora.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <01010174769e2b68-a6f3768e-aef8-43c7-b357-a8cb1e17d3eb-000000@us-west-2.amazonses.com>
 <b8c6e11f-00f3-a89c-6ebc-eef55f92298b@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <145c57a3-1753-3ff8-4353-3bf7bac0b7de@arm.com>
Date:   Thu, 10 Sep 2020 16:20:42 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <b8c6e11f-00f3-a89c-6ebc-eef55f92298b@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/10/2020 01:57 PM, Steven Price wrote:
> On 10/09/2020 07:05, Sudarshan Rajagopalan wrote:
>> When section mappings are enabled, we allocate vmemmap pages from physically
>> continuous memory of size PMD_SZIE using vmemmap_alloc_block_buf(). Section
>> mappings are good to reduce TLB pressure. But when system is highly fragmented
>> and memory blocks are being hot-added at runtime, its possible that such
>> physically continuous memory allocations can fail. Rather than failing the
>> memory hot-add procedure, add a fallback option to allocate vmemmap pages from
>> discontinuous pages using vmemmap_populate_basepages().
>>
>> Signed-off-by: Sudarshan Rajagopalan <sudaraja@codeaurora.org>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Logan Gunthorpe <logang@deltatee.com>
>> Cc: David Hildenbrand <david@redhat.com>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Steven Price <steven.price@arm.com>
>> ---
>>   arch/arm64/mm/mmu.c | 15 ++++++++++++---
>>   1 file changed, 12 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>> index 75df62f..a46c7d4 100644
>> --- a/arch/arm64/mm/mmu.c
>> +++ b/arch/arm64/mm/mmu.c
>> @@ -1100,6 +1100,7 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
>>       p4d_t *p4dp;
>>       pud_t *pudp;
>>       pmd_t *pmdp;
>> +    int ret = 0;
>>         do {
>>           next = pmd_addr_end(addr, end);
>> @@ -1121,15 +1122,23 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
>>               void *p = NULL;
>>                 p = vmemmap_alloc_block_buf(PMD_SIZE, node, altmap);
>> -            if (!p)
>> -                return -ENOMEM;
>> +            if (!p) {
>> +#ifdef CONFIG_MEMORY_HOTPLUG
>> +                vmemmap_free(start, end, altmap);
>> +#endif
>> +                ret = -ENOMEM;
>> +                break;
>> +            }
>>                 pmd_set_huge(pmdp, __pa(p), __pgprot(PROT_SECT_NORMAL));
>>           } else
>>               vmemmap_verify((pte_t *)pmdp, node, addr, next);
>>       } while (addr = next, addr != end);
>>   -    return 0;
>> +    if (ret)
>> +        return vmemmap_populate_basepages(start, end, node, altmap);
>> +    else
>> +        return ret;
> 
> Style comment: I find this usage of 'ret' confusing. When we assign -ENOMEM above that is never actually the return value of the function (in that case vmemmap_populate_basepages() provides the actual return value).

Right.

> 
> Also the "return ret" is misleading since we know by that point that ret==0 (and the 'else' is redundant).

Right.

> 
> Can you not just move the call to vmemmap_populate_basepages() up to just after the (possible) vmemmap_free() call and remove the 'ret' variable?
> 
> AFAICT the call to vmemmap_free() also doesn't need the #ifdef as the function is a no-op if CONFIG_MEMORY_HOTPLUG isn't set. I also feel you 

Right, CONFIG_MEMORY_HOTPLUG is not required.

need at least a comment to explain Anshuman's point that it looks like you're freeing an unmapped area. Although if I'm reading the code correctly it seems like the unmapped area will just be skipped.
Proposed vmemmap_free() attempts to free the entire requested vmemmap range
[start, end] when an intermediate PMD entry can not be allocated. Hence even
if vmemap_free() could skip an unmapped area (will double check on that), it
unnecessarily goes through large sections of unmapped range, which could not
have been mapped.

So, basically there could be two different methods for doing this fallback.

1. Call vmemmap_populate_basepages() for sections when PMD_SIZE allocation fails

	- vmemmap_free() need not be called

2. Abort at the first instance of PMD_SIZE allocation failure

	- Call vmemmap_free() to unmap all sections mapped till that point
	- Call vmemmap_populate_basepages() to map the entire request section

The proposed patch tried to mix both approaches. Regardless, the first approach
here seems better and is the case in vmemmap_populate_hugepages() implementation
on x86 as well.
