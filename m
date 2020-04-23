Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D3C2C55186
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 11:55:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3FF020857
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 11:55:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ijFQI1cU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728223AbgDWLz3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 07:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728200AbgDWLz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 07:55:27 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7EDAC035495
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 04:55:26 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id s5so5365201uad.4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 04:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EsVqTT5wXXhdTLsomAwxroQ1T+w0e7VVQswoorQRWuI=;
        b=ijFQI1cUWrlnvFTSLmAmYANFQVYYT0KLtxIWD4KQV76dY3HQy5sXwhskWitkENgJUk
         FRJcj876X/B2f8QB/wEo76RAmYiaCyHuFafl3aMhOy5qhbMbaoXj4+aN5L7HBP44LxbZ
         MOKv7xfXQ2BiOXG2HXichEwQ0IHnAODo3VpkI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EsVqTT5wXXhdTLsomAwxroQ1T+w0e7VVQswoorQRWuI=;
        b=jSIHG0N8GhDZzHLzEvDOxHzfThtrAlVWehx5iRluMKUuBVysVdRmE1m2KpWrvutJS/
         xwhh3Xq7tn9rCJ/qj2elSZk7HM6hN4G70acDCXaLTAZBpVT+PUsa6yY4Wmq/2QKMfbU9
         fl1FYvqXPas6ij80sadOEyid0dFPNkZBpD3KiGU3dEdtrYVBDXu9d+DtsxonPPotCetz
         wyFW3lpfM5mA/Z7Wry6ZEK4v+6f5fbY6nIdmHZlsWhdOpCK3hQpkMyDAtDxIEyGuyqP6
         F+AvooW/y52BrmFHUogtrNCtagx7AUhf+zFrjpt1Vx3UBktuGQXxtfi9/wFnewXYqQXZ
         DQgA==
X-Gm-Message-State: AGi0Pub9nZMerZRDCQqIW1HaXuZHX3zKsCkBn2KbnId+BTyXVJc624IV
        raBXS6UixgCVh6gki38hxdrNSk5Q10d1Z6zePWZ1lg==
X-Google-Smtp-Source: APiQypLuW645Sg7+l9AH4kIkM3J8fzdluHvCEFm1pFoq/7YjpI/mbTanqNvaw/UbOaEPxD+LGY9qmP//QPp/Bzlw/sw=
X-Received: by 2002:a05:6102:308b:: with SMTP id l11mr2597359vsb.14.1587642926008;
 Thu, 23 Apr 2020 04:55:26 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1582529411.git.xji@analogixsemi.com> <a81adcf2e79d440edcb7b3989f31efcb80a6e9ff.1582529411.git.xji@analogixsemi.com>
In-Reply-To: <a81adcf2e79d440edcb7b3989f31efcb80a6e9ff.1582529411.git.xji@analogixsemi.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Thu, 23 Apr 2020 19:55:15 +0800
Message-ID: <CANMq1KBfB6tXFqYGvr=8fV_bpCV5GbVHeEbRs+fuaZba65-OPw@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] drm/bridge: anx7625: Add anx7625 MIPI DSI/DPI to
 DP bridge driver
To:     Xin Ji <xji@analogixsemi.com>
Cc:     devel@driverdev.osuosl.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        lkml <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Pi-Hsun Shih <pihsun@chromium.org>,
        Sheng Pan <span@analogixsemi.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Just commenting on the mode_fixup function that was added in v7.

