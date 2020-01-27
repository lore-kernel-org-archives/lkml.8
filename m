Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1937DC3F68F
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 11:59:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D92CF20716
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 11:59:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Koj0B4JT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730223AbgA0L7E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 06:59:04 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:54392 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728981AbgA0L7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 06:59:03 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 00RBwiRo123300;
        Mon, 27 Jan 2020 05:58:44 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1580126324;
        bh=1ThGnVGaiS9FqKbQRBbN7fWA13r28BPDHjVEcw0Z3u4=;
        h=Subject:From:To:CC:References:Date:In-Reply-To;
        b=Koj0B4JTVblvPK6h3noaSsmrJKSnatoASovXFWGWzR3hzVQx77d7uOkjmjurja4r5
         jphtj3vP42Ahxb5X33yHZ0ZbslbrxqFSw58HCmT7TcsK7fp70v8bt7K/dzUi/APQuH
         8KaXStaCo6+MmNqZ9pmJmIM2Ii/FwDSyJf4A4/n0=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 00RBwiLq101922
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 27 Jan 2020 05:58:44 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 27
 Jan 2020 05:58:44 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 27 Jan 2020 05:58:44 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 00RBwfvq056961;
        Mon, 27 Jan 2020 05:58:41 -0600
Subject: Re: [PATCH v3 2/2] drm/bridge: Add tc358768 driver
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <airlied@linux.ie>, <daniel@ffwll.ch>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <a.hajda@samsung.com>,
        <narmstrong@baylibre.com>
CC:     <tomi.valkeinen@ti.com>, <dri-devel@lists.freedesktop.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Laurent.pinchart@ideasonboard.com>, <jonas@kwiboo.se>,
        <jernej.skrabec@siol.net>
References: <20200127105634.7638-1-peter.ujfalusi@ti.com>
 <20200127105634.7638-3-peter.ujfalusi@ti.com>
