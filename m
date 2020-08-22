Return-Path: <SRS0=ximN=CA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0955C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 16:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C95A206C0
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 16:33:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="Ep+wl6yA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728594AbgHVQdc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Aug 2020 12:33:32 -0400
Received: from crapouillou.net ([89.234.176.41]:48722 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728514AbgHVQdb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 12:33:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1598113990; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VOADsf+zkaa1JPcnuwuK9JFkqtkUN121yhXN3FKMvOY=;
        b=Ep+wl6yA0yE8XujoZQ6btOAQ279oBjOy45Ow/JBcHJtGy5ZXQHk1rDrRbfBxqe5B1V3Y7X
        UIarEkz8KvQXNQBOHnV5IqTdgWr+47DruOJek+25sNNWrGEQQfrw0iUoi8k4EihXyPgVmO
        KCPinisdWvjOh/ix6gwIUVhWYNRGyT8=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Noralf Tronnes <noralf@tronnes.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     od@zcrc.me, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 3/6] drm: Add SPI DBI host driver
Date:   Sat, 22 Aug 2020 18:32:47 +0200
Message-Id: <20200822163250.63664-4-paul@crapouillou.net>
In-Reply-To: <20200822163250.63664-1-paul@crapouillou.net>
References: <20200822163250.63664-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver will register a DBI host driver for panels connected over
SPI.

DBI types c1 and c3 are supported. C1 is a SPI protocol with 9 bits per
word, with the data/command information in the 9th (MSB) bit. C3 is a
SPI protocol with 8 bits per word, with the data/command information
carried by a separate GPIO.

v2: - Move ouside of drivers/gpu/drm/bridge/
    - The client drivers should now use module_mipi_dbi_spi_driver().
      This ensures that the panel drivers can probe from the DSI/DBI
      bus, as well as from the SPI bus, using a shared OF match table.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/gpu/drm/Kconfig            |   8 +
 drivers/gpu/drm/Makefile           |   1 +
 drivers/gpu/drm/drm_mipi_dbi_spi.c | 247 +++++++++++++++++++++++++++++
 include/drm/drm_mipi_dbi_spi.h     |  42 +++++
 4 files changed, 298 insertions(+)
 create mode 100644 drivers/gpu/drm/drm_mipi_dbi_spi.c
 create mode 100644 include/drm/drm_mipi_dbi_spi.h

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index 147d61b9674e..932c7bcaeff0 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -32,6 +32,14 @@ config DRM_MIPI_DSI
 	bool
 	depends on DRM
 
+config DRM_MIPI_DBI_SPI
+	tristate "SPI host support for MIPI DBI"
+	depends on DRM && OF && SPI
+	select DRM_MIPI_DSI
+	select DRM_MIPI_DBI
+	help
+	  Enable this option to support DBI panels connected over SPI.
+
 config DRM_DP_AUX_CHARDEV
 	bool "DRM DP AUX Interface"
 	depends on DRM
diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
index 2f31579f91d4..8c60448a3ee5 100644
--- a/drivers/gpu/drm/Makefile
+++ b/drivers/gpu/drm/Makefile
@@ -60,6 +60,7 @@ obj-$(CONFIG_DRM_DEBUG_SELFTEST) += selftests/
 obj-$(CONFIG_DRM)	+= drm.o
 obj-$(CONFIG_DRM_MIPI_DBI) += drm_mipi_dbi.o
 obj-$(CONFIG_DRM_MIPI_DSI) += drm_mipi_dsi.o
+obj-$(CONFIG_DRM_MIPI_DBI_SPI) += drm_mipi_dbi_spi.o
 obj-$(CONFIG_DRM_PANEL_ORIENTATION_QUIRKS) += drm_panel_orientation_quirks.o
 obj-y			+= arm/
 obj-$(CONFIG_DRM_TTM)	+= ttm/
