Return-Path: <SRS0=qJsj=BZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41EFBC433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 21:32:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21C0C23133
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 21:32:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbgHOVck (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Aug 2020 17:32:40 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:52578 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725983AbgHOVcX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 17:32:23 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 16BBCFB02;
        Sat, 15 Aug 2020 23:16:28 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id J5RZCWaH0Sss; Sat, 15 Aug 2020 23:16:23 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id B6C78457CF; Sat, 15 Aug 2020 23:16:22 +0200 (CEST)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Daniel Palmer <daniel@0x0f.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Mark Brown <broonie@kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        allen <allen.chen@ite.com.tw>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] drm/panel: Add panel driver for the Mantix MLAF057WE51-X DSI panel
Date:   Sat, 15 Aug 2020 23:16:22 +0200
Message-Id: <d4e3f881e3d53166eea0be31a885e08679813558.1597526107.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1597526107.git.agx@sigxcpu.org>
References: <cover.1597526107.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The panel uses a Focaltech FT8006p, the touch part is handled by the
already existing edt-ft5x06.

Signed-off-by: Guido Günther <agx@sigxcpu.org>
---
 MAINTAINERS                                   |   7 +
 drivers/gpu/drm/panel/Kconfig                 |  11 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 .../gpu/drm/panel/panel-mantix-mlaf057we51.c  | 328 ++++++++++++++++++
 4 files changed, 347 insertions(+)
 create mode 100644 drivers/gpu/drm/panel/panel-mantix-mlaf057we51.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 83ba7b62651f7..7dfe4cc3d4ec8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5474,6 +5474,13 @@ S:	Maintained
 F:	drivers/gpu/drm/panel/panel-lvds.c
 F:	Documentation/devicetree/bindings/display/panel/lvds.yaml
 
+DRM DRIVER FOR MANTIX MLAF057WE51 PANELS
+M:	Guido Günther <agx@sigxcpu.org>
+R:	Purism Kernel Team <kernel@puri.sm>
+S:	Maintained
+F:	Documentation/devicetree/bindings/display/panel/mantix,mlaf057we51-x.yaml
+F:	drivers/gpu/drm/panel/panel-mantix-mlaf057we51.c
+
 DRM DRIVER FOR MATROX G200/G400 GRAPHICS CARDS
 S:	Orphan / Obsolete
 F:	drivers/gpu/drm/mga/
diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
index de2f2a452be55..8d97d07c58713 100644
--- a/drivers/gpu/drm/panel/Kconfig
+++ b/drivers/gpu/drm/panel/Kconfig
@@ -217,6 +217,17 @@ config DRM_PANEL_NOVATEK_NT39016
 	  Say Y here if you want to enable support for the panels built
 	  around the Novatek NT39016 display controller.
 
+config DRM_PANEL_MANTIX_MLAF057WE51
+	tristate "Mantix MLAF057WE51-X MIPI-DSI LCD panel"
+	depends on OF
+	depends on DRM_MIPI_DSI
+	depends on BACKLIGHT_CLASS_DEVICE
+	help
+	  Say Y here if you want to enable support for the Mantix
+	  MLAF057WE51-X MIPI DSI panel as e.g. used in the Librem 5. It
+	  has a resolution of 720x1440 pixels, a built in backlight and touch
+	  controller.
+
 config DRM_PANEL_OLIMEX_LCD_OLINUXINO
 	tristate "Olimex LCD-OLinuXino panel"
 	depends on OF
diff --git a/drivers/gpu/drm/panel/Makefile b/drivers/gpu/drm/panel/Makefile
index e45ceac6286fd..15a4e77529514 100644
--- a/drivers/gpu/drm/panel/Makefile
+++ b/drivers/gpu/drm/panel/Makefile
@@ -20,6 +20,7 @@ obj-$(CONFIG_DRM_PANEL_LG_LG4573) += panel-lg-lg4573.o
 obj-$(CONFIG_DRM_PANEL_NEC_NL8048HL11) += panel-nec-nl8048hl11.o
 obj-$(CONFIG_DRM_PANEL_NOVATEK_NT35510) += panel-novatek-nt35510.o
 obj-$(CONFIG_DRM_PANEL_NOVATEK_NT39016) += panel-novatek-nt39016.o
