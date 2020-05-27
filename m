Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7DABC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 16:27:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2AC620835
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 16:27:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=anholt-net.20150623.gappssmtp.com header.i=@anholt-net.20150623.gappssmtp.com header.b="tg9oAlgp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390078AbgE0Q1c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 12:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390050AbgE0Q1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 12:27:30 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09773C05BD1E
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 09:27:30 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id z22so14873744lfd.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 09:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anholt-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XMhd8kBFatjxSzyX/p3050Yxy/ALKXPMLe1zG6XyHx0=;
        b=tg9oAlgp7VoL+EBWwFKZCwxZNy5lyMQoLLYGxu4yU21LOLoOeptabgcOIvROr+RaB1
         6oUeR/F5grzuF0LSLIyDzq8DBWr8p0a8mc6PB+g8LiOBY0d36llnTQ/4gNghXAihICLb
         LF2BCjUirUHryM1vMjxs131Od0fDR0I/cKVFkskphzXRGwpuwsMFL0jCPeLhm1OPybx1
         +R9NO6yWU/Y7sbUoGmk3JcWkxYYhkyH76f25Nuu5Ix0e5o3tcYC8dKaG1fg0UsZonmSG
         HNvIx8E9lCYlPvNpMOn+TEbUNDM2e1ltKGgeo12aEF9cRVxOgr8Yf+Udq+PwMdOfPVox
         IL6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XMhd8kBFatjxSzyX/p3050Yxy/ALKXPMLe1zG6XyHx0=;
        b=loJAm5r3FPoBsb7wyukejnuTbo4UgVWlNAZv/gs64YUwHzXNz5WuFSs1mhQLY2hI3T
         tFFvD1npU1KST3TOgVVRXRRz+iGT3N7tsS1ZR4R9R4nc+j+S4yo3MJAJckuGE8lQULnU
         DRGIs4Ct+L6Bfq1MNDfCmhsniGxLl1IZmSugc8B5turdRK9V6nR1aPeXXPRIqnTpfqS+
         cp/llL4mglk2DT5a0Osc9j2NLpu4sDhcigl2nXS69I9hGWYzSAd5Kr+eWVCmEEpzxxBZ
         1+0WxeKY638Yl6TZU8+uAlPMZbzevnLPm3zgFmMlwmJk20/MJpSjUJobNhuNin3UNHSD
         CtCA==
X-Gm-Message-State: AOAM532o4RYjsG83XWofhmxpksPTlEQQKY7bBM2ImU+yXZVkVymaMfto
        279j56cq+jBJmPnN38SoQWplhRxkXTx803dDUDl0mA==
X-Google-Smtp-Source: ABdhPJxFvruh7NtW7OmnRsxfpA4KD4Sao+jVZ0SfkQQXEH279eVxlLFNAkd0wXGZRueXvW68axsCFwH8oNuW2YHoWP0=
X-Received: by 2002:a05:6512:3208:: with SMTP id d8mr3516857lfe.38.1590596848480;
 Wed, 27 May 2020 09:27:28 -0700 (PDT)
MIME-Version: 1.0
References: <cover.aaf2100bd7da4609f8bcb8216247d4b4e4379639.1590594512.git-series.maxime@cerno.tech>
 <49c552751ec619e03371bc4bb1b9ec66c8423bf7.1590594512.git-series.maxime@cerno.tech>
In-Reply-To: <49c552751ec619e03371bc4bb1b9ec66c8423bf7.1590594512.git-series.maxime@cerno.tech>
From:   Eric Anholt <eric@anholt.net>
Date:   Wed, 27 May 2020 09:27:17 -0700
Message-ID: <CADaigPU2YUoffXjaaBOxWRni3thKW9gM0+yr75TRgpeeW3CXaw@mail.gmail.com>
Subject: Re: [PATCH v3 012/105] drm/vc4: drv: Support BCM2711
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
> The BCM2711 has a reworked display pipeline, and the load tracker needs
> some adjustement to operate properly. Let's add a compatible for BCM2711
> and disable the load tracker until properly supported.
>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---
>  drivers/gpu/drm/vc4/vc4_drv.c   |  1 +-
>  drivers/gpu/drm/vc4/vc4_drv.h   |  3 ++-
>  drivers/gpu/drm/vc4/vc4_kms.c   | 42 +++++++++++++++++++++++-----------
>  drivers/gpu/drm/vc4/vc4_plane.c |  5 ++++-
>  4 files changed, 38 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/vc4/vc4_drv.c b/drivers/gpu/drm/vc4/vc4_drv.c
> index 76f93b662766..d7f554a6f0ed 100644
> --- a/drivers/gpu/drm/vc4/vc4_drv.c
> +++ b/drivers/gpu/drm/vc4/vc4_drv.c
> @@ -364,6 +364,7 @@ static int vc4_platform_drm_remove(struct platform_device *pdev)
>  }
>
>  static const struct of_device_id vc4_of_match[] = {
> +       { .compatible = "brcm,bcm2711-vc5", },
>         { .compatible = "brcm,bcm2835-vc4", },
>         { .compatible = "brcm,cygnus-vc4", },
>         {},

Patch 6 Acked-by: Eric Anholt <eric@anholt.net>
Patch 7-11 Reviewed-by: Eric Anholt <eric@anholt.net>

This one to start probing needs to move later in the series once the
vc5 support is actually present in the driver.
