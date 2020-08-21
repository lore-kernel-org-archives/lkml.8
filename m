Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99470C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 02:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71F0820855
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 02:50:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TheepzJO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbgHUCuP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 22:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726964AbgHUCuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 22:50:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77D17C061385
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 19:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=o8FOD1P0Ywv5Vt6CEpvQmhpEk1fBVgUX3n+CuvA7v/c=; b=TheepzJO/krjJ5ZXXdUKl/s/Ui
        5NwLqjcxka5lAsbKNOVpc2zD9wn4Z7Z3yI7Q6ht60Op2OglNliMaipeC6C8F8XBdp1jmpd0tYAPCr
        /lx/Ho2sxJhmTn48VsUmhTr1mGgqurhzzoFGULF1Gr41VLeMc6mUdGqxt9G0QRYaQFRD0rrfWRSvw
        tF5qXrLADexgpUUudDw9bTTajVzSItpePMMW4M9+hfK6DjJ+u9wNmAM88bEf7ItLSMhzxDCAI0Ukk
        mA7PvLKa2k9Sne2JI+OjOVogH779r2EDdPkPiUIC+R4lUiXNJ+erfzDq7Vcm2ujVwXvF0jhAWtUq6
        iy1Vm6Zw==;
Received: from [2601:1c0:6280:3f0::19c2]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k8x7x-0006dh-6L; Fri, 21 Aug 2020 02:50:01 +0000
Subject: Re: [PATCH v6 1/2] dma-contiguous: provide the ability to reserve
 per-numa CMA
To:     Barry Song <song.bao.hua@hisilicon.com>, hch@lst.de,
        m.szyprowski@samsung.com, robin.murphy@arm.com, will@kernel.org,
        ganapatrao.kulkarni@cavium.com, catalin.marinas@arm.com
Cc:     iommu@lists.linux-foundation.org, linuxarm@huawei.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        huangdaode@huawei.com,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Steve Capper <steve.capper@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>
References: <20200821022615.28596-1-song.bao.hua@hisilicon.com>
 <20200821022615.28596-2-song.bao.hua@hisilicon.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <5dbe456d-d408-11ef-788e-63d996435fa8@infradead.org>
Date:   Thu, 20 Aug 2020 19:49:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200821022615.28596-2-song.bao.hua@hisilicon.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/20/20 7:26 PM, Barry Song wrote:
> 
> 
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> Cc: Steve Capper <steve.capper@arm.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Mike Rapoport <rppt@linux.ibm.com>
> Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
> ---
>  v6: rebase on top of 5.9-rc1;
>      doc cleanup
> 
>  .../admin-guide/kernel-parameters.txt         |   9 ++
>  include/linux/dma-contiguous.h                |   6 ++
>  kernel/dma/Kconfig                            |  10 ++
>  kernel/dma/contiguous.c                       | 100 ++++++++++++++++--
>  4 files changed, 115 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index bdc1f33fd3d1..3f33b89aeab5 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -599,6 +599,15 @@
>  			altogether. For more information, see
>  			include/linux/dma-contiguous.h
>  
> +	pernuma_cma=nn[MG]

memparse() allows any one of these suffixes: K, M, G, T, P, E
and nothing in the option parsing function cares what suffix is used...

> +			[ARM64,KNL]
> +			Sets the size of kernel per-numa memory area for
> +			contiguous memory allocations. A value of 0 disables
> +			per-numa CMA altogether. DMA users on node nid will
> +			first try to allocate buffer from the pernuma area
> +			which is located in node nid, if the allocation fails,
> +			they will fallback to the global default memory area.
> +
>  	cmo_free_hint=	[PPC] Format: { yes | no }
>  			Specify whether pages are marked as being inactive
>  			when they are freed.  This is used in CMO environments

> diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
> index cff7e60968b9..89b95f10e56d 100644
> --- a/kernel/dma/contiguous.c
> +++ b/kernel/dma/contiguous.c
> @@ -69,6 +69,19 @@ static int __init early_cma(char *p)
>  }
>  early_param("cma", early_cma);
>  
> +#ifdef CONFIG_DMA_PERNUMA_CMA
> +
> +static struct cma *dma_contiguous_pernuma_area[MAX_NUMNODES];
> +static phys_addr_t pernuma_size_bytes __initdata;

why phys_addr_t? couldn't it just be unsigned long long?

OK, so cma_declare_contiguous_nid() uses phys_addr_t. Fine.

> +
> +static int __init early_pernuma_cma(char *p)
> +{
> +	pernuma_size_bytes = memparse(p, &p);
> +	return 0;
> +}
> +early_param("pernuma_cma", early_pernuma_cma);
> +#endif
> +
>  #ifdef CONFIG_CMA_SIZE_PERCENTAGE
>  
>  static phys_addr_t __init __maybe_unused cma_early_percent_memory(void)
> @@ -96,6 +109,34 @@ static inline __maybe_unused phys_addr_t cma_early_percent_memory(void)
>  
>  #endif
>  
> +#ifdef CONFIG_DMA_PERNUMA_CMA
> +void __init dma_pernuma_cma_reserve(void)
> +{
> +	int nid;
> +
> +	if (!pernuma_size_bytes)
> +		return;
> +
> +	for_each_node_state(nid, N_ONLINE) {
> +		int ret;
> +		char name[20];
> +		struct cma **cma = &dma_contiguous_pernuma_area[nid];
> +
> +		snprintf(name, sizeof(name), "pernuma%d", nid);
> +		ret = cma_declare_contiguous_nid(0, pernuma_size_bytes, 0, 0,
> +						 0, false, name, cma, nid);
> +		if (ret) {
> +			pr_warn("%s: reservation failed: err %d, node %d", __func__,
> +				ret, nid);
> +			continue;
> +		}
> +
> +		pr_debug("%s: reserved %llu MiB on node %d\n", __func__,
> +			(unsigned long long)pernuma_size_bytes / SZ_1M, nid);

Conversely, if you want to leave pernuma_size_bytes as phys_addr_t,
you should use %pa (or %pap) to print it.

> +	}
> +}
> +#endif



-- 
~Randy

