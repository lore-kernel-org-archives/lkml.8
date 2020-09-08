Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB09DC43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 07:41:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B29A207DE
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 07:41:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="fN6k5um7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729305AbgIHHlL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 03:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729190AbgIHHlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 03:41:05 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E50BC061573
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 00:41:04 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id a9so16124556wmm.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 00:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=t8agpATIloVmTgcFNd5TB4FQfNWGSCtWVYOfLN6qNNE=;
        b=fN6k5um7C7AEOqXC683HOyRmG3Vqp2EeqIFQe5kAmHijhbLW/SDbRfcq56VxgodvVx
         ViDmHtHVu5eBPMxo34zE1elJFeak+N6V+8EYCujXtnhtt5o31TNoi36TRtAuGh8iDqVg
         mSgTXX1v+wNvjeeKe3aMqohVkEwr3PZK7CRxNVT6bMmm3mrqmD23z6HEkTYMOAohTPcb
         1MHr+No1n+Elm+9XzgT/JHObD1fosNNtgLNVgtVbakhw+qrSUDxUK9Wn1UZs56LwFbsY
         T+eQXUpmDQ0QInM7yy0EdzMEAgUN90JbEUHmzN9ylehU+vd4qmzLGtGz3wuDItJVOuQC
         jyQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=t8agpATIloVmTgcFNd5TB4FQfNWGSCtWVYOfLN6qNNE=;
        b=El6PGnykwICBmDWhVw9XsmtQ1ecne/SAsTj6sbrqJ6RBA2TmQQuWnJEtQTdr4CQeHE
         FY4Vb7xYiPGERLt1J3giaZGZq0+i594VaX6PaxbvENRvSEPchOGzPtFM9xkJkryaoRaj
         w1w3ITaQb/w4WqBDQmAh8nPotiJsNxjxx0esoFFDIdxvQekUPccYFSRQeGG9HwqcWubk
         Tqgh5Gv0xAe63c152bf2XHs/yVKyMGwVO8YrEF3b9u540RXLRSvV8zgv2KqBsElkF7fK
         65rs49fkgQorgdLU12Z1gXWznMVyuViQnyToNHS/eb5u1i171jlbN69bVDGCJ7zNEjSj
         Lzbw==
X-Gm-Message-State: AOAM531Rcms9L5tLltx2n1tFTzcshdB7y5mGP/GrsuUUDRC0mDeiEztk
        0JMT60FLaZLVcspf4E8KTueQpw==
X-Google-Smtp-Source: ABdhPJy3zFZ43EifkQzD/C9vQhMtA+ZxauM+mN4GfwLHTtT5JHInKHBRrZK4DDZuRbFekWP8P1zEDw==
X-Received: by 2002:a1c:4e08:: with SMTP id g8mr2928795wmh.53.1599550863030;
        Tue, 08 Sep 2020 00:41:03 -0700 (PDT)
Received: from ?IPv6:2a01:e35:2ec0:82b0:5405:9623:e2f1:b2ac? ([2a01:e35:2ec0:82b0:5405:9623:e2f1:b2ac])
        by smtp.gmail.com with ESMTPSA id d18sm32714069wrm.10.2020.09.08.00.41.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Sep 2020 00:41:02 -0700 (PDT)
Subject: Re: [PATCH v2 3/3] drm: panel: add TDO tl070wsh30 panel driver
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     thierry.reding@gmail.com, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20200907111027.21933-1-narmstrong@baylibre.com>
 <20200907111027.21933-4-narmstrong@baylibre.com>
 <20200907195244.GB558348@ravnborg.org>
