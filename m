Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E248C433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 16:15:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B68E620796
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 16:15:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="y054vF8r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727943AbgIDQPg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 12:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727865AbgIDQPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 12:15:20 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF4CC061247
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 09:15:18 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id g4so7303250wrs.5
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 09:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TiWVDyOiJOLfpry+KJM9xN6KpFkNEhDwQ75bGspW1TI=;
        b=y054vF8rhbpcfyCeggqd/TIY9zb1D4HjEZIfJRhdya+RNsgmJTVCEMt5PPe34FlecT
         Y7QQIJ/EQ2FvGVepgvBu5tLg2HmgPPIDjps3WdPexRtPuLoCfbnM0zhbIls1Ue3PgzQn
         G/7BHrNkkDWlHhL8tN08cSva8+6Wr2ir1BcgOZKE6Zyliv6dUPd3nfnuON+isXvBbMHb
         jzgrjPyB19lUOCi3bjI/uTkc1UJswiILY0A/nT46qfnHAXqVrJtjfHQWY3TYE7F4KqZi
         0Sp7rrGHSTfe9uwS6ms4JijfVCpCXxUFv82KcA/qhFkj70zDU/jqJS+VbJ85/NWQeE29
         uUjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TiWVDyOiJOLfpry+KJM9xN6KpFkNEhDwQ75bGspW1TI=;
        b=YqSYvxipXGw+JMc4cabaKGeei3Dc0eeuSeVnG8I42qcwT46bubhAodVC3LgYYeMWQN
         tTn7EDLBdYkaq0lK3UW0rwa+8wUJIr+fMNH37SPq+S5M+qAocRMELiMOWpLnzxOJolTn
         +PDdM0AdxQK8Lrf4QlEhUz0D87Tsv/JCdVk2AG6/9J19C9RhqDHbgi311qpVneb0acG2
         16nnuzNDwqjCE+bpGIKCzArbwjX6j1dPIxrvlZvNGHZoyoluz9X06uouuuULJS4o4QQ6
         yo7+fCQ8fHn3uR31zRDWUXuFH+bouVmZxhHIZFnMx4WNBuc5VFVCoTHGjGOTB38eT/f9
         48pg==
X-Gm-Message-State: AOAM533drn+aWcbQHd+G40os6/dW5wGj+253GKmSa0SL4vw+thJ1wRR9
        O8dMf71whqepv31oekuAfj4xkA==
X-Google-Smtp-Source: ABdhPJwCbuGRUjy+meziXyXlAmclbEESal5T8OBjAfHiaHd+/emX3KFBkDESxvUodfXx1G/G6zn3XA==
X-Received: by 2002:a5d:48c3:: with SMTP id p3mr8079200wrs.69.1599236117334;
        Fri, 04 Sep 2020 09:15:17 -0700 (PDT)
Received: from bender.baylibre.local ([2a01:e35:2ec0:82b0:5405:9623:e2f1:b2ac])
        by smtp.gmail.com with ESMTPSA id d18sm12238160wrm.10.2020.09.04.09.15.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 09:15:16 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     thierry.reding@gmail.com, sam@ravnborg.org
Cc:     dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 2/2] drm: panel: add TDO tl070wsh30 panel driver
Date:   Fri,  4 Sep 2020 18:15:04 +0200
Message-Id: <20200904161504.23915-3-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200904161504.23915-1-narmstrong@baylibre.com>
References: <20200904161504.23915-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support for the TDO TL070WSH30 TFT-LCD panel module.
The panel has a 1024×600 resolution and uses 24 bit RGB per pixel.
It provides a MIPI DSI interface to the host, a built-in LED backlight
and touch controller.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/gpu/drm/panel/Kconfig                |  11 +
 drivers/gpu/drm/panel/Makefile               |   1 +
 drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c | 263 +++++++++++++++++++
 3 files changed, 275 insertions(+)
 create mode 100644 drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c

diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
index 8d97d07c5871..2d488a875b99 100644
--- a/drivers/gpu/drm/panel/Kconfig
+++ b/drivers/gpu/drm/panel/Kconfig
@@ -433,6 +433,17 @@ config DRM_PANEL_SONY_ACX565AKM
 	  Say Y here if you want to enable support for the Sony ACX565AKM
 	  800x600 3.5" panel (found on the Nokia N900).
 
