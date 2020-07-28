Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32010C433E8
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 13:01:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08A6720663
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 13:01:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="Hx12KSYm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729880AbgG1NBH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 09:01:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729857AbgG1NBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 09:01:03 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B854C061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 06:01:02 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id k20so10443636wmi.5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 06:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8jmZcLNhJMqYMjcTqjPQmtQ8P0Msg4xOuIQgfa8zC1w=;
        b=Hx12KSYmyNspQ20MnI262XHd/ggVHzu3cALqhn4ACAVTDUceBouCvxfbBeDW9WyLHB
         HJhl2sQ2aEpl1gXV5mh4s4iM8Tlck07exfeOsFa1bYBjLRGPJEmDme8aC1S+H3jmMTqn
         KAF4/T+Rhoa23qTWOgY6Vrx0O78QbgbXqsG0/cUbN4tzO6FoLWE/G63gDdfjUU+whmR3
         C02+0s1IUMuMrDgM8pzbOYYCemwrfdnoTTlf3fJG+nxMpMvdNr/gvgcQqXaLwrQDGM5g
         dV8Z9eP6LUJWO/08CXBVh2goLZ7fjkwO2HRrNwSKxAgG0FOR50Rz95mjiSsDFJUBQqln
         kr1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8jmZcLNhJMqYMjcTqjPQmtQ8P0Msg4xOuIQgfa8zC1w=;
        b=TvDRr1fibhPd1GCHcGJ0gifg+vsa8bQ/1kjvVj53ULkpHK41UasRLgXa4cK0tVq1/e
         gJL5WXZnMNc0wxWCIsraNsxOKZVcy9u8Sx98Tni3zmwU3P6zVP4TdYILshFbUEAEKYDT
         6iffZPNjO0mftLkTi/wrNtyrzHKXjYf1+1/UP1PO64AX8lYqJHPgscw8toXtWcmuGEak
         t38sCdilqeR6vkXDyMbEY8NNjEH/Noc+CBqqumNevOeYM8gUxLbx2D9/ySfmsgRWe6qv
         XzznxlYNy5uirNEWeUsrdW9p+PF1CjbA9ANUc7VXc86sB97vHt8GoWXR3PeY+A71BTuN
         CN1g==
X-Gm-Message-State: AOAM532Suo4Tm6Rf93tNTEhJjv1UC4QLpBtISKiz+uRRTPR81jHWzycI
        Ww4afd1g9ntnvCSi1NjpSF/pIdQFcLJeuPMuJ3ryLw==
X-Google-Smtp-Source: ABdhPJzNJGXoMkeyB78SIo1q7nH5otCVlzH/fPUf3ev2WPGKtmu6lqowrHi4IrqPinZ5+zG7noCHHP+YZrqMMkPK5N0=
X-Received: by 2002:a05:600c:d7:: with SMTP id u23mr3688799wmm.183.1595941261046;
 Tue, 28 Jul 2020 06:01:01 -0700 (PDT)
MIME-Version: 1.0
References: <cover.7a1aa1784976093af26cb31fd283cf5b3ed568bb.1594230107.git-series.maxime@cerno.tech>
 <ab00cc4655224f26d74c307a410bbca8d67dbbbb.1594230107.git-series.maxime@cerno.tech>
In-Reply-To: <ab00cc4655224f26d74c307a410bbca8d67dbbbb.1594230107.git-series.maxime@cerno.tech>
From:   Dave Stevenson <dave.stevenson@raspberrypi.com>
Date:   Tue, 28 Jul 2020 14:00:42 +0100
Message-ID: <CAPY8ntAduOMFgDSkekX5mXDYbQpG_eu-CGtUBRjxAofbWJi--Q@mail.gmail.com>
Subject: Re: [PATCH v4 52/78] drm/vc4: hdmi: Add reset callback
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
> The BCM2711 and BCM283x HDMI controllers use a slightly different reset
> sequence, so let's add a callback to reset the controller.
>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>

Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>

