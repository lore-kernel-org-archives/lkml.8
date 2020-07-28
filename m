Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC37BC433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 15:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAE92206D8
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 15:01:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="Jo9KrEAR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730578AbgG1PBk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 11:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730542AbgG1PBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 11:01:39 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 944ECC061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 08:01:39 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id g8so6466190wmk.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 08:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZcrgKc86yq8jTIyryDrJPO9n2XZz5GQUQu/T72sz8/s=;
        b=Jo9KrEARmx57XEuZF9UIjrILmxJkqN/glLYpkX7VkYNnqVSVCjrANh+1dL79NRHS+1
         kw225T0kYBhckZq3H9fiBzqhXHLawffOfQXvDJ6HyevfgEIvEBLyD1k6MBUMuMRGgR/d
         nbY30rZu+Fh8ghEYOuFlcFQS+xvKAlop0ZRcQcvuULOZuplN2+KOANZtFSC8llMfrEvH
         v73MIuvqQOVIjJlKccE9+CYFGqAvsAz1HRavlCB/HZuEQyCDHdY5oVRQxNJERFrukYHH
         hbkGzJmDiSGw+Kd10EwExQ0HBNDznk2Z24CHoqFJuSqS2TgSfCJ++2T1DaIXPlkFxOjb
         qL+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZcrgKc86yq8jTIyryDrJPO9n2XZz5GQUQu/T72sz8/s=;
        b=tAs6bKsETFfsJWdMFqtdqJo2BhjLSX5i8NhM5rEJsOmUzWoeIjw3srjftCEFTymOa7
         Ym4PmqwvlcPuCgm4SeSuFUCsJvAvSaHda3//w4myWIQzNZhV8Ls9bdtEztJOpVQseHKA
         qaXFJzHXV5y9YFSC3clv4YL4hv2jdSUjUAGhdAUphzqTPKpcxwXd82W00zB5zgOPdfME
         nd+bHvM6O25sMHwV0KanVDGQK3DKCl6xl0f0J37Ra98PHuTh8hFognSwLy4n1KuEhz42
         vsgpxjNxODhXRlxWqPIFsstOdXRH01tCnIN3CVguMEjFgF0UqEnn3Y5Zq83U1tORULLh
         qwJA==
X-Gm-Message-State: AOAM5336MB3TEomOh4CqcHykdoZXP4uvjj+7vAbZ1I46W1OaIAMQGl24
        O/jCpSjxQG+aiRJn/oBmhqSOu3L1gUQFhxpk36dbCQ==
X-Google-Smtp-Source: ABdhPJxsowHKjs4VRkG6lEsi2OtxAldJwXZhMHpPadE/C085R7BWsFMiIcXNwj9j5QNXuzmhc2E3AmMjKoxXxa/+oaE=
X-Received: by 2002:a1c:e382:: with SMTP id a124mr4093328wmh.96.1595948498383;
 Tue, 28 Jul 2020 08:01:38 -0700 (PDT)
MIME-Version: 1.0
References: <cover.7a1aa1784976093af26cb31fd283cf5b3ed568bb.1594230107.git-series.maxime@cerno.tech>
 <805c78c427113b151dbd289dc52116f17734a1da.1594230107.git-series.maxime@cerno.tech>
In-Reply-To: <805c78c427113b151dbd289dc52116f17734a1da.1594230107.git-series.maxime@cerno.tech>
From:   Dave Stevenson <dave.stevenson@raspberrypi.com>
Date:   Tue, 28 Jul 2020 16:01:22 +0100
Message-ID: <CAPY8ntBD_qkvP5DyOx8O-9kFzqKxE-q9swrhBcmRm2L4dDA7gw@mail.gmail.com>
Subject: Re: [PATCH v4 69/78] drm/vc4: hdmi: Remove register dumps in enable
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
> The current code has some logic, disabled by default, to dump the register
> setup in the HDMI controller.
>
> However, since we're going to split those functions in multiple, shorter,
> functions that only make sense where they are called in sequence, keeping
> the register dump makes little sense.
>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>

Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>

> ---
>  drivers/gpu/drm/vc4/vc4_hdmi.c | 17 -----------------
>  1 file changed, 17 deletions(-)
>
> diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
> index 0a9a323e03d8..4058985940e6 100644
> --- a/drivers/gpu/drm/vc4/vc4_hdmi.c
> +++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
> @@ -430,7 +430,6 @@ static void vc4_hdmi_encoder_enable(struct drm_encoder *encoder)
>         struct drm_display_mode *mode = &encoder->crtc->state->adjusted_mode;
>         struct vc4_hdmi *vc4_hdmi = encoder_to_vc4_hdmi(encoder);
>         struct vc4_hdmi_encoder *vc4_encoder = to_vc4_hdmi_encoder(encoder);
> -       bool debug_dump_regs = false;
>         unsigned long pixel_rate, hsm_rate;
>         int ret;
>
> @@ -489,14 +488,6 @@ static void vc4_hdmi_encoder_enable(struct drm_encoder *encoder)
>         if (vc4_hdmi->variant->phy_init)
>                 vc4_hdmi->variant->phy_init(vc4_hdmi, mode);
>
> -       if (debug_dump_regs) {
> -               struct drm_printer p = drm_info_printer(&vc4_hdmi->pdev->dev);
> -
> -               dev_info(&vc4_hdmi->pdev->dev, "HDMI regs before:\n");
> -               drm_print_regset32(&p, &vc4_hdmi->hdmi_regset);
> -               drm_print_regset32(&p, &vc4_hdmi->hd_regset);
> -       }
> -
>         HDMI_WRITE(HDMI_VID_CTL, 0);
>
>         HDMI_WRITE(HDMI_SCHEDULER_CONTROL,
> @@ -522,14 +513,6 @@ static void vc4_hdmi_encoder_enable(struct drm_encoder *encoder)
>
>         HDMI_WRITE(HDMI_FIFO_CTL, VC4_HDMI_FIFO_CTL_MASTER_SLAVE_N);
>
> -       if (debug_dump_regs) {
> -               struct drm_printer p = drm_info_printer(&vc4_hdmi->pdev->dev);
> -
> -               dev_info(&vc4_hdmi->pdev->dev, "HDMI regs after:\n");
> -               drm_print_regset32(&p, &vc4_hdmi->hdmi_regset);
> -               drm_print_regset32(&p, &vc4_hdmi->hd_regset);
> -       }
> -
>         HDMI_WRITE(HDMI_VID_CTL,
>                    HDMI_READ(HDMI_VID_CTL) |
>                    VC4_HD_VID_CTL_ENABLE |
> --
> git-series 0.9.1
