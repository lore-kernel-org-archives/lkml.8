Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFCB9C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 08:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D8ED206B5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 08:53:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="IQiHh+mO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbgHGIxN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 04:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726940AbgHGIxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 04:53:13 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D5D0C061575
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 01:53:12 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id r2so932268wrs.8
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 01:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=2VcR1BDuGxPd+uco3kzeUdvgveolzvXOgl61y+LceLQ=;
        b=IQiHh+mOHTWbvSJ5MhHFvhQ9o5IriJWOXtk2hnDr0S0jKb5RBZvqVTQohVUW8zZtTz
         9+0Lg8yW0nHUrAZqymlHr98qpvrCsG9xBotNaMXmmdAH3qKbXnN4ArZr+MLNdDWFrhJf
         ixnLqOQ2MZH+OPkAnMBfTa6cMRhlnhZ/YxQRU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=2VcR1BDuGxPd+uco3kzeUdvgveolzvXOgl61y+LceLQ=;
        b=KOMN4l15Xh48C4ueMjJluzKt4dWmddbMwJsj+sZOwviT4DFDxNUExHy2qkrYs0s8S4
         wlQoKLVlZCmI5ZoPPmgm6ArGuHVsEXkehog7c15Q+0Ox7GtdZcia1MCUumJkcsHRPny1
         HXN3MVMVOYtR/kpzMHHGqMQp2YoemLAiGNqSOOKPDbBotXxHZ0SWEsmYWm2TUbFiGxGt
         4no+pN/jBYDAi8EVKpS9Zo1ymH43EGPEvaQjAaHtBOSMD8MbYkHP+eE6ozPGm6g/K23c
         ejMT1+MTw98ehPQsOs1Xhyw1ewyKv1CaCrSx9Wx3JXVD5CPLD4pEjewhetYytgM5Y2uR
         +i8w==
X-Gm-Message-State: AOAM532cKywbi2qiSUd1xNa/dx7mJFoJ8y07vvZmk6K8qRuDOeYO5Z3D
        Wsnh3kiS4Ze+TEH7vEMmRur5ouf4v2s=
X-Google-Smtp-Source: ABdhPJz3F9pgtvDG875F9ck9GiThy96pkEWsAliV4QS3QkMPwCaukt5ASD6++GHHlV8T7yhBqZwrJw==
X-Received: by 2002:adf:fa4b:: with SMTP id y11mr10914375wrr.349.1596790390818;
        Fri, 07 Aug 2020 01:53:10 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id v11sm9571033wrr.10.2020.08.07.01.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2020 01:53:10 -0700 (PDT)
Date:   Fri, 7 Aug 2020 10:53:08 +0200
From:   daniel@ffwll.ch
Cc:     Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/gma500: fix spelling mistake "pannel" -> "panel"
Message-ID: <20200807085308.GQ6419@phenom.ffwll.local>
Mail-Followup-To: Colin King <colin.king@canonical.com>,
        Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200805124227.20005-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200805124227.20005-1-colin.king@canonical.com>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 05, 2020 at 01:42:27PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There a handful of spelling mistakes. fix them.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Queued up for 5.10, should show up in linux-next right after the merge
window closes.
-Daniel

> ---
>  drivers/gpu/drm/gma500/mdfld_dsi_output.c | 4 ++--
>  drivers/gpu/drm/gma500/psb_intel_sdvo.c   | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/gma500/mdfld_dsi_output.c b/drivers/gpu/drm/gma500/mdfld_dsi_output.c
> index f350ac1ead18..2f3486f32fed 100644
> --- a/drivers/gpu/drm/gma500/mdfld_dsi_output.c
> +++ b/drivers/gpu/drm/gma500/mdfld_dsi_output.c
> @@ -366,7 +366,7 @@ static enum drm_mode_status mdfld_dsi_connector_mode_valid(struct drm_connector
>  	/**
>  	 * FIXME: current DC has no fitting unit, reject any mode setting
>  	 * request
> -	 * Will figure out a way to do up-scaling(pannel fitting) later.
> +	 * Will figure out a way to do up-scaling(panel fitting) later.
>  	 **/
>  	if (fixed_mode) {
>  		if (mode->hdisplay != fixed_mode->hdisplay)
> @@ -531,7 +531,7 @@ void mdfld_dsi_output_init(struct drm_device *dev,
>  	dsi_config->connector = dsi_connector;
>  
>  	if (!dsi_config->fixed_mode) {
> -		DRM_ERROR("No pannel fixed mode was found\n");
> +		DRM_ERROR("No panel fixed mode was found\n");
>  		goto dsi_init_err0;
>  	}
>  
> diff --git a/drivers/gpu/drm/gma500/psb_intel_sdvo.c b/drivers/gpu/drm/gma500/psb_intel_sdvo.c
> index 06e44f47e73e..907f966d6f22 100644
> --- a/drivers/gpu/drm/gma500/psb_intel_sdvo.c
> +++ b/drivers/gpu/drm/gma500/psb_intel_sdvo.c
> @@ -125,7 +125,7 @@ struct psb_intel_sdvo {
>  	bool is_lvds;
>  
>  	/**
> -	 * This is sdvo fixed pannel mode pointer
> +	 * This is sdvo fixed panel mode pointer
>  	 */
>  	struct drm_display_mode *sdvo_lvds_fixed_mode;
>  
> -- 
> 2.27.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
