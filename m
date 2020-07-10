Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97D6AC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 18:51:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7836E20720
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 18:51:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbgGJSvt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 14:51:49 -0400
Received: from foss.arm.com ([217.140.110.172]:34440 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726872AbgGJSvs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 14:51:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1E18E31B;
        Fri, 10 Jul 2020 11:51:48 -0700 (PDT)
Received: from [192.168.122.166] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A175B3FA00;
        Fri, 10 Jul 2020 11:51:47 -0700 (PDT)
Subject: Re: [PATCH] dma-pool: Only allocate from CMA when in same memory zone
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>, hch@lst.de,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        David Rientjes <rientjes@google.com>
Cc:     linux-rpi-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20200710141016.15495-1-nsaenzjulienne@suse.de>
From:   Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <c7c24764-1014-ec81-e7fe-af0a0ac72ef9@arm.com>
Date:   Fri, 10 Jul 2020 13:51:36 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200710141016.15495-1-nsaenzjulienne@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


I have merged this to a 5.8 tree along with "dma-pool: Fix atomic pool 
selection" and tested it in various ACPI/DT combinations, particularly 
on the RPI4. It seems to be working fine.

So thanks for your time and effort clearing this up!

tested-by: Jeremy Linton <jeremy.linton@arm.com>



On 7/10/20 9:10 AM, Nicolas Saenz Julienne wrote:
> There is no guarantee to CMA's placement, so allocating a zone specific
> atomic pool from CMA might return memory from a completely different
> memory zone. To get around this double check CMA's placement before
> allocating from it.
> 
> Fixes: c84dc6e68a1d ("dma-pool: add additional coherent pools to map to gfp mask")
> Reported-by: Jeremy Linton <jeremy.linton@arm.com>
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> ---
> 
> This is a code intensive alternative to "dma-pool: Do not allocate pool
> memory from CMA"[1].
> 
> [1] https://lkml.org/lkml/2020/7/8/1108
> 
>   kernel/dma/pool.c | 36 +++++++++++++++++++++++++++++++++++-
>   1 file changed, 35 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
> index 8cfa01243ed2..ccf3eeb77e00 100644
> --- a/kernel/dma/pool.c
> +++ b/kernel/dma/pool.c
> @@ -3,6 +3,7 @@
>    * Copyright (C) 2012 ARM Ltd.
>    * Copyright (C) 2020 Google LLC
>    */
> +#include <linux/cma.h>
>   #include <linux/debugfs.h>
>   #include <linux/dma-direct.h>
>   #include <linux/dma-noncoherent.h>
> @@ -56,6 +57,39 @@ static void dma_atomic_pool_size_add(gfp_t gfp, size_t size)
>   		pool_size_kernel += size;
>   }
>   
> +static bool cma_in_zone(gfp_t gfp)
> +{
> +	u64 zone_dma_end, zone_dma32_end;
> +	phys_addr_t base, end;
> +	unsigned long size;
> +	struct cma *cma;
> +
> +	cma = dev_get_cma_area(NULL);
> +	if (!cma)
> +		return false;
> +
> +	size = cma_get_size(cma);
> +	if (!size)
> +		return false;
> +	base = cma_get_base(cma) - memblock_start_of_DRAM();
> +	end = base + size - 1;
> +
> +	zone_dma_end = IS_ENABLED(CONFIG_ZONE_DMA) ? DMA_BIT_MASK(zone_dma_bits) : 0;
> +	zone_dma32_end = IS_ENABLED(CONFIG_ZONE_DMA32) ? DMA_BIT_MASK(32) : 0;
> +
> +	/* CMA can't cross zone boundaries, see cma_activate_area() */
> +	if (IS_ENABLED(CONFIG_ZONE_DMA) && gfp & GFP_DMA &&
> +	   end <= zone_dma_end)
> +		return true;
> +	else if (IS_ENABLED(CONFIG_ZONE_DMA32) && gfp & GFP_DMA32 &&
> +		base > zone_dma_end && end <= zone_dma32_end)
> +		return true;
> +	else if (base > zone_dma32_end)
> +		return true;
> +
> +	return false;
> +}
> +
>   static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
>   			      gfp_t gfp)
>   {
> @@ -70,7 +104,7 @@ static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
>   	do {
>   		pool_size = 1 << (PAGE_SHIFT + order);
>   
> -		if (dev_get_cma_area(NULL))
> +		if (cma_in_zone(gfp))
>   			page = dma_alloc_from_contiguous(NULL, 1 << order,
>   							 order, false);
>   		else
> 

