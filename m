Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95878C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 00:23:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7152B20716
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 00:23:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="d197E3XB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728042AbgHKAXB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 20:23:01 -0400
Received: from crapouillou.net ([89.234.176.41]:38598 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727992AbgHKAXA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 20:23:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1597105371; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2pAnB95G7HfE2UWr4cxMF2djUoaYxRElPvRjpK6hlhU=;
        b=d197E3XBewJUXplkkmNY5MDQQycQSD3sInAosPbLbaIWyW3QctL81PILqzExjMzqAK6Tpl
        zVIHQMD4Ytr/HobyXEF+lwNf7Aw50+I8/IkBtpn0wk+GEQhsf+SAjeXMvoFYOtrZa5IDA8
        SaB12kToN3cNWv2dFe/J9563P2p/Nl8=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        od@zcrc.me, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 1/5] drm/panel: novatek,nt39016: Handle backlight the standard way
Date:   Tue, 11 Aug 2020 02:22:36 +0200
Message-Id: <20200811002240.55194-2-paul@crapouillou.net>
In-Reply-To: <20200811002240.55194-1-paul@crapouillou.net>
References: <20200811002240.55194-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of manipulating the backlight directly in this driver, register
it in the probe using drm_panel_of_backlight() and let the drm_panel
framework code handle it.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/gpu/drm/panel/panel-novatek-nt39016.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-novatek-nt39016.c b/drivers/gpu/drm/panel/panel-novatek-nt39016.c
index 3d15d9925204..ba05165b6050 100644
--- a/drivers/gpu/drm/panel/panel-novatek-nt39016.c
+++ b/drivers/gpu/drm/panel/panel-novatek-nt39016.c
@@ -6,7 +6,6 @@
  * Copyright (C) 2019, Paul Cercueil <paul@crapouillou.net>
  */
 
-#include <linux/backlight.h>
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/gpio/consumer.h>
@@ -63,8 +62,6 @@ struct nt39016 {
 	const struct nt39016_panel_info *panel_info;
 
 	struct gpio_desc *reset_gpio;
-
-	struct backlight_device *backlight;
 };
 
 static inline struct nt39016 *to_nt39016(struct drm_panel *panel)
@@ -180,14 +177,12 @@ static int nt39016_enable(struct drm_panel *drm_panel)
 		return ret;
 	}
 
-	if (panel->backlight) {
+	if (drm_panel->backlight) {
 		/* Wait for the picture to be ready before enabling backlight */
 		msleep(150);
-
-		ret = backlight_enable(panel->backlight);
 	}
 
-	return ret;
+	return 0;
 }
 
 static int nt39016_disable(struct drm_panel *drm_panel)
@@ -195,8 +190,6 @@ static int nt39016_disable(struct drm_panel *drm_panel)
 	struct nt39016 *panel = to_nt39016(drm_panel);
 	int err;
 
-	backlight_disable(panel->backlight);
-
 	err = regmap_write(panel->map, NT39016_REG_SYSTEM,
 			   NT39016_SYSTEM_RESET_N);
 	if (err) {
@@ -292,9 +285,8 @@ static int nt39016_probe(struct spi_device *spi)
 		return PTR_ERR(panel->map);
 	}
 
-	panel->backlight = devm_of_find_backlight(dev);
-	if (IS_ERR(panel->backlight)) {
-		err = PTR_ERR(panel->backlight);
+	err = drm_panel_of_backlight(&panel->drm_panel);
+	if (err) {
 		if (err != -EPROBE_DEFER)
 			dev_err(dev, "Failed to get backlight handle");
 		return err;
-- 
2.28.0

