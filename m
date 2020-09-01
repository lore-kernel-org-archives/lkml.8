Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8160C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 04:58:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1CA8208CA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 04:58:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ewhD6ICQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbgIAE6e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 00:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbgIAE6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 00:58:31 -0400
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC9C6C061290
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 21:58:31 -0700 (PDT)
Received: by mail-oo1-xc42.google.com with SMTP id a6so2033996oog.9
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 21:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KPPzOd4S5Oo6nrlND6IQthNcXuqMvh5LHpQP3YI6R7E=;
        b=ewhD6ICQ1SgoLstQajN77CTLdULS5zqw29h2elkj+FHI9pa8i71+BVMpzhUK55smit
         3jBeMp15emblXj28HqSsOsSgGW/dxzOMuwE7RPMBpKTjhkkdBrxnRQyC93Bhne39doZA
         eJ2j+2x8Wqy6LhKXTLO2qn/WBg6JlOeq/DRZJ/MfsR6NzpIEGcrXoKgfUzjvf+SHr4+M
         plydV6o9K36XCe68xzcV1cS6mSQdBWqR2/U4OrfBELAOCgRIdLkjnCWkdStBrov03UMm
         Pt3TpFnNv+w4h+ANHqAy/KhOTUvsymm4StXmKv2fEj2XiEJcayiyMzfvji6NcEwpz/6D
         fOsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KPPzOd4S5Oo6nrlND6IQthNcXuqMvh5LHpQP3YI6R7E=;
        b=Bcmq5QpTOb+Cb7Jp9hihrnLRo5ryqj2WvIC3EN86aGGdevPygGSrQifa8eP8UFtYlH
         45E6aoFhMvnslppFL7BZiYh0QjMPn9owDLay9NW/EVSS5gv3tBokSyqS/YMSgQLfxj9r
         Md1MeC9INhOynr0IPpzPOdYcAHAuLAO/gZYoo+9Uzy+nHbDgN0tfBN9YRHQUKKX5k9o8
         WdTz9LF4QDK0ywyJZFrERDx52YdkZv3Byr3h8C4DeqVwsJpQhMCSl3267bnYUGZVTgeU
         UmJS05Skzz4MWKX++uhEUHukZzPK4zJEPezgXJCvqXO+6Lf6IaQ801FYvH2c/qH3+X8t
         iOvA==
X-Gm-Message-State: AOAM532CkypV3POCpnz9JoV9z7ryFO9V5KQLDCit44lVcUrMLLj57hLp
        UBHnN6B0GvhcZgyOmk1ghvx1/A==
X-Google-Smtp-Source: ABdhPJxrPBozUfI+nlt0nkFZ4l7dT06KTI3ftv7H/ltBoqgGY1jMGlNRVE8cvXIGCulF5qGLIxFSxw==
X-Received: by 2002:a4a:9622:: with SMTP id q31mr3138001ooi.78.1598936311137;
        Mon, 31 Aug 2020 21:58:31 -0700 (PDT)
Received: from yoga ([2605:6000:e5cb:c100:8898:14ff:fe6d:34e])
        by smtp.gmail.com with ESMTPSA id 126sm31576oof.28.2020.08.31.21.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 21:58:30 -0700 (PDT)
Date:   Mon, 31 Aug 2020 23:58:27 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
        linux-arm-msm@vger.kernel.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Will Deacon <will@kernel.org>, freedreno@lists.freedesktop.org,
        Sibi Sankar <sibis@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel@lists.infradead.org,
        Rob Clark <robdclark@chromium.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Shawn Guo <shawn.guo@linaro.org>,
        Sharat Masetty <smasetty@codeaurora.org>,
        AngeloGioacchino Del Regno <kholk11@gmail.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 07/19] drm/msm: set adreno_smmu as gpu's drvdata
Message-ID: <20200901045827.GP3715@yoga>
References: <20200810222657.1841322-1-jcrouse@codeaurora.org>
 <20200814024114.1177553-8-robdclark@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200814024114.1177553-8-robdclark@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 13 Aug 21:41 CDT 2020, Rob Clark wrote:

> From: Rob Clark <robdclark@chromium.org>
> 
> This will be populated by adreno-smmu, to provide a way for coordinating
> enabling/disabling TTBR0 translation.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>  drivers/gpu/drm/msm/adreno/adreno_device.c | 2 --
>  drivers/gpu/drm/msm/msm_gpu.c              | 2 +-
>  drivers/gpu/drm/msm/msm_gpu.h              | 6 +++++-
>  3 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
> index 26664e1b30c0..58e03b20e1c7 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_device.c
> +++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
> @@ -417,8 +417,6 @@ static int adreno_bind(struct device *dev, struct device *master, void *data)
>  		return PTR_ERR(gpu);
>  	}
>  
> -	dev_set_drvdata(dev, gpu);
> -
>  	return 0;
>  }
>  
> diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
> index 6aa9e04e52e7..806eb0957280 100644
> --- a/drivers/gpu/drm/msm/msm_gpu.c
> +++ b/drivers/gpu/drm/msm/msm_gpu.c
> @@ -892,7 +892,7 @@ int msm_gpu_init(struct drm_device *drm, struct platform_device *pdev,
>  		gpu->gpu_cx = NULL;
>  
>  	gpu->pdev = pdev;
> -	platform_set_drvdata(pdev, gpu);
> +	platform_set_drvdata(pdev, &gpu->adreno_smmu);
>  
>  	msm_devfreq_init(gpu);
>  
> diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
> index 8bda7beaed4b..f91b141add75 100644
> --- a/drivers/gpu/drm/msm/msm_gpu.h
> +++ b/drivers/gpu/drm/msm/msm_gpu.h
> @@ -7,6 +7,7 @@
>  #ifndef __MSM_GPU_H__
>  #define __MSM_GPU_H__
>  
> +#include <linux/adreno-smmu-priv.h>
>  #include <linux/clk.h>
>  #include <linux/interconnect.h>
>  #include <linux/pm_opp.h>
> @@ -73,6 +74,8 @@ struct msm_gpu {
>  	struct platform_device *pdev;
>  	const struct msm_gpu_funcs *funcs;
>  
> +	struct adreno_smmu_priv adreno_smmu;
> +
>  	/* performance counters (hw & sw): */
>  	spinlock_t perf_lock;
>  	bool perfcntr_active;
> @@ -143,7 +146,8 @@ struct msm_gpu {
>  
>  static inline struct msm_gpu *dev_to_gpu(struct device *dev)
>  {
> -	return dev_get_drvdata(dev);
> +	struct adreno_smmu_priv *adreno_smmu = dev_get_drvdata(dev);
> +	return container_of(adreno_smmu, struct msm_gpu, adreno_smmu);
>  }
>  
>  /* It turns out that all targets use the same ringbuffer size */
> -- 
> 2.26.2
> 
