Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 908D5C433F1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 15:05:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DEA520663
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 15:05:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="VDauPB6q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730615AbgG1PFP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 11:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730558AbgG1PFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 11:05:14 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B41CC061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 08:05:14 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id k20so10874490wmi.5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 08:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QxDxVmK0BEhYtrvSw5SuThDITVSJ95nih7WzyiY6TNg=;
        b=VDauPB6qRa6EVmiLT86Ab8sjixBlVTgYVNP2bABJh0xjtT82MKXtQJK3Z5h7KqZ3d4
         uSpRCjnz0Yg9q9x1ZbVj153pUmP+mCTVPXtxJ6IP5eOAdGIJSU4nKxLS+8cSaHnoiQao
         CB2BD8pizBCd9Ha4rSekIKmR2fhY7FnWKT7XJW57jUuZZwCYEtR7u14Ru7AGMPBh0OTO
         Q6g33s+bCkq3Q0zZV7yRzeQMhJMXu4Ca2zbTHYwozgqWmdKaAj4Bum6EWT5HPEStgfXL
         sXMe0jfVI1jninOuMAHb+YTlPnO1lhcuEC3qr0TZsH41UeiOAghvZZCJsStR8CIjV4sU
         HJCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QxDxVmK0BEhYtrvSw5SuThDITVSJ95nih7WzyiY6TNg=;
        b=D+XQa04YDIyHSrHl3ZVKB8MtoQGVwmRuk2IhKA4fPXMz3COlR/f58DG0fYYBqyoBIv
         vZos9gHZB55a/Dl0mwFGZ363xMQtgNG39mMpXWiW2Ep8ROy27R5VdLT5y4FzzwUFM/jY
         quTnJtV6MpZZPZraVffPP5lCgaH96POLSC7+j4BYNEwXLI9RkVV9W+df0uQ0ZSgl6jf/
         Qoc+FrmSrVAVRAYOrZOwWjM6y3j1G+riJod+xPizTOjtWcAAVqV8rGIFH68s5U5AtMC0
         UbjnUUXIyaSeI/wRnd9GpSIur4E7z4I2eqAg6VaJdMixQGImmfcqqAaBZNLTd/sYGR8D
         cizw==
X-Gm-Message-State: AOAM533BJ5rywnVZ+KiJ19ds4jAMa/5xyNdTBKCCrGaoRrEfUwbTzz6h
        9JHMr1PbtgeAU9Sn1Ye6+C4bWeG0dA9sWc2YduhutA==
X-Google-Smtp-Source: ABdhPJxHDPQtTTZrTbY1UZTbWSdu5PQ3WiVqQT+/t87lD4d4Ysa2XPJ/+sSgBPjyp+BLtkMVXpvAwGoDl0RydJrSoIw=
X-Received: by 2002:a7b:cf18:: with SMTP id l24mr4400512wmg.116.1595948713057;
 Tue, 28 Jul 2020 08:05:13 -0700 (PDT)
MIME-Version: 1.0
References: <cover.7a1aa1784976093af26cb31fd283cf5b3ed568bb.1594230107.git-series.maxime@cerno.tech>
 <496aecbe04aa460572d4ff02a64e77ca01368316.1594230107.git-series.maxime@cerno.tech>
In-Reply-To: <496aecbe04aa460572d4ff02a64e77ca01368316.1594230107.git-series.maxime@cerno.tech>
From:   Dave Stevenson <dave.stevenson@raspberrypi.com>
Date:   Tue, 28 Jul 2020 16:04:55 +0100
Message-ID: <CAPY8ntDwJfBFLmJA8cHpkKXu5EicsZWoa8f7Pvh8jPuXYQ_ScQ@mail.gmail.com>
Subject: Re: [PATCH v4 71/78] drm/vc4: hdmi: Implement finer-grained hooks
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
> In order to prevent some pixels getting stuck in an unflushable FIFO on
> bcm2711, we need to enable the HVS, the pixelvalve (the CRTC) and the HDMI
> controller (the encoder) in an intertwined way, and with tight delays.
>
> However, the atomic callbacks don't really provide a way to work with
> either constraints, so we need to roll our own callbacks so that we can
> provide those guarantees.
>
> Since those callbacks have been implemented and called in the CRTC code, we
> can just implement them in the HDMI driver now.
>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>

Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>

