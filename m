Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23E7EC433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 17:24:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F5282078B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 17:24:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732705AbgIARYb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 13:24:31 -0400
Received: from foss.arm.com ([217.140.110.172]:47282 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728454AbgIARYV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 13:24:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 266601FB;
        Tue,  1 Sep 2020 10:24:21 -0700 (PDT)
Received: from [10.57.40.122] (unknown [10.57.40.122])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 27F3B3F71F;
        Tue,  1 Sep 2020 10:24:18 -0700 (PDT)
Subject: Re: [PATCH v9 02/32] drm: prime: use sgtable iterators in
 drm_prime_sg_to_page_addr_arrays()
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
References: <20200826063316.23486-1-m.szyprowski@samsung.com>
 <CGME20200826063528eucas1p1502c849c0fd337245541e1b31352d87f@eucas1p1.samsung.com>
 <20200826063316.23486-3-m.szyprowski@samsung.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <484582f2-b027-8406-b6ff-f50c0d1ba7b0@arm.com>
Date:   Tue, 1 Sep 2020 18:24:17 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200826063316.23486-3-m.szyprowski@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-08-26 07:32, Marek Szyprowski wrote:
> Replace the current hand-crafted code for extracting pages and DMA
> addresses from the given scatterlist by the much more robust
> code based on the generic scatterlist iterators and recently
> introduced sg_table-based wrappers. The resulting code is simple and
> easy to understand, so the comment describing the old code is no
> longer needed.

Is removing the WARN_ON()s intentional? It certainly seems like it would 
be a genuine driver bug if the caller asked for addresses but didn't 
allocate appropriately-sized arrays. Might be worth noting either way. 
I'm also assuming this isn't called in performance-critical paths with 
massive lists such that the two separate iterations might have a 
noticeable impact.

Nits aside,

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
> ---
>   drivers/gpu/drm/drm_prime.c | 49 ++++++++++++-------------------------
>   1 file changed, 15 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_prime.c b/drivers/gpu/drm/drm_prime.c
> index 4ed5ed1f078c..5d181bf60a44 100644
> --- a/drivers/gpu/drm/drm_prime.c
> +++ b/drivers/gpu/drm/drm_prime.c
> @@ -990,45 +990,26 @@ EXPORT_SYMBOL(drm_gem_prime_import);
>   int drm_prime_sg_to_page_addr_arrays(struct sg_table *sgt, struct page **pages,
>   				     dma_addr_t *addrs, int max_entries)
>   {
> -	unsigned count;
> -	struct scatterlist *sg;
> -	struct page *page;
> -	u32 page_len, page_index;
> -	dma_addr_t addr;
> -	u32 dma_len, dma_index;
> -
> -	/*
> -	 * Scatterlist elements contains both pages and DMA addresses, but
> -	 * one shoud not assume 1:1 relation between them. The sg->length is
> -	 * the size of the physical memory chunk described by the sg->page,
> -	 * while sg_dma_len(sg) is the size of the DMA (IO virtual) chunk
> -	 * described by the sg_dma_address(sg).
> -	 */
> -	page_index = 0;
> -	dma_index = 0;
> -	for_each_sg(sgt->sgl, sg, sgt->nents, count) {
> -		page_len = sg->length;
> -		page = sg_page(sg);
> -		dma_len = sg_dma_len(sg);
> -		addr = sg_dma_address(sg);
> -
> -		while (pages && page_len > 0) {
> -			if (WARN_ON(page_index >= max_entries))
> +	struct sg_dma_page_iter dma_iter;
> +	struct sg_page_iter page_iter;
> +	struct page **p = pages;
> +	dma_addr_t *a = addrs;
> +
> +	if (pages) {
> +		for_each_sgtable_page(sgt, &page_iter, 0) {
> +			if (p - pages >= max_entries)
>   				return -1;
> -			pages[page_index] = page;
> -			page++;
> -			page_len -= PAGE_SIZE;
> -			page_index++;
> +			*p++ = sg_page_iter_page(&page_iter);
>   		}
> -		while (addrs && dma_len > 0) {
> -			if (WARN_ON(dma_index >= max_entries))
> +	}
> +	if (addrs) {
> +		for_each_sgtable_dma_page(sgt, &dma_iter, 0) {
> +			if (a - addrs >= max_entries)
>   				return -1;
> -			addrs[dma_index] = addr;
> -			addr += PAGE_SIZE;
> -			dma_len -= PAGE_SIZE;
> -			dma_index++;
> +			*a++ = sg_page_iter_dma_address(&dma_iter);
>   		}
>   	}
> +
>   	return 0;
>   }
>   EXPORT_SYMBOL(drm_prime_sg_to_page_addr_arrays);
> 
