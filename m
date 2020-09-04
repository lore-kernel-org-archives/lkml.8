Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63C0BC43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 15:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17A75206E7
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 15:48:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="Cxmaouoq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbgIDPr6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 11:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727797AbgIDPri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 11:47:38 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73AD2C061247
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 08:47:09 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id l9so6514393wme.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 08:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Bm29TR0zDyfJHRh/JsSqrgRAa80WtO8xmYwnn8tQ1oI=;
        b=Cxmaouoqp1ey3OvqLyNR86kTWhAMP/leb1Iv1DcCt0h9uEs0PL5jx9+1TCId6dQ6HS
         OuRqLqcThUlu/BzJpdYt6CxeZgf+7FDaTdU7VMYALZnGQFd8WOY6iJLvDSKvMkWuQ6oE
         HNR1fsb6YNGzLkuCC4AUAn167nz7Blzms3jTH1n/UUrdBuwX+qM05BZg5TYFyC7pZCl7
         yVp0+8Buu+eRjB6/593xtEIhqrb3j4k1XkuWfrV1ej6wdngOwGhzUBYE5WQmmmT3VwX2
         vCk0FiFrMKl5eINxeXMkavSkFEHQsDMgbakDPxSd1NUodEyfl2kjXwNQEnwse35Tbkhj
         35rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bm29TR0zDyfJHRh/JsSqrgRAa80WtO8xmYwnn8tQ1oI=;
        b=aqevZ+LqrvbfjN6PMUFbOml0ulH9NBF7Iq24nxiMQyYVCdf43MgHELR7WC5+J4RfZp
         9LbjJqFvduNE/JR/6tEn3whiE96uJsQ8WfCZoEC8SipQs1HPuJq3YVIgLjXG3Jy/0kgx
         H8iiR2Mjd7qgJu6ODnNZzPgfSERlJwmCnEIjiFhEOWPe/s50h7z9rzeeRw5Qwx6TNwOB
         00ANMjwA5IxI0jlz4mlqVrDdFdoqm4lkJlBTkGzojxXRdxlp9cEb0OR1rjZqzk6KBQ0r
         WzLdMTi/h9QN2ZRwgdzuMpufbx2qZzeujspBu8KTOJGh0bP11m5hI50Ylkr86+eXHkV2
         gXqA==
X-Gm-Message-State: AOAM530F9mBYBkivWuM4109ipD19kemDPcooR5jqldDJ6emgJWYfOCnZ
        em0WeCyjVnqn57c+PlHNg1Iyjw6K1HPHiXGQrjbnmg==
X-Google-Smtp-Source: ABdhPJxpU9rr5tU8lUD2ZqpqMTLkDLYORH4WjLVHnLFfcCbVfshaLZPgZXO3/BS7nFSaOY2UdhC36Wu6GDOCIM8JuQU=
X-Received: by 2002:a1c:415:: with SMTP id 21mr7849921wme.183.1599234427998;
 Fri, 04 Sep 2020 08:47:07 -0700 (PDT)
MIME-Version: 1.0
References: <cover.dddc064d8bb83e46744336af67dcb13139e5747d.1599120059.git-series.maxime@cerno.tech>
 <0cfcbb379212f90b4abc76c0ccf3b90d1d7c0268.1599120059.git-series.maxime@cerno.tech>
In-Reply-To: <0cfcbb379212f90b4abc76c0ccf3b90d1d7c0268.1599120059.git-series.maxime@cerno.tech>
From:   Dave Stevenson <dave.stevenson@raspberrypi.com>
Date:   Fri, 4 Sep 2020 16:46:53 +0100
Message-ID: <CAPY8ntBCbEo_xj0J_PonSdcfb7P=UFsPMPZe1dHtbh6pkxvHnA@mail.gmail.com>
Subject: Re: [PATCH v5 56/80] drm/vc4: hdmi: Add a set_timings callback
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Eric Anholt <eric@anholt.net>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Hoegeun Kwon <hoegeun.kwon@samsung.com>,
        Stefan Wahren <stefan.wahren@i2se.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime

