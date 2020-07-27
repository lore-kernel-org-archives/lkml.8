Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 122B4C433E5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 18:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEA99207FC
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 18:03:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="VdgLz7qb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730322AbgG0SD4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 14:03:56 -0400
Received: from crapouillou.net ([89.234.176.41]:39880 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728313AbgG0SDz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 14:03:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1595873032; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+4C4GzR18AIe9cjQjP0708WVWejC/aKyzBgrtwhGm98=;
        b=VdgLz7qb/6UA7++JuErzDz5cDShB0gFhN+CfZlEXJ+lmIsPF3dm0B9zSNo59u3DPhxualL
        eGtujYoJfbHWWV5xVb2hbGcTdIKk6KO9tCHrX4ujUHZd+yFwJymy+O8gB5IfwKjQ6Sh3sj
        PDLmTWLiN5Q1Xn9XYt/KwojX89aKKjk=
Date:   Mon, 27 Jul 2020 19:54:13 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 3/6] drm/bridge: Add SPI DBI host driver
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Noralf =?iso-8859-1?q?Tr=F8nnes?= <noralf@tronnes.org>,
        od@zcrc.me, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <D235EQ.3HLG82ZFRC5C3@crapouillou.net>
In-Reply-To: <20200727170638.GG17521@pendragon.ideasonboard.com>
References: <20200727164613.19744-1-paul@crapouillou.net>
        <20200727164613.19744-4-paul@crapouillou.net>
        <20200727170638.GG17521@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

