Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4249EC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 15:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2213121D95
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 15:10:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="oPm1eOTK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730645AbgG1PKQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 11:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730556AbgG1PKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 11:10:15 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A80E2C061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 08:10:13 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id c80so17646887wme.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 08:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yoaV8EiIxu54dsFIyU0qdvYTV9Nos1kcoN3M/Zvq+Z8=;
        b=oPm1eOTKzWnAqS5MU6mSlSrX5N1BhOrhoJz8NsUIH4WoueF1QeJdRlXIuDeIbPw/1R
         V15xq8XH1hmSvtP0/JmCEw5PGrzsLToKzbXYE3dqAOl5/0jb4MRPaAmQ2ORdHUcFbdHe
         DZX1uNWDKlhEcmvzcQSlxOCnTj8r9QfxvxERm16MIn9heQtAUFMpazXta1UyzxhN3rw4
         GalYPH8T1XcfqzmBhftP+J0AndZznl0EcTSLLYD4CA7Y3d81IR4gydyEthoR35CLjy7b
         BGMasywv/e+ePgnSYZRv57hCaFXKWZv94DjQpOPAP68dc2zYGp2aQQBXrhA/Qv3X11qR
         55Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yoaV8EiIxu54dsFIyU0qdvYTV9Nos1kcoN3M/Zvq+Z8=;
        b=CQBaN+trp2I2A/LpOQhfhSzAzw/Z5qRZ1NhowU45Zn6fV4ulM9rd2ESpJ11Oa1tsOp
         SXOVmEDUGl061mCuvW21SEqL2G7TRGLKDcvXQQ2XhH7JC2pV+Umh3o5sDmUGzNEIvz95
         70F+XihKKvUG/PBExwyxOPOThupgvoJ3BF0lJSnTMOc4/ZqBPkwPXpEWSOs87hagAqhn
         32kK0WzADojlXO3V1A5/KkIb5Zwrmirvw4Xznfz7j69vSyS7CNktqFc28f+6s5grU7gl
         rv/IfzhBPPyvSRtyZAUSA6VXQNEezS4ddEsFrLJlQQ5TSWCzj4xdM0ZWSRYW+e/vIagZ
         JmBg==
X-Gm-Message-State: AOAM530AfPCqUogaU0yXkoHXdVeWCmN78JhTfIFMbPUXRdvNEMVNduuj
        RQOqCBVBAIf3+wN1uQTHBmXHqqBApJ+wp7c7LlstfQ==
X-Google-Smtp-Source: ABdhPJyNYOA6mCmdd4k+gqY/yaotErgNgTwjweShu/vSvjyf4/SAxApHi7n17d+UDmL6h8xlukBGzg/W25y9L1n/yS8=
X-Received: by 2002:a7b:cf18:: with SMTP id l24mr4420427wmg.116.1595949012379;
 Tue, 28 Jul 2020 08:10:12 -0700 (PDT)
MIME-Version: 1.0
References: <cover.7a1aa1784976093af26cb31fd283cf5b3ed568bb.1594230107.git-series.maxime@cerno.tech>
 <c76f3fe7ded07234e711007330ea40d32c461119.1594230107.git-series.maxime@cerno.tech>
In-Reply-To: <c76f3fe7ded07234e711007330ea40d32c461119.1594230107.git-series.maxime@cerno.tech>
From:   Dave Stevenson <dave.stevenson@raspberrypi.com>
Date:   Tue, 28 Jul 2020 16:09:54 +0100
Message-ID: <CAPY8ntD+Wz3C8gnTuoZB0SPFhmGD_FqNgEDcxHOWeV5n94UtqQ@mail.gmail.com>
Subject: Re: [PATCH v4 73/78] drm/vc4: hdmi: Switch to blank pixels when disabled
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

On Wed, 8 Jul 2020 at 18:44, Maxime Ripard <maxime@cerno.tech> wrote:
>
> In order to avoid pixels getting stuck in an unflushable FIFO, we need when
> we disable the HDMI controller to switch away from getting our pixels from
> the pixelvalve and instead use blank pixels, and switch back to the
> pixelvalve when we enable the HDMI controller.
>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>

Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>

> ---
>  drivers/gpu/drm/vc4/vc4_hdmi.c |  9 +++++++++
>  drivers/gpu/drm/vc4/vc4_regs.h |  3 +++
>  2 files changed, 12 insertions(+)
>
> diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
> index f56a718a3643..37463b016b47 100644
> --- a/drivers/gpu/drm/vc4/vc4_hdmi.c
> +++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
> @@ -325,6 +325,12 @@ static void vc4_hdmi_encoder_post_crtc_disable(struct drm_encoder *encoder)
>         struct vc4_hdmi *vc4_hdmi = encoder_to_vc4_hdmi(encoder);
>
>         HDMI_WRITE(HDMI_RAM_PACKET_CONFIG, 0);
> +
> +       HDMI_WRITE(HDMI_VID_CTL, HDMI_READ(HDMI_VID_CTL) |
> +                  VC4_HD_VID_CTL_CLRRGB | VC4_HD_VID_CTL_CLRSYNC);
> +
> +       HDMI_WRITE(HDMI_VID_CTL,
> +                  HDMI_READ(HDMI_VID_CTL) | VC4_HD_VID_CTL_BLANKPIX);
>  }
>
>  static void vc4_hdmi_encoder_post_crtc_powerdown(struct drm_encoder *encoder)
> @@ -563,6 +569,9 @@ static void vc4_hdmi_encoder_post_crtc_enable(struct drm_encoder *encoder)
>                    (vsync_pos ? 0 : VC4_HD_VID_CTL_VSYNC_LOW) |
>                    (hsync_pos ? 0 : VC4_HD_VID_CTL_HSYNC_LOW));
>
> +       HDMI_WRITE(HDMI_VID_CTL,
> +                  HDMI_READ(HDMI_VID_CTL) & ~VC4_HD_VID_CTL_BLANKPIX);
> +
>         if (vc4_encoder->hdmi_monitor) {
>                 HDMI_WRITE(HDMI_SCHEDULER_CONTROL,
>                            HDMI_READ(HDMI_SCHEDULER_CONTROL) |
> diff --git a/drivers/gpu/drm/vc4/vc4_regs.h b/drivers/gpu/drm/vc4/vc4_regs.h
> index d1e8961edaa0..30af52b406f1 100644
> --- a/drivers/gpu/drm/vc4/vc4_regs.h
> +++ b/drivers/gpu/drm/vc4/vc4_regs.h
> @@ -723,6 +723,9 @@
>  # define VC4_HD_VID_CTL_FRAME_COUNTER_RESET    BIT(29)
>  # define VC4_HD_VID_CTL_VSYNC_LOW              BIT(28)
>  # define VC4_HD_VID_CTL_HSYNC_LOW              BIT(27)
> +# define VC4_HD_VID_CTL_CLRSYNC                        BIT(24)
> +# define VC4_HD_VID_CTL_CLRRGB                 BIT(23)
> +# define VC4_HD_VID_CTL_BLANKPIX               BIT(18)
>
>  # define VC4_HD_CSC_CTL_ORDER_MASK             VC4_MASK(7, 5)
>  # define VC4_HD_CSC_CTL_ORDER_SHIFT            5
> --
> git-series 0.9.1
