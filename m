Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B5A6C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 19:57:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B8D32088E
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 19:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590695849;
	bh=WdjZb2iePlc27XuysorsJpBilXlRt3WRFcZxlXNQpY0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=e8VZ4hgHPjsvBi0RjXWEgGzb9wYlS/Qr594A4cqRBE8UjjlA4QFVxiuMb3/sZKpaV
	 5VyKfXR3pMpEycXKnHsPcEHt0gW9U6GXLNFM7l8zQwi9ip4acvKRIvCaWxROmQE1fk
	 d2DTvcHIRwXR67hAH7QH3t0Cg+6fYzS0TfjbD408=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406808AbgE1T5Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 15:57:25 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:41138 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406687AbgE1T5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 15:57:21 -0400
Received: by mail-io1-f67.google.com with SMTP id o5so31455633iow.8;
        Thu, 28 May 2020 12:57:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=C1yxG+5EPv3E4hC3r9qMne3qQ1WLqR3rVkfPRz5Lf7A=;
        b=KESz+RH2pOl6VIua9FOmCwgjXTqa/IlGXvkhr/5sIjnxjGZcajx8n/DdcRahir1pNZ
         QGWRHNy9T56tdSGNG9vqBBWa7f3YMi2Yv2wGwaF5L6wc26mvbACoDFpzU4CDYDCoYqx0
         6TeQaEPqSBV180LS97zQwM5e8rLihY3M49B25xR7geoWFLHleqYepOUDxDOw62vsxGzH
         uNqnLbNJ9p7Ca+5NuF1y+V0MisGajxt9gNYIJlOr0nKHZr4PvmigIuNr7bvGTvFHazQQ
         BiNOUN8i3vlq/6jWSI++U+FSkLMsUpfAM1QcFgbhjgQaRWAxLvbSEaeUljwG7uAjWGWp
         MvAw==
X-Gm-Message-State: AOAM531NRScDwHC6KOcBYPgIWDpiKv4pzpSYLo1oFi59pUYlbRL3xgPK
        qu2E/vj1NMw2ctDLj5fqjA==
X-Google-Smtp-Source: ABdhPJwSH+qxIcWv8h/fKAo6SOTAQdcOfw2m0OYWjSIpa6W5m47BsalTXqPIM9X9CbE4u2CeC3MeOw==
X-Received: by 2002:a02:95a6:: with SMTP id b35mr4047016jai.40.1590695839998;
        Thu, 28 May 2020 12:57:19 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id b18sm3627485ilh.77.2020.05.28.12.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 12:57:19 -0700 (PDT)
Received: (nullmailer pid 580805 invoked by uid 1000);
        Thu, 28 May 2020 19:57:17 -0000
Date:   Thu, 28 May 2020 13:57:17 -0600
From:   Rob Herring <robh@kernel.org>
To:     Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
Cc:     Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Shawn Guo <shawnguo@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Anson Huang <Anson.Huang@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Peng Fan <peng.fan@nxp.com>,
        Robert Chiras <robert.chiras@nxp.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH 4/6] drm/bridge/nwl-dsi: Drop mux handling
Message-ID: <20200528195717.GA568887@bogus>
References: <cover.1589548223.git.agx@sigxcpu.org>
 <951688795f969ebcbf9fb3c38065ccce6f488235.1589548223.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <951688795f969ebcbf9fb3c38065ccce6f488235.1589548223.git.agx@sigxcpu.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 15, 2020 at 03:12:13PM +0200, Guido Günther wrote:
> This will be handled via the mux-input-bridge.

You can't do this. What happens booting a kernel with this change and an 
un-modified dtb? You just broke it.

