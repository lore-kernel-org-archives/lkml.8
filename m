Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C87EFC433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 15:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EDFD20770
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 15:45:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="oFrwyne8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbgIDPp6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 11:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbgIDPpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 11:45:54 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D84C061244
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 08:45:52 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id w2so6504415wmi.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 08:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BWAhN7a+4874hzvxevYBZLVV3qk181dMhkmwcopVXuI=;
        b=oFrwyne8UjE4GXeuhjjOpVE9dYZzB2GlQAZCkFaOP1wA0cXqKCn7uoJJwGDObMHxPc
         dFLnAam23p6BBsCONYgBCS8Y3VSJ7EySoY4Fq5UoZy/F8Fn2lbfkkqBi1OjU/s5JCuEQ
         +UHKUniKfnrVglb99KDPOYVPapsE5nuHsbwWDUXY5kMUq5FTRJ89pfRug0hq4ZLwqTag
         kxJjyxhTh7qRPvOCRVNb+dWojAmEJ2ch1rJknyxyZUNQd2ZIZPR2hKHtF5EnNzeGSe5W
         3LkwSplCw1X7pDUYAp/rmsDgjRmrze7FYppzpfhj7RhzMpSAeo+cHJAmHAAMamm/Yicg
         alXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BWAhN7a+4874hzvxevYBZLVV3qk181dMhkmwcopVXuI=;
        b=qX9iUVH/lBEpfNnilecqEZPbaztKnGSpv/H0jWS8u6zSSi7CeTYrR40yo/9RG+Rwag
         GfUCaBbN2+d2OWdu702dKwJzH8yuIdh+vstQsfe8ii38Zo/ewThY4bKYZwnwM1oCAcNr
         JXtLEPvGqB4cqJs+yCdkXzLhVLW2El01KvWqTSWCmWGZkcB9IH5kk7kEKtM16rGwsiwi
         KhKD/EvjtjgaJ0MpR1aPGklY0QTse+9a9HU9uiCoBY2d4VjwuAryIL1Ekn/5hSA7k56E
         TzIc11EIXQM1AOSLyPalkz13kJxsmEt0AP7jnxYHdcp+XkOPQPXSwsxwZJqTj2UJItv0
         Bypg==
X-Gm-Message-State: AOAM5316KGVkN69+mkaZGa7d+wl56GXdWoUO8ymaqQJyWmM1Cbla8Kv7
        VfTOXxja8Z0DqdmCqqxTKnLe44AtlvY97sUFXmZxvQ==
X-Google-Smtp-Source: ABdhPJzfjtKP7vZTuEflczNVPJm8Afz2ShaotHKRilLa7ZLCMiX8evx3ILz6Mx8pA1RbRMbqOuiZ+w5nytdpOD6GqG0=
X-Received: by 2002:a1c:4303:: with SMTP id q3mr8102774wma.158.1599234351549;
 Fri, 04 Sep 2020 08:45:51 -0700 (PDT)
MIME-Version: 1.0
References: <cover.dddc064d8bb83e46744336af67dcb13139e5747d.1599120059.git-series.maxime@cerno.tech>
 <5c19bbf10153cb42ca0fb67e08606c8295c17236.1599120059.git-series.maxime@cerno.tech>
In-Reply-To: <5c19bbf10153cb42ca0fb67e08606c8295c17236.1599120059.git-series.maxime@cerno.tech>
From:   Dave Stevenson <dave.stevenson@raspberrypi.com>
Date:   Fri, 4 Sep 2020 16:45:36 +0100
Message-ID: <CAPY8ntAPzQ2BWRivzmfSbX03WZiQ0UDRCDBFgWA2-ZtrqO10nA@mail.gmail.com>
Subject: Re: [PATCH v5 55/80] drm/vc4: hdmi: Add a CSC setup callback
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Eric Anholt <eric@anholt.net>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Hoegeun Kwon <hoegeun.kwon@samsung.com>,
        Stefan Wahren <stefan.wahren@i2se.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime

On Thu, 3 Sep 2020 at 09:03, Maxime Ripard <maxime@cerno.tech> wrote:
>
> Similarly to the previous patches, the CSC setup is slightly different in
> the BCM2711 than in the previous generations. Let's add a callback for it.
>
> Tested-by: Chanwoo Choi <cw00.choi@samsung.com>
> Tested-by: Hoegeun Kwon <hoegeun.kwon@samsung.com>
> Tested-by: Stefan Wahren <stefan.wahren@i2se.com>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>

Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>

> ---
>  drivers/gpu/drm/vc4/vc4_hdmi.c | 70 +++++++++++++++++++++--------------
>  drivers/gpu/drm/vc4/vc4_hdmi.h |  3 ++-
>  2 files changed, 45 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
> index c29376c3fd8a..532618e02399 100644
> --- a/drivers/gpu/drm/vc4/vc4_hdmi.c
> +++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
> @@ -334,6 +334,41 @@ static void vc4_hdmi_encoder_disable(struct drm_encoder *encoder)
>                 DRM_ERROR("Failed to release power domain: %d\n", ret);
>  }
>
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
>  static void vc4_hdmi_encoder_enable(struct drm_encoder *encoder)
>  {
>         struct drm_display_mode *mode = &encoder->crtc->state->adjusted_mode;
> @@ -357,7 +392,6 @@ static void vc4_hdmi_encoder_enable(struct drm_encoder *encoder)
>                                         mode->crtc_vsync_end -
>                                         interlaced,
>                                         VC4_HDMI_VERTB_VBP));
> -       u32 csc_ctl;
>         int ret;
>
>         ret = pm_runtime_get_sync(&vc4_hdmi->pdev->dev);
> @@ -428,41 +462,20 @@ static void vc4_hdmi_encoder_enable(struct drm_encoder *encoder)
>                    (vsync_pos ? 0 : VC4_HD_VID_CTL_VSYNC_LOW) |
>                    (hsync_pos ? 0 : VC4_HD_VID_CTL_HSYNC_LOW));
>
> -       csc_ctl = VC4_SET_FIELD(VC4_HD_CSC_CTL_ORDER_BGR,
> -                               VC4_HD_CSC_CTL_ORDER);
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
> @@ -1430,6 +1443,7 @@ static const struct vc4_hdmi_variant bcm2835_variant = {
>         .num_registers          = ARRAY_SIZE(vc4_hdmi_fields),
>
>         .init_resources         = vc4_hdmi_init_resources,
> +       .csc_setup              = vc4_hdmi_csc_setup,
>         .reset                  = vc4_hdmi_reset,
>         .phy_init               = vc4_hdmi_phy_init,
>         .phy_disable            = vc4_hdmi_phy_disable,
> diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.h b/drivers/gpu/drm/vc4/vc4_hdmi.h
> index 950accbc44e4..c8fd58548ea2 100644
> --- a/drivers/gpu/drm/vc4/vc4_hdmi.h
> +++ b/drivers/gpu/drm/vc4/vc4_hdmi.h
> @@ -41,6 +41,9 @@ struct vc4_hdmi_variant {
>         /* Callback to reset the HDMI block */
>         void (*reset)(struct vc4_hdmi *vc4_hdmi);
>
> +       /* Callback to enable / disable the CSC */
> +       void (*csc_setup)(struct vc4_hdmi *vc4_hdmi, bool enable);
> +
>         /* Callback to initialize the PHY according to the mode */
>         void (*phy_init)(struct vc4_hdmi *vc4_hdmi,
>                          struct drm_display_mode *mode);
> --
> git-series 0.9.1
