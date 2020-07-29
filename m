Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7172C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 14:43:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B81B720809
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 14:43:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="OG5EldDE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbgG2OnP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 10:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbgG2OnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 10:43:15 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B620EC061794
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 07:43:14 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id p14so2967826wmg.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 07:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wd61Bbp9ukgeA9Chq75iGFckRsvukuJaOV9sT03x+48=;
        b=OG5EldDEwNlD9cxTierr+fUm2xb5qV3Pm2ihUpCVFluLtG85Na7ozcsIz4ro2MsILb
         dtWgwO1md/MNqjPwiEXxkOE440Hz5oNVbjbkVNBSYn1a+EIjXNNur4ofrXFdyJKsEvLk
         lpGOfqeFxlhd0BaJgKXASjH9aWGymd9nd85sug879ctdNp2muWe8MkvbR7UCLNJX1CtI
         G14YrXsH7QLXWVzM7I6wxGlTcuG8nU85f6vNNboNXefJvEXMwYFcFudfXJxhcu+iWgvK
         Kwb8MZn2bZZdcjZTDKaIO3HEbN9RIq3+FJCqFZbwroCJmT86hzSf00jDZcx0sigP7g+a
         dyng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wd61Bbp9ukgeA9Chq75iGFckRsvukuJaOV9sT03x+48=;
        b=gQoR7JAIyinnFcZVShO18ZdbQZy3GRb/N4qqgfHxTU+s7o5lq/eOFdEK4+cA4OEoCy
         kmzktcyYpveLji9o5dwIJDSSU+nE5RFwqUipXUArekevRC2wG6vVtaoYgveLGc+oFay6
         U9M/tslu0/wY9o55WmjjM4P4JahnIiaVRgNwtQUbUvlA/bPp5oyKi6ArbZNx/+66VQtU
         ncYM0ohRq/tRXtXa6K68SwGdkA7TY6zU3wrE8fUo5oL6+zGGPsm5Q1aCakBnnMXwPKSu
         VmZtAgSpHyEpFJd0+7Ts+c7/kPhYedZI44cAEJos9ifRTLDjlNioqkeYLpP/hQY0+sj9
         0PzQ==
X-Gm-Message-State: AOAM532dtwJuBz7DOrnPvD71QE19R/hVLTw4wY7BLhmheIjs5FMRbCxQ
        Ps7TS/JOq4/tfZMz/nyXLbi5MOidRDsTWu4cPKV/Fg==
X-Google-Smtp-Source: ABdhPJy3mR2QPQLt8ZWC7EQcPTfuGgEJLKjzXyye2XbQ4GaXVMFnr52bXDKHL24OZKHgZ1GIoThbGmJzND3CSjaSBb4=
X-Received: by 2002:a1c:e382:: with SMTP id a124mr8417867wmh.96.1596033793425;
 Wed, 29 Jul 2020 07:43:13 -0700 (PDT)
MIME-Version: 1.0
References: <cover.7a1aa1784976093af26cb31fd283cf5b3ed568bb.1594230107.git-series.maxime@cerno.tech>
 <e9e7b46a827d430d402b22cc25d31e6002dead1d.1594230107.git-series.maxime@cerno.tech>
In-Reply-To: <e9e7b46a827d430d402b22cc25d31e6002dead1d.1594230107.git-series.maxime@cerno.tech>
From:   Dave Stevenson <dave.stevenson@raspberrypi.com>
Date:   Wed, 29 Jul 2020 15:42:54 +0100
Message-ID: <CAPY8ntB4_rRNaxLkqrYRamegbvrbCir0gnTBoUpyumj+FwxneQ@mail.gmail.com>
Subject: Re: [PATCH v4 23/78] drm/vc4: crtc: Move the HVS gamma LUT setup to
 our init function
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Eric Anholt <eric@anholt.net>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime

On Wed, 8 Jul 2020 at 18:43, Maxime Ripard <maxime@cerno.tech> wrote:
>
> Since most of the HVS channel is setup in the init function, let's move the
> gamma setup there too. As this makes the HVS mode_set function empty, let's
> remove it in the process.
>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>

Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>

