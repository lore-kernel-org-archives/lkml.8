Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD21BC433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 16:02:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5A2B206C3
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 16:02:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731722AbgGAQCv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 12:02:51 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:34468 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728534AbgGAQCu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 12:02:50 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 811FCFB03;
        Wed,  1 Jul 2020 18:02:48 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id g4FYZ4R6qEuf; Wed,  1 Jul 2020 18:02:47 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 2F5EF40972; Wed,  1 Jul 2020 18:02:47 +0200 (CEST)
Date:   Wed, 1 Jul 2020 18:02:47 +0200
From:   Guido =?iso-8859-1?Q?G=FCnther?= <guido.gunther@puri.sm>
To:     Ondrej Jirman <megous@megous.com>
Cc:     linux-sunxi@googlegroups.com,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Purism Kernel Team <kernel@puri.sm>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Samuel Holland <samuel@sholland.org>,
        Martijn Braam <martijn@brixit.nl>, Luca Weiss <luca@z3ntu.xyz>,
        Bhushan Shah <bshah@kde.org>
Subject: Re: [PATCH v6 08/13] drm/panel: st7703: Move generic part of init
 sequence to enable callback
Message-ID: <20200701160247.GG174356@bogon.m.sigxcpu.org>
References: <20200701103126.1512615-1-megous@megous.com>
 <20200701103126.1512615-9-megous@megous.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200701103126.1512615-9-megous@megous.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Wed, Jul 01, 2020 at 12:31:21PM +0200, Ondrej Jirman wrote:
> Calling sleep out and display on is a controller specific part
> of the initialization process. Move it out of the panel specific
> initialization function to the enable callback.

Reviewed-by: Guido Günther <agx@sigxcpu.org> 

> 
> Signed-off-by: Ondrej Jirman <megous@megous.com>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/gpu/drm/panel/panel-sitronix-st7703.c | 33 ++++++++++---------
>  1 file changed, 18 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-sitronix-st7703.c b/drivers/gpu/drm/panel/panel-sitronix-st7703.c
> index d03aab10cfef..cdbf7dfb4dd4 100644
> --- a/drivers/gpu/drm/panel/panel-sitronix-st7703.c
> +++ b/drivers/gpu/drm/panel/panel-sitronix-st7703.c
> @@ -84,8 +84,6 @@ static inline struct st7703 *panel_to_st7703(struct drm_panel *panel)
>  static int jh057n_init_sequence(struct st7703 *ctx)
>  {
>  	struct mipi_dsi_device *dsi = to_mipi_dsi_device(ctx->dev);
> -	struct device *dev = ctx->dev;
> -	int ret;
>  
>  	/*
>  	 * Init sequence was supplied by the panel vendor. Most of the commands
> @@ -136,20 +134,7 @@ static int jh057n_init_sequence(struct st7703 *ctx)
>  			      0x18, 0x00, 0x09, 0x0E, 0x29, 0x2D, 0x3C, 0x41,
>  			      0x37, 0x07, 0x0B, 0x0D, 0x10, 0x11, 0x0F, 0x10,
>  			      0x11, 0x18);
> -	msleep(20);
> -
> -	ret = mipi_dsi_dcs_exit_sleep_mode(dsi);
> -	if (ret < 0) {
> -		DRM_DEV_ERROR(dev, "Failed to exit sleep mode: %d\n", ret);
> -		return ret;
> -	}
> -	/* Panel is operational 120 msec after reset */
> -	msleep(60);
> -	ret = mipi_dsi_dcs_set_display_on(dsi);
> -	if (ret)
> -		return ret;
>  
> -	DRM_DEV_DEBUG_DRIVER(dev, "Panel init sequence done\n");
>  	return 0;
>  }
>  
> @@ -181,6 +166,7 @@ struct st7703_panel_desc jh057n00900_panel_desc = {
>  static int st7703_enable(struct drm_panel *panel)
>  {
>  	struct st7703 *ctx = panel_to_st7703(panel);
> +	struct mipi_dsi_device *dsi = to_mipi_dsi_device(ctx->dev);
>  	int ret;
>  
>  	ret = ctx->desc->init_sequence(ctx);
> @@ -190,6 +176,23 @@ static int st7703_enable(struct drm_panel *panel)
>  		return ret;
>  	}
>  
> +	msleep(20);
> +
> +	ret = mipi_dsi_dcs_exit_sleep_mode(dsi);
> +	if (ret < 0) {
> +		DRM_DEV_ERROR(ctx->dev, "Failed to exit sleep mode: %d\n", ret);
> +		return ret;
> +	}
> +
> +	/* Panel is operational 120 msec after reset */
> +	msleep(60);
> +
> +	ret = mipi_dsi_dcs_set_display_on(dsi);
> +	if (ret)
> +		return ret;
> +
> +	DRM_DEV_DEBUG_DRIVER(ctx->dev, "Panel init sequence done\n");
> +
>  	return 0;
>  }
>  
> -- 
> 2.27.0
> 
