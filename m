Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75147C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 15:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53F94204EA
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 15:07:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="VTagqeDR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730680AbgG1PHJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 11:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730505AbgG1PHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 11:07:09 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D0EC061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 08:07:09 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id a14so18658716wra.5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 08:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W/YdhzEx/vyaHEVhqUuCRX7czWchwkSBVhpXRtjSYY4=;
        b=VTagqeDR8jA/cF11iGP906j2K3kIJGUg0PT91VJQtmmZWW40RJOhkg3WHkLVXNY3SN
         8kZL8SgF28l5FAI1pi6of5htR3Sku6yW86xTYzKWrTQl61N9+/x2/WZD5sGraNT7KJQL
         ix+K3lboyDRkQZM2P146zwHgkvOSDIZZU9Fo0omMt4cNlJeM0gIo045JbvVe3Y/1SmeG
         yZMt9nPrwBdeiAyd9MzuBGM0VPDpTspHJgnGIXCU1guC4RPPMgbCos1Z86nAd3DEH7H2
         Khv5iijZps9LdpFz9ub/q7nEwMs8O1ca+kwQRiAgm8aom4oubq+9tzIoc/GEghsZE8b3
         lOJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W/YdhzEx/vyaHEVhqUuCRX7czWchwkSBVhpXRtjSYY4=;
        b=FBcjjzqsUFWYOqj7b5CHob4cTGt1JGLrrtzq7QM0f2cB747+E48Hssc0wmmpAvt456
         E9De8lRmIW/rOdDZs6YTsDVOX57QIipAyOo5vyC3TzmwBNDaYKfemhmJmTSV4+B/kfYW
         0AC3fgWRf0gK77bNJwb50MK5p6wGNBSXAbo30hGzwBMUkQ6dZjtd9dpJgSegUnexDM3D
         I548qhvsXKLu6fD2zED/r14SF+xqCmf6S1brtn3JAoKA+ROs2Fy/m40+X3KhFMIKK/kt
         WuahzM6w982n2wEjTJL82LB5W72g/IIWk4sKpAo+uYwqLyGtJ6/N0v5Yl1gdimUF1lWq
         bs5g==
X-Gm-Message-State: AOAM532wY00JjkIOihA58bk6+F3aiKB55V+Fa1GriICLhb2b4k/JLqH5
        pb4wGY0Bjph4/r09AauF/VAxhqXL+ddHJIog2avIfg==
X-Google-Smtp-Source: ABdhPJygKAtASQ39NVxPtwZTd0cui+1aL7Ldd3aiUrbNsVByMnrKvu4bejQSYxT36FPuweRrJ+bGO2xF63DlnnP2678=
X-Received: by 2002:a5d:5383:: with SMTP id d3mr18384224wrv.42.1595948827769;
 Tue, 28 Jul 2020 08:07:07 -0700 (PDT)
MIME-Version: 1.0
References: <cover.7a1aa1784976093af26cb31fd283cf5b3ed568bb.1594230107.git-series.maxime@cerno.tech>
 <06921938439fdf7da952fb8d148932fc9403f82a.1594230107.git-series.maxime@cerno.tech>
In-Reply-To: <06921938439fdf7da952fb8d148932fc9403f82a.1594230107.git-series.maxime@cerno.tech>
From:   Dave Stevenson <dave.stevenson@raspberrypi.com>
Date:   Tue, 28 Jul 2020 16:06:48 +0100
Message-ID: <CAPY8ntAaH9hOXQuVaSyCNrU5fKKHgk=+3wV3eKcR84-pw_PjeQ@mail.gmail.com>
Subject: Re: [PATCH v4 72/78] drm/vc4: hdmi: Do the VID_CTL configuration at once
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
> The VID_CTL setup is done in several places in the driver even though it's
> not really required. Let's simplify it a bit to do the configuration in one
> go.
>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>

Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>

> ---
>  drivers/gpu/drm/vc4/vc4_hdmi.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
> index bbe521ab000b..f56a718a3643 100644
> --- a/drivers/gpu/drm/vc4/vc4_hdmi.c
> +++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
> @@ -428,10 +428,6 @@ static void vc4_hdmi_set_timings(struct vc4_hdmi *vc4_hdmi,
>
>         HDMI_WRITE(HDMI_VERTB0, vertb_even);
>         HDMI_WRITE(HDMI_VERTB1, vertb);
> -
> -       HDMI_WRITE(HDMI_VID_CTL,
> -                  (vsync_pos ? 0 : VC4_HD_VID_CTL_VSYNC_LOW) |
> -                  (hsync_pos ? 0 : VC4_HD_VID_CTL_HSYNC_LOW));
>  }
>
>  static void vc4_hdmi_recenter_fifo(struct vc4_hdmi *vc4_hdmi)
> @@ -520,8 +516,6 @@ static void vc4_hdmi_encoder_pre_crtc_configure(struct drm_encoder *encoder)
>         if (vc4_hdmi->variant->phy_init)
>                 vc4_hdmi->variant->phy_init(vc4_hdmi, mode);
>
> -       HDMI_WRITE(HDMI_VID_CTL, 0);
> -
>         HDMI_WRITE(HDMI_SCHEDULER_CONTROL,
>                    HDMI_READ(HDMI_SCHEDULER_CONTROL) |
>                    VC4_HDMI_SCHEDULER_CONTROL_MANUAL_FORMAT |
> @@ -555,15 +549,19 @@ static void vc4_hdmi_encoder_pre_crtc_enable(struct drm_encoder *encoder)
>
>  static void vc4_hdmi_encoder_post_crtc_enable(struct drm_encoder *encoder)
>  {
> +       struct drm_display_mode *mode = &encoder->crtc->state->adjusted_mode;
>         struct vc4_hdmi *vc4_hdmi = encoder_to_vc4_hdmi(encoder);
>         struct vc4_hdmi_encoder *vc4_encoder = to_vc4_hdmi_encoder(encoder);
> +       bool hsync_pos = mode->flags & DRM_MODE_FLAG_PHSYNC;
> +       bool vsync_pos = mode->flags & DRM_MODE_FLAG_PVSYNC;
>         int ret;
>
>         HDMI_WRITE(HDMI_VID_CTL,
> -                  HDMI_READ(HDMI_VID_CTL) |
>                    VC4_HD_VID_CTL_ENABLE |
>                    VC4_HD_VID_CTL_UNDERFLOW_ENABLE |
> -                  VC4_HD_VID_CTL_FRAME_COUNTER_RESET);
> +                  VC4_HD_VID_CTL_FRAME_COUNTER_RESET |
> +                  (vsync_pos ? 0 : VC4_HD_VID_CTL_VSYNC_LOW) |
> +                  (hsync_pos ? 0 : VC4_HD_VID_CTL_HSYNC_LOW));
>
>         if (vc4_encoder->hdmi_monitor) {
>                 HDMI_WRITE(HDMI_SCHEDULER_CONTROL,
> --
> git-series 0.9.1
