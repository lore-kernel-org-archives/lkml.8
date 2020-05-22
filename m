Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D55BAC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 22:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B348120723
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 22:12:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="k01k/xE1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731123AbgEVWMI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 18:12:08 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:18593 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731051AbgEVWMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 18:12:08 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1590185527; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=BMLKs2JomZd3TZEWwn5R98bMIQZhgMt6bzYovepD0FU=; b=k01k/xE1es+5rdWq0+HAVEsxpB/nXENi/GAQC71dYt03sHQWUV9BH9YC0OCMKnVR6uNM0bVH
 sfh4V7xW1a74kYkzJ1T2VnxyIRd+zre/eEklZqjfYIbf9Q2p/AGKKvvE9go43dt5miYwkfXV
 Q0CDqlnx2b/x06YVC3stjwPYi5Y=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 5ec84e3382c96b5d3bd70acb (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 22 May 2020 22:12:03
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 28D76C43391; Fri, 22 May 2020 22:12:03 +0000 (UTC)
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 65FB0C433C6;
        Fri, 22 May 2020 22:12:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 65FB0C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
Date:   Fri, 22 May 2020 16:11:59 -0600
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     Jonathan Marek <jonathan@marek.ca>
Cc:     freedreno@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "Michael J. Ruhl" <michael.j.ruhl@intel.com>,
        Sharat Masetty <smasetty@codeaurora.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/msm/a6xx: don't try to set GPU frequency when GMU is
 suspended
Message-ID: <20200522221159.GA20960@jcrouse1-lnx.qualcomm.com>
Mail-Followup-To: Jonathan Marek <jonathan@marek.ca>,
        freedreno@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "Michael J. Ruhl" <michael.j.ruhl@intel.com>,
        Sharat Masetty <smasetty@codeaurora.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" <linux-arm-msm@vger.kernel.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200519030735.24713-1-jonathan@marek.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200519030735.24713-1-jonathan@marek.ca>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 18, 2020 at 11:07:33PM -0400, Jonathan Marek wrote:
> This fixes changing the frequency in sysfs while suspended, for example
> when doing something like this:
> 
> cat devfreq/3d00000.gpu/max_freq > devfreq/3d00000.gpu/min_freq

A patch landed to fix this [1] but it crossed paths in the night with the
a640/a650 support. Can you respin this to move the pm_runtime_get_if_in_use()
check in _a6xx_gmu_set_freq() to the higher level function and then we should
be covered.

Thanks,
Jordan

[1] https://patchwork.freedesktop.org/patch/364089/?series=76829&rev=3

> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> index aec54cde8534..9498803dcad9 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> @@ -151,13 +151,20 @@ void a6xx_gmu_set_freq(struct msm_gpu *gpu, unsigned long freq)
>  			break;
>  
>  	gmu->current_perf_index = perf_index;
> +	gmu->freq = gmu->gpu_freqs[perf_index];
> +
> +	/*
> +	 * devfreq may try to change frequency target even when suspended
> +	 * this can happen when changing frequency through sysfs
> +	 * don't try to set freq when suspended, it will be set on resume
> +	 */
> +	if (!pm_runtime_active(gmu->dev))
> +		return;
>  
>  	if (gmu->legacy)
>  		__a6xx_gmu_set_freq(gmu, perf_index);
>  	else
>  		a6xx_hfi_set_freq(gmu, perf_index);
> -
> -	gmu->freq = gmu->gpu_freqs[perf_index];
>  }
>  
>  unsigned long a6xx_gmu_get_freq(struct msm_gpu *gpu)
> -- 
> 2.26.1
> 

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
