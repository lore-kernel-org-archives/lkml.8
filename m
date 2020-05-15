Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 646E3C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 01:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41B5B206D8
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 01:05:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nC6qh/RR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728194AbgEOBFk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 21:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726171AbgEOBFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 21:05:39 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE946C05BD43
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 18:05:37 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id q24so243977pjd.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 18:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6eDmVoxMjvhjUTcVq+QS+luvVgKfEd6UeTKYi0GYY/Q=;
        b=nC6qh/RRtLo5YkFASVNTjzmS6hB2wcHOSlCr6oyH+TRQvoERZi7p4K1Xcm4kuC4zfI
         IPZu7/uOH/jDh4/sS6a6Wl7/uYnk7PYrM5mxSbz3KCnEHIgK9FBWlUpMFggDwzTHihUK
         oVuWf5zTDw/mr7UpS8XDlsrUQ8ldUVXmPUc90=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6eDmVoxMjvhjUTcVq+QS+luvVgKfEd6UeTKYi0GYY/Q=;
        b=aemz4GOr3PRDGZG3WE2FmzhCxfS06hYgJ1MIV34YMjZtMPMB8xyuDgw1y0eChyWUjc
         gN8dhPFvtn+FMWdj07gPFvoE+MVrU+1+bNQUcJhWZJElkLYqGfT2AwSbecRILxnSMQUa
         +ppxsJTGyqEnkTMcp7MjIk5bDgHlA3Lnt01VMSi7oZV+hmXcNHRU3MElXnUDmw4DSdhX
         WnHJOf5zrVmTNtr98yyDB4gORrwOyUSMbrGk2DDD97bHOsSfuT0vXC/4cJ/jCnZXZQgZ
         jFTfgQZ8H4EaLfz4JBsP6pHG8oiecDmflmKLQLPUNK1M1bCzc8ucbhb9cOIOA+2AY3mK
         Q+ig==
X-Gm-Message-State: AOAM5336L/CsKOLwAzOjJobPWFeSmJa7wGDEPsIsVT9mHje3g/AKQ6oj
        Lgw6gArPgJtGvuheiUufYC8kow==
X-Google-Smtp-Source: ABdhPJwB6PAoOJYeS3qdfXHG1VARwSCyiTzJNK443oUUSG4LRJTMdwSgD9Whi8xkSHQq+C2mHa74PQ==
X-Received: by 2002:a17:90b:c90:: with SMTP id o16mr717743pjz.59.1589504737439;
        Thu, 14 May 2020 18:05:37 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id g14sm363169pfh.49.2020.05.14.18.05.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 May 2020 18:05:36 -0700 (PDT)
Date:   Thu, 14 May 2020 18:05:35 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Sharat Masetty <smasetty@codeaurora.org>
Cc:     freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        dri-devel@freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, jcrouse@codeaurora.org,
        georgi.djakov@linaro.org
Subject: Re: [PATCH 5/6] drm: msm: a6xx: use dev_pm_opp_set_bw to set DDR
 bandwidth
Message-ID: <20200515010535.GX4525@google.com>
References: <1589453659-27581-1-git-send-email-smasetty@codeaurora.org>
 <1589453659-27581-6-git-send-email-smasetty@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1589453659-27581-6-git-send-email-smasetty@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 14, 2020 at 04:24:18PM +0530, Sharat Masetty wrote:
> This patches replaces the previously used static DDR vote and uses
> dev_pm_opp_set_bw() to scale GPU->DDR bandwidth along with scaling
> GPU frequency.
> 
> Signed-off-by: Sharat Masetty <smasetty@codeaurora.org>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> index 2d8124b..79433d3 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> @@ -141,11 +141,7 @@ void a6xx_gmu_set_freq(struct msm_gpu *gpu, struct dev_pm_opp *opp)
> 
>  	gmu->freq = gmu->gpu_freqs[perf_index];
> 
> -	/*
> -	 * Eventually we will want to scale the path vote with the frequency but
> -	 * for now leave it at max so that the performance is nominal.
> -	 */
> -	icc_set_bw(gpu->icc_path, 0, MBps_to_icc(7216));
> +	dev_pm_opp_set_bw(&gpu->pdev->dev, opp);

Is there a particular reason to keep this one liner in a separate patch?
I think it would make sense to squash it into "drm: msm: a6xx: send opp
instead of a frequency" and change the subject of the combined patch to
something like "drm: msm: a6xx: Scale the DDR bandwidth dynamically".
