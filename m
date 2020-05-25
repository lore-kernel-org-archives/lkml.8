Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FCDFC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 15:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49EC02073B
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 15:12:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="IFiDyfUZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391085AbgEYPMl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 11:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390992AbgEYPMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 11:12:41 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E007DC061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 08:12:40 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id y5so305992wmj.4
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 08:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=KghFKwFNl8hSzWv6Z3aLFWWGHd6AyG7zrRq1WhzsXps=;
        b=IFiDyfUZy5oc/M4ulHtx3QHrQiW6cXKRM2Hm/B9gkaxJQMEWlwFbZCaUGxuwCdtiWB
         gfeqF0PVnaSY0nIZuKdlSI/79Wnw9rlFpIkKqSFdmAuS797eTF0j0poklJ3m4nlHsrpH
         pAm08eQ4EIXQUsDEwNCs/i7cGi7TxfUaGvUEw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=KghFKwFNl8hSzWv6Z3aLFWWGHd6AyG7zrRq1WhzsXps=;
        b=tkTsTKgmLNJ2f0V+ruydOVxFaulFi10EUnOV/SKMxN8Wp72jAk0NoM8W/f9D4lSWzm
         lReFa3Th64rLPP3HQwwSBZhWTKp4cN230XtFCYsaAXffu38qywyqblsBNZeBymkJJ0X8
         T8lNqzu2GU7QEtmpCwg9X/uYXMFaYqZIkHaPnUF73uffrnd7DPZeX3FlNo8S3HnfGrwL
         UAJsbA0jYiMfkSiLNq4oc9s16lRBAqBRhw1JmMlGBaLtdYKxY7ckx1WJbsgPbPPsGdAk
         S6ANv81hkrQFl60ggrddXR4sURh6DnychXpj+7XHajtE3gugDT0peXnl2KLEcsJ+Adsj
         KY1A==
X-Gm-Message-State: AOAM531x5prAnswwTasYUlpmXPyQLrHdSUTl2TceJpS0Pa+k0bA8JWc7
        SaSSYBzU0j9Zevwr6Ad0FXspwQ==
X-Google-Smtp-Source: ABdhPJzLOtSxrGWcgJ4Qgx6WeEYNjCzlux5W9q5Zb384uoob1qCpIHD5u6Y9fJgukZs6BL0UHiL1gg==
X-Received: by 2002:a7b:c306:: with SMTP id k6mr24742315wmj.40.1590419559650;
        Mon, 25 May 2020 08:12:39 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id g6sm18344983wrp.75.2020.05.25.08.12.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2020 08:12:38 -0700 (PDT)
Date:   Mon, 25 May 2020 17:12:37 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     James Hilliard <james.hilliard1@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, Eric Anholt <eric@anholt.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] drm/vc4: hdmi: Silence pixel clock error on
 -EPROBE_DEFER
Message-ID: <20200525151237.GJ206103@phenom.ffwll.local>
Mail-Followup-To: James Hilliard <james.hilliard1@gmail.com>,
        dri-devel@lists.freedesktop.org, Eric Anholt <eric@anholt.net>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org
References: <20200525012859.267433-1-james.hilliard1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200525012859.267433-1-james.hilliard1@gmail.com>
X-Operating-System: Linux phenom 5.6.0-1-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 24, 2020 at 07:28:59PM -0600, James Hilliard wrote:
> If the vc4 hdmi driver loads before the pixel clock is available we
> see a spurious "*ERROR* Failed to get pixel clock" error.
> 
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
> no response in over 2 weeks

Thanks for poking again, not sure who exactly is supporting drm/vc4
nowadays. Eric at least doesn't work at broadcom anymore.

I queued up the patch in drm-misc-next.
-Daniel

> ---
>  drivers/gpu/drm/vc4/vc4_hdmi.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
> index 340719238753..6d4ee3f6b445 100644
> --- a/drivers/gpu/drm/vc4/vc4_hdmi.c
> +++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
> @@ -1338,8 +1338,10 @@ static int vc4_hdmi_bind(struct device *dev, struct device *master, void *data)
>  
>  	hdmi->pixel_clock = devm_clk_get(dev, "pixel");
>  	if (IS_ERR(hdmi->pixel_clock)) {
> -		DRM_ERROR("Failed to get pixel clock\n");
> -		return PTR_ERR(hdmi->pixel_clock);
> +		ret = PTR_ERR(hdmi->pixel_clock);
> +		if (ret != -EPROBE_DEFER)
> +			DRM_ERROR("Failed to get pixel clock\n");
> +		return ret;
>  	}
>  	hdmi->hsm_clock = devm_clk_get(dev, "hdmi");
>  	if (IS_ERR(hdmi->hsm_clock)) {
> -- 
> 2.25.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
