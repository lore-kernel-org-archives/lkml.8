Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 562D6C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 19:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A12D2089D
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 19:25:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=anholt-net.20150623.gappssmtp.com header.i=@anholt-net.20150623.gappssmtp.com header.b="u+9b6a0U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726114AbgE0TY5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 15:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbgE0TY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 15:24:56 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33AD0C05BD1E
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 12:24:56 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id z13so20690820ljn.7
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 12:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anholt-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B06LJB5h/zgyW4gA7PYFxNZx20JgVf522YB+3F5h4TA=;
        b=u+9b6a0UuzqNEdKrRRYp74xaFel684WNim59ka+OYrYbmLKL+H/nprkX7vFkVdiCUa
         +O86fHKLZqw/5tvWP3hqw33ak6tHjf4NSI1j5fKipCDJdZkSuCUv1XCSLH8Tfb6vMsFa
         +KsDYhqcUq9p3f4rUyvTwRp9v9Amptoi+GEESpmqsgMwwWNwe5Zu3KFM4nYbIyauEQQW
         Usd8sT8LWVX1IsdfL24D+BCSQx7pVofPBfOZl09tfusTjauehsiP52sutkoRRUjTp+ui
         nESEZOg8iF63hA/Zd9X5L9zSoARxejFqZOUOXEg2msmKduDEaDnFqQPCGDpRoIWyLiqu
         vDtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B06LJB5h/zgyW4gA7PYFxNZx20JgVf522YB+3F5h4TA=;
        b=BSTZB6/dKecnc/pIxZMvTdZjM7ep9F6tzA73Mm4VG36ynLTKYprh6olMdWwWJ4qXHk
         xzjNeJCA7VgrQFgR2YHAdWFEW9/qWuju/448dDj+itT9HT4lWZIfznSxnXRZyDOMyHus
         v+BSZ6RxXC6HLghrJcRPPzXXmiALJGoik5wvMNpoIVE2OGPwpLSS80hmkcl1Pyn9UVm+
         YK12wP0KVIChLU542bPiY+6KAmuMvNUO5wYeLajF7rKp5D4rE6WzmwC90pUGtYgAaJjA
         8nBoZu0OSCMqweUCfUtVvix+UB1AxmEx5F/96fMCkyBDZJYKbYAtDksRxf0LzqeqpOuk
         vk7w==
X-Gm-Message-State: AOAM5333olJj+MvWavUabBKCbuh37JdhSo1N3NH5UcXh9697XE/qvVY9
        b4lLtPCbPvJIoQyY8rvMeB1Lh0LFrg1GrC9YIeO1CA==
X-Google-Smtp-Source: ABdhPJwwWyamvPVDkwG/N5cdNWA1k5bhKyYHl2B8H32SDSArpyPTtBHqXMrv/ns/v1MgZiZHuBPsS7jNbWkMbQJkOuA=
X-Received: by 2002:a2e:b0ec:: with SMTP id h12mr3493066ljl.269.1590607494583;
 Wed, 27 May 2020 12:24:54 -0700 (PDT)
MIME-Version: 1.0
References: <cover.aaf2100bd7da4609f8bcb8216247d4b4e4379639.1590594512.git-series.maxime@cerno.tech>
 <eb489952ba212a84dbe3d369371c0ee75b9a2d3e.1590594512.git-series.maxime@cerno.tech>
In-Reply-To: <eb489952ba212a84dbe3d369371c0ee75b9a2d3e.1590594512.git-series.maxime@cerno.tech>
From:   Eric Anholt <eric@anholt.net>
Date:   Wed, 27 May 2020 12:24:43 -0700
Message-ID: <CADaigPXm-ap=FxVV0_BPJmoL7A2cteVcD+EU3i954ParbyP7wA@mail.gmail.com>
Subject: Re: [PATCH v3 059/105] drm/vc4: crtc: Add BCM2711 pixelvalves
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
> The BCM2711 has 5 pixelvalves, so now that our driver is ready, let's add
> support for them.
>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---
>  drivers/gpu/drm/vc4/vc4_crtc.c | 84 ++++++++++++++++++++++++++++++++++-
>  drivers/gpu/drm/vc4/vc4_regs.h |  6 +++-
>  2 files changed, 88 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/vc4/vc4_crtc.c b/drivers/gpu/drm/vc4/vc4_crtc.c
> index 9efd7cb25590..a577ed8f929f 100644
> --- a/drivers/gpu/drm/vc4/vc4_crtc.c
> +++ b/drivers/gpu/drm/vc4/vc4_crtc.c
> @@ -229,6 +229,13 @@ static u32 vc4_get_fifo_full_level(struct vc4_crtc *vc4_crtc, u32 format)
>         case PV_CONTROL_FORMAT_24:
>         case PV_CONTROL_FORMAT_DSIV_24:
>         default:
> +               /*
> +                * For some reason, the pixelvalve4 doesn't work with
> +                * the usual formula and will only work with 32.
> +                */
> +               if (vc4_crtc->data->hvs_output == 5)
> +                       return 32;
> +
>                 return fifo_len_bytes - 3 * HVS_FIFO_LATENCY_PIX;
>         }
>  }
> @@ -237,9 +244,14 @@ static u32 vc4_crtc_get_fifo_full_level_bits(struct vc4_crtc *vc4_crtc,
>                                              u32 format)
>  {
>         u32 level = vc4_get_fifo_full_level(vc4_crtc, format);
> +       u32 ret = 0;
>
> -       return VC4_SET_FIELD(level & 0x3f,
> -                            PV_CONTROL_FIFO_LEVEL);
> +       if (level > 0x3f)
> +               ret |= VC4_SET_FIELD((level >> 6) & 0x3,
> +                                    PV5_CONTROL_FIFO_LEVEL_HIGH);
> +

I would drop the conditional here (ORing in zero is fine), and also
the & 3 because it would be good to get a warning if you picked a fifo
full level that doesn't fit in the field.

> +       return ret | VC4_SET_FIELD(level & 0x3f,
> +                                  PV_CONTROL_FIFO_LEVEL);
>  }
>
>  /*
> @@ -277,6 +289,8 @@ static void vc4_crtc_pixelvalve_reset(struct drm_crtc *crtc)
>
>  static void vc4_crtc_config_pv(struct drm_crtc *crtc)
>  {
> +       struct drm_device *dev = crtc->dev;
> +       struct vc4_dev *vc4 = to_vc4_dev(dev);
>         struct drm_encoder *encoder = vc4_get_crtc_encoder(crtc);
>         struct vc4_encoder *vc4_encoder = to_vc4_encoder(encoder);
>         struct vc4_crtc *vc4_crtc = to_vc4_crtc(crtc);
> @@ -356,6 +370,10 @@ static void vc4_crtc_config_pv(struct drm_crtc *crtc)
>         if (is_dsi)
>                 CRTC_WRITE(PV_HACT_ACT, mode->hdisplay * pixel_rep);
>
> +       if (vc4->hvs->hvs5)
> +               CRTC_WRITE(PV_MUX_CFG,
> +                          VC4_SET_FIELD(8, PV_MUX_CFG_RGB_PIXEL_MUX_MODE));

Can we get some #defines in the reg header instead of a magic value?

Other than that, r-b.
