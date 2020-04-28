Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3CE3C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 15:14:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4DA7206D7
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 15:14:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KlHwcr3g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728112AbgD1POp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 11:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727108AbgD1POo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 11:14:44 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DFDBC03C1AB
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 08:14:44 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id e26so3195379wmk.5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 08:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=l31iHzi+Qs0wCkNpZUkmQ43l/0Uer53q54jbPNk9/tA=;
        b=KlHwcr3gTyxBlExVYMYEDezxp2MypKFK+c6Ao/6WCZFEdvxM87IzFhahTJWpvBuNZM
         cFsfktXWaoRij0YPRZs+CfSAAapta3x5PTjTct9nKzkeYlY/uKwbfbgFnN7gjjy2NYs8
         oeXIVDldzCGpa4IeFQvUz5qM0thtnyU+gBnAqzy88i4+rnZ7PFIvhnjWZjEFzSIO0kbL
         p0p19jj+iD6Xh5Tg8gXjuda6JrLj+r8F56iRtpn0tm/B5pquPdIB0hA4jaipWC68ssNv
         HlJNAQ+DAB1ZQ2u1gjAfaSG5//xbPSnz+CTuBZi+htDjig8onvuhS9nFWJ1tLfXTRyp2
         zKtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=l31iHzi+Qs0wCkNpZUkmQ43l/0Uer53q54jbPNk9/tA=;
        b=J8F8EFx4eepUYN08pmmaVG90OuHqDx+bVRAu8twd3Wq4IJZFPfDH+wKqkIQnDQFSGB
         d1pVYYmA8NWol7Sbe5/CCYGhELBR0ErMOPSkUnpkNv1zMZa6Abgr3Qx3I2oNIqi+VQ/T
         IwnPHll+7ECzHUCK5l+0lRNmnSg3s1xFTD3p3NQhGfGnWj/2tUg/J1e0ZuyePkX0rEF8
         mPT4lWiN48IK1AOa5f6NQEkIFXcuMwx5pX8FsT2wTHWTa+rTyiyv1H5qt3r/ePNhb56P
         nSfhu4rjlvMVeCmdFLciL2qSZiIZWMDkpyl6tWYxhhPfGd/13A4uDT45/F0jb5g7rTKT
         459g==
X-Gm-Message-State: AGi0PubqKvNaSSxtkdKUnaQ9Miogy36OBHRgs9tK+FfQ2pTT3EjBCswZ
        KXMUvflolQtKSCkPha1xdxg=
X-Google-Smtp-Source: APiQypL8H3EcxyO7rOvNQpM8a9StjgW5VyI7nmqOUuAgjrQlknQi+ypDm7LmhWDvCqyCCbM8wblpgQ==
X-Received: by 2002:a1c:7715:: with SMTP id t21mr4857338wmi.182.1588086882730;
        Tue, 28 Apr 2020 08:14:42 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7? ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
        by smtp.gmail.com with ESMTPSA id s8sm25807970wru.38.2020.04.28.08.14.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Apr 2020 08:14:42 -0700 (PDT)
Reply-To: christian.koenig@amd.com
Subject: Re: [RFC 02/17] drm: amdgpu: fix sg_table nents vs. orig_nents misuse
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        David Airlie <airlied@linux.ie>,
        intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        Christoph Hellwig <hch@lst.de>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        linux-arm-kernel@lists.infradead.org
References: <20200428132005.21424-1-m.szyprowski@samsung.com>
 <CGME20200428132023eucas1p2a1993145eef91506698aa8c9750a7e43@eucas1p2.samsung.com>
 <20200428132005.21424-3-m.szyprowski@samsung.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <c462d1f0-8daa-76bb-a7fd-5e0d687975d5@gmail.com>
Date:   Tue, 28 Apr 2020 17:14:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200428132005.21424-3-m.szyprowski@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 28.04.20 um 15:19 schrieb Marek Szyprowski:
> The Documentation/DMA-API-HOWTO.txt states that dma_map_sg returns the
> numer of the created entries in the DMA address space. However the
> subsequent calls to dma_sync_sg_for_{device,cpu} and dma_unmap_sg must be
> called with the original number of entries passed to dma_map_sg. The
> sg_table->nents in turn holds the result of the dma_map_sg call as stated
> in include/linux/scatterlist.h. Adapt the code to obey those rules.
>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 7 ++++---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c     | 8 ++++----
>   2 files changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> index 43d8ed7..4df813e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> @@ -307,8 +307,9 @@ static struct sg_table *amdgpu_dma_buf_map(struct dma_buf_attachment *attach,
>   		if (IS_ERR(sgt))
>   			return sgt;
>   
> -		if (!dma_map_sg_attrs(attach->dev, sgt->sgl, sgt->nents, dir,
> -				      DMA_ATTR_SKIP_CPU_SYNC))
> +		sgt->nents = dma_map_sg_attrs(attach->dev, sgt->sgl, sgt->orig_nents,
> +					      dir, DMA_ATTR_SKIP_CPU_SYNC);
> +		if (!sgt->nents)
>   			goto error_free;
>   		break;
>   
> @@ -349,7 +350,7 @@ static void amdgpu_dma_buf_unmap(struct dma_buf_attachment *attach,
>   	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
>   
>   	if (sgt->sgl->page_link) {
> -		dma_unmap_sg(attach->dev, sgt->sgl, sgt->nents, dir);
> +		dma_unmap_sg(attach->dev, sgt->sgl, sgt->orig_nents, dir);
>   		sg_free_table(sgt);
>   		kfree(sgt);
>   	} else {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index d5543c2..5f31585 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -1043,7 +1043,6 @@ static int amdgpu_ttm_tt_pin_userptr(struct ttm_tt *ttm)
>   {
>   	struct amdgpu_device *adev = amdgpu_ttm_adev(ttm->bdev);
>   	struct amdgpu_ttm_tt *gtt = (void *)ttm;
> -	unsigned nents;
>   	int r;
>   
>   	int write = !(gtt->userflags & AMDGPU_GEM_USERPTR_READONLY);
> @@ -1059,8 +1058,9 @@ static int amdgpu_ttm_tt_pin_userptr(struct ttm_tt *ttm)
>   
>   	/* Map SG to device */
>   	r = -ENOMEM;
> -	nents = dma_map_sg(adev->dev, ttm->sg->sgl, ttm->sg->nents, direction);
> -	if (nents == 0)
> +	ttm->sg->nents = dma_map_sg(adev->dev, ttm->sg->sgl,
> +				    ttm->sg->orig_nents, direction);
> +	if (ttm->sg->nents == 0)
>   		goto release_sg;
>   
>   	/* convert SG to linear array of pages and dma addresses */
> @@ -1091,7 +1091,7 @@ static void amdgpu_ttm_tt_unpin_userptr(struct ttm_tt *ttm)
>   		return;
>   
>   	/* unmap the pages mapped to the device */
> -	dma_unmap_sg(adev->dev, ttm->sg->sgl, ttm->sg->nents, direction);
> +	dma_unmap_sg(adev->dev, ttm->sg->sgl, ttm->sg->orig_nents, direction);
>   
>   	sg_free_table(ttm->sg);
>   

