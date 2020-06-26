Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1F7FC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 00:56:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9628F2081A
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 00:56:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="azRibTE8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbgFZA4o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 20:56:44 -0400
Received: from vps.xff.cz ([195.181.215.36]:45188 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726667AbgFZA4K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 20:56:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1593132967; bh=SlEXwD28ceW0ryWeI1DcRtKQ+o2CROCThO4n27xkfJs=;
        h=From:To:Cc:Subject:Date:References:From;
        b=azRibTE85Omgyx2gilsCaphOn8gj/YoMM104MUtLqqpqEGOBeQZkuqF9/cr7PFxhr
         gkNQHen+k4nO99SySFM5I5KJbYZr3YhzucevBiKbyWimik5KxdixC0MPULVn6RXwHi
         wvUZNB4LaWBiqz8uAn+9bY2yoJxWwzmLiAdPk/JE=
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
Subject: [PATCH v5 08/13] drm/panel: st7703: Move generic part of init sequence to enable callback
Date:   Fri, 26 Jun 2020 02:55:56 +0200
Message-Id: <20200626005601.241022-9-megous@megous.com>
In-Reply-To: <20200626005601.241022-1-megous@megous.com>
References: <20200626005601.241022-1-megous@megous.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Calling sleep out and display on is a controller specific part
of the initialization process. Move it out of the panel specific
initialization function to the enable callback.

Signed-off-by: Ondrej Jirman <megous@megous.com>
---
 drivers/gpu/drm/panel/panel-sitronix-st7703.c | 33 ++++++++++---------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-sitronix-st7703.c b/drivers/gpu/drm/panel/panel-sitronix-st7703.c
index d03aab10cfef..cdbf7dfb4dd4 100644
--- a/drivers/gpu/drm/panel/panel-sitronix-st7703.c
+++ b/drivers/gpu/drm/panel/panel-sitronix-st7703.c
@@ -84,8 +84,6 @@ static inline struct st7703 *panel_to_st7703(struct drm_panel *panel)
 static int jh057n_init_sequence(struct st7703 *ctx)
 {
 	struct mipi_dsi_device *dsi = to_mipi_dsi_device(ctx->dev);
-	struct device *dev = ctx->dev;
-	int ret;
 
 	/*
 	 * Init sequence was supplied by the panel vendor. Most of the commands
@@ -136,20 +134,7 @@ static int jh057n_init_sequence(struct st7703 *ctx)
 			      0x18, 0x00, 0x09, 0x0E, 0x29, 0x2D, 0x3C, 0x41,
 			      0x37, 0x07, 0x0B, 0x0D, 0x10, 0x11, 0x0F, 0x10,
 			      0x11, 0x18);
-	msleep(20);
-
-	ret = mipi_dsi_dcs_exit_sleep_mode(dsi);
-	if (ret < 0) {
-		DRM_DEV_ERROR(dev, "Failed to exit sleep mode: %d\n", ret);
-		return ret;
-	}
-	/* Panel is operational 120 msec after reset */
-	msleep(60);
-	ret = mipi_dsi_dcs_set_display_on(dsi);
-	if (ret)
-		return ret;
 
-	DRM_DEV_DEBUG_DRIVER(dev, "Panel init sequence done\n");
 	return 0;
 }
 
@@ -181,6 +166,7 @@ struct st7703_panel_desc jh057n00900_panel_desc = {
 static int st7703_enable(struct drm_panel *panel)
 {
 	struct st7703 *ctx = panel_to_st7703(panel);
+	struct mipi_dsi_device *dsi = to_mipi_dsi_device(ctx->dev);
 	int ret;
 
 	ret = ctx->desc->init_sequence(ctx);
@@ -190,6 +176,23 @@ static int st7703_enable(struct drm_panel *panel)
 		return ret;
 	}
 
+	msleep(20);
+
+	ret = mipi_dsi_dcs_exit_sleep_mode(dsi);
+	if (ret < 0) {
+		DRM_DEV_ERROR(ctx->dev, "Failed to exit sleep mode: %d\n", ret);
+		return ret;
+	}
+
+	/* Panel is operational 120 msec after reset */
+	msleep(60);
+
+	ret = mipi_dsi_dcs_set_display_on(dsi);
+	if (ret)
+		return ret;
+
+	DRM_DEV_DEBUG_DRIVER(ctx->dev, "Panel init sequence done\n");
+
 	return 0;
 }
 
-- 
2.27.0

