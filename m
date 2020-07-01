Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4EE1C433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 16:29:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 664BB20781
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 16:29:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="DqCF3jkS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732439AbgGAQ3n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 12:29:43 -0400
Received: from vps.xff.cz ([195.181.215.36]:52284 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732384AbgGAQ3h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 12:29:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1593620973; bh=EDHzW5S2+qb2oeqA0b2GK7kayadrwI5GDPCMTwgUIPA=;
        h=From:To:Cc:Subject:Date:References:From;
        b=DqCF3jkSJzh0D5n4bdh3w+d/XLwdJE8qVKBF5F9A5BWtCIaOo54Kk+DIepIRVtJG6
         ZLa8BZ38T6cqRguNK/aoOYhwRhmj8zdPMqv2aG+IPGbp2udNxmCtUSM7TVb6cHu+uA
         +4jahIGnjuar8gwEQ0eF0cWTne9ZIPcfe4vOhZCg=
From:   Ondrej Jirman <megous@megous.com>
To:     linux-sunxi@googlegroups.com,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        Purism Kernel Team <kernel@puri.sm>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Icenowy Zheng <icenowy@aosc.io>
Cc:     Ondrej Jirman <megous@megous.com>, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Samuel Holland <samuel@sholland.org>,
        Martijn Braam <martijn@brixit.nl>, Luca Weiss <luca@z3ntu.xyz>,
        Bhushan Shah <bshah@kde.org>
Subject: [PATCH v7 05/13] drm/panel: st7703: Rename functions from jh057n prefix to st7703
Date:   Wed,  1 Jul 2020 18:29:20 +0200
Message-Id: <20200701162928.1638874-6-megous@megous.com>
In-Reply-To: <20200701162928.1638874-1-megous@megous.com>
References: <20200701162928.1638874-1-megous@megous.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is done so that code that's not specific to a particular
jh057n panel is named after the controller. Functions specific
to the panel are kept named after the panel.

Signed-off-by: Ondrej Jirman <megous@megous.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpu/drm/panel/panel-sitronix-st7703.c | 90 ++++++++++---------
 1 file changed, 46 insertions(+), 44 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-sitronix-st7703.c b/drivers/gpu/drm/panel/panel-sitronix-st7703.c
index da4e373291f9..14761fec3789 100644
--- a/drivers/gpu/drm/panel/panel-sitronix-st7703.c
+++ b/drivers/gpu/drm/panel/panel-sitronix-st7703.c
@@ -1,6 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Rockteck jh057n00900 5.5" MIPI-DSI panel driver
+ * Driver for panels based on Sitronix ST7703 controller, souch as:
+ *
+ * - Rocktech jh057n00900 5.5" MIPI-DSI panel
  *
  * Copyright (C) Purism SPC 2019
  */
@@ -21,7 +23,7 @@
 #include <drm/drm_panel.h>
 #include <drm/drm_print.h>
 
-#define DRV_NAME "panel-rocktech-jh057n00900"
+#define DRV_NAME "panel-sitronix-st7703"
 
 /* Manufacturer specific Commands send via DSI */
 #define ST7703_CMD_ALL_PIXEL_OFF 0x22
@@ -45,7 +47,7 @@
 #define ST7703_CMD_SETGIP1	 0xE9
 #define ST7703_CMD_SETGIP2	 0xEA
 
-struct jh057n {
+struct st7703 {
 	struct device *dev;
 	struct drm_panel panel;
 	struct gpio_desc *reset_gpio;
@@ -56,9 +58,9 @@ struct jh057n {
 	struct dentry *debugfs;
 };
 
-static inline struct jh057n *panel_to_jh057n(struct drm_panel *panel)
+static inline struct st7703 *panel_to_st7703(struct drm_panel *panel)
 {
-	return container_of(panel, struct jh057n, panel);
+	return container_of(panel, struct st7703, panel);
 }
 
 #define dsi_generic_write_seq(dsi, seq...) do {				\
@@ -69,7 +71,7 @@ static inline struct jh057n *panel_to_jh057n(struct drm_panel *panel)
 			return ret;					\
 	} while (0)
 
-static int jh057n_init_sequence(struct jh057n *ctx)
+static int jh057n_init_sequence(struct st7703 *ctx)
 {
 	struct mipi_dsi_device *dsi = to_mipi_dsi_device(ctx->dev);
 	struct device *dev = ctx->dev;
@@ -141,9 +143,9 @@ static int jh057n_init_sequence(struct jh057n *ctx)
 	return 0;
 }
 
-static int jh057n_enable(struct drm_panel *panel)
+static int st7703_enable(struct drm_panel *panel)
 {
-	struct jh057n *ctx = panel_to_jh057n(panel);
+	struct st7703 *ctx = panel_to_st7703(panel);
 	int ret;
 
 	ret = jh057n_init_sequence(ctx);
@@ -156,17 +158,17 @@ static int jh057n_enable(struct drm_panel *panel)
 	return 0;
 }
 
-static int jh057n_disable(struct drm_panel *panel)
+static int st7703_disable(struct drm_panel *panel)
 {
-	struct jh057n *ctx = panel_to_jh057n(panel);
+	struct st7703 *ctx = panel_to_st7703(panel);
 	struct mipi_dsi_device *dsi = to_mipi_dsi_device(ctx->dev);
 
 	return mipi_dsi_dcs_set_display_off(dsi);
 }
 
-static int jh057n_unprepare(struct drm_panel *panel)
+static int st7703_unprepare(struct drm_panel *panel)
 {
-	struct jh057n *ctx = panel_to_jh057n(panel);
+	struct st7703 *ctx = panel_to_st7703(panel);
 
 	if (!ctx->prepared)
 		return 0;
@@ -178,9 +180,9 @@ static int jh057n_unprepare(struct drm_panel *panel)
 	return 0;
 }
 
-static int jh057n_prepare(struct drm_panel *panel)
+static int st7703_prepare(struct drm_panel *panel)
 {
-	struct jh057n *ctx = panel_to_jh057n(panel);
+	struct st7703 *ctx = panel_to_st7703(panel);
 	int ret;
 
 	if (ctx->prepared)
@@ -229,10 +231,10 @@ static const struct drm_display_mode default_mode = {
 	.height_mm   = 130,
 };
 
-static int jh057n_get_modes(struct drm_panel *panel,
+static int st7703_get_modes(struct drm_panel *panel,
 			    struct drm_connector *connector)
 {
-	struct jh057n *ctx = panel_to_jh057n(panel);
+	struct st7703 *ctx = panel_to_st7703(panel);
 	struct drm_display_mode *mode;
 
 	mode = drm_mode_duplicate(connector->dev, &default_mode);
@@ -253,17 +255,17 @@ static int jh057n_get_modes(struct drm_panel *panel,
 	return 1;
 }
 
-static const struct drm_panel_funcs jh057n_drm_funcs = {
-	.disable   = jh057n_disable,
-	.unprepare = jh057n_unprepare,
-	.prepare   = jh057n_prepare,
-	.enable	   = jh057n_enable,
-	.get_modes = jh057n_get_modes,
+static const struct drm_panel_funcs st7703_drm_funcs = {
+	.disable   = st7703_disable,
+	.unprepare = st7703_unprepare,
+	.prepare   = st7703_prepare,
+	.enable	   = st7703_enable,
+	.get_modes = st7703_get_modes,
 };
 
 static int allpixelson_set(void *data, u64 val)
 {
-	struct jh057n *ctx = data;
+	struct st7703 *ctx = data;
 	struct mipi_dsi_device *dsi = to_mipi_dsi_device(ctx->dev);
 
 	DRM_DEV_DEBUG_DRIVER(ctx->dev, "Setting all pixels on\n");
@@ -281,7 +283,7 @@ static int allpixelson_set(void *data, u64 val)
 DEFINE_SIMPLE_ATTRIBUTE(allpixelson_fops, NULL,
 			allpixelson_set, "%llu\n");
 
-static void jh057n_debugfs_init(struct jh057n *ctx)
+static void st7703_debugfs_init(struct st7703 *ctx)
 {
 	ctx->debugfs = debugfs_create_dir(DRV_NAME, NULL);
 
@@ -289,16 +291,16 @@ static void jh057n_debugfs_init(struct jh057n *ctx)
 			    &allpixelson_fops);
 }
 
-static void jh057n_debugfs_remove(struct jh057n *ctx)
+static void st7703_debugfs_remove(struct st7703 *ctx)
 {
 	debugfs_remove_recursive(ctx->debugfs);
 	ctx->debugfs = NULL;
 }
 
-static int jh057n_probe(struct mipi_dsi_device *dsi)
+static int st7703_probe(struct mipi_dsi_device *dsi)
 {
 	struct device *dev = &dsi->dev;
-	struct jh057n *ctx;
+	struct st7703 *ctx;
 	int ret;
 
 	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
@@ -339,7 +341,7 @@ static int jh057n_probe(struct mipi_dsi_device *dsi)
 		return ret;
 	}
 
-	drm_panel_init(&ctx->panel, dev, &jh057n_drm_funcs,
+	drm_panel_init(&ctx->panel, dev, &st7703_drm_funcs,
 		       DRM_MODE_CONNECTOR_DSI);
 
 	ret = drm_panel_of_backlight(&ctx->panel);
@@ -362,13 +364,13 @@ static int jh057n_probe(struct mipi_dsi_device *dsi)
 		     drm_mode_vrefresh(&default_mode),
 		     mipi_dsi_pixel_format_to_bpp(dsi->format), dsi->lanes);
 
-	jh057n_debugfs_init(ctx);
+	st7703_debugfs_init(ctx);
 	return 0;
 }
 
-static void jh057n_shutdown(struct mipi_dsi_device *dsi)
+static void st7703_shutdown(struct mipi_dsi_device *dsi)
 {
-	struct jh057n *ctx = mipi_dsi_get_drvdata(dsi);
+	struct st7703 *ctx = mipi_dsi_get_drvdata(dsi);
 	int ret;
 
 	ret = drm_panel_unprepare(&ctx->panel);
@@ -382,12 +384,12 @@ static void jh057n_shutdown(struct mipi_dsi_device *dsi)
 			      ret);
 }
 
-static int jh057n_remove(struct mipi_dsi_device *dsi)
+static int st7703_remove(struct mipi_dsi_device *dsi)
 {
-	struct jh057n *ctx = mipi_dsi_get_drvdata(dsi);
+	struct st7703 *ctx = mipi_dsi_get_drvdata(dsi);
 	int ret;
 
-	jh057n_shutdown(dsi);
+	st7703_shutdown(dsi);
 
 	ret = mipi_dsi_detach(dsi);
 	if (ret < 0)
@@ -396,28 +398,28 @@ static int jh057n_remove(struct mipi_dsi_device *dsi)
 
 	drm_panel_remove(&ctx->panel);
 
-	jh057n_debugfs_remove(ctx);
+	st7703_debugfs_remove(ctx);
 
 	return 0;
 }
 
-static const struct of_device_id jh057n_of_match[] = {
+static const struct of_device_id st7703_of_match[] = {
 	{ .compatible = "rocktech,jh057n00900" },
 	{ /* sentinel */ }
 };
-MODULE_DEVICE_TABLE(of, jh057n_of_match);
+MODULE_DEVICE_TABLE(of, st7703_of_match);
 
-static struct mipi_dsi_driver jh057n_driver = {
-	.probe	= jh057n_probe,
-	.remove = jh057n_remove,
-	.shutdown = jh057n_shutdown,
+static struct mipi_dsi_driver st7703_driver = {
+	.probe	= st7703_probe,
+	.remove = st7703_remove,
+	.shutdown = st7703_shutdown,
 	.driver = {
 		.name = DRV_NAME,
-		.of_match_table = jh057n_of_match,
+		.of_match_table = st7703_of_match,
 	},
 };
-module_mipi_dsi_driver(jh057n_driver);
+module_mipi_dsi_driver(st7703_driver);
 
 MODULE_AUTHOR("Guido Günther <agx@sigxcpu.org>");
-MODULE_DESCRIPTION("DRM driver for Rocktech JH057N00900 MIPI DSI panel");
+MODULE_DESCRIPTION("DRM driver for Sitronix ST7703 based MIPI DSI panels");
 MODULE_LICENSE("GPL v2");
-- 
2.27.0

