Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE501C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 13:03:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C593B20663
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 13:03:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="Cw/Vz4YG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729952AbgG1NDT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 09:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729764AbgG1NDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 09:03:18 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2102AC061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 06:03:18 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id t142so11751915wmt.4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 06:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wv84ulHBLNw4Uf5oxYsoMX+Mv7LdyizqK6mgHY/q9Lg=;
        b=Cw/Vz4YG3V+q9BXCM+dRF8Bf1+qaTvaVBLZtNXFHMhI+iwRPIr1VMt0h31PKFR1K3w
         +KsWrczwug5KX/BqsyIEzuvdM1keRi8mGc/8LbBrbfWJjGGSKN5PfJggpJOFmzc8L5CB
         PSQILgbHeYV22T6xLuO7xDwIpu4iOT7pgifyK3xBoLmvUkLYykrw4ZAbjQ7OAUlogwDz
         PkOelni0f1GB8DCgyZuITXzIjke8GqIjkEAvSBOA/3TYq2ry+qxyvO1jQMvO1wqn8q6L
         BewuijkFBtR61aW6Z/VxiNfUu9+tu9kfUHbqz2RTBcFiF6m4HQB8aLRJVGjY9a/o1Udw
         J0pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wv84ulHBLNw4Uf5oxYsoMX+Mv7LdyizqK6mgHY/q9Lg=;
        b=iyXf/dLadGid7kzW9N7XfXEhdx4kzKGHVATFlGjbHkp5gX342ouC7Z1R9kVm/qjH4Z
         BM3rh30F3LZvCmaDe9NsLUi9aE+tuoRp/U11+h3+xaM4PxtIrLSubFn6ImjYVW45SiY1
         SqFohy3gIavrQkNSObHWVWA+8eRPC4pAO1894Mo90b9e7Xhok64pvBbPVWcYTtVc+gCD
         3Mx73Dc/VAnUfqNucXCzvguaSIhfczofDXLXruBd5sKbW61nHo4LwEqKHuhirI+EcUIn
         dahwq+ymzdJ2DZIABILvvV8MPI1YgqO94BUgwkort5/DFYun3r1rsKb8KYGcErlAzvPk
         98MQ==
X-Gm-Message-State: AOAM530JoiGEXF08BFL2ZtteoJxKb2WOdaaMIvyG9C14JfI5UByNkTsO
        uYJKTgmH5CgGxg1AQ98KauWfYNZ3PaSWK8Cpy0XUOg==
X-Google-Smtp-Source: ABdhPJwdB7oDA/Uqj1bSF0wZ3zvwcMHPhTJTdpSbPzhoZ35h4LBovlO0Tm+FCn284QnywH5X/aUMaAJcxfFfhuNcVeE=
X-Received: by 2002:a1c:e382:: with SMTP id a124mr3687596wmh.96.1595941396813;
 Tue, 28 Jul 2020 06:03:16 -0700 (PDT)
MIME-Version: 1.0
References: <cover.7a1aa1784976093af26cb31fd283cf5b3ed568bb.1594230107.git-series.maxime@cerno.tech>
 <9ac309938e18a55c1c48d3520fe51a61f3c09b1f.1594230107.git-series.maxime@cerno.tech>
In-Reply-To: <9ac309938e18a55c1c48d3520fe51a61f3c09b1f.1594230107.git-series.maxime@cerno.tech>
From:   Dave Stevenson <dave.stevenson@raspberrypi.com>
Date:   Tue, 28 Jul 2020 14:03:00 +0100
Message-ID: <CAPY8ntDiLWkfYwXUyTf-v51z6t3tE7qnsBpC9wN_AMcW=CyWiQ@mail.gmail.com>
Subject: Re: [PATCH v4 53/78] drm/vc4: hdmi: Add PHY init and disable function
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
> The HDMI PHY in the BCM2711 HDMI controller is significantly more
> complicated to setup than in the older BCM283x SoCs.
>
> Let's add hooks to enable and disable the PHY.
>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>

Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>

