Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44D03C433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 14:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20AE6223B0
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 14:57:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="lPVlCXQS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbgGNO5v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 10:57:51 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:30884 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725945AbgGNO5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 10:57:51 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1594738670; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=rPT/6bcoi+yeld8ZbjkMYo22+/QxPs1ApgbqbZ3wZM8=; b=lPVlCXQSjbm6uBOZFvetfgJQ+Y5AIG4zCrdReqsOG9KGzcqPmYUppnu/ws6E7cwqzOlhLv+x
 PWiMAEaQEG8FqJXJkp59QqgwHOwabwFl6ksaGYMfn+ZYwa4AdutgT68BV1FrQpYX4OiWUHUC
 n11I1yBV/Gu+2vvwdDtpbkECknk=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n19.prod.us-west-2.postgun.com with SMTP id
 5f0dc7d62991e765cda47a72 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 14 Jul 2020 14:57:26
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 4A10BC433A0; Tue, 14 Jul 2020 14:57:26 +0000 (UTC)
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9C80EC433C8;
        Tue, 14 Jul 2020 14:57:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9C80EC433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
Date:   Tue, 14 Jul 2020 08:57:21 -0600
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     Akhil P Oommen <akhilpo@codeaurora.org>
Cc:     freedreno@lists.freedesktop.org, dri-devel@freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, mka@chromium.org, jonathan@marek.ca,
        robdclark@gmail.com, rnayak@codeaurora.org
Subject: Re: [PATCH] drm: msm: a6xx: fix gpu failure after system resume
Message-ID: <20200714145721.GD24345@jcrouse1-lnx.qualcomm.com>
Mail-Followup-To: Akhil P Oommen <akhilpo@codeaurora.org>,
        freedreno@lists.freedesktop.org, dri-devel@freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, mka@chromium.org, jonathan@marek.ca,
        robdclark@gmail.com, rnayak@codeaurora.org
References: <1594733130-398-1-git-send-email-akhilpo@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1594733130-398-1-git-send-email-akhilpo@codeaurora.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 14, 2020 at 06:55:30PM +0530, Akhil P Oommen wrote:
> On targets where GMU is available, GMU takes over the ownership of GX GDSC
> during its initialization. So, take a refcount on the GX PD on behalf of
> GMU before we initialize it. This makes sure that nobody can collapse the
> GX GDSC once GMU owns the GX GDSC. This patch fixes some weird failures
> during GPU wake up during system resume.

The change looks fine but this explanation is confusing. When I read it I
thought "oh, man, we weren't taking a reference to the GX PD during resume???"
but that's not really the case. We *are* taking a reference, just not soon
enough to avoid possible issues. It would be helpful if you reworded this to
explain that you are moving the reference and perhaps to shine a bit more light
on what the "weird" failures are.

Jordan

> Signed-off-by: Akhil P Oommen <akhilpo@codeaurora.org>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> index a6f43ff..5b2df7d 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> @@ -873,10 +873,19 @@ int a6xx_gmu_resume(struct a6xx_gpu *a6xx_gpu)
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
> @@ -919,19 +928,12 @@ int a6xx_gmu_resume(struct a6xx_gpu *a6xx_gpu)
>  	/* Set the GPU to the current freq */
>  	a6xx_gmu_set_initial_freq(gpu, gmu);
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
