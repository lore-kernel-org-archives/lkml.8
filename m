Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 535DBC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 04:12:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 321F1207C4
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 04:12:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726028AbgFQEM3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 00:12:29 -0400
Received: from foss.arm.com ([217.140.110.172]:50892 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725776AbgFQEM3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 00:12:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8943E1FB;
        Tue, 16 Jun 2020 21:12:28 -0700 (PDT)
Received: from [10.163.80.128] (unknown [10.163.80.128])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A09C03F71F;
        Tue, 16 Jun 2020 21:12:24 -0700 (PDT)
Subject: Re: [PATCH v2] arm64: mm: reserve hugetlb CMA after numa_init
To:     Barry Song <song.bao.hua@hisilicon.com>, catalin.marinas@arm.com,
        will@kernel.org, nsaenzjulienne@suse.de, steve.capper@arm.com,
        rppt@linux.ibm.com, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linuxarm@huawei.com,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Roman Gushchin <guro@fb.com>,
        linux-arm-kernel@lists.infradead.org
References: <20200616221924.74780-1-song.bao.hua@hisilicon.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <4489e307-1ce8-a883-2dae-1aa7e1c881fc@arm.com>
Date:   Wed, 17 Jun 2020 09:42:18 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200616221924.74780-1-song.bao.hua@hisilicon.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/17/2020 03:49 AM, Barry Song wrote:
> hugetlb_cma_reserve() is called at the wrong place. numa_init has not been
> done yet. so all reserved memory will be located at node0.
> 
> Fixes: cf11e85fc08c ("mm: hugetlb: optionally allocate gigantic hugepages using cma")
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Acked-by: Roman Gushchin <guro@fb.com>
> Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
> ---
>  -v2: add Fixes tag according to Matthias Brugger's comment
> 
>  arch/arm64/mm/init.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index e631e6425165..41914b483d54 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -404,11 +404,6 @@ void __init arm64_memblock_init(void)
>  	high_memory = __va(memblock_end_of_DRAM() - 1) + 1;
>  
>  	dma_contiguous_reserve(arm64_dma32_phys_limit);
> -
> -#ifdef CONFIG_ARM64_4K_PAGES
> -	hugetlb_cma_reserve(PUD_SHIFT - PAGE_SHIFT);
> -#endif
> -
>  }
>  
>  void __init bootmem_init(void)
> @@ -424,6 +419,11 @@ void __init bootmem_init(void)
>  	min_low_pfn = min;
>  
>  	arm64_numa_init();
> +
> +#ifdef CONFIG_ARM64_4K_PAGES
> +	hugetlb_cma_reserve(PUD_SHIFT - PAGE_SHIFT);
> +#endif

arm64_numa_init() calls numa_init() which initializes node_online_map
that gets used in hugetlb_cma_reserve() while allocating required CMA
size across online nodes.

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