From:   Neil Armstrong <narmstrong@baylibre.com>
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 BSwxi7g3Mu7u5kUByanqHyA=
Organization: Baylibre
Message-ID: <479e1299-740a-8a9e-1747-53a626f28d8e@baylibre.com>
Date:   Tue, 8 Sep 2020 09:41:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200907195244.GB558348@ravnborg.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 07/09/2020 21:52, Sam Ravnborg wrote:
> Hi Neil.
> 
> On Mon, Sep 07, 2020 at 01:10:27PM +0200, Neil Armstrong wrote:
>> This adds support for the TDO TL070WSH30 TFT-LCD panel module.
>> The panel has a 1024×600 resolution and uses 24 bit RGB per pixel.
>> It provides a MIPI DSI interface to the host, a built-in LED backlight
>> and touch controller.
> 
> Despite a nicely written driver I noticed a few things that needs to be
> addressed.

Thanks for the review, indeed the remove/shutdown was wrong, and I aligned
with panel-simple, which seems more logical.

> 
> 	Sam
>>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> ---
>>  drivers/gpu/drm/panel/Kconfig                |  11 +
>>  drivers/gpu/drm/panel/Makefile               |   1 +
>>  drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c | 256 +++++++++++++++++++
>>  3 files changed, 268 insertions(+)
>>  create mode 100644 drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c
>>
>> diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
>> index 8d97d07c5871..2d488a875b99 100644
>> --- a/drivers/gpu/drm/panel/Kconfig
>> +++ b/drivers/gpu/drm/panel/Kconfig
>> @@ -433,6 +433,17 @@ config DRM_PANEL_SONY_ACX565AKM
>>  	  Say Y here if you want to enable support for the Sony ACX565AKM
>>  	  800x600 3.5" panel (found on the Nokia N900).
>>  
>> +config DRM_PANEL_TDO_TL070WSH30
>> +	tristate "TDO TL070WSH30 DSI panel"
>> +	depends on OF
>> +	depends on DRM_MIPI_DSI
>> +	depends on BACKLIGHT_CLASS_DEVICE
>> +	help
>> +	  Say Y here if you want to enable support for TDO TL070WSH30 TFT-LCD
>> +	  panel module. The panel has a 1024×600 resolution and uses
>> +	  24 bit RGB per pixel. It provides a MIPI DSI interface to
>> +	  the host, a built-in LED backlight and touch controller.
>> +
>>  config DRM_PANEL_TPO_TD028TTEC1
>>  	tristate "Toppoly (TPO) TD028TTEC1 panel driver"
>>  	depends on OF && SPI
>> diff --git a/drivers/gpu/drm/panel/Makefile b/drivers/gpu/drm/panel/Makefile
>> index 15a4e7752951..35ee06a1b5c2 100644
>> --- a/drivers/gpu/drm/panel/Makefile
>> +++ b/drivers/gpu/drm/panel/Makefile
>> @@ -45,6 +45,7 @@ obj-$(CONFIG_DRM_PANEL_SITRONIX_ST7703) += panel-sitronix-st7703.o
>>  obj-$(CONFIG_DRM_PANEL_SITRONIX_ST7789V) += panel-sitronix-st7789v.o
>>  obj-$(CONFIG_DRM_PANEL_SONY_ACX424AKP) += panel-sony-acx424akp.o
>>  obj-$(CONFIG_DRM_PANEL_SONY_ACX565AKM) += panel-sony-acx565akm.o
>> +obj-$(CONFIG_DRM_PANEL_TDO_TL070WSH30) += panel-tdo-tl070wsh30.o
>>  obj-$(CONFIG_DRM_PANEL_TPO_TD028TTEC1) += panel-tpo-td028ttec1.o
>>  obj-$(CONFIG_DRM_PANEL_TPO_TD043MTEA1) += panel-tpo-td043mtea1.o
>>  obj-$(CONFIG_DRM_PANEL_TPO_TPG110) += panel-tpo-tpg110.o
>> diff --git a/drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c b/drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c
>> new file mode 100644
>> index 000000000000..c7a6c2c42c52
>> --- /dev/null
>> +++ b/drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c
>> @@ -0,0 +1,256 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (C) 2020 BayLibre, SAS
>> + * Author: Neil Armstrong <narmstrong@baylibre.com>
>> + */
>> +
>> +#include <linux/delay.h>
>> +#include <linux/gpio/consumer.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/regulator/consumer.h>
>> +
>> +#include <video/mipi_display.h>
>> +
>> +#include <drm/drm_crtc.h>
>> +#include <drm/drm_device.h>
>> +#include <drm/drm_mipi_dsi.h>
>> +#include <drm/drm_modes.h>
>> +#include <drm/drm_panel.h>
>> +
>> +struct tdo_tl070wsh30_panel {
>> +	struct drm_panel base;
>> +	struct mipi_dsi_device *link;
>> +
>> +	struct regulator *supply;
>> +	struct gpio_desc *reset_gpio;
>> +
>> +	bool prepared;
>> +};
>> +
>> +static inline
>> +struct tdo_tl070wsh30_panel *to_tdo_tl070wsh30_panel(struct drm_panel *panel)
>> +{
>> +	return container_of(panel, struct tdo_tl070wsh30_panel, base);
>> +}
> 
> bikeshedding - but my preference is to order the functions:
> 
> prepare
> enable
> disable
> unprepare
> 
> As this is the natural order they are used.
> Feel free to ignore!