+config DRM_PANEL_TDO_TL070WSH30
+	tristate "TDO TL070WSH30 DSI panel"
+	depends on OF
+	depends on DRM_MIPI_DSI
+	depends on BACKLIGHT_CLASS_DEVICE
+	help
+	  Say Y here if you want to enable support for TDO TL070WSH30 TFT-LCD
+	  panel module. The panel has a 1024×600 resolution and uses
+	  24 bit RGB per pixel. It provides a MIPI DSI interface to
+	  the host, a built-in LED backlight and touch controller.
+
 config DRM_PANEL_TPO_TD028TTEC1
 	tristate "Toppoly (TPO) TD028TTEC1 panel driver"
 	depends on OF && SPI
diff --git a/drivers/gpu/drm/panel/Makefile b/drivers/gpu/drm/panel/Makefile
index 15a4e7752951..35ee06a1b5c2 100644
--- a/drivers/gpu/drm/panel/Makefile
+++ b/drivers/gpu/drm/panel/Makefile
@@ -45,6 +45,7 @@ obj-$(CONFIG_DRM_PANEL_SITRONIX_ST7703) += panel-sitronix-st7703.o
 obj-$(CONFIG_DRM_PANEL_SITRONIX_ST7789V) += panel-sitronix-st7789v.o
 obj-$(CONFIG_DRM_PANEL_SONY_ACX424AKP) += panel-sony-acx424akp.o
 obj-$(CONFIG_DRM_PANEL_SONY_ACX565AKM) += panel-sony-acx565akm.o
+obj-$(CONFIG_DRM_PANEL_TDO_TL070WSH30) += panel-tdo-tl070wsh30.o
 obj-$(CONFIG_DRM_PANEL_TPO_TD028TTEC1) += panel-tpo-td028ttec1.o
 obj-$(CONFIG_DRM_PANEL_TPO_TD043MTEA1) += panel-tpo-td043mtea1.o
 obj-$(CONFIG_DRM_PANEL_TPO_TPG110) += panel-tpo-tpg110.o