diff --git a/drivers/gpu/drm/drm_mipi_dbi_spi.c b/drivers/gpu/drm/drm_mipi_dbi_spi.c
new file mode 100644
index 000000000000..a7eaf3125a17
--- /dev/null
+++ b/drivers/gpu/drm/drm_mipi_dbi_spi.c
@@ -0,0 +1,247 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * MIPI Display Bus Interface (DBI) SPI support
+ *
+ * Copyright 2016 Noralf Trønnes
+ * Copyright 2020 Paul Cercueil <paul@crapouillou.net>
+ */
+
+#include <linux/gpio/consumer.h>
+#include <linux/module.h>
+#include <linux/spi/spi.h>
+
+#include <drm/drm_mipi_dbi.h>
+#include <drm/drm_mipi_dsi.h>
+
+#include <video/mipi_display.h>
+
+struct dbi_spi {
+	struct mipi_dsi_host host;
+	struct mipi_dsi_host_ops host_ops;
+
+	struct spi_device *spi;
+	struct gpio_desc *dc;
+	struct mutex cmdlock;
+
+	unsigned int current_bus_type;
+
+	/**
+	 * @tx_buf9: Buffer used for Option 1 9-bit conversion
+	 */
+	void *tx_buf9;
+
+	/**
+	 * @tx_buf9_len: Size of tx_buf9.
+	 */
+	size_t tx_buf9_len;
+};
+
+static inline struct dbi_spi *host_to_dbi_spi(struct mipi_dsi_host *host)
+{
+	return container_of(host, struct dbi_spi, host);
+}
+
+static ssize_t dbi_spi1_transfer(struct mipi_dsi_host *host,
+				 const struct mipi_dsi_msg *msg)
+{
+	struct dbi_spi *dbi = host_to_dbi_spi(host);
+	struct spi_device *spi = dbi->spi;
+	struct spi_transfer tr = {
+		.bits_per_word = 9,
+	};
+	const u8 *src8 = msg->tx_buf;
+	struct spi_message m;
+	size_t max_chunk, chunk;
+	size_t len = msg->tx_len;
+	bool cmd_byte = true;
+	unsigned int i;
+	u16 *dst16;
+	int ret;
+
+	tr.speed_hz = mipi_dbi_spi_cmd_max_speed(spi, len);
+	dst16 = dbi->tx_buf9;
+
+	max_chunk = min(dbi->tx_buf9_len / 2, len);
+
+	spi_message_init_with_transfers(&m, &tr, 1);
+	tr.tx_buf = dst16;
+
+	while (len) {
+		chunk = min(len, max_chunk);
+
+		for (i = 0; i < chunk; i++) {
+			dst16[i] = *src8++;
+
+			/* Bit 9: 0 means command, 1 means data */
+			if (!cmd_byte)
+				dst16[i] |= BIT(9);
+
+			cmd_byte = false;
+		}
+
+		tr.len = chunk * 2;
+		len -= chunk;
+
+		ret = spi_sync(spi, &m);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static ssize_t dbi_spi3_transfer(struct mipi_dsi_host *host,
+				 const struct mipi_dsi_msg *msg)
+{
+	struct dbi_spi *dbi = host_to_dbi_spi(host);
+	struct spi_device *spi = dbi->spi;
+	const u8 *buf = msg->tx_buf;
+	unsigned int bpw = 8;
+	u32 speed_hz;
+	ssize_t ret;
+
+	/* for now we only support sending messages, not receiving */
+	if (msg->rx_len)
+		return -EINVAL;
+
+	gpiod_set_value_cansleep(dbi->dc, 0);
+
+	speed_hz = mipi_dbi_spi_cmd_max_speed(spi, 1);
+	ret = mipi_dbi_spi_transfer(spi, speed_hz, 8, buf, 1);
+	if (ret || msg->tx_len == 1)
+		return ret;
+
+	if (buf[0] == MIPI_DCS_WRITE_MEMORY_START)
+		bpw = 16;
+
+	gpiod_set_value_cansleep(dbi->dc, 1);
+	speed_hz = mipi_dbi_spi_cmd_max_speed(spi, msg->tx_len - 1);
+
+	ret = mipi_dbi_spi_transfer(spi, speed_hz, bpw,
+				    &buf[1], msg->tx_len - 1);
+	if (ret)
+		return ret;
+
+	return msg->tx_len;
+}
+
+static ssize_t dbi_spi_transfer(struct mipi_dsi_host *host,
+				const struct mipi_dsi_msg *msg)
+{
+	struct dbi_spi *dbi = host_to_dbi_spi(host);
+
+	switch (dbi->current_bus_type) {
+	case MIPI_DCS_BUS_TYPE_DBI_SPI_C1:
+		return dbi_spi1_transfer(host, msg);
+	case MIPI_DCS_BUS_TYPE_DBI_SPI_C3:
+		return dbi_spi3_transfer(host, msg);
+	default:
+		dev_err(&dbi->spi->dev, "Unknown transfer type\n");
+		return -EINVAL;
+	}
+}
+
+static int dbi_spi_attach(struct mipi_dsi_host *host,
+			  struct mipi_dsi_device *dsi)
+{
+	struct dbi_spi *dbi = host_to_dbi_spi(host);
+
+	dbi->current_bus_type = dsi->bus_type;
+
+	if (dbi->current_bus_type == MIPI_DCS_BUS_TYPE_DBI_SPI_C1) {
+		dbi->tx_buf9_len = SZ_16K;
+
+		dbi->tx_buf9 = kmalloc(dbi->tx_buf9_len, GFP_KERNEL);
+		if (!dbi->tx_buf9)
+			return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static int dbi_spi_detach(struct mipi_dsi_host *host,
+			  struct mipi_dsi_device *dsi)
+{
+	struct dbi_spi *dbi = host_to_dbi_spi(host);
+
+	kfree(dbi->tx_buf9);
+	dbi->tx_buf9_len = 0;
+
+	return 0; /* Nothing to do */
+}
+
+static void dbi_spi_host_unregister(void *d)
+{
+	mipi_dsi_host_unregister(d);
+}
+
+int drm_mipi_dbi_spi_probe(struct spi_device *spi)
+{
+	struct device *dev = &spi->dev;
+	struct mipi_dsi_device_info info = { };
+	struct mipi_dsi_device *dsi;
+	struct dbi_spi *dbi;
+	int ret;
+
+	dbi = devm_kzalloc(dev, sizeof(*dbi), GFP_KERNEL);
+	if (!dbi)
+		return -ENOMEM;
+
+	dbi->host.dev = dev;
+	dbi->host.ops = &dbi->host_ops;
+	dbi->spi = spi;
+	spi_set_drvdata(spi, dbi);
+
+	dbi->dc = devm_gpiod_get_optional(dev, "dc", GPIOD_OUT_LOW);
+	if (IS_ERR(dbi->dc)) {
+		dev_err(dev, "Failed to get gpio 'dc'\n");
+		return PTR_ERR(dbi->dc);
+	}
+
+	if (spi_is_bpw_supported(spi, 9))
+		dbi->host.bus_types |= MIPI_DCS_BUS_TYPE_DBI_SPI_C1;
+	if (dbi->dc)
+		dbi->host.bus_types |= MIPI_DCS_BUS_TYPE_DBI_SPI_C3;
+
+	if (!dbi->host.bus_types) {
+		dev_err(dev, "Neither Type1 nor Type3 are supported\n");
+		return -EINVAL;
+	}
+
+	dbi->host_ops.transfer = dbi_spi_transfer;
+	dbi->host_ops.attach = dbi_spi_attach;
+	dbi->host_ops.detach = dbi_spi_detach;
+
+	mutex_init(&dbi->cmdlock);
+
+	ret = mipi_dsi_host_register(&dbi->host);
+	if (ret) {
+		dev_err(dev, "Unable to register DSI host\n");
+		return ret;
+	}
+
+	ret = devm_add_action_or_reset(dev, dbi_spi_host_unregister,
+				       &dbi->host);
+	if (ret)
+		return ret;
+
+	/*
+	 * Register our own node as a MIPI DSI device.
+	 * This ensures that the panel driver will be probed.
+	 */
+	info.channel = 0;
+	info.node = of_node_get(dev->of_node);
+
+	dsi = mipi_dsi_device_register_full(&dbi->host, &info);
+	if (IS_ERR(dsi)) {
+		dev_err(dev, "Failed to add DSI device\n");
+		return PTR_ERR(dsi);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(drm_mipi_dbi_spi_probe);
+
+MODULE_DESCRIPTION("DBI SPI bus driver");
+MODULE_AUTHOR("Paul Cercueil <paul@crapouillou.net>");
+MODULE_LICENSE("GPL");
diff --git a/include/drm/drm_mipi_dbi_spi.h b/include/drm/drm_mipi_dbi_spi.h
new file mode 100644
index 000000000000..ed3b040b1e4e
--- /dev/null
+++ b/include/drm/drm_mipi_dbi_spi.h
@@ -0,0 +1,42 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * MIPI Display Bus Interface (DBI) LCD controller support
+ *
+ * Copyright 2016 Noralf Trønnes
+ */
+
+#ifndef __DRM_MIPI_DBI_SPI_H
+#define __DRM_MIPI_DBI_SPI_H
+
+#include <drm/drm_mipi_dsi.h>
+#include <linux/spi/spi.h>
+
+int drm_mipi_dbi_spi_probe(struct spi_device *spi);
+
+#define module_mipi_dbi_spi_driver(__mipi_dbi_driver, __mipi_dbi_match_table) \
+	static struct spi_driver __mipi_dbi_driver##_spi __maybe_unused = { \
+		.driver = { \
+			.name = #__mipi_dbi_driver "_spi", \
+			.of_match_table = __mipi_dbi_match_table, \
+		}, \
+		.probe = drm_mipi_dbi_spi_probe, \
+	}; \
+	static int __mipi_dbi_driver##_module_init(void) \
+	{ \
+		if (IS_ENABLED(CONFIG_DRM_MIPI_DBI_SPI)) { \
+			int err = spi_register_driver(&__mipi_dbi_driver##_spi); \
+			if (err) \
+				return err; \
+		} \
+		return mipi_dsi_driver_register(&__mipi_dbi_driver); \
+	} \
+	static void __mipi_dbi_driver##_module_exit(void) \
+	{ \
+		mipi_dsi_driver_unregister(&__mipi_dbi_driver); \
+		if (IS_ENABLED(CONFIG_DRM_MIPI_DBI_SPI)) \
+			spi_unregister_driver(&__mipi_dbi_driver##_spi); \
+	} \
+	module_init(__mipi_dbi_driver##_module_init); \
+	module_exit(__mipi_dbi_driver##_module_exit)
+
+#endif /* __DRM_MIPI_DBI_SPI_H */
-- 
2.28.0

