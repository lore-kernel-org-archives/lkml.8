Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55417C433EA
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 13:13:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A29720714
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 13:13:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="O64uoCHV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730017AbgG1NNO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 09:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729923AbgG1NNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 09:13:13 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7659C061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 06:13:12 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id c80so17266893wme.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 06:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hn73ZeTsbvvZEe6zF6c1TcaGJ3Kb+2Neo3dKxuwxqwI=;
        b=O64uoCHVwK8OV2TsHjId6t4SCQ2EwLv1Nlbsa5qLH4EFhek7Lxuf5K7I0Xcqsyb3cx
         rOlCF+Jc36Z/OfuQAcZSE3GN7mOqwk4cttMNEgd3z5LtE3xV5nFeQlUXgyG3NmUw7kAQ
         BfXzolvhIsne8zHf11w+A8GPIeWx5gFDlN/yCVSCEnq+rFtoH3yncRfVbhoc/g8sq9Hd
         W4slxdlT4/o8bF7am460uU1vP1GFDqiSF36DLpk7XPx0qr/+rU81W36sbYRJgVDOuK+D
         fiMpF50F3dpH8xLjIzu3OWdGc86R7wJprr9KtIjffdmiCAdcnYNXmHvuimvajdw1VcL2
         CjaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hn73ZeTsbvvZEe6zF6c1TcaGJ3Kb+2Neo3dKxuwxqwI=;
        b=QuXSSV0WnpmEKIIJVbQyK86PBYUEoAGEobcATpk1ZNvNkBN7n9XPuqwCpRLX6aOUzx
         mwb7kELDpoxGeg+NlSZyBzSYdeiFCN5CNeBfNqaZZyg5+71q9n800yJ9saN60QkWZVdl
         BeCypf32Be9728PoWVXASQDFDacqavqe4641R+8hdAND4VMRNWTyYrVfmM0nnne1obBN
         Gfm8aJt6CSJsgj9kIuVDV5oGx0mvnaH2qCZbAJiTkNkHjqMe2t4vVDaiSEPtZ6NIdghD
         gqOT5Z+/TJCypcXp01hsyILJZQ48pU+0Kn2JUQEYma8O0l5vS1zPFuOCRRYhsYY1waG0
         mSGQ==
X-Gm-Message-State: AOAM533JT7A47W+Q0GTpkdClVoTpwkkSGm9yO94RqxhbYE2T5vL7NTjs
        64ZHuE1o8ZVYzoXqKHyjHBmhzMwWzflbhPF07KeBPmVGzd8=
X-Google-Smtp-Source: ABdhPJy7HYS0aEVl26WsJfxCdOzW1mGb++9Zn0Ks4CZMROjIWrmhXci1tkPBKLKRq4FcZnC+6t+dbpas6DIaFQMdUso=
X-Received: by 2002:a1c:1d52:: with SMTP id d79mr1526380wmd.82.1595941991293;
 Tue, 28 Jul 2020 06:13:11 -0700 (PDT)
MIME-Version: 1.0
References: <cover.7a1aa1784976093af26cb31fd283cf5b3ed568bb.1594230107.git-series.maxime@cerno.tech>
 <7e00240a06b54e2ee7175a892310914d7f565426.1594230107.git-series.maxime@cerno.tech>
In-Reply-To: <7e00240a06b54e2ee7175a892310914d7f565426.1594230107.git-series.maxime@cerno.tech>
From:   Dave Stevenson <dave.stevenson@raspberrypi.com>
Date:   Tue, 28 Jul 2020 14:12:55 +0100
Message-ID: <CAPY8ntBbYCupu8LNqYZO=cnJsx=5tpPs2ripTAtM5R=Nsk5=xg@mail.gmail.com>
Subject: Re: [PATCH v4 55/78] drm/vc4: hdmi: Add a CSC setup callback
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
> Similarly to the previous patches, the CSC setup is slightly different in
> the BCM2711 than in the previous generations. Let's add a callback for it.

We've gained the set_timings callback in this patch as well as
csc_setup. Was that an accidental squash as we had them as independent
commits in v1.

  Dave

> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---
>  drivers/gpu/drm/vc4/vc4_hdmi.c | 142 +++++++++++++++++++---------------
>  drivers/gpu/drm/vc4/vc4_hdmi.h |   7 ++-
>  2 files changed, 89 insertions(+), 60 deletions(-)
>
> diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
> index 19897d6525ac..a50220bfd5dd 100644
> --- a/drivers/gpu/drm/vc4/vc4_hdmi.c
> +++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
> @@ -334,12 +334,44 @@ static void vc4_hdmi_encoder_disable(struct drm_encoder *encoder)
>                 DRM_ERROR("Failed to release power domain: %d\n", ret);
>  }
>
> -static void vc4_hdmi_encoder_enable(struct drm_encoder *encoder)
> +static void vc4_hdmi_csc_setup(struct vc4_hdmi *vc4_hdmi, bool enable)
> +{
> +       u32 csc_ctl;
> +
> +       csc_ctl = VC4_SET_FIELD(VC4_HD_CSC_CTL_ORDER_BGR,
> +                               VC4_HD_CSC_CTL_ORDER);
> +
> +       if (enable) {
> +               /* CEA VICs other than #1 requre limited range RGB
> +                * output unless overridden by an AVI infoframe.
> +                * Apply a colorspace conversion to squash 0-255 down
> +                * to 16-235.  The matrix here is:
> +                *
> +                * [ 0      0      0.8594 16]
> +                * [ 0      0.8594 0      16]
> +                * [ 0.8594 0      0      16]
> +                * [ 0      0      0       1]
> +                */
> +               csc_ctl |= VC4_HD_CSC_CTL_ENABLE;
> +               csc_ctl |= VC4_HD_CSC_CTL_RGB2YCC;
> +               csc_ctl |= VC4_SET_FIELD(VC4_HD_CSC_CTL_MODE_CUSTOM,
> +                                        VC4_HD_CSC_CTL_MODE);
> +
> +               HDMI_WRITE(HDMI_CSC_12_11, (0x000 << 16) | 0x000);
> +               HDMI_WRITE(HDMI_CSC_14_13, (0x100 << 16) | 0x6e0);
> +               HDMI_WRITE(HDMI_CSC_22_21, (0x6e0 << 16) | 0x000);
> +               HDMI_WRITE(HDMI_CSC_24_23, (0x100 << 16) | 0x000);
> +               HDMI_WRITE(HDMI_CSC_32_31, (0x000 << 16) | 0x6e0);
> +               HDMI_WRITE(HDMI_CSC_34_33, (0x100 << 16) | 0x000);
> +       }
> +
> +       /* The RGB order applies even when CSC is disabled. */
> +       HDMI_WRITE(HDMI_CSC_CTL, csc_ctl);
> +}
> +
> +static void vc4_hdmi_set_timings(struct vc4_hdmi *vc4_hdmi,
> +                                struct drm_display_mode *mode)
>  {
> -       struct drm_display_mode *mode = &encoder->crtc->state->adjusted_mode;
> -       struct vc4_hdmi *vc4_hdmi = encoder_to_vc4_hdmi(encoder);
> -       struct vc4_hdmi_encoder *vc4_encoder = &vc4_hdmi->encoder;
> -       bool debug_dump_regs = false;
>         bool hsync_pos = mode->flags & DRM_MODE_FLAG_PHSYNC;
>         bool vsync_pos = mode->flags & DRM_MODE_FLAG_PVSYNC;
>         bool interlaced = mode->flags & DRM_MODE_FLAG_INTERLACE;
> @@ -357,7 +389,41 @@ static void vc4_hdmi_encoder_enable(struct drm_encoder *encoder)
>                                         mode->crtc_vsync_end -
>                                         interlaced,
>                                         VC4_HDMI_VERTB_VBP));
> -       u32 csc_ctl;
> +
> +       HDMI_WRITE(HDMI_HORZA,
> +                  (vsync_pos ? VC4_HDMI_HORZA_VPOS : 0) |
> +                  (hsync_pos ? VC4_HDMI_HORZA_HPOS : 0) |
> +                  VC4_SET_FIELD(mode->hdisplay * pixel_rep,
> +                                VC4_HDMI_HORZA_HAP));
> +
> +       HDMI_WRITE(HDMI_HORZB,
> +                  VC4_SET_FIELD((mode->htotal -
> +                                 mode->hsync_end) * pixel_rep,
> +                                VC4_HDMI_HORZB_HBP) |
> +                  VC4_SET_FIELD((mode->hsync_end -
> +                                 mode->hsync_start) * pixel_rep,
> +                                VC4_HDMI_HORZB_HSP) |
> +                  VC4_SET_FIELD((mode->hsync_start -
> +                                 mode->hdisplay) * pixel_rep,
> +                                VC4_HDMI_HORZB_HFP));
> +
> +       HDMI_WRITE(HDMI_VERTA0, verta);
> +       HDMI_WRITE(HDMI_VERTA1, verta);
> +
> +       HDMI_WRITE(HDMI_VERTB0, vertb_even);
> +       HDMI_WRITE(HDMI_VERTB1, vertb);
> +
> +       HDMI_WRITE(HDMI_VID_CTL,
> +                  (vsync_pos ? 0 : VC4_HD_VID_CTL_VSYNC_LOW) |
> +                  (hsync_pos ? 0 : VC4_HD_VID_CTL_HSYNC_LOW));
> +}
> +
> +static void vc4_hdmi_encoder_enable(struct drm_encoder *encoder)
> +{
> +       struct drm_display_mode *mode = &encoder->crtc->state->adjusted_mode;
> +       struct vc4_hdmi *vc4_hdmi = encoder_to_vc4_hdmi(encoder);
> +       struct vc4_hdmi_encoder *vc4_encoder = to_vc4_hdmi_encoder(encoder);
> +       bool debug_dump_regs = false;
>         int ret;
>
>         ret = pm_runtime_get_sync(&vc4_hdmi->pdev->dev);
> @@ -401,68 +467,22 @@ static void vc4_hdmi_encoder_enable(struct drm_encoder *encoder)
>                    VC4_HDMI_SCHEDULER_CONTROL_MANUAL_FORMAT |
>                    VC4_HDMI_SCHEDULER_CONTROL_IGNORE_VSYNC_PREDICTS);
>
> -       HDMI_WRITE(HDMI_HORZA,
> -                  (vsync_pos ? VC4_HDMI_HORZA_VPOS : 0) |
> -                  (hsync_pos ? VC4_HDMI_HORZA_HPOS : 0) |
> -                  VC4_SET_FIELD(mode->hdisplay * pixel_rep,
> -                                VC4_HDMI_HORZA_HAP));
> -
> -       HDMI_WRITE(HDMI_HORZB,
> -                  VC4_SET_FIELD((mode->htotal -
> -                                 mode->hsync_end) * pixel_rep,
> -                                VC4_HDMI_HORZB_HBP) |
> -                  VC4_SET_FIELD((mode->hsync_end -
> -                                 mode->hsync_start) * pixel_rep,
> -                                VC4_HDMI_HORZB_HSP) |
> -                  VC4_SET_FIELD((mode->hsync_start -
> -                                 mode->hdisplay) * pixel_rep,
> -                                VC4_HDMI_HORZB_HFP));
> -
> -       HDMI_WRITE(HDMI_VERTA0, verta);
> -       HDMI_WRITE(HDMI_VERTA1, verta);
> -
> -       HDMI_WRITE(HDMI_VERTB0, vertb_even);
> -       HDMI_WRITE(HDMI_VERTB1, vertb);
> -
> -       HDMI_WRITE(HDMI_VID_CTL,
> -                  (vsync_pos ? 0 : VC4_HD_VID_CTL_VSYNC_LOW) |
> -                  (hsync_pos ? 0 : VC4_HD_VID_CTL_HSYNC_LOW));
> -
> -       csc_ctl = VC4_SET_FIELD(VC4_HD_CSC_CTL_ORDER_BGR,
> -                               VC4_HD_CSC_CTL_ORDER);
> +       if (vc4_hdmi->variant->set_timings)
> +               vc4_hdmi->variant->set_timings(vc4_hdmi, mode);
>
>         if (vc4_encoder->hdmi_monitor &&
> -           drm_default_rgb_quant_range(mode) ==
> -           HDMI_QUANTIZATION_RANGE_LIMITED) {
> -               /* CEA VICs other than #1 requre limited range RGB
> -                * output unless overridden by an AVI infoframe.
> -                * Apply a colorspace conversion to squash 0-255 down
> -                * to 16-235.  The matrix here is:
> -                *
> -                * [ 0      0      0.8594 16]
> -                * [ 0      0.8594 0      16]
> -                * [ 0.8594 0      0      16]
> -                * [ 0      0      0       1]
> -                */
> -               csc_ctl |= VC4_HD_CSC_CTL_ENABLE;
> -               csc_ctl |= VC4_HD_CSC_CTL_RGB2YCC;
> -               csc_ctl |= VC4_SET_FIELD(VC4_HD_CSC_CTL_MODE_CUSTOM,
> -                                        VC4_HD_CSC_CTL_MODE);
> +           drm_default_rgb_quant_range(mode) == HDMI_QUANTIZATION_RANGE_LIMITED) {
> +               if (vc4_hdmi->variant->csc_setup)
> +                       vc4_hdmi->variant->csc_setup(vc4_hdmi, true);
>
> -               HDMI_WRITE(HDMI_CSC_12_11, (0x000 << 16) | 0x000);
> -               HDMI_WRITE(HDMI_CSC_14_13, (0x100 << 16) | 0x6e0);
> -               HDMI_WRITE(HDMI_CSC_22_21, (0x6e0 << 16) | 0x000);
> -               HDMI_WRITE(HDMI_CSC_24_23, (0x100 << 16) | 0x000);
> -               HDMI_WRITE(HDMI_CSC_32_31, (0x000 << 16) | 0x6e0);
> -               HDMI_WRITE(HDMI_CSC_34_33, (0x100 << 16) | 0x000);
>                 vc4_encoder->limited_rgb_range = true;
>         } else {
> +               if (vc4_hdmi->variant->csc_setup)
> +                       vc4_hdmi->variant->csc_setup(vc4_hdmi, false);
> +
>                 vc4_encoder->limited_rgb_range = false;
>         }
>
> -       /* The RGB order applies even when CSC is disabled. */
> -       HDMI_WRITE(HDMI_CSC_CTL, csc_ctl);
> -
>         HDMI_WRITE(HDMI_FIFO_CTL, VC4_HDMI_FIFO_CTL_MASTER_SLAVE_N);
>
>         if (debug_dump_regs) {
> @@ -1431,7 +1451,9 @@ static const struct vc4_hdmi_variant bcm2835_variant = {
>         .num_registers          = ARRAY_SIZE(vc4_hdmi_fields),
>
>         .init_resources         = vc4_hdmi_init_resources,
> +       .csc_setup              = vc4_hdmi_csc_setup,
>         .reset                  = vc4_hdmi_reset,
> +       .set_timings            = vc4_hdmi_set_timings,
>         .phy_init               = vc4_hdmi_phy_init,
>         .phy_disable            = vc4_hdmi_phy_disable,
>         .phy_rng_enable         = vc4_hdmi_phy_rng_enable,
> diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.h b/drivers/gpu/drm/vc4/vc4_hdmi.h
> index 950accbc44e4..0c32dc46d289 100644
> --- a/drivers/gpu/drm/vc4/vc4_hdmi.h
> +++ b/drivers/gpu/drm/vc4/vc4_hdmi.h
> @@ -41,6 +41,13 @@ struct vc4_hdmi_variant {
>         /* Callback to reset the HDMI block */
>         void (*reset)(struct vc4_hdmi *vc4_hdmi);
>
> +       /* Callback to enable / disable the CSC */
> +       void (*csc_setup)(struct vc4_hdmi *vc4_hdmi, bool enable);
> +
> +       /* Callback to configure the video timings in the HDMI block */
> +       void (*set_timings)(struct vc4_hdmi *vc4_hdmi,
> +                           struct drm_display_mode *mode);
> +
>         /* Callback to initialize the PHY according to the mode */
>         void (*phy_init)(struct vc4_hdmi *vc4_hdmi,
>                          struct drm_display_mode *mode);
> --
> git-series 0.9.1
