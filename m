Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 142DDC433EB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 09:49:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1CDB20829
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 09:49:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="A4OpHyoV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728491AbgG1JtJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 05:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728235AbgG1JtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 05:49:08 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67339C061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 02:49:08 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id 88so17627604wrh.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 02:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wQ1i30iYSbM1E0tY0uz5+ptChSg4d1LMooSt7pYAIp4=;
        b=A4OpHyoVRkvCtCk/WeGVm4r6+vfXfmRD/RTAzMlpa7itoM/Lw1OkUcHnqNAL/XFv14
         Uv9aobxx3J9cGNv9Lx2IjlobDb54qEf9A9xwV5Ur4XI5VmOc0e6SfAG/R3YzvvYKQTPO
         fK/+QbgKXPkMIKD/c8s4nP6Stgb+NOE+dNwDqVqLd2/AsVyTYjkaYrMbuq1uIlJ9kNjk
         UMMzUvyqWVaCUpcWHajcI7OHUr/y8Pq8/N51Iv9evSWYev2JqfJWszVop9XSxnv3MASs
         3a2DQcijWC6JuqssV7uNZtEoZyF4XnN/q5CmZKnhdKr7oNuwErIYHfrzLwiDh9D9whCo
         YEug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wQ1i30iYSbM1E0tY0uz5+ptChSg4d1LMooSt7pYAIp4=;
        b=FqtdOnTPkG7utS8kyxqCy+DFuRm3RciSD0YwGvdtfD/Ca7QMOAHFtXr9wuXObGtVd5
         G6klbbxL7rWyv8U5oa2mrAvQA15dzvhgPisw9ecC1sRSkpISzKLiZ6Ju7c1ldV24stZH
         RV7G/18x9Cw0Dba8G6lPyFhV9Y6kFGbPMjEWlQOIqn9WaFUK+CesnKt7J2VHsFOpGwtQ
         FDvCL2lqSgoV1PmgpeUfMiio7Ns4jkzfmqO28uXacesXXYhC3OZbwgGhpIxt6S8cKPYJ
         c/EutxKGLD1dC6ZpRa7RkPZCiAWuervpi4MCGA3va3rtGXGFncbuNZ6ejLkKn/iPdzVP
         U0Fg==
X-Gm-Message-State: AOAM530mSXQWfIeBdfrARQhSVJbHGJF6ipLHikul+el+7QEH1/U6oYUq
        +pQkH0iXT3pQW3lUKX0w5qYMB4Iww43fvPDTP9/wrw==
X-Google-Smtp-Source: ABdhPJzCYKb8DvqERDkL3H9QJlkZgbf25hBn8OO3QFDLQ5DXsMbFlosEaM1m9TBf31uEuGk9GMa/XzF8p9sCGXVxoRI=
X-Received: by 2002:adf:fdce:: with SMTP id i14mr18888180wrs.273.1595929747173;
 Tue, 28 Jul 2020 02:49:07 -0700 (PDT)
MIME-Version: 1.0
References: <cover.7a1aa1784976093af26cb31fd283cf5b3ed568bb.1594230107.git-series.maxime@cerno.tech>
 <4c3be351dac862a07c30bc32d13de495f1674045.1594230107.git-series.maxime@cerno.tech>
In-Reply-To: <4c3be351dac862a07c30bc32d13de495f1674045.1594230107.git-series.maxime@cerno.tech>
From:   Dave Stevenson <dave.stevenson@raspberrypi.com>
Date:   Tue, 28 Jul 2020 10:48:52 +0100
Message-ID: <CAPY8ntA_SKfamtwEYQ7Ti+2Kj_x1gTNP7A9OZecOyBOXvc=_AA@mail.gmail.com>
Subject: Re: [PATCH v4 10/78] drm/vc4: crtc: Rename HVS channel to output
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

On Wed, 8 Jul 2020 at 18:42, Maxime Ripard <maxime@cerno.tech> wrote:
>
> In vc5, the HVS has 6 outputs and 3 FIFOs (or channels), with
> pixelvalves each being assigned to a given output, but each output can
> then be muxed to feed from multiple FIFOs.
>
> Since vc4 had that entirely static, both were probably equivalent, but
> since that changes, let's rename hvs_channel to hvs_output in the
> vc4_crtc_data, since a pixelvalve is really connected to an output, and
> not to a FIFO.
>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>

Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>

