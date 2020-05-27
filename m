Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 874D3C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 18:26:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 683612089D
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 18:26:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=anholt-net.20150623.gappssmtp.com header.i=@anholt-net.20150623.gappssmtp.com header.b="jVDU6dAI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391976AbgE0S00 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 14:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389214AbgE0S0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 14:26:25 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E41FC08C5C1
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 11:26:25 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id z18so30121198lji.12
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 11:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anholt-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QB7YwKLcAEW/NVxETJ/RRwZrpqw1ubcJORL5utvFFXU=;
        b=jVDU6dAIH5AMHvUenFCLEWc4e55tCqNJdfkNlGCKtdQ94FJ2ncc6VGQQ6rttsFcAyl
         dqtMPPBIon1Ieua2HOivG/UGPk9Ax02cmVxtlqyXA4gNg4qCWoTPim7JDk6SxP0y+Snc
         KqNNJXD4/Fwdr13n9LZMd/DSXHh7ebYllwc7RsOiaeEfmid5gUShCMZoJaA/zHhugQ+3
         vXiq57zCHznETZPv6jo2AMUFiicPgZ5MgBnBGNQ2/aZdxQdxbjj4kALa2fBrOfUuIFU2
         2SKqQuH6ewCZ4tiwHO47DhJaRPS5pt/diRpda0vF7ojfHnwoJpJnohxNt+gtNrB5K2Ax
         G+Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QB7YwKLcAEW/NVxETJ/RRwZrpqw1ubcJORL5utvFFXU=;
        b=Qqptq0+Rv9Nk4S9QGPJMprte4Qahxqc3SUrNAGYxGzkffr5i6L5+xMl/Ue6AVLqJtv
         0nDgTfOll1xWGDZiyzUxcfc0DVb2QzJ8zHCs/4d/YzN68HuLTdg1ZAECqjzjRYbxZteV
         ElV4bdlAdMIgdfOBi7v892JCfBhEWZsMekjaVjEJ+Gf1/XTZ2n/4hJTsidBxVmglK1x8
         EGEnbvtYD7osr6b3tZjzsNeU85nGkNSQRv7aD15RXKqkCUvT8zOFuNN9An40+ZkAE6T7
         BdUSNfXOCFZNU6URNrAEUaktI3wijuypanJuinAqj9uEeUWmK0jhEXRDlYhK59Qf2yG8
         gfJw==
X-Gm-Message-State: AOAM533PdQhgj3i4uXybZRVlNU/tk3yQ00S6cwqPD7cu7RmgPjjk99Rt
        gaV6yJp2YIfvkPOE4Xi+35is4OQIjs7RZyHUPv/XwA==
X-Google-Smtp-Source: ABdhPJxA8oAlyNouzKzEzxB2DjfrFnm6s4bMaRIjUr0L/MTi6rlsrHzCde2XffFmTHZekkBhimOM52uiHfe7MBRTvrc=
X-Received: by 2002:a2e:8186:: with SMTP id e6mr3843593ljg.252.1590603983554;
 Wed, 27 May 2020 11:26:23 -0700 (PDT)
MIME-Version: 1.0
References: <cover.aaf2100bd7da4609f8bcb8216247d4b4e4379639.1590594512.git-series.maxime@cerno.tech>
 <afcc607bdcaf9ad38480f49cc1fa186ebe6f2d5a.1590594512.git-series.maxime@cerno.tech>
In-Reply-To: <afcc607bdcaf9ad38480f49cc1fa186ebe6f2d5a.1590594512.git-series.maxime@cerno.tech>
From:   Eric Anholt <eric@anholt.net>
Date:   Wed, 27 May 2020 11:26:12 -0700
Message-ID: <CADaigPUFP5QXCbE81kFnwJPGO1GjvmoaKK28BhbEUNnJ4Pc0jg@mail.gmail.com>
Subject: Re: [PATCH v3 041/105] drm/vc4: crtc: Move HVS mode config to HVS file
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 8:50 AM Maxime Ripard <maxime@cerno.tech> wrote:
>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---
>  drivers/gpu/drm/vc4/vc4_crtc.c | 272 +-------------------------------
>  drivers/gpu/drm/vc4/vc4_drv.h  |   5 +-
>  drivers/gpu/drm/vc4/vc4_hvs.c  | 298 ++++++++++++++++++++++++++++++++++-
>  3 files changed, 309 insertions(+), 266 deletions(-)


>  static void vc4_crtc_mode_set_nofb(struct drm_crtc *crtc)
>  {
> -       struct drm_device *dev = crtc->dev;
> -       struct vc4_dev *vc4 = to_vc4_dev(dev);
>         struct vc4_crtc *vc4_crtc = to_vc4_crtc(crtc);
>         struct vc4_crtc_state *vc4_state = to_vc4_crtc_state(crtc->state);
> -       struct drm_display_mode *mode = &crtc->state->adjusted_mode;
> -       bool interlace = mode->flags & DRM_MODE_FLAG_INTERLACE;
>         bool debug_dump_regs = false;
>
>         if (debug_dump_regs) {
> @@ -418,42 +372,10 @@ static void vc4_crtc_mode_set_nofb(struct drm_crtc *crtc)
>                 drm_print_regset32(&p, &vc4_crtc->regset);
>         }
>
> -       if (vc4_crtc->data->hvs_output == 2) {
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

I just noticed, this block being moved looks like it should probably
have been removed as part of patch #33.  Cleaning this up I think will
impact the following patches.
