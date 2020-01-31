Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B9EEC35240
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 13:14:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AD99205F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 13:14:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728698AbgAaNOL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 08:14:11 -0500
Received: from icp-osb-irony-out7.external.iinet.net.au ([203.59.1.107]:22912
        "EHLO icp-osb-irony-out7.external.iinet.net.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728575AbgAaNOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 08:14:11 -0500
X-Greylist: delayed 586 seconds by postgrey-1.27 at vger.kernel.org; Fri, 31 Jan 2020 08:14:09 EST
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2AlAAB/JDRe/zXSMGcNWBoBAQEBAQE?=
 =?us-ascii?q?BAQEDAQEBAREBAQECAgEBAQGBe4MVgTGEFI9YAQEBAQEBBoESJYlvkUkJAQE?=
 =?us-ascii?q?BAQEBAQEBKwwBAYRAAoJTOBMCEAEBAQQBAQEBAQUDAYVYTIVyAQEBAQIBIwQ?=
 =?us-ascii?q?RQQULCw0LAgImAgJXBg0GAgEBgyIBglYFL6wYdX8zGoQbAYEUgy2BOAaBDiq?=
 =?us-ascii?q?BZYpVeYEHgREnDIJgPodZgl4ElzeYKQiCPYdFhUeELYUAIYJ4jBIDi3iXR44?=
 =?us-ascii?q?6hgiBejMaCCgIgycTPXuNUxeIZIVRYgIBjkYBAQ?=
X-IPAS-Result: =?us-ascii?q?A2AlAAB/JDRe/zXSMGcNWBoBAQEBAQEBAQEDAQEBAREBA?=
 =?us-ascii?q?QECAgEBAQGBe4MVgTGEFI9YAQEBAQEBBoESJYlvkUkJAQEBAQEBAQEBKwwBA?=
 =?us-ascii?q?YRAAoJTOBMCEAEBAQQBAQEBAQUDAYVYTIVyAQEBAQIBIwQRQQULCw0LAgImA?=
 =?us-ascii?q?gJXBg0GAgEBgyIBglYFL6wYdX8zGoQbAYEUgy2BOAaBDiqBZYpVeYEHgREnD?=
 =?us-ascii?q?IJgPodZgl4ElzeYKQiCPYdFhUeELYUAIYJ4jBIDi3iXR446hgiBejMaCCgIg?=
 =?us-ascii?q?ycTPXuNUxeIZIVRYgIBjkYBAQ?=
X-IronPort-AV: E=Sophos;i="5.70,385,1574092800"; 
   d="scan'208";a="236594061"
Received: from unknown (HELO [10.44.0.192]) ([103.48.210.53])
  by icp-osb-irony-out7.iinet.net.au with ESMTP; 31 Jan 2020 21:04:04 +0800
Subject: Re: [PATCH 0/5] Rewrite Motorola MMU page-table layout
To:     Will Deacon <will@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
References: <20200129103941.304769381@infradead.org>
 <8a81e075-d3bd-80c1-d869-9935fdd73162@linux-m68k.org>
 <20200131093813.GA3938@willie-the-truck>
From:   Greg Ungerer <gerg@linux-m68k.org>
Message-ID: <6b345fe8-448f-83b4-5527-db0dfe6036f7@linux-m68k.org>
Date:   Fri, 31 Jan 2020 23:04:02 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200131093813.GA3938@willie-the-truck>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

On 31/1/20 7:38 pm, Will Deacon wrote:
> On Fri, Jan 31, 2020 at 04:31:48PM +1000, Greg Ungerer wrote:
>> On 29/1/20 8:39 pm, Peter Zijlstra wrote:
>>> In order to faciliate Will's READ_ONCE() patches:
>>>
>>>     https://lkml.kernel.org/r/20200123153341.19947-1-will@kernel.org
>>>
>>> we need to fix m68k/motorola to not have a giant pmd_t. These patches do so and
>>> are tested using ARAnyM/68040.
>>>
>>> It would be very good if someone can either test or tell us what emulator to
>>> use for 020/030.
>>
>> This series breaks compilation for the ColdFire (with MMU) variant of
>> the m68k family:
> 
> [...]
> 
>> Easy to reproduce. Build for the m5475evb_defconfig.
> 
> I've hacked up a fix below, but I don't know how to test whether it actually
> works (it does fix the build).

Yep, I can confirm that too.
There is no emulators for the MMU based ColdFires (qemu only supports
a non-MMU variant).

I can test on real hardware - but not until Monday when I am back
in my lab. I'll report back then.


> However, I also notice that building for
> m5475evb_defconfig with vanilla v5.5 triggers this scary looking warning
> due to a mismatch between the pgd size and the (8k!) page size:
> 
> 
>    | In function 'pgd_alloc.isra.111',
>    |     inlined from 'mm_alloc_pgd' at kernel/fork.c:634:12,
>    |     inlined from 'mm_init.isra.112' at kernel/fork.c:1043:6:
>    | ./arch/m68k/include/asm/string.h:72:25: warning: '__builtin_memcpy' forming offset [4097, 8192] is out of the bounds [0, 4096] of object 'kernel_pg_dir' with type 'pgd_t[1024]' {aka 'struct <anonymous>[1024]'} [-Warray-bounds]
>    |  #define memcpy(d, s, n) __builtin_memcpy(d, s, n)
>    |                          ^~~~~~~~~~~~~~~~~~~~~~~~~
>    | ./arch/m68k/include/asm/mcf_pgalloc.h:93:2: note: in expansion of macro 'memcpy'
>    |   memcpy(new_pgd, swapper_pg_dir, PAGE_SIZE);
>    |   ^~~~~~
> 
> 
> I think the correct fix is to add this:
> 
> 
> diff --git a/arch/m68k/include/asm/mcf_pgalloc.h b/arch/m68k/include/asm/mcf_pgalloc.h
> index 82ec54c2eaa4..c335e6a381a1 100644
> --- a/arch/m68k/include/asm/mcf_pgalloc.h
> +++ b/arch/m68k/include/asm/mcf_pgalloc.h
> @@ -90,7 +90,7 @@ static inline pgd_t *pgd_alloc(struct mm_struct *mm)
>   	new_pgd = (pgd_t *)__get_free_page(GFP_DMA | __GFP_NOWARN);
>   	if (!new_pgd)
>   		return NULL;
> -	memcpy(new_pgd, swapper_pg_dir, PAGE_SIZE);
> +	memcpy(new_pgd, swapper_pg_dir, PTRS_PER_PGD * sizeof(pgd_t));
>   	memset(new_pgd, 0, PAGE_OFFSET >> PGDIR_SHIFT);
>   	return new_pgd;
>   }
> 
> 
> but maybe it should be done as a separate patch give that it's not caused
> by the rework we've been doing.