> ---
>  drivers/gpu/drm/vc4/vc4_hdmi.c | 31 ++++++++++++++++++-------------
>  drivers/gpu/drm/vc4/vc4_hdmi.h |  3 +++
>  2 files changed, 21 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
> index a4fed1439bf3..80bc3dd9d4a8 100644
> --- a/drivers/gpu/drm/vc4/vc4_hdmi.c
> +++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
> @@ -69,6 +69,21 @@ static int vc4_hdmi_debugfs_regs(struct seq_file *m, void *unused)
>         return 0;
>  }
>
> +static void vc4_hdmi_reset(struct vc4_hdmi *vc4_hdmi)
> +{
> +       HDMI_WRITE(HDMI_M_CTL, VC4_HD_M_SW_RST);
> +       udelay(1);
> +       HDMI_WRITE(HDMI_M_CTL, 0);
> +
> +       HDMI_WRITE(HDMI_M_CTL, VC4_HD_M_ENABLE);
> +
> +       HDMI_WRITE(HDMI_SW_RESET_CONTROL,
> +                  VC4_HDMI_SW_RESET_HDMI |
> +                  VC4_HDMI_SW_RESET_FORMAT_DETECT);
> +
> +       HDMI_WRITE(HDMI_SW_RESET_CONTROL, 0);
> +}
> +
>  static enum drm_connector_status
>  vc4_hdmi_connector_detect(struct drm_connector *connector, bool force)
>  {
> @@ -363,11 +378,8 @@ static void vc4_hdmi_encoder_enable(struct drm_encoder *encoder)
>                 return;
>         }
>
> -       HDMI_WRITE(HDMI_SW_RESET_CONTROL,
> -                  VC4_HDMI_SW_RESET_HDMI |
> -                  VC4_HDMI_SW_RESET_FORMAT_DETECT);
> -
> -       HDMI_WRITE(HDMI_SW_RESET_CONTROL, 0);
> +       if (vc4_hdmi->variant->reset)
> +               vc4_hdmi->variant->reset(vc4_hdmi);
>
>         /* PHY should be in reset, like
>          * vc4_hdmi_encoder_disable() does.
> @@ -1292,14 +1304,6 @@ static int vc4_hdmi_bind(struct device *dev, struct device *master, void *data)
>                 vc4_hdmi->hpd_active_low = hpd_gpio_flags & OF_GPIO_ACTIVE_LOW;
>         }
>
> -       /* HDMI core must be enabled. */
> -       if (!(HDMI_READ(HDMI_M_CTL) & VC4_HD_M_ENABLE)) {
> -               HDMI_WRITE(HDMI_M_CTL, VC4_HD_M_SW_RST);
> -               udelay(1);
> -               HDMI_WRITE(HDMI_M_CTL, 0);
> -
> -               HDMI_WRITE(HDMI_M_CTL, VC4_HD_M_ENABLE);
> -       }
>         pm_runtime_enable(dev);
>
>         drm_simple_encoder_init(drm, encoder, DRM_MODE_ENCODER_TMDS);
> @@ -1428,6 +1432,7 @@ static const struct vc4_hdmi_variant bcm2835_variant = {
>         .num_registers          = ARRAY_SIZE(vc4_hdmi_fields),
>
>         .init_resources         = vc4_hdmi_init_resources,
> +       .reset                  = vc4_hdmi_reset,
>  };
>
>  static const struct of_device_id vc4_hdmi_dt_match[] = {
> diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.h b/drivers/gpu/drm/vc4/vc4_hdmi.h
> index b36e0210671f..17a30589f39c 100644
> --- a/drivers/gpu/drm/vc4/vc4_hdmi.h
> +++ b/drivers/gpu/drm/vc4/vc4_hdmi.h
> @@ -35,6 +35,9 @@ struct vc4_hdmi_variant {
>          * clocks, etc) for that variant.
>          */
>         int (*init_resources)(struct vc4_hdmi *vc4_hdmi);
> +
> +       /* Callback to reset the HDMI block */
> +       void (*reset)(struct vc4_hdmi *vc4_hdmi);
>  };
>
>  /* HDMI audio information */
> --
> git-series 0.9.1