> ---
>  drivers/gpu/drm/vc4/vc4_crtc.c |  2 +-
>  drivers/gpu/drm/vc4/vc4_drv.h  |  1 +-
>  drivers/gpu/drm/vc4/vc4_hvs.c  | 59 +++++++++--------------------------
>  drivers/gpu/drm/vc4/vc4_txp.c  |  1 +-
>  4 files changed, 16 insertions(+), 47 deletions(-)
>
> diff --git a/drivers/gpu/drm/vc4/vc4_crtc.c b/drivers/gpu/drm/vc4/vc4_crtc.c
> index 181d3fd57bc7..284a85b9d7d4 100644
> --- a/drivers/gpu/drm/vc4/vc4_crtc.c
> +++ b/drivers/gpu/drm/vc4/vc4_crtc.c
> @@ -379,8 +379,6 @@ static void vc4_crtc_config_pv(struct drm_crtc *crtc)
>  static void vc4_crtc_mode_set_nofb(struct drm_crtc *crtc)
>  {
>         vc4_crtc_config_pv(crtc);
> -
> -       vc4_hvs_mode_set_nofb(crtc);
>  }
>
>  static void require_hvs_enabled(struct drm_device *dev)
> diff --git a/drivers/gpu/drm/vc4/vc4_drv.h b/drivers/gpu/drm/vc4/vc4_drv.h
> index 4126506b3a69..dfcc684f5d28 100644
> --- a/drivers/gpu/drm/vc4/vc4_drv.h
> +++ b/drivers/gpu/drm/vc4/vc4_drv.h
> @@ -904,7 +904,6 @@ int vc4_hvs_atomic_check(struct drm_crtc *crtc, struct drm_crtc_state *state);
>  void vc4_hvs_atomic_enable(struct drm_crtc *crtc, struct drm_crtc_state *old_state);
>  void vc4_hvs_atomic_disable(struct drm_crtc *crtc, struct drm_crtc_state *old_state);
>  void vc4_hvs_atomic_flush(struct drm_crtc *crtc, struct drm_crtc_state *state);
> -void vc4_hvs_mode_set_nofb(struct drm_crtc *crtc);
>  void vc4_hvs_dump_state(struct drm_device *dev);
>  void vc4_hvs_unmask_underrun(struct drm_device *dev, int channel);
>  void vc4_hvs_mask_underrun(struct drm_device *dev, int channel);
> diff --git a/drivers/gpu/drm/vc4/vc4_hvs.c b/drivers/gpu/drm/vc4/vc4_hvs.c
> index 78bb1c0b0b76..c7de77afbf0a 100644
> --- a/drivers/gpu/drm/vc4/vc4_hvs.c
> +++ b/drivers/gpu/drm/vc4/vc4_hvs.c
> @@ -201,6 +201,8 @@ static int vc4_hvs_init_channel(struct vc4_dev *vc4, struct drm_crtc *crtc,
>  {
>         struct vc4_crtc_state *vc4_crtc_state = to_vc4_crtc_state(crtc->state);
>         unsigned int chan = vc4_crtc_state->assigned_channel;
> +       bool interlace = mode->flags & DRM_MODE_FLAG_INTERLACE;
> +       u32 dispbkgndx;
>         u32 dispctrl;
>
>         /* Turn on the scaler, which will wait for vstart to start
> @@ -225,6 +227,20 @@ static int vc4_hvs_init_channel(struct vc4_dev *vc4, struct drm_crtc *crtc,
>
>         HVS_WRITE(SCALER_DISPCTRLX(chan), dispctrl);
>
> +       dispbkgndx = HVS_READ(SCALER_DISPBKGNDX(chan));
> +       dispbkgndx &= ~SCALER_DISPBKGND_GAMMA;
> +       dispbkgndx &= ~SCALER_DISPBKGND_INTERLACE;
> +
> +       HVS_WRITE(SCALER_DISPBKGNDX(chan), dispbkgndx |
> +                 SCALER_DISPBKGND_AUTOHS |
> +                 ((!vc4->hvs->hvs5) ? SCALER_DISPBKGND_GAMMA : 0) |
> +                 (interlace ? SCALER_DISPBKGND_INTERLACE : 0));
> +
> +       /* Reload the LUT, since the SRAMs would have been disabled if
> +        * all CRTCs had SCALER_DISPBKGND_GAMMA unset at once.
> +        */
> +       vc4_hvs_lut_load(crtc);
> +
>         return 0;
>  }
>
> @@ -421,49 +437,6 @@ void vc4_hvs_atomic_flush(struct drm_crtc *crtc,
>         }
>  }
>
> -void vc4_hvs_mode_set_nofb(struct drm_crtc *crtc)
> -{
> -       struct drm_device *dev = crtc->dev;
> -       struct vc4_dev *vc4 = to_vc4_dev(dev);
> -       struct vc4_crtc_state *vc4_state = to_vc4_crtc_state(crtc->state);
> -       struct drm_display_mode *mode = &crtc->state->adjusted_mode;
> -       bool interlace = mode->flags & DRM_MODE_FLAG_INTERLACE;
> -
> -       if (vc4_state->assigned_channel == 2) {
> -               u32 dispctrl;
> -               u32 dsp3_mux;
> -
> -               /*
> -                * SCALER_DISPCTRL_DSP3 = X, where X < 2 means 'connect DSP3 to
> -                * FIFO X'.
> -                * SCALER_DISPCTRL_DSP3 = 3 means 'disable DSP 3'.
> -                *
> -                * DSP3 is connected to FIFO2 unless the transposer is
> -                * enabled. In this case, FIFO 2 is directly accessed by the
> -                * TXP IP, and we need to disable the FIFO2 -> pixelvalve1
> -                * route.
> -                */
> -               if (vc4_state->feed_txp)
> -                       dsp3_mux = VC4_SET_FIELD(3, SCALER_DISPCTRL_DSP3_MUX);
> -               else
> -                       dsp3_mux = VC4_SET_FIELD(2, SCALER_DISPCTRL_DSP3_MUX);
> -
> -               dispctrl = HVS_READ(SCALER_DISPCTRL) &
> -                          ~SCALER_DISPCTRL_DSP3_MUX_MASK;
> -               HVS_WRITE(SCALER_DISPCTRL, dispctrl | dsp3_mux);
> -       }
> -
> -       HVS_WRITE(SCALER_DISPBKGNDX(vc4_state->assigned_channel),
> -                 SCALER_DISPBKGND_AUTOHS |
> -                 ((!vc4->hvs->hvs5) ? SCALER_DISPBKGND_GAMMA : 0) |
> -                 (interlace ? SCALER_DISPBKGND_INTERLACE : 0));
> -
> -       /* Reload the LUT, since the SRAMs would have been disabled if
> -        * all CRTCs had SCALER_DISPBKGND_GAMMA unset at once.
> -        */
> -       vc4_hvs_lut_load(crtc);
> -}
> -
>  void vc4_hvs_mask_underrun(struct drm_device *dev, int channel)
>  {
>         struct vc4_dev *vc4 = to_vc4_dev(dev);
> diff --git a/drivers/gpu/drm/vc4/vc4_txp.c b/drivers/gpu/drm/vc4/vc4_txp.c
> index a2380d856000..849dcafbfff1 100644
> --- a/drivers/gpu/drm/vc4/vc4_txp.c
> +++ b/drivers/gpu/drm/vc4/vc4_txp.c
> @@ -436,7 +436,6 @@ static const struct drm_crtc_helper_funcs vc4_txp_crtc_helper_funcs = {
>         .atomic_flush   = vc4_hvs_atomic_flush,
>         .atomic_enable  = vc4_txp_atomic_enable,
>         .atomic_disable = vc4_txp_atomic_disable,
> -       .mode_set_nofb  = vc4_hvs_mode_set_nofb,
>  };
>
>  static irqreturn_t vc4_txp_interrupt(int irq, void *data)
> --
> git-series 0.9.1
