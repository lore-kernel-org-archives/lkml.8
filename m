Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06375C54FCC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 16:34:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D54C7206D5
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 16:34:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="Psghxta/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728597AbgDUQeq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 12:34:46 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:45623 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725990AbgDUQep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 12:34:45 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1587486884; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=z4m4GVLgDXCcfjWyV/ReLcM4EsDo1v6yZUlQduMxtdM=; b=Psghxta/hKx8VA3Uk1odkJpmNC1fTOgrk8pAXpsOkFTq9/+BhkGnP2ib0G5y0QdZR4GpO+IB
 BQeYbZ4VV5aGmf87rSUgqclVCGM3Vlc7vnhylUOSVqcYgbC75xOWsMgmfasr/20tkiDc2FtQ
 2FcPq3rUvwYb1RMPm7OEtwG4kV0=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e9f209a.7f39881cdf48-smtp-out-n01;
 Tue, 21 Apr 2020 16:34:34 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 90CDBC433D2; Tue, 21 Apr 2020 16:34:32 +0000 (UTC)
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DFE0EC433CB;
        Tue, 21 Apr 2020 16:34:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DFE0EC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
Date:   Tue, 21 Apr 2020 10:34:29 -0600
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     Jonathan Marek <jonathan@marek.ca>
Cc:     freedreno@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sharat Masetty <smasetty@codeaurora.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 7/9] drm/msm/a6xx: gmu_pdc register values for A640 and
 A650
Message-ID: <20200421163428.GB13825@jcrouse1-lnx.qualcomm.com>
Mail-Followup-To: Jonathan Marek <jonathan@marek.ca>,
        freedreno@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sharat Masetty <smasetty@codeaurora.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" <linux-arm-msm@vger.kernel.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200420140313.7263-1-jonathan@marek.ca>
 <20200420140313.7263-8-jonathan@marek.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420140313.7263-8-jonathan@marek.ca>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 20, 2020 at 10:03:11AM -0400, Jonathan Marek wrote:
> Signed-off-by: Jonathan Marek <jonathan@marek.ca>

I was wondering where this was.  I don't think there is any reason to not squash
this into the previous patch since the GMU won't be operational without it.

> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> index 3e51939eb867..b583bf6e293b 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> @@ -469,10 +469,18 @@ static void a6xx_gmu_rpmh_init(struct a6xx_gmu *gmu)
>  	struct platform_device *pdev = to_platform_device(gmu->dev);
>  	void __iomem *pdcptr = a6xx_gmu_get_mmio(pdev, "gmu_pdc");
>  	void __iomem *seqptr = a6xx_gmu_get_mmio(pdev, "gmu_pdc_seq");
> +	uint32_t pdc_address_offset;
>  
>  	if (!pdcptr || !seqptr)
>  		goto err;
>  
> +	if (adreno_is_a618(adreno_gpu) || adreno_is_a640(adreno_gpu))
> +		pdc_address_offset = 0x30090;
> +	else if (adreno_is_a650(adreno_gpu))
> +		pdc_address_offset = 0x300a0;
> +	else
> +		pdc_address_offset = 0x30080;
> +

>  	/* Disable SDE clock gating */
>  	gmu_write_rscc(gmu, REG_A6XX_GPU_RSCC_RSC_STATUS0_DRV0, BIT(24));
>  
> @@ -523,10 +531,7 @@ static void a6xx_gmu_rpmh_init(struct a6xx_gmu *gmu)
>  	pdc_write(pdcptr, REG_A6XX_PDC_GPU_TCS1_CMD0_DATA + 4, 0x0);
>  
>  	pdc_write(pdcptr, REG_A6XX_PDC_GPU_TCS1_CMD0_MSGID + 8, 0x10108);
> -	if (adreno_is_a618(adreno_gpu))
> -		pdc_write(pdcptr, REG_A6XX_PDC_GPU_TCS1_CMD0_ADDR + 8, 0x30090);
> -	else
> -		pdc_write(pdcptr, REG_A6XX_PDC_GPU_TCS1_CMD0_ADDR + 8, 0x30080);
> +	pdc_write(pdcptr, REG_A6XX_PDC_GPU_TCS1_CMD0_ADDR + 8, pdc_address_offset);
>  	pdc_write(pdcptr, REG_A6XX_PDC_GPU_TCS1_CMD0_DATA + 8, 0x0);
>  
>  	pdc_write(pdcptr, REG_A6XX_PDC_GPU_TCS3_CMD_ENABLE_BANK, 7);
> @@ -538,17 +543,12 @@ static void a6xx_gmu_rpmh_init(struct a6xx_gmu *gmu)
>  
>  	pdc_write(pdcptr, REG_A6XX_PDC_GPU_TCS3_CMD0_MSGID + 4, 0x10108);
>  	pdc_write(pdcptr, REG_A6XX_PDC_GPU_TCS3_CMD0_ADDR + 4, 0x30000);
> -	if (adreno_is_a618(adreno_gpu))
> +	if (adreno_is_a618(adreno_gpu) || adreno_is_a650(adreno_gpu))
>  		pdc_write(pdcptr, REG_A6XX_PDC_GPU_TCS3_CMD0_DATA + 4, 0x2);
>  	else
>  		pdc_write(pdcptr, REG_A6XX_PDC_GPU_TCS3_CMD0_DATA + 4, 0x3);
> -
> -
>  	pdc_write(pdcptr, REG_A6XX_PDC_GPU_TCS3_CMD0_MSGID + 8, 0x10108);
> -	if (adreno_is_a618(adreno_gpu))
> -		pdc_write(pdcptr, REG_A6XX_PDC_GPU_TCS3_CMD0_ADDR + 8, 0x30090);
> -	else
> -		pdc_write(pdcptr, REG_A6XX_PDC_GPU_TCS3_CMD0_ADDR + 8, 0x30080);
> +	pdc_write(pdcptr, REG_A6XX_PDC_GPU_TCS3_CMD0_ADDR + 8, pdc_address_offset);
>  	pdc_write(pdcptr, REG_A6XX_PDC_GPU_TCS3_CMD0_DATA + 8, 0x3);
>  
>  	/* Setup GPU PDC */
> -- 
> 2.26.1
> 

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