> ---
>  drivers/gpu/drm/vc4/vc4_crtc.c | 8 ++++----
>  drivers/gpu/drm/vc4/vc4_drv.h  | 4 ++--
>  drivers/gpu/drm/vc4/vc4_hvs.c  | 2 +-
>  drivers/gpu/drm/vc4/vc4_txp.c  | 2 +-
>  4 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/vc4/vc4_crtc.c b/drivers/gpu/drm/vc4/vc4_crtc.c
> index fdecaba77836..d3126fe04d9a 100644
> --- a/drivers/gpu/drm/vc4/vc4_crtc.c
> +++ b/drivers/gpu/drm/vc4/vc4_crtc.c
> @@ -775,7 +775,7 @@ static const struct drm_crtc_helper_funcs vc4_crtc_helper_funcs = {
>
>  static const struct vc4_pv_data bcm2835_pv0_data = {
>         .base = {
> -               .hvs_channel = 0,
> +               .hvs_output = 0,
>         },
>         .debugfs_name = "crtc0_regs",
>         .pixels_per_clock = 1,
> @@ -787,7 +787,7 @@ static const struct vc4_pv_data bcm2835_pv0_data = {
>
>  static const struct vc4_pv_data bcm2835_pv1_data = {
>         .base = {
> -               .hvs_channel = 2,
> +               .hvs_output = 2,
>         },
>         .debugfs_name = "crtc1_regs",
>         .pixels_per_clock = 1,
> @@ -799,7 +799,7 @@ static const struct vc4_pv_data bcm2835_pv1_data = {
>
>  static const struct vc4_pv_data bcm2835_pv2_data = {
>         .base = {
> -               .hvs_channel = 1,
> +               .hvs_output = 1,
>         },
>         .debugfs_name = "crtc2_regs",
>         .pixels_per_clock = 1,
> @@ -862,7 +862,7 @@ int vc4_crtc_init(struct drm_device *drm, struct vc4_crtc *vc4_crtc,
>         drm_crtc_init_with_planes(drm, crtc, primary_plane, NULL,
>                                   crtc_funcs, NULL);
>         drm_crtc_helper_add(crtc, crtc_helper_funcs);
> -       vc4_crtc->channel = vc4_crtc->data->hvs_channel;
> +       vc4_crtc->channel = vc4_crtc->data->hvs_output;
>         drm_mode_crtc_set_gamma_size(crtc, ARRAY_SIZE(vc4_crtc->lut_r));
>         drm_crtc_enable_color_mgmt(crtc, 0, false, crtc->gamma_size);
>
> diff --git a/drivers/gpu/drm/vc4/vc4_drv.h b/drivers/gpu/drm/vc4/vc4_drv.h
> index d80fc3bbb450..d1cf4c038180 100644
> --- a/drivers/gpu/drm/vc4/vc4_drv.h
> +++ b/drivers/gpu/drm/vc4/vc4_drv.h
> @@ -447,8 +447,8 @@ to_vc4_encoder(struct drm_encoder *encoder)
>  }
>
>  struct vc4_crtc_data {
> -       /* Which channel of the HVS this pixelvalve sources from. */
> -       int hvs_channel;
> +       /* Which output of the HVS this pixelvalve sources from. */
> +       int hvs_output;
>  };
>
>  struct vc4_pv_data {
> diff --git a/drivers/gpu/drm/vc4/vc4_hvs.c b/drivers/gpu/drm/vc4/vc4_hvs.c
> index 091fdf4908aa..6fd9de1dc65a 100644
> --- a/drivers/gpu/drm/vc4/vc4_hvs.c
> +++ b/drivers/gpu/drm/vc4/vc4_hvs.c
> @@ -419,7 +419,7 @@ void vc4_hvs_mode_set_nofb(struct drm_crtc *crtc)
>         struct drm_display_mode *mode = &crtc->state->adjusted_mode;
>         bool interlace = mode->flags & DRM_MODE_FLAG_INTERLACE;
>
> -       if (vc4_crtc->data->hvs_channel == 2) {
> +       if (vc4_crtc->data->hvs_output == 2) {
>                 u32 dispctrl;
>                 u32 dsp3_mux;
>
> diff --git a/drivers/gpu/drm/vc4/vc4_txp.c b/drivers/gpu/drm/vc4/vc4_txp.c
> index a7c3af0005a0..f39d9900d027 100644
> --- a/drivers/gpu/drm/vc4/vc4_txp.c
> +++ b/drivers/gpu/drm/vc4/vc4_txp.c
> @@ -452,7 +452,7 @@ static irqreturn_t vc4_txp_interrupt(int irq, void *data)
>  }
>
>  static const struct vc4_crtc_data vc4_txp_crtc_data = {
> -       .hvs_channel = 2,
> +       .hvs_output = 2,
>  };
>
>  static int vc4_txp_bind(struct device *dev, struct device *master, void *data)
> --
> git-series 0.9.1
