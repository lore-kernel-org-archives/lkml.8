Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36B71C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 15:30:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D7FE2078E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 15:30:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="I5twUgwr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730919AbgG1Paf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 11:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730637AbgG1Paf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 11:30:35 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE85C061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 08:30:34 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id r2so13638962wrs.8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 08:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+/MweqE4fo3ies98OuOCD9mQ9+9iVlg+rECmf+irmFA=;
        b=I5twUgwrgMu2P8NRQJTFMtovKxG8fbPMYuB45pLfXPR7g2n7UiK4QtthPVAUUXZgtT
         wzn4Cu+VNxVUsHmEFFmnvhwMUkbOkuhJcV5CCdQatVLfpxfrwMYweN6X9bzcTILiBrml
         qbpHHZAWYMp3qvfAkx+9YIEokB/xeHr8RZYuNpP9VHT1EtNctMi0CToCwKER1KiyjowS
         BFjUYBfcEZwZW+wG0tQwiDr9dHVdzfoVYGFPyw8iKwee3z5W2/xpSkKZi2OgqVu3+APs
         lh8Mhiax7CC2akub6VPEWAXc5S2yarchllUfHvyTBswnsW7eD0nozMyGkGqwkwst+Rjh
         F67w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+/MweqE4fo3ies98OuOCD9mQ9+9iVlg+rECmf+irmFA=;
        b=UOJZ4f4SgUdBKoVU+d3WuM7jJ7PjXZX6r8fx5kB+6D45qkAjTBKVsS07MGms3pmmke
         fY4LZsMyZOH2qKW5SAbY5vzFoP2qjur9q2XFglnyvsqpzb9zJB9A7yD3Q51PdDAjvIRg
         rA7gcioQnfVGDVaxSFPvROUAbITLao/k04W8pjT3X4hTPFGBoLKE7AzGicTeLZcSZZdT
         cG6YGI7nud42HtmoBL53nWMKobFTbCFtcs321N0NhOX0MBFaIe3Lz14bOPGTX3PS1jgA
         YsSjW6pCBZe7iyCBEuQ2+9w4AASoPwrbgzmWdgKsBsgF4bI2Kd2G8WPSvbZ30IpIQCq1
         e4TA==
X-Gm-Message-State: AOAM531H+tyvQl0uQwnIduCycToMCziL6pGKpr3mCwPrYTOFg/67rfj4
        Uj93PIYcDWFmqUpncB9mS0PaQCTnM3QpxVUcT51vyA==
X-Google-Smtp-Source: ABdhPJxvvieBfVuOSjh3FV/8raIvobRVmuPFlSewQwflYLjB304mWmC3gwGeRCiiEq8XJ6CMCONtTG7tM35J4cczRdE=
X-Received: by 2002:a5d:5383:: with SMTP id d3mr18473386wrv.42.1595950232724;
 Tue, 28 Jul 2020 08:30:32 -0700 (PDT)
MIME-Version: 1.0
References: <cover.7a1aa1784976093af26cb31fd283cf5b3ed568bb.1594230107.git-series.maxime@cerno.tech>
 <90c53367b289e9c0f9eeb97794a8d3b08d813884.1594230107.git-series.maxime@cerno.tech>
In-Reply-To: <90c53367b289e9c0f9eeb97794a8d3b08d813884.1594230107.git-series.maxime@cerno.tech>
From:   Dave Stevenson <dave.stevenson@raspberrypi.com>
Date:   Tue, 28 Jul 2020 16:30:16 +0100
Message-ID: <CAPY8ntB3eeqqz0hPSfHiJpKs9sJpU5uN5GzLsqmhtxrD0i6TJg@mail.gmail.com>
Subject: Re: [PATCH v4 77/78] drm/vc4: drv: Support BCM2711
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
> The BCM2711 has a reworked display pipeline, and the load tracker needs
> some adjustement to operate properly. Let's add a compatible for BCM2711

