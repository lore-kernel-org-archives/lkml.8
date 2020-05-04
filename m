Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A75C47257
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 13:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCC182073E
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 13:28:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728085AbgEDN2C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 09:28:02 -0400
Received: from foss.arm.com ([217.140.110.172]:44816 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727104AbgEDN2B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 09:28:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C61241FB;
        Mon,  4 May 2020 06:28:00 -0700 (PDT)
Received: from [192.168.1.84] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D88F43F71F;
        Mon,  4 May 2020 06:27:57 -0700 (PDT)
Subject: Re: [PATCH v2 09/21] drm: panfrost: fix sg_table nents vs. orig_nents
 misuse
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Robin Murphy <Robin.Murphy@arm.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
References: <20200504125017.5494-1-m.szyprowski@samsung.com>
 <20200504125359.5678-1-m.szyprowski@samsung.com>
 <CGME20200504125415eucas1p1eea125ce87eec4e7c2e2dcc75f965896@eucas1p1.samsung.com>
 <20200504125359.5678-9-m.szyprowski@samsung.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <607fc87f-eb1c-6362-d8ff-3ac6ccf31bdf@arm.com>
Date:   Mon, 4 May 2020 14:27:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200504125359.5678-9-m.szyprowski@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/05/2020 13:53, Marek Szyprowski wrote:
> The Documentation/DMA-API-HOWTO.txt states that dma_map_sg returns the
> numer of the created entries in the DMA address space. However the
> subsequent calls to dma_sync_sg_for_{device,cpu} and dma_unmap_sg must be
> called with the original number of entries passed to dma_map_sg. The
> sg_table->nents in turn holds the result of the dma_map_sg call as stated
> in include/linux/scatterlist.h. Adapt the code to obey those rules.

I find this commit message a bit confusing, but AFAICT the problem with 
the Panfrost code is really in mmu_map_sg() where we don't have the 
return value from dma_map_sg() and the for_each_sg() loop could (in 
theory) run off the end of the list.

The fix seems correct - store the return where it's meant to be (nents) 
and make sure when unmapping we use the original (orig_nents). So you 
might also consider adding:

Fixes: f3ba91228e8e ("drm/panfrost: Add initial panfrost driver")

Even better would be the wrappers you mention in the cover letter! ;)

Reviewed-by: Steven Price <steven.price@arm.com>

> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
> For more information, see '[PATCH v2 00/21] DRM: fix struct sg_table nents
> vs. orig_nents misuse' thread: https://lkml.org/lkml/2020/5/4/373
> ---
>   drivers/gpu/drm/panfrost/panfrost_gem.c | 3 ++-
>   drivers/gpu/drm/panfrost/panfrost_mmu.c | 4 +++-
>   2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_gem.c b/drivers/gpu/drm/panfrost/panfrost_gem.c
> index 17b654e..22fec7c 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_gem.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_gem.c
> @@ -42,7 +42,8 @@ static void panfrost_gem_free_object(struct drm_gem_object *obj)
>   		for (i = 0; i < n_sgt; i++) {
>   			if (bo->sgts[i].sgl) {
>   				dma_unmap_sg(pfdev->dev, bo->sgts[i].sgl,
> -					     bo->sgts[i].nents, DMA_BIDIRECTIONAL);
> +					     bo->sgts[i].orig_nents,
> +					     DMA_BIDIRECTIONAL);
>   				sg_free_table(&bo->sgts[i]);
>   			}
>   		}
> diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm/panfrost/panfrost_mmu.c
> index ed28aeb..2d9b1f9 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
> @@ -517,7 +517,9 @@ static int panfrost_mmu_map_fault_addr(struct panfrost_device *pfdev, int as,
>   	if (ret)
>   		goto err_pages;
>   
> -	if (!dma_map_sg(pfdev->dev, sgt->sgl, sgt->nents, DMA_BIDIRECTIONAL)) {
> +	sgt->nents = dma_map_sg(pfdev->dev, sgt->sgl, sgt->orig_nents,
> +				DMA_BIDIRECTIONAL);
> +	if (!sgt->nents) {
>   		ret = -EINVAL;
>   		goto err_map;
>   	}
> 