On Tue, Feb 25, 2020 at 2:15 PM Xin Ji <xji@analogixsemi.com> wrote:
>
> The ANX7625 is an ultra-low power 4K Mobile HD Transmitter designed
> for portable device. It converts MIPI DSI/DPI to DisplayPort 1.3 4K.
>
> The ANX7625 can support both USB Type-C PD feature and MIPI DSI/DPI
> to DP feature. This driver only enabled MIPI DSI/DPI to DP feature.
>
> Signed-off-by: Xin Ji <xji@analogixsemi.com>
> ---
>  drivers/gpu/drm/bridge/Makefile           |    2 +-
>  drivers/gpu/drm/bridge/analogix/Kconfig   |    6 +
>  drivers/gpu/drm/bridge/analogix/Makefile  |    1 +
>  drivers/gpu/drm/bridge/analogix/anx7625.c | 2172 +++++++++++++++++++++++++++++
>  drivers/gpu/drm/bridge/analogix/anx7625.h |  410 ++++++
>  5 files changed, 2590 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/gpu/drm/bridge/analogix/anx7625.c
>  create mode 100644 drivers/gpu/drm/bridge/analogix/anx7625.h
>
> diff --git a/drivers/gpu/drm/bridge/Makefile b/drivers/gpu/drm/bridge/Makefile
> index 4934fcf..bcd388a 100644
> --- a/drivers/gpu/drm/bridge/Makefile
> +++ b/drivers/gpu/drm/bridge/Makefile
[snip]
> +static bool anx7625_bridge_mode_fixup(struct drm_bridge *bridge,
> +                                     const struct drm_display_mode *mode,
> +                                     struct drm_display_mode *adj)
> +{
> +       struct anx7625_data *ctx = bridge_to_anx7625(bridge);
> +       struct device *dev = &ctx->client->dev;
> +       u32 hsync, hfp, hbp, hactive, hblanking;
> +       u32 adj_hsync, adj_hfp, adj_hbp, adj_hblanking, delta_adj;
> +       u32 vref, adj_clock;
> +
> +       DRM_DEV_DEBUG_DRIVER(dev, "drm mode fixup set\n");
> +
> +       mutex_lock(&ctx->lock);

Why do you need this lock?

> +
> +       hactive = mode->hdisplay;

This is never used, drop it?

> +       hsync = mode->hsync_end - mode->hsync_start;
> +       hfp = mode->hsync_start - mode->hdisplay;
> +       hbp = mode->htotal - mode->hsync_end;
> +       hblanking = mode->htotal - mode->hdisplay;
> +
> +       DRM_DEV_DEBUG_DRIVER(dev, "before mode fixup\n");
> +       DRM_DEV_DEBUG_DRIVER(dev, "hsync(%d),hfp(%d),hbp(%d),clock(%d)\n",
> +                            hsync,
> +                            hfp,
> +                            hbp,
> +                            adj->clock);
> +       DRM_DEV_DEBUG_DRIVER(dev, "hsync_start(%d),hsync_end(%d),htotal(%d)\n",
> +                            adj->hsync_start,
> +                            adj->hsync_end,
> +                            adj->htotal);
> +
> +       adj_hfp = hfp;
> +       adj_hsync = hsync;
> +       adj_hbp = hbp;
> +       adj_hblanking = hblanking;
> +
> +       /* plus 1 if hfp is odd */

A better way to word these comments is to say "hfp needs to be even",
otherwise, you're just repeating what we can already see in the code.

> +       if (hfp & 0x1) {
> +               adj_hfp = hfp + 1;

adj_hfp -= 1 for consistency?

> +               adj_hblanking += 1;
> +       }
> +
> +       /* minus 1 if hbp is odd */
> +       if (hbp & 0x1) {
> +               adj_hbp = hbp - 1;

ditto, adj_hbp -= 1;

> +               adj_hblanking -= 1;
> +       }
> +
> +       /* plus 1 if hsync is odd */
> +       if (hsync & 0x1) {
> +               if (adj_hblanking < hblanking)
> +                       adj_hsync = hsync + 1;

ditto

> +               else
> +                       adj_hsync = hsync - 1;

ditto

> +       }
> +
> +       /*
> +        * once illegal timing detected, use default HFP, HSYNC, HBP
> +        */
> +       if (hblanking < HBLANKING_MIN || (hfp < HP_MIN && hbp < HP_MIN)) {

should this be adj_hblanking/adj_hfp/adj_hbp?

> +               adj_hsync = SYNC_LEN_DEF;
> +               adj_hfp = HFP_HBP_DEF;
> +               adj_hbp = HFP_HBP_DEF;
> +               vref = adj->clock * 1000 / (adj->htotal * adj->vtotal);
> +               if (hblanking < HBLANKING_MIN) {
> +                       delta_adj = HBLANKING_MIN - hblanking;
> +                       adj_clock = vref * delta_adj * adj->vtotal;
> +                       adj->clock += DIV_ROUND_UP(adj_clock, 1000);
> +               } else {
> +                       delta_adj = hblanking - HBLANKING_MIN;
> +                       adj_clock = vref * delta_adj * adj->vtotal;
> +                       adj->clock -= DIV_ROUND_UP(adj_clock, 1000);
> +               }
> +
> +               DRM_WARN("illegal hblanking timing, use default.\n");
> +               DRM_WARN("hfp(%d),hbp(%d),hsync(%d).\n", hfp, hbp, hsync);

How likely is it that this mode is going to work? Can you just return
false here to reject the mode?

> +       } else if (adj_hfp < HP_MIN) {
> +               /* adjust hfp if hfp less than HP_MIN */
> +               delta_adj = HP_MIN - adj_hfp;
> +               adj_hfp = HP_MIN;
> +
> +               /*
> +                * balance total HBlanking pixel, if HBP hasn't enough space,

"does not have enough space"

> +                * adjust HSYNC length, otherwize adjust HBP

otherwise

> +                */
> +               if ((adj_hbp - delta_adj) < HP_MIN)
> +                       /* hbp not enough space */
> +                       adj_hsync -= delta_adj;
> +               else
> +                       adj_hbp -= delta_adj;
> +       } else if (adj_hbp < HP_MIN) {
> +               delta_adj = HP_MIN - adj_hbp;
> +               adj_hbp = HP_MIN;
> +
> +               /*
> +                * balance total HBlanking pixel, if HBP hasn't enough space,
> +                * adjust HSYNC length, otherwize adjust HBP
> +                */
> +               if ((adj_hfp - delta_adj) < HP_MIN)
> +                       /* hbp not enough space */
> +                       adj_hsync -= delta_adj;
> +               else
> +                       adj_hfp -= delta_adj;
> +       }
> +
> +       DRM_DEV_DEBUG_DRIVER(dev, "after mode fixup\n");
> +       DRM_DEV_DEBUG_DRIVER(dev, "hsync(%d),hfp(%d),hbp(%d),clock(%d)\n",

Add spaces after commas in your debug strings (same above and below).

> +                            adj_hsync,
> +                            adj_hfp,
> +                            adj_hbp,
> +                            adj->clock);

Put these 4 on a single line.

> +
> +       /* reconstruct timing */
> +       adj->hsync_start = adj->hdisplay + adj_hfp;
> +       adj->hsync_end = adj->hsync_start + adj_hsync;
> +       adj->htotal = adj->hsync_end + adj_hbp;
> +       DRM_DEV_DEBUG_DRIVER(dev, "hsync_start(%d),hsync_end(%d),htotal(%d)\n",
> +                            adj->hsync_start,
> +                            adj->hsync_end,
> +                            adj->htotal);
> +
> +       mutex_unlock(&ctx->lock);
> +
> +       return true;
> +}
> +
> [snip]