s/adjustement/adjustment

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
> index 9567d1019212..f1a5fd5dab6f 100644
> --- a/drivers/gpu/drm/vc4/vc4_drv.c
> +++ b/drivers/gpu/drm/vc4/vc4_drv.c
> @@ -372,6 +372,7 @@ static int vc4_platform_drm_remove(struct platform_device *pdev)
>  }
>
>  static const struct of_device_id vc4_of_match[] = {
> +       { .compatible = "brcm,bcm2711-vc5", },
>         { .compatible = "brcm,bcm2835-vc4", },
>         { .compatible = "brcm,cygnus-vc4", },
>         {},
> diff --git a/drivers/gpu/drm/vc4/vc4_drv.h b/drivers/gpu/drm/vc4/vc4_drv.h
> index 501a48a714d3..8c8d96b6289f 100644
> --- a/drivers/gpu/drm/vc4/vc4_drv.h
> +++ b/drivers/gpu/drm/vc4/vc4_drv.h
> @@ -200,6 +200,9 @@ struct vc4_dev {
>
>         int power_refcount;
>
> +       /* Set to true when the load tracker is supported. */
> +       bool load_tracker_available;
> +
>         /* Set to true when the load tracker is active. */
>         bool load_tracker_enabled;
>
> diff --git a/drivers/gpu/drm/vc4/vc4_kms.c b/drivers/gpu/drm/vc4/vc4_kms.c
> index 7c8a87339959..ae479f988666 100644
> --- a/drivers/gpu/drm/vc4/vc4_kms.c
> +++ b/drivers/gpu/drm/vc4/vc4_kms.c
> @@ -532,6 +532,9 @@ static int vc4_load_tracker_atomic_check(struct drm_atomic_state *state)
>         struct drm_plane *plane;
>         int i;
>
> +       if (!vc4->load_tracker_available)
> +               return 0;
> +
>         priv_state = drm_atomic_get_private_obj_state(state,
>                                                       &vc4->load_tracker);
>         if (IS_ERR(priv_state))
> @@ -681,10 +684,14 @@ int vc4_kms_load(struct drm_device *dev)
>         struct vc4_load_tracker_state *load_state;
>         int ret;
>
> -       /* Start with the load tracker enabled. Can be disabled through the
> -        * debugfs load_tracker file.
> -        */
> -       vc4->load_tracker_enabled = true;
> +       if (!of_device_is_compatible(dev->dev->of_node, "brcm,bcm2711-vc5")) {

Is it better to look up the compatible string, or pass something via
the .data element of the of_device_id table? Probably down to personal
preference?

> +               vc4->load_tracker_available = true;
> +
> +               /* Start with the load tracker enabled. Can be
> +                * disabled through the debugfs load_tracker file.
> +                */
> +               vc4->load_tracker_enabled = true;
> +       }
>
>         sema_init(&vc4->async_modeset, 1);
>
> @@ -698,8 +705,14 @@ int vc4_kms_load(struct drm_device *dev)
>                 return ret;
>         }
>
> -       dev->mode_config.max_width = 2048;
> -       dev->mode_config.max_height = 2048;
> +       if (of_device_is_compatible(dev->dev->of_node, "brcm,bcm2711-vc5")) {

We're making the same of_device_is_compatible call twice within
vc4_kms_load. Set a flag based on it and check that instead?

  Dave

> +               dev->mode_config.max_width = 7680;
> +               dev->mode_config.max_height = 7680;
> +       } else {
> +               dev->mode_config.max_width = 2048;
> +               dev->mode_config.max_height = 2048;
> +       }
> +
>         dev->mode_config.funcs = &vc4_mode_funcs;
>         dev->mode_config.preferred_depth = 24;
>         dev->mode_config.async_page_flip = true;
> @@ -714,14 +727,17 @@ int vc4_kms_load(struct drm_device *dev)
>         drm_atomic_private_obj_init(dev, &vc4->ctm_manager, &ctm_state->base,
>                                     &vc4_ctm_state_funcs);
>
> -       load_state = kzalloc(sizeof(*load_state), GFP_KERNEL);
> -       if (!load_state) {
> -               drm_atomic_private_obj_fini(&vc4->ctm_manager);
> -               return -ENOMEM;
> -       }
> +       if (vc4->load_tracker_available) {
> +               load_state = kzalloc(sizeof(*load_state), GFP_KERNEL);
> +               if (!load_state) {
> +                       drm_atomic_private_obj_fini(&vc4->ctm_manager);
> +                       return -ENOMEM;
> +               }
>
> -       drm_atomic_private_obj_init(dev, &vc4->load_tracker, &load_state->base,
> -                                   &vc4_load_tracker_state_funcs);
> +               drm_atomic_private_obj_init(dev, &vc4->load_tracker,
> +                                           &load_state->base,
> +                                           &vc4_load_tracker_state_funcs);
> +       }
>
>         drm_mode_config_reset(dev);
>
> diff --git a/drivers/gpu/drm/vc4/vc4_plane.c b/drivers/gpu/drm/vc4/vc4_plane.c
> index 1e38e603f83b..24d7e6db6fdd 100644
> --- a/drivers/gpu/drm/vc4/vc4_plane.c
> +++ b/drivers/gpu/drm/vc4/vc4_plane.c
> @@ -516,6 +516,11 @@ static void vc4_plane_calc_load(struct drm_plane_state *state)
>         struct vc4_plane_state *vc4_state;
>         struct drm_crtc_state *crtc_state;
>         unsigned int vscale_factor;
> +       struct vc4_dev *vc4;
> +
> +       vc4 = to_vc4_dev(state->plane->dev);
> +       if (!vc4->load_tracker_available)
> +               return;
>
>         vc4_state = to_vc4_plane_state(state);
>         crtc_state = drm_atomic_get_existing_crtc_state(state->state,
> --
> git-series 0.9.1
