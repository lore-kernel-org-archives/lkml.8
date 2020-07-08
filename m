Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27CFDC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 23:14:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DC4620708
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 23:14:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgGHXOx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 19:14:53 -0400
Received: from foss.arm.com ([217.140.110.172]:44326 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726321AbgGHXOw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 19:14:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 328EE31B;
        Wed,  8 Jul 2020 16:14:51 -0700 (PDT)
Received: from [192.168.122.166] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B6F4B3F9AB;
        Wed,  8 Jul 2020 16:14:50 -0700 (PDT)
Subject: Re: [PATCH] dma-pool: Do not allocate pool memory from CMA
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        David Rientjes <rientjes@google.com>
Cc:     linux-rpi-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20200708164936.9340-1-nsaenzjulienne@suse.de>
From:   Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <a32e1017-4724-7cd8-0ba9-daddfaad1f44@arm.com>
Date:   Wed, 8 Jul 2020 18:14:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200708164936.9340-1-nsaenzjulienne@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 7/8/20 11:49 AM, Nicolas Saenz Julienne wrote:
> There is no guarantee to CMA's placement, so allocating a zone specific
> atomic pool from CMA might return memory from a completely different
> memory zone. So stop using it.
> 
> Fixes: c84dc6e68a1d ("dma-pool: add additional coherent pools to map to gfp mask")
> Reported-by: Jeremy Linton <jeremy.linton@arm.com>
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> ---

With this patch and 
https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg2226971.html 
the machine appears to be working fine with/without CMA and in both 
DT/ACPI mode.

The JBOD/etc I was having problems with are working fine, and the rtlsdr 
seems to be working better now too (its still not perfect, but that is 
likely another issue).

so:

tested-by: Jeremy Linton <jeremy.linton@arm.com>

thanks!


> 
> An more costly alternative would be adding an option to
> dma_alloc_from_contiguous() so it fails when the allocation doesn't fall
> in a specific zone.
> 
>   kernel/dma/pool.c | 11 ++---------
>   1 file changed, 2 insertions(+), 9 deletions(-)
> 
> diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
> index 8cfa01243ed2..4bc1c46ae6ef 100644
> --- a/kernel/dma/pool.c
> +++ b/kernel/dma/pool.c
> @@ -6,7 +6,6 @@
>   #include <linux/debugfs.h>
>   #include <linux/dma-direct.h>
>   #include <linux/dma-noncoherent.h>
> -#include <linux/dma-contiguous.h>
>   #include <linux/init.h>
>   #include <linux/genalloc.h>
>   #include <linux/set_memory.h>
> @@ -69,12 +68,7 @@ static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
>   
>   	do {
>   		pool_size = 1 << (PAGE_SHIFT + order);
> -
> -		if (dev_get_cma_area(NULL))
> -			page = dma_alloc_from_contiguous(NULL, 1 << order,
> -							 order, false);
> -		else
> -			page = alloc_pages(gfp, order);
> +		page = alloc_pages(gfp, order);
>   	} while (!page && order-- > 0);
>   	if (!page)
>   		goto out;
> @@ -118,8 +112,7 @@ static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
>   	dma_common_free_remap(addr, pool_size);
>   #endif
>   free_page: __maybe_unused
> -	if (!dma_release_from_contiguous(NULL, page, 1 << order))
> -		__free_pages(page, order);
> +	__free_pages(page, order);
>   out:
>   	return ret;
>   }
> 

