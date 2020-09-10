Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66A1CC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 11:21:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 234D020C09
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 11:21:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728971AbgIJLVr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 07:21:47 -0400
Received: from foss.arm.com ([217.140.110.172]:33600 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730431AbgIJLRM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 07:17:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1CB7613D5;
        Thu, 10 Sep 2020 04:17:09 -0700 (PDT)
Received: from [10.163.71.250] (unknown [10.163.71.250])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EFE763F68F;
        Thu, 10 Sep 2020 04:17:05 -0700 (PDT)
Subject: Re: [PATCH] arm64/mm: add fallback option to allocate virtually
 contiguous memory
To:     sudaraja@codeaurora.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     'Mark Rutland' <mark.rutland@arm.com>,
        'Will Deacon' <will@kernel.org>,
        'David Hildenbrand' <david@redhat.com>,
        'Catalin Marinas' <catalin.marinas@arm.com>,
        'Steven Price' <steven.price@arm.com>,
        'Andrew Morton' <akpm@linux-foundation.org>,
        'Logan Gunthorpe' <logang@deltatee.com>, pratikp@codeaurora.org
References: <01010174769e2b68-a6f3768e-aef8-43c7-b357-a8cb1e17d3eb-000000@us-west-2.amazonses.com>
 <0475e813-cb95-0992-39e4-593bfd5cdbf8@arm.com>
 <0101017477202341-51a1c9d3-5ba4-4328-b24c-0b29317af168-000000@us-west-2.amazonses.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <a9380c22-c097-eb7e-0668-032a24f8f044@arm.com>
Date:   Thu, 10 Sep 2020 16:46:33 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <0101017477202341-51a1c9d3-5ba4-4328-b24c-0b29317af168-000000@us-west-2.amazonses.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/10/2020 01:57 PM, sudaraja@codeaurora.org wrote:
> Hello Anshuman,
> 
>> On 09/10/2020 11:35 AM, Sudarshan Rajagopalan wrote:
>>> When section mappings are enabled, we allocate vmemmap pages from 
>>> physically continuous memory of size PMD_SZIE using 
>>> vmemmap_alloc_block_buf(). Section> mappings are good to reduce TLB 
>>> pressure. But when system is highly fragmented and memory blocks are 
>>> being hot-added at runtime, its possible that such physically 
>>> continuous memory allocations can fail. Rather than failing the
>>
>> Did you really see this happen on a system ?
> 
> Thanks for the response.

There seems to be some text alignment problem in your response on this
thread, please have a look.

> 
> Yes, this happened on a system with very low RAM (size ~120MB) where no free order-9 pages were present. Pasting below few kernel logs. On systems with low RAM, its high probability where memory is fragmented and no higher order pages are free. On such scenarios, vmemmap alloc would fail for PMD_SIZE of contiguous memory.
> 
> We have a usecase for memory sharing between VMs where one of the VM uses add_memory() to add the memory that was donated by the other VM. This uses something similar to VirtIO-Mem. And this requires memory to be _guaranteed_ to be added in the VM so that the usecase can run without any failure.
> 
> vmemmap alloc failure: order:9, mode:0x4cc0(GFP_KERNEL|__GFP_RETRY_MAYFAIL), nodemask=(null),cpuset=/,mems_allowed=0
> CPU: 1 PID: 294 Comm: -------- Tainted: G S                5.4.50 #1
> Call trace:
>  dump_stack+0xa4/0xdc
>  warn_alloc+0x104/0x160
>  vmemmap_alloc_block+0xe4/0xf4
>  vmemmap_alloc_block_buf+0x34/0x38
>  vmemmap_populate+0xc8/0x224
>  __populate_section_memmap+0x34/0x54
>  sparse_add_section+0x16c/0x254
>  __add_pages+0xd0/0x138
>  arch_add_memory+0x114/0x1a8
> 
> DMA32: 2627*4kB (UMC) 23*8kB (UME) 6*16kB (UM) 8*32kB (UME) 2*64kB (ME) 2*128kB (UE) 1*256kB (M) 2*512kB (ME) 1*1024kB (M) 0*2048kB 0*4096kB = 13732kB
> 30455 pages RAM
> 
> But keeping this usecase aside, won’t this be problematic on any systems with low RAM where order-9 alloc would fail on a fragmented system, and any memory hot-adding would fail? Or other similar users of VirtIO-Mem which uses arch_add_memory.
> 
>>
>>> memory hot-add procedure, add a fallback option to allocate vmemmap 
>>> pages from discontinuous pages using vmemmap_populate_basepages().
>>
>> Which could lead to a mixed page size mapping in the VMEMMAP area.
> 
> Would this be problematic? We would only lose one section mapping per failure and increases slight TLB pressure. Also, we would anyway do discontinuous pages alloc for systems having non-4K pages (ARM64_SWAPPER_USES_SECTION_MAPS will be 0). I only see a small cost to performance due to slight TLB pressure.
> 
>> Allocation failure in vmemmap_populate() should just cleanly fail the memory hot add operation, which can then be retried. Why the retry has to be offloaded to kernel ?
> 
> While a retry can attempted again, but it won’t help in cases where there are no order-9 pages available and any retry would just not succeed again until a order-9 page gets free'ed. Here we are just falling back to use discontinuous pages allocation to help succeed memory hot-add as best as possible.

Understood, seems like there is enough potential use cases and scenarios
right now, to consider this fallback mechanism and a possible mixed page
size vmemmap. But I would let others weigh in, on the performance impact.

> 
> Thanks and Regards,
> Sudarshan
> 
> --
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
> 
> -----Original Message-----
> From: Anshuman Khandual <anshuman.khandual@arm.com> 
> Sent: Wednesday, September 9, 2020 11:45 PM
> To: Sudarshan Rajagopalan <sudaraja@codeaurora.org>; linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org
> Cc: Catalin Marinas <catalin.marinas@arm.com>; Will Deacon <will@kernel.org>; Mark Rutland <mark.rutland@arm.com>; Logan Gunthorpe <logang@deltatee.com>; David Hildenbrand <david@redhat.com>; Andrew Morton <akpm@linux-foundation.org>; Steven Price <steven.price@arm.com>
> Subject: Re: [PATCH] arm64/mm: add fallback option to allocate virtually contiguous memory
> 
> Hello Sudarshan,
> 
> On 09/10/2020 11:35 AM, Sudarshan Rajagopalan wrote:
>> When section mappings are enabled, we allocate vmemmap pages from 
>> physically continuous memory of size PMD_SZIE using 
>> vmemmap_alloc_block_buf(). Section> mappings are good to reduce TLB 
>> pressure. But when system is highly fragmented and memory blocks are 
>> being hot-added at runtime, its possible that such physically 
>> continuous memory allocations can fail. Rather than failing the
> 
> Did you really see this happen on a system ?
> 
>> memory hot-add procedure, add a fallback option to allocate vmemmap 
>> pages from discontinuous pages using vmemmap_populate_basepages().
> 
> Which could lead to a mixed page size mapping in the VMEMMAP area.
> Allocation failure in vmemmap_populate() should just cleanly fail the memory hot add operation, which can then be retried. Why the retry has to be offloaded to kernel ?
> 
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
>>  arch/arm64/mm/mmu.c | 15 ++++++++++++---
>>  1 file changed, 12 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c index 
>> 75df62f..a46c7d4 100644
>> --- a/arch/arm64/mm/mmu.c
>> +++ b/arch/arm64/mm/mmu.c
>> @@ -1100,6 +1100,7 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
>>  	p4d_t *p4dp;
>>  	pud_t *pudp;
>>  	pmd_t *pmdp;
>> +	int ret = 0;
>>  
>>  	do {
>>  		next = pmd_addr_end(addr, end);
>> @@ -1121,15 +1122,23 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
>>  			void *p = NULL;
>>  
>>  			p = vmemmap_alloc_block_buf(PMD_SIZE, node, altmap);
>> -			if (!p)
>> -				return -ENOMEM;
>> +			if (!p) {
>> +#ifdef CONFIG_MEMORY_HOTPLUG
>> +				vmemmap_free(start, end, altmap); #endif
> 
> The mapping was never created in the first place, as the allocation failed. vmemmap_free() here will free an unmapped area !
> 
>> +				ret = -ENOMEM;
>> +				break;
>> +			}
>>  
>>  			pmd_set_huge(pmdp, __pa(p), __pgprot(PROT_SECT_NORMAL));
>>  		} else
>>  			vmemmap_verify((pte_t *)pmdp, node, addr, next);
>>  	} while (addr = next, addr != end);
>>  
>> -	return 0;
>> +	if (ret)
>> +		return vmemmap_populate_basepages(start, end, node, altmap);
>> +	else
>> +		return ret;
>>  }
>>  #endif	/* !ARM64_SWAPPER_USES_SECTION_MAPS */
>>  void vmemmap_free(unsigned long start, unsigned long end,
>>
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
