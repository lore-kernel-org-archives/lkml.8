Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E99F1C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 14:46:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEE8A20734
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 14:46:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="UvDf7R8J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbgGQOqY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 10:46:24 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:28207 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726198AbgGQOqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 10:46:24 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1594997183; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=+bOQoMlayiU8zaVsun4ZAjjXcdS6Du8WzvCubqCAKxo=; b=UvDf7R8JjH4vYmfcy0MATKtVKVxfrQm/QGwgmVV20I8e9aGsbDshOyf4Y9FXqimh+2dWQGpt
 xcfI4nZLHwFpRLa3F61JmjFSEgHK7kE/OavVs4tWLxARE6kftCHp6h46Q1M1L9puzKxXINPy
 B01er3Ej+q6AXzI7PUZExCmIBB0=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n11.prod.us-east-1.postgun.com with SMTP id
 5f11b9b4427cd55766cfc9a4 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 17 Jul 2020 14:46:12
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id CCE4DC433CA; Fri, 17 Jul 2020 14:46:11 +0000 (UTC)
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C3593C433C6;
        Fri, 17 Jul 2020 14:46:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C3593C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
Date:   Fri, 17 Jul 2020 08:46:07 -0600
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     Akhil P Oommen <akhilpo@codeaurora.org>
Cc:     freedreno@lists.freedesktop.org, dri-devel@freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        mka@chromium.org, robdclark@gmail.com, dianders@chromium.org
Subject: Re: [PATCH v2] drm: msm: a6xx: fix gpu failure after system resume
Message-ID: <20200717144607.GA16703@jcrouse1-lnx.qualcomm.com>
Mail-Followup-To: Akhil P Oommen <akhilpo@codeaurora.org>,
        freedreno@lists.freedesktop.org, dri-devel@freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        mka@chromium.org, robdclark@gmail.com, dianders@chromium.org
References: <1594996458-15529-1-git-send-email-akhilpo@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1594996458-15529-1-git-send-email-akhilpo@codeaurora.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 17, 2020 at 08:04:18PM +0530, Akhil P Oommen wrote:
> On targets where GMU is available, GMU takes over the ownership of GX GDSC
> during its initialization. So, move the refcount-get on GX PD before we
> initialize the GMU. This ensures that nobody can collapse the GX GDSC
> once GMU owns the GX GDSC. This patch fixes some GMU OOB errors seen
> during GPU wake up during a system resume.

> Signed-off-by: Akhil P Oommen <akhilpo@codeaurora.org>
> Reported-by: Matthias Kaehlcke <mka@chromium.org>
> Tested-by: Matthias Kaehlcke <mka@chromium.org>

The Signed-off-by needs to be at the end but I think Rob can do that for you.

Reviewed-by: Jordan Crouse <jcrouse@codeaurora.org>

> ---
> Changes from v1:
> - Reworded the commit text
> - Added Reported-by & Tested-by tags
> 
>  drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> index 21e77d6..1d33020 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> @@ -854,10 +854,19 @@ int a6xx_gmu_resume(struct a6xx_gpu *a6xx_gpu)
>  	/* Turn on the resources */
>  	pm_runtime_get_sync(gmu->dev);
>  
> +	/*
> +	 * "enable" the GX power domain which won't actually do anything but it
> +	 * will make sure that the refcounting is correct in case we need to
> +	 * bring down the GX after a GMU failure
> +	 */
> +	if (!IS_ERR_OR_NULL(gmu->gxpd))
> +		pm_runtime_get_sync(gmu->gxpd);
> +
>  	/* Use a known rate to bring up the GMU */
>  	clk_set_rate(gmu->core_clk, 200000000);
>  	ret = clk_bulk_prepare_enable(gmu->nr_clocks, gmu->clocks);
>  	if (ret) {
> +		pm_runtime_put(gmu->gxpd);
>  		pm_runtime_put(gmu->dev);
>  		return ret;
>  	}
> @@ -903,19 +912,12 @@ int a6xx_gmu_resume(struct a6xx_gpu *a6xx_gpu)
>  	else
>  		a6xx_hfi_set_freq(gmu, gmu->current_perf_index);
>  
> -	/*
> -	 * "enable" the GX power domain which won't actually do anything but it
> -	 * will make sure that the refcounting is correct in case we need to
> -	 * bring down the GX after a GMU failure
> -	 */
> -	if (!IS_ERR_OR_NULL(gmu->gxpd))
> -		pm_runtime_get(gmu->gxpd);
> -
>  out:
>  	/* On failure, shut down the GMU to leave it in a good state */
>  	if (ret) {
>  		disable_irq(gmu->gmu_irq);
>  		a6xx_rpmh_stop(gmu);
> +		pm_runtime_put(gmu->gxpd);
>  		pm_runtime_put(gmu->dev);
>  	}
>  
> -- 
> 2.7.4
> 

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