diff --git a/drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c b/drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c
new file mode 100644
index 000000000000..1734acd4f570
--- /dev/null
+++ b/drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c
@@ -0,0 +1,263 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2020 BayLibre, SAS
+ * Author: Neil Armstrong <narmstrong@baylibre.com>
+ */
+
+#include <linux/delay.h>
+#include <linux/gpio/consumer.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/regulator/consumer.h>
+
+#include <video/mipi_display.h>
+
+#include <drm/drm_crtc.h>
+#include <drm/drm_device.h>
+#include <drm/drm_mipi_dsi.h>
+#include <drm/drm_modes.h>
+#include <drm/drm_panel.h>
+#include <drm/drm_print.h>
+
+struct tdo_tl070wsh30_panel {
+	struct drm_panel base;
+	struct mipi_dsi_device *link;
+
+	struct regulator *supply;
+	struct gpio_desc *reset_gpio;
+
+	bool prepared;
+};
+
+static inline
+struct tdo_tl070wsh30_panel *to_tdo_tl070wsh30_panel(struct drm_panel *panel)
+{
+	return container_of(panel, struct tdo_tl070wsh30_panel, base);
+}
+
+static int tdo_tl070wsh30_panel_unprepare(struct drm_panel *panel)
+{
+	struct tdo_tl070wsh30_panel *tdo_tl070wsh30 = to_tdo_tl070wsh30_panel(panel);
+	int err;
+
+	if (!tdo_tl070wsh30->prepared)
+		return 0;
+
+	err = mipi_dsi_dcs_set_display_off(tdo_tl070wsh30->link);
+	if (err < 0)
+		DRM_DEV_ERROR(panel->dev, "failed to set display off: %d\n",
+			      err);
+
+	usleep_range(10000, 11000);
+
+	err = mipi_dsi_dcs_enter_sleep_mode(tdo_tl070wsh30->link);
+	if (err < 0) {
+		DRM_DEV_ERROR(panel->dev, "failed to enter sleep mode: %d\n",
+			      err);
+		return err;
+	}
+
+	usleep_range(10000, 11000);
+
+	tdo_tl070wsh30->prepared = false;
+
+	return 0;
+}
+
+static int tdo_tl070wsh30_panel_prepare(struct drm_panel *panel)
+{
+	struct tdo_tl070wsh30_panel *tdo_tl070wsh30 = to_tdo_tl070wsh30_panel(panel);
+	int err;
+
+	if (tdo_tl070wsh30->prepared)
+		return 0;
+
+	err = mipi_dsi_dcs_exit_sleep_mode(tdo_tl070wsh30->link);
+	if (err < 0) {
+		DRM_DEV_ERROR(panel->dev, "failed to exit sleep mode: %d\n",
+			      err);
+		return err;
+	}
+
+	msleep(200);
+
+	err = mipi_dsi_dcs_set_display_on(tdo_tl070wsh30->link);
+	if (err < 0) {
+		DRM_DEV_ERROR(panel->dev, "failed to set display on: %d\n",
+			      err);
+		return err;
+	}
+
+	msleep(20);
+
+	tdo_tl070wsh30->prepared = true;
+
+	return 0;
+}
+
+static const struct drm_display_mode default_mode = {
+	.clock = 47250,
+	.hdisplay = 1024,
+	.hsync_start = 1024 + 46,
+	.hsync_end = 1024 + 46 + 80,
+	.htotal = 1024 + 46 + 80 + 100,
+	.vdisplay = 600,
+	.vsync_start = 600 + 5,
+	.vsync_end = 600 + 5 + 5,
+	.vtotal = 600 + 5 + 5 + 20,
+	.vrefresh = 60, /* to be removed */
+	.flags = DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC,
+};
+
+static int tdo_tl070wsh30_panel_get_modes(struct drm_panel *panel,
+				       struct drm_connector *connector)
+{
+	struct drm_display_mode *mode;
+
+	mode = drm_mode_duplicate(connector->dev, &default_mode);
+	if (!mode) {
+		DRM_DEV_ERROR(panel->dev, "failed to add mode %ux%ux@%u\n",
+			      default_mode.hdisplay, default_mode.vdisplay,
+			      default_mode.vrefresh);
+		return -ENOMEM;
+	}
+
+	drm_mode_set_name(mode);
+
+	drm_mode_probed_add(connector, mode);
+
+	connector->display_info.width_mm = 154;
+	connector->display_info.height_mm = 85;
+	connector->display_info.bpc = 8;
+
+	return 1;
+}
+
+static const struct drm_panel_funcs tdo_tl070wsh30_panel_funcs = {
+	.unprepare = tdo_tl070wsh30_panel_unprepare,
+	.prepare = tdo_tl070wsh30_panel_prepare,
+	.get_modes = tdo_tl070wsh30_panel_get_modes,
+};
+
+static const struct of_device_id tdo_tl070wsh30_of_match[] = {
+	{ .compatible = "tdo,tl070wsh30", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, tdo_tl070wsh30_of_match);
+
+static int tdo_tl070wsh30_panel_add(struct tdo_tl070wsh30_panel *tdo_tl070wsh30)
+{
+	struct device *dev = &tdo_tl070wsh30->link->dev;
+	int err;
+
+	tdo_tl070wsh30->supply = devm_regulator_get(dev, "power");
+	if (IS_ERR(tdo_tl070wsh30->supply))
+		return PTR_ERR(tdo_tl070wsh30->supply);
+
+	tdo_tl070wsh30->reset_gpio = devm_gpiod_get(dev, "reset",
+						  GPIOD_OUT_LOW);
+	if (IS_ERR(tdo_tl070wsh30->reset_gpio)) {
+		err = PTR_ERR(tdo_tl070wsh30->reset_gpio);
+		dev_dbg(dev, "failed to get reset gpio: %d\n", err);
+		return err;
+	}
+
+	drm_panel_init(&tdo_tl070wsh30->base, &tdo_tl070wsh30->link->dev,
+		       &tdo_tl070wsh30_panel_funcs, DRM_MODE_CONNECTOR_DSI);
+
+	err = drm_panel_of_backlight(&tdo_tl070wsh30->base);
+	if (err)
+		return err;
+
+	err = regulator_enable(tdo_tl070wsh30->supply);
+	if (err < 0)
+		return err;
+
+	usleep_range(10000, 11000);
+
+	gpiod_set_value_cansleep(tdo_tl070wsh30->reset_gpio, 1);
+
+	usleep_range(10000, 11000);
+
+	gpiod_set_value_cansleep(tdo_tl070wsh30->reset_gpio, 0);
+
+	msleep(200);
+
+	return drm_panel_add(&tdo_tl070wsh30->base);
+}
+
+static void tdo_tl070wsh30_panel_del(struct tdo_tl070wsh30_panel *tdo_tl070wsh30)
+{
+	drm_panel_remove(&tdo_tl070wsh30->base);
+}
+
+static int tdo_tl070wsh30_panel_probe(struct mipi_dsi_device *dsi)
+{
+	struct tdo_tl070wsh30_panel *tdo_tl070wsh30;
+	int err;
+
+	dsi->lanes = 4;
+	dsi->format = MIPI_DSI_FMT_RGB888;
+	dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_BURST | MIPI_DSI_MODE_LPM;
+
+	tdo_tl070wsh30 = devm_kzalloc(&dsi->dev, sizeof(*tdo_tl070wsh30),
+				    GFP_KERNEL);
+	if (!tdo_tl070wsh30)
+		return -ENOMEM;
+
+	mipi_dsi_set_drvdata(dsi, tdo_tl070wsh30);
+	tdo_tl070wsh30->link = dsi;
+
+	err = tdo_tl070wsh30_panel_add(tdo_tl070wsh30);
+	if (err < 0)
+		return err;
+
+	return mipi_dsi_attach(dsi);
+}
+
+static int tdo_tl070wsh30_panel_remove(struct mipi_dsi_device *dsi)
+{
+	struct tdo_tl070wsh30_panel *tdo_tl070wsh30 = mipi_dsi_get_drvdata(dsi);
+	int err;
+
+	err = drm_panel_unprepare(&tdo_tl070wsh30->base);
+	if (err < 0)
+		DRM_DEV_ERROR(&dsi->dev, "failed to unprepare panel: %d\n",
+			      err);
+
+	err = drm_panel_disable(&tdo_tl070wsh30->base);
+	if (err < 0)
+		DRM_DEV_ERROR(&dsi->dev, "failed to disable panel: %d\n", err);
+
+	err = mipi_dsi_detach(dsi);
+	if (err < 0)
+		DRM_DEV_ERROR(&dsi->dev, "failed to detach from DSI host: %d\n",
+			      err);
+
+	tdo_tl070wsh30_panel_del(tdo_tl070wsh30);
+
+	return 0;
+}
+
+static void tdo_tl070wsh30_panel_shutdown(struct mipi_dsi_device *dsi)
+{
+	struct tdo_tl070wsh30_panel *tdo_tl070wsh30 = mipi_dsi_get_drvdata(dsi);
+
+	drm_panel_unprepare(&tdo_tl070wsh30->base);
+	drm_panel_disable(&tdo_tl070wsh30->base);
+}
+
+static struct mipi_dsi_driver tdo_tl070wsh30_panel_driver = {
+	.driver = {
+		.name = "panel-tdo-tl070wsh30",
+		.of_match_table = tdo_tl070wsh30_of_match,
+	},
+	.probe = tdo_tl070wsh30_panel_probe,
+	.remove = tdo_tl070wsh30_panel_remove,
+	.shutdown = tdo_tl070wsh30_panel_shutdown,
+};
+module_mipi_dsi_driver(tdo_tl070wsh30_panel_driver);
+
+MODULE_AUTHOR("Neil Armstrong <narmstrong@baylibre.com>");
+MODULE_DESCRIPTION("TDO TL070WSH30 panel driver");
+MODULE_LICENSE("GPL v2");
-- 
2.22.0