> 
> Signed-off-by: Guido Günther <agx@sigxcpu.org>
> ---
>  drivers/gpu/drm/bridge/Kconfig   |  1 -
>  drivers/gpu/drm/bridge/nwl-dsi.c | 61 --------------------------------
>  2 files changed, 62 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
> index 3886c0f41bdd..11444f841e35 100644
> --- a/drivers/gpu/drm/bridge/Kconfig
> +++ b/drivers/gpu/drm/bridge/Kconfig
> @@ -78,7 +78,6 @@ config DRM_NWL_MIPI_DSI
>  	select DRM_PANEL_BRIDGE
>  	select GENERIC_PHY_MIPI_DPHY
>  	select MFD_SYSCON
> -	select MULTIPLEXER
>  	select REGMAP_MMIO
>  	help
>  	  This enables the Northwest Logic MIPI DSI Host controller as
> diff --git a/drivers/gpu/drm/bridge/nwl-dsi.c b/drivers/gpu/drm/bridge/nwl-dsi.c
> index b14d725bf609..8839f333f39c 100644
> --- a/drivers/gpu/drm/bridge/nwl-dsi.c
> +++ b/drivers/gpu/drm/bridge/nwl-dsi.c
> @@ -12,7 +12,6 @@
>  #include <linux/math64.h>
>  #include <linux/mfd/syscon.h>
>  #include <linux/module.h>
> -#include <linux/mux/consumer.h>
>  #include <linux/of.h>
>  #include <linux/of_platform.h>
>  #include <linux/phy/phy.h>
> @@ -44,9 +43,6 @@ enum transfer_direction {
>  	DSI_PACKET_RECEIVE,
>  };
>  
> -#define NWL_DSI_ENDPOINT_LCDIF 0
> -#define NWL_DSI_ENDPOINT_DCSS 1
> -
>  struct nwl_dsi_plat_clk_config {
>  	const char *id;
>  	struct clk *clk;
> @@ -94,7 +90,6 @@ struct nwl_dsi {
>  	struct reset_control *rst_esc;
>  	struct reset_control *rst_dpi;
>  	struct reset_control *rst_pclk;
> -	struct mux_control *mux;
>  
>  	/* DSI clocks */
>  	struct clk *phy_ref_clk;
> @@ -1018,14 +1013,6 @@ static int nwl_dsi_parse_dt(struct nwl_dsi *dsi)
>  	}
>  	dsi->tx_esc_clk = clk;
>  
> -	dsi->mux = devm_mux_control_get(dsi->dev, NULL);
> -	if (IS_ERR(dsi->mux)) {
> -		ret = PTR_ERR(dsi->mux);
> -		if (ret != -EPROBE_DEFER)
> -			DRM_DEV_ERROR(dsi->dev, "Failed to get mux: %d\n", ret);
> -		return ret;
> -	}
> -
>  	base = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(base))
>  		return PTR_ERR(base);
> @@ -1073,47 +1060,6 @@ static int nwl_dsi_parse_dt(struct nwl_dsi *dsi)
>  	return 0;
>  }
>  
> -static int nwl_dsi_select_input(struct nwl_dsi *dsi)
> -{
> -	struct device_node *remote;
> -	u32 use_dcss = 1;
> -	int ret;
> -
> -	remote = of_graph_get_remote_node(dsi->dev->of_node, 0,
> -					  NWL_DSI_ENDPOINT_LCDIF);
> -	if (remote) {
> -		use_dcss = 0;
> -	} else {
> -		remote = of_graph_get_remote_node(dsi->dev->of_node, 0,
> -						  NWL_DSI_ENDPOINT_DCSS);
> -		if (!remote) {
> -			DRM_DEV_ERROR(dsi->dev,
> -				      "No valid input endpoint found\n");
> -			return -EINVAL;
> -		}
> -	}
> -
> -	DRM_DEV_INFO(dsi->dev, "Using %s as input source\n",
> -		     (use_dcss) ? "DCSS" : "LCDIF");
> -	ret = mux_control_try_select(dsi->mux, use_dcss);
> -	if (ret < 0)
> -		DRM_DEV_ERROR(dsi->dev, "Failed to select input: %d\n", ret);
> -
> -	of_node_put(remote);
> -	return ret;
> -}

You could however make these functions generic for any bridge to use. 
Define a function that checks for mux-control property and if found sets 
up the mux (IIRC, there's already a concept of a default state). That 
should be callable from somewhere generic too.

Rob