+obj-$(CONFIG_DRM_PANEL_MANTIX_MLAF057WE51) += panel-mantix-mlaf057we51.o
 obj-$(CONFIG_DRM_PANEL_OLIMEX_LCD_OLINUXINO) += panel-olimex-lcd-olinuxino.o
 obj-$(CONFIG_DRM_PANEL_ORISETECH_OTM8009A) += panel-orisetech-otm8009a.o
 obj-$(CONFIG_DRM_PANEL_OSD_OSD101T2587_53TS) += panel-osd-osd101t2587-53ts.o
diff --git a/drivers/gpu/drm/panel/panel-mantix-mlaf057we51.c b/drivers/gpu/drm/panel/panel-mantix-mlaf057we51.c
new file mode 100644
index 0000000000000..cd5424d5bdb63
--- /dev/null
+++ b/drivers/gpu/drm/panel/panel-mantix-mlaf057we51.c
@@ -0,0 +1,328 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Mantix MLAF057WE51 5.7" MIPI-DSI panel driver
+ *
+ * Copyright (C) Purism SPC 2020
+ */
+
+#include <linux/backlight.h>
+#include <linux/delay.h>
+#include <linux/gpio/consumer.h>
+#include <linux/module.h>
+#include <linux/regulator/consumer.h>
+
+#include <video/mipi_display.h>
+
+#include <drm/drm_mipi_dsi.h>
+#include <drm/drm_modes.h>
+#include <drm/drm_panel.h>
+#include <drm/drm_print.h>
+
+#define DRV_NAME "panel-mantix-mlaf057we51"
+
+/* Manufacturer specific Commands send via DSI */
+#define MANTIX_CMD_OTP_STOP_RELOAD_MIPI 0x41
+#define MANTIX_CMD_INT_CANCEL           0x4C
+
+struct mantix {
+	struct device *dev;
+	struct drm_panel panel;
+	struct gpio_desc *reset_gpio;
+
+	struct regulator *avdd;
+	struct regulator *avee;
+	struct regulator *vddi;
+};
+
+static inline struct mantix *panel_to_mantix(struct drm_panel *panel)
+{
+	return container_of(panel, struct mantix, panel);
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
+static int mantix_init_sequence(struct mantix *ctx)
+{
+	struct mipi_dsi_device *dsi = to_mipi_dsi_device(ctx->dev);
+	struct device *dev = ctx->dev;
+
+	/*
+	 * Init sequence was supplied by the panel vendor.
+	 */
+	dsi_generic_write_seq(dsi, MANTIX_CMD_OTP_STOP_RELOAD_MIPI, 0x5A);
+
+	dsi_generic_write_seq(dsi, MANTIX_CMD_INT_CANCEL, 0x03);
+	dsi_generic_write_seq(dsi, MANTIX_CMD_OTP_STOP_RELOAD_MIPI, 0x5A, 0x03);
+	dsi_generic_write_seq(dsi, 0x80, 0xA9, 0x00);
+
+	dsi_generic_write_seq(dsi, MANTIX_CMD_OTP_STOP_RELOAD_MIPI, 0x5A, 0x09);
+	dsi_generic_write_seq(dsi, 0x80, 0x64, 0x00, 0x64, 0x00, 0x00);
+	msleep(20);
+
+	dev_dbg(dev, "Panel init sequence done\n");
+	return 0;
+}
+
+static int mantix_enable(struct drm_panel *panel)
+{
+	struct mantix *ctx = panel_to_mantix(panel);
+	struct device *dev = ctx->dev;
+	struct mipi_dsi_device *dsi = to_mipi_dsi_device(dev);
+	int ret;
+
+	ret = mantix_init_sequence(ctx);
+	if (ret < 0) {
+		dev_err(ctx->dev, "Panel init sequence failed: %d\n", ret);
+		return ret;
+	}
+
+	ret = mipi_dsi_dcs_exit_sleep_mode(dsi);
+	if (ret < 0) {
+		dev_err(dev, "Failed to exit sleep mode\n");
+		return ret;
+	}
+	msleep(20);
+
+	ret = mipi_dsi_dcs_set_display_on(dsi);
+	if (ret)
+		return ret;
+	usleep_range(10000, 12000);
+
+	ret = mipi_dsi_turn_on_peripheral(dsi);
+	if (ret < 0) {
+		dev_err(dev, "Failed to turn on peripheral\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int mantix_disable(struct drm_panel *panel)
+{
+	struct mantix *ctx = panel_to_mantix(panel);
+	struct mipi_dsi_device *dsi = to_mipi_dsi_device(ctx->dev);
+	int ret;
+
+	ret = mipi_dsi_dcs_set_display_off(dsi);
+	if (ret < 0)
+		dev_err(ctx->dev, "Failed to turn off the display: %d\n", ret);
+
+	ret = mipi_dsi_dcs_enter_sleep_mode(dsi);
+	if (ret < 0)
+		dev_err(ctx->dev, "Failed to enter sleep mode: %d\n", ret);
+
+
+	return 0;
+}
+
+static int mantix_unprepare(struct drm_panel *panel)
+{
+	struct mantix *ctx = panel_to_mantix(panel);
+
+	regulator_disable(ctx->avee);
+	regulator_disable(ctx->avdd);
+	/* T11 */
+	usleep_range(5000, 6000);
+	regulator_disable(ctx->vddi);
+	/* T14 */
+	msleep(50);
+
+	return 0;
+}
+
+static int mantix_prepare(struct drm_panel *panel)
+{
+	struct mantix *ctx = panel_to_mantix(panel);
+	int ret;
+
+	/* Focaltech FT8006P, section 7.3.1 and 7.3.4 */
+	dev_dbg(ctx->dev, "Resetting the panel\n");
+	ret = regulator_enable(ctx->vddi);
+	if (ret < 0) {
+		dev_err(ctx->dev, "Failed to enable vddi supply: %d\n", ret);
+		return ret;
+	}
+	/* T1 + T2 */
+	usleep_range(8000, 10000);
+
+	ret = regulator_enable(ctx->avdd);
+	if (ret < 0) {
+		dev_err(ctx->dev, "Failed to enable avdd supply: %d\n", ret);
+		return ret;
+	}
+
+	/* T2d */
+	usleep_range(3500, 4000);
+	ret = regulator_enable(ctx->avee);
+	if (ret < 0) {
+		dev_err(ctx->dev, "Failed to enable avee supply: %d\n", ret);
+		return ret;
+	}
+
+	/* T3+T5 */
+	usleep_range(10000, 12000);
+
+	gpiod_set_value_cansleep(ctx->reset_gpio, 1);
+	usleep_range(5150, 7000);
+
+	gpiod_set_value_cansleep(ctx->reset_gpio, 0);
+
+	/* T6 */
+	msleep(50);
+
+	return 0;
+}
+
+static const struct drm_display_mode default_mode = {
+	.hdisplay    = 720,
+	.hsync_start = 720 + 45,
+	.hsync_end   = 720 + 45 + 14,
+	.htotal	     = 720 + 45 + 14 + 25,
+	.vdisplay    = 1440,
+	.vsync_start = 1440 + 130,
+	.vsync_end   = 1440 + 130 + 8,
+	.vtotal	     = 1440 + 130 + 8 + 106,
+	.clock	     = 85298,
+	.flags	     = DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC,
+	.width_mm    = 65,
+	.height_mm   = 130,
+};
+
+static int mantix_get_modes(struct drm_panel *panel,
+			    struct drm_connector *connector)
+{
+	struct mantix *ctx = panel_to_mantix(panel);
+	struct drm_display_mode *mode;
+
+	mode = drm_mode_duplicate(connector->dev, &default_mode);
+	if (!mode) {
+		dev_err(ctx->dev, "Failed to add mode %ux%u@%u\n",
+			default_mode.hdisplay, default_mode.vdisplay,
+			drm_mode_vrefresh(mode));
+		return -ENOMEM;
+	}
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
+static const struct drm_panel_funcs mantix_drm_funcs = {
+	.disable   = mantix_disable,
+	.unprepare = mantix_unprepare,
+	.prepare   = mantix_prepare,
+	.enable	   = mantix_enable,
+	.get_modes = mantix_get_modes,
+};
+
+static int mantix_probe(struct mipi_dsi_device *dsi)
+{
+	struct device *dev = &dsi->dev;
+	struct mantix *ctx;
+	int ret;
+
+	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	ctx->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
+	if (IS_ERR(ctx->reset_gpio)) {
+		dev_err(dev, "cannot get reset gpio\n");
+		return PTR_ERR(ctx->reset_gpio);
+	}
+
+	mipi_dsi_set_drvdata(dsi, ctx);
+	ctx->dev = dev;
+
+	dsi->lanes = 4;
+	dsi->format = MIPI_DSI_FMT_RGB888;
+	dsi->mode_flags = MIPI_DSI_MODE_VIDEO |
+		MIPI_DSI_MODE_VIDEO_BURST | MIPI_DSI_MODE_VIDEO_SYNC_PULSE;
+
+	ctx->avdd = devm_regulator_get(dev, "avdd");
+	if (IS_ERR(ctx->avdd))
+		return dev_err_probe(dev, PTR_ERR(ctx->avdd), "Failed to request avdd regulator\n");
+
+	ctx->avee = devm_regulator_get(dev, "avee");
+	if (IS_ERR(ctx->avee))
+		return dev_err_probe(dev, PTR_ERR(ctx->avee), "Failed to request avee regulator\n");
+
+	ctx->vddi = devm_regulator_get(dev, "vddi");
+	if (IS_ERR(ctx->vddi))
+		return dev_err_probe(dev, PTR_ERR(ctx->vddi), "Failed to request vddi regulator\n");
+
+	drm_panel_init(&ctx->panel, dev, &mantix_drm_funcs,
+		       DRM_MODE_CONNECTOR_DSI);
+
+	ret = drm_panel_of_backlight(&ctx->panel);
+	if (ret)
+		return ret;
+
+	drm_panel_add(&ctx->panel);
+
+	ret = mipi_dsi_attach(dsi);
+	if (ret < 0) {
+		dev_err(dev, "mipi_dsi_attach failed (%d). Is host ready?\n", ret);
+		drm_panel_remove(&ctx->panel);
+		return ret;
+	}
+
+	dev_info(dev, "%ux%u@%u %ubpp dsi %udl - ready\n",
+		 default_mode.hdisplay, default_mode.vdisplay,
+		 drm_mode_vrefresh(&default_mode),
+		 mipi_dsi_pixel_format_to_bpp(dsi->format), dsi->lanes);
+
+	return 0;
+}
+
+static void mantix_shutdown(struct mipi_dsi_device *dsi)
+{
+	struct mantix *ctx = mipi_dsi_get_drvdata(dsi);
+
+	drm_panel_unprepare(&ctx->panel);
+	drm_panel_disable(&ctx->panel);
+}
+
+static int mantix_remove(struct mipi_dsi_device *dsi)
+{
+	struct mantix *ctx = mipi_dsi_get_drvdata(dsi);
+
+	mantix_shutdown(dsi);
+
+	mipi_dsi_detach(dsi);
+	drm_panel_remove(&ctx->panel);
+
+	return 0;
+}
+
+static const struct of_device_id mantix_of_match[] = {
+	{ .compatible = "mantix,mlaf057we51-x" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, mantix_of_match);
+
+static struct mipi_dsi_driver mantix_driver = {
+	.probe	= mantix_probe,
+	.remove = mantix_remove,
+	.shutdown = mantix_shutdown,
+	.driver = {
+		.name = DRV_NAME,
+		.of_match_table = mantix_of_match,
+	},
+};
+module_mipi_dsi_driver(mantix_driver);
+
+MODULE_AUTHOR("Guido Günther <agx@sigxcpu.org>");
+MODULE_DESCRIPTION("DRM driver for Mantix MLAF057WE51-X MIPI DSI panel");
+MODULE_LICENSE("GPL v2");
-- 
2.26.2

