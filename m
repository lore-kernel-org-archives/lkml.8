Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E429C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 14:41:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D23A20671
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 14:41:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbgEOOlv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 10:41:51 -0400
Received: from foss.arm.com ([217.140.110.172]:57118 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726197AbgEOOlv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 10:41:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 99A3F2F;
        Fri, 15 May 2020 07:41:50 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6099A3F71E;
        Fri, 15 May 2020 07:41:50 -0700 (PDT)
Received: by e110455-lin.cambridge.arm.com (Postfix, from userid 1000)
        id 24973682B70; Fri, 15 May 2020 15:41:49 +0100 (BST)
Date:   Fri, 15 May 2020 15:41:49 +0100
From:   Liviu Dudau <liviu.dudau@arm.com>
To:     Bernard <bernard@vivo.com>
Cc:     Brian Starkey <brian.starkey@arm.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        opensource.kernel@vivo.com
Subject: Re: Re:Re: [PATCH v2] drm/arm: fixes pixel clock enabled with wrong
 format
Message-ID: <20200515144149.GN159988@e110455-lin.cambridge.arm.com>
References: <AKgAPAB2CNW-P97ALGekNqqN.3.1587728256276.Hmail.bernard@vivo.com>
 <AAsAdQBuCHzEtmuRTR69xqrg.3.1588927637309.Hmail.bernard@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AAsAdQBuCHzEtmuRTR69xqrg.3.1588927637309.Hmail.bernard@vivo.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bernard,

On Fri, May 08, 2020 at 04:47:17PM +0800, Bernard wrote:
> From: "赵军奎" <bernard@vivo.com>
> Date: 2020-04-24 19:37:36
> To:  Liviu Dudau <liviu.dudau@arm.com>
> Cc:  Brian Starkey <brian.starkey@arm.com>,David Airlie <airlied@linux.ie>,Daniel Vetter <daniel@ffwll.ch>,dri-devel@lists.freedesktop.org,linux-kernel@vger.kernel.org,opensource.kernel@vivo.com
> Subject: Re:Re: [PATCH v2] drm/arm: fixes pixel clock enabled with wrong format
> 
> 
> 
> 
> From: Liviu Dudau <liviu.dudau@arm.com>
> Date: 2020-04-24 19:09:50
> To:  Bernard Zhao <bernard@vivo.com>
> Cc:  Brian Starkey <brian.starkey@arm.com>,David Airlie <airlied@linux.ie>,Daniel Vetter <daniel@ffwll.ch>,dri-devel@lists.freedesktop.org,linux-kernel@vger.kernel.org,opensource.kernel@vivo.com
> Subject: Re: [PATCH v2] drm/arm: fixes pixel clock enabled with wrong format>Hi Bernand,
> >
> >On Thu, Apr 23, 2020 at 11:35:51PM -0700, Bernard Zhao wrote:
> >> The pixel clock is still enabled when the format is wrong.
> >> no error branch handle, and also some register is not set
> >> in this case, e.g: HDLCD_REG_<color>_SELECT. Maybe we
> >> should disable this clock and throw an warn message when
> >> this happened.
> >> With this change, the code maybe a bit more readable.
> >> 
> >> Signed-off-by: Bernard Zhao <bernard@vivo.com>
> >> 
> >> Changes since V1:
> >> *add format error handle, if format is not correct, throw
> >> an warning message and disable this clock.
> >> 
> >> Link for V1:
> >> *https://lore.kernel.org/patchwork/patch/1228501/
> >> ---
> >>  drivers/gpu/drm/arm/hdlcd_crtc.c | 13 +++++++++----
> >>  1 file changed, 9 insertions(+), 4 deletions(-)
> >> 
> >> diff --git a/drivers/gpu/drm/arm/hdlcd_crtc.c b/drivers/gpu/drm/arm/hdlcd_crtc.c
> >> index af67fefed38d..f3945dee2b7d 100644
> >> --- a/drivers/gpu/drm/arm/hdlcd_crtc.c
> >> +++ b/drivers/gpu/drm/arm/hdlcd_crtc.c
> >> @@ -96,7 +96,7 @@ static int hdlcd_set_pxl_fmt(struct drm_crtc *crtc)
> >>  	}
> >>  
> >>  	if (WARN_ON(!format))
> >> -		return 0;
> >> +		return -EINVAL;
> >
> >That is the right fix!
> >
> >>  
> >>  	/* HDLCD uses 'bytes per pixel', zero means 1 byte */
> >>  	btpp = (format->bits_per_pixel + 7) / 8;
> >> @@ -125,7 +125,7 @@ static int hdlcd_set_pxl_fmt(struct drm_crtc *crtc)
> >>  	return 0;
> >>  }
> >>  
> >> -static void hdlcd_crtc_mode_set_nofb(struct drm_crtc *crtc)
> >> +static int hdlcd_crtc_mode_set_nofb(struct drm_crtc *crtc)
> >
> >But this is not. We don't need to propagate the error further, just ....
> >
> >>  {
> >>  	struct hdlcd_drm_private *hdlcd = crtc_to_hdlcd_priv(crtc);
> >>  	struct drm_display_mode *m = &crtc->state->adjusted_mode;
> >> @@ -162,9 +162,10 @@ static void hdlcd_crtc_mode_set_nofb(struct drm_crtc *crtc)
> >>  
> >>  	err = hdlcd_set_pxl_fmt(crtc);
> >>  	if (err)
> >> -		return;
> >
> 
> My previous understanding was that when such an exception occurred, it was caught
> in the atomic_enable interface, and then disable pixel clock. I am not sure is this ok or
> i have to do more register clean operaction.
> 
> >... return here so that we don't call clk_set_rate();
> And for this part, i am a little confused :
> 1 clk_set_rate must be set even if format is wrong?
> 2 The original code logic shows that If format is not correct, we will not set registers 
> HDLCD_REG_PIXEL_FORMAT & HDLCD_REG_<color>_SELECT, will this bring in
> any problems?
> 3 if 1 the rate must set & 2 registers above doesn`t matter, then maybe there is no
> need to disable pixel clock.
> Am i misunderstanding

You are right, the pixel format check should not happen inside hdlcd_crtc_atomic_enable()
hook, it should be moved into a separate function hdlcd_crtc_atomic_check() and that needs
to be hooked into .atomic_check() for hdlcd_crtc_helper_funcs().

If you want to have another go I'll be happy to review and Ack your patch.

Best regards,
Liviu 

> 
> Regards,
> Bernard
> 
> >> +		return err;
> >>  
> >>  	clk_set_rate(hdlcd->clk, m->crtc_clock * 1000);
> >> +	return 0;
> >>  }
> >>  
> >>  static void hdlcd_crtc_atomic_enable(struct drm_crtc *crtc,
> >> @@ -173,7 +174,11 @@ static void hdlcd_crtc_atomic_enable(struct drm_crtc *crtc,
> >>  	struct hdlcd_drm_private *hdlcd = crtc_to_hdlcd_priv(crtc);
> >>  
> >>  	clk_prepare_enable(hdlcd->clk);
> >> -	hdlcd_crtc_mode_set_nofb(crtc);
> >> +	if (hdlcd_crtc_mode_set_nofb(crtc)) {
> >> +		DRM_DEBUG_KMS("Invalid format, pixel clock enable failed!\n");
> >> +		clk_disable_unprepare(hdlcd->clk);
> >> +		return;
> >> +	}
> >>  	hdlcd_write(hdlcd, HDLCD_REG_COMMAND, 1);
> >>  	drm_crtc_vblank_on(crtc);
> >>  }
> >> -- 
> >> 2.26.2
> >> 
> >
> >-- 
> >====================
> >| I would like to |
> >| fix the world,  |
> >| but they're not |
> >| giving me the   |
> > \ source code!  /
> >  ---------------
> >    ¯\_(ツ)_/¯
> 
> 
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
