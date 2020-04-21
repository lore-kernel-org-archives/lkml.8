Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06816C54FCC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 16:48:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3FB2206A1
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 16:48:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="hT2rDzyr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbgDUQsV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 12:48:21 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:29996 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725930AbgDUQsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 12:48:21 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1587487699; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=OXhBL5oimC0xxfX2i1rmN7+RusYn9+BsYrXGaYsdBZ4=; b=hT2rDzyrpnKGIl7ofRO39xlNXL/hclcxSzPTrl0rQ+9fUyRL2xWy9c/ZP9MEtG+FGLLmSTbP
 hNeQ9lCwqs4WqCb9HvLRWscYDAdZIVMnK1VK4ajEarNboVomDgRjEcp89wzDnt4T0V59tEIR
 I8XyMpmRnfeTq8NC7B56WCYRkx8=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e9f23d0.7fb15049ece0-smtp-out-n02;
 Tue, 21 Apr 2020 16:48:16 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E5432C433BA; Tue, 21 Apr 2020 16:48:14 +0000 (UTC)
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8E896C433D2;
        Tue, 21 Apr 2020 16:48:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8E896C433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
Date:   Tue, 21 Apr 2020 10:48:11 -0600
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     Jonathan Marek <jonathan@marek.ca>
Cc:     freedreno@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sharat Masetty <smasetty@codeaurora.org>,
        Akhil P Oommen <akhilpo@codeaurora.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 9/9] drm/msm/a6xx: update a6xx_hw_init for A640 and A650
Message-ID: <20200421164810.GD13825@jcrouse1-lnx.qualcomm.com>
Mail-Followup-To: Jonathan Marek <jonathan@marek.ca>,
        freedreno@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sharat Masetty <smasetty@codeaurora.org>,
        Akhil P Oommen <akhilpo@codeaurora.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" <linux-arm-msm@vger.kernel.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200420140313.7263-1-jonathan@marek.ca>
 <20200420140313.7263-10-jonathan@marek.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420140313.7263-10-jonathan@marek.ca>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 20, 2020 at 10:03:13AM -0400, Jonathan Marek wrote:
> Adreno 640 and 650 GPUs need some registers set differently.

> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx.xml.h | 14 +++++++
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 56 ++++++++++++++++++++++-----
>  2 files changed, 61 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx.xml.h b/drivers/gpu/drm/msm/adreno/a6xx.xml.h
> index ed78fee2a262..47840b73cdda 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx.xml.h
> +++ b/drivers/gpu/drm/msm/adreno/a6xx.xml.h
> @@ -1047,6 +1047,8 @@ enum a6xx_tex_type {
>  
>  #define REG_A6XX_CP_MISC_CNTL					0x00000840
>  
> +#define REG_A6XX_CP_APRIV_CNTL					0x00000844
> +
>  #define REG_A6XX_CP_ROQ_THRESHOLDS_1				0x000008c1
>  
>  #define REG_A6XX_CP_ROQ_THRESHOLDS_2				0x000008c2
> @@ -1764,6 +1766,8 @@ static inline uint32_t A6XX_CP_PROTECT_REG_MASK_LEN(uint32_t val)
>  
>  #define REG_A6XX_RBBM_VBIF_CLIENT_QOS_CNTL			0x00000010
>  
> +#define REG_A6XX_RBBM_GBIF_CLIENT_QOS_CNTL			0x00000011
> +
>  #define REG_A6XX_RBBM_INTERFACE_HANG_INT_CNTL			0x0000001f
>  
>  #define REG_A6XX_RBBM_INT_CLEAR_CMD				0x00000037
> @@ -2418,6 +2422,16 @@ static inline uint32_t A6XX_UCHE_CLIENT_PF_PERFSEL(uint32_t val)
>  
>  #define REG_A6XX_TPL1_NC_MODE_CNTL				0x0000b604
>  
> +#define REG_A6XX_TPL1_BICUBIC_WEIGHTS_TABLE_0			0x0000b608
> +
> +#define REG_A6XX_TPL1_BICUBIC_WEIGHTS_TABLE_1			0x0000b609
> +
> +#define REG_A6XX_TPL1_BICUBIC_WEIGHTS_TABLE_2			0x0000b60a
> +
> +#define REG_A6XX_TPL1_BICUBIC_WEIGHTS_TABLE_3			0x0000b60b
> +
> +#define REG_A6XX_TPL1_BICUBIC_WEIGHTS_TABLE_4			0x0000b60c
> +
>  #define REG_A6XX_TPL1_PERFCTR_TP_SEL_0				0x0000b610
>  
>  #define REG_A6XX_TPL1_PERFCTR_TP_SEL_1				0x0000b611
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> index a860d4970e10..e1eb34fa3a99 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> @@ -414,7 +414,17 @@ static int a6xx_hw_init(struct msm_gpu *gpu)
>  		a6xx_set_hwcg(gpu, true);
>  
>  	/* VBIF/GBIF start*/
> -	gpu_write(gpu, REG_A6XX_RBBM_VBIF_CLIENT_QOS_CNTL, 0x3);

Oops, this should have been changed for 618 too.  Only 630 had the VBIF
so you can invert this if statement.

> +	if (adreno_is_a640(adreno_gpu) || adreno_is_a650(adreno_gpu)) {
> +		gpu_write(gpu, REG_A6XX_GBIF_QSB_SIDE0, 0x00071620);
> +		gpu_write(gpu, REG_A6XX_GBIF_QSB_SIDE1, 0x00071620);
> +		gpu_write(gpu, REG_A6XX_GBIF_QSB_SIDE2, 0x00071620);
> +		gpu_write(gpu, REG_A6XX_GBIF_QSB_SIDE3, 0x00071620);
> +		gpu_write(gpu, REG_A6XX_GBIF_QSB_SIDE3, 0x00071620);
> +		gpu_write(gpu, REG_A6XX_RBBM_GBIF_CLIENT_QOS_CNTL, 0x3);
> +	} else {
> +		gpu_write(gpu, REG_A6XX_RBBM_VBIF_CLIENT_QOS_CNTL, 0x3);
> +	}
> +
>  	if (adreno_is_a630(adreno_gpu))
>  		gpu_write(gpu, REG_A6XX_VBIF_GATE_OFF_WRREQ_EN, 0x00000009);
>  
> @@ -429,25 +439,35 @@ static int a6xx_hw_init(struct msm_gpu *gpu)
>  	gpu_write(gpu, REG_A6XX_UCHE_WRITE_THRU_BASE_LO, 0xfffff000);
>  	gpu_write(gpu, REG_A6XX_UCHE_WRITE_THRU_BASE_HI, 0x0001ffff);
>  
> -	/* Set the GMEM VA range [0x100000:0x100000 + gpu->gmem - 1] */
> -	gpu_write64(gpu, REG_A6XX_UCHE_GMEM_RANGE_MIN_LO,
> -		REG_A6XX_UCHE_GMEM_RANGE_MIN_HI, 0x00100000);
> +	if (!adreno_is_a650(adreno_gpu)) {
> +		/* Set the GMEM VA range [0x100000:0x100000 + gpu->gmem - 1] */
> +		gpu_write64(gpu, REG_A6XX_UCHE_GMEM_RANGE_MIN_LO,
> +			REG_A6XX_UCHE_GMEM_RANGE_MIN_HI, 0x00100000);
>  
> -	gpu_write64(gpu, REG_A6XX_UCHE_GMEM_RANGE_MAX_LO,
> -		REG_A6XX_UCHE_GMEM_RANGE_MAX_HI,
> -		0x00100000 + adreno_gpu->gmem - 1);
> +		gpu_write64(gpu, REG_A6XX_UCHE_GMEM_RANGE_MAX_LO,
> +			REG_A6XX_UCHE_GMEM_RANGE_MAX_HI,
> +			0x00100000 + adreno_gpu->gmem - 1);
> +	}
>  
>  	gpu_write(gpu, REG_A6XX_UCHE_FILTER_CNTL, 0x804);
>  	gpu_write(gpu, REG_A6XX_UCHE_CACHE_WAYS, 0x4);
>  
> -	gpu_write(gpu, REG_A6XX_CP_ROQ_THRESHOLDS_2, 0x010000c0);
> +	if (adreno_is_a640(adreno_gpu) || adreno_is_a650(adreno_gpu))
> +		gpu_write(gpu, REG_A6XX_CP_ROQ_THRESHOLDS_2, 0x02000140);
> +	else
> +		gpu_write(gpu, REG_A6XX_CP_ROQ_THRESHOLDS_2, 0x010000c0);
>  	gpu_write(gpu, REG_A6XX_CP_ROQ_THRESHOLDS_1, 0x8040362c);
>  
>  	/* Setting the mem pool size */
>  	gpu_write(gpu, REG_A6XX_CP_MEM_POOL_SIZE, 128);
>  
>  	/* Setting the primFifo thresholds default values */
> -	gpu_write(gpu, REG_A6XX_PC_DBG_ECO_CNTL, (0x300 << 11));
> +	if (adreno_is_a650(adreno_gpu))
> +		gpu_write(gpu, REG_A6XX_PC_DBG_ECO_CNTL, 0x00300000);
> +	else if (adreno_is_a640(adreno_gpu))
> +		gpu_write(gpu, REG_A6XX_PC_DBG_ECO_CNTL, 0x00200000);
> +	else
> +		gpu_write(gpu, REG_A6XX_PC_DBG_ECO_CNTL, (0x300 << 11));
>  
>  	/* Set the AHB default slave response to "ERROR" */
>  	gpu_write(gpu, REG_A6XX_CP_AHB_CNTL, 0x1);
> @@ -471,6 +491,19 @@ static int a6xx_hw_init(struct msm_gpu *gpu)
>  
>  	gpu_write(gpu, REG_A6XX_UCHE_CLIENT_PF, 1);
>  
> +	/* Set weights for bicubic filtering */
> +	if (adreno_is_a650(adreno_gpu)) {
> +		gpu_write(gpu, REG_A6XX_TPL1_BICUBIC_WEIGHTS_TABLE_0, 0);
> +		gpu_write(gpu, REG_A6XX_TPL1_BICUBIC_WEIGHTS_TABLE_1,
> +			0x3fe05ff4);
> +		gpu_write(gpu, REG_A6XX_TPL1_BICUBIC_WEIGHTS_TABLE_2,
> +			0x3fa0ebee);
> +		gpu_write(gpu, REG_A6XX_TPL1_BICUBIC_WEIGHTS_TABLE_3,
> +			0x3f5193ed);
> +		gpu_write(gpu, REG_A6XX_TPL1_BICUBIC_WEIGHTS_TABLE_4,
> +			0x3f0243f0);
> +	}
> +
>  	/* Protect registers from the CP */
>  	gpu_write(gpu, REG_A6XX_CP_PROTECT_CNTL, 0x00000003);
>  
> @@ -508,6 +541,11 @@ static int a6xx_hw_init(struct msm_gpu *gpu)
>  			A6XX_PROTECT_RDONLY(0x980, 0x4));
>  	gpu_write(gpu, REG_A6XX_CP_PROTECT(25), A6XX_PROTECT_RW(0xa630, 0x0));
>  
> +	if (adreno_is_a650(adreno_gpu)) {
> +		gpu_write(gpu, REG_A6XX_CP_APRIV_CNTL,
> +			(1 << 6) | (1 << 5) | (1 << 3) | (1 << 2) | (1 << 1));
> +	}

Okay, so this guy is fun. With these setting enabled the ringbuffer
automatically has register protection turned off and it can access privileged
buffers without setting any special registers. This isn't something we can
immediately take advantage of but the potential is there.

> +
>  	/* Enable interrupts */
>  	gpu_write(gpu, REG_A6XX_RBBM_INT_0_MASK, A6XX_INT_MASK);
>  
> -- 
> 2.26.1
> 

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
