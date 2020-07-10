Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05B42C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 08:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7E36207BC
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 08:59:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbgGJI7I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 04:59:08 -0400
Received: from foss.arm.com ([217.140.110.172]:32802 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726644AbgGJI7I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 04:59:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7CEEA31B;
        Fri, 10 Jul 2020 01:59:07 -0700 (PDT)
Received: from [10.163.87.77] (unknown [10.163.87.77])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 696513F68F;
        Fri, 10 Jul 2020 01:59:01 -0700 (PDT)
Subject: Re: [PATCH v2] mm/hugetlb: split hugetlb_cma in nodes with memory
To:     Barry Song <song.bao.hua@hisilicon.com>, akpm@linux-foundation.org
Cc:     x86@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, linux-arm-kernel@lists.infradead.org,
        Roman Gushchin <guro@fb.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>
References: <20200710035014.25244-1-song.bao.hua@hisilicon.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <ce0ed9ea-663f-dfd6-565d-db0f81b964da@arm.com>
Date:   Fri, 10 Jul 2020 14:28:36 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200710035014.25244-1-song.bao.hua@hisilicon.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/10/2020 09:20 AM, Barry Song wrote:
> Rather than splitting huge_cma in online nodes, it is better to do it in
> nodes with memory.
> Without this patch, for an ARM64 server with four numa nodes and only
> node0 has memory. If I set hugetlb_cma=4G in bootargs,
> 
> without this patch, I got the below printk:
> hugetlb_cma: reserve 4096 MiB, up to 1024 MiB per node
> hugetlb_cma: reserved 1024 MiB on node 0
> hugetlb_cma: reservation failed: err -12, node 1
> hugetlb_cma: reservation failed: err -12, node 2
> hugetlb_cma: reservation failed: err -12, node 3

Seems like you have not changed the commit message from the last time.
This does not explain the problem as we had discussed before. This just
states the effects of the problem not the cause which is really required
when there is a proposal for change in behavior.

> 
> With this patch, I got the below printk:
> 
> hugetlb_cma: reserve 4096 MiB, up to 4096 MiB per node
> hugetlb_cma: reserved 4096 MiB on node 0

Before and after the patch behavior should be described after the problem
and it's solution have been articulated.

> 
> So this patch makes the hugetlb_cma size consistent with users' setting
> on ARM64 platforms.

As mentioned before, there is nothing arm64 specific here. The problem just
manifests on arm64 platform because of it's memory init process.

> 
> Jonathan Cameron tested this patch on x86 platform. Jonathan figured out
> the boot code of x86 is much different with arm64. On arm64 all nodes are
> marked online at the same time. On x86, only nodes with memory are
> initially marked as online:
> initmem_init()->x86_numa_init()->numa_init()->
> numa_register_memblks()->alloc_node_data()->node_set_online()

Function call sequence should be described (if at all) cleanly with proper
indentation.

> So at time of the existing cma setup call only the memory containing nodes
> are online. The other nodes are brought up much later.
> Therefore, on x86 platform, hugetlb_cma size is actually consistent with
> users' setting even though system has nodes without memory.
> 
> The problem is always there if N_ONLINE != N_MEMORY. In x86 case, it
> is just hidden because N_ONLINE happen to match N_MEMORY during the boot
> process when hugetlb_cma_reserve() gets called.
> 
> This patch documents this problem in the comment of hugetlb_cma_reserve()
> and makes hugetlb_cma size optimal.

The commit message here is not proper for the change it's proposing. It needs
to describe the problem, how it manifests on arm64 but remains hidden on x86,
proposed solution i.e changes in generic and platform code, also if required
before and after patch behavior on arm64 which had triggered this patch. Also
please take care of the indentation, paragraph formatting and avoid writing
in first person singular format.

> 
> Cc: Roman Gushchin <guro@fb.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: H. Peter Anvin <hpa@zytor.com>
> Cc: Mike Kravetz <mike.kravetz@oracle.com>
> Cc: Mike Rapoport <rppt@linux.ibm.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
> Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
> ---
>  -v2: document better according to Anshuman Khandual's comment
> 
>  arch/arm64/mm/init.c    | 19 ++++++++++---------
>  arch/x86/kernel/setup.c | 12 +++++++++---
>  include/linux/hugetlb.h |  7 +++++++
>  mm/hugetlb.c            |  4 ++--
>  4 files changed, 28 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 1e93cfc7c47a..420f5e55615c 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -420,15 +420,6 @@ void __init bootmem_init(void)
>  
>  	arm64_numa_init();
>  
> -	/*
> -	 * must be done after arm64_numa_init() which calls numa_init() to
> -	 * initialize node_online_map that gets used in hugetlb_cma_reserve()
> -	 * while allocating required CMA size across online nodes.
> -	 */
> -#ifdef CONFIG_ARM64_4K_PAGES
> -	hugetlb_cma_reserve(PUD_SHIFT - PAGE_SHIFT);
> -#endif
> -
>  	/*
>  	 * Sparsemem tries to allocate bootmem in memory_present(), so must be
>  	 * done after the fixed reservations.
> @@ -438,6 +429,16 @@ void __init bootmem_init(void)
>  	sparse_init();
>  	zone_sizes_init(min, max);
>  
> +	/*
> +	 * must be done after zone_sizes_init() which calls free_area_init()
> +	 * that calls node_set_state() to initialize node_states[N_MEMORY]
> +	 * because hugetlb_cma_reserve() will scan over nodes with N_MEMORY
> +	 * state
> +	 */
> +#ifdef CONFIG_ARM64_4K_PAGES
> +	hugetlb_cma_reserve(PUD_SHIFT - PAGE_SHIFT);
> +#endif
> +
>  	memblock_dump_all();
>  }
>  
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index a3767e74c758..a1a9712090ae 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -1164,9 +1164,6 @@ void __init setup_arch(char **cmdline_p)
>  	initmem_init();
>  	dma_contiguous_reserve(max_pfn_mapped << PAGE_SHIFT);
>  
> -	if (boot_cpu_has(X86_FEATURE_GBPAGES))
> -		hugetlb_cma_reserve(PUD_SHIFT - PAGE_SHIFT);
> -
>  	/*
>  	 * Reserve memory for crash kernel after SRAT is parsed so that it
>  	 * won't consume hotpluggable memory.
> @@ -1180,6 +1177,15 @@ void __init setup_arch(char **cmdline_p)
>  
>  	x86_init.paging.pagetable_init();
>  
> +	/*
> +	 * must be done after zone_sizes_init() which calls free_area_init()
> +	 * that calls node_set_state() to initialize node_states[N_MEMORY]
> +	 * because hugetlb_cma_reserve() will scan over nodes with N_MEMORY
> +	 * state
> +	 */
> +	if (boot_cpu_has(X86_FEATURE_GBPAGES))
> +		hugetlb_cma_reserve(PUD_SHIFT - PAGE_SHIFT);
> +
>  	kasan_init();
>  
>  	/*
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 50650d0d01b9..6df411d91040 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -909,6 +909,13 @@ static inline spinlock_t *huge_pte_lock(struct hstate *h,
>  }
>  
>  #if defined(CONFIG_HUGETLB_PAGE) && defined(CONFIG_CMA)
> +/**
> + * hugetlb_cma_reserve() -- reserve CMA for gigantic pages on nodes with memory
> + *
> + * must be called after free_area_init() that updates N_MEMORY via node_set_state().
> + * hugetlb_cma_reserve() scans over N_MEMORY nodemask and hence expects the platforms
> + * to have initialized N_MEMORY state.
> + */

The in-code documentation should be where it is defined i.s mm/hugetlb.c and
also in existing format e.g see unmap_kernel_range_noflush() in mm/vmalloc.c