Le lun. 27 juil. 2020 =E0 20:06, Laurent Pinchart=20
<laurent.pinchart@ideasonboard.com> a =E9crit :
> Hi Paul,
>=20
> Thank you for the patch.
>=20
> On Mon, Jul 27, 2020 at 06:46:10PM +0200, Paul Cercueil wrote:
>>  This driver will register a DBI host driver for panels connected=20
>> over
>>  SPI.
>>=20
>>  DBI types c1 and c3 are supported. C1 is a SPI protocol with 9 bits=20
>> per
>>  word, with the data/command information in the 9th (MSB) bit. C3 is=20
>> a
>>  SPI protocol with 8 bits per word, with the data/command information
>>  carried by a separate GPIO.
>>=20
>>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>  ---
>>   drivers/gpu/drm/bridge/Kconfig   |   8 +
>>   drivers/gpu/drm/bridge/Makefile  |   1 +
>>   drivers/gpu/drm/bridge/dbi-spi.c | 261=20
>> +++++++++++++++++++++++++++++++
>>   3 files changed, 270 insertions(+)
>>   create mode 100644 drivers/gpu/drm/bridge/dbi-spi.c
>>=20
>>  diff --git a/drivers/gpu/drm/bridge/Kconfig=20
>> b/drivers/gpu/drm/bridge/Kconfig
>>  index c7f0dacfb57a..ed38366847c1 100644
>>  --- a/drivers/gpu/drm/bridge/Kconfig
>>  +++ b/drivers/gpu/drm/bridge/Kconfig
>>  @@ -219,6 +219,14 @@ config DRM_TI_TPD12S015
>>   	  Texas Instruments TPD12S015 HDMI level shifter and ESD=20
>> protection
>>   	  driver.
>>=20
>>  +config DRM_MIPI_DBI_SPI
>>  +	tristate "SPI host support for MIPI DBI"
>>  +	depends on OF && SPI
>>  +	select DRM_MIPI_DSI
>>  +	select DRM_MIPI_DBI
>>  +	help
>>  +	  Driver to support DBI over SPI.
>>  +
>>   source "drivers/gpu/drm/bridge/analogix/Kconfig"
>>=20
>>   source "drivers/gpu/drm/bridge/adv7511/Kconfig"
>>  diff --git a/drivers/gpu/drm/bridge/Makefile=20
>> b/drivers/gpu/drm/bridge/Makefile
>>  index 7d7c123a95e4..c2c522c2774f 100644
>>  --- a/drivers/gpu/drm/bridge/Makefile
>>  +++ b/drivers/gpu/drm/bridge/Makefile
>>  @@ -20,6 +20,7 @@ obj-$(CONFIG_DRM_I2C_ADV7511) +=3D adv7511/
>>   obj-$(CONFIG_DRM_TI_SN65DSI86) +=3D ti-sn65dsi86.o
>>   obj-$(CONFIG_DRM_TI_TFP410) +=3D ti-tfp410.o
>>   obj-$(CONFIG_DRM_TI_TPD12S015) +=3D ti-tpd12s015.o
>>  +obj-$(CONFIG_DRM_MIPI_DBI_SPI) +=3D dbi-spi.o
>>   obj-$(CONFIG_DRM_NWL_MIPI_DSI) +=3D nwl-dsi.o
>>=20
>>   obj-y +=3D analogix/
>>  diff --git a/drivers/gpu/drm/bridge/dbi-spi.c=20
>> b/drivers/gpu/drm/bridge/dbi-spi.c
>>  new file mode 100644
>>  index 000000000000..1060b8f95fba
>>  --- /dev/null
>>  +++ b/drivers/gpu/drm/bridge/dbi-spi.c
>>  @@ -0,0 +1,261 @@
>>  +// SPDX-License-Identifier: GPL-2.0-or-later
>>  +/*
>>  + * MIPI Display Bus Interface (DBI) SPI support
>>  + *
>>  + * Copyright 2016 Noralf Tr=F8nnes
>>  + * Copyright 2020 Paul Cercueil <paul@crapouillou.net>
>>  + */
>>  +
>>  +#include <linux/gpio/consumer.h>
>>  +#include <linux/module.h>
>>  +#include <linux/spi/spi.h>
>>  +
>>  +#include <drm/drm_mipi_dbi.h>
>>  +#include <drm/drm_mipi_dsi.h>
>>  +
>>  +#include <video/mipi_display.h>
>>  +
>>  +struct dbi_spi {
>>  +	struct mipi_dsi_host host;
>>  +	struct mipi_dsi_host_ops host_ops;
>>  +
>>  +	struct spi_device *spi;
>>  +	struct gpio_desc *dc;
>>  +	struct mutex cmdlock;
>>  +
>>  +	unsigned int current_bus_type;
>>  +
>>  +	/**
>>  +	 * @tx_buf9: Buffer used for Option 1 9-bit conversion
>>  +	 */
>>  +	void *tx_buf9;
>>  +
>>  +	/**
>>  +	 * @tx_buf9_len: Size of tx_buf9.
>>  +	 */
>>  +	size_t tx_buf9_len;
>>  +};
>>  +
>>  +static inline struct dbi_spi *host_to_dbi_spi(struct mipi_dsi_host=20
>> *host)
>>  +{
>>  +	return container_of(host, struct dbi_spi, host);
>>  +}
>>  +
>>  +static ssize_t dbi_spi1_transfer(struct mipi_dsi_host *host,
>>  +				 const struct mipi_dsi_msg *msg)
>>  +{
>>  +	struct dbi_spi *dbi =3D host_to_dbi_spi(host);
>>  +	struct spi_device *spi =3D dbi->spi;
>>  +	struct spi_transfer tr =3D {
>>  +		.bits_per_word =3D 9,
>>  +	};
>>  +	const u8 *src8 =3D msg->tx_buf;
>>  +	struct spi_message m;
>>  +	size_t max_chunk, chunk;
>>  +	size_t len =3D msg->tx_len;
>>  +	bool cmd_byte =3D true;
>>  +	unsigned int i;
>>  +	u16 *dst16;
>>  +	int ret;
>>  +
>>  +	tr.speed_hz =3D mipi_dbi_spi_cmd_max_speed(spi, len);
>>  +	dst16 =3D dbi->tx_buf9;
>>  +
>>  +	max_chunk =3D min(dbi->tx_buf9_len / 2, len);
>>  +
>>  +	spi_message_init_with_transfers(&m, &tr, 1);
>>  +	tr.tx_buf =3D dst16;
>>  +
>>  +	while (len) {
>>  +		chunk =3D min(len, max_chunk);
>>  +
>>  +		for (i =3D 0; i < chunk; i++) {
>>  +			dst16[i] =3D *src8++;
>>  +
>>  +			/* Bit 9: 0 means command, 1 means data */
>>  +			if (!cmd_byte)
>>  +				dst16[i] |=3D BIT(9);
>>  +
>>  +			cmd_byte =3D false;
>>  +		}
>>  +
>>  +		tr.len =3D chunk * 2;
>>  +		len -=3D chunk;
>>  +
>>  +		ret =3D spi_sync(spi, &m);
>>  +		if (ret)
>>  +			return ret;
>>  +	}
>>  +
>>  +	return 0;
>>  +}
>>  +
>>  +static ssize_t dbi_spi3_transfer(struct mipi_dsi_host *host,
>>  +				 const struct mipi_dsi_msg *msg)
>>  +{
>>  +	struct dbi_spi *dbi =3D host_to_dbi_spi(host);
>>  +	struct spi_device *spi =3D dbi->spi;
>>  +	const u8 *buf =3D msg->tx_buf;
>>  +	unsigned int bpw =3D 8;
>>  +	u32 speed_hz;
>>  +	ssize_t ret;
>>  +
>>  +	/* for now we only support sending messages, not receiving */
>>  +	if (msg->rx_len)
>>  +		return -EINVAL;
>>  +
>>  +	gpiod_set_value_cansleep(dbi->dc, 0);
>>  +
>>  +	speed_hz =3D mipi_dbi_spi_cmd_max_speed(spi, 1);
>>  +	ret =3D mipi_dbi_spi_transfer(spi, speed_hz, 8, buf, 1);
>>  +	if (ret || msg->tx_len =3D=3D 1)
>>  +		return ret;
>>  +
>>  +	if (buf[0] =3D=3D MIPI_DCS_WRITE_MEMORY_START)
>>  +		bpw =3D 16;
>>  +
>>  +	gpiod_set_value_cansleep(dbi->dc, 1);
>>  +	speed_hz =3D mipi_dbi_spi_cmd_max_speed(spi, msg->tx_len - 1);
>>  +
>>  +	ret =3D mipi_dbi_spi_transfer(spi, speed_hz, bpw,
>>  +				    &buf[1], msg->tx_len - 1);
>>  +	if (ret)
>>  +		return ret;
>>  +
>>  +	return msg->tx_len;
>>  +}
>>  +
>>  +static ssize_t dbi_spi_transfer(struct mipi_dsi_host *host,
>>  +				const struct mipi_dsi_msg *msg)
>>  +{
>>  +	struct dbi_spi *dbi =3D host_to_dbi_spi(host);
>>  +
>>  +	switch (dbi->current_bus_type) {
>>  +	case MIPI_DEVICE_TYPE_DBI_SPI_MODE1:
>>  +		return dbi_spi1_transfer(host, msg);
>>  +	case MIPI_DEVICE_TYPE_DBI_SPI_MODE3:
>>  +		return dbi_spi3_transfer(host, msg);
>>  +	default:
>>  +		dev_err(&dbi->spi->dev, "Unknown transfer type\n");
>>  +		return -EINVAL;
>>  +	}
>>  +}
>>  +
>>  +static int dbi_spi_attach(struct mipi_dsi_host *host,
>>  +			  struct mipi_dsi_device *dsi)
>>  +{
>>  +	struct dbi_spi *dbi =3D host_to_dbi_spi(host);
>>  +
>>  +	dbi->current_bus_type =3D dsi->bus_type;
>>  +
>>  +	if (dbi->current_bus_type =3D=3D MIPI_DEVICE_TYPE_DBI_SPI_MODE1) {
>>  +		dbi->tx_buf9_len =3D SZ_16K;
>>  +
>>  +		dbi->tx_buf9 =3D kmalloc(dbi->tx_buf9_len, GFP_KERNEL);
>>  +		if (!dbi->tx_buf9)
>>  +			return -ENOMEM;
>>  +	}
>>  +
>>  +	return 0;
>>  +}
>>  +
>>  +static int dbi_spi_detach(struct mipi_dsi_host *host,
>>  +			  struct mipi_dsi_device *dsi)
>>  +{
>>  +	struct dbi_spi *dbi =3D host_to_dbi_spi(host);
>>  +
>>  +	kfree(dbi->tx_buf9);
>>  +	dbi->tx_buf9_len =3D 0;
>>  +
>>  +	return 0; /* Nothing to do */
>>  +}
>>  +
>>  +static void dbi_spi_host_unregister(void *d)
>>  +{
>>  +	mipi_dsi_host_unregister(d);
>>  +}
>>  +
>>  +static int dbi_spi_probe(struct spi_device *spi)
>>  +{
>>  +	struct device *dev =3D &spi->dev;
>>  +	struct mipi_dsi_device_info info =3D { };
>>  +	struct mipi_dsi_device *dsi;
>>  +	struct dbi_spi *dbi;
>>  +	int ret;
>>  +
>>  +	dbi =3D devm_kzalloc(dev, sizeof(*dbi), GFP_KERNEL);
>>  +	if (!dbi)
>>  +		return -ENOMEM;
>>  +
>>  +	dbi->host.dev =3D dev;
>>  +	dbi->host.ops =3D &dbi->host_ops;
>>  +	dbi->spi =3D spi;
>>  +	spi_set_drvdata(spi, dbi);
>>  +
>>  +	dbi->dc =3D devm_gpiod_get_optional(dev, "dc", GPIOD_OUT_LOW);
>>  +	if (IS_ERR(dbi->dc)) {
>>  +		dev_err(dev, "Failed to get gpio 'dc'\n");
>>  +		return PTR_ERR(dbi->dc);
>>  +	}
>>  +
>>  +	if (spi_is_bpw_supported(spi, 9))
>>  +		dbi->host.bus_types |=3D MIPI_DEVICE_TYPE_DBI_SPI_MODE1;
>>  +	if (dbi->dc)
>>  +		dbi->host.bus_types |=3D MIPI_DEVICE_TYPE_DBI_SPI_MODE3;
>>  +
>>  +	if (!dbi->host.bus_types) {
>>  +		dev_err(dev, "Neither Type1 nor Type3 are supported\n");
>>  +		return -EINVAL;
>>  +	}
>>  +
>>  +	dbi->host_ops.transfer =3D dbi_spi_transfer;
>>  +	dbi->host_ops.attach =3D dbi_spi_attach;
>>  +	dbi->host_ops.detach =3D dbi_spi_detach;
>>  +
>>  +	mutex_init(&dbi->cmdlock);
>>  +
>>  +	ret =3D mipi_dsi_host_register(&dbi->host);
>>  +	if (ret) {
>>  +		dev_err(dev, "Unable to register DSI host\n");
>>  +		return ret;
>>  +	}
>>  +
>>  +	ret =3D devm_add_action_or_reset(dev, dbi_spi_host_unregister,=20
>> &dbi->host);
>>  +	if (ret)
>>  +		return ret;
>>  +
>>  +	/*
>>  +	 * Register our own node as a MIPI DSI device.
>>  +	 * This ensures that the panel driver will be probed.
>>  +	 */
>>  +	info.channel =3D 0;
>>  +	info.node =3D of_node_get(dev->of_node);
>>  +
>>  +	dsi =3D mipi_dsi_device_register_full(&dbi->host, &info);
>=20
> Two devices for the same OF node is asking for trouble :-S

There is nothing that prevents you from doing that, and it's been done=20
before (on Ingenic SoCs we have one DT node shared by 3 drivers).

> Looking at the other patches in this series, it seems that what you=20
> need
> from the DSI framework is DCS. I think we should then extract the DCS
> support to mipi_dcs_* functions, with two different backends, one for
> DSI and one for DBI. That way you will be able to support DBI panels
> with a single driver instead of splutting the support between two
> drivers (this one and the corresponding mipi_dsi_driver's).

Then that would be five different backends, one for DSI, one for=20
DBI/i8080, one for DBI/m68k, one for DBI/spi9, one for DBI/spi+gpio.=20
Without the SPI/DBI bridge, your panel driver then has to support=20
probing from two different buses, as a mipi_dsi_driver, and as a=20
mipi_spi_driver, if you want to support both interfaces. That moves a=20
lot of the complexity to the panel driver itself. Besides, to transform=20
the spi_device to a mipi_dsi_device that the driver manipulates,=20
wouldn't the shared code need to register a new DSI device with a=20
SPI-to-DBI host anyway? The only difference is that it wouldn't be done=20
in a separate driver.

So I fail to see how that would work better. A shared node may look=20
scary but I think it's the cleanest solution.

As for backends: Having mipi_dcs_* functions with different backends=20
wouldn't really work either, because that assumes that DSI and DBI are=20
completely different buses. But one controller can very well support=20
both DSI and DBI/i8080, and as such one "DCS host driver" should be=20
able to support both. So the distinction should be made within the host=20
drivers, which should present a unified DCS API. This is basically what=20
this patchset does but with the current DSI API as the "unified DCS=20
API".

-Paul

>=20
>>  +	if (IS_ERR(dsi)) {
>>  +		dev_err(dev, "Failed to add DSI device\n");
>>  +		return PTR_ERR(dsi);
>>  +	}
>>  +
>>  +	return 0;
>>  +}
>>  +
>>  +static const struct of_device_id dbi_spi_of_match[] =3D {
>>  +	{ .compatible =3D "adafruit,yx240qv29" },
>>  +	{ .compatible =3D "leadtek,ltk035c5444t-spi" },
>>  +	{ }
>>  +};
>>  +MODULE_DEVICE_TABLE(of, dbi_spi_of_match);
>>  +
>>  +static struct spi_driver dbi_spi_driver =3D {
>>  +	.driver =3D {
>>  +		.name =3D "dbi-spi",
>>  +		.of_match_table =3D dbi_spi_of_match,
>>  +	},
>>  +	.probe =3D dbi_spi_probe,
>>  +};
>>  +module_spi_driver(dbi_spi_driver);
>>  +
>>  +MODULE_DESCRIPTION("DBI SPI bus driver");
>>  +MODULE_AUTHOR("Paul Cercueil <paul@crapouillou.net>");
>>  +MODULE_LICENSE("GPL");
>=20
> --
> Regards,
>=20
> Laurent Pinchart


