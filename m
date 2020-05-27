Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EED7EC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 16:45:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C03FD20721
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 16:45:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=anholt-net.20150623.gappssmtp.com header.i=@anholt-net.20150623.gappssmtp.com header.b="W1Cxi2bY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391449AbgE0QpL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 12:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387952AbgE0QpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 12:45:10 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 682A3C05BD1E
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 09:45:09 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id b6so29785068ljj.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 09:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anholt-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x5U/zKfkvmSEww+vSURoUmS0s1xUIVHLA1Nb4AtxJis=;
        b=W1Cxi2bY3PkaST1Z8OpeWGbMyEmo5P8jlNIwCdvVr+EjtPpX+j4R/HBMaMD7y4Dbz2
         sN2rfypqEM2mZkwCR0i0VC8WXHwpnf1WoXE9veH7nmHE1qcnAYL60rYjN5GtdbL7Er1s
         WzhIsrXN6NswcPYYrH1wEJ9LKSW6ea64X8zPbj5KzHqu6v6U4SOTWTD1ACj2AgEXeE6n
         Ow7zyaPtpdsM5IvuEpbGg6vrgBYIUyUwC4ri2NUosucaU5RmpJLrkxfAuYYsbvPM+u9v
         L7aHcngTSiHdWHOweNSQYkka0AxBsVpDzpNMA5BjYV4Hv/uBtOwPuqzDoOR/heOa38Sr
         dgyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x5U/zKfkvmSEww+vSURoUmS0s1xUIVHLA1Nb4AtxJis=;
        b=gBdiaNs/gvrxEBmm5V6rk2y7Y6U9fXo8KkGmsFuEx6smsK5qtVHTuTX97a6uWs5uSu
         5mvqbHSAVsVDWfX89dIf3Wujw5Dz99MQz9hfJR3qXsFIQuazpvmXZSgvcmzJUGA5fWg/
         fW0hlYKXAVbcp85yb9rx2NzdPSQElADKDuggUIMzS7v2f7kjakZghUvkJUmc5Lj+TLxV
         Q2Azj27vQ+lTxYzSCEcrA1hQKCKH0atLtBRCOQdJaZLPiokdOA915gT+JVwSf6dQNeV5
         OVFogLFxDxmiGPi83JHCPP+qhrLEZWGZnVRaG9shWhv8aT04e2SihnwjA9oy60a3fD90
         hrfw==
X-Gm-Message-State: AOAM53389d9gBX1pEglM41NKLManrQKQjTuYSdMJRsJhqGW/WN0m4hc2
        xIh85Vy/4yPeSZGRD2j2HkGntmnT7BXUl2hM9255lI9d
X-Google-Smtp-Source: ABdhPJzlE2zCA4ef3RAWHj2biI9Q1eAsYK7BNlo9EXKXBDmBQL0WWpSKBn/3tA9ID11/ogPIYEhxoy1NogcPeGz3zR4=
X-Received: by 2002:a2e:b0ec:: with SMTP id h12mr3241295ljl.269.1590597907811;
 Wed, 27 May 2020 09:45:07 -0700 (PDT)
MIME-Version: 1.0
References: <cover.aaf2100bd7da4609f8bcb8216247d4b4e4379639.1590594512.git-series.maxime@cerno.tech>
 <44e3ec27ee6c0d81c440cd2d6cdd1bf93ea102e7.1590594512.git-series.maxime@cerno.tech>
In-Reply-To: <44e3ec27ee6c0d81c440cd2d6cdd1bf93ea102e7.1590594512.git-series.maxime@cerno.tech>
From:   Eric Anholt <eric@anholt.net>
Date:   Wed, 27 May 2020 09:44:56 -0700
Message-ID: <CADaigPVbUZzo5c8fp9EqZsfrp44-09whu-HPk9c-eNc2KXS4Mg@mail.gmail.com>
Subject: Re: [PATCH v3 016/105] drm/vc4: plane: Improve LBM usage
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

