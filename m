Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E21E7C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 12:43:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C715F20717
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 12:43:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729833AbgGUMnl convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 08:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726904AbgGUMnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 08:43:40 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6563FC061794
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 05:43:40 -0700 (PDT)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1jxrcL-0006Dx-Re; Tue, 21 Jul 2020 14:43:33 +0200
Received: from pza by lupine with local (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1jxrcG-0005Rp-VR; Tue, 21 Jul 2020 14:43:28 +0200
Message-ID: <58a3ebe2620008daeab826a8216b6b5ad672fc7c.camel@pengutronix.de>
Subject: Re: [PATCH v7 2/5] drm/imx: Add initial support for DCSS on iMX8MQ
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>
Cc:     lukas@mntmn.com, agx@sigxcpu.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Date:   Tue, 21 Jul 2020 14:43:28 +0200
In-Reply-To: <20200721102007.18368-3-laurentiu.palcu@oss.nxp.com>
References: <20200721102007.18368-1-laurentiu.palcu@oss.nxp.com>
         <20200721102007.18368-3-laurentiu.palcu@oss.nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurentiu,

On Tue, 2020-07-21 at 13:20 +0300, Laurentiu Palcu wrote:
> From: Laurentiu Palcu <laurentiu.palcu@nxp.com>
> 
> This adds initial support for iMX8MQ's Display Controller Subsystem (DCSS).
> Some of its capabilities include:
>  * 4K@60fps;
>  * HDR10;
>  * one graphics and 2 video pipelines;
>  * on-the-fly decompression of compressed video and graphics;
> 
> The reference manual can be found here:
> https://www.nxp.com/webapp/Download?colCode=IMX8MDQLQRM
> 
> The current patch adds only basic functionality: one primary plane for
> graphics, linear, tiled and super-tiled buffers support (no graphics
> decompression yet), no HDR10 and no video planes.
> 
> Video planes support and HDR10 will be added in subsequent patches once
> per-plane de-gamma/CSC/gamma support is in.
> 
> Signed-off-by: Laurentiu Palcu <laurentiu.palcu@nxp.com>
> Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
> ---
>  drivers/gpu/drm/imx/Kconfig            |   2 +
>  drivers/gpu/drm/imx/Makefile           |   1 +
>  drivers/gpu/drm/imx/dcss/Kconfig       |   9 +
>  drivers/gpu/drm/imx/dcss/Makefile      |   6 +
>  drivers/gpu/drm/imx/dcss/dcss-blkctl.c |  70 +++
>  drivers/gpu/drm/imx/dcss/dcss-crtc.c   | 219 +++++++
>  drivers/gpu/drm/imx/dcss/dcss-ctxld.c  | 424 +++++++++++++
>  drivers/gpu/drm/imx/dcss/dcss-dev.c    | 314 ++++++++++
>  drivers/gpu/drm/imx/dcss/dcss-dev.h    | 177 ++++++
>  drivers/gpu/drm/imx/dcss/dcss-dpr.c    | 562 +++++++++++++++++
>  drivers/gpu/drm/imx/dcss/dcss-drv.c    | 138 +++++
>  drivers/gpu/drm/imx/dcss/dcss-dtg.c    | 409 ++++++++++++
>  drivers/gpu/drm/imx/dcss/dcss-kms.c    | 177 ++++++
>  drivers/gpu/drm/imx/dcss/dcss-kms.h    |  43 ++
>  drivers/gpu/drm/imx/dcss/dcss-plane.c  | 405 ++++++++++++
>  drivers/gpu/drm/imx/dcss/dcss-scaler.c | 826 +++++++++++++++++++++++++
>  drivers/gpu/drm/imx/dcss/dcss-ss.c     | 180 ++++++
>  17 files changed, 3962 insertions(+)
>  create mode 100644 drivers/gpu/drm/imx/dcss/Kconfig
>  create mode 100644 drivers/gpu/drm/imx/dcss/Makefile
>  create mode 100644 drivers/gpu/drm/imx/dcss/dcss-blkctl.c
>  create mode 100644 drivers/gpu/drm/imx/dcss/dcss-crtc.c
>  create mode 100644 drivers/gpu/drm/imx/dcss/dcss-ctxld.c
>  create mode 100644 drivers/gpu/drm/imx/dcss/dcss-dev.c
>  create mode 100644 drivers/gpu/drm/imx/dcss/dcss-dev.h
>  create mode 100644 drivers/gpu/drm/imx/dcss/dcss-dpr.c
>  create mode 100644 drivers/gpu/drm/imx/dcss/dcss-drv.c
>  create mode 100644 drivers/gpu/drm/imx/dcss/dcss-dtg.c
>  create mode 100644 drivers/gpu/drm/imx/dcss/dcss-kms.c
>  create mode 100644 drivers/gpu/drm/imx/dcss/dcss-kms.h
>  create mode 100644 drivers/gpu/drm/imx/dcss/dcss-plane.c
>  create mode 100644 drivers/gpu/drm/imx/dcss/dcss-scaler.c
>  create mode 100644 drivers/gpu/drm/imx/dcss/dcss-ss.c
> 
> diff --git a/drivers/gpu/drm/imx/Kconfig b/drivers/gpu/drm/imx/Kconfig
> index 207bf7409dfb..6231048aa5aa 100644
> --- a/drivers/gpu/drm/imx/Kconfig
> +++ b/drivers/gpu/drm/imx/Kconfig
> @@ -39,3 +39,5 @@ config DRM_IMX_HDMI
>  	depends on DRM_IMX
>  	help
>  	  Choose this if you want to use HDMI on i.MX6.
> +
> +source "drivers/gpu/drm/imx/dcss/Kconfig"
> diff --git a/drivers/gpu/drm/imx/Makefile b/drivers/gpu/drm/imx/Makefile
> index 21cdcc2faabc..b644deffe948 100644
> --- a/drivers/gpu/drm/imx/Makefile
> +++ b/drivers/gpu/drm/imx/Makefile
> @@ -9,3 +9,4 @@ obj-$(CONFIG_DRM_IMX_TVE) += imx-tve.o
>  obj-$(CONFIG_DRM_IMX_LDB) += imx-ldb.o
>  
>  obj-$(CONFIG_DRM_IMX_HDMI) += dw_hdmi-imx.o
> +obj-$(CONFIG_DRM_IMX_DCSS) += dcss/
> diff --git a/drivers/gpu/drm/imx/dcss/Kconfig b/drivers/gpu/drm/imx/dcss/Kconfig
> new file mode 100644
> index 000000000000..988979bc22cc
> --- /dev/null
> +++ b/drivers/gpu/drm/imx/dcss/Kconfig
> @@ -0,0 +1,9 @@
> +config DRM_IMX_DCSS
> +	tristate "i.MX8MQ DCSS"
> +	select RESET_CONTROLLER

Why does DCSS select RESET_CONTROLLER?

regards
Philipp
