Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BC2FCA90AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 13:24:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9ED48204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 13:24:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733104AbgEMNYc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 09:24:32 -0400
Received: from foss.arm.com ([217.140.110.172]:45904 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726001AbgEMNYc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 09:24:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4D34C30E;
        Wed, 13 May 2020 06:24:31 -0700 (PDT)
Received: from [10.57.36.85] (unknown [10.57.36.85])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9C35C3F71E;
        Wed, 13 May 2020 06:24:27 -0700 (PDT)
Subject: Re: [PATCH v4 02/38] scatterlist: add generic wrappers for iterating
 over sgtable objects
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
References: <20200512085710.14688-1-m.szyprowski@samsung.com>
 <20200512090058.14910-1-m.szyprowski@samsung.com>
 <CGME20200512090108eucas1p10a3571be3f60265daea3b3f1469b5e82@eucas1p1.samsung.com>
 <20200512090058.14910-2-m.szyprowski@samsung.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <4f9f747a-9bce-90f4-9ca7-ab851f29d758@arm.com>
Date:   Wed, 13 May 2020 14:24:25 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200512090058.14910-2-m.szyprowski@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-05-12 10:00 am, Marek Szyprowski wrote:
> struct sg_table is a common structure used for describing a memory
> buffer. It consists of a scatterlist with memory pages and DMA addresses
> (sgl entry), as well as the number of scatterlist entries: CPU pages
> (orig_nents entry) and DMA mapped pages (nents entry).
> 
> It turned out that it was a common mistake to misuse nents and orig_nents
> entries, calling the scatterlist iterating functions with a wrong number
> of the entries.
> 
> To avoid such issues, lets introduce a common wrappers operating directly
> on the struct sg_table objects, which take care of the proper use of
> the nents and orig_nents entries.
> 
> While touching this, lets clarify some ambiguities in the comments for
> the existing for_each helpers.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
> For more information, see '[PATCH v4 00/38] DRM: fix struct sg_table nents
> vs. orig_nents misuse' thread:
> https://lore.kernel.org/dri-devel/20200512085710.14688-1-m.szyprowski@samsung.com/T/
> ---
>   include/linux/scatterlist.h | 50 ++++++++++++++++++++++++++++++++++++++++++---
>   1 file changed, 47 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/scatterlist.h b/include/linux/scatterlist.h
> index 6eec50f..4f922af 100644
> --- a/include/linux/scatterlist.h
> +++ b/include/linux/scatterlist.h
> @@ -151,6 +151,20 @@ static inline void sg_set_buf(struct scatterlist *sg, const void *buf,
>   #define for_each_sg(sglist, sg, nr, __i)	\
>   	for (__i = 0, sg = (sglist); __i < (nr); __i++, sg = sg_next(sg))
>   
> +/*
> + * Loop over each sg element in the given sg_table object.
> + */
> +#define for_each_sgtable_sg(sgt, sg, i)		\
> +	for_each_sg(sgt->sgl, sg, sgt->orig_nents, i)
> +
> +/*
> + * Loop over each sg element in the given *DMA mapped* sg_table object.
> + * Please use sg_dma_address(sg) and sg_dma_len(sg) to extract DMA addresses
> + * of the each element.
> + */
> +#define for_each_sgtable_dma_sg(sgt, sg, i)	\
> +	for_each_sg(sgt->sgl, sg, sgt->nents, i)
> +
>   /**
>    * sg_chain - Chain two sglists together
>    * @prv:	First scatterlist
> @@ -401,9 +415,10 @@ static inline struct page *sg_page_iter_page(struct sg_page_iter *piter)
>    * @sglist:	sglist to iterate over
>    * @piter:	page iterator to hold current page, sg, sg_pgoffset
>    * @nents:	maximum number of sg entries to iterate over
> - * @pgoffset:	starting page offset
> + * @pgoffset:	starting page offset (in pages)
>    *
>    * Callers may use sg_page_iter_page() to get each page pointer.
> + * In each loop it operates on PAGE_SIZE unit.
>    */
>   #define for_each_sg_page(sglist, piter, nents, pgoffset)		   \
>   	for (__sg_page_iter_start((piter), (sglist), (nents), (pgoffset)); \
> @@ -412,18 +427,47 @@ static inline struct page *sg_page_iter_page(struct sg_page_iter *piter)
>   /**
>    * for_each_sg_dma_page - iterate over the pages of the given sg list
>    * @sglist:	sglist to iterate over
> - * @dma_iter:	page iterator to hold current page
> + * @dma_iter:	DMA page iterator to hold current page
>    * @dma_nents:	maximum number of sg entries to iterate over, this is the value
>    *              returned from dma_map_sg
> - * @pgoffset:	starting page offset
> + * @pgoffset:	starting page offset (in pages)
>    *
>    * Callers may use sg_page_iter_dma_address() to get each page's DMA address.
> + * In each loop it operates on PAGE_SIZE unit.
>    */
>   #define for_each_sg_dma_page(sglist, dma_iter, dma_nents, pgoffset)            \
>   	for (__sg_page_iter_start(&(dma_iter)->base, sglist, dma_nents,        \
>   				  pgoffset);                                   \
>   	     __sg_page_iter_dma_next(dma_iter);)
>   
> +/**
> + * for_each_sgtable_page - iterate over all pages in the sg_table object
> + * @sgt:	sg_table object to iterate over
> + * @piter:	page iterator to hold current page
> + * @pgoffset:	starting page offset (in pages)
> + *
> + * Iterates over the all memory pages in the buffer described by
> + * a scatterlist stored in the given sg_table object.
> + * See also for_each_sg_page(). In each loop it operates on PAGE_SIZE unit.
> + */
> +#define for_each_sgtable_page(sgt, piter, pgoffset)	\
> +	for_each_sg_page(sgt->sgl, piter, sgt->orig_nents, pgoffset)
> +
> +/**
> + * for_each_sgtable_dma_page - iterate over the DMA mapped sg_table object
> + * @sgt:	sg_table object to iterate over
> + * @dma_iter:	DMA page iterator to hold current page
> + * @pgoffset:	starting page offset (in pages)
> + *
> + * Iterates over the all DMA mapped pages in the buffer described by
> + * a scatterlist stored in the given sg_table object.
> + * See also for_each_sg_dma_page(). In each loop it operates on PAGE_SIZE
> + * unit.
> + */
> +#define for_each_sgtable_dma_page(sgt, dma_iter, pgoffset)	\
> +	for_each_sg_dma_page(sgt->sgl, dma_iter, sgt->nents, pgoffset)
> +
> +
>   /*
>    * Mapping sg iterator
>    *
> 
