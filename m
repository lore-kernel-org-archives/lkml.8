Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D078C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 10:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CA5020786
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 10:40:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="e3aiC4Ga"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728779AbgG1Kk4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 06:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728638AbgG1Kkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 06:40:55 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7265BC061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 03:40:55 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id 88so17781236wrh.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 03:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lnyqa9+3UN7p5XZc/yQA8t0Ef1omNto0wwGE8iK64Ps=;
        b=e3aiC4Ga9fB5qgGr4vSAQOSNMC2YJanljK0xzwO/FP4PPvt4fKWeox5e9QSIaR9h96
         IbzHkgQBD67HcVVpAT47x4pZJXUzgKMfdJlOxVMfudCxZyMV0H898UN41v99WtdO3FXg
         5y2BC0wmfHDqg/T0lvaFMrwADmgBol2r9uPe+XHXoBpp5gdJqNKp7s8cDbQv82rk7iBn
         HO+sWneuhPvWCe9pdI2njLORejD4fY2xkXz8bODjpslSW65Cj22z/lxln2Lg+enHw4Gz
         fkihrFRGvRXdQDemmYZoELVUnUzb1ZKsGVAZYFfq3lGyEmGQzKxGxzaEfhuZBqlXRq6c
         8+dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lnyqa9+3UN7p5XZc/yQA8t0Ef1omNto0wwGE8iK64Ps=;
        b=labc/vy2tU69TYO9Ny93ZoN1dR9W6YnH2zOjheCr/EENC9d6TeYopMv68tQkB/ioAT
         NmcIv5C06pCks1ydMxJIUqPUlXOJ1tKTv4l2WvGln/dXb9/2TfADMCSPH+KhqIZZcytj
         xE2jeevlk+BXntW78KPDYgU7Prrr3N4+Ngl7MA+3iWQ1dxvYDRz30mFlX1vz2McpNMhX
         1XJ0ES0m9oqLzM6e/mMR1LO0gU6pQCMDb3o+tXOWdZA3EaV/X2nUphKYQmW9CUXrMvm6
         DBY0Wfm4O+shlAnHOBrpwAetGKbfcxLNQBRj+i9V5E35YtDoQuRiMDym9QzLw+dshIGb
         vBGw==
X-Gm-Message-State: AOAM530fhch4g5sw76oLW03hFkYqmafMLL7c+aYibcjO+2pczN0//ipl
        jJYqcyypP7el6oLfu5Oq8xvizX5rjLt6dtKFMgaktw==
X-Google-Smtp-Source: ABdhPJwkPgquSiZ/upn1u2Q3I/tb+BHEawcLufuM8QtrW8LQqxXEhYjzDPG3DmSmELIhw4QHnc6qRbH4fzIAr0B2i1Q=
X-Received: by 2002:a5d:6681:: with SMTP id l1mr23292071wru.47.1595932854229;
 Tue, 28 Jul 2020 03:40:54 -0700 (PDT)
MIME-Version: 1.0
References: <cover.7a1aa1784976093af26cb31fd283cf5b3ed568bb.1594230107.git-series.maxime@cerno.tech>
 <03aa26eb5be1c558e3048a3b4ff3214856d5c490.1594230107.git-series.maxime@cerno.tech>
In-Reply-To: <03aa26eb5be1c558e3048a3b4ff3214856d5c490.1594230107.git-series.maxime@cerno.tech>
From:   Dave Stevenson <dave.stevenson@raspberrypi.com>
Date:   Tue, 28 Jul 2020 11:40:37 +0100
Message-ID: <CAPY8ntDeMAuDb1ZWj59+14ZQVqDjM7X+E312Lymm0P8LHFx0Yg@mail.gmail.com>
Subject: Re: [PATCH v4 27/78] drm/vc4: crtc: Move HVS channel init before the
 PV initialisation
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
> In order to avoid stale pixels getting stuck in an intermediate FIFO
> between the HVS and the pixelvalve on BCM2711, we need to configure the HVS
> channel before the pixelvalve is reset and configured.
>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>

Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>

> ---
>  drivers/gpu/drm/vc4/vc4_crtc.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/vc4/vc4_crtc.c b/drivers/gpu/drm/vc4/vc4_crtc.c
> index 2c5ff45dc315..b7b0e19e2fe1 100644
> --- a/drivers/gpu/drm/vc4/vc4_crtc.c
> +++ b/drivers/gpu/drm/vc4/vc4_crtc.c
> @@ -427,10 +427,6 @@ static void vc4_crtc_atomic_enable(struct drm_crtc *crtc,
>
>         require_hvs_enabled(dev);
>
> -       vc4_crtc_config_pv(crtc);
> -
> -       CRTC_WRITE(PV_CONTROL, CRTC_READ(PV_CONTROL) | PV_CONTROL_EN);
> -
>         /* Enable vblank irq handling before crtc is started otherwise
>          * drm_crtc_get_vblank() fails in vc4_crtc_update_dlist().
>          */
> @@ -438,6 +434,10 @@ static void vc4_crtc_atomic_enable(struct drm_crtc *crtc,
>
>         vc4_hvs_atomic_enable(crtc, old_state);
>
> +       vc4_crtc_config_pv(crtc);
> +
> +       CRTC_WRITE(PV_CONTROL, CRTC_READ(PV_CONTROL) | PV_CONTROL_EN);
> +
>         /* When feeding the transposer block the pixelvalve is unneeded and
>          * should not be enabled.
>          */
> --
> git-series 0.9.1
