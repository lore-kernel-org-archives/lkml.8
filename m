Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4951BC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 00:56:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23255207D8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 00:56:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="fPZl5job"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbgFZA4q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 20:56:46 -0400
Received: from vps.xff.cz ([195.181.215.36]:45178 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726607AbgFZA4K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 20:56:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1593132966; bh=H4Ey/axNrmDO8uWqgGRB90xGu+wTgBcSE26SENeyZ7Y=;
        h=From:To:Cc:Subject:Date:References:From;
        b=fPZl5job8L5Vj6SXEpUmEWt1xp72Di5hQdqIqR5g3buxh9QvctA9uN7Ow2j5YH5hG
         CYIi3OhHwRcGi6jvYae0ifvAgU9f7HJ4o7vxWjle2AQCnUcCi6eGUxuSD9eY+nkSBd
         oZAtXBJ8y7NTPjyv2B5Mx3RqUTvfED7aFvw4oZFc=
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
Subject: [PATCH v5 06/13] drm/panel: st7703: Prepare for supporting multiple panels
Date:   Fri, 26 Jun 2020 02:55:54 +0200
Message-Id: <20200626005601.241022-7-megous@megous.com>
In-Reply-To: <20200626005601.241022-1-megous@megous.com>
References: <20200626005601.241022-1-megous@megous.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Parametrize the driver so that it can support more panels based
on st7703 controller.

Signed-off-by: Ondrej Jirman <megous@megous.com>
---
 drivers/gpu/drm/panel/panel-sitronix-st7703.c | 43 +++++++++++++------
 1 file changed, 31 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-sitronix-st7703.c b/drivers/gpu/drm/panel/panel-sitronix-st7703.c
index 511af659f273..08cbc316266c 100644
--- a/drivers/gpu/drm/panel/panel-sitronix-st7703.c
+++ b/drivers/gpu/drm/panel/panel-sitronix-st7703.c
@@ -13,6 +13,7 @@
 #include <linux/media-bus-format.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
+#include <linux/of_device.h>
 #include <linux/regulator/consumer.h>
 
 #include <video/display_timing.h>
@@ -56,6 +57,15 @@ struct st7703 {
 	bool prepared;
 
 	struct dentry *debugfs;
+	const struct st7703_panel_desc *desc;
+};
+
+struct st7703_panel_desc {
+	const struct drm_display_mode *mode;
+	unsigned int lanes;
+	unsigned long mode_flags;
+	enum mipi_dsi_pixel_format format;
+	int (*init_sequence)(struct st7703 *ctx);
 };
 
 static inline struct st7703 *panel_to_st7703(struct drm_panel *panel)
@@ -148,7 +158,7 @@ static int st7703_enable(struct drm_panel *panel)
 	struct st7703 *ctx = panel_to_st7703(panel);
 	int ret;
 
-	ret = jh057n_init_sequence(ctx);
+	ret = ctx->desc->init_sequence(ctx);
 	if (ret < 0) {
 		DRM_DEV_ERROR(ctx->dev, "Panel init sequence failed: %d\n",
 			      ret);
@@ -216,7 +226,7 @@ static int st7703_prepare(struct drm_panel *panel)
 	return ret;
 }
 
-static const struct drm_display_mode default_mode = {
+static const struct drm_display_mode jh057n00900_mode = {
 	.hdisplay    = 720,
 	.hsync_start = 720 + 90,
 	.hsync_end   = 720 + 90 + 20,
@@ -232,17 +242,26 @@ static const struct drm_display_mode default_mode = {
 	.height_mm   = 130,
 };
 
+struct st7703_panel_desc jh057n00900_panel_desc = {
+	.mode = &jh057n00900_mode,
+	.lanes = 4,
+	.mode_flags = MIPI_DSI_MODE_VIDEO |
+		MIPI_DSI_MODE_VIDEO_BURST | MIPI_DSI_MODE_VIDEO_SYNC_PULSE,
+	.format = MIPI_DSI_FMT_RGB888,
+	.init_sequence = jh057n_init_sequence,
+};
+
 static int st7703_get_modes(struct drm_panel *panel,
 			    struct drm_connector *connector)
 {
 	struct st7703 *ctx = panel_to_st7703(panel);
 	struct drm_display_mode *mode;
 
-	mode = drm_mode_duplicate(connector->dev, &default_mode);
+	mode = drm_mode_duplicate(connector->dev, ctx->desc->mode);
 	if (!mode) {
 		DRM_DEV_ERROR(ctx->dev, "Failed to add mode %ux%u@%u\n",
-			      default_mode.hdisplay, default_mode.vdisplay,
-			      default_mode.vrefresh);
+			      ctx->desc->mode->hdisplay, ctx->desc->mode->vdisplay,
+			      ctx->desc->mode->vrefresh);
 		return -ENOMEM;
 	}
 
@@ -317,11 +336,11 @@ static int st7703_probe(struct mipi_dsi_device *dsi)
 	mipi_dsi_set_drvdata(dsi, ctx);
 
 	ctx->dev = dev;
+	ctx->desc = of_device_get_match_data(dev);
 
-	dsi->lanes = 4;
-	dsi->format = MIPI_DSI_FMT_RGB888;
-	dsi->mode_flags = MIPI_DSI_MODE_VIDEO |
-		MIPI_DSI_MODE_VIDEO_BURST | MIPI_DSI_MODE_VIDEO_SYNC_PULSE;
+	dsi->mode_flags = ctx->desc->mode_flags;
+	dsi->format = ctx->desc->format;
+	dsi->lanes = ctx->desc->lanes;
 
 	ctx->vcc = devm_regulator_get(dev, "vcc");
 	if (IS_ERR(ctx->vcc)) {
@@ -361,8 +380,8 @@ static int st7703_probe(struct mipi_dsi_device *dsi)
 	}
 
 	DRM_DEV_INFO(dev, "%ux%u@%u %ubpp dsi %udl - ready\n",
-		     default_mode.hdisplay, default_mode.vdisplay,
-		     default_mode.vrefresh,
+		     ctx->desc->mode->hdisplay, ctx->desc->mode->vdisplay,
+		     ctx->desc->mode->vrefresh,
 		     mipi_dsi_pixel_format_to_bpp(dsi->format), dsi->lanes);
 
 	st7703_debugfs_init(ctx);
@@ -405,7 +424,7 @@ static int st7703_remove(struct mipi_dsi_device *dsi)
 }
 
 static const struct of_device_id st7703_of_match[] = {
-	{ .compatible = "rocktech,jh057n00900" },
+	{ .compatible = "rocktech,jh057n00900", .data = &jh057n00900_panel_desc },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, st7703_of_match);
-- 
2.27.0

