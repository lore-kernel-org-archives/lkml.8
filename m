Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C068C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 16:07:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE76A206B5
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 16:07:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="vfV9K4HN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729103AbgHKQH1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 12:07:27 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:26715 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729004AbgHKQHY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 12:07:24 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597162043; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=aopWiCCtLIEBIrrQ/NhWFIPKW7qlpjHho6adIWqA26g=; b=vfV9K4HNRb4+HoaX0w5O00SKed+5XoGMjRLvdz5FAmfwdIKJKWHwNbQzMeHbZ1OnQUYHniwV
 tW+/PJK+aLyVJNOf4R9p01nqvt+ODufAdg7BjsMAgs4fMRNQm8jiV7ToIeN+lg+D0zOb8rA3
 ZWgMJw1IvcHYueM4HVdusf/gjxA=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 5f32c1f8d96d28d61ebbdb60 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 11 Aug 2020 16:06:16
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 50EF1C433AF; Tue, 11 Aug 2020 16:06:16 +0000 (UTC)
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 61799C433C6;
        Tue, 11 Aug 2020 16:06:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 61799C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
Date:   Tue, 11 Aug 2020 10:06:11 -0600
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sharat Masetty <smasetty@codeaurora.org>,
        Jonathan Marek <jonathan@marek.ca>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <freedreno@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/msm/a6xx: fix crashdec section name typo
Message-ID: <20200811160611.GA3221@jcrouse1-lnx.qualcomm.com>
Mail-Followup-To: Rob Clark <robdclark@gmail.com>,
        dri-devel@lists.freedesktop.org, Rob Clark <robdclark@chromium.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sharat Masetty <smasetty@codeaurora.org>,
        Jonathan Marek <jonathan@marek.ca>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" <linux-arm-msm@vger.kernel.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" <freedreno@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200808172913.380050-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200808172913.380050-1-robdclark@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 08, 2020 at 10:29:11AM -0700, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> Backport note: maybe wait some time for the crashdec MR[1] to look for
> both the old typo'd name and the corrected name to land in mesa 20.2
> 
> [1] https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/6242

Reviewed-by: Jordan Crouse <jcrouse@codeaurora.org>

> Fixes: 1707add81551 ("drm/msm/a6xx: Add a6xx gpu state")
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gpu_state.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.h b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.h
> index 846fd5b54c23..2fb58b7098e4 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.h
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.h
> @@ -372,7 +372,7 @@ static const struct a6xx_indexed_registers {
>  	u32 data;
>  	u32 count;
>  } a6xx_indexed_reglist[] = {
> -	{ "CP_SEQ_STAT", REG_A6XX_CP_SQE_STAT_ADDR,
> +	{ "CP_SQE_STAT", REG_A6XX_CP_SQE_STAT_ADDR,
>  		REG_A6XX_CP_SQE_STAT_DATA, 0x33 },
>  	{ "CP_DRAW_STATE", REG_A6XX_CP_DRAW_STATE_ADDR,
>  		REG_A6XX_CP_DRAW_STATE_DATA, 0x100 },
> -- 
> 2.26.2
> 

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