> ---
>  drivers/gpu/drm/vc4/vc4_hdmi.c | 39 +++++++++++++++++++++++++++++++----
>  1 file changed, 35 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
> index 00592c1ada73..bbe521ab000b 100644
> --- a/drivers/gpu/drm/vc4/vc4_hdmi.c
> +++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
> @@ -320,12 +320,17 @@ static void vc4_hdmi_set_infoframes(struct drm_encoder *encoder)
>                 vc4_hdmi_set_audio_infoframe(encoder);
>  }
>
> -static void vc4_hdmi_encoder_disable(struct drm_encoder *encoder)
> +static void vc4_hdmi_encoder_post_crtc_disable(struct drm_encoder *encoder)
>  {
>         struct vc4_hdmi *vc4_hdmi = encoder_to_vc4_hdmi(encoder);
> -       int ret;
>
>         HDMI_WRITE(HDMI_RAM_PACKET_CONFIG, 0);
> +}
> +
> +static void vc4_hdmi_encoder_post_crtc_powerdown(struct drm_encoder *encoder)
> +{
> +       struct vc4_hdmi *vc4_hdmi = encoder_to_vc4_hdmi(encoder);
> +       int ret;
>
>         if (vc4_hdmi->variant->phy_disable)
>                 vc4_hdmi->variant->phy_disable(vc4_hdmi);
> @@ -341,6 +346,10 @@ static void vc4_hdmi_encoder_disable(struct drm_encoder *encoder)
>                 DRM_ERROR("Failed to release power domain: %d\n", ret);
>  }
>
> +static void vc4_hdmi_encoder_disable(struct drm_encoder *encoder)
> +{
> +}
> +
>  static void vc4_hdmi_csc_setup(struct vc4_hdmi *vc4_hdmi, bool enable)
>  {
>         u32 csc_ctl;
> @@ -449,11 +458,10 @@ static void vc4_hdmi_recenter_fifo(struct vc4_hdmi *vc4_hdmi)
>                   "VC4_HDMI_FIFO_CTL_RECENTER_DONE");
>  }
>
> -static void vc4_hdmi_encoder_enable(struct drm_encoder *encoder)
> +static void vc4_hdmi_encoder_pre_crtc_configure(struct drm_encoder *encoder)
>  {
>         struct drm_display_mode *mode = &encoder->crtc->state->adjusted_mode;
>         struct vc4_hdmi *vc4_hdmi = encoder_to_vc4_hdmi(encoder);
> -       struct vc4_hdmi_encoder *vc4_encoder = to_vc4_hdmi_encoder(encoder);
>         unsigned long pixel_rate, hsm_rate;
>         int ret;
>
> @@ -521,6 +529,13 @@ static void vc4_hdmi_encoder_enable(struct drm_encoder *encoder)
>
>         if (vc4_hdmi->variant->set_timings)
>                 vc4_hdmi->variant->set_timings(vc4_hdmi, mode);
> +}
> +
> +static void vc4_hdmi_encoder_pre_crtc_enable(struct drm_encoder *encoder)
> +{
> +       struct drm_display_mode *mode = &encoder->crtc->state->adjusted_mode;
> +       struct vc4_hdmi_encoder *vc4_encoder = to_vc4_hdmi_encoder(encoder);
> +       struct vc4_hdmi *vc4_hdmi = encoder_to_vc4_hdmi(encoder);
>
>         if (vc4_encoder->hdmi_monitor &&
>             drm_default_rgb_quant_range(mode) == HDMI_QUANTIZATION_RANGE_LIMITED) {
> @@ -536,6 +551,13 @@ static void vc4_hdmi_encoder_enable(struct drm_encoder *encoder)
>         }
>
>         HDMI_WRITE(HDMI_FIFO_CTL, VC4_HDMI_FIFO_CTL_MASTER_SLAVE_N);
> +}
> +
> +static void vc4_hdmi_encoder_post_crtc_enable(struct drm_encoder *encoder)
> +{
> +       struct vc4_hdmi *vc4_hdmi = encoder_to_vc4_hdmi(encoder);
> +       struct vc4_hdmi_encoder *vc4_encoder = to_vc4_hdmi_encoder(encoder);
> +       int ret;
>
>         HDMI_WRITE(HDMI_VID_CTL,
>                    HDMI_READ(HDMI_VID_CTL) |
> @@ -582,6 +604,10 @@ static void vc4_hdmi_encoder_enable(struct drm_encoder *encoder)
>         vc4_hdmi_recenter_fifo(vc4_hdmi);
>  }
>
> +static void vc4_hdmi_encoder_enable(struct drm_encoder *encoder)
> +{
> +}
> +
>  static enum drm_mode_status
>  vc4_hdmi_encoder_mode_valid(struct drm_encoder *encoder,
>                             const struct drm_display_mode *mode)
> @@ -1362,6 +1388,11 @@ static int vc4_hdmi_bind(struct device *dev, struct device *master, void *data)
>         dev_set_drvdata(dev, vc4_hdmi);
>         encoder = &vc4_hdmi->encoder.base.base;
>         vc4_hdmi->encoder.base.type = variant->encoder_type;
> +       vc4_hdmi->encoder.base.pre_crtc_configure = vc4_hdmi_encoder_pre_crtc_configure;
> +       vc4_hdmi->encoder.base.pre_crtc_enable = vc4_hdmi_encoder_pre_crtc_enable;
> +       vc4_hdmi->encoder.base.post_crtc_enable = vc4_hdmi_encoder_post_crtc_enable;
> +       vc4_hdmi->encoder.base.post_crtc_disable = vc4_hdmi_encoder_post_crtc_disable;
> +       vc4_hdmi->encoder.base.post_crtc_powerdown = vc4_hdmi_encoder_post_crtc_powerdown;
>         vc4_hdmi->pdev = pdev;
>         vc4_hdmi->variant = variant;
>
> --
> git-series 0.9.1
