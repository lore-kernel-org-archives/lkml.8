Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E425C11D1B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 19:50:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD99B206F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 19:50:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="DJ8zTdOP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728979AbgBTTui (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 14:50:38 -0500
Received: from mail27.static.mailgun.info ([104.130.122.27]:41602 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728865AbgBTTui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 14:50:38 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1582228237; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=7vaalBQGbByuwInf/ET23b5L19GnKvr01agHVpzaH2A=; b=DJ8zTdOPIcJ1tXmHTQcxPHV+ztUoDeBa3l7KGm8p6Wvr2FG0576/d4r9XTWhPK6vpVrDJjqs
 Z9PUK07Pv283+8hY6q7d2DqBkXt6cJMzPQZRU2vd1TgG8LRwfleTFGWzq2KsHXy67EzqDJ0X
 XC6ecV8ddoQ6OYqh3m5w3Y9NUC8=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e4ee304.7f0e2a5a9bc8-smtp-out-n03;
 Thu, 20 Feb 2020 19:50:28 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D0071C447A3; Thu, 20 Feb 2020 19:50:27 +0000 (UTC)
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5C997C43383;
        Thu, 20 Feb 2020 19:50:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5C997C43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
Date:   Thu, 20 Feb 2020 12:50:24 -0700
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <freedreno@lists.freedesktop.org>, David Airlie <airlied@linux.ie>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>, Sean Paul <sean@poorly.run>
Subject: Re: [Freedreno] [PATCH] drm/msm/a6xx: Fix CP_MEMPOOL state name
Message-ID: <20200220195024.GA11477@jcrouse1-lnx.qualcomm.com>
Mail-Followup-To: Rob Clark <robdclark@gmail.com>,
        dri-devel@lists.freedesktop.org, Rob Clark <robdclark@chromium.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" <freedreno@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>, Sean Paul <sean@poorly.run>
References: <20200220180013.1120750-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200220180013.1120750-1-robdclark@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2020 at 10:00:09AM -0800, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>

Reviewed-by: Jordan Crouse <jcrouse@codeaurora.org>

> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gpu_state.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.h b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.h
> index 68cccfa2870a..bbbec8d26870 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.h
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.h
> @@ -370,7 +370,7 @@ static const struct a6xx_indexed_registers {
>  };
>  
>  static const struct a6xx_indexed_registers a6xx_cp_mempool_indexed = {
> -	"CP_MEMPOOOL", REG_A6XX_CP_MEM_POOL_DBG_ADDR,
> +	"CP_MEMPOOL", REG_A6XX_CP_MEM_POOL_DBG_ADDR,
>  		REG_A6XX_CP_MEM_POOL_DBG_DATA, 0x2060,
>  };
>  
> -- 
> 2.24.1
> 
> _______________________________________________
> Freedreno mailing list
> Freedreno@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/freedreno

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
