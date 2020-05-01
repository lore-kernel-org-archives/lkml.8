Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91642C47254
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 20:48:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D2D0208DB
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 20:48:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W/PSwxyM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbgEAUsp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 16:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbgEAUsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 16:48:45 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C49F0C061A0C;
        Fri,  1 May 2020 13:48:44 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id f13so12908555wrm.13;
        Fri, 01 May 2020 13:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UDJxw/ug0/U/iGbtoFqQBVqVbjHxpxn12zHozN7SZ2o=;
        b=W/PSwxyMlgLuDUXQysstYJPaIVhDWE8D1NvIkylvSXwDko/rxN0qGw9jw1NJQ51owP
         y4UsF2jtnuBKqNeWoCGSsuUkJlizN9AtSrOp4RQ36e7OpNMXCTMt9A1BXs/8LMiYhCc5
         FsgAoUbzJ4yX89RUCWUEswIWCQSi/GpUBi7+/TvfWcfWrJOjrCq9Qo6zqdITsuPzykO4
         oV64kV2Za6eji1WDN0vg6LXcJY0Lo/3wpoZ0bHA23LrvRHq+KV6taLKJ9v0iHlwoT32R
         K/l1DFcggSQQSNJhcQkIWDpHMRiIa/vLd1SoMt/0HMI1Ibgf8Ezgaz7Hl+jWAcm9N2Ef
         FGRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UDJxw/ug0/U/iGbtoFqQBVqVbjHxpxn12zHozN7SZ2o=;
        b=cJsCrRnV/XZR2Bi8PqjBJAmb9DilIPpPo04G95pUrwEVGyFxjbza0CV8IJB0EPy4S7
         DAtAtczsF4xICQXm5cwL//T4Zs5M2b3aN3L3taZ899KNkRFCsMer4Xx5CjyGaeCGHKwV
         6vT3pePj8klpwiJnvg0pMbD97BZ0I2mhUibMyNcQBK4UyrMyeanJKycLoPIpkTboHdK9
         0ipnZROgUmpexw7y/ehylTva0BbX3SyepmCbdk7xcad8r4DN50CRP4BauWpo6TOqn/vR
         g/f1ZfPDL1pkHMNbkfeD0TZII7juiLKalzP9dqiTHCFf+CwqPUT+LObSiBI7+5NH1vWh
         qRrA==
X-Gm-Message-State: AGi0PubvYa7YXad+vq8Wi4xSPlLvsoMFuOBjb4Y3A0LuL8ZiXyGK+6W3
        nfbfoBBwjTkK6KEX/J/8wp8=
X-Google-Smtp-Source: APiQypL8/wMynBDyQuDHgDZwf8aULrdD+p6HLs9oEQWYrW1FDjC3o+Tu9KpmQcAM6E38OkTCJL+Pww==
X-Received: by 2002:a05:6000:1287:: with SMTP id f7mr6098085wrx.345.1588366123398;
        Fri, 01 May 2020 13:48:43 -0700 (PDT)
Received: from localhost.localdomain (abag125.neoplus.adsl.tpnet.pl. [83.6.170.125])
        by smtp.googlemail.com with ESMTPSA id w12sm5938623wrk.56.2020.05.01.13.48.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2020 13:48:43 -0700 (PDT)
From:   Konrad Dybcio <konradybcio@gmail.com>
To:     skrzynka@konradybcio.pl
Cc:     Konrad Dybcio <konradybcio@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] drivers: drm: panel: Add TM5P5 NT35596 panel driver
Date:   Fri,  1 May 2020 22:48:22 +0200
Message-Id: <20200501204825.146424-2-konradybcio@gmail.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200501204825.146424-1-konradybcio@gmail.com>
References: <20200501204825.146424-1-konradybcio@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support for TMP5P5 NT35596 1080x1920 video
mode panel that can be found on some Asus Zenfone 2
Laser (Z00T) devices.

Signed-off-by: Konrad Dybcio <konradybcio@gmail.com>
---
 drivers/gpu/drm/panel/Kconfig               |   9 +
 drivers/gpu/drm/panel/Makefile              |   1 +
 drivers/gpu/drm/panel/panel-tm5p5-nt35596.c | 366 ++++++++++++++++++++
 3 files changed, 376 insertions(+)
 create mode 100644 drivers/gpu/drm/panel/panel-tm5p5-nt35596.c

diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
index a1723c1b5fbf8..6ff892334ac4b 100644
--- a/drivers/gpu/drm/panel/Kconfig
+++ b/drivers/gpu/drm/panel/Kconfig
@@ -401,6 +401,15 @@ config DRM_PANEL_SONY_ACX565AKM
 	  Say Y here if you want to enable support for the Sony ACX565AKM
 	  800x600 3.5" panel (found on the Nokia N900).
 
+config DRM_PANEL_TM5P5_NT35596
+	tristate "TM5P5 NT35596 panel"
+	depends on GPIOLIB && OF
+	depends on DRM_MIPI_DSI
+	help
+	  Say Y here if you want to enable support for the TMP5P5
+	  NT35596 1080x1920 video mode panel as found in some Asus
+	  Zenfone 2 Laser Z00T devices.
+
 config DRM_PANEL_TPO_TD028TTEC1
 	tristate "Toppoly (TPO) TD028TTEC1 panel driver"
 	depends on OF && SPI
diff --git a/drivers/gpu/drm/panel/Makefile b/drivers/gpu/drm/panel/Makefile
index 96a883cd66305..4fc7e00b18502 100644
--- a/drivers/gpu/drm/panel/Makefile
+++ b/drivers/gpu/drm/panel/Makefile
@@ -42,6 +42,7 @@ obj-$(CONFIG_DRM_PANEL_SITRONIX_ST7701) += panel-sitronix-st7701.o
 obj-$(CONFIG_DRM_PANEL_SITRONIX_ST7789V) += panel-sitronix-st7789v.o
 obj-$(CONFIG_DRM_PANEL_SONY_ACX424AKP) += panel-sony-acx424akp.o
 obj-$(CONFIG_DRM_PANEL_SONY_ACX565AKM) += panel-sony-acx565akm.o
+obj-$(CONFIG_DRM_PANEL_TM5P5_NT35596) += panel-tm5p5-nt35596.o
 obj-$(CONFIG_DRM_PANEL_TPO_TD028TTEC1) += panel-tpo-td028ttec1.o
 obj-$(CONFIG_DRM_PANEL_TPO_TD043MTEA1) += panel-tpo-td043mtea1.o
 obj-$(CONFIG_DRM_PANEL_TPO_TPG110) += panel-tpo-tpg110.o
