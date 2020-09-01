Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E81BC433E7
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 19:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BD51206EB
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 19:34:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729180AbgIATee (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 15:34:34 -0400
Received: from foss.arm.com ([217.140.110.172]:48954 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728217AbgIATed (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 15:34:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 63F041FB;
        Tue,  1 Sep 2020 12:34:32 -0700 (PDT)
Received: from [10.57.40.122] (unknown [10.57.40.122])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D91FB3F71F;
        Tue,  1 Sep 2020 12:34:29 -0700 (PDT)
Subject: Re: [PATCH v9 16/32] drm: rockchip: use common helper for a
 scatterlist contiguity check
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org
References: <20200826063316.23486-1-m.szyprowski@samsung.com>
 <CGME20200826063537eucas1p1462d4761c8eb6d762fe5ea0fbd3b6e3b@eucas1p1.samsung.com>
 <20200826063316.23486-17-m.szyprowski@samsung.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <263143f0-8b39-6daa-1d26-54ef32b54c27@arm.com>
Date:   Tue, 1 Sep 2020 20:34:28 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200826063316.23486-17-m.szyprowski@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-08-26 07:33, Marek Szyprowski wrote:
> Use common helper for checking the contiguity of the imported dma-buf.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>   drivers/gpu/drm/rockchip/rockchip_drm_gem.c | 19 +------------------
>   1 file changed, 1 insertion(+), 18 deletions(-)
> 
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
> index b9275ba7c5a5..2970e534e2bb 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
> @@ -460,23 +460,6 @@ struct sg_table *rockchip_gem_prime_get_sg_table(struct drm_gem_object *obj)
>   	return sgt;
>   }
>   
> -static unsigned long rockchip_sg_get_contiguous_size(struct sg_table *sgt,
> -						     int count)
> -{
> -	struct scatterlist *s;
> -	dma_addr_t expected = sg_dma_address(sgt->sgl);
> -	unsigned int i;
> -	unsigned long size = 0;
> -
> -	for_each_sg(sgt->sgl, s, count, i) {
> -		if (sg_dma_address(s) != expected)
> -			break;
> -		expected = sg_dma_address(s) + sg_dma_len(s);
> -		size += sg_dma_len(s);
> -	}
> -	return size;
> -}
> -
>   static int
>   rockchip_gem_iommu_map_sg(struct drm_device *drm,
>   			  struct dma_buf_attachment *attach,
> @@ -498,7 +481,7 @@ rockchip_gem_dma_map_sg(struct drm_device *drm,
>   	if (!count)
>   		return -EINVAL;
>   
> -	if (rockchip_sg_get_contiguous_size(sg, count) < attach->dmabuf->size) {
> +	if (drm_prime_get_contiguous_size(sg) < attach->dmabuf->size) {
>   		DRM_ERROR("failed to map sg_table to contiguous linear address.\n");
>   		dma_unmap_sg(drm->dev, sg->sgl, sg->nents,
>   			     DMA_BIDIRECTIONAL);
> 
