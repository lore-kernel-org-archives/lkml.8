Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4B9DC433F8
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 11:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88DEB206D7
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 11:52:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729173AbgG1Lwh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 07:52:37 -0400
Received: from verein.lst.de ([213.95.11.211]:47964 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728504AbgG1Lwg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 07:52:36 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0344268B05; Tue, 28 Jul 2020 13:52:32 +0200 (CEST)
Date:   Tue, 28 Jul 2020 13:52:31 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Barry Song <song.bao.hua@hisilicon.com>
Cc:     hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com,
        will@kernel.org, ganapatrao.kulkarni@cavium.com,
        catalin.marinas@arm.com, iommu@lists.linux-foundation.org,
        linuxarm@huawei.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, prime.zeng@hisilicon.com,
        huangdaode@huawei.com,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Steve Capper <steve.capper@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH v4 1/2] dma-direct: provide the ability to reserve
 per-numa CMA
Message-ID: <20200728115231.GA793@lst.de>
References: <20200723131344.41472-1-song.bao.hua@hisilicon.com> <20200723131344.41472-2-song.bao.hua@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200723131344.41472-2-song.bao.hua@hisilicon.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 24, 2020 at 01:13:43AM +1200, Barry Song wrote:
> +config CMA_PERNUMA_SIZE_MBYTES
> +	int "Size in Mega Bytes for per-numa CMA areas"
> +	depends on NUMA
> +	default 16 if ARM64
> +	default 0
> +	help
> +	  Defines the size (in MiB) of the per-numa memory area for Contiguous
> +	  Memory Allocator. Every numa node will get a separate CMA with this
> +	  size. If the size of 0 is selected, per-numa CMA is disabled.

I'm still not a fan of the config option.  You can just hardcode the
value in CONFIG_CMDLINE based on the kernel parameter.  Also I wonder
if a way to expose this in the device tree might be useful, but people
more familiar with the device tree and the arm code will have to chime
in on that.

>  struct cma *dma_contiguous_default_area;
> +static struct cma *dma_contiguous_pernuma_area[MAX_NUMNODES];
>  
>  /*
>   * Default global CMA area size can be defined in kernel's .config.
> @@ -44,6 +51,8 @@ struct cma *dma_contiguous_default_area;
>   */
>  static const phys_addr_t size_bytes __initconst =
>  	(phys_addr_t)CMA_SIZE_MBYTES * SZ_1M;
> +static phys_addr_t pernuma_size_bytes __initdata =
> +	(phys_addr_t)CMA_SIZE_PERNUMA_MBYTES * SZ_1M;
>  static phys_addr_t  size_cmdline __initdata = -1;
>  static phys_addr_t base_cmdline __initdata;
>  static phys_addr_t limit_cmdline __initdata;
> @@ -69,6 +78,13 @@ static int __init early_cma(char *p)
>  }
>  early_param("cma", early_cma);
>  
> +static int __init early_pernuma_cma(char *p)
> +{
> +	pernuma_size_bytes = memparse(p, &p);
> +	return 0;
> +}
> +early_param("pernuma_cma", early_pernuma_cma);
> +
>  #ifdef CONFIG_CMA_SIZE_PERCENTAGE
>  
>  static phys_addr_t __init __maybe_unused cma_early_percent_memory(void)
> @@ -96,6 +112,33 @@ static inline __maybe_unused phys_addr_t cma_early_percent_memory(void)
>  
>  #endif
>  
> +void __init dma_pernuma_cma_reserve(void)
> +{
> +	int nid;
> +
> +	if (!pernuma_size_bytes)
> +		return;
> +
> +	for_each_node_state(nid, N_MEMORY) {
> +		int ret;
> +		char name[20];
> +
> +		snprintf(name, sizeof(name), "pernuma%d", nid);
> +		ret = cma_declare_contiguous_nid(0, pernuma_size_bytes, 0, 0,
> +						 0, false, name,
> +						 &dma_contiguous_pernuma_area[nid],
> +						 nid);

This adds a > 80 char line.

>  struct page *dma_alloc_contiguous(struct device *dev, size_t size, gfp_t gfp)
>  {
> +	int nid = dev_to_node(dev);
> +
>  	/* CMA can be used only in the context which permits sleeping */
>  	if (!gfpflags_allow_blocking(gfp))
>  		return NULL;
>  	if (dev->cma_area)
>  		return cma_alloc_aligned(dev->cma_area, size, gfp);
> -	if (size <= PAGE_SIZE || !dma_contiguous_default_area)
> +	if (size <= PAGE_SIZE)
>  		return NULL;
> +
> +	if ((nid != NUMA_NO_NODE) && !(gfp & (GFP_DMA | GFP_DMA32))) {

No need for the braces around the nid check.

> +		struct cma *cma = dma_contiguous_pernuma_area[nid];
> +		struct page *page;
> +
> +		if (cma) {
> +			page = cma_alloc_aligned(cma, size, gfp);
> +			if (page)
> +				return page;
> +		}
> +	}
> +
>  	return cma_alloc_aligned(dma_contiguous_default_area, size, gfp);

This seems to have lost the dma_contiguous_default_area NULL check.

> +	/* if dev has its own cma, free page from there */
> +	if (dev->cma_area) {
> +		if (cma_release(dev->cma_area, page, PAGE_ALIGN(size) >> PAGE_SHIFT))
> +			return;

Another overly long line.

> +	} else {
> +		/*
> +		 * otherwise, page is from either per-numa cma or default cma
> +		 */
> +		if (cma_release(dma_contiguous_pernuma_area[page_to_nid(page)],
> +					page, PAGE_ALIGN(size) >> PAGE_SHIFT))
> +			return;
> +
> +		if (cma_release(dma_contiguous_default_area, page,
> +					PAGE_ALIGN(size) >> PAGE_SHIFT))
> +			return;
> +	}

I'd introduce a count variable for the value of "PAGE_ALIGN(size) >>
PAGE_SHIFT" to clean al lthis up a bit.

Also please add a CONFIG_PERCPU_DMA_CMA config variable so that we
don't build this code for the vast majority of users that don't need it.
