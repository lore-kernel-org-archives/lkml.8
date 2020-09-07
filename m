Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EBD9C2BB84
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 19:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25A7621532
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 19:52:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729169AbgIGTwt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 15:52:49 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:41432 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728675AbgIGTws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 15:52:48 -0400
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 8EEEF20033;
        Mon,  7 Sep 2020 21:52:45 +0200 (CEST)
Date:   Mon, 7 Sep 2020 21:52:44 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     thierry.reding@gmail.com, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 3/3] drm: panel: add TDO tl070wsh30 panel driver
Message-ID: <20200907195244.GB558348@ravnborg.org>
References: <20200907111027.21933-1-narmstrong@baylibre.com>
 <20200907111027.21933-4-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200907111027.21933-4-narmstrong@baylibre.com>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=CaYmGojl c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=8nJEP1OIZ-IA:10 a=IpJZQVW2AAAA:8 a=e5mUnYsNAAAA:8
        a=OZb2ejd9N8hvyYciKFoA:9 a=wPNLvfGTeEIA:10 a=IawgGOuG5U0WyFbmm1f5:22
        a=Vxmtnl_E_bksehYqCbjh:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil.

On Mon, Sep 07, 2020 at 01:10:27PM +0200, Neil Armstrong wrote:
> This adds support for the TDO TL070WSH30 TFT-LCD panel module.
> The panel has a 1024×600 resolution and uses 24 bit RGB per pixel.
> It provides a MIPI DSI interface to the host, a built-in LED backlight
> and touch controller.

Despite a nicely written driver I noticed a few things that needs to be
addressed.

	Sam
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  drivers/gpu/drm/panel/Kconfig                |  11 +
>  drivers/gpu/drm/panel/Makefile               |   1 +
>  drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c | 256 +++++++++++++++++++
>  3 files changed, 268 insertions(+)
>  create mode 100644 drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c
> 
> diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
> index 8d97d07c5871..2d488a875b99 100644
> --- a/drivers/gpu/drm/panel/Kconfig
> +++ b/drivers/gpu/drm/panel/Kconfig
> @@ -433,6 +433,17 @@ config DRM_PANEL_SONY_ACX565AKM
>  	  Say Y here if you want to enable support for the Sony ACX565AKM
>  	  800x600 3.5" panel (found on the Nokia N900).
>  
> +config DRM_PANEL_TDO_TL070WSH30
> +	tristate "TDO TL070WSH30 DSI panel"
> +	depends on OF
> +	depends on DRM_MIPI_DSI
> +	depends on BACKLIGHT_CLASS_DEVICE
> +	help
> +	  Say Y here if you want to enable support for TDO TL070WSH30 TFT-LCD
> +	  panel module. The panel has a 1024×600 resolution and uses
> +	  24 bit RGB per pixel. It provides a MIPI DSI interface to
> +	  the host, a built-in LED backlight and touch controller.
> +
>  config DRM_PANEL_TPO_TD028TTEC1
>  	tristate "Toppoly (TPO) TD028TTEC1 panel driver"
>  	depends on OF && SPI
> diff --git a/drivers/gpu/drm/panel/Makefile b/drivers/gpu/drm/panel/Makefile
> index 15a4e7752951..35ee06a1b5c2 100644
> --- a/drivers/gpu/drm/panel/Makefile
> +++ b/drivers/gpu/drm/panel/Makefile
> @@ -45,6 +45,7 @@ obj-$(CONFIG_DRM_PANEL_SITRONIX_ST7703) += panel-sitronix-st7703.o
>  obj-$(CONFIG_DRM_PANEL_SITRONIX_ST7789V) += panel-sitronix-st7789v.o
>  obj-$(CONFIG_DRM_PANEL_SONY_ACX424AKP) += panel-sony-acx424akp.o
>  obj-$(CONFIG_DRM_PANEL_SONY_ACX565AKM) += panel-sony-acx565akm.o
> +obj-$(CONFIG_DRM_PANEL_TDO_TL070WSH30) += panel-tdo-tl070wsh30.o
>  obj-$(CONFIG_DRM_PANEL_TPO_TD028TTEC1) += panel-tpo-td028ttec1.o
>  obj-$(CONFIG_DRM_PANEL_TPO_TD043MTEA1) += panel-tpo-td043mtea1.o
>  obj-$(CONFIG_DRM_PANEL_TPO_TPG110) += panel-tpo-tpg110.o
> diff --git a/drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c b/drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c
> new file mode 100644
> index 000000000000..c7a6c2c42c52
> --- /dev/null
> +++ b/drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c
> @@ -0,0 +1,256 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2020 BayLibre, SAS
> + * Author: Neil Armstrong <narmstrong@baylibre.com>
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/regulator/consumer.h>
> +
> +#include <video/mipi_display.h>
> +
> +#include <drm/drm_crtc.h>
> +#include <drm/drm_device.h>
> +#include <drm/drm_mipi_dsi.h>
> +#include <drm/drm_modes.h>
> +#include <drm/drm_panel.h>
> +
> +struct tdo_tl070wsh30_panel {
> +	struct drm_panel base;
> +	struct mipi_dsi_device *link;
> +
> +	struct regulator *supply;
> +	struct gpio_desc *reset_gpio;
> +
> +	bool prepared;
> +};
> +
> +static inline
> +struct tdo_tl070wsh30_panel *to_tdo_tl070wsh30_panel(struct drm_panel *panel)
> +{
> +	return container_of(panel, struct tdo_tl070wsh30_panel, base);
> +}