On Thu, 3 Sep 2020 at 09:03, Maxime Ripard <maxime@cerno.tech> wrote:
>
> Similarly to the previous patches, the timings setup in the HDMI controller
> of the BCM2711 is slightly different, mostly because it supports higher
> resolutions and thus needed more spaces for the various timings, resulting
> in the register layout changing.
>
> Let's add a callback for that as well.
>
> Tested-by: Chanwoo Choi <cw00.choi@samsung.com>
> Tested-by: Hoegeun Kwon <hoegeun.kwon@samsung.com>
> Tested-by: Stefan Wahren <stefan.wahren@i2se.com>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>

Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>

> ---
>  drivers/gpu/drm/vc4/vc4_hdmi.c | 72 +++++++++++++++++++----------------
>  drivers/gpu/drm/vc4/vc4_hdmi.h |  4 ++-
>  2 files changed, 44 insertions(+), 32 deletions(-)
>
> diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
> index 532618e02399..9e2bc6cb690e 100644
> --- a/drivers/gpu/drm/vc4/vc4_hdmi.c
> +++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
> @@ -369,12 +369,9 @@ static void vc4_hdmi_csc_setup(struct vc4_hdmi *vc4_hdmi, bool enable)
>         HDMI_WRITE(HDMI_CSC_CTL, csc_ctl);
>  }
>
> -static void vc4_hdmi_encoder_enable(struct drm_encoder *encoder)
> +static void vc4_hdmi_set_timings(struct vc4_hdmi *vc4_hdmi,
> +                                struct drm_display_mode *mode)
>  {
> -       struct drm_display_mode *mode = &encoder->crtc->state->adjusted_mode;
> -       struct vc4_hdmi *vc4_hdmi = encoder_to_vc4_hdmi(encoder);
> -       struct vc4_hdmi_encoder *vc4_encoder = &vc4_hdmi->encoder;
> -       bool debug_dump_regs = false;
>         bool hsync_pos = mode->flags & DRM_MODE_FLAG_PHSYNC;
>         bool vsync_pos = mode->flags & DRM_MODE_FLAG_PVSYNC;
>         bool interlaced = mode->flags & DRM_MODE_FLAG_INTERLACE;
> @@ -392,6 +389,41 @@ static void vc4_hdmi_encoder_enable(struct drm_encoder *encoder)
>                                         mode->crtc_vsync_end -
>                                         interlaced,
>                                         VC4_HDMI_VERTB_VBP));
> +
> +       HDMI_WRITE(HDMI_HORZA,
> +                  (vsync_pos ? VC4_HDMI_HORZA_VPOS : 0) |
> +                  (hsync_pos ? VC4_HDMI_HORZA_HPOS : 0) |
> +                  VC4_SET_FIELD(mode->hdisplay * pixel_rep,
> +                                VC4_HDMI_HORZA_HAP));
> +
> +       HDMI_WRITE(HDMI_HORZB,
> +                  VC4_SET_FIELD((mode->htotal -
> +                                 mode->hsync_end) * pixel_rep,
> +                                VC4_HDMI_HORZB_HBP) |
> +                  VC4_SET_FIELD((mode->hsync_end -
> +                                 mode->hsync_start) * pixel_rep,
> +                                VC4_HDMI_HORZB_HSP) |
> +                  VC4_SET_FIELD((mode->hsync_start -
> +                                 mode->hdisplay) * pixel_rep,
> +                                VC4_HDMI_HORZB_HFP));
> +
> +       HDMI_WRITE(HDMI_VERTA0, verta);
> +       HDMI_WRITE(HDMI_VERTA1, verta);
> +
> +       HDMI_WRITE(HDMI_VERTB0, vertb_even);
> +       HDMI_WRITE(HDMI_VERTB1, vertb);
> +
> +       HDMI_WRITE(HDMI_VID_CTL,
> +                  (vsync_pos ? 0 : VC4_HD_VID_CTL_VSYNC_LOW) |
> +                  (hsync_pos ? 0 : VC4_HD_VID_CTL_HSYNC_LOW));
> +}
> +
> +static void vc4_hdmi_encoder_enable(struct drm_encoder *encoder)
> +{
> +       struct drm_display_mode *mode = &encoder->crtc->state->adjusted_mode;
> +       struct vc4_hdmi *vc4_hdmi = encoder_to_vc4_hdmi(encoder);
> +       struct vc4_hdmi_encoder *vc4_encoder = to_vc4_hdmi_encoder(encoder);
> +       bool debug_dump_regs = false;
>         int ret;
>
>         ret = pm_runtime_get_sync(&vc4_hdmi->pdev->dev);
> @@ -435,33 +467,8 @@ static void vc4_hdmi_encoder_enable(struct drm_encoder *encoder)
>                    VC4_HDMI_SCHEDULER_CONTROL_MANUAL_FORMAT |
>                    VC4_HDMI_SCHEDULER_CONTROL_IGNORE_VSYNC_PREDICTS);
>
> -       HDMI_WRITE(HDMI_HORZA,
> -                  (vsync_pos ? VC4_HDMI_HORZA_VPOS : 0) |
> -                  (hsync_pos ? VC4_HDMI_HORZA_HPOS : 0) |
> -                  VC4_SET_FIELD(mode->hdisplay * pixel_rep,
> -                                VC4_HDMI_HORZA_HAP));
> -
> -       HDMI_WRITE(HDMI_HORZB,
> -                  VC4_SET_FIELD((mode->htotal -
> -                                 mode->hsync_end) * pixel_rep,
> -                                VC4_HDMI_HORZB_HBP) |
> -                  VC4_SET_FIELD((mode->hsync_end -
> -                                 mode->hsync_start) * pixel_rep,
> -                                VC4_HDMI_HORZB_HSP) |
> -                  VC4_SET_FIELD((mode->hsync_start -
> -                                 mode->hdisplay) * pixel_rep,
> -                                VC4_HDMI_HORZB_HFP));
> -
> -       HDMI_WRITE(HDMI_VERTA0, verta);
> -       HDMI_WRITE(HDMI_VERTA1, verta);
> -
> -       HDMI_WRITE(HDMI_VERTB0, vertb_even);
> -       HDMI_WRITE(HDMI_VERTB1, vertb);
> -
> -       HDMI_WRITE(HDMI_VID_CTL,
> -                  (vsync_pos ? 0 : VC4_HD_VID_CTL_VSYNC_LOW) |
> -                  (hsync_pos ? 0 : VC4_HD_VID_CTL_HSYNC_LOW));
> -
> +       if (vc4_hdmi->variant->set_timings)
> +               vc4_hdmi->variant->set_timings(vc4_hdmi, mode);
>
>         if (vc4_encoder->hdmi_monitor &&
>             drm_default_rgb_quant_range(mode) == HDMI_QUANTIZATION_RANGE_LIMITED) {
> @@ -1445,6 +1452,7 @@ static const struct vc4_hdmi_variant bcm2835_variant = {
>         .init_resources         = vc4_hdmi_init_resources,
>         .csc_setup              = vc4_hdmi_csc_setup,
>         .reset                  = vc4_hdmi_reset,
> +       .set_timings            = vc4_hdmi_set_timings,
>         .phy_init               = vc4_hdmi_phy_init,
>         .phy_disable            = vc4_hdmi_phy_disable,
>         .phy_rng_enable         = vc4_hdmi_phy_rng_enable,
> diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.h b/drivers/gpu/drm/vc4/vc4_hdmi.h
> index c8fd58548ea2..0c32dc46d289 100644
> --- a/drivers/gpu/drm/vc4/vc4_hdmi.h
> +++ b/drivers/gpu/drm/vc4/vc4_hdmi.h
> @@ -44,6 +44,10 @@ struct vc4_hdmi_variant {
>         /* Callback to enable / disable the CSC */
>         void (*csc_setup)(struct vc4_hdmi *vc4_hdmi, bool enable);
>
> +       /* Callback to configure the video timings in the HDMI block */
> +       void (*set_timings)(struct vc4_hdmi *vc4_hdmi,
> +                           struct drm_display_mode *mode);
> +
>         /* Callback to initialize the PHY according to the mode */
>         void (*phy_init)(struct vc4_hdmi *vc4_hdmi,
>                          struct drm_display_mode *mode);
> --
> git-series 0.9.1