diff --git a/drivers/gpu/drm/panel/panel-tm5p5-nt35596.c b/drivers/gpu/drm/panel/panel-tm5p5-nt35596.c
new file mode 100644
index 0000000000000..c361ab76812b8
--- /dev/null
+++ b/drivers/gpu/drm/panel/panel-tm5p5-nt35596.c
@@ -0,0 +1,366 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/backlight.h>
+#include <linux/delay.h>
+#include <linux/gpio/consumer.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/regulator/consumer.h>
+
+#include <drm/drm_mipi_dsi.h>
+#include <drm/drm_modes.h>
+#include <drm/drm_panel.h>
+
+struct tm5p5_nt35596 {
+	struct drm_panel panel;
+	struct mipi_dsi_device *dsi;
+	struct regulator_bulk_data supplies[2];
+	struct gpio_desc *reset_gpio;
+	bool prepared;
+};
+
+static inline struct tm5p5_nt35596 *to_tm5p5_nt35596(struct drm_panel *panel)
+{
+	return container_of(panel, struct tm5p5_nt35596, panel);
+}
+
+#define dsi_generic_write_seq(dsi, seq...) do {				\
+		static const u8 d[] = { seq };				\
+		int ret;						\
+		ret = mipi_dsi_generic_write(dsi, d, ARRAY_SIZE(d));	\
+		if (ret < 0)						\
+			return ret;					\
+	} while (0)
+
+#define dsi_dcs_write_seq(dsi, seq...) do {				\
+		static const u8 d[] = { seq };				\
+		int ret;						\
+		ret = mipi_dsi_dcs_write_buffer(dsi, d, ARRAY_SIZE(d));	\
+		if (ret < 0)						\
+			return ret;					\
+	} while (0)
+
+static void tm5p5_nt35596_reset(struct tm5p5_nt35596 *ctx)
+{
+	gpiod_set_value_cansleep(ctx->reset_gpio, 1);
+	usleep_range(1000, 2000);
+	gpiod_set_value_cansleep(ctx->reset_gpio, 0);
+	usleep_range(1000, 2000);
+	gpiod_set_value_cansleep(ctx->reset_gpio, 1);
+	usleep_range(15000, 16000);
+}
+
+static int tm5p5_nt35596_on(struct tm5p5_nt35596 *ctx)
+{
+	struct mipi_dsi_device *dsi = ctx->dsi;
+
+	dsi_generic_write_seq(dsi, 0xff, 0x05);
+	dsi_generic_write_seq(dsi, 0xfb, 0x01);
+	dsi_generic_write_seq(dsi, 0xc5, 0x31);
+	dsi_generic_write_seq(dsi, 0xff, 0x04);
+	dsi_generic_write_seq(dsi, 0x01, 0x84);
+	dsi_generic_write_seq(dsi, 0x05, 0x25);
+	dsi_generic_write_seq(dsi, 0x06, 0x01);
+	dsi_generic_write_seq(dsi, 0x07, 0x20);
+	dsi_generic_write_seq(dsi, 0x08, 0x06);
+	dsi_generic_write_seq(dsi, 0x09, 0x08);
+	dsi_generic_write_seq(dsi, 0x0a, 0x10);
+	dsi_generic_write_seq(dsi, 0x0b, 0x10);
+	dsi_generic_write_seq(dsi, 0x0c, 0x10);
+	dsi_generic_write_seq(dsi, 0x0d, 0x14);
+	dsi_generic_write_seq(dsi, 0x0e, 0x14);
+	dsi_generic_write_seq(dsi, 0x0f, 0x14);
+	dsi_generic_write_seq(dsi, 0x10, 0x14);
+	dsi_generic_write_seq(dsi, 0x11, 0x14);
+	dsi_generic_write_seq(dsi, 0x12, 0x14);
+	dsi_generic_write_seq(dsi, 0x17, 0xf3);
+	dsi_generic_write_seq(dsi, 0x18, 0xc0);
+	dsi_generic_write_seq(dsi, 0x19, 0xc0);
+	dsi_generic_write_seq(dsi, 0x1a, 0xc0);
+	dsi_generic_write_seq(dsi, 0x1b, 0xb3);
+	dsi_generic_write_seq(dsi, 0x1c, 0xb3);
+	dsi_generic_write_seq(dsi, 0x1d, 0xb3);
+	dsi_generic_write_seq(dsi, 0x1e, 0xb3);
+	dsi_generic_write_seq(dsi, 0x1f, 0xb3);
+	dsi_generic_write_seq(dsi, 0x20, 0xb3);
+	dsi_generic_write_seq(dsi, 0xfb, 0x01);
+	dsi_generic_write_seq(dsi, 0xff, 0x00);
+	dsi_generic_write_seq(dsi, 0xfb, 0x01);
+	dsi_generic_write_seq(dsi, 0x35, 0x01);
+	dsi_generic_write_seq(dsi, 0xd3, 0x06);
+	dsi_generic_write_seq(dsi, 0xd4, 0x04);
+	dsi_generic_write_seq(dsi, 0x5e, 0x0d);
+	dsi_generic_write_seq(dsi, 0x11, 0x00);
+	msleep(100);
+	dsi_generic_write_seq(dsi, 0x29, 0x00);
+	dsi_generic_write_seq(dsi, 0x53, 0x24);
+
+	return 0;
+}
+
+static int tm5p5_nt35596_off(struct tm5p5_nt35596 *ctx)
+{
+	struct mipi_dsi_device *dsi = ctx->dsi;
+	struct device *dev = &dsi->dev;
+	int ret;
+
+	ret = mipi_dsi_dcs_set_display_off(dsi);
+	if (ret < 0) {
+		dev_err(dev, "Failed to set display off: %d\n", ret);
+		return ret;
+	}
+	msleep(60);
+
+	ret = mipi_dsi_dcs_enter_sleep_mode(dsi);
+	if (ret < 0) {
+		dev_err(dev, "Failed to enter sleep mode: %d\n", ret);
+		return ret;
+	}
+
+	dsi_dcs_write_seq(dsi, 0x4f, 0x01);
+
+	return 0;
+}
+
+static int tm5p5_nt35596_prepare(struct drm_panel *panel)
+{
+	struct tm5p5_nt35596 *ctx = to_tm5p5_nt35596(panel);
+	struct device *dev = &ctx->dsi->dev;
+	int ret;
+
+	if (ctx->prepared)
+		return 0;
+
+	ret = regulator_bulk_enable(ARRAY_SIZE(ctx->supplies), ctx->supplies);
+	if (ret < 0) {
+		dev_err(dev, "Failed to enable regulators: %d\n", ret);
+		return ret;
+	}
+
+	tm5p5_nt35596_reset(ctx);
+
+	ret = tm5p5_nt35596_on(ctx);
+	if (ret < 0) {
+		dev_err(dev, "Failed to initialize panel: %d\n", ret);
+		gpiod_set_value_cansleep(ctx->reset_gpio, 0);
+		regulator_bulk_disable(ARRAY_SIZE(ctx->supplies), ctx->supplies);
+		return ret;
+	}
+
+	ctx->prepared = true;
+	return 0;
+}
+
+static int tm5p5_nt35596_unprepare(struct drm_panel *panel)
+{
+	struct tm5p5_nt35596 *ctx = to_tm5p5_nt35596(panel);
+	struct device *dev = &ctx->dsi->dev;
+	int ret;
+
+	if (!ctx->prepared)
+		return 0;
+
+	ret = tm5p5_nt35596_off(ctx);
+	if (ret < 0)
+		dev_err(dev, "Failed to un-initialize panel: %d\n", ret);
+
+	gpiod_set_value_cansleep(ctx->reset_gpio, 0);
+	regulator_bulk_disable(ARRAY_SIZE(ctx->supplies), ctx->supplies);
+
+	ctx->prepared = false;
+	return 0;
+}
+
+static const struct drm_display_mode tm5p5_nt35596_mode = {
+	.clock = (1080 + 100 + 8 + 16) * (1920 + 4 + 2 + 4) * 60 / 1000,
+	.hdisplay = 1080,
+	.hsync_start = 1080 + 100,
+	.hsync_end = 1080 + 100 + 8,
+	.htotal = 1080 + 100 + 8 + 16,
+	.vdisplay = 1920,
+	.vsync_start = 1920 + 4,
+	.vsync_end = 1920 + 4 + 2,
+	.vtotal = 1920 + 4 + 2 + 4,
+	.vrefresh = 60,
+	.width_mm = 68,
+	.height_mm = 121,
+};
+
+static int tm5p5_nt35596_get_modes(struct drm_panel *panel,
+				   struct drm_connector *connector)
+{
+	struct drm_display_mode *mode;
+
+	mode = drm_mode_duplicate(connector->dev, &tm5p5_nt35596_mode);
+	if (!mode)
+		return -ENOMEM;
+
+	drm_mode_set_name(mode);
+
+	mode->type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED;
+	connector->display_info.width_mm = mode->width_mm;
+	connector->display_info.height_mm = mode->height_mm;
+	drm_mode_probed_add(connector, mode);
+
+	return 1;
+}
+
+static const struct drm_panel_funcs tm5p5_nt35596_panel_funcs = {
+	.prepare = tm5p5_nt35596_prepare,
+	.unprepare = tm5p5_nt35596_unprepare,
+	.get_modes = tm5p5_nt35596_get_modes,
+};
+
+static int tm5p5_nt35596_bl_update_status(struct backlight_device *bl)
+{
+	struct mipi_dsi_device *dsi = bl_get_data(bl);
+	u16 brightness = bl->props.brightness;
+	int ret;
+
+	if (bl->props.power != FB_BLANK_UNBLANK ||
+	    bl->props.fb_blank != FB_BLANK_UNBLANK ||
+	    bl->props.state & (BL_CORE_SUSPENDED | BL_CORE_FBBLANK))
+		brightness = 0;
+
+	dsi->mode_flags &= ~MIPI_DSI_MODE_LPM;
+
+	ret = mipi_dsi_dcs_set_display_brightness(dsi, brightness);
+	if (ret < 0)
+		return ret;
+
+	dsi->mode_flags |= MIPI_DSI_MODE_LPM;
+
+	return 0;
+}
+
+// TODO: Check if /sys/class/backlight/.../actual_brightness actually returns
+// correct values. If not, remove this function.
+static int tm5p5_nt35596_bl_get_brightness(struct backlight_device *bl)
+{
+	struct mipi_dsi_device *dsi = bl_get_data(bl);
+	u16 brightness = bl->props.brightness;
+	int ret;
+
+	dsi->mode_flags &= ~MIPI_DSI_MODE_LPM;
+
+	ret = mipi_dsi_dcs_get_display_brightness(dsi, &brightness);
+	if (ret < 0)
+		return ret;
+
+	dsi->mode_flags |= MIPI_DSI_MODE_LPM;
+
+	return brightness & 0xff;
+}
+
+static const struct backlight_ops tm5p5_nt35596_bl_ops = {
+	.update_status = tm5p5_nt35596_bl_update_status,
+	.get_brightness = tm5p5_nt35596_bl_get_brightness,
+};
+
+static struct backlight_device *
+tm5p5_nt35596_create_backlight(struct mipi_dsi_device *dsi)
+{
+	struct device *dev = &dsi->dev;
+	struct backlight_properties props = {
+		.type = BACKLIGHT_RAW,
+		.brightness = 255,
+		.max_brightness = 255,
+	};
+
+	return devm_backlight_device_register(dev, dev_name(dev), dev, dsi,
+					      &tm5p5_nt35596_bl_ops, &props);
+}
+
+static int tm5p5_nt35596_probe(struct mipi_dsi_device *dsi)
+{
+	struct device *dev = &dsi->dev;
+	struct tm5p5_nt35596 *ctx;
+	int ret;
+
+	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	ctx->supplies[0].supply = "vdd";
+	ctx->supplies[1].supply = "vddio";
+	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(ctx->supplies),
+				      ctx->supplies);
+	if (ret < 0) {
+		dev_err(dev, "Failed to get regulators: %d\n", ret);
+		return ret;
+	}
+
+	ctx->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
+	if (IS_ERR(ctx->reset_gpio)) {
+		ret = PTR_ERR(ctx->reset_gpio);
+		dev_err(dev, "Failed to get reset-gpios: %d\n", ret);
+		return ret;
+	}
+
+	ctx->dsi = dsi;
+	mipi_dsi_set_drvdata(dsi, ctx);
+
+	dsi->lanes = 4;
+	dsi->format = MIPI_DSI_FMT_RGB888;
+	dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_BURST |
+			  MIPI_DSI_MODE_VIDEO_HSE | MIPI_DSI_MODE_EOT_PACKET |
+			  MIPI_DSI_CLOCK_NON_CONTINUOUS | MIPI_DSI_MODE_LPM;
+
+	drm_panel_init(&ctx->panel, dev, &tm5p5_nt35596_panel_funcs,
+		       DRM_MODE_CONNECTOR_DSI);
+
+	ctx->panel.backlight = tm5p5_nt35596_create_backlight(dsi);
+	if (IS_ERR(ctx->panel.backlight)) {
+		ret = PTR_ERR(ctx->panel.backlight);
+		dev_err(dev, "Failed to create backlight: %d\n", ret);
+		return ret;
+	}
+
+	ret = drm_panel_add(&ctx->panel);
+	if (ret < 0) {
+		dev_err(dev, "Failed to add panel: %d\n", ret);
+		return ret;
+	}
+
+	ret = mipi_dsi_attach(dsi);
+	if (ret < 0) {
+		dev_err(dev, "Failed to attach to DSI host: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int tm5p5_nt35596_remove(struct mipi_dsi_device *dsi)
+{
+	struct tm5p5_nt35596 *ctx = mipi_dsi_get_drvdata(dsi);
+	int ret;
+
+	ret = mipi_dsi_detach(dsi);
+	if (ret < 0)
+		dev_err(&dsi->dev, "Failed to detach from DSI host: %d\n", ret);
+
+	drm_panel_remove(&ctx->panel);
+
+	return 0;
+}
+
+static const struct of_device_id tm5p5_nt35596_of_match[] = {
+	{ .compatible = "tm5p5,nt35596" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, tm5p5_nt35596_of_match);
+
+static struct mipi_dsi_driver tm5p5_nt35596_driver = {
+	.probe = tm5p5_nt35596_probe,
+	.remove = tm5p5_nt35596_remove,
+	.driver = {
+		.name = "panel-tm5p5-nt35596",
+		.of_match_table = tm5p5_nt35596_of_match,
+	},
+};
+module_mipi_dsi_driver(tm5p5_nt35596_driver);
+
+MODULE_AUTHOR("Konrad Dybcio <konradybcio@gmail.com>");
+MODULE_DESCRIPTION("DRM driver for tm5p5 nt35596 1080p video mode dsi panel");
+MODULE_LICENSE("GPL v2");
-- 
2.26.1

