Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D782C10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 07:49:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 276CD20675
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 07:49:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Jq7oN9z+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbgCIHtk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 03:49:40 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42892 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbgCIHtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 03:49:39 -0400
Received: by mail-ed1-f67.google.com with SMTP id n18so10866990edw.9
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 00:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tGvHVL+X8ENX8ZlFkJ4aTUiRtrm/fcY3/mfmmVzMIbM=;
        b=Jq7oN9z+T3yHMHlBWmtg/oPw3NMpUuf+HHE/AEB6ve19jbPtvt5AEZ3WDPvkS0xNRJ
         TxPi+1T+CforxzUbaOpceljyeEB1qThb+1+7Yv5FETpD/6MLNoUiLzGPTdjvfyt2N7yA
         204omxFy4IXZZH2/4KFT1X0Gv3NC+THh/SuOk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tGvHVL+X8ENX8ZlFkJ4aTUiRtrm/fcY3/mfmmVzMIbM=;
        b=AI/1f7GPf01fgZ5s2qFg/s2MTWSyqbZrf10N3od/UvOHJQPNdPCs2luYIAzyNG6QmM
         wmDt+R0umIGyO38YrUJHUvywGMVkBoABotO9SyUZVoSvPM1G2Kz4YI7kjN+r+wgHep2U
         gXykKgvQtALRuvYhX0jr9vJ76gYjqd0SOKDAZx0anGh8D2m9Yr8WiLqf72BfdyQBjtB1
         cWH4ymAXsVN1itEXj7eZLA5HCQ5aETJGbRbEz6gBZqs+dY/iX2SKSCNb6M7RM9jIebAs
         lSOhatAVGpjv1QEsfLhw1tzNMBu0IJAWcR8q7ngkJYwyaD7XY+S46ie3eu6zdAc3i79r
         zOxQ==
X-Gm-Message-State: ANhLgQ1QIFUbCWMYErGrylIwCp4JjOceu1rxtciNpAKJZFqC9+ZyBvQE
        R5cg0T9XDrQnKwYROXxWIE9okGCcWdbxWidsEj5XFg==
X-Google-Smtp-Source: ADFU+vunIbfF7cF+cg/5HQCVkQIHDO6ScLBXRU/yTPevJyjOidbI5t2wOJVf0V1aAGYL0Qe0suR5rmu4QLvHq6Gpl3U=
X-Received: by 2002:a17:907:2154:: with SMTP id rk20mr13348435ejb.322.1583740177890;
 Mon, 09 Mar 2020 00:49:37 -0700 (PDT)
MIME-Version: 1.0
References: <1583735298-19266-1-git-send-email-allen.chen@ite.com.tw> <1583735298-19266-4-git-send-email-allen.chen@ite.com.tw>
In-Reply-To: <1583735298-19266-4-git-send-email-allen.chen@ite.com.tw>
From:   Pi-Hsun Shih <pihsun@chromium.org>
Date:   Mon, 9 Mar 2020 15:49:01 +0800
Message-ID: <CANdKZ0cB-nWR75RcpAet+UDj6t+QXi1rjF3jMiM6_+awhZzAOg@mail.gmail.com>
Subject: Re: [PATCH v7 3/3] drm/bridge: add it6505 driver
To:     allen <allen.chen@ite.com.tw>
Cc:     Jau-Chih Tseng <Jau-Chih.Tseng@ite.com.tw>,
        Jitao Shi <jitao.shi@mediatek.com>,
        Yilun Lin <yllin@google.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi allen,

On Mon, Mar 9, 2020 at 2:32 PM allen <allen.chen@ite.com.tw> wrote:
>
> From: Allen Chen <allen.chen@ite.com.tw>
>
> This adds support for the iTE IT6505.
> This device can convert DPI signal to DP output.
>
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> Signed-off-by: Yilun Lin <yllin@google.com>
> Signed-off-by: Allen Chen <allen.chen@ite.com.tw>
> Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>
> ---
>  drivers/gpu/drm/bridge/Kconfig      |   11 +-
>  drivers/gpu/drm/bridge/Makefile     |    6 +-
>  drivers/gpu/drm/bridge/ite-it6505.c | 3022 +++++++++++++++++++++++++++++++++++
>  3 files changed, 3035 insertions(+), 4 deletions(-)
>  create mode 100644 drivers/gpu/drm/bridge/ite-it6505.c
>
> diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
> index aaed234..ff81681 100644
> --- a/drivers/gpu/drm/bridge/Kconfig
> +++ b/drivers/gpu/drm/bridge/Kconfig
> @@ -38,8 +38,15 @@ config DRM_DISPLAY_CONNECTOR
>           on ARM-based platforms. Saying Y here when this driver is not needed
>           will not cause any issue.
>
> -config DRM_LVDS_CODEC
> -       tristate "Transparent LVDS encoders and decoders support"
> +config DRM_ITE_IT6505
> +       tristate "ITE IT6505 DP bridge"
> +       depends on OF
> +       select DRM_KMS_HELPER
> +       help
> +         ITE IT6505 DP bridge chip driver.
> +
> +config DRM_LVDS_ENCODER
> +       tristate "Transparent parallel to LVDS encoder support"
>         depends on OF
>         select DRM_KMS_HELPER
>         select DRM_PANEL_BRIDGE
> diff --git a/drivers/gpu/drm/bridge/Makefile b/drivers/gpu/drm/bridge/Makefile
> index 6fb062b..e6c80ab 100644
> --- a/drivers/gpu/drm/bridge/Makefile
> +++ b/drivers/gpu/drm/bridge/Makefile
> @@ -1,7 +1,9 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-$(CONFIG_DRM_CDNS_DSI) += cdns-dsi.o
> -obj-$(CONFIG_DRM_DISPLAY_CONNECTOR) += display-connector.o
> -obj-$(CONFIG_DRM_LVDS_CODEC) += lvds-codec.o
> +obj-$(CONFIG_DRM_DUMB_VGA_DAC) += dumb-vga-dac.o
> +obj-$(CONFIG_DRM_GENERIC_GPIO_MUX) += generic-gpio-mux.o
> +obj-$(CONFIG_DRM_ITE_IT6505) += ite-it6505.o
> +obj-$(CONFIG_DRM_LVDS_ENCODER) += lvds-encoder.o
>  obj-$(CONFIG_DRM_MEGACHIPS_STDPXXXX_GE_B850V3_FW) += megachips-stdpxxxx-ge-b850v3-fw.o
>  obj-$(CONFIG_DRM_NXP_PTN3460) += nxp-ptn3460.o
>  obj-$(CONFIG_DRM_PARADE_PS8622) += parade-ps8622.o

There are unrelated changes to it6505 in the Makefile and Kconfig,
please remove them.
