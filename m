Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72272C54FCB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 11:09:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F6C320728
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 11:09:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbgDXLJx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 07:09:53 -0400
Received: from foss.arm.com ([217.140.110.172]:59960 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726582AbgDXLJx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 07:09:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 50FD41FB;
        Fri, 24 Apr 2020 04:09:52 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 314BC3F6CF;
        Fri, 24 Apr 2020 04:09:52 -0700 (PDT)
Received: by e110455-lin.cambridge.arm.com (Postfix, from userid 1000)
        id EC473682B6C; Fri, 24 Apr 2020 12:09:50 +0100 (BST)
Date:   Fri, 24 Apr 2020 12:09:50 +0100
From:   Liviu Dudau <liviu.dudau@arm.com>
To:     Bernard Zhao <bernard@vivo.com>
Cc:     Brian Starkey <brian.starkey@arm.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        opensource.kernel@vivo.com
Subject: Re: [PATCH v2] drm/arm: fixes pixel clock enabled with wrong format
Message-ID: <20200424110950.GC1985@e110455-lin.cambridge.arm.com>
References: <20200424063551.14336-1-bernard@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200424063551.14336-1-bernard@vivo.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bernand,

On Thu, Apr 23, 2020 at 11:35:51PM -0700, Bernard Zhao wrote:
> The pixel clock is still enabled when the format is wrong.
> no error branch handle, and also some register is not set
> in this case, e.g: HDLCD_REG_<color>_SELECT. Maybe we
> should disable this clock and throw an warn message when
> this happened.
> With this change, the code maybe a bit more readable.
> 
> Signed-off-by: Bernard Zhao <bernard@vivo.com>
> 
> Changes since V1:
> *add format error handle, if format is not correct, throw
> an warning message and disable this clock.
> 
> Link for V1:
> *https://lore.kernel.org/patchwork/patch/1228501/
> ---
>  drivers/gpu/drm/arm/hdlcd_crtc.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/arm/hdlcd_crtc.c b/drivers/gpu/drm/arm/hdlcd_crtc.c
> index af67fefed38d..f3945dee2b7d 100644
> --- a/drivers/gpu/drm/arm/hdlcd_crtc.c
> +++ b/drivers/gpu/drm/arm/hdlcd_crtc.c
> @@ -96,7 +96,7 @@ static int hdlcd_set_pxl_fmt(struct drm_crtc *crtc)
>  	}
>  
>  	if (WARN_ON(!format))
> -		return 0;
> +		return -EINVAL;

That is the right fix!

>  
>  	/* HDLCD uses 'bytes per pixel', zero means 1 byte */
>  	btpp = (format->bits_per_pixel + 7) / 8;
> @@ -125,7 +125,7 @@ static int hdlcd_set_pxl_fmt(struct drm_crtc *crtc)
>  	return 0;
>  }
>  
> -static void hdlcd_crtc_mode_set_nofb(struct drm_crtc *crtc)
> +static int hdlcd_crtc_mode_set_nofb(struct drm_crtc *crtc)

But this is not. We don't need to propagate the error further, just ....

>  {
>  	struct hdlcd_drm_private *hdlcd = crtc_to_hdlcd_priv(crtc);
>  	struct drm_display_mode *m = &crtc->state->adjusted_mode;
> @@ -162,9 +162,10 @@ static void hdlcd_crtc_mode_set_nofb(struct drm_crtc *crtc)
>  
>  	err = hdlcd_set_pxl_fmt(crtc);
>  	if (err)
> -		return;

... return here so that we don't call clk_set_rate();

Best regards,
Liviu

> +		return err;
>  
>  	clk_set_rate(hdlcd->clk, m->crtc_clock * 1000);
> +	return 0;
>  }
>  
>  static void hdlcd_crtc_atomic_enable(struct drm_crtc *crtc,
> @@ -173,7 +174,11 @@ static void hdlcd_crtc_atomic_enable(struct drm_crtc *crtc,
>  	struct hdlcd_drm_private *hdlcd = crtc_to_hdlcd_priv(crtc);
>  
>  	clk_prepare_enable(hdlcd->clk);
> -	hdlcd_crtc_mode_set_nofb(crtc);
> +	if (hdlcd_crtc_mode_set_nofb(crtc)) {
> +		DRM_DEBUG_KMS("Invalid format, pixel clock enable failed!\n");
> +		clk_disable_unprepare(hdlcd->clk);
> +		return;
> +	}
>  	hdlcd_write(hdlcd, HDLCD_REG_COMMAND, 1);
>  	drm_crtc_vblank_on(crtc);
>  }
> -- 
> 2.26.2
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
