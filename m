Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CFBDC52D58
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 18:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EFE72485D
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 18:03:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbgIDRFL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 13:05:11 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:60372 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725966AbgIDRFG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 13:05:06 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id B807BFB06;
        Fri,  4 Sep 2020 19:05:03 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id EC2SdMEKEx2S; Fri,  4 Sep 2020 19:05:01 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 8329345B81; Fri,  4 Sep 2020 19:05:01 +0200 (CEST)
Date:   Fri, 4 Sep 2020 19:05:01 +0200
From:   Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To:     "Robert Chiras (OSS)" <robert.chiras@oss.nxp.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Sam Ravnborg <sam@ravnborg.org>,
        Fabio Estevam <festevam@gmail.com>,
        Ondrej Jirman <megous@megous.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com
Subject: Re: [PATCH 5/5] drm/bridge: nwl-dsi: add support for DCSS
Message-ID: <20200904170501.GB755526@bogon.m.sigxcpu.org>
References: <1598613212-1113-1-git-send-email-robert.chiras@oss.nxp.com>
 <1598613212-1113-6-git-send-email-robert.chiras@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1598613212-1113-6-git-send-email-robert.chiras@oss.nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Fri, Aug 28, 2020 at 02:13:32PM +0300, Robert Chiras (OSS) wrote:
> From: Laurentiu Palcu <laurentiu.palcu@nxp.com>
> 
> DCSS needs active low VSYNC and HSYNC. Also, move the input selection in
> the probe function, as this will not change at runtime.
> 
> Signed-off-by: Laurentiu Palcu <laurentiu.palcu@nxp.com>
> Signed-off-by: Robert Chiras <robert.chiras@nxp.com>
> ---
>  drivers/gpu/drm/bridge/nwl-dsi.c | 24 ++++++++++++++++--------
>  1 file changed, 16 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/nwl-dsi.c b/drivers/gpu/drm/bridge/nwl-dsi.c
> index ac4aa0a..c30f7a8 100644
> --- a/drivers/gpu/drm/bridge/nwl-dsi.c
> +++ b/drivers/gpu/drm/bridge/nwl-dsi.c
> @@ -143,6 +143,7 @@ struct nwl_dsi {
>  	struct nwl_dsi_transfer *xfer;
>  	struct list_head valid_modes;
>  	u32 clk_drop_lvl;
> +	bool use_dcss;
>  };
>  
>  static const struct regmap_config nwl_dsi_regmap_config = {
> @@ -1036,16 +1037,16 @@ static int nwl_dsi_get_dphy_params(struct nwl_dsi *dsi,
>  
>  static bool nwl_dsi_bridge_mode_fixup(struct drm_bridge *bridge,
>  				      const struct drm_display_mode *mode,
> -				      struct drm_display_mode *adjusted_mode)
> +				      struct drm_display_mode *adjusted)

why the rename?

>  {
>  	struct nwl_dsi *dsi = bridge_to_dsi(bridge);
>  	struct mode_config *config;
>  	unsigned long pll_rate;
>  
>  	DRM_DEV_DEBUG_DRIVER(dsi->dev, "Fixup mode:\n");
> -	drm_mode_debug_printmodeline(adjusted_mode);
> +	drm_mode_debug_printmodeline(adjusted);
>  
> -	config = nwl_dsi_mode_probe(dsi, adjusted_mode);
> +	config = nwl_dsi_mode_probe(dsi, adjusted);
>  	if (!config)
>  		return false;
>  
> @@ -1067,12 +1068,16 @@ static bool nwl_dsi_bridge_mode_fixup(struct drm_bridge *bridge,
>  	}
>  	/* Update the crtc_clock to be used by display controller */
>  	if (config->crtc_clock)
> -		adjusted_mode->crtc_clock = config->crtc_clock / 1000;
> +		adjusted->crtc_clock = config->crtc_clock / 1000;
>  
> -
> -	/* At least LCDIF + NWL needs active high sync */
> -	adjusted_mode->flags |= (DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC);
> -	adjusted_mode->flags &= ~(DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC);
> +	if (!dsi->use_dcss) {
> +		/* At least LCDIF + NWL needs active high sync */
> +		adjusted->flags |= (DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC);
> +		adjusted->flags &= ~(DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC);
> +	} else {
> +		adjusted->flags &= ~(DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC);
> +		adjusted->flags |= (DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC);
> +	}
>  
>  	return true;
>  }
> @@ -1400,6 +1405,9 @@ static int nwl_dsi_select_input(struct nwl_dsi *dsi)
>  		DRM_DEV_ERROR(dsi->dev, "Failed to select input: %d\n", ret);
>  
>  	of_node_put(remote);
> +
> +	dsi->use_dcss = use_dcss;

If we need to preserve it we can assign `dsi->use_dcss` directly and
drop `use_dcss`.
Cheers,
 -- Guido

> +
>  	return ret;
>  }
>  
> -- 
> 2.7.4
> 