bikeshedding - but my preference is to order the functions:

prepare
enable
disable
unprepare

As this is the natural order they are used.
Feel free to ignore!

> +
> +static int tdo_tl070wsh30_panel_unprepare(struct drm_panel *panel)
> +{
> +	struct tdo_tl070wsh30_panel *tdo_tl070wsh30 = to_tdo_tl070wsh30_panel(panel);
> +	int err;
> +
> +	if (!tdo_tl070wsh30->prepared)
> +		return 0;
> +
> +	err = mipi_dsi_dcs_set_display_off(tdo_tl070wsh30->link);
> +	if (err < 0)
> +		dev_err(panel->dev, "failed to set display off: %d\n", err);
> +
> +	usleep_range(10000, 11000);
> +
> +	err = mipi_dsi_dcs_enter_sleep_mode(tdo_tl070wsh30->link);
> +	if (err < 0) {
> +		dev_err(panel->dev, "failed to enter sleep mode: %d\n", err);
> +		return err;
> +	}
> +
> +	usleep_range(10000, 11000);
> +
> +	tdo_tl070wsh30->prepared = false;
> +
> +	return 0;
> +}
> +
> +static int tdo_tl070wsh30_panel_prepare(struct drm_panel *panel)
> +{
> +	struct tdo_tl070wsh30_panel *tdo_tl070wsh30 = to_tdo_tl070wsh30_panel(panel);
> +	int err;
> +
> +	if (tdo_tl070wsh30->prepared)
> +		return 0;
> +
> +	err = mipi_dsi_dcs_exit_sleep_mode(tdo_tl070wsh30->link);
> +	if (err < 0) {
> +		dev_err(panel->dev, "failed to exit sleep mode: %d\n", err);
> +		return err;
> +	}
> +
> +	msleep(200);
> +
> +	err = mipi_dsi_dcs_set_display_on(tdo_tl070wsh30->link);
> +	if (err < 0) {
> +		dev_err(panel->dev, "failed to set display on: %d\n", err);
> +		return err;
> +	}
> +
> +	msleep(20);
> +
> +	tdo_tl070wsh30->prepared = true;
> +
> +	return 0;
> +}
> +
> +static const struct drm_display_mode default_mode = {
> +	.clock = 47250,
> +	.hdisplay = 1024,
> +	.hsync_start = 1024 + 46,
> +	.hsync_end = 1024 + 46 + 80,
> +	.htotal = 1024 + 46 + 80 + 100,
> +	.vdisplay = 600,
> +	.vsync_start = 600 + 5,
> +	.vsync_end = 600 + 5 + 5,
> +	.vtotal = 600 + 5 + 5 + 20,
> +	.flags = DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC,
> +};
> +
> +static int tdo_tl070wsh30_panel_get_modes(struct drm_panel *panel,
> +				       struct drm_connector *connector)
> +{
> +	struct drm_display_mode *mode;
> +
> +	mode = drm_mode_duplicate(connector->dev, &default_mode);
> +	if (!mode) {
> +		dev_err(panel->dev, "failed to add mode %ux%ux\n", default_mode.hdisplay,
> +			default_mode.vdisplay);
Here we often print the refresh rate too.
If there is no need for the refresh rate than at least drop the extra
'x' at the end of the line.

> +		return -ENOMEM;
> +	}
> +
> +	drm_mode_set_name(mode);
> +
> +	drm_mode_probed_add(connector, mode);
> +
> +	connector->display_info.width_mm = 154;
> +	connector->display_info.height_mm = 85;
> +	connector->display_info.bpc = 8;
> +
> +	return 1;
> +}
> +
> +static const struct drm_panel_funcs tdo_tl070wsh30_panel_funcs = {
> +	.unprepare = tdo_tl070wsh30_panel_unprepare,
> +	.prepare = tdo_tl070wsh30_panel_prepare,
> +	.get_modes = tdo_tl070wsh30_panel_get_modes,
> +};
> +
> +static const struct of_device_id tdo_tl070wsh30_of_match[] = {
> +	{ .compatible = "tdo,tl070wsh30", },
> +	{ }
I often recommends
	{ /* sentinel },

but thats just to be consistent with what I see in other drivers.

> +};
> +MODULE_DEVICE_TABLE(of, tdo_tl070wsh30_of_match);
> +
> +static int tdo_tl070wsh30_panel_add(struct tdo_tl070wsh30_panel *tdo_tl070wsh30)
> +{
> +	struct device *dev = &tdo_tl070wsh30->link->dev;
> +	int err;
> +
> +	tdo_tl070wsh30->supply = devm_regulator_get(dev, "power");
> +	if (IS_ERR(tdo_tl070wsh30->supply))
> +		return PTR_ERR(tdo_tl070wsh30->supply);
> +
> +	tdo_tl070wsh30->reset_gpio = devm_gpiod_get(dev, "reset",
> +						  GPIOD_OUT_LOW);
> +	if (IS_ERR(tdo_tl070wsh30->reset_gpio)) {
> +		err = PTR_ERR(tdo_tl070wsh30->reset_gpio);
> +		dev_dbg(dev, "failed to get reset gpio: %d\n", err);
> +		return err;
> +	}
> +
> +	drm_panel_init(&tdo_tl070wsh30->base, &tdo_tl070wsh30->link->dev,
> +		       &tdo_tl070wsh30_panel_funcs, DRM_MODE_CONNECTOR_DSI);
> +
> +	err = drm_panel_of_backlight(&tdo_tl070wsh30->base);
> +	if (err)
> +		return err;



> +
> +	err = regulator_enable(tdo_tl070wsh30->supply);
> +	if (err < 0)
> +		return err;
> +
> +	usleep_range(10000, 11000);
> +
> +	gpiod_set_value_cansleep(tdo_tl070wsh30->reset_gpio, 1);
> +
> +	usleep_range(10000, 11000);
> +
> +	gpiod_set_value_cansleep(tdo_tl070wsh30->reset_gpio, 0);
> +
> +	msleep(200);
> +

It is the job of the prepare function to turn on the panel,
and likewise the unprepare to turn off the panel.
Please move the code above to the prepare function.


> +	drm_panel_add(&tdo_tl070wsh30->base);
> +
> +	return 0;
> +}
> +
> +static void tdo_tl070wsh30_panel_del(struct tdo_tl070wsh30_panel *tdo_tl070wsh30)
> +{
> +	drm_panel_remove(&tdo_tl070wsh30->base);
> +}
This helper does not gain anything - call drm_panel_remove() direct.

> +
> +static int tdo_tl070wsh30_panel_probe(struct mipi_dsi_device *dsi)
> +{
> +	struct tdo_tl070wsh30_panel *tdo_tl070wsh30;
> +	int err;
> +
> +	dsi->lanes = 4;
> +	dsi->format = MIPI_DSI_FMT_RGB888;
> +	dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_BURST | MIPI_DSI_MODE_LPM;
> +
> +	tdo_tl070wsh30 = devm_kzalloc(&dsi->dev, sizeof(*tdo_tl070wsh30),
> +				    GFP_KERNEL);
> +	if (!tdo_tl070wsh30)
> +		return -ENOMEM;
> +
> +	mipi_dsi_set_drvdata(dsi, tdo_tl070wsh30);
> +	tdo_tl070wsh30->link = dsi;
> +
> +	err = tdo_tl070wsh30_panel_add(tdo_tl070wsh30);
> +	if (err < 0)
> +		return err;
> +
> +	return mipi_dsi_attach(dsi);
> +}
> +
> +static int tdo_tl070wsh30_panel_remove(struct mipi_dsi_device *dsi)
> +{
> +	struct tdo_tl070wsh30_panel *tdo_tl070wsh30 = mipi_dsi_get_drvdata(dsi);
> +	int err;
> +
> +	err = drm_panel_unprepare(&tdo_tl070wsh30->base);
> +	if (err < 0)
> +		dev_err(&dsi->dev, "failed to unprepare panel: %d\n", err);
> +
> +	err = drm_panel_disable(&tdo_tl070wsh30->base);
> +	if (err < 0)
> +		dev_err(&dsi->dev, "failed to disable panel: %d\n", err);
> +
In most panel drivers we just ignore the return results here.

> +	err = mipi_dsi_detach(dsi);
> +	if (err < 0)
> +		dev_err(&dsi->dev, "failed to detach from DSI host: %d\n", err);
> +
> +	tdo_tl070wsh30_panel_del(tdo_tl070wsh30);
> +
> +	return 0;
> +}
> +
> +static void tdo_tl070wsh30_panel_shutdown(struct mipi_dsi_device *dsi)
> +{
> +	struct tdo_tl070wsh30_panel *tdo_tl070wsh30 = mipi_dsi_get_drvdata(dsi);
> +
> +	drm_panel_unprepare(&tdo_tl070wsh30->base);
> +	drm_panel_disable(&tdo_tl070wsh30->base);
This is the wrong order. disable before unpreapre.


I am not sure what is right here - but I see some drivers that only have
the disable() + unprepare() in their shutdown() method and then the
remocal in their remove() function.
That makes sense with this split but I have not looked too deep into it.

> +}
> +
> +static struct mipi_dsi_driver tdo_tl070wsh30_panel_driver = {
> +	.driver = {
> +		.name = "panel-tdo-tl070wsh30",
> +		.of_match_table = tdo_tl070wsh30_of_match,
> +	},
> +	.probe = tdo_tl070wsh30_panel_probe,
> +	.remove = tdo_tl070wsh30_panel_remove,
> +	.shutdown = tdo_tl070wsh30_panel_shutdown,
> +};
> +module_mipi_dsi_driver(tdo_tl070wsh30_panel_driver);
> +
> +MODULE_AUTHOR("Neil Armstrong <narmstrong@baylibre.com>");
> +MODULE_DESCRIPTION("TDO TL070WSH30 panel driver");
> +MODULE_LICENSE("GPL v2");
> -- 
> 2.22.0
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
