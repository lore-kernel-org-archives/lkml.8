Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6CC1C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 16:08:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8971320776
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 16:08:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728624AbgFRQIa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 12:08:30 -0400
Received: from foss.arm.com ([217.140.110.172]:54178 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726981AbgFRQIa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 12:08:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 68354101E;
        Thu, 18 Jun 2020 09:08:29 -0700 (PDT)
Received: from [10.57.9.128] (unknown [10.57.9.128])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6E6CF3F6CF;
        Thu, 18 Jun 2020 09:08:22 -0700 (PDT)
Subject: Re: [PATCH v6 01/36] drm: prime: add common helper to check
 scatterlist contiguity
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
References: <20200618153956.29558-1-m.szyprowski@samsung.com>
 <CGME20200618154014eucas1p12812b08c65f53bb216f8ac8751a309de@eucas1p1.samsung.com>
 <20200618153956.29558-2-m.szyprowski@samsung.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <968a920c-83b7-a0e5-8d0d-fa8486816b01@arm.com>
Date:   Thu, 18 Jun 2020 17:07:46 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200618153956.29558-2-m.szyprowski@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-06-18 16:39, Marek Szyprowski wrote:
> It is a common operation done by DRM drivers to check the contiguity
> of the DMA-mapped buffer described by a scatterlist in the
> sg_table object. Let's add a common helper for this operation.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>   drivers/gpu/drm/drm_gem_cma_helper.c | 23 +++--------------------
>   drivers/gpu/drm/drm_prime.c          | 26 ++++++++++++++++++++++++++
>   include/drm/drm_prime.h              |  2 ++
>   3 files changed, 31 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_gem_cma_helper.c b/drivers/gpu/drm/drm_gem_cma_helper.c
> index 06a5b9ee1fe0..41566a15dabd 100644
> --- a/drivers/gpu/drm/drm_gem_cma_helper.c
> +++ b/drivers/gpu/drm/drm_gem_cma_helper.c
> @@ -471,26 +471,9 @@ drm_gem_cma_prime_import_sg_table(struct drm_device *dev,
>   {
>   	struct drm_gem_cma_object *cma_obj;
>   
> -	if (sgt->nents != 1) {
> -		/* check if the entries in the sg_table are contiguous */
> -		dma_addr_t next_addr = sg_dma_address(sgt->sgl);
> -		struct scatterlist *s;
> -		unsigned int i;
> -
> -		for_each_sg(sgt->sgl, s, sgt->nents, i) {
> -			/*
> -			 * sg_dma_address(s) is only valid for entries
> -			 * that have sg_dma_len(s) != 0
> -			 */
> -			if (!sg_dma_len(s))
> -				continue;
> -
> -			if (sg_dma_address(s) != next_addr)
> -				return ERR_PTR(-EINVAL);
> -
> -			next_addr = sg_dma_address(s) + sg_dma_len(s);
> -		}
> -	}
> +	/* check if the entries in the sg_table are contiguous */
> +	if (drm_prime_get_contiguous_size(sgt) < attach->dmabuf->size)
> +		return ERR_PTR(-EINVAL);
>   
>   	/* Create a CMA GEM buffer. */
>   	cma_obj = __drm_gem_cma_create(dev, attach->dmabuf->size);
> diff --git a/drivers/gpu/drm/drm_prime.c b/drivers/gpu/drm/drm_prime.c
> index bbfc713bfdc3..0784969894c1 100644
> --- a/drivers/gpu/drm/drm_prime.c
> +++ b/drivers/gpu/drm/drm_prime.c
> @@ -825,6 +825,32 @@ struct sg_table *drm_prime_pages_to_sg(struct page **pages, unsigned int nr_page
>   }
>   EXPORT_SYMBOL(drm_prime_pages_to_sg);
>   
> +/**
> + * drm_prime_get_contiguous_size - returns the contiguous size of the buffer
> + * @sgt: sg_table describing the buffer to check
> + *
> + * This helper calculates the contiguous size in the DMA address space
> + * of the the buffer described by the provided sg_table.
> + *
> + * This is useful for implementing
> + * &drm_gem_object_funcs.gem_prime_import_sg_table.
> + */
> +unsigned long drm_prime_get_contiguous_size(struct sg_table *sgt)
> +{
> +	dma_addr_t expected = sg_dma_address(sgt->sgl);
> +	struct sg_dma_page_iter dma_iter;
> +	unsigned long size = 0;
> +
> +	for_each_sgtable_dma_page(sgt, &dma_iter, 0) {
> +		if (sg_page_iter_dma_address(&dma_iter) != expected)
> +			break;
> +		expected += PAGE_SIZE;
> +		size += PAGE_SIZE;

Hmm, in many cases this is likely to be far less efficient than simply 
using for_each_sgtable_dma() and sg_dma_len() equivalent to the original 
implementation, and there doesn't seem to be any good reason for that. 
Plus AFAICS it could potentially let false-positives through if someone 
were to pass in a table with non-page-aligned lengths (I assume that's 
expected never to happen, but still...)

Robin.

> +	}
> +	return size;
> +}
> +EXPORT_SYMBOL(drm_prime_get_contiguous_size);
> +
>   /**
>    * drm_gem_prime_export - helper library implementation of the export callback
>    * @obj: GEM object to export
> diff --git a/include/drm/drm_prime.h b/include/drm/drm_prime.h
> index 9af7422b44cf..47ef11614627 100644
> --- a/include/drm/drm_prime.h
> +++ b/include/drm/drm_prime.h
> @@ -92,6 +92,8 @@ struct sg_table *drm_prime_pages_to_sg(struct page **pages, unsigned int nr_page
>   struct dma_buf *drm_gem_prime_export(struct drm_gem_object *obj,
>   				     int flags);
>   
> +unsigned long drm_prime_get_contiguous_size(struct sg_table *sgt);
> +
>   /* helper functions for importing */
>   struct drm_gem_object *drm_gem_prime_import_dev(struct drm_device *dev,
>   						struct dma_buf *dma_buf,
> 