Message-ID: <27c29a4e-4207-d07b-ec25-902596f9d7b6@ti.com>
Date:   Mon, 27 Jan 2020 13:59:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200127105634.7638-3-peter.ujfalusi@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27/01/2020 12.56, Peter Ujfalusi wrote:
> Add basic support for the Toshiba TC358768 RGB to DSI bridge.
> Not all the features of the TC358768 is implemented by the initial driver:
> MIPI_DSI_MODE_VIDEO and MIPI_DSI_FMT_RGB888 is only supported and tested.
> 
> Only write is implemented for mipi_dsi_host_ops.transfer.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  drivers/gpu/drm/bridge/Kconfig    |   10 +
>  drivers/gpu/drm/bridge/Makefile   |    1 +
>  drivers/gpu/drm/bridge/tc358768.c | 1040 +++++++++++++++++++++++++++++
>  3 files changed, 1051 insertions(+)
>  create mode 100644 drivers/gpu/drm/bridge/tc358768.c
> 
> diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
> index 0b9ca5862455..3fef3513bdd0 100644
> --- a/drivers/gpu/drm/bridge/Kconfig
> +++ b/drivers/gpu/drm/bridge/Kconfig
> @@ -122,6 +122,16 @@ config DRM_TOSHIBA_TC358767
>  	---help---
>  	  Toshiba TC358767 eDP bridge chip driver.
>  
> +config DRM_TOSHIBA_TC358768
> +	tristate "Toshiba TC358768 MIPI DSI bridge"
> +	depends on OF
> +	select DRM_KMS_HELPER
> +	select REGMAP_I2C
> +	select DRM_PANEL
> +	select DRM_MIPI_DSI
> +	help
> +	  Toshiba TC358768AXBG/TC358778XBG DSI bridge chip driver.
> +
>  config DRM_TI_TFP410
>  	tristate "TI TFP410 DVI/HDMI bridge"
>  	depends on OF
> diff --git a/drivers/gpu/drm/bridge/Makefile b/drivers/gpu/drm/bridge/Makefile
> index cd16ce830270..06fc265de0ef 100644
> --- a/drivers/gpu/drm/bridge/Makefile
> +++ b/drivers/gpu/drm/bridge/Makefile
> @@ -11,6 +11,7 @@ obj-$(CONFIG_DRM_SII9234) += sii9234.o
>  obj-$(CONFIG_DRM_THINE_THC63LVD1024) += thc63lvd1024.o
>  obj-$(CONFIG_DRM_TOSHIBA_TC358764) += tc358764.o
>  obj-$(CONFIG_DRM_TOSHIBA_TC358767) += tc358767.o
> +obj-$(CONFIG_DRM_TOSHIBA_TC358768) += tc358768.o
>  obj-$(CONFIG_DRM_I2C_ADV7511) += adv7511/
>  obj-$(CONFIG_DRM_TI_SN65DSI86) += ti-sn65dsi86.o
>  obj-$(CONFIG_DRM_TI_TFP410) += ti-tfp410.o
> diff --git a/drivers/gpu/drm/bridge/tc358768.c b/drivers/gpu/drm/bridge/tc358768.c
> new file mode 100644
> index 000000000000..244309c1112e
> --- /dev/null
> +++ b/drivers/gpu/drm/bridge/tc358768.c
> @@ -0,0 +1,1040 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + *  Copyright (C) 2020 Texas Instruments Incorporated - http://www.ti.com
> + *  Author: Peter Ujfalusi <peter.ujfalusi@ti.com>
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/device.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/i2c.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/slab.h>
> +
> +#include <drm/drm_atomic_helper.h>
> +#include <drm/drm_crtc_helper.h>
> +#include <drm/drm_drv.h>
> +#include <drm/drm_mipi_dsi.h>
> +#include <drm/drm_of.h>
> +#include <drm/drm_panel.h>
> +#include <video/mipi_display.h>
> +#include <video/videomode.h>
> +
> +/* Global (16-bit addressable) */
> +#define TC358768_CHIPID			0x0000
> +#define TC358768_SYSCTL			0x0002
> +#define TC358768_CONFCTL		0x0004
> +#define TC358768_VSDLY			0x0006
> +#define TC358768_DATAFMT		0x0008
> +#define TC358768_GPIOEN			0x000E
> +#define TC358768_GPIODIR		0x0010
> +#define TC358768_GPIOIN			0x0012
> +#define TC358768_GPIOOUT		0x0014
> +#define TC358768_PLLCTL0		0x0016
> +#define TC358768_PLLCTL1		0x0018
> +#define TC358768_CMDBYTE		0x0022
> +#define TC358768_PP_MISC		0x0032
> +#define TC358768_DSITX_DT		0x0050
> +#define TC358768_FIFOSTATUS		0x00F8
> +
> +/* Debug (16-bit addressable) */
> +#define TC358768_VBUFCTRL		0x00E0
> +#define TC358768_DBG_WIDTH		0x00E2
> +#define TC358768_DBG_VBLANK		0x00E4
> +#define TC358768_DBG_DATA		0x00E8
> +
> +/* TX PHY (32-bit addressable) */
> +#define TC358768_CLW_DPHYCONTTX		0x0100
> +#define TC358768_D0W_DPHYCONTTX		0x0104
> +#define TC358768_D1W_DPHYCONTTX		0x0108
> +#define TC358768_D2W_DPHYCONTTX		0x010C
> +#define TC358768_D3W_DPHYCONTTX		0x0110
> +#define TC358768_CLW_CNTRL		0x0140
> +#define TC358768_D0W_CNTRL		0x0144
> +#define TC358768_D1W_CNTRL		0x0148
> +#define TC358768_D2W_CNTRL		0x014C
> +#define TC358768_D3W_CNTRL		0x0150
> +
> +/* TX PPI (32-bit addressable) */
> +#define TC358768_STARTCNTRL		0x0204
> +#define TC358768_DSITXSTATUS		0x0208
> +#define TC358768_LINEINITCNT		0x0210
> +#define TC358768_LPTXTIMECNT		0x0214
> +#define TC358768_TCLK_HEADERCNT		0x0218
> +#define TC358768_TCLK_TRAILCNT		0x021C
> +#define TC358768_THS_HEADERCNT		0x0220
> +#define TC358768_TWAKEUP		0x0224
> +#define TC358768_TCLK_POSTCNT		0x0228
> +#define TC358768_THS_TRAILCNT		0x022C
> +#define TC358768_HSTXVREGCNT		0x0230
> +#define TC358768_HSTXVREGEN		0x0234
> +#define TC358768_TXOPTIONCNTRL		0x0238
> +#define TC358768_BTACNTRL1		0x023C
> +
> +/* TX CTRL (32-bit addressable) */
> +#define TC358768_DSI_CONTROL		0x040C
> +#define TC358768_DSI_STATUS		0x0410
> +#define TC358768_DSI_INT		0x0414
> +#define TC358768_DSI_INT_ENA		0x0418
> +#define TC358768_DSICMD_RDFIFO		0x0430
> +#define TC358768_DSI_ACKERR		0x0434
> +#define TC358768_DSI_ACKERR_INTENA	0x0438
> +#define TC358768_DSI_ACKERR_HALT	0x043c
> +#define TC358768_DSI_RXERR		0x0440
> +#define TC358768_DSI_RXERR_INTENA	0x0444
> +#define TC358768_DSI_RXERR_HALT		0x0448
> +#define TC358768_DSI_ERR		0x044C
> +#define TC358768_DSI_ERR_INTENA		0x0450
> +#define TC358768_DSI_ERR_HALT		0x0454
> +#define TC358768_DSI_CONFW		0x0500
> +#define TC358768_DSI_LPCMD		0x0500
> +#define TC358768_DSI_RESET		0x0504
> +#define TC358768_DSI_INT_CLR		0x050C
> +#define TC358768_DSI_START		0x0518
> +
> +/* DSITX CTRL (16-bit addressable) */
> +#define TC358768_DSICMD_TX		0x0600
> +#define TC358768_DSICMD_TYPE		0x0602
> +#define TC358768_DSICMD_WC		0x0604
> +#define TC358768_DSICMD_WD0		0x0610
> +#define TC358768_DSICMD_WD1		0x0612
> +#define TC358768_DSICMD_WD2		0x0614
> +#define TC358768_DSICMD_WD3		0x0616
> +#define TC358768_DSI_EVENT		0x0620
> +#define TC358768_DSI_VSW		0x0622
> +#define TC358768_DSI_VBPR		0x0624
> +#define TC358768_DSI_VACT		0x0626
> +#define TC358768_DSI_HSW		0x0628
> +#define TC358768_DSI_HBPR		0x062A
> +#define TC358768_DSI_HACT		0x062C
> +
> +/* TC358768_DSI_CONTROL (0x040C) register */
> +#define TC358768_DSI_CONTROL_DIS_MODE	BIT(15)
> +#define TC358768_DSI_CONTROL_TXMD	BIT(7)
> +#define TC358768_DSI_CONTROL_HSCKMD	BIT(5)
> +#define TC358768_DSI_CONTROL_EOTDIS	BIT(0)
> +
> +/* TC358768_DSI_CONFW (0x0500) register */
> +#define TC358768_DSI_CONFW_MODE_SET	(5 << 29)
> +#define TC358768_DSI_CONFW_MODE_CLR	(6 << 29)
> +#define TC358768_DSI_CONFW_ADDR_DSI_CONTROL	(0x3 << 24)
> +
> +static const char * const tc358768_supplies[] = {
> +	"vddc", "vddmipi", "vddio"
> +};
> +
> +struct tc358768_dsi_output {
> +	struct mipi_dsi_device *dev;
> +	struct drm_panel *panel;
> +	struct drm_bridge *bridge;
> +};
> +
> +struct tc358768_priv {
> +	struct device *dev;
> +	struct regmap *regmap;
> +	struct gpio_desc *reset_gpio;
> +	struct regulator_bulk_data supplies[ARRAY_SIZE(tc358768_supplies)];
> +	struct clk *refclk;
> +	int enabled;
> +	int error;
> +
> +	struct mipi_dsi_host dsi_host;
> +	struct drm_bridge bridge;
> +	struct tc358768_dsi_output output;
> +
> +	u32 pd_lines; /* number of Parallel Port Input Data Lines */
> +	u32 dsi_lanes; /* number of DSI Lanes */
> +
> +	/* Parameters for PLL programming */
> +	u32 fbd;	/* PLL feedback divider */
> +	u32 prd;	/* PLL input divider */
> +	u32 frs;	/* PLL Freqency range for HSCK (post divider) */
> +
> +	u32 dsiclk;	/* pll_clk / 2 */
> +};
> +
> +static inline struct tc358768_priv *dsi_host_to_tc358768(struct mipi_dsi_host
> +							 *host)
> +{
> +	return container_of(host, struct tc358768_priv, dsi_host);
> +}
> +
> +static inline struct tc358768_priv *bridge_to_tc358768(struct drm_bridge
> +						       *bridge)
> +{
> +	return container_of(bridge, struct tc358768_priv, bridge);
> +}
> +
> +static int tc358768_clear_error(struct tc358768_priv *priv)
> +{
> +	int ret = priv->error;
> +
> +	priv->error = 0;
> +	return ret;
> +}
> +
> +static void tc358768_write(struct tc358768_priv *priv, u32 reg, u32 val)
> +{
> +	size_t count = 2;
> +
> +	if (priv->error)
> +		return;
> +
> +	/* 16-bit register? */
> +	if (reg < 0x100 || reg >= 0x600)
> +		count = 1;
> +
> +	priv->error = regmap_bulk_write(priv->regmap, reg, &val, count);
> +}
> +
> +static void tc358768_read(struct tc358768_priv *priv, u32 reg, u32 *val)
> +{
> +	size_t count = 2;
> +
> +	if (priv->error)
> +		return;
> +
> +	/* 16-bit register? */
> +	if (reg < 0x100 || reg >= 0x600) {
> +		*val = 0;
> +		count = 1;
> +	}
> +
> +	priv->error = regmap_bulk_read(priv->regmap, reg, val, count);
> +}
> +
> +static void tc358768_update_bits(struct tc358768_priv *priv, u32 reg, u32 mask,
> +				 u32 val)
> +{
> +	u32 tmp, orig;
> +
> +	tc358768_read(priv, reg, &orig);
> +	tmp = orig & ~mask;
> +	tmp |= val & mask;
> +	if (tmp != orig)
> +		tc358768_write(priv, reg, tmp);
> +}
> +
> +static int tc358768_sw_reset(struct tc358768_priv *priv)
> +{
> +	/* Assert Reset */
> +	tc358768_write(priv, TC358768_SYSCTL, 1);
> +	/* Release Reset, Exit Sleep */
> +	tc358768_write(priv, TC358768_SYSCTL, 0);
> +
> +	return tc358768_clear_error(priv);
> +}
> +
> +static void tc358768_hw_enable(struct tc358768_priv *priv)
> +{
> +	int ret;
> +
> +	if (priv->enabled++ > 0)
> +		return;
> +
> +	ret = regulator_bulk_enable(ARRAY_SIZE(priv->supplies), priv->supplies);
> +	if (ret < 0)
> +		dev_err(priv->dev, "error enabling regulators (%d)\n", ret);
> +
> +	if (priv->reset_gpio)
> +		usleep_range(200, 300);
> +
> +	/*
> +	 * The RESX is active low (GPIO_ACTIVE_LOW).
> +	 * DEASSERT (value = 0) the reset_gpio to enable the chip
> +	 */
> +	gpiod_set_value_cansleep(priv->reset_gpio, 0);
> +
> +	/* wait for encoder clocks to stabilize */
> +	usleep_range(1000, 2000);
> +}
> +
> +static void tc358768_hw_disable(struct tc358768_priv *priv)
> +{
> +	int ret;
> +
> +	if (--priv->enabled != 0)

I should be doing:
	if (!priv->enabled || --priv->enabled != 0)

to avoid going negative on the enabled, which could happen I think if an
enable path fails and later the bridge is disabled.

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
