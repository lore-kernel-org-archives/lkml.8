Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 339A4C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 16:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D13920787
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 16:52:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=anholt-net.20150623.gappssmtp.com header.i=@anholt-net.20150623.gappssmtp.com header.b="hheOM/T3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731045AbgE0Qwv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 12:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731030AbgE0Qwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 12:52:47 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59D1AC05BD1E
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 09:52:47 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id q2so29749389ljm.10
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 09:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anholt-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3s8Z6TqgZ6rWtKMmi0vz86r9c3ZptE+7p8K+InML9XA=;
        b=hheOM/T3hgh3E9Yc0l9MkrAt26GKtRqNh6+lDuuRkJ/Z+uJHoSZl2dSFjgqp7BBq2L
         /SLxlWegH7b1a2tMbGhTqU9tk1RRu8RG6IgFKbDUfWCaHOMYtga8OzWAy6QPqhf6afE4
         BPHSLALrgxXbCKxk2lUBsDW7mQzcA5W1z6ovU9gQF7mTlBL1LR3YrrkKMxwQdgJtC1Ut
         U7d3H4vDH+D55QCG6JckSgD+23dcS96mwHuITUzmtasl8ytZgd9iNVVwwbWAHw1fvaPE
         kCJTA2dYBT45FIiwBmfqzZzr0+fDKMIxtpDKto1RUd6bnbcf/FYbBHHIeQMNoFLcbZ4N
         gfIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3s8Z6TqgZ6rWtKMmi0vz86r9c3ZptE+7p8K+InML9XA=;
        b=qGyUUafAVLzG1lhiSDDsAnyTNS+bYu5PC9q5D3WNVoSTu5lweoB6SlP15iufdfQOu6
         0NcjWyGuXBJShNJVUygDEtkipaaVgQbMKkfoxlaIS714/JwpnCqTrS00xx86ekgnrV/o
         pn3cTV9bYb2kgZOczNZ1cchEOKBfh5wXBLzANEDXWhdi/9SHCsuH0oKpGLVAfn0vReBw
         D0JaoGtLVAplndJYJ5lXrpvBBBjoBV8vC6hasHZXTCeCXGjML7qfnOXNtAfTe1X1IPzx
         kHaHoqi6Zequyya2rHzMwo/Y74kF6Os5sSxXUeVJQjO2R+l2HX2vHyoUceG3PWAN0ueB
         y0Ew==
X-Gm-Message-State: AOAM531bRItdJWS0pFr/EVZBXg7989gq4wV6m0WX2oPBKLzkEQA0sl2H
        o+rq4cbNa0d8zEnvpu5VOAQbfsYi0YQeSVg18U9nCg==
X-Google-Smtp-Source: ABdhPJykPtRUbq3wuH3bc4nCEgiCAkTCt706TKmwFiZu59fzrGES6YLoGp3T1oNdU87IWiuXxpt7gGN7IYPEMgs6uZM=
X-Received: by 2002:a2e:b0ec:: with SMTP id h12mr3253838ljl.269.1590598365768;
 Wed, 27 May 2020 09:52:45 -0700 (PDT)
MIME-Version: 1.0
References: <cover.aaf2100bd7da4609f8bcb8216247d4b4e4379639.1590594512.git-series.maxime@cerno.tech>
 <74d84c75511974bc1ff4bc044413894a43a907a6.1590594512.git-series.maxime@cerno.tech>
In-Reply-To: <74d84c75511974bc1ff4bc044413894a43a907a6.1590594512.git-series.maxime@cerno.tech>
From:   Eric Anholt <eric@anholt.net>
Date:   Wed, 27 May 2020 09:52:34 -0700
Message-ID: <CADaigPWzgP=C86D6zWN-z_tajFP8-F8GrQ-TcSzUt2cHcM8=8A@mail.gmail.com>
Subject: Re: [PATCH v3 020/105] drm/vc4: plane: Create overlays for any CRTC
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
> Now that we have everything in place, we can now register all the overlay
> planes that can be assigned to all the CRTCs.
>
> This has two side effects:
>
>   - The number of overlay planes is reduced from 24 to 8. This is temporary
>     and will be increased again in the next patch.
>
>   - The ID of the various planes is changed again, and we will now have all
>     the primary planes, then all the overlay planes and finally the cursor
>     planes. This shouldn't cause any issue since the ordering between
>     primary, overlay and cursor planes is preserved.
>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>

Honestly, I'd squash this with the previous two patches, the
individual refactors don't make much sense on their own or simplify
this patch I think.  Either way, patch 17-29 r-b.




> ---
>  drivers/gpu/drm/vc4/vc4_plane.c | 35 +++++++++++++++++-----------------
>  1 file changed, 18 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/gpu/drm/vc4/vc4_plane.c b/drivers/gpu/drm/vc4/vc4_plane.c
> index 824c188980b0..5335123ae2a0 100644
> --- a/drivers/gpu/drm/vc4/vc4_plane.c
> +++ b/drivers/gpu/drm/vc4/vc4_plane.c
> @@ -1378,26 +1378,27 @@ int vc4_plane_create_additional_planes(struct drm_device *drm)
>         struct drm_crtc *crtc;
>         unsigned int i;
>
> -       drm_for_each_crtc(crtc, drm) {
> -               /* Set up some arbitrary number of planes.  We're not limited
> -                * by a set number of physical registers, just the space in
> -                * the HVS (16k) and how small an plane can be (28 bytes).
> -                * However, each plane we set up takes up some memory, and
> -                * increases the cost of looping over planes, which atomic
> -                * modesetting does quite a bit.  As a result, we pick a
> -                * modest number of planes to expose, that should hopefully
> -                * still cover any sane usecase.
> -                */
> -               for (i = 0; i < 8; i++) {
> -                       struct drm_plane *plane =
> -                               vc4_plane_init(drm, DRM_PLANE_TYPE_OVERLAY);
> +       /* Set up some arbitrary number of planes.  We're not limited
> +        * by a set number of physical registers, just the space in
> +        * the HVS (16k) and how small an plane can be (28 bytes).
> +        * However, each plane we set up takes up some memory, and
> +        * increases the cost of looping over planes, which atomic
> +        * modesetting does quite a bit.  As a result, we pick a
> +        * modest number of planes to expose, that should hopefully
> +        * still cover any sane usecase.
> +        */
> +       for (i = 0; i < 8; i++) {
> +               struct drm_plane *plane =
> +                       vc4_plane_init(drm, DRM_PLANE_TYPE_OVERLAY);
>
> -                       if (IS_ERR(plane))
> -                               continue;
> +               if (IS_ERR(plane))
> +                       continue;
>
> -                       plane->possible_crtcs = drm_crtc_mask(crtc);
> -               }
> +               plane->possible_crtcs =
> +                       GENMASK(drm->mode_config.num_crtc - 1, 0);
> +       }
>
> +       drm_for_each_crtc(crtc, drm) {
>                 /* Set up the legacy cursor after overlay initialization,
>                  * since we overlay planes on the CRTC in the order they were
>                  * initialized.
> --
> git-series 0.9.1
