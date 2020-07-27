Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A1F4C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 20:32:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77FF120759
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 20:32:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729211AbgG0UcI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 16:32:08 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:43000 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbgG0UcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 16:32:07 -0400
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id E258B8048A;
        Mon, 27 Jul 2020 22:31:59 +0200 (CEST)
Date:   Mon, 27 Jul 2020 22:31:58 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
        od@zcrc.me, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] drm/bridge: Add SPI DBI host driver
Message-ID: <20200727203158.GA1016751@ravnborg.org>
References: <20200727164613.19744-1-paul@crapouillou.net>
 <20200727164613.19744-4-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200727164613.19744-4-paul@crapouillou.net>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=aP3eV41m c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=8nJEP1OIZ-IA:10 a=ER_8r6IbAAAA:8 a=7X9hF7tqX14c7ykuo-AA:9
        a=wPNLvfGTeEIA:10 a=9LHmKk7ezEChjTCyhBa9:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul.

On Mon, Jul 27, 2020 at 06:46:10PM +0200, Paul Cercueil wrote:
> This driver will register a DBI host driver for panels connected over
> SPI.
So this is actually a MIPI DBI host driver.

I personally would love to have added mipi_ in the names - to make it
all more explicit.
But maybe that just because I get confused on all the acronyms.


Some details in the following. Will try to find some more time so I can
grasp the full picture. The following was just my low-level notes for
now.

	Sam
> 
> DBI types c1 and c3 are supported. C1 is a SPI protocol with 9 bits per
> word, with the data/command information in the 9th (MSB) bit. C3 is a
> SPI protocol with 8 bits per word, with the data/command information
> carried by a separate GPIO.

We did not have any define to distingush between DBI_C1 and DBI_c3:
+/* MIPI bus types */
+#define MIPI_DEVICE_TYPE_DSI           BIT(0)
+#define MIPI_DEVICE_TYPE_DBI_SPI_MODE1 BIT(1)
+#define MIPI_DEVICE_TYPE_DBI_SPI_MODE2 BIT(2)
+#define MIPI_DEVICE_TYPE_DBI_SPI_MODE3 BIT(3)
+#define MIPI_DEVICE_TYPE_DBI_M6800     BIT(4)
+#define MIPI_DEVICE_TYPE_DBI_I8080     BIT(5)

Is this on purpose?
I had assumed the host should tell what it supports and the device should
tell what it wanted.
So if the host did not support DBI_C3 and device wants it - then we
could give up early.

> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  drivers/gpu/drm/bridge/Kconfig   |   8 +
>  drivers/gpu/drm/bridge/Makefile  |   1 +
>  drivers/gpu/drm/bridge/dbi-spi.c | 261 +++++++++++++++++++++++++++++++
This is no bridge driver - so does not belong in the bridge
directory.
gpu/drm/drm_mipi_dbi_spi.c?

>  3 files changed, 270 insertions(+)
>  create mode 100644 drivers/gpu/drm/bridge/dbi-spi.c
> 
> diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
> index c7f0dacfb57a..ed38366847c1 100644
> --- a/drivers/gpu/drm/bridge/Kconfig
> +++ b/drivers/gpu/drm/bridge/Kconfig
> @@ -219,6 +219,14 @@ config DRM_TI_TPD12S015
>  	  Texas Instruments TPD12S015 HDMI level shifter and ESD protection
>  	  driver.
>  
> +config DRM_MIPI_DBI_SPI
> +	tristate "SPI host support for MIPI DBI"
> +	depends on OF && SPI
> +	select DRM_MIPI_DSI
> +	select DRM_MIPI_DBI
> +	help
> +	  Driver to support DBI over SPI.
> +
>  source "drivers/gpu/drm/bridge/analogix/Kconfig"
>  
>  source "drivers/gpu/drm/bridge/adv7511/Kconfig"
> diff --git a/drivers/gpu/drm/bridge/Makefile b/drivers/gpu/drm/bridge/Makefile
> index 7d7c123a95e4..c2c522c2774f 100644
> --- a/drivers/gpu/drm/bridge/Makefile
> +++ b/drivers/gpu/drm/bridge/Makefile
> @@ -20,6 +20,7 @@ obj-$(CONFIG_DRM_I2C_ADV7511) += adv7511/
>  obj-$(CONFIG_DRM_TI_SN65DSI86) += ti-sn65dsi86.o
>  obj-$(CONFIG_DRM_TI_TFP410) += ti-tfp410.o
>  obj-$(CONFIG_DRM_TI_TPD12S015) += ti-tpd12s015.o
> +obj-$(CONFIG_DRM_MIPI_DBI_SPI) += dbi-spi.o
mipi_dbi_spi.o would be nice...

