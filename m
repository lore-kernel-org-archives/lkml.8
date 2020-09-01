Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2281AC433E7
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 18:44:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1279020767
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 18:44:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730566AbgIASom (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 14:44:42 -0400
Received: from foss.arm.com ([217.140.110.172]:48240 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726102AbgIASol (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 14:44:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9AAB81FB;
        Tue,  1 Sep 2020 11:44:40 -0700 (PDT)
Received: from [10.57.40.122] (unknown [10.57.40.122])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 82E493F71F;
        Tue,  1 Sep 2020 11:44:36 -0700 (PDT)
Subject: Re: [PATCH v9 10/32] drm: mediatek: use common helper for a
 scatterlist contiguity check
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-mediatek@lists.infradead.org
References: <20200826063316.23486-1-m.szyprowski@samsung.com>
 <CGME20200826063533eucas1p1fad2f2afb117b026081468d2d840ab0f@eucas1p1.samsung.com>
 <20200826063316.23486-11-m.szyprowski@samsung.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <0fda65b1-1755-9e18-7c84-3156f5124752@arm.com>
Date:   Tue, 1 Sep 2020 19:44:34 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200826063316.23486-11-m.szyprowski@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-08-26 07:32, Marek Szyprowski wrote:
> Use common helper for checking the contiguity of the imported dma-buf and
> do this check before allocating resources, so the error path is simpler.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>   drivers/gpu/drm/mediatek/mtk_drm_gem.c | 28 ++++++--------------------
>   1 file changed, 6 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_gem.c b/drivers/gpu/drm/mediatek/mtk_drm_gem.c
> index 6190cc3b7b0d..3654ec732029 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_gem.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_gem.c
> @@ -212,37 +212,21 @@ struct drm_gem_object *mtk_gem_prime_import_sg_table(struct drm_device *dev,
>   			struct dma_buf_attachment *attach, struct sg_table *sg)
>   {
>   	struct mtk_drm_gem_obj *mtk_gem;
> -	int ret;
> -	struct scatterlist *s;
> -	unsigned int i;
> -	dma_addr_t expected;
>   
> -	mtk_gem = mtk_drm_gem_init(dev, attach->dmabuf->size);
> +	/* check if the entries in the sg_table are contiguous */
> +	if (drm_prime_get_contiguous_size(sg) < attach->dmabuf->size) {
> +		DRM_ERROR("sg_table is not contiguous");
> +		return ERR_PTR(-EINVAL);
> +	}
>   
> +	mtk_gem = mtk_drm_gem_init(dev, attach->dmabuf->size);
>   	if (IS_ERR(mtk_gem))
>   		return ERR_CAST(mtk_gem);
>   
> -	expected = sg_dma_address(sg->sgl);
> -	for_each_sg(sg->sgl, s, sg->nents, i) {
> -		if (!sg_dma_len(s))
> -			break;
> -
> -		if (sg_dma_address(s) != expected) {
> -			DRM_ERROR("sg_table is not contiguous");
> -			ret = -EINVAL;
> -			goto err_gem_free;
> -		}
> -		expected = sg_dma_address(s) + sg_dma_len(s);
> -	}
> -
>   	mtk_gem->dma_addr = sg_dma_address(sg->sgl);
>   	mtk_gem->sg = sg;
>   
>   	return &mtk_gem->base;
> -
> -err_gem_free:
> -	kfree(mtk_gem);
> -	return ERR_PTR(ret);
>   }
>   
>   void *mtk_drm_gem_prime_vmap(struct drm_gem_object *obj)
> 
