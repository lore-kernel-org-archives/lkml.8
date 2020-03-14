Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F69C4CECE
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 01:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3894D20637
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 01:42:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b="SeNOiKHI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbgCOBmS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Mar 2020 21:42:18 -0400
Received: from hermes.aosc.io ([199.195.250.187]:51366 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726530AbgCOBmR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Mar 2020 21:42:17 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id 65C8E4C6DF;
        Sat, 14 Mar 2020 08:04:04 +0000 (UTC)
Date:   Sat, 14 Mar 2020 16:02:35 +0800
In-Reply-To: <20200314080000.GE5783@ravnborg.org>
References: <20200311163329.221840-1-icenowy@aosc.io> <20200311163329.221840-4-icenowy@aosc.io> <20200314080000.GE5783@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 3/5] drm: panel: add Xingbangda XBD599 panel
To:     Sam Ravnborg <sam@ravnborg.org>
CC:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Ondrej Jirman <megous@megous.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@googlegroups.com
From:   Icenowy Zheng <icenowy@aosc.io>
Message-ID: <6AE386BC-BBC9-491F-82F0-CA32EAFE44DF@aosc.io>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aosc.io; s=dkim;
        t=1584173048;
        h=from:subject:date:message-id:to:cc:mime-version:content-type:content-transfer-encoding:in-reply-to:references;
        bh=38sFWW+aHC6JMRaoefvDlRb1dSMgPBO2UZrmIX95ZWI=;
        b=SeNOiKHI1bapdzvD05FKpRf4yC/lBwA267xSphQG+JAAdV8jMervqiPlyx8nZZyMf2pHsf
        PO2h1CHPw9tYlZy5IRIHH+mXhoeXX+WTJoC+V5Gzg6EriFMIS9YvZ/2fFuHv6cjySF9u+h
        3Jl0hNf9UdXkUHS9pIiOzF3NbbG54n0=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



