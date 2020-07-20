Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A72AC433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 07:36:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DC3222CAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 07:36:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Sw5IEcis"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbgGTHgG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 03:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726015AbgGTHgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 03:36:05 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FB4EC061794
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 00:36:05 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id o2so24148808wmh.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 00:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=c0ZDB5Wq9R/JvtsXNF5Wt7Eqi2IUySqHftkrwWUiswg=;
        b=Sw5IEcisrBVJmb4gyxwaCG0cAqNnsc5yffyEHrr0+8UBL3kzg1SE1kRMGSlnDoSxyc
         806TppootrHhX/rF15kUD9CNz9VhxEDkhC/iYXtHASrvbcC16hX823XSYN5lopruVMM3
         KoDgWHHnik2fpBfH31SHOtwqVOrcajQeBV9Ns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=c0ZDB5Wq9R/JvtsXNF5Wt7Eqi2IUySqHftkrwWUiswg=;
        b=umALpbydJCQQWMwV6dnDVaQ50oVWL593to2PaL9IcvJOQO5c4tO4oyg/5/oP+ahRm3
         THqt6bqRG+0me41vnlkOYNw4Ba/IxuCk8OyGqXx+JPlTu9GtQCCh/T/xSdAujWKitIYj
         DKU5kDyaTr8jsVy9ejB3rSDE/pDd4jFDrPs78ibkxAFx1vH1TVXAc9I2X6VQ3HTEuyjx
         wAt6QrNxtedN6nOwqSMRt6OGK3yMoUigPbWAiRm8DvPx28XmhQ5GGONEpuOOeOahABTn
         9CrAr3kPmH3YyL14Qwjr6P/JJH3xemqLfznCXRouQDaVEgP5EqWf7s2Qrxqb4iAidAQ4
         udxQ==
X-Gm-Message-State: AOAM53365UiVbv4wod9wjjmgwUlRbL6jUg+eTU6RK9uaKHf+kGv/I0rH
        LkI5sqGYz/DGa3R3CeMH7OSZB5zLgCE=
X-Google-Smtp-Source: ABdhPJzmQ6e/1d88R0TDasxOj7GnF+ar1riWOZ2iimadli/xJPeOijGgXkcxuoFB6lfdwcaowN5kUg==
X-Received: by 2002:a1c:9d0c:: with SMTP id g12mr20981175wme.107.1595230564111;
        Mon, 20 Jul 2020 00:36:04 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id f197sm32565618wme.33.2020.07.20.00.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 00:36:03 -0700 (PDT)
Date:   Mon, 20 Jul 2020 09:36:01 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Suraj Upadhyay <usuraj35@gmail.com>
Cc:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch,
        sam@ravnborg.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm: core: Convert device logging to drm_* functions.
Message-ID: <20200720073601.GV3278063@phenom.ffwll.local>
Mail-Followup-To: Suraj Upadhyay <usuraj35@gmail.com>,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, sam@ravnborg.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20200718150955.GA23103@blackclown>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200718150955.GA23103@blackclown>
X-Operating-System: Linux phenom 5.6.0-1-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 18, 2020 at 08:39:55PM +0530, Suraj Upadhyay wrote:
> Convert device logging with dev_* functions into drm_* functions.
> 
> The patch has been generated with the coccinelle script below.
> The script focuses on instances of dev_* functions where the drm device
> context is clearly visible in its arguments.
> 
> @@expression E1; expression list E2; @@
> -dev_warn(E1->dev, E2)
> +drm_warn(E1, E2)
> 
> @@expression E1; expression list E2; @@
> -dev_info(E1->dev, E2)
> +drm_info(E1, E2)
> 
> @@expression E1; expression list E2; @@
> -dev_err(E1->dev, E2)
> +drm_err(E1, E2)
> 
> @@expression E1; expression list E2; @@
> -dev_info_once(E1->dev, E2)
> +drm_info_once(E1, E2)
> 
> @@expression E1; expression list E2; @@
> -dev_notice_once(E1->dev, E2)
> +drm_notice_once(E1, E2)
> 
> @@expression E1; expression list E2; @@
> -dev_warn_once(E1->dev, E2)
> +drm_warn_once(E1, E2)
> 
> @@expression E1; expression list E2; @@
> -dev_err_once(E1->dev, E2)
> +drm_err_once(E1, E2)
> 
> @@expression E1; expression list E2; @@
> -dev_err_ratelimited(E1->dev, E2)
> +drm_err_ratelimited(E1, E2)
> 
> @@expression E1; expression list E2; @@
> -dev_dbg(E1->dev, E2)
> +drm_dbg(E1, E2)
> 
> Signed-off-by: Suraj Upadhyay <usuraj35@gmail.com>
> ---
> Changes:
> 	v2: Fixed error in coccinelle script and diff,
> 	    i.e. removed the underscore.
> 		drv_dbg_ -> drm_dbg