>  obj-$(CONFIG_DRM_NWL_MIPI_DSI) += nwl-dsi.o
>  
>  obj-y += analogix/
> diff --git a/drivers/gpu/drm/bridge/dbi-spi.c b/drivers/gpu/drm/bridge/dbi-spi.c
> new file mode 100644
> index 000000000000..1060b8f95fba
> --- /dev/null
> +++ b/drivers/gpu/drm/bridge/dbi-spi.c
> @@ -0,0 +1,261 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * MIPI Display Bus Interface (DBI) SPI support
> + *
> + * Copyright 2016 Noralf Trønnes
> + * Copyright 2020 Paul Cercueil <paul@crapouillou.net>
> + */
> +
> +#include <linux/gpio/consumer.h>
> +#include <linux/module.h>
> +#include <linux/spi/spi.h>
> +
> +#include <drm/drm_mipi_dbi.h>
> +#include <drm/drm_mipi_dsi.h>
> +
> +#include <video/mipi_display.h>
> +
> +struct dbi_spi {
> +	struct mipi_dsi_host host;
It is very confusing that the mipi_dbi_spi driver uses a dsi_host.
It clashes in my head - and then reviewing it not easy.

> +	struct mipi_dsi_host_ops host_ops;
const?
> +
> +	struct spi_device *spi;
> +	struct gpio_desc *dc;
> +	struct mutex cmdlock;
> +
> +	unsigned int current_bus_type;
> +
> +	/**
> +	 * @tx_buf9: Buffer used for Option 1 9-bit conversion
> +	 */
> +	void *tx_buf9;
> +
> +	/**
> +	 * @tx_buf9_len: Size of tx_buf9.
> +	 */
> +	size_t tx_buf9_len;
> +};
> +
> +static inline struct dbi_spi *host_to_dbi_spi(struct mipi_dsi_host *host)
> +{
> +	return container_of(host, struct dbi_spi, host);
> +}
> +
> +static ssize_t dbi_spi1_transfer(struct mipi_dsi_host *host,
> +				 const struct mipi_dsi_msg *msg)
> +{
> +	struct dbi_spi *dbi = host_to_dbi_spi(host);
> +	struct spi_device *spi = dbi->spi;
> +	struct spi_transfer tr = {
> +		.bits_per_word = 9,
> +	};
> +	const u8 *src8 = msg->tx_buf;
> +	struct spi_message m;
> +	size_t max_chunk, chunk;
> +	size_t len = msg->tx_len;
> +	bool cmd_byte = true;
> +	unsigned int i;
> +	u16 *dst16;
> +	int ret;
> +
> +	tr.speed_hz = mipi_dbi_spi_cmd_max_speed(spi, len);
> +	dst16 = dbi->tx_buf9;
> +
> +	max_chunk = min(dbi->tx_buf9_len / 2, len);
Hmm, this looks not right. We limit the max_chunk to 8K here.
We learned the other day that we count in bytes.
OR did I miss something?

> +
> +	spi_message_init_with_transfers(&m, &tr, 1);
> +	tr.tx_buf = dst16;
> +
> +	while (len) {
> +		chunk = min(len, max_chunk);
> +
> +		for (i = 0; i < chunk; i++) {
> +			dst16[i] = *src8++;
> +
> +			/* Bit 9: 0 means command, 1 means data */
> +			if (!cmd_byte)
> +				dst16[i] |= BIT(9);
> +
> +			cmd_byte = false;
> +		}
> +
> +		tr.len = chunk * 2;
> +		len -= chunk;
> +
> +		ret = spi_sync(spi, &m);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static ssize_t dbi_spi3_transfer(struct mipi_dsi_host *host,
> +				 const struct mipi_dsi_msg *msg)
> +{
> +	struct dbi_spi *dbi = host_to_dbi_spi(host);
> +	struct spi_device *spi = dbi->spi;
> +	const u8 *buf = msg->tx_buf;
> +	unsigned int bpw = 8;
> +	u32 speed_hz;
> +	ssize_t ret;
> +
> +	/* for now we only support sending messages, not receiving */
> +	if (msg->rx_len)
> +		return -EINVAL;
> +
> +	gpiod_set_value_cansleep(dbi->dc, 0);
> +
> +	speed_hz = mipi_dbi_spi_cmd_max_speed(spi, 1);
> +	ret = mipi_dbi_spi_transfer(spi, speed_hz, 8, buf, 1);
> +	if (ret || msg->tx_len == 1)
> +		return ret;
> +
> +	if (buf[0] == MIPI_DCS_WRITE_MEMORY_START)
> +		bpw = 16;
> +
> +	gpiod_set_value_cansleep(dbi->dc, 1);
> +	speed_hz = mipi_dbi_spi_cmd_max_speed(spi, msg->tx_len - 1);
> +
> +	ret = mipi_dbi_spi_transfer(spi, speed_hz, bpw,
> +				    &buf[1], msg->tx_len - 1);
> +	if (ret)
> +		return ret;
> +
> +	return msg->tx_len;
> +}
> +
> +static ssize_t dbi_spi_transfer(struct mipi_dsi_host *host,
> +				const struct mipi_dsi_msg *msg)
> +{
> +	struct dbi_spi *dbi = host_to_dbi_spi(host);
> +
> +	switch (dbi->current_bus_type) {
> +	case MIPI_DEVICE_TYPE_DBI_SPI_MODE1:
> +		return dbi_spi1_transfer(host, msg);
> +	case MIPI_DEVICE_TYPE_DBI_SPI_MODE3:
> +		return dbi_spi3_transfer(host, msg);
> +	default:
> +		dev_err(&dbi->spi->dev, "Unknown transfer type\n");
> +		return -EINVAL;
> +	}
> +}
> +
> +static int dbi_spi_attach(struct mipi_dsi_host *host,
> +			  struct mipi_dsi_device *dsi)
> +{
> +	struct dbi_spi *dbi = host_to_dbi_spi(host);
> +
> +	dbi->current_bus_type = dsi->bus_type;
> +
> +	if (dbi->current_bus_type == MIPI_DEVICE_TYPE_DBI_SPI_MODE1) {
> +		dbi->tx_buf9_len = SZ_16K;
> +
> +		dbi->tx_buf9 = kmalloc(dbi->tx_buf9_len, GFP_KERNEL);
> +		if (!dbi->tx_buf9)
> +			return -ENOMEM;
> +	}
> +
> +	return 0;
> +}
> +
> +static int dbi_spi_detach(struct mipi_dsi_host *host,
> +			  struct mipi_dsi_device *dsi)
> +{
> +	struct dbi_spi *dbi = host_to_dbi_spi(host);
> +
> +	kfree(dbi->tx_buf9);
> +	dbi->tx_buf9_len = 0;
> +
> +	return 0; /* Nothing to do */
> +}
> +
> +static void dbi_spi_host_unregister(void *d)
> +{
> +	mipi_dsi_host_unregister(d);
> +}
> +
> +static int dbi_spi_probe(struct spi_device *spi)
> +{
> +	struct device *dev = &spi->dev;
> +	struct mipi_dsi_device_info info = { };
> +	struct mipi_dsi_device *dsi;
> +	struct dbi_spi *dbi;
> +	int ret;
> +
> +	dbi = devm_kzalloc(dev, sizeof(*dbi), GFP_KERNEL);
> +	if (!dbi)
> +		return -ENOMEM;
> +
> +	dbi->host.dev = dev;
> +	dbi->host.ops = &dbi->host_ops;
> +	dbi->spi = spi;
> +	spi_set_drvdata(spi, dbi);
> +
> +	dbi->dc = devm_gpiod_get_optional(dev, "dc", GPIOD_OUT_LOW);
> +	if (IS_ERR(dbi->dc)) {
> +		dev_err(dev, "Failed to get gpio 'dc'\n");
> +		return PTR_ERR(dbi->dc);
> +	}
> +
> +	if (spi_is_bpw_supported(spi, 9))
> +		dbi->host.bus_types |= MIPI_DEVICE_TYPE_DBI_SPI_MODE1;
> +	if (dbi->dc)
> +		dbi->host.bus_types |= MIPI_DEVICE_TYPE_DBI_SPI_MODE3;
> +
> +	if (!dbi->host.bus_types) {
> +		dev_err(dev, "Neither Type1 nor Type3 are supported\n");
> +		return -EINVAL;
> +	}
> +
> +	dbi->host_ops.transfer = dbi_spi_transfer;
> +	dbi->host_ops.attach = dbi_spi_attach;
> +	dbi->host_ops.detach = dbi_spi_detach;
> +
> +	mutex_init(&dbi->cmdlock);
> +
> +	ret = mipi_dsi_host_register(&dbi->host);
> +	if (ret) {
> +		dev_err(dev, "Unable to register DSI host\n");
> +		return ret;
> +	}
> +
> +	ret = devm_add_action_or_reset(dev, dbi_spi_host_unregister, &dbi->host);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Register our own node as a MIPI DSI device.
> +	 * This ensures that the panel driver will be probed.
> +	 */
> +	info.channel = 0;
> +	info.node = of_node_get(dev->of_node);
> +
> +	dsi = mipi_dsi_device_register_full(&dbi->host, &info);
> +	if (IS_ERR(dsi)) {
> +		dev_err(dev, "Failed to add DSI device\n");
> +		return PTR_ERR(dsi);
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id dbi_spi_of_match[] = {
> +	{ .compatible = "adafruit,yx240qv29" },
> +	{ .compatible = "leadtek,ltk035c5444t-spi" },
> +	{ }
Would it be better with a fall-back compatible like:
mipi,dbi-spi.
So the nodes must includes this compatible to be registered with
this driver?

> +};
> +MODULE_DEVICE_TABLE(of, dbi_spi_of_match);
> +
> +static struct spi_driver dbi_spi_driver = {
> +	.driver = {
> +		.name = "dbi-spi",
> +		.of_match_table = dbi_spi_of_match,
> +	},
> +	.probe = dbi_spi_probe,
> +};
> +module_spi_driver(dbi_spi_driver);
> +
> +MODULE_DESCRIPTION("DBI SPI bus driver");
> +MODULE_AUTHOR("Paul Cercueil <paul@crapouillou.net>");
> +MODULE_LICENSE("GPL");
> -- 
> 2.27.0
