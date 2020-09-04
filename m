Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6969FC43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 15:51:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C5992074D
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 15:51:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="ctlOJyDx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbgIDPvn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 11:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbgIDPvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 11:51:42 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA77FC061244
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 08:51:41 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id k15so7193124wrn.10
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 08:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+mUIkf5+wSrm/eOZF7pJYOzf+3jat87UbehRU5d1CD4=;
        b=ctlOJyDxNnInQWTjGofcghYd8KfO8SgyHTC6gCppdxK0TvyA9HS2p/aVj9h9So7J5/
         udjKiN+Q6VjQpb3vEQXFQ7uZN9LqWakT6awNFc6XlK3vzZy18iU8Lu066utYipZNZrWg
         Tf65wHzRBTDvSAZ7079Aepz5+qFAlMKSRKmd2xzua42SCMZQBBwDoKMldF+tx2WKlkyx
         VzoXt48tG+KSkEOePMS1j0xCZxw+OFBbzhsR8OhUaGKUhi4WHTNwrcfOQ6CwT/2DMU4c
         02hw93ZPf0sJy49WW/hEFgcwXDnVazQefsrvwe7LpEQzU8GWov0cthRSoQTRa9GAfY5V
         2YYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+mUIkf5+wSrm/eOZF7pJYOzf+3jat87UbehRU5d1CD4=;
        b=V6R1zdMNLQ2MxaKsqFtXMA6u9x40NhiIC4AoWprYekCcZ/571+I92XamGVg1XVMzzU
         Ne7V51nvd890PkU+GuMt1plwpbH1tBZrhjAhK8j0ZoqHQ7N3ya3Olc5ax835KThc7sWi
         +qL5VE8WcPw27TPRA+xa41Q/3EDQQrhublSURZdVhGcDGclIgXrXXVoAhrDyPFmDw8lY
         aKUhMZIArU8FkplGTBbec+uRCOHL024j7OMV5+yoKmCxHZa6gyYhtTbeYAk7R1t7Q5sk
         w2+kPJtTtlKcIGk9cXre++2m2Hth0vitIr74uqM3aDRazUFggItLuE6qrmNvmjZxDQis
         2UKg==
X-Gm-Message-State: AOAM533pRAifzYqRh6P4ZO5MkxJyPS2+bR2HqmBVLPdWpM24nvjgiiFe
        c2/ZCv7TiMOXAvSilxc3Zv1JrNxqXXtQ78ce271u5Q==
X-Google-Smtp-Source: ABdhPJxVUA4kul9AONUXChuqM/AQenlSrCidWNt9xPtYdIgi/y8Q68ckj01B30VHM7wx5Fj4Ux2eJfyD2bMAZVV7AdQ=
X-Received: by 2002:adf:ec0a:: with SMTP id x10mr7947475wrn.47.1599234700474;
 Fri, 04 Sep 2020 08:51:40 -0700 (PDT)
MIME-Version: 1.0
References: <cover.dddc064d8bb83e46744336af67dcb13139e5747d.1599120059.git-series.maxime@cerno.tech>
 <beac4f9ef0261bca731a0402c8354e9af740519c.1599120059.git-series.maxime@cerno.tech>
In-Reply-To: <beac4f9ef0261bca731a0402c8354e9af740519c.1599120059.git-series.maxime@cerno.tech>
From:   Dave Stevenson <dave.stevenson@raspberrypi.com>
Date:   Fri, 4 Sep 2020 16:51:25 +0100
Message-ID: <CAPY8ntDxn+Cpt-HPiuGdCUZW+Eg7tpmp0a23pQ5Sm4get1Rq6g@mail.gmail.com>
Subject: Re: [PATCH v5 79/80] drm/vc4: drv: Support BCM2711
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
> The BCM2711 has a reworked display pipeline, and the load tracker needs
> some adjustment to operate properly. Let's add a compatible for BCM2711
> and disable the load tracker until properly supported.
>
> Tested-by: Chanwoo Choi <cw00.choi@samsung.com>
> Tested-by: Hoegeun Kwon <hoegeun.kwon@samsung.com>
> Tested-by: Stefan Wahren <stefan.wahren@i2se.com>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>

I'm happy with this.
Potentially a case for having split it into two patches (make the load
tracker optional, and then use that option for the new compatible),
but I'm not convinced, so:

Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>

> ---
>  drivers/gpu/drm/vc4/vc4_drv.c   |  1 +-
>  drivers/gpu/drm/vc4/vc4_drv.h   |  3 ++-
>  drivers/gpu/drm/vc4/vc4_kms.c   | 44 +++++++++++++++++++++++-----------
>  drivers/gpu/drm/vc4/vc4_plane.c |  5 ++++-
>  4 files changed, 40 insertions(+), 13 deletions(-)
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
> index bfc7ddd49ac5..16e233e1406e 100644
> --- a/drivers/gpu/drm/vc4/vc4_kms.c
> +++ b/drivers/gpu/drm/vc4/vc4_kms.c
> @@ -536,6 +536,9 @@ static int vc4_load_tracker_atomic_check(struct drm_atomic_state *state)
>         struct drm_plane *plane;
>         int i;
>
> +       if (!vc4->load_tracker_available)
> +               return 0;
> +
>         priv_state = drm_atomic_get_private_obj_state(state,
>                                                       &vc4->load_tracker);
>         if (IS_ERR(priv_state))
> @@ -683,12 +686,18 @@ int vc4_kms_load(struct drm_device *dev)
>         struct vc4_dev *vc4 = to_vc4_dev(dev);
>         struct vc4_ctm_state *ctm_state;
>         struct vc4_load_tracker_state *load_state;
> +       bool is_vc5 = of_device_is_compatible(dev->dev->of_node,
> +                                             "brcm,bcm2711-vc5");
>         int ret;
>
> -       /* Start with the load tracker enabled. Can be disabled through the
> -        * debugfs load_tracker file.
> -        */
> -       vc4->load_tracker_enabled = true;
> +       if (!is_vc5) {
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
> @@ -702,8 +711,14 @@ int vc4_kms_load(struct drm_device *dev)
>                 return ret;
>         }
>
> -       dev->mode_config.max_width = 2048;
> -       dev->mode_config.max_height = 2048;
> +       if (is_vc5) {
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
> @@ -718,14 +733,17 @@ int vc4_kms_load(struct drm_device *dev)
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
