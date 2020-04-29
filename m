Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1745C83007
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 02:10:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 938D92083B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 02:10:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IGr0uPAw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbgD2CKT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 22:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbgD2CKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 22:10:18 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AB67C03C1AC
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 19:10:17 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id a7so375472uak.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 19:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EEiz4HMJY+gJLMc0IjkJJcjI52MRJi3WFunE6kev/X8=;
        b=IGr0uPAwPnAUzql39gFbigTf1/E0vT5ToGKW4FnWX3bF56hobtrwxuxfH9C+n1pxjG
         QofHwiZgi8oufhJDlBpByQQ10aVfZRFVIUrtUo5c/LHQFsbqphHkwoHE1q59g2SVB1NC
         nFc904DWiFqRUWaWvjJN/hGRl6aDvY3o4cEiU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EEiz4HMJY+gJLMc0IjkJJcjI52MRJi3WFunE6kev/X8=;
        b=UW9tbBv1+A0zMtfpzd+9IlGRuRwGSN+Xaf5hRjbStt5Ozdq7vH2EX/z9EkEpLDkr3t
         zebE+bsIGlIOPDD+GziuRYUvMtoyhr1eMKu7kEBZHCK8oieCsMTfl1mRhUe1/MqxgxR4
         5tFKlXHxmIjZGvQOiwXr99MBrYWprUGHdyHrM1SVlhRpCVjoCqPvCG3cuQXCm5gYaBpw
         Whsf5tzPEk8wT37kAZZj9njMuvInjjLWKqrnbJXApHFmyPDiF4eND/UHCBUZgjnE5Fes
         i8KjMjRAEijaEI9g/WSZW7YqsqzC9SNlmWlI5w+IL4HnOpuyjV96D4eFxVJFkzqbsSOT
         BhLg==
X-Gm-Message-State: AGi0PuaXzoGkn1vWbsaXgtO3H8K6G19pfn7/g4x2uMGcB6kJZC8XaN5d
        zMAXmulLrtS7SzkibAY6eeVWNfFnNlAJMy7cbrdCcQ==
X-Google-Smtp-Source: APiQypItlQAa5e4mGAa1IHYQ7pc+hM+tuChNF99J4Y7tM8loTIXZXHO2lcr4ukwuovUBkRtkL0SxAQLI4QpRoyNBorc=
X-Received: by 2002:ab0:254:: with SMTP id 78mr22456426uas.77.1588126215976;
 Tue, 28 Apr 2020 19:10:15 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1587880280.git.xji@analogixsemi.com> <4d14400b6c19f17c28267f6ebdbce9673333c05c.1587880280.git.xji@analogixsemi.com>
In-Reply-To: <4d14400b6c19f17c28267f6ebdbce9673333c05c.1587880280.git.xji@analogixsemi.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Wed, 29 Apr 2020 10:10:05 +0800
Message-ID: <CANMq1KC2EUPMDqTcaU-HLqfFivR4=7wxrmiSk-VzF0bjjLgNHA@mail.gmail.com>
Subject: Re: [PATCH v8 2/2] drm/bridge: anx7625: Add anx7625 MIPI DSI/DPI to
 DP bridge driver
To:     Xin Ji <xji@analogixsemi.com>
Cc:     devel@driverdev.osuosl.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Nicolas Boichat <drinkcat@google.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        lkml <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Pi-Hsun Shih <pihsun@chromium.org>,
        Sheng Pan <span@analogixsemi.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 27, 2020 at 2:18 PM Xin Ji <xji@analogixsemi.com> wrote:
>
> The ANX7625 is an ultra-low power 4K Mobile HD Transmitter designed
> for portable device. It converts MIPI DSI/DPI to DisplayPort 1.3 4K.
>
> The ANX7625 can support both USB Type-C PD feature and MIPI DSI/DPI
> to DP feature. This driver only enabled MIPI DSI/DPI to DP feature.
>
> Signed-off-by: Xin Ji <xji@analogixsemi.com>
> ---
>  drivers/gpu/drm/bridge/Makefile           |    2 +-
>  drivers/gpu/drm/bridge/analogix/Kconfig   |    6 +
>  drivers/gpu/drm/bridge/analogix/Makefile  |    1 +
>  drivers/gpu/drm/bridge/analogix/anx7625.c | 2158 +++++++++++++++++++++++++++++
>  drivers/gpu/drm/bridge/analogix/anx7625.h |  410 ++++++
>  5 files changed, 2576 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/gpu/drm/bridge/analogix/anx7625.c
>  create mode 100644 drivers/gpu/drm/bridge/analogix/anx7625.h
>
> diff --git a/drivers/gpu/drm/bridge/Makefile b/drivers/gpu/drm/bridge/Makefile
> index 4934fcf..bcd388a 100644
> --- a/drivers/gpu/drm/bridge/Makefile
> +++ b/drivers/gpu/drm/bridge/Makefile
> @@ -12,8 +12,8 @@ obj-$(CONFIG_DRM_SII9234) += sii9234.o
>  obj-$(CONFIG_DRM_THINE_THC63LVD1024) += thc63lvd1024.o
>  obj-$(CONFIG_DRM_TOSHIBA_TC358764) += tc358764.o
>  obj-$(CONFIG_DRM_TOSHIBA_TC358767) += tc358767.o
> -obj-$(CONFIG_DRM_ANALOGIX_DP) += analogix/
>  obj-$(CONFIG_DRM_I2C_ADV7511) += adv7511/
>  obj-$(CONFIG_DRM_TI_SN65DSI86) += ti-sn65dsi86.o
>  obj-$(CONFIG_DRM_TI_TFP410) += ti-tfp410.o
> +obj-y += analogix/
>  obj-y += synopsys/
> diff --git a/drivers/gpu/drm/bridge/analogix/Kconfig b/drivers/gpu/drm/bridge/analogix/Kconfig
> index e930ff9..b2f127e 100644
> --- a/drivers/gpu/drm/bridge/analogix/Kconfig
> +++ b/drivers/gpu/drm/bridge/analogix/Kconfig
> @@ -2,3 +2,9 @@
>  config DRM_ANALOGIX_DP
>         tristate
>         depends on DRM
> +
> +config ANALOGIX_ANX7625
> +       tristate "Analogix MIPI to DP interface support"
> +       help
> +               ANX7625 is an ultra-low power 4K mobile HD transmitter designed
> +               for portable devices. It converts MIPI/DPI to DisplayPort1.3 4K.
> diff --git a/drivers/gpu/drm/bridge/analogix/Makefile b/drivers/gpu/drm/bridge/analogix/Makefile
> index fdbf3fd..8a52867 100644
> --- a/drivers/gpu/drm/bridge/analogix/Makefile
> +++ b/drivers/gpu/drm/bridge/analogix/Makefile
> @@ -1,3 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> +obj-$(CONFIG_ANALOGIX_ANX7625) += anx7625.o
>  analogix_dp-objs := analogix_dp_core.o analogix_dp_reg.o
>  obj-$(CONFIG_DRM_ANALOGIX_DP) += analogix_dp.o
> diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
> new file mode 100644
> index 0000000..fff7a49
> [snip]
> +static int anx7625_attach_dsi(struct anx7625_data *ctx)
> +{
> +       struct mipi_dsi_host *host;
> +       struct mipi_dsi_device *dsi;
> +       struct device_node *mipi_host_node;
> +       struct device *dev = &ctx->client->dev;
> +       const struct mipi_dsi_device_info info = {
> +               .type = "anx7625",
> +               .channel = 0,
> +               .node = NULL,
> +       };
> +
> +       DRM_DEV_DEBUG_DRIVER(dev, "attach dsi\n");
> +
> +       if (ctx->pdata.dsi_supported)
> +               mipi_host_node = ctx->pdata.node.mipi_dsi_host_node;
> +       else
> +               mipi_host_node = ctx->pdata.node.mipi_dpi_host_node;
> +
> +       if (!mipi_host_node) {
> +               DRM_ERROR("dsi host is not configured.\n");
> +               return -EINVAL;
> +       }
> +
> +       host = of_find_mipi_dsi_host_by_node(mipi_host_node);

I tried this driver when connected to a dpi interface, and this fails,
as of_find_mipi_dsi_host_by_node is not able to find the dpi interface
from the SoC.

I'm not too familiar with how dpi bridges are supposed to work in the
kernel, but should we even call "anx7625_attach_dsi" for DPI
interface?

> +       if (!host) {
> +               DRM_ERROR("failed to find dsi host.\n");
> +               return -EINVAL;
> +       }
> +
> +       dsi = mipi_dsi_device_register_full(host, &info);
> +       if (IS_ERR(dsi)) {
> +               DRM_ERROR("failed to create dsi device.\n");
> +               return -EINVAL;
> +       }
> +
> +       dsi->lanes = 4;
> +       dsi->format = MIPI_DSI_FMT_RGB888;
> +       dsi->mode_flags = MIPI_DSI_MODE_VIDEO   |
> +               MIPI_DSI_MODE_VIDEO_SYNC_PULSE  |
> +               MIPI_DSI_MODE_EOT_PACKET        |
> +               MIPI_DSI_MODE_VIDEO_HSE;
> +
> +       if (mipi_dsi_attach(dsi) < 0) {
> +               DRM_ERROR("failed to attach dsi to host.\n");
> +               mipi_dsi_device_unregister(dsi);
> +               return -EINVAL;
> +       }
> +
> +       ctx->dsi = dsi;
> +
> +       DRM_DEV_DEBUG_DRIVER(dev, "attach dsi succeeded.\n");
> +
> +       return 0;
> +}
> +
> [snip]
> +static int anx7625_bridge_attach(struct drm_bridge *bridge)
> +{
> +       struct anx7625_data *ctx = bridge_to_anx7625(bridge);
> +       int err;
> +       struct device *dev = &ctx->client->dev;
> +
> +       DRM_DEV_DEBUG_DRIVER(dev, "drm attach\n");
> +       if (!bridge->encoder) {
> +               DRM_ERROR("Parent encoder object not found");
> +               return -ENODEV;
> +       }
> +
> +       err = drm_connector_init(bridge->dev, &ctx->connector,
> +                                &anx7625_connector_funcs,
> +                                ctx->pdata.internal_panel ?
> +                                       DRM_MODE_CONNECTOR_eDP :
> +                                       DRM_MODE_CONNECTOR_DisplayPort);
> +       if (err) {
> +               DRM_ERROR("Failed to initialize connector: %d\n", err);
> +               return err;
> +       }
> +
> +       drm_connector_helper_add(&ctx->connector,
> +                                &anx7625_connector_helper_funcs);
> +
> +       err = drm_connector_register(&ctx->connector);
> +       if (err) {
> +               DRM_ERROR("Failed to register connector: %d\n", err);
> +               return err;
> +       }
> +
> +       ctx->connector.polled = DRM_CONNECTOR_POLL_HPD;
> +
> +       err = drm_connector_attach_encoder(&ctx->connector, bridge->encoder);
> +       if (err) {
> +               DRM_ERROR("Failed to link up connector to encoder: %d\n", err);
> +               drm_connector_unregister(&ctx->connector);
> +               return err;
> +       }
> +
> +       err = anx7625_attach_dsi(ctx);
> +       if (err) {
> +               DRM_ERROR("Failed to attach to dsi : %d\n", err);
> +               drm_connector_unregister(&ctx->connector);
> +               return err;
> +       }
> +
> +       ctx->bridge_attached = 1;
> +
> +       return 0;
> +}
> +
