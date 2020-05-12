Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6585C54E4A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 12:18:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9658B206CC
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 12:18:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729676AbgELMSa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 08:18:30 -0400
Received: from verein.lst.de ([213.95.11.211]:40890 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729437AbgELMSM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 08:18:12 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8F23F68BEB; Tue, 12 May 2020 14:18:08 +0200 (CEST)
Date:   Tue, 12 May 2020 14:18:08 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v4 01/38] dma-mapping: add generic helpers for mapping
 sgtable objects
Message-ID: <20200512121808.GA20393@lst.de>
References: <20200512085710.14688-1-m.szyprowski@samsung.com> <CGME20200512090107eucas1p13a38ce5ce4c15cd0033acaea7b26c9b0@eucas1p1.samsung.com> <20200512090058.14910-1-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200512090058.14910-1-m.szyprowski@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 12, 2020 at 11:00:21AM +0200, Marek Szyprowski wrote:
> struct sg_table is a common structure used for describing a memory
> buffer. It consists of a scatterlist with memory pages and DMA addresses
> (sgl entry), as well as the number of scatterlist entries: CPU pages
> (orig_nents entry) and DMA mapped pages (nents entry).
> 
> It turned out that it was a common mistake to misuse nents and orig_nents
> entries, calling DMA-mapping functions with a wrong number of entries or
> ignoring the number of mapped entries returned by the dma_map_sg
> function.
> 
> To avoid such issues, lets introduce a common wrappers operating directly
> on the struct sg_table objects, which take care of the proper use of
> the nents and orig_nents entries.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
> For more information, see '[PATCH v4 00/38] DRM: fix struct sg_table nents
> vs. orig_nents misuse' thread:
> https://lore.kernel.org/dri-devel/20200512085710.14688-1-m.szyprowski@samsung.com/T/
> ---
>  include/linux/dma-mapping.h | 79 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 79 insertions(+)
> 
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index b43116a..88f01cc 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -609,6 +609,85 @@ static inline void dma_sync_single_range_for_device(struct device *dev,
>  	return dma_sync_single_for_device(dev, addr + offset, size, dir);
>  }
>  
> +/**
> + * dma_map_sgtable - Map the given buffer for the DMA operations
> + * @dev:	The device to perform a DMA operation
> + * @sgt:	The sg_table object describing the buffer
> + * @dir:	DMA direction
> + * @attrs:	Optional DMA attributes for the map operation
> + *
> + * Maps a buffer described by a scatterlist stored in the given sg_table
> + * object for the @dir DMA operation by the @dev device. After success
> + * the ownership for the buffer is transferred to the DMA domain. One has
> + * to call dma_sync_sgtable_for_cpu() or dma_unmap_sgtable() to move the
> + * ownership of the buffer back to the CPU domain before touching the
> + * buffer by the CPU.
> + * Returns 0 on success or -EINVAL on error during mapping the buffer.
> + */
> +static inline int dma_map_sgtable(struct device *dev, struct sg_table *sgt,
> +		enum dma_data_direction dir, unsigned long attrs)
> +{
> +	int n = dma_map_sg_attrs(dev, sgt->sgl, sgt->orig_nents, dir, attrs);
> +
> +	if (n > 0) {
> +		sgt->nents = n;
> +		return 0;
> +	}
> +	return -EINVAL;

Nit:  code tend to be a tad easier to read if the the exceptional
condition is inside the branch block, so:

	if (n <= 0)
		return -EINVAL;
	sgt->nents = n;
	return 0;

Otherwise this looks good to me:

Reviewed-by: Christoph Hellwig <hch@lst.de>
