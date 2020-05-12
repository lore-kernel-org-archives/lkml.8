Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E00CC47255
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 00:20:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5287E206D6
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 00:20:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728154AbgELAUb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 20:20:31 -0400
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:24252 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725855AbgELAUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 20:20:31 -0400
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-001.vmware.com (10.113.208.155) with Microsoft SMTP Server id
 15.0.1156.6; Mon, 11 May 2020 17:19:27 -0700
Received: from [0.0.0.0] (oddjob.vmware.com [10.253.4.32])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id 53A74404D5;
        Mon, 11 May 2020 17:19:26 -0700 (PDT)
Subject: Re: [Linux-graphics-maintainer] [PATCH v3 15/25] drm: vmwgfx: fix
 common struct sg_table related issues
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        <dri-devel@lists.freedesktop.org>,
        <iommu@lists.linux-foundation.org>,
        <linaro-mm-sig@lists.linaro.org>, <linux-kernel@vger.kernel.org>
CC:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Airlie <airlied@linux.ie>,
        VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        <linux-arm-kernel@lists.infradead.org>
References: <20200505083926.28503-1-m.szyprowski@samsung.com>
 <20200505084614.30424-1-m.szyprowski@samsung.com>
 <CGME20200505084632eucas1p231212e9cea88e755da8eaf1fb012d2c6@eucas1p2.samsung.com>
 <20200505084614.30424-15-m.szyprowski@samsung.com>
From:   Roland Scheidegger <sroland@vmware.com>
Message-ID: <8adef36a-1f35-e8df-3b7b-2f994a204be1@vmware.com>
Date:   Tue, 12 May 2020 02:19:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20200505084614.30424-15-m.szyprowski@samsung.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Received-SPF: None (EX13-EDG-OU-001.vmware.com: sroland@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm not exactly an expert on this, but looks alright to me.
Acked-by: Roland Scheidegger <sroland@vmware.com>

Am 05.05.20 um 10:46 schrieb Marek Szyprowski:
> The Documentation/DMA-API-HOWTO.txt states that dma_map_sg returns the
> numer of the created entries in the DMA address space. However the
> subsequent calls to dma_sync_sg_for_{device,cpu} and dma_unmap_sg must be
> called with the original number of the entries passed to dma_map_sg. The
> sg_table->nents in turn holds the result of the dma_map_sg call as stated
> in include/linux/scatterlist.h. A common mistake was to ignore a result
> of the dma_map_sg function and don't use the sg_table->orig_nents at all.
> 
> To avoid such issues, lets use common dma-mapping wrappers operating
> directly on the struct sg_table objects and adjust references to the
> nents and orig_nents respectively.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
> For more information, see '[PATCH v3 00/25] DRM: fix struct sg_table nents
> vs. orig_nents misuse' thread: https://lkml.org/lkml/2020/5/5/187
> ---
>  drivers/gpu/drm/vmwgfx/vmwgfx_ttm_buffer.c | 17 ++++-------------
>  1 file changed, 4 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_ttm_buffer.c b/drivers/gpu/drm/vmwgfx/vmwgfx_ttm_buffer.c
> index bf0bc46..e50ae8b 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_ttm_buffer.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_ttm_buffer.c
> @@ -362,8 +362,7 @@ static void vmw_ttm_unmap_from_dma(struct vmw_ttm_tt *vmw_tt)
>  {
>  	struct device *dev = vmw_tt->dev_priv->dev->dev;
>  
> -	dma_unmap_sg(dev, vmw_tt->sgt.sgl, vmw_tt->sgt.nents,
> -		DMA_BIDIRECTIONAL);
> +	dma_unmap_sgtable(dev, vmw_tt->sgt, DMA_BIDIRECTIONAL);
>  	vmw_tt->sgt.nents = vmw_tt->sgt.orig_nents;
>  }
>  
> @@ -383,16 +382,8 @@ static void vmw_ttm_unmap_from_dma(struct vmw_ttm_tt *vmw_tt)
>  static int vmw_ttm_map_for_dma(struct vmw_ttm_tt *vmw_tt)
>  {
>  	struct device *dev = vmw_tt->dev_priv->dev->dev;
> -	int ret;
> -
> -	ret = dma_map_sg(dev, vmw_tt->sgt.sgl, vmw_tt->sgt.orig_nents,
> -			 DMA_BIDIRECTIONAL);
> -	if (unlikely(ret == 0))
> -		return -ENOMEM;
>  
> -	vmw_tt->sgt.nents = ret;
> -
> -	return 0;
> +	return dma_map_sgtable(dev, vmw_tt->sgt, DMA_BIDIRECTIONAL);
>  }
>  
>  /**
> @@ -449,10 +440,10 @@ static int vmw_ttm_map_dma(struct vmw_ttm_tt *vmw_tt)
>  		if (unlikely(ret != 0))
>  			goto out_sg_alloc_fail;
>  
> -		if (vsgt->num_pages > vmw_tt->sgt.nents) {
> +		if (vsgt->num_pages > vmw_tt->sgt.orig_nents) {
>  			uint64_t over_alloc =
>  				sgl_size * (vsgt->num_pages -
> -					    vmw_tt->sgt.nents);
> +					    vmw_tt->sgt.orig_nents);
>  
>  			ttm_mem_global_free(glob, over_alloc);
>  			vmw_tt->sg_alloc_size -= over_alloc;
> 

