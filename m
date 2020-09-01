Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07955C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 18:26:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E93172071B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 18:26:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730318AbgIAS0h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 14:26:37 -0400
Received: from foss.arm.com ([217.140.110.172]:48016 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727991AbgIAS0g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 14:26:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4B5561FB;
        Tue,  1 Sep 2020 11:26:35 -0700 (PDT)
Received: from [10.57.40.122] (unknown [10.57.40.122])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 63A0F3F71F;
        Tue,  1 Sep 2020 11:26:33 -0700 (PDT)
Subject: Re: [PATCH v9 04/32] drm: armada: fix common struct sg_table related
 issues
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Russell King <linux@armlinux.org.uk>
References: <20200826063316.23486-1-m.szyprowski@samsung.com>
 <CGME20200826063529eucas1p24a398fd2bacf53a33a14d7977a097f61@eucas1p2.samsung.com>
 <20200826063316.23486-5-m.szyprowski@samsung.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <f3a3e178-4d52-7015-1913-bf44993f07f3@arm.com>
Date:   Tue, 1 Sep 2020 19:26:32 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200826063316.23486-5-m.szyprowski@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-08-26 07:32, Marek Szyprowski wrote:
> The Documentation/DMA-API-HOWTO.txt states that the dma_map_sg() function
> returns the number of the created entries in the DMA address space.
> However the subsequent calls to the dma_sync_sg_for_{device,cpu}() and
> dma_unmap_sg must be called with the original number of the entries
> passed to the dma_map_sg().
> 
> struct sg_table is a common structure used for describing a non-contiguous
> memory buffer, used commonly in the DRM and graphics subsystems. It
> consists of a scatterlist with memory pages and DMA addresses (sgl entry),
> as well as the number of scatterlist entries: CPU pages (orig_nents entry)
> and DMA mapped pages (nents entry).
> 
> It turned out that it was a common mistake to misuse nents and orig_nents
> entries, calling DMA-mapping functions with a wrong number of entries or
> ignoring the number of mapped entries returned by the dma_map_sg()
> function.
> 
> To avoid such issues, lets use a common dma-mapping wrappers operating
> directly on the struct sg_table objects and use scatterlist page
> iterators where possible. This, almost always, hides references to the
> nents and orig_nents entries, making the code robust, easier to follow
> and copy/paste safe.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>   drivers/gpu/drm/armada/armada_gem.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/armada/armada_gem.c b/drivers/gpu/drm/armada/armada_gem.c
> index 8005614d2e6b..bedd8937d8a1 100644
> --- a/drivers/gpu/drm/armada/armada_gem.c
> +++ b/drivers/gpu/drm/armada/armada_gem.c
> @@ -395,7 +395,7 @@ armada_gem_prime_map_dma_buf(struct dma_buf_attachment *attach,
>   
>   		mapping = dobj->obj.filp->f_mapping;
>   
> -		for_each_sg(sgt->sgl, sg, count, i) {
> +		for_each_sgtable_sg(sgt, sg, i) {
>   			struct page *page;
>   
>   			page = shmem_read_mapping_page(mapping, i);
> @@ -407,8 +407,8 @@ armada_gem_prime_map_dma_buf(struct dma_buf_attachment *attach,
>   			sg_set_page(sg, page, PAGE_SIZE, 0);
>   		}
>   
> -		if (dma_map_sg(attach->dev, sgt->sgl, sgt->nents, dir) == 0) {
> -			num = sgt->nents;
> +		if (dma_map_sgtable(attach->dev, sgt, dir, 0)) {
> +			num = count;

I think it might be even nicer to get rid of "num" entirely and convert 
the cleanup path to for_each_sgtable_sg() for completeness - AFAICS it 
should only need an extra "if (sg_page(sg))..." check in that loop. Then 
"count" could possibly be squashed into its one remaining use as well, 
but maybe it's worth keeping for readability.

Robin.

>   			goto release;
>   		}
>   	} else if (dobj->page) {
> @@ -418,7 +418,7 @@ armada_gem_prime_map_dma_buf(struct dma_buf_attachment *attach,
>   
>   		sg_set_page(sgt->sgl, dobj->page, dobj->obj.size, 0);
>   
> -		if (dma_map_sg(attach->dev, sgt->sgl, sgt->nents, dir) == 0)
> +		if (dma_map_sgtable(attach->dev, sgt, dir, 0))
>   			goto free_table;
>   	} else if (dobj->linear) {
>   		/* Single contiguous physical region - no struct page */
> @@ -449,11 +449,11 @@ static void armada_gem_prime_unmap_dma_buf(struct dma_buf_attachment *attach,
>   	int i;
>   
>   	if (!dobj->linear)
> -		dma_unmap_sg(attach->dev, sgt->sgl, sgt->nents, dir);
> +		dma_unmap_sgtable(attach->dev, sgt, dir, 0);
>   
>   	if (dobj->obj.filp) {
>   		struct scatterlist *sg;
> -		for_each_sg(sgt->sgl, sg, sgt->nents, i)
> +		for_each_sgtable_sg(sgt, sg, i)
>   			put_page(sg_page(sg));
>   	}
>   
> 