On Wed, May 27, 2020 at 8:49 AM Maxime Ripard <maxime@cerno.tech> wrote:
>
> From: Dave Stevenson <dave.stevenson@raspberrypi.com>
>
> LBM allocations were always taking the worst case sizing of
> max(src_width, dst_width) * 16. This is significantly over
> the required sizing, and stops us rendering multiple 4k images
> to the screen.
>
> Add some of the additional constraints to more accurately
> describe the LBM requirements.
>
> Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---
>  drivers/gpu/drm/vc4/vc4_plane.c | 31 ++++++++++++++++++++-----------
>  1 file changed, 20 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/vc4/vc4_plane.c b/drivers/gpu/drm/vc4/vc4_plane.c
> index 1575c05e3106..602927745f84 100644
> --- a/drivers/gpu/drm/vc4/vc4_plane.c
> +++ b/drivers/gpu/drm/vc4/vc4_plane.c
> @@ -142,9 +142,10 @@ static const struct hvs_format *vc4_get_hvs_format(u32 drm_format)
>         return NULL;
>  }
>
> -static enum vc4_scaling_mode vc4_get_scaling_mode(u32 src, u32 dst)
> +static enum vc4_scaling_mode vc4_get_scaling_mode(u32 src, u32 dst,
> +                                                 bool chroma_vrep)
>  {
> -       if (dst == src)
> +       if (dst == src && !chroma_vrep)
>                 return VC4_SCALING_NONE;
>         if (3 * dst >= 2 * src)
>                 return VC4_SCALING_PPF;
> @@ -369,9 +370,11 @@ static int vc4_plane_setup_clipping_and_scaling(struct drm_plane_state *state)
>                 return ret;
>
>         vc4_state->x_scaling[0] = vc4_get_scaling_mode(vc4_state->src_w[0],
> -                                                      vc4_state->crtc_w);
> +                                                      vc4_state->crtc_w,
> +                                                      false);
>         vc4_state->y_scaling[0] = vc4_get_scaling_mode(vc4_state->src_h[0],
> -                                                      vc4_state->crtc_h);
> +                                                      vc4_state->crtc_h,
> +                                                      false);
>
>         vc4_state->is_unity = (vc4_state->x_scaling[0] == VC4_SCALING_NONE &&
>                                vc4_state->y_scaling[0] == VC4_SCALING_NONE);
> @@ -384,10 +387,12 @@ static int vc4_plane_setup_clipping_and_scaling(struct drm_plane_state *state)
>
>                 vc4_state->x_scaling[1] =
>                         vc4_get_scaling_mode(vc4_state->src_w[1],
> -                                            vc4_state->crtc_w);
> +                                            vc4_state->crtc_w,
> +                                            v_subsample == 2);
>                 vc4_state->y_scaling[1] =
>                         vc4_get_scaling_mode(vc4_state->src_h[1],
> -                                            vc4_state->crtc_h);
> +                                            vc4_state->crtc_h,
> +                                            v_subsample == 2);
>
>                 /* YUV conversion requires that horizontal scaling be enabled
>                  * on the UV plane even if vc4_get_scaling_mode() returned

The change above isn't mentioned in the commit message and I don't
understand what's going on.  It should be split out with an
explanation.

> @@ -437,10 +442,7 @@ static void vc4_write_ppf(struct vc4_plane_state *vc4_state, u32 src, u32 dst)
>  static u32 vc4_lbm_size(struct drm_plane_state *state)
>  {
>         struct vc4_plane_state *vc4_state = to_vc4_plane_state(state);
> -       /* This is the worst case number.  One of the two sizes will
> -        * be used depending on the scaling configuration.
> -        */
> -       u32 pix_per_line = max(vc4_state->src_w[0], (u32)vc4_state->crtc_w);
> +       u32 pix_per_line;
>         u32 lbm;
>
>         /* LBM is not needed when there's no vertical scaling. */
> @@ -448,6 +450,11 @@ static u32 vc4_lbm_size(struct drm_plane_state *state)
>             vc4_state->y_scaling[1] == VC4_SCALING_NONE)
>                 return 0;
>
> +       if (vc4_state->x_scaling[0] == VC4_SCALING_TPZ)
> +               pix_per_line = vc4_state->crtc_w;
> +       else
> +               pix_per_line = vc4_state->src_w[0];

Looks like it's also crtc_w for RGB or 4:4:4 and HPPF in (0.5,1.0].
Maybe drop a note in here that we're not covering that case, but src_w
> crtc_w so it's safe at least.

> +
>         if (!vc4_state->is_yuv) {
>                 if (vc4_state->y_scaling[0] == VC4_SCALING_TPZ)
>                         lbm = pix_per_line * 8;
> @@ -583,7 +590,9 @@ static int vc4_plane_allocate_lbm(struct drm_plane_state *state)
>                 spin_lock_irqsave(&vc4->hvs->mm_lock, irqflags);
>                 ret = drm_mm_insert_node_generic(&vc4->hvs->lbm_mm,
>                                                  &vc4_state->lbm,
> -                                                lbm_size, 32, 0, 0);
> +                                                lbm_size,
> +                                                vc4->hvs->hvs5 ? 64 : 32,
> +                                                0, 0);
>                 spin_unlock_irqrestore(&vc4->hvs->mm_lock, irqflags);
>
>                 if (ret)
> --
> git-series 0.9.1