Indeed I hadn't noticed that before. But good idea, a separate patch
would make sense.

Regards
Greg


> Will
> 
> --->8
> 
> diff --git a/arch/m68k/include/asm/mcf_pgalloc.h b/arch/m68k/include/asm/mcf_pgalloc.h
> index 82ec54c2eaa4..955d54a6e973 100644
> --- a/arch/m68k/include/asm/mcf_pgalloc.h
> +++ b/arch/m68k/include/asm/mcf_pgalloc.h
> @@ -28,21 +28,22 @@ extern inline pmd_t *pmd_alloc_kernel(pgd_t *pgd, unsigned long address)
>   	return (pmd_t *) pgd;
>   }
>   
> -#define pmd_populate(mm, pmd, page) (pmd_val(*pmd) = \
> -	(unsigned long)(page_address(page)))
> +#define pmd_populate(mm, pmd, pte) (pmd_val(*pmd) = (unsigned long)(pte))
>   
> -#define pmd_populate_kernel(mm, pmd, pte) (pmd_val(*pmd) = (unsigned long)(pte))
> +#define pmd_populate_kernel pmd_populate
>   
> -#define pmd_pgtable(pmd) pmd_page(pmd)
> +#define pmd_pgtable(pmd) pfn_to_virt(pmd_val(pmd) >> PAGE_SHIFT)
>   
> -static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t page,
> +static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t pgtable,
>   				  unsigned long address)
>   {
> +	struct page *page = virt_to_page(pgtable);
> +
>   	pgtable_pte_page_dtor(page);
>   	__free_page(page);
>   }
>   
> -static inline struct page *pte_alloc_one(struct mm_struct *mm)
> +static inline pgtable_t pte_alloc_one(struct mm_struct *mm)
>   {
>   	struct page *page = alloc_pages(GFP_DMA, 0);
>   	pte_t *pte;
> @@ -54,20 +55,19 @@ static inline struct page *pte_alloc_one(struct mm_struct *mm)
>   		return NULL;
>   	}
>   
> -	pte = kmap(page);
> -	if (pte) {
> -		clear_page(pte);
> -		__flush_page_to_ram(pte);
> -		flush_tlb_kernel_page(pte);
> -		nocache_page(pte);
> -	}
> -	kunmap(page);
> +	pte = page_address(page);
> +	clear_page(pte);
> +	__flush_page_to_ram(pte);
> +	flush_tlb_kernel_page(pte);
> +	nocache_page(pte);
>   
> -	return page;
> +	return pte;
>   }
>   
> -static inline void pte_free(struct mm_struct *mm, struct page *page)
> +static inline void pte_free(struct mm_struct *mm, pgtable_t pgtable)
>   {
> +	struct page *page = virt_to_page(pgtable);
> +
>   	pgtable_pte_page_dtor(page);
>   	__free_page(page);
>   }
> 
