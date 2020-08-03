Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6603C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 15:39:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D018620781
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 15:39:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbgHCPjo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 11:39:44 -0400
Received: from foss.arm.com ([217.140.110.172]:59104 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726478AbgHCPjo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 11:39:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9126E30E;
        Mon,  3 Aug 2020 08:39:43 -0700 (PDT)
Received: from [10.57.35.143] (unknown [10.57.35.143])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6D4DA3F718;
        Mon,  3 Aug 2020 08:39:40 -0700 (PDT)
Subject: Re: [PATCH] ARM64: Setup DMA32 zone size by bootargs
To:     Phil Chang <phil.chang@mediatek.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Alix Wu <alix.wu@mediatek.com>, linux-doc@vger.kernel.org,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Steve Capper <steve.capper@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        YJ Chiang <yj.chiang@mediatek.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>
References: <20200803142647.16737-1-phil.chang@mediatek.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <db255462-7a02-f3a4-075a-5070f630e9d6@arm.com>
Date:   Mon, 3 Aug 2020 16:39:39 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200803142647.16737-1-phil.chang@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-08-03 15:26, Phil Chang wrote:
> this patch allowing the arm64 DMA zone be configurable.
> 
> Signed-off-by: Alix Wu <alix.wu@mediatek.com>
> Signed-off-by: YJ Chiang <yj.chiang@mediatek.com>
> Signed-off-by: Phil Chang <phil.chang@mediatek.com>
> ---
> Hi
> 
> For some devices, the main memory split into 2 part due to the memory architecture,
> the efficient and less inefficient part.
> One of the use case is fine-tune the dma32 size to contain all the
> efficient part of memory block on this kind of architecture,
> but in general, the DMA32 zone size is hardcode to 4G.

The sole point of ZONE_DMA32 is to contain all the 32-bit addressable 
memory which is not covered by ZONE_DMA. As such the only possible thing 
that could be configured is the size of ZONE_DMA (if present), and this 
patch makes no sense.

If you want to describe NUMA characteristics, use NUMA properties. 
Giving users freedom to break fundamental assumptions of the DMA layer 
by arbitrarily changing the meaning of "32-bit" is not an appropriate 
solution.

Robin.

>   .../admin-guide/kernel-parameters.txt         |  3 ++
>   arch/arm64/include/asm/memory.h               |  2 ++
>   arch/arm64/mm/init.c                          | 33 +++++++++++++++++--
>   3 files changed, 35 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index fb95fad81c79..441ad3cb8ee8 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -956,6 +956,9 @@
>   			The filter can be disabled or changed to another
>   			driver later using sysfs.
>   
> +	dma32_zone=nn	[KMG] [KNL,BOOT]
> +			Forces the DMA32 zone size of <nn> in mb, arm64 only.
> +
>   	driver_async_probe=  [KNL]
>   			List of driver names to be probed asynchronously.
>   			Format: <driver_name1>,<driver_name2>...
> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
> index a1871bb32bb1..377f2252618a 100644
> --- a/arch/arm64/include/asm/memory.h
> +++ b/arch/arm64/include/asm/memory.h
> @@ -174,6 +174,8 @@ extern u64			kimage_vaddr;
>   /* the offset between the kernel virtual and physical mappings */
>   extern u64			kimage_voffset;
>   
> +extern phys_addr_t		arm_dma_zone_size;
> +
>   static inline unsigned long kaslr_offset(void)
>   {
>   	return kimage_vaddr - KIMAGE_VADDR;
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 1e93cfc7c47a..642ab323392c 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -60,6 +60,9 @@ EXPORT_SYMBOL(physvirt_offset);
>   struct page *vmemmap __ro_after_init;
>   EXPORT_SYMBOL(vmemmap);
>   
> +phys_addr_t arm_dma_zone_size __ro_after_init;
> +EXPORT_SYMBOL(arm_dma_zone_size);
> +
>   /*
>    * We create both ZONE_DMA and ZONE_DMA32. ZONE_DMA covers the first 1G of
>    * memory as some devices, namely the Raspberry Pi 4, have peripherals with
> @@ -242,6 +245,25 @@ static int __init early_mem(char *p)
>   }
>   early_param("mem", early_mem);
>   
> +/*
> + * Setup the dma32 zone size
> + */
> +static int __init setup_dma32_zone(char *p)
> +{
> +	if (!p)
> +		return -EINVAL;
> +
> +	if (kstrtoull(p, 0, &arm_dma_zone_size))
> +		return -EINVAL;
> +
> +	arm_dma_zone_size *= SZ_1M;
> +	pr_notice("Setup dma32 zone size to %llu Mb\n", arm_dma_zone_size);
> +
> +	return 0;
> +}
> +
> +early_param("dma32_zone", setup_dma32_zone);
> +
>   static int __init early_init_dt_scan_usablemem(unsigned long node,
>   		const char *uname, int depth, void *data)
>   {
> @@ -392,10 +414,15 @@ void __init arm64_memblock_init(void)
>   		arm64_dma_phys_limit = max_zone_phys(ARM64_ZONE_DMA_BITS);
>   	}
>   
> -	if (IS_ENABLED(CONFIG_ZONE_DMA32))
> -		arm64_dma32_phys_limit = max_zone_phys(32);
> -	else
> +	if (IS_ENABLED(CONFIG_ZONE_DMA32)) {
> +		if (arm_dma_zone_size)
> +			arm64_dma32_phys_limit = arm_dma_zone_size +
> +						memblock_start_of_DRAM();
> +		else
> +			arm64_dma32_phys_limit = max_zone_phys(32);
> +	} else {
>   		arm64_dma32_phys_limit = PHYS_MASK + 1;
> +	}
>   
>   	reserve_crashkernel();
>   
> 