Ack, prepare before unprepare looks better !

> 
>> +
>> +static int tdo_tl070wsh30_panel_unprepare(struct drm_panel *panel)
>> +{
>> +	struct tdo_tl070wsh30_panel *tdo_tl070wsh30 = to_tdo_tl070wsh30_panel(panel);
>> +	int err;
>> +
>> +	if (!tdo_tl070wsh30->prepared)
>> +		return 0;
>> +
>> +	err = mipi_dsi_dcs_set_display_off(tdo_tl070wsh30->link);
>> +	if (err < 0)
>> +		dev_err(panel->dev, "failed to set display off: %d\n", err);
>> +
>> +	usleep_range(10000, 11000);
>> +
>> +	err = mipi_dsi_dcs_enter_sleep_mode(tdo_tl070wsh30->link);
>> +	if (err < 0) {
>> +		dev_err(panel->dev, "failed to enter sleep mode: %d\n", err);
>> +		return err;
>> +	}
>> +
>> +	usleep_range(10000, 11000);
>> +
>> +	tdo_tl070wsh30->prepared = false;
>> +
>> +	return 0;
>> +}
>> +
>> +static int tdo_tl070wsh30_panel_prepare(struct drm_panel *panel)
>> +{
>> +	struct tdo_tl070wsh30_panel *tdo_tl070wsh30 = to_tdo_tl070wsh30_panel(panel);
>> +	int err;
>> +
>> +	if (tdo_tl070wsh30->prepared)
>> +		return 0;
>> +
>> +	err = mipi_dsi_dcs_exit_sleep_mode(tdo_tl070wsh30->link);
>> +	if (err < 0) {
>> +		dev_err(panel->dev, "failed to exit sleep mode: %d\n", err);
>> +		return err;
>> +	}
>> +
>> +	msleep(200);
>> +
>> +	err = mipi_dsi_dcs_set_display_on(tdo_tl070wsh30->link);
>> +	if (err < 0) {
>> +		dev_err(panel->dev, "failed to set display on: %d\n", err);
>> +		return err;
>> +	}
>> +
>> +	msleep(20);
>> +
>> +	tdo_tl070wsh30->prepared = true;
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct drm_display_mode default_mode = {
>> +	.clock = 47250,
>> +	.hdisplay = 1024,
>> +	.hsync_start = 1024 + 46,
>> +	.hsync_end = 1024 + 46 + 80,
>> +	.htotal = 1024 + 46 + 80 + 100,
>> +	.vdisplay = 600,
>> +	.vsync_start = 600 + 5,
>> +	.vsync_end = 600 + 5 + 5,
>> +	.vtotal = 600 + 5 + 5 + 20,
>> +	.flags = DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC,
>> +};
>> +
>> +static int tdo_tl070wsh30_panel_get_modes(struct drm_panel *panel,
>> +				       struct drm_connector *connector)
>> +{
>> +	struct drm_display_mode *mode;
>> +
>> +	mode = drm_mode_duplicate(connector->dev, &default_mode);
>> +	if (!mode) {
>> +		dev_err(panel->dev, "failed to add mode %ux%ux\n", default_mode.hdisplay,
>> +			default_mode.vdisplay);
> Here we often print the refresh rate too.
> If there is no need for the refresh rate than at least drop the extra
> 'x' at the end of the line.

I forgot to remove it after vrefresh removal, but I'll prefer adding back
drm_mode_vrefresh() and the refresh.

> 
>> +		return -ENOMEM;
>> +	}
>> +
>> +	drm_mode_set_name(mode);
>> +
>> +	drm_mode_probed_add(connector, mode);
>> +
>> +	connector->display_info.width_mm = 154;
>> +	connector->display_info.height_mm = 85;
>> +	connector->display_info.bpc = 8;
>> +
>> +	return 1;
>> +}
>> +
>> +static const struct drm_panel_funcs tdo_tl070wsh30_panel_funcs = {
>> +	.unprepare = tdo_tl070wsh30_panel_unprepare,
>> +	.prepare = tdo_tl070wsh30_panel_prepare,
>> +	.get_modes = tdo_tl070wsh30_panel_get_modes,
>> +};
>> +
>> +static const struct of_device_id tdo_tl070wsh30_of_match[] = {
>> +	{ .compatible = "tdo,tl070wsh30", },
>> +	{ }
> I often recommends
> 	{ /* sentinel },
> 
> but thats just to be consistent with what I see in other drivers.

Let it be consistent.

> 
>> +};
>> +MODULE_DEVICE_TABLE(of, tdo_tl070wsh30_of_match);
>> +
>> +static int tdo_tl070wsh30_panel_add(struct tdo_tl070wsh30_panel *tdo_tl070wsh30)
>> +{
>> +	struct device *dev = &tdo_tl070wsh30->link->dev;
>> +	int err;
>> +
>> +	tdo_tl070wsh30->supply = devm_regulator_get(dev, "power");
>> +	if (IS_ERR(tdo_tl070wsh30->supply))
>> +		return PTR_ERR(tdo_tl070wsh30->supply);
>> +
>> +	tdo_tl070wsh30->reset_gpio = devm_gpiod_get(dev, "reset",
>> +						  GPIOD_OUT_LOW);
>> +	if (IS_ERR(tdo_tl070wsh30->reset_gpio)) {
>> +		err = PTR_ERR(tdo_tl070wsh30->reset_gpio);
>> +		dev_dbg(dev, "failed to get reset gpio: %d\n", err);
>> +		return err;
>> +	}
>> +
>> +	drm_panel_init(&tdo_tl070wsh30->base, &tdo_tl070wsh30->link->dev,
>> +		       &tdo_tl070wsh30_panel_funcs, DRM_MODE_CONNECTOR_DSI);
>> +
>> +	err = drm_panel_of_backlight(&tdo_tl070wsh30->base);
>> +	if (err)
>> +		return err;
> 
> 
> 
>> +
>> +	err = regulator_enable(tdo_tl070wsh30->supply);
>> +	if (err < 0)
>> +		return err;
>> +
>> +	usleep_range(10000, 11000);
>> +
>> +	gpiod_set_value_cansleep(tdo_tl070wsh30->reset_gpio, 1);
>> +
>> +	usleep_range(10000, 11000);
>> +
>> +	gpiod_set_value_cansleep(tdo_tl070wsh30->reset_gpio, 0);
>> +
>> +	msleep(200);
>> +
> 
> It is the job of the prepare function to turn on the panel,
> and likewise the unprepare to turn off the panel.
> Please move the code above to the prepare function.

Moved

> 
> 
>> +	drm_panel_add(&tdo_tl070wsh30->base);
>> +
>> +	return 0;
>> +}
>> +
>> +static void tdo_tl070wsh30_panel_del(struct tdo_tl070wsh30_panel *tdo_tl070wsh30)
>> +{
>> +	drm_panel_remove(&tdo_tl070wsh30->base);
>> +}
> This helper does not gain anything - call drm_panel_remove() direct.

Removed

> 
>> +
>> +static int tdo_tl070wsh30_panel_probe(struct mipi_dsi_device *dsi)
>> +{
>> +	struct tdo_tl070wsh30_panel *tdo_tl070wsh30;
>> +	int err;
>> +
>> +	dsi->lanes = 4;
>> +	dsi->format = MIPI_DSI_FMT_RGB888;
>> +	dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_BURST | MIPI_DSI_MODE_LPM;
>> +
>> +	tdo_tl070wsh30 = devm_kzalloc(&dsi->dev, sizeof(*tdo_tl070wsh30),
>> +				    GFP_KERNEL);
>> +	if (!tdo_tl070wsh30)
>> +		return -ENOMEM;
>> +
>> +	mipi_dsi_set_drvdata(dsi, tdo_tl070wsh30);
>> +	tdo_tl070wsh30->link = dsi;
>> +
>> +	err = tdo_tl070wsh30_panel_add(tdo_tl070wsh30);
>> +	if (err < 0)
>> +		return err;
>> +
>> +	return mipi_dsi_attach(dsi);
>> +}
>> +
>> +static int tdo_tl070wsh30_panel_remove(struct mipi_dsi_device *dsi)
>> +{
>> +	struct tdo_tl070wsh30_panel *tdo_tl070wsh30 = mipi_dsi_get_drvdata(dsi);
>> +	int err;
>> +
>> +	err = drm_panel_unprepare(&tdo_tl070wsh30->base);
>> +	if (err < 0)
>> +		dev_err(&dsi->dev, "failed to unprepare panel: %d\n", err);
>> +
>> +	err = drm_panel_disable(&tdo_tl070wsh30->base);
>> +	if (err < 0)
>> +		dev_err(&dsi->dev, "failed to disable panel: %d\n", err);
>> +
> In most panel drivers we just ignore the return results here.

Ok

> 
>> +	err = mipi_dsi_detach(dsi);
>> +	if (err < 0)
>> +		dev_err(&dsi->dev, "failed to detach from DSI host: %d\n", err);
>> +
>> +	tdo_tl070wsh30_panel_del(tdo_tl070wsh30);
>> +
>> +	return 0;
>> +}
>> +
>> +static void tdo_tl070wsh30_panel_shutdown(struct mipi_dsi_device *dsi)
>> +{
>> +	struct tdo_tl070wsh30_panel *tdo_tl070wsh30 = mipi_dsi_get_drvdata(dsi);
>> +
>> +	drm_panel_unprepare(&tdo_tl070wsh30->base);
>> +	drm_panel_disable(&tdo_tl070wsh30->base);
> This is the wrong order. disable before unpreapre.
> 
> 
> I am not sure what is right here - but I see some drivers that only have
> the disable() + unprepare() in their shutdown() method and then the
> remocal in their remove() function.
> That makes sense with this split but I have not looked too deep into it.

No prob, I aligned with panel-simple here.

> 
>> +}
>> +
>> +static struct mipi_dsi_driver tdo_tl070wsh30_panel_driver = {
>> +	.driver = {
>> +		.name = "panel-tdo-tl070wsh30",
>> +		.of_match_table = tdo_tl070wsh30_of_match,
>> +	},
>> +	.probe = tdo_tl070wsh30_panel_probe,
>> +	.remove = tdo_tl070wsh30_panel_remove,
>> +	.shutdown = tdo_tl070wsh30_panel_shutdown,
>> +};
>> +module_mipi_dsi_driver(tdo_tl070wsh30_panel_driver);
>> +
>> +MODULE_AUTHOR("Neil Armstrong <narmstrong@baylibre.com>");
>> +MODULE_DESCRIPTION("TDO TL070WSH30 panel driver");
>> +MODULE_LICENSE("GPL v2");
>> -- 
>> 2.22.0
>>
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/dri-devel

Thanks,
Neil
