Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BE94C3F2D1
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 22:29:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DC6820728
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 22:29:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bnSswgv1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbgCCW3i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 17:29:38 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34884 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727322AbgCCW3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 17:29:37 -0500
Received: by mail-pg1-f196.google.com with SMTP id 7so2220913pgr.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 14:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=qsYG18HX6uZbiPK20EisyP81AacMb1c2Icyzz8nclsQ=;
        b=bnSswgv1wQFHCnn2gUBYrBM6J8xRuL8TpkX3sFiMTk4PrTI/zDDPpicC5ZXcMnJDM/
         0Ry1HAMWFWQNXmkHdB7fFqsXsckAp87MBVtGcXD9f2e75GCgZbuNApH7lJCb93O1VBcf
         eZAhsO/26YflgSqRe7KMkFSPiHe2E3+sgW/9wFTytSoZ0cHMP5HrBowLc+Bkg1oToYoY
         1Tdm3PmBgZAtoBgYkPh4swcaX6JDf5+v6Kl//LM1ArypSYa2P3tIDUqFUj+ggonrV3um
         F0r0YZAnpFQDAGqXCrS40dDQWYBigUnN074NBmPnOI2lZ1v5BZKascdgNBolGiNcr/Cp
         q/ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=qsYG18HX6uZbiPK20EisyP81AacMb1c2Icyzz8nclsQ=;
        b=AHKD5B3/p9k0irXNOFosXjqnCp1lueTQ17wpUE0KVSpBuyJ1UE2xYIk0UxRyGUmbz6
         c1Wj47mfcvLlCMup+iANS7sRvvv+43Z1Nw+InVm33D5nxg13Sa6NYoSa2CKKDL9RNoG9
         dFWGc94S42yTXCgFJVApOcZPdwbBFqsX4XQwKnBMVObPqiPfnJewAeSgqVcF2BXghTJg
         q8N2zhPZxkRQF3KJeMNcFHaJzw32/iMQNdvJCTAKc/CnL7rY43woUa265JDsYDnVUN83
         e5/Yccg+XQTqEoAZVZQoOguQtsO/Jff+BbE6jFJ0qZntbA178iVK1fmwWZZdWR1qFNNJ
         YPNg==
X-Gm-Message-State: ANhLgQ0mTOFhb2OGia1lUZd2cjxxEsz42wA3EyUq4UAXDEhDgwxK1M5O
        MDrUCEBV0726z7zG9MhQ+1JZiA==
X-Google-Smtp-Source: ADFU+vtzyIShP+G54of6bxET8G8ijzqUGU1m5d1X3O4aCk+cSDULuBvvUSQPIM3mSn/0xoX3ha8aAA==
X-Received: by 2002:aa7:9a5e:: with SMTP id x30mr497971pfj.33.1583274575478;
        Tue, 03 Mar 2020 14:29:35 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id d24sm26951030pfq.75.2020.03.03.14.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 14:29:34 -0800 (PST)
Date:   Tue, 3 Mar 2020 14:29:34 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Christoph Hellwig <hch@lst.de>,
        Tom Lendacky <thomas.lendacky@amd.com>
cc:     "Singh, Brijesh" <brijesh.singh@amd.com>,
        "Grimm, Jon" <jon.grimm@amd.com>, Joerg Roedel <joro@8bytes.org>,
        baekhw@google.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Subject: Re: [rfc 4/6] dma-remap: dynamically expanding atomic pools
In-Reply-To: <alpine.DEB.2.21.2003011537440.213582@chino.kir.corp.google.com>
Message-ID: <alpine.DEB.2.21.2003031424400.41997@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.1912311738130.68206@chino.kir.corp.google.com> <b22416ec-cc28-3fd2-3a10-89840be173fa@amd.com> <alpine.DEB.2.21.2002280118461.165532@chino.kir.corp.google.com> <alpine.DEB.2.21.2003011535510.213582@chino.kir.corp.google.com>
 <alpine.DEB.2.21.2003011537440.213582@chino.kir.corp.google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 1 Mar 2020, David Rientjes wrote:

> When an atomic pool becomes fully depleted because it is now relied upon
> for all non-blocking allocations through the DMA API, allow background
> expansion of each pool by a kworker.
> 
> When an atomic pool has less than the default size of memory left, kick
> off a kworker to dynamically expand the pool in the background.  The pool
> is doubled in size.
> 
> This allows the default size to be kept quite low when one or more of the
> atomic pools is not used.
> 
> Also switch over some node ids to the more appropriate NUMA_NO_NODE.
> 
> Signed-off-by: David Rientjes <rientjes@google.com>
> ---
>  kernel/dma/remap.c | 79 ++++++++++++++++++++++++++++++++++------------
>  1 file changed, 58 insertions(+), 21 deletions(-)
> 
> diff --git a/kernel/dma/remap.c b/kernel/dma/remap.c
> --- a/kernel/dma/remap.c
> +++ b/kernel/dma/remap.c
> @@ -10,6 +10,7 @@
>  #include <linux/genalloc.h>
>  #include <linux/slab.h>
>  #include <linux/vmalloc.h>
> +#include <linux/workqueue.h>
>  
>  struct page **dma_common_find_pages(void *cpu_addr)
>  {
> @@ -104,7 +105,10 @@ static struct gen_pool *atomic_pool_dma32 __ro_after_init;
>  static struct gen_pool *atomic_pool_normal __ro_after_init;
>  
>  #define DEFAULT_DMA_COHERENT_POOL_SIZE  SZ_256K
> -static size_t atomic_pool_size __initdata = DEFAULT_DMA_COHERENT_POOL_SIZE;
> +static size_t atomic_pool_size = DEFAULT_DMA_COHERENT_POOL_SIZE;
> +
> +/* Dynamic background expansion when the atomic pool is near capacity */
> +struct work_struct atomic_pool_work;
>  
>  static int __init early_coherent_pool(char *p)
>  {
> @@ -113,14 +117,14 @@ static int __init early_coherent_pool(char *p)
>  }
>  early_param("coherent_pool", early_coherent_pool);
>  
> -static int __init __dma_atomic_pool_init(struct gen_pool **pool,
> -					 size_t pool_size, gfp_t gfp)
> +static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
> +			      gfp_t gfp)
>  {
> -	const unsigned int order = get_order(pool_size);
>  	const unsigned long nr_pages = pool_size >> PAGE_SHIFT;
> +	const unsigned int order = get_order(pool_size);
>  	struct page *page;
>  	void *addr;
> -	int ret;
> +	int ret = -ENOMEM;
>  
>  	if (dev_get_cma_area(NULL))
>  		page = dma_alloc_from_contiguous(NULL, nr_pages, order, false);

There's an issue here if the pool grows too large which would result in
order > MAX_ORDER-1.  We can fix that by limiting order to MAX_ORDER-1 and 
doing nr_pages = 1 << order.

I should also add support for trying smaller page allocations if our 
preferred expansion size results in an allocation failure.

Other than that, I'll remove the RFC tag and send a refreshed series by 
the end of the week unless there are other comments or suggestions to 
factor in.

Thanks!

> @@ -131,38 +135,67 @@ static int __init __dma_atomic_pool_init(struct gen_pool **pool,
>  
>  	arch_dma_prep_coherent(page, pool_size);
>  
> -	*pool = gen_pool_create(PAGE_SHIFT, -1);
> -	if (!*pool)
> -		goto free_page;
> -
>  	addr = dma_common_contiguous_remap(page, pool_size,
>  					   pgprot_dmacoherent(PAGE_KERNEL),
>  					   __builtin_return_address(0));
>  	if (!addr)
> -		goto destroy_genpool;
> +		goto free_page;
>  
> -	ret = gen_pool_add_virt(*pool, (unsigned long)addr, page_to_phys(page),
> -				pool_size, -1);
> +	ret = gen_pool_add_virt(pool, (unsigned long)addr, page_to_phys(page),
> +				pool_size, NUMA_NO_NODE);
>  	if (ret)
>  		goto remove_mapping;
> -	gen_pool_set_algo(*pool, gen_pool_first_fit_order_align, NULL);
>  
> -	pr_info("DMA: preallocated %zu KiB %pGg pool for atomic allocations\n",
> -		pool_size >> 10, &gfp);
>  	return 0;
>  
>  remove_mapping:
>  	dma_common_free_remap(addr, pool_size);
> -destroy_genpool:
> -	gen_pool_destroy(*pool);
> -	*pool = NULL;
>  free_page:
>  	if (!dma_release_from_contiguous(NULL, page, nr_pages))
>  		__free_pages(page, order);
>  out:
> -	pr_err("DMA: failed to allocate %zu KiB %pGg pool for atomic allocation\n",
> -		atomic_pool_size >> 10, &gfp);
> -	return -ENOMEM;
> +	return ret;
> +}
> +
> +static void atomic_pool_resize(struct gen_pool *pool, gfp_t gfp)
> +{
> +	if (pool && gen_pool_avail(pool) < atomic_pool_size)
> +		atomic_pool_expand(pool, gen_pool_size(pool), gfp);
> +}
> +
> +static void atomic_pool_work_fn(struct work_struct *work)
> +{
> +	if (IS_ENABLED(CONFIG_ZONE_DMA))
> +		atomic_pool_resize(atomic_pool, GFP_DMA);
> +	if (IS_ENABLED(CONFIG_ZONE_DMA32))
> +		atomic_pool_resize(atomic_pool_dma32, GFP_DMA32);
> +	atomic_pool_resize(atomic_pool_normal, GFP_KERNEL);
> +}
> +
> +static int __init __dma_atomic_pool_init(struct gen_pool **pool,
> +					 size_t pool_size, gfp_t gfp)
> +{
> +	int ret;
> +
> +	*pool = gen_pool_create(PAGE_SHIFT, NUMA_NO_NODE);
> +	if (!*pool)
> +		return -ENOMEM;
> +
> +	gen_pool_set_algo(*pool, gen_pool_first_fit_order_align, NULL);
> +
> +	ret = atomic_pool_expand(*pool, pool_size, gfp);
> +	if (ret) {
> +		gen_pool_destroy(*pool);
> +		*pool = NULL;
> +		pr_err("DMA: failed to allocate %zu KiB %pGg pool for atomic allocation\n",
> +		       atomic_pool_size >> 10, &gfp);
> +		return ret;
> +	}
> +
> +
> +	pr_info("DMA: preallocated %zu KiB %pGg pool for atomic allocations\n",
> +		pool_size >> 10, &gfp);
> +	return 0;
>  }
>  
>  static int __init dma_atomic_pool_init(void)
> @@ -170,6 +203,8 @@ static int __init dma_atomic_pool_init(void)
>  	int ret = 0;
>  	int err;
>  
> +	INIT_WORK(&atomic_pool_work, atomic_pool_work_fn);
> +
>  	ret = __dma_atomic_pool_init(&atomic_pool_normal, atomic_pool_size,
>  				     GFP_KERNEL);
>  	if (IS_ENABLED(CONFIG_ZONE_DMA)) {
> @@ -231,6 +266,8 @@ void *dma_alloc_from_pool(struct device *dev, size_t size,
>  		ptr = (void *)val;
>  		memset(ptr, 0, size);
>  	}
> +	if (gen_pool_avail(pool) < atomic_pool_size)
> +		schedule_work(&atomic_pool_work);
>  
>  	return ptr;
>  }
> 
