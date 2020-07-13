Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA4BAC433E8
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 23:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8D70214DB
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 23:46:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="olHvFFmE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbgGMXqV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 19:46:21 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:62093 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726829AbgGMXqU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 19:46:20 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1594683980; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=i+RnCuHAQbN5qioI8ma+NQ9jS5eXOMxlIpBpYjoUcQ8=; b=olHvFFmEyKKZ6k3j2SHPbJNXTaIhFL9Fx26O1UW3SnALU1K0kHyfIWPFDDnwzOedjxABQltU
 KV3y/hL1PKpx7ZBRNIwQ2JCPXxrpAilvc2q9ZPaqImtl70epen0XHH17UodTqg6HTUGqbOo+
 uEkTh2wnL4UfFukERMNOI8jFb70=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n09.prod.us-east-1.postgun.com with SMTP id
 5f0cf24c65270fa59594e8d8 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 13 Jul 2020 23:46:20
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6080EC43387; Mon, 13 Jul 2020 23:46:19 +0000 (UTC)
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BBDFFC433CA;
        Mon, 13 Jul 2020 23:46:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BBDFFC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
Date:   Mon, 13 Jul 2020 17:46:14 -0600
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     Jonathan Marek <jonathan@marek.ca>
Cc:     freedreno@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <dri-devel@lists.freedesktop.org>, Rob Clark <robdclark@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Sean Paul <sean@poorly.run>
Subject: Re: [Freedreno] [PATCH v4 2/3] drm/msm: reset devfreq
 freq_table/max_state before devfreq_add_device
Message-ID: <20200713234614.GB24345@jcrouse1-lnx.qualcomm.com>
Mail-Followup-To: Jonathan Marek <jonathan@marek.ca>,
        freedreno@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" <dri-devel@lists.freedesktop.org>,
        Rob Clark <robdclark@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Sean Paul <sean@poorly.run>
References: <20200713225345.20556-1-jonathan@marek.ca>
 <20200713225345.20556-3-jonathan@marek.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200713225345.20556-3-jonathan@marek.ca>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 13, 2020 at 06:53:41PM -0400, Jonathan Marek wrote:
> These never get set back to 0 when probing fails, so an attempt to probe
> again results in broken behavior. Fix the problem by setting thse to zero
> before they are used.

Reviewed-by: Jordan Crouse <jcrouse@codeaurora.org>

> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
> ---
>  drivers/gpu/drm/msm/msm_gpu.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
> index a22d30622306..aa9775ab52f0 100644
> --- a/drivers/gpu/drm/msm/msm_gpu.c
> +++ b/drivers/gpu/drm/msm/msm_gpu.c
> @@ -93,7 +93,11 @@ static void msm_devfreq_init(struct msm_gpu *gpu)
>  	/*
>  	 * Don't set the freq_table or max_state and let devfreq build the table
>  	 * from OPP
> +	 * After a deferred probe, these may have be left to non-zero values,
> +	 * so set them back to zero before creating the devfreq device
>  	 */
> +	msm_devfreq_profile.freq_table = NULL;
> +	msm_devfreq_profile.max_state = 0;
>  
>  	gpu->devfreq.devfreq = devm_devfreq_add_device(&gpu->pdev->dev,
>  			&msm_devfreq_profile, DEVFREQ_GOV_SIMPLE_ONDEMAND,
> -- 
> 2.26.1
> 
> _______________________________________________
> Freedreno mailing list
> Freedreno@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/freedreno

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
