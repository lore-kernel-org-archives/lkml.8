Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B69BC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 17:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8DF92063A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 17:33:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="bth56Yix"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389266AbgHQRdb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 13:33:31 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:48097 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389019AbgHQQxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 12:53:54 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597683233; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=CWGALEqQ4ZA1LCRWwGY3ghzqLDTb2GiGuUvIFbf/Xdo=; b=bth56YixzpRLq21Y6l56M4ZqBILP4d8/9e1w2K6QCObATm5FFQVdYVwHAN6TxljJx0AWanjI
 NwPNKGcjd37y+bU75IfECM01dpO/dM34uzxouedAo1d8jwzx2QhfNIpQE77YOPYxtBxuGqoD
 +kSVT7GjMHfXSW/ardaNIS0GhSM=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 5f3ab61df2b697637a973602 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 17 Aug 2020 16:53:49
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6E212C433B6; Mon, 17 Aug 2020 16:53:47 +0000 (UTC)
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D110DC433C6;
        Mon, 17 Aug 2020 16:53:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D110DC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
Date:   Mon, 17 Aug 2020 10:53:41 -0600
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
        linux-arm-msm@vger.kernel.org, Rob Clark <robdclark@chromium.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        open list <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jonathan Marek <jonathan@marek.ca>,
        David Airlie <airlied@linux.ie>, Will Deacon <will@kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        AngeloGioacchino Del Regno <kholk11@gmail.com>,
        Sean Paul <sean@poorly.run>,
        Sibi Sankar <sibis@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        freedreno@lists.freedesktop.org,
        Sharat Masetty <smasetty@codeaurora.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [Freedreno] [PATCH 06/19] drm/msm/gpu: add dev_to_gpu() helper
Message-ID: <20200817165341.GI3221@jcrouse1-lnx.qualcomm.com>
Mail-Followup-To: Rob Clark <robdclark@gmail.com>,
        dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
        linux-arm-msm@vger.kernel.org, Rob Clark <robdclark@chromium.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        open list <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>, Jonathan Marek <jonathan@marek.ca>,
        David Airlie <airlied@linux.ie>, Will Deacon <will@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        AngeloGioacchino Del Regno <kholk11@gmail.com>,
        Sean Paul <sean@poorly.run>, Sibi Sankar <sibis@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>, freedreno@lists.freedesktop.org,
        Sharat Masetty <smasetty@codeaurora.org>,
        linux-arm-kernel@lists.infradead.org
References: <20200810222657.1841322-1-jcrouse@codeaurora.org>
 <20200814024114.1177553-7-robdclark@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200814024114.1177553-7-robdclark@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 13, 2020 at 07:41:01PM -0700, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> In a later patch, the drvdata will not directly be 'struct msm_gpu *',
> so add a helper to reduce the churn.
> 
Reviewed-by: Jordan Crouse <jcrouse@codeaurora.org>

> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>  drivers/gpu/drm/msm/adreno/adreno_device.c | 10 ++++------
>  drivers/gpu/drm/msm/msm_gpu.c              |  6 +++---
>  drivers/gpu/drm/msm/msm_gpu.h              |  5 +++++
>  3 files changed, 12 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
> index 9eeb46bf2a5d..26664e1b30c0 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_device.c
> +++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
> @@ -282,7 +282,7 @@ struct msm_gpu *adreno_load_gpu(struct drm_device *dev)
>  	int ret;
>  
>  	if (pdev)
> -		gpu = platform_get_drvdata(pdev);
> +		gpu = dev_to_gpu(&pdev->dev);
>  
>  	if (!gpu) {
>  		dev_err_once(dev->dev, "no GPU device was found\n");
> @@ -425,7 +425,7 @@ static int adreno_bind(struct device *dev, struct device *master, void *data)
>  static void adreno_unbind(struct device *dev, struct device *master,
>  		void *data)
>  {
> -	struct msm_gpu *gpu = dev_get_drvdata(dev);
> +	struct msm_gpu *gpu = dev_to_gpu(dev);
>  
>  	pm_runtime_force_suspend(dev);
>  	gpu->funcs->destroy(gpu);
> @@ -490,16 +490,14 @@ static const struct of_device_id dt_match[] = {
>  #ifdef CONFIG_PM
>  static int adreno_resume(struct device *dev)
>  {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct msm_gpu *gpu = platform_get_drvdata(pdev);
> +	struct msm_gpu *gpu = dev_to_gpu(dev);
>  
>  	return gpu->funcs->pm_resume(gpu);
>  }
>  
>  static int adreno_suspend(struct device *dev)
>  {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct msm_gpu *gpu = platform_get_drvdata(pdev);
> +	struct msm_gpu *gpu = dev_to_gpu(dev);
>  
>  	return gpu->funcs->pm_suspend(gpu);
>  }
> diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
> index d5645472b25d..6aa9e04e52e7 100644
> --- a/drivers/gpu/drm/msm/msm_gpu.c
> +++ b/drivers/gpu/drm/msm/msm_gpu.c
> @@ -24,7 +24,7 @@
>  static int msm_devfreq_target(struct device *dev, unsigned long *freq,
>  		u32 flags)
>  {
> -	struct msm_gpu *gpu = platform_get_drvdata(to_platform_device(dev));
> +	struct msm_gpu *gpu = dev_to_gpu(dev);
>  	struct dev_pm_opp *opp;
>  
>  	opp = devfreq_recommended_opp(dev, freq, flags);
> @@ -45,7 +45,7 @@ static int msm_devfreq_target(struct device *dev, unsigned long *freq,
>  static int msm_devfreq_get_dev_status(struct device *dev,
>  		struct devfreq_dev_status *status)
>  {
> -	struct msm_gpu *gpu = platform_get_drvdata(to_platform_device(dev));
> +	struct msm_gpu *gpu = dev_to_gpu(dev);
>  	ktime_t time;
>  
>  	if (gpu->funcs->gpu_get_freq)
> @@ -64,7 +64,7 @@ static int msm_devfreq_get_dev_status(struct device *dev,
>  
>  static int msm_devfreq_get_cur_freq(struct device *dev, unsigned long *freq)
>  {
> -	struct msm_gpu *gpu = platform_get_drvdata(to_platform_device(dev));
> +	struct msm_gpu *gpu = dev_to_gpu(dev);
>  
>  	if (gpu->funcs->gpu_get_freq)
>  		*freq = gpu->funcs->gpu_get_freq(gpu);
> diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
> index 0db117a7339b..8bda7beaed4b 100644
> --- a/drivers/gpu/drm/msm/msm_gpu.h
> +++ b/drivers/gpu/drm/msm/msm_gpu.h
> @@ -141,6 +141,11 @@ struct msm_gpu {
>  	struct msm_gpu_state *crashstate;
>  };
>  
> +static inline struct msm_gpu *dev_to_gpu(struct device *dev)
> +{
> +	return dev_get_drvdata(dev);
> +}
> +
>  /* It turns out that all targets use the same ringbuffer size */
>  #define MSM_GPU_RINGBUFFER_SZ SZ_32K
>  #define MSM_GPU_RINGBUFFER_BLKSIZE 32
> -- 
> 2.26.2
> 
> _______________________________________________
> Freedreno mailing list
> Freedreno@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/freedreno

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