Applied to drm-misc-next, thanks for your patch. Will probably go to 5.10
because drm is already in feature freeze.
-Daniel

> 
>  drivers/gpu/drm/drm_edid.c           | 6 ++----
>  drivers/gpu/drm/drm_gem_cma_helper.c | 4 ++--
>  drivers/gpu/drm/drm_mipi_dbi.c       | 7 +++----
>  3 files changed, 7 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
> index 52b357e75c3d..6840f0530a38 100644
> --- a/drivers/gpu/drm/drm_edid.c
> +++ b/drivers/gpu/drm/drm_edid.c
> @@ -1844,9 +1844,7 @@ static void connector_bad_edid(struct drm_connector *connector,
>  	if (connector->bad_edid_counter++ && !drm_debug_enabled(DRM_UT_KMS))
>  		return;
>  
> -	dev_warn(connector->dev->dev,
> -		 "%s: EDID is invalid:\n",
> -		 connector->name);
> +	drm_warn(connector->dev, "%s: EDID is invalid:\n", connector->name);
>  	for (i = 0; i < num_blocks; i++) {
>  		u8 *block = edid + i * EDID_LENGTH;
>  		char prefix[20];
> @@ -5298,7 +5296,7 @@ int drm_add_edid_modes(struct drm_connector *connector, struct edid *edid)
>  	}
>  	if (!drm_edid_is_valid(edid)) {
>  		clear_eld(connector);
> -		dev_warn(connector->dev->dev, "%s: EDID invalid.\n",
> +		drm_warn(connector->dev, "%s: EDID invalid.\n",
>  			 connector->name);
>  		return 0;
>  	}
> diff --git a/drivers/gpu/drm/drm_gem_cma_helper.c b/drivers/gpu/drm/drm_gem_cma_helper.c
> index 06a5b9ee1fe0..822edeadbab3 100644
> --- a/drivers/gpu/drm/drm_gem_cma_helper.c
> +++ b/drivers/gpu/drm/drm_gem_cma_helper.c
> @@ -105,8 +105,8 @@ struct drm_gem_cma_object *drm_gem_cma_create(struct drm_device *drm,
>  	cma_obj->vaddr = dma_alloc_wc(drm->dev, size, &cma_obj->paddr,
>  				      GFP_KERNEL | __GFP_NOWARN);
>  	if (!cma_obj->vaddr) {
> -		dev_dbg(drm->dev, "failed to allocate buffer with size %zu\n",
> -			size);
> +		drm_dbg(drm, "failed to allocate buffer with size %zu\n",
> +			 size);
>  		ret = -ENOMEM;
>  		goto error;
>  	}
> diff --git a/drivers/gpu/drm/drm_mipi_dbi.c b/drivers/gpu/drm/drm_mipi_dbi.c
> index 0e55d8716e3d..a7a611894243 100644
> --- a/drivers/gpu/drm/drm_mipi_dbi.c
> +++ b/drivers/gpu/drm/drm_mipi_dbi.c
> @@ -225,9 +225,8 @@ int mipi_dbi_buf_copy(void *dst, struct drm_framebuffer *fb,
>  		drm_fb_xrgb8888_to_rgb565(dst, src, fb, clip, swap);
>  		break;
>  	default:
> -		dev_err_once(fb->dev->dev, "Format is not supported: %s\n",
> -			     drm_get_format_name(fb->format->format,
> -						 &format_name));
> +		drm_err_once(fb->dev, "Format is not supported: %s\n",
> +			     drm_get_format_name(fb->format->format, &format_name));
>  		return -EINVAL;
>  	}
>  
> @@ -295,7 +294,7 @@ static void mipi_dbi_fb_dirty(struct drm_framebuffer *fb, struct drm_rect *rect)
>  				   width * height * 2);
>  err_msg:
>  	if (ret)
> -		dev_err_once(fb->dev->dev, "Failed to update display %d\n", ret);
> +		drm_err_once(fb->dev, "Failed to update display %d\n", ret);
>  
>  	drm_dev_exit(idx);
>  }
> -- 
> 2.17.1
> 



-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
