Return-Path: <SRS0=pQss=CP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CF86C433E2
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 10:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 677FB20C09
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 10:28:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728445AbgIFK2c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Sep 2020 06:28:32 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:44016 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725788AbgIFK20 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Sep 2020 06:28:26 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 42110FB03;
        Sun,  6 Sep 2020 12:28:22 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 6es4sdGsHemK; Sun,  6 Sep 2020 12:28:20 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 2FBF445B81; Sun,  6 Sep 2020 12:28:20 +0200 (CEST)
Date:   Sun, 6 Sep 2020 12:28:20 +0200
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
Subject: Re: [PATCH 3/5] drm/bridge: nwl-dsi: Add support for clock-drop-level
Message-ID: <20200906102820.GA3472@bogon.m.sigxcpu.org>
References: <1598613212-1113-1-git-send-email-robert.chiras@oss.nxp.com>
 <1598613212-1113-4-git-send-email-robert.chiras@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1598613212-1113-4-git-send-email-robert.chiras@oss.nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robert,
On Fri, Aug 28, 2020 at 02:13:30PM +0300, Robert Chiras (OSS) wrote:
> From: Robert Chiras <robert.chiras@nxp.com>
> 
> The clock-drop-level is needed in order to add more blanking space needed
> by DSI panels when sending DSI commands. One level is the equivalent of
> phy_ref rate from the PLL rate. Since the PLL rate is targeted as highest
> possible, each level should not get the crtc_clock too low, compared to
> the actual clock.

Did you check whether this is only needed during panel prepare (when the
image sequence is being sent)? I wonder if this is an artifact of the
driver sending pixel data too early - and if it's not whether we have
something else wrong so that we need to have a longer blanking period
with some panels?

Cheers,
 -- Guido

> 
> Example for a clock of 132M, with "clock-drop-level = <1>" in dts file
> will result in a crtc_clock of 129M, using the following logic:
> - video_pll rate to provide both phy_ref rate of 24M and pixel-clock
>   of 132M is 1056M (divisor /43 for phy_ref and /8 for pixel-clock)
> - from this rate, we subtract the equivalent of phy_ref (24M) but
>   keep the same divisor. This way, the video_pll rate will be 1056 - 24
> = 1032M.
> - new pixel-clock will be: 1032 / 8 = 129M
> 
> For a "clock-drop-level = <2>", new pixel-clock will be:
> (1056 - (24 * 2)) / 8 = 1008 / 8 = 126M
> 
> Signed-off-by: Robert Chiras <robert.chiras@nxp.com>
> ---
>  drivers/gpu/drm/bridge/nwl-dsi.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/nwl-dsi.c b/drivers/gpu/drm/bridge/nwl-dsi.c
> index 1228466..ac4aa0a 100644
> --- a/drivers/gpu/drm/bridge/nwl-dsi.c
> +++ b/drivers/gpu/drm/bridge/nwl-dsi.c
> @@ -142,6 +142,7 @@ struct nwl_dsi {
>  
>  	struct nwl_dsi_transfer *xfer;
>  	struct list_head valid_modes;
> +	u32 clk_drop_lvl;
>  };
>  
>  static const struct regmap_config nwl_dsi_regmap_config = {
> @@ -842,13 +843,14 @@ static unsigned long nwl_dsi_get_lcm(unsigned long a, unsigned long b)
>  
>  	return ((unsigned long long)a * b) / gcf;
>  }
> -
>  /*
>   * This function tries to adjust the crtc_clock for a DSI device in such a way
>   * that the video pll will be able to satisfy both Display Controller pixel
>   * clock (feeding out DPI interface) and our input phy_ref clock.
> + * Also, the DC pixel clock must be lower than the actual clock in order to
> + * have enough blanking space to send DSI commands, if the device is a panel.
>   */
> -static void nwl_dsi_setup_pll_config(struct mode_config *config)
> +static void nwl_dsi_setup_pll_config(struct mode_config *config, u32 lvl)
>  {
>  	unsigned long pll_rate;
>  	int div;
> @@ -908,7 +910,6 @@ static void nwl_dsi_setup_pll_config(struct mode_config *config)
>  	}
>  }
>  
> -
>  /*
>   * This function will try the required phy speed for current mode
>   * If the phy speed can be achieved, the phy will save the speed
> @@ -1103,7 +1104,7 @@ nwl_dsi_bridge_mode_valid(struct drm_bridge *bridge,
>  
>  	pll_rate = config->pll_rates[config->phy_rate_idx];
>  	if (dsi->pll_clk && !pll_rate)
> -		nwl_dsi_setup_pll_config(config);
> +		nwl_dsi_setup_pll_config(config, dsi->clk_drop_lvl);
>  
>  	return MODE_OK;
>  }
> @@ -1248,6 +1249,7 @@ static const struct drm_bridge_funcs nwl_dsi_bridge_funcs = {
>  static int nwl_dsi_parse_dt(struct nwl_dsi *dsi)
>  {
>  	struct platform_device *pdev = to_platform_device(dsi->dev);
> +	struct device_node *np = dsi->dev->of_node;
>  	struct clk *clk;
>  	void __iomem *base;
>  	int ret;
> @@ -1364,6 +1366,8 @@ static int nwl_dsi_parse_dt(struct nwl_dsi *dsi)
>  		return PTR_ERR(dsi->rst_dpi);
>  	}
>  
> +	of_property_read_u32(np, "fsl,clock-drop-level", &dsi->clk_drop_lvl);
> +
>  	INIT_LIST_HEAD(&dsi->valid_modes);
>  
>  	return 0;
> -- 
> 2.7.4
> 