=E4=BA=8E 2020=E5=B9=B43=E6=9C=8814=E6=97=A5 GMT+08:00 =E4=B8=8B=E5=8D=884=
:00:00, Sam Ravnborg <sam@ravnborg=2Eorg> =E5=86=99=E5=88=B0:
>Hi Icenowy
>
>A few details in the following=2E
>
>	Sam
>
>On Thu, Mar 12, 2020 at 12:33:27AM +0800, Icenowy Zheng wrote:
>> Xingbangda XBD599 is a 5=2E99" 720x1440 MIPI-DSI IPS LCD panel made by
>> Xingbangda, which is used on PinePhone final assembled phones=2E
>>=20
>> Add support for it=2E
>>=20
>> Signed-off-by: Icenowy Zheng <icenowy@aosc=2Eio>
>> ---
>>  drivers/gpu/drm/panel/Kconfig                 |   9 +
>>  drivers/gpu/drm/panel/Makefile                |   1 +
>>  =2E=2E=2E/gpu/drm/panel/panel-xingbangda-xbd599=2Ec   | 367
>++++++++++++++++++
>>  3 files changed, 377 insertions(+)
>>  create mode 100644 drivers/gpu/drm/panel/panel-xingbangda-xbd599=2Ec
>>=20
>> +++ b/drivers/gpu/drm/panel/panel-xingbangda-xbd599=2Ec
>> @@ -0,0 +1,367 @@
>> +// SPDX-License-Identifier: GPL-2=2E0
>> +/*
>> + * Xingbangda XBD599 MIPI-DSI panel driver
>> + *
>> + * Copyright (C) 2019 Icenowy Zheng <icenowy@aosc=2Eio>
>2020?

The work started at Mid 2019=2E

Is 2019-2020 okay?

>
>> + *
>> + * Based on panel-rocktech-jh057n00900=2Ec, which is:
>> + *   Copyright (C) Purism SPC 2019
>> + */
>> +
>> +#include <linux/gpio/consumer=2Eh>
>> +#include <linux/delay=2Eh>
>> +#include <linux/mod_devicetable=2Eh>
>> +#include <linux/module=2Eh>
>> +#include <linux/of_device=2Eh>
>> +#include <linux/regulator/consumer=2Eh>
>Sort alphabetically=2E
>
>> +
>> +#include <drm/drm_mipi_dsi=2Eh>
>> +#include <drm/drm_modes=2Eh>
>> +#include <drm/drm_panel=2Eh>
>> +#include <drm/drm_print=2Eh>
>> +
>> +#define DRV_NAME "panel-xingbangda-xbd599"
>No reason for this indirection, it is only used once
>
>> +
>> +/* Manufacturer specific Commands send via DSI */
>> +#define ST7703_CMD_ALL_PIXEL_OFF 0x22
>> +#define ST7703_CMD_ALL_PIXEL_ON	 0x23
>> +#define ST7703_CMD_SETDISP	 0xB2
>> +#define ST7703_CMD_SETRGBIF	 0xB3
>> +#define ST7703_CMD_SETCYC	 0xB4
>> +#define ST7703_CMD_SETBGP	 0xB5
>> +#define ST7703_CMD_SETVCOM	 0xB6
>> +#define ST7703_CMD_SETOTP	 0xB7
>> +#define ST7703_CMD_SETPOWER_EXT	 0xB8
>> +#define ST7703_CMD_SETEXTC	 0xB9
>> +#define ST7703_CMD_SETMIPI	 0xBA
>> +#define ST7703_CMD_SETVDC	 0xBC
>> +#define ST7703_CMD_SETSCR	 0xC0
>> +#define ST7703_CMD_SETPOWER	 0xC1
>> +#define ST7703_CMD_UNK_C6	 0xC6
>> +#define ST7703_CMD_SETPANEL	 0xCC
>> +#define ST7703_CMD_SETGAMMA	 0xE0
>> +#define ST7703_CMD_SETEQ	 0xE3
>> +#define ST7703_CMD_SETGIP1	 0xE9
>> +#define ST7703_CMD_SETGIP2	 0xEA
>> +
>> +static const char * const regulator_names[] =3D {
>> +	"iovcc",
>> +	"vcc",
>> +};
>> +
>> +struct xbd599 {
>> +	struct device *dev;
>> +	struct drm_panel panel;
>> +	struct gpio_desc *reset_gpio;
>> +	struct regulator_bulk_data supplies[ARRAY_SIZE(regulator_names)];
>> +	bool prepared;
>> +};
>> +
>> +static inline struct xbd599 *panel_to_xbd599(struct drm_panel
>*panel)
>> +{
>> +	return container_of(panel, struct xbd599, panel);
>> +}
>> +
>> +#define dsi_dcs_write_seq(dsi, cmd, seq=2E=2E=2E) do {			\
>> +		static const u8 d[] =3D { seq };				\
>> +		int ret;						\
>> +		ret =3D mipi_dsi_dcs_write(dsi, cmd, d, ARRAY_SIZE(d));	\
>> +		if (ret < 0)						\
>> +			return ret;					\
>> +	} while (0)
>> +
>> +static int xbd599_init_sequence(struct xbd599 *ctx)
>> +{
>> +	struct mipi_dsi_device *dsi =3D to_mipi_dsi_device(ctx->dev);
>> +	struct device *dev =3D ctx->dev;
>> +	int ret;
>> +
>> +	/*
>> +	 * Init sequence was supplied by the panel vendor=2E
>> +	 */
>> +	dsi_dcs_write_seq(dsi, ST7703_CMD_SETEXTC,
>> +			  0xF1, 0x12, 0x83);
>> +	dsi_dcs_write_seq(dsi, ST7703_CMD_SETMIPI,
>> +			  0x33, 0x81, 0x05, 0xF9, 0x0E, 0x0E, 0x20, 0x00,
>> +			  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x44, 0x25,
>> +			  0x00, 0x91, 0x0a, 0x00, 0x00, 0x02, 0x4F, 0x11,
>> +			  0x00, 0x00, 0x37);
>> +	dsi_dcs_write_seq(dsi, ST7703_CMD_SETPOWER_EXT,
>> +			  0x25, 0x22, 0x20, 0x03);
>> +	dsi_dcs_write_seq(dsi, ST7703_CMD_SETRGBIF,
>> +			  0x10, 0x10, 0x05, 0x05, 0x03, 0xFF, 0x00, 0x00,
>> +			  0x00, 0x00);
>> +	dsi_dcs_write_seq(dsi, ST7703_CMD_SETSCR,
>> +			  0x73, 0x73, 0x50, 0x50, 0x00, 0xC0, 0x08, 0x70,
>> +			  0x00);
>> +	dsi_dcs_write_seq(dsi, ST7703_CMD_SETVDC, 0x4E);
>> +	dsi_dcs_write_seq(dsi, ST7703_CMD_SETPANEL, 0x0B);
>> +	dsi_dcs_write_seq(dsi, ST7703_CMD_SETCYC, 0x80);
>> +	dsi_dcs_write_seq(dsi, ST7703_CMD_SETDISP, 0xF0, 0x12, 0xF0);
>> +	dsi_dcs_write_seq(dsi, ST7703_CMD_SETEQ,
>> +			  0x00, 0x00, 0x0B, 0x0B, 0x10, 0x10, 0x00, 0x00,
>> +			  0x00, 0x00, 0xFF, 0x00, 0xC0, 0x10);
>> +	dsi_dcs_write_seq(dsi, 0xC6, 0x01, 0x00, 0xFF, 0xFF, 0x00);
>> +	dsi_dcs_write_seq(dsi, ST7703_CMD_SETPOWER,
>> +			  0x74, 0x00, 0x32, 0x32, 0x77, 0xF1, 0xFF, 0xFF,
>> +			  0xCC, 0xCC, 0x77, 0x77);
>> +	dsi_dcs_write_seq(dsi, ST7703_CMD_SETBGP, 0x07, 0x07);
>> +	dsi_dcs_write_seq(dsi, ST7703_CMD_SETVCOM, 0x2C, 0x2C);
>> +	dsi_dcs_write_seq(dsi, 0xBF, 0x02, 0x11, 0x00);
>> +
>> +	dsi_dcs_write_seq(dsi, ST7703_CMD_SETGIP1,
>> +			  0x82, 0x10, 0x06, 0x05, 0xA2, 0x0A, 0xA5, 0x12,
>> +			  0x31, 0x23, 0x37, 0x83, 0x04, 0xBC, 0x27, 0x38,
>> +			  0x0C, 0x00, 0x03, 0x00, 0x00, 0x00, 0x0C, 0x00,
>> +			  0x03, 0x00, 0x00, 0x00, 0x75, 0x75, 0x31, 0x88,
>> +			  0x88, 0x88, 0x88, 0x88, 0x88, 0x13, 0x88, 0x64,
>> +			  0x64, 0x20, 0x88, 0x88, 0x88, 0x88, 0x88, 0x88,
>> +			  0x02, 0x88, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
>> +			  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00);
>> +	dsi_dcs_write_seq(dsi, ST7703_CMD_SETGIP2,
>> +			  0x02, 0x21, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
>> +			  0x00, 0x00, 0x00, 0x00, 0x02, 0x46, 0x02, 0x88,
>> +			  0x88, 0x88, 0x88, 0x88, 0x88, 0x64, 0x88, 0x13,
>> +			  0x57, 0x13, 0x88, 0x88, 0x88, 0x88, 0x88, 0x88,
>> +			  0x75, 0x88, 0x23, 0x14, 0x00, 0x00, 0x02, 0x00,
>> +			  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
>> +			  0x00, 0x00, 0x00 ,0x00, 0x00, 0x00, 0x03, 0x0A,
>> +			  0xA5, 0x00, 0x00, 0x00, 0x00);
>> +	dsi_dcs_write_seq(dsi, ST7703_CMD_SETGAMMA,
>> +			  0x00, 0x09, 0x0D, 0x23, 0x27, 0x3C, 0x41, 0x35,
>> +			  0x07, 0x0D, 0x0E, 0x12, 0x13, 0x10, 0x12, 0x12,
>> +			  0x18, 0x00, 0x09, 0x0D, 0x23, 0x27, 0x3C, 0x41,
>> +			  0x35, 0x07, 0x0D, 0x0E, 0x12, 0x13, 0x10, 0x12,
>> +			  0x12, 0x18);
>> +	msleep(20);
>> +
>> +	ret =3D mipi_dsi_dcs_exit_sleep_mode(dsi);
>> +	if (ret < 0) {
>> +		DRM_DEV_ERROR(dev, "Failed to exit sleep mode\n");
>> +		return ret;
>> +	}
>> +	msleep(250);
>> +
>> +	ret =3D mipi_dsi_dcs_set_display_on(dsi);
>> +	if (ret)
>> +		return ret;
>> +	msleep(50);
>> +
>> +	DRM_DEV_DEBUG_DRIVER(dev, "Panel init sequence done\n");
>> +	return 0;
>> +}
>> +
>> +static int xbd599_disable(struct drm_panel *panel)
>> +{
>> +	struct xbd599 *ctx =3D panel_to_xbd599(panel);
>> +	struct mipi_dsi_device *dsi =3D to_mipi_dsi_device(ctx->dev);
>> +
>> +	return mipi_dsi_dcs_set_display_off(dsi);
>> +}
>The following is the same for many panels but anyway=2E
>
>The init order for a display is
>
>    prepare
>    enable
>
>    # Display is now fully operational
>
>    disable
>    unprepare
>
>    # display is now off and turned off (no power)
>
>So when reading panel drivers my personal preference is to read the
>functions in that order - this makes it easier to follow the sequence=2E
>
>Thats just my personal opinion - so feel free to ignore=2E
>
>> +
>> +static int xbd599_unprepare(struct drm_panel *panel)
>> +{
>> +	struct xbd599 *ctx =3D panel_to_xbd599(panel);
>> +
>> +	if (!ctx->prepared)
>> +		return 0;
>> +
>> +	regulator_bulk_disable(ARRAY_SIZE(ctx->supplies), ctx->supplies);
>> +	ctx->prepared =3D false;
>> +
>> +	return 0;
>> +}
>Maybe activate reset before power is turned off=2E
>So when power is turned on again later the panel is kept in reset=2E
>
>This would also make this a closer mirror of what is done in prepare()
>
>> +
>> +static int xbd599_enable(struct drm_panel *panel)
>> +{
>> +	struct xbd599 *ctx =3D panel_to_xbd599(panel);
>> +	int ret;
>> +
>> +	ret =3D xbd599_init_sequence(ctx);
>> +	if (ret < 0) {
>> +		DRM_DEV_ERROR(ctx->dev, "Panel init sequence failed: %d\n",
>> +			      ret);
>> +		return ret;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int xbd599_prepare(struct drm_panel *panel)
>> +{
>> +	struct xbd599 *ctx =3D panel_to_xbd599(panel);
>> +	int ret;
>> +
>> +	if (ctx->prepared)
>> +		return 0;
>> +
>> +	ret =3D regulator_bulk_enable(ARRAY_SIZE(ctx->supplies),
>ctx->supplies);
>> +	if (ret)
>> +		return ret;
>> +
>> +	DRM_DEV_DEBUG_DRIVER(ctx->dev, "Resetting the panel\n");
>> +	gpiod_set_value_cansleep(ctx->reset_gpio, 1);
>> +	usleep_range(20, 40);
>> +	gpiod_set_value_cansleep(ctx->reset_gpio, 0);
>> +	msleep(20);
>> +
>> +	ctx->prepared =3D true;
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct drm_display_mode xbd599_default_mode =3D {
>> +	=2Ehdisplay    =3D 720,
>> +	=2Ehsync_start =3D 720 + 40,
>> +	=2Ehsync_end   =3D 720 + 40 + 40,
>> +	=2Ehtotal	     =3D 720 + 40 + 40 + 40,
>> +	=2Evdisplay    =3D 1440,
>> +	=2Evsync_start =3D 1440 + 18,
>> +	=2Evsync_end   =3D 1440 + 18 + 10,
>> +	=2Evtotal	     =3D 1440 + 18 + 10 + 17,
>> +	=2Evrefresh    =3D 60,
>> +	=2Eclock	     =3D 69000,
>> +	=2Eflags	     =3D DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC,
>> +
>> +	=2Ewidth_mm    =3D 68,
>> +	=2Eheight_mm   =3D 136,
>> +	=2Etype        =3D DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED,
>> +};
>> +
>> +static int xbd599_get_modes(struct drm_panel *panel,
>> +			    struct drm_connector *connector)
>> +{
>> +	struct xbd599 *ctx =3D panel_to_xbd599(panel);
>> +	struct drm_display_mode *mode;
>> +
>> +	mode =3D drm_mode_duplicate(connector->dev, &xbd599_default_mode);
>> +	if (!mode) {
>> +		DRM_DEV_ERROR(ctx->dev, "Failed to add mode\n");
>> +		return -ENOMEM;
>> +	}
>> +
>> +	drm_mode_set_name(mode);
>> +
>> +	mode->type =3D DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED;
>> +	connector->display_info=2Ewidth_mm =3D mode->width_mm;
>> +	connector->display_info=2Eheight_mm =3D mode->height_mm;
>> +	drm_mode_probed_add(connector, mode);
>> +
>> +	return 1;
>> +}
>> +
>> +static const struct drm_panel_funcs xbd599_drm_funcs =3D {
>> +	=2Edisable   =3D xbd599_disable,
>> +	=2Eunprepare =3D xbd599_unprepare,
>> +	=2Eenable    =3D xbd599_enable,
>> +	=2Eprepare   =3D xbd599_prepare,
>> +	=2Eget_modes =3D xbd599_get_modes,
>> +};
>> +
>> +static int xbd599_probe(struct mipi_dsi_device *dsi)
>> +{
>> +	struct device *dev =3D &dsi->dev;
>> +	struct xbd599 *ctx;
>> +	int i, ret;
>> +
>> +	ctx =3D devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
>> +	if (!ctx)
>> +		return -ENOMEM;
>> +
>> +	for (i =3D 0; i < ARRAY_SIZE(ctx->supplies); i++)
>> +		ctx->supplies[i]=2Esupply =3D regulator_names[i];
>> +
>> +	ret =3D devm_regulator_bulk_get(dev, ARRAY_SIZE(ctx->supplies),
>> +				      ctx->supplies);
>> +	if (ret < 0) {
>> +		DRM_DEV_ERROR(&dsi->dev, "cannot get regulators\n");
>> +		return ret;
>> +	}
>> +
>> +	ctx->reset_gpio =3D devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
>> +	if (IS_ERR(ctx->reset_gpio)) {
>> +		DRM_DEV_ERROR(dev, "cannot get reset gpio\n");
>> +		return PTR_ERR(ctx->reset_gpio);
>> +	}
>> +
>> +	mipi_dsi_set_drvdata(dsi, ctx);
>> +
>> +	ctx->dev =3D dev;
>> +
>> +	dsi->lanes =3D 4;
>> +	dsi->format =3D MIPI_DSI_FMT_RGB888;
>> +	dsi->mode_flags =3D MIPI_DSI_MODE_VIDEO |
>MIPI_DSI_MODE_VIDEO_SYNC_PULSE;
>> +
>> +	drm_panel_init(&ctx->panel, &dsi->dev, &xbd599_drm_funcs,
>> +		       DRM_MODE_CONNECTOR_DSI);
>> +
>> +	ret =3D drm_panel_of_backlight(&ctx->panel);
>> +	if (ret)
>> +		return ret;
>> +
>> +	drm_panel_add(&ctx->panel);
>> +
>> +	ret =3D mipi_dsi_attach(dsi);
>> +	if (ret < 0) {
>> +		DRM_DEV_ERROR(dev, "mipi_dsi_attach failed=2E Is host ready?\n");
>> +		drm_panel_remove(&ctx->panel);
>> +		return ret;
>> +	}
>> +
>> +	DRM_DEV_INFO(dev, "%ux%u@%u %ubpp dsi %udl - ready\n",
>> +		     xbd599_default_mode=2Ehdisplay,
>> +		     xbd599_default_mode=2Evdisplay,
>> +		     xbd599_default_mode=2Evrefresh,
>> +		     mipi_dsi_pixel_format_to_bpp(dsi->format), dsi->lanes);
>> +
>> +	return 0;
>> +}
>> +
>> +static void xbd599_shutdown(struct mipi_dsi_device *dsi)
>> +{
>> +	struct xbd599 *ctx =3D mipi_dsi_get_drvdata(dsi);
>> +	int ret;
>> +
>> +	ret =3D xbd599_unprepare(&ctx->panel);
>
>Use drm_panel_unprepare()=2E
>There may be, or may come functionality in drm_panel that is required=2E
>
>> +	if (ret < 0)
>> +		DRM_DEV_ERROR(&dsi->dev, "Failed to unprepare panel: %d\n",
>> +			      ret);
>> +}
>> +
>> +static int xbd599_remove(struct mipi_dsi_device *dsi)
>> +{
>> +	struct xbd599 *ctx =3D mipi_dsi_get_drvdata(dsi);
>> +	int ret;
>> +
>> +	xbd599_shutdown(dsi);
>> +
>> +	ret =3D mipi_dsi_detach(dsi);
>> +	if (ret < 0)
>> +		DRM_DEV_ERROR(&dsi->dev, "Failed to detach from DSI host: %d\n",
>> +			      ret);
>> +
>> +	drm_panel_remove(&ctx->panel);
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct of_device_id xbd599_of_match[] =3D {
>> +	{ =2Ecompatible =3D "xingbangda,xbd599", },
>> +	{ /* sentinel */ }
>> +};
>> +MODULE_DEVICE_TABLE(of, xbd599_of_match);
>> +
>> +static struct mipi_dsi_driver xbd599_driver =3D {
>> +	=2Eprobe	=3D xbd599_probe,
>> +	=2Eremove =3D xbd599_remove,
>> +	=2Eshutdown =3D xbd599_shutdown,
>> +	=2Edriver =3D {
>> +		=2Ename =3D DRV_NAME,
>> +		=2Eof_match_table =3D xbd599_of_match,
>> +	},
>> +};
>> +module_mipi_dsi_driver(xbd599_driver);
>> +
>> +MODULE_AUTHOR("Icenowy Zheng <icenowy@aosc=2Eio>");
>> +MODULE_DESCRIPTION("DRM driver for Xingbangda XBD599 MIPI DSI
>panel");
>> +MODULE_LICENSE("GPL v2");
>> --=20
>> 2=2E24=2E1

--=20
=E4=BD=BF=E7=94=A8 K-9 Mail =E5=8F=91=E9=80=81=E8=87=AA=E6=88=91=E7=9A=84A=
ndroid=E8=AE=BE=E5=A4=87=E3=80=82
