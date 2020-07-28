Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F65AC433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 10:38:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CFE420829
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 10:38:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="ch9uv/BU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728689AbgG1Kiq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 06:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728566AbgG1Kip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 06:38:45 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8817EC061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 03:38:44 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id d190so207134wmd.4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 03:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DRhCSmIwi420CrkXUO97I66VCQgr7S8ldVnLi+5FGbg=;
        b=ch9uv/BUJSu3oSt8k3ciCSYlMfuMBNGz6xnHGp7pe0JFdEOFJ4ONqGzURQRAVpZQ1j
         FpQuHTgSEqbQq93FZtOKunxuGNo5G93RAsJhiHdV53vHprAEkGR5j7f7MOkYEj3AE6/L
         F/Xmr7t+LMIJH+1FxKTk3VVDE1kZsnSHmLc/iwzXGpb3jFjkXVD83X43M3+SS1oXMZwe
         d95QywpZiGc1PhTdgVi1tXmGewQLRDgVNtCxvXTL4iW2P7US1j5HQWyuFUSO0yud6p5o
         sOa01w7Ly9jiTvl/9YTMcWdEM9F5NImbBJmv/sqK0/gHMfWTTX5K3lttaLayQLF9zVL5
         J/+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DRhCSmIwi420CrkXUO97I66VCQgr7S8ldVnLi+5FGbg=;
        b=DROxn8M/F4JPWCbATm0zscKwXuWsplRmKlygwrNYnf3K2M3OVpUGAD523ziXsxYR3g
         6alCWKE5717WTfqf7O8XCJ+xm7L1DZkMnquSWjRjeESA8nKl+KW0pxqlEkbFb4fy2SIb
         GDqTe+JNj/OQOpduOn/9pccbOQU0QWEJRYbOJwZ4MwzTF1gpsrmkjX1pMWphZyRzSZWe
         kxeY073OSiEYK2oxQHACvqeWEbOmY87J9TzXQ2Gd++udqZSiks8yj3t1hLHVJHP2pf/8
         xpSwaNx3GJxtDIBzLiBYg8d0YTBdXkJ5WVkDS61q7uRABh3GZao8qRbE74Whn6rNgT5O
         Xz+Q==
X-Gm-Message-State: AOAM532E/CAOdH0LC+gSvW7MwbubU6S0woocgSSC01JelmC5nw/R8B53
        TeNAVwMUgzHbFlS6JYrLjOYLEPiU3jRotFIeazl2xg==
X-Google-Smtp-Source: ABdhPJzMVUhIJzulRUVqA+fy1eEAHCtDW22IaZs5ZYJ9cfXiVcLmQKRVShFpKgdv8QsgsKC0gB+rAu5IHXaapNAg1r8=
X-Received: by 2002:a7b:cf18:: with SMTP id l24mr3417030wmg.116.1595932723328;
 Tue, 28 Jul 2020 03:38:43 -0700 (PDT)
MIME-Version: 1.0
References: <cover.7a1aa1784976093af26cb31fd283cf5b3ed568bb.1594230107.git-series.maxime@cerno.tech>
 <8bfc2e06f1c2a1f01151880e62e816b3ee629a75.1594230107.git-series.maxime@cerno.tech>
In-Reply-To: <8bfc2e06f1c2a1f01151880e62e816b3ee629a75.1594230107.git-series.maxime@cerno.tech>
From:   Dave Stevenson <dave.stevenson@raspberrypi.com>
Date:   Tue, 28 Jul 2020 11:38:26 +0100
Message-ID: <CAPY8ntBhc1VGj8tJhX6c1JjB8mcu8YfL3=T_8HyFgyznyi+bPA@mail.gmail.com>
Subject: Re: [PATCH v4 25/78] drm/vc4: crtc: Remove mode_set_nofb
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
> On BCM2711 to avoid stale pixels getting stuck in intermediate FIFOs, the
> pixelvalve needs to be setup each time there's a mode change or enable /
> disable sequence.
>
> Therefore, we can't really use mode_set_nofb anymore to configure it, but
> we need to move it to atomic_enable.
>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>

Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>

> ---
>  drivers/gpu/drm/vc4/vc4_crtc.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/vc4/vc4_crtc.c b/drivers/gpu/drm/vc4/vc4_crtc.c
> index 284a85b9d7d4..2eda2e6429ec 100644
> --- a/drivers/gpu/drm/vc4/vc4_crtc.c
> +++ b/drivers/gpu/drm/vc4/vc4_crtc.c
> @@ -376,11 +376,6 @@ static void vc4_crtc_config_pv(struct drm_crtc *crtc)
>         }
>  }
>
> -static void vc4_crtc_mode_set_nofb(struct drm_crtc *crtc)
> -{
> -       vc4_crtc_config_pv(crtc);
> -}
> -
>  static void require_hvs_enabled(struct drm_device *dev)
>  {
>         struct vc4_dev *vc4 = to_vc4_dev(dev);
> @@ -433,6 +428,7 @@ static void vc4_crtc_atomic_enable(struct drm_crtc *crtc,
>         require_hvs_enabled(dev);
>
>         vc4_crtc_pixelvalve_reset(crtc);
> +       vc4_crtc_config_pv(crtc);
>
>         CRTC_WRITE(PV_CONTROL, CRTC_READ(PV_CONTROL) | PV_CONTROL_EN);
>
> @@ -791,7 +787,6 @@ static const struct drm_crtc_funcs vc4_crtc_funcs = {
>  };
>
>  static const struct drm_crtc_helper_funcs vc4_crtc_helper_funcs = {
> -       .mode_set_nofb = vc4_crtc_mode_set_nofb,
>         .mode_valid = vc4_crtc_mode_valid,
>         .atomic_check = vc4_crtc_atomic_check,
>         .atomic_flush = vc4_hvs_atomic_flush,
> --
> git-series 0.9.1