> ---
>  drivers/gpu/drm/vc4/Makefile       |  1 +
>  drivers/gpu/drm/vc4/vc4_hdmi.c     | 14 +++++++-------
>  drivers/gpu/drm/vc4/vc4_hdmi.h     | 13 +++++++++++++
>  drivers/gpu/drm/vc4/vc4_hdmi_phy.c | 25 +++++++++++++++++++++++++
>  4 files changed, 46 insertions(+), 7 deletions(-)
>  create mode 100644 drivers/gpu/drm/vc4/vc4_hdmi_phy.c
>
> diff --git a/drivers/gpu/drm/vc4/Makefile b/drivers/gpu/drm/vc4/Makefile
> index b303703bc7f3..d0163e18e9ca 100644
> --- a/drivers/gpu/drm/vc4/Makefile
> +++ b/drivers/gpu/drm/vc4/Makefile
> @@ -12,6 +12,7 @@ vc4-y := \
>         vc4_kms.o \
>         vc4_gem.o \
>         vc4_hdmi.o \
> +       vc4_hdmi_phy.o \
>         vc4_vec.o \
>         vc4_hvs.o \
>         vc4_irq.o \
> diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
> index 80bc3dd9d4a8..068041145d1c 100644
> --- a/drivers/gpu/drm/vc4/vc4_hdmi.c
> +++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
> @@ -321,7 +321,9 @@ static void vc4_hdmi_encoder_disable(struct drm_encoder *encoder)
>
>         HDMI_WRITE(HDMI_RAM_PACKET_CONFIG, 0);
>
> -       HDMI_WRITE(HDMI_TX_PHY_RESET_CTL, 0xf << 16);
> +       if (vc4_hdmi->variant->phy_disable)
> +               vc4_hdmi->variant->phy_disable(vc4_hdmi);
> +
>         HDMI_WRITE(HDMI_VID_CTL,
>                    HDMI_READ(HDMI_VID_CTL) & ~VC4_HD_VID_CTL_ENABLE);
>
> @@ -381,12 +383,8 @@ static void vc4_hdmi_encoder_enable(struct drm_encoder *encoder)
>         if (vc4_hdmi->variant->reset)
>                 vc4_hdmi->variant->reset(vc4_hdmi);
>
> -       /* PHY should be in reset, like
> -        * vc4_hdmi_encoder_disable() does.
> -        */
> -       HDMI_WRITE(HDMI_TX_PHY_RESET_CTL, 0xf << 16);
> -
> -       HDMI_WRITE(HDMI_TX_PHY_RESET_CTL, 0);
> +       if (vc4_hdmi->variant->phy_init)
> +               vc4_hdmi->variant->phy_init(vc4_hdmi, mode);
>
>         if (debug_dump_regs) {
>                 struct drm_printer p = drm_info_printer(&vc4_hdmi->pdev->dev);
> @@ -1433,6 +1431,8 @@ static const struct vc4_hdmi_variant bcm2835_variant = {
>
>         .init_resources         = vc4_hdmi_init_resources,
>         .reset                  = vc4_hdmi_reset,
> +       .phy_init               = vc4_hdmi_phy_init,
> +       .phy_disable            = vc4_hdmi_phy_disable,
>  };
>
>  static const struct of_device_id vc4_hdmi_dt_match[] = {
> diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.h b/drivers/gpu/drm/vc4/vc4_hdmi.h
> index 17a30589f39c..32c80161c786 100644
> --- a/drivers/gpu/drm/vc4/vc4_hdmi.h
> +++ b/drivers/gpu/drm/vc4/vc4_hdmi.h
> @@ -21,6 +21,8 @@ to_vc4_hdmi_encoder(struct drm_encoder *encoder)
>         return container_of(encoder, struct vc4_hdmi_encoder, base.base);
>  }
>
> +struct drm_display_mode;
> +
>  struct vc4_hdmi;
>  struct vc4_hdmi_register;
>
> @@ -38,6 +40,13 @@ struct vc4_hdmi_variant {
>
>         /* Callback to reset the HDMI block */
>         void (*reset)(struct vc4_hdmi *vc4_hdmi);
> +
> +       /* Callback to initialize the PHY according to the mode */
> +       void (*phy_init)(struct vc4_hdmi *vc4_hdmi,
> +                        struct drm_display_mode *mode);
> +
> +       /* Callback to disable the PHY */
> +       void (*phy_disable)(struct vc4_hdmi *vc4_hdmi);
>  };
>
>  /* HDMI audio information */
> @@ -95,4 +104,8 @@ encoder_to_vc4_hdmi(struct drm_encoder *encoder)
>         return container_of(_encoder, struct vc4_hdmi, encoder);
>  }
>
> +void vc4_hdmi_phy_init(struct vc4_hdmi *vc4_hdmi,
> +                      struct drm_display_mode *mode);
> +void vc4_hdmi_phy_disable(struct vc4_hdmi *vc4_hdmi);
> +
>  #endif /* _VC4_HDMI_H_ */
> diff --git a/drivers/gpu/drm/vc4/vc4_hdmi_phy.c b/drivers/gpu/drm/vc4/vc4_hdmi_phy.c
> new file mode 100644
> index 000000000000..5a1746877bb5
> --- /dev/null
> +++ b/drivers/gpu/drm/vc4/vc4_hdmi_phy.c
> @@ -0,0 +1,25 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2015 Broadcom
> + * Copyright (c) 2014 The Linux Foundation. All rights reserved.
> + * Copyright (C) 2013 Red Hat
> + * Author: Rob Clark <robdclark@gmail.com>
> + */
> +
> +#include "vc4_hdmi.h"
> +#include "vc4_hdmi_regs.h"
> +
> +void vc4_hdmi_phy_init(struct vc4_hdmi *vc4_hdmi, struct drm_display_mode *mode)
> +{
> +       /* PHY should be in reset, like
> +        * vc4_hdmi_encoder_disable() does.
> +        */
> +
> +       HDMI_WRITE(HDMI_TX_PHY_RESET_CTL, 0xf << 16);
> +       HDMI_WRITE(HDMI_TX_PHY_RESET_CTL, 0);
> +}
> +
> +void vc4_hdmi_phy_disable(struct vc4_hdmi *vc4_hdmi)
> +{
> +       HDMI_WRITE(HDMI_TX_PHY_RESET_CTL, 0xf << 16);
> +}
> --
> git-series 0.9.1
