Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C310C43332
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 09:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D47220663
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 09:39:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbgCSJjF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 05:39:05 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:59276 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725887AbgCSJjE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 05:39:04 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 5D042FB03;
        Thu, 19 Mar 2020 10:39:01 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 1Xzj51gxscCV; Thu, 19 Mar 2020 10:38:59 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 3A2A8412BE; Thu, 19 Mar 2020 10:38:59 +0100 (CET)
Date:   Thu, 19 Mar 2020 10:38:59 +0100
From:   Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Lee Jones <lee.jones@linaro.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Robert Chiras <robert.chiras@nxp.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v9 2/2] drm/bridge: Add NWL MIPI DSI host controller
 support
Message-ID: <20200319093859.GA50655@bogon.m.sigxcpu.org>
References: <cover.1584544065.git.agx@sigxcpu.org>
 <6f2e65df672a0fe832af29f4ea89fbe7250c3a07.1584544065.git.agx@sigxcpu.org>
 <20200318214639.GA971@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200318214639.GA971@ravnborg.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sam,

On Wed, Mar 18, 2020 at 10:46:39PM +0100, Sam Ravnborg wrote:
> Hi Guido.
> 
> Impressive and very detailed changelog in intro mail - nice.
> 
> On Wed, Mar 18, 2020 at 04:09:08PM +0100, Guido Günther wrote:
> > This adds initial support for the NWL MIPI DSI Host controller found on
> > i.MX8 SoCs.
> > 
> > It adds support for the i.MX8MQ but the same IP can be found on
> > e.g. the i.MX8QXP.
> > 
> > It has been tested on the Librem 5 devkit using mxsfb.
> > 
> > Signed-off-by: Guido Günther <agx@sigxcpu.org>
> > Co-developed-by: Robert Chiras <robert.chiras@nxp.com>
> > Signed-off-by: Robert Chiras <robert.chiras@nxp.com>
> > Tested-by: Robert Chiras <robert.chiras@nxp.com>
> > Tested-by: Martin Kepplinger <martin.kepplinger@puri.sm>
> > ---
> >  drivers/gpu/drm/bridge/Kconfig   |   16 +
> >  drivers/gpu/drm/bridge/Makefile  |    3 +
> >  drivers/gpu/drm/bridge/nwl-dsi.c | 1213 ++++++++++++++++++++++++++++++
> >  drivers/gpu/drm/bridge/nwl-dsi.h |  144 ++++
> >  4 files changed, 1376 insertions(+)
> >  create mode 100644 drivers/gpu/drm/bridge/nwl-dsi.c
> >  create mode 100644 drivers/gpu/drm/bridge/nwl-dsi.h
> > 
> > diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
> > index 8397bf72d2f3..d41d93d24f16 100644
> > --- a/drivers/gpu/drm/bridge/Kconfig
> > +++ b/drivers/gpu/drm/bridge/Kconfig
> > @@ -55,6 +55,22 @@ config DRM_MEGACHIPS_STDPXXXX_GE_B850V3_FW
> >  	  to DP++. This is used with the i.MX6 imx-ldb
> >  	  driver. You are likely to say N here.
> >  
> > +config DRM_NWL_MIPI_DSI
> > +	tristate "Northwest Logic MIPI DSI Host controller"
> > +	depends on DRM
> > +	depends on COMMON_CLK
> > +	depends on OF && HAS_IOMEM
> > +	select DRM_KMS_HELPER
> > +	select DRM_MIPI_DSI
> > +	select DRM_PANEL_BRIDGE
> > +	select GENERIC_PHY_MIPI_DPHY
> > +	select MFD_SYSCON
> > +	select MULTIPLEXER
> > +	select REGMAP_MMIO
> > +	help
> > +	  This enables the Northwest Logic MIPI DSI Host controller as
> > +	  for example found on NXP's i.MX8 Processors.
> > +
> >  config DRM_NXP_PTN3460
> >  	tristate "NXP PTN3460 DP/LVDS bridge"
> >  	depends on OF
> > diff --git a/drivers/gpu/drm/bridge/Makefile b/drivers/gpu/drm/bridge/Makefile
> > index 1eb5376c5d68..98581b3128a3 100644
> > --- a/drivers/gpu/drm/bridge/Makefile
> > +++ b/drivers/gpu/drm/bridge/Makefile
> > @@ -15,6 +15,9 @@ obj-$(CONFIG_DRM_TOSHIBA_TC358767) += tc358767.o
> >  obj-$(CONFIG_DRM_I2C_ADV7511) += adv7511/
> >  obj-$(CONFIG_DRM_TI_SN65DSI86) += ti-sn65dsi86.o
> >  obj-$(CONFIG_DRM_TI_TFP410) += ti-tfp410.o
> > +obj-$(CONFIG_DRM_NWL_MIPI_DSI) += nwl-dsi.o
> >  
> >  obj-y += analogix/
> >  obj-y += synopsys/
> > +
> > +header-test-y += nwl-dsi.h
> Sorry - but header-test-y support was ripped out of the kernel again.
> So this line has no longer any effect.

Missed that removal, dropped.

> > +
> > +static void nwl_dsi_bridge_enable(struct drm_bridge *bridge)
> > +{
> > +	struct nwl_dsi *dsi = bridge_to_dsi(bridge);
> > +	int ret;
> > +
> > +	/* Step 5 from DSI reset-out instructions */
> > +	ret = reset_control_deassert(dsi->rst_dpi);
> > +	if (ret < 0)
> > +		DRM_DEV_ERROR(dsi->dev, "Failed to deassert DPI: %d\n", ret);
> I picked this for a general comment.
> 
>     We have drm_err(drm, "...", ...) which is preferred over DRM_XXX
>     They require a drm_device * that may not be available everywhere.
> 
> IMO not a showstopper, but should be trivial to fix (if adrm_device * is
> a avaiable).

We don't do a drm_dev_alloc so no drm device here afaik tell.

> 
> > +}
> > +
> > +static int nwl_dsi_bridge_attach(struct drm_bridge *bridge)
> > +{
> > +	struct nwl_dsi *dsi = bridge_to_dsi(bridge);
> > +	struct drm_bridge *panel_bridge;
> > +	struct drm_panel *panel;
> > +	int ret;
> 
> This function now takes a flags argument.
> In other words - the driver will not build when applied
> to drm-misc-next.

Fixed by rebasing on next-20200317. I'll send a new version after
letting this sit for a moment. It'd be so cool to get this queued up so
we get a working display stack on the imx8mq.

Cheers,
 -- Guido

> 
> > +
> > +	ret = drm_of_find_panel_or_bridge(dsi->dev->of_node, 1, 0, &panel,
> > +					  &panel_bridge);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (panel) {
> > +		panel_bridge = drm_panel_bridge_add(panel);
> > +		if (IS_ERR(panel_bridge))
> > +			return PTR_ERR(panel_bridge);
> > +	}
> > +	dsi->panel_bridge = panel_bridge;
> > +
> > +	if (!dsi->panel_bridge)
> > +		return -EPROBE_DEFER;
> > +
> > +	return drm_bridge_attach(bridge->encoder, dsi->panel_bridge, bridge);
> > +}
> 
> 	Sam
> 
