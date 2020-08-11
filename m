Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 210C1C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 00:23:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE91920716
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 00:23:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="pK9ShE4t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728055AbgHKAXJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 20:23:09 -0400
Received: from crapouillou.net ([89.234.176.41]:38632 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726984AbgHKAXI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 20:23:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1597105372; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JjIL9moCS0z1R5alv49aEL6O8PlqQzsA7GoxoF/cqMw=;
        b=pK9ShE4tFRjKFD+mxFvMa/9QiWoOgvWQPajZrDK8Gng10jd0U2ta3YPUdqCwxlBB6sNNnG
        aIx1XIjVVZK7U+zQ2VI50PAL9gDHYxPE+1xHjDAqjmXI8oOe8fvAV0rCmbIFAQRjFPkZgw
        JeP7SmmvFEo+ZriFb6yWXGOhR+VX8W4=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        od@zcrc.me, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 2/5] drm/panel: novatek,nt39016: Add missing CR to error messages
Date:   Tue, 11 Aug 2020 02:22:37 +0200
Message-Id: <20200811002240.55194-3-paul@crapouillou.net>
In-Reply-To: <20200811002240.55194-1-paul@crapouillou.net>
References: <20200811002240.55194-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If you pass a string that is not terminated with a carriage return to
dev_err(), it will eventually be printed with a carriage return, but
not right away, since the kernel will wait for a pr_cont().

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/gpu/drm/panel/panel-novatek-nt39016.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-novatek-nt39016.c b/drivers/gpu/drm/panel/panel-novatek-nt39016.c
index ba05165b6050..39f7be679da5 100644
--- a/drivers/gpu/drm/panel/panel-novatek-nt39016.c
+++ b/drivers/gpu/drm/panel/panel-novatek-nt39016.c
@@ -124,7 +124,7 @@ static int nt39016_prepare(struct drm_panel *drm_panel)
 
 	err = regulator_enable(panel->supply);
 	if (err) {
-		dev_err(panel->dev, "Failed to enable power supply: %d", err);
+		dev_err(panel->dev, "Failed to enable power supply: %d\n", err);
 		return err;
 	}
 
@@ -143,7 +143,7 @@ static int nt39016_prepare(struct drm_panel *drm_panel)
 	err = regmap_multi_reg_write(panel->map, nt39016_panel_regs,
 				     ARRAY_SIZE(nt39016_panel_regs));
 	if (err) {
-		dev_err(panel->dev, "Failed to init registers: %d", err);
+		dev_err(panel->dev, "Failed to init registers: %d\n", err);
 		goto err_disable_regulator;
 	}
 
@@ -173,7 +173,7 @@ static int nt39016_enable(struct drm_panel *drm_panel)
 	ret = regmap_write(panel->map, NT39016_REG_SYSTEM,
 			   NT39016_SYSTEM_RESET_N | NT39016_SYSTEM_STANDBY);
 	if (ret) {
-		dev_err(panel->dev, "Unable to enable panel: %d", ret);
+		dev_err(panel->dev, "Unable to enable panel: %d\n", ret);
 		return ret;
 	}
 
@@ -193,7 +193,7 @@ static int nt39016_disable(struct drm_panel *drm_panel)
 	err = regmap_write(panel->map, NT39016_REG_SYSTEM,
 			   NT39016_SYSTEM_RESET_N);
 	if (err) {
-		dev_err(panel->dev, "Unable to disable panel: %d", err);
+		dev_err(panel->dev, "Unable to disable panel: %d\n", err);
 		return err;
 	}
 
@@ -261,13 +261,13 @@ static int nt39016_probe(struct spi_device *spi)
 
 	panel->supply = devm_regulator_get(dev, "power");
 	if (IS_ERR(panel->supply)) {
-		dev_err(dev, "Failed to get power supply");
+		dev_err(dev, "Failed to get power supply\n");
 		return PTR_ERR(panel->supply);
 	}
 
 	panel->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
 	if (IS_ERR(panel->reset_gpio)) {
-		dev_err(dev, "Failed to get reset GPIO");
+		dev_err(dev, "Failed to get reset GPIO\n");
 		return PTR_ERR(panel->reset_gpio);
 	}
 
@@ -275,20 +275,20 @@ static int nt39016_probe(struct spi_device *spi)
 	spi->mode = SPI_MODE_3 | SPI_3WIRE;
 	err = spi_setup(spi);
 	if (err) {
-		dev_err(dev, "Failed to setup SPI");
+		dev_err(dev, "Failed to setup SPI\n");
 		return err;
 	}
 
 	panel->map = devm_regmap_init_spi(spi, &nt39016_regmap_config);
 	if (IS_ERR(panel->map)) {
-		dev_err(dev, "Failed to init regmap");
+		dev_err(dev, "Failed to init regmap\n");
 		return PTR_ERR(panel->map);
 	}
 
 	err = drm_panel_of_backlight(&panel->drm_panel);
 	if (err) {
 		if (err != -EPROBE_DEFER)
-			dev_err(dev, "Failed to get backlight handle");
+			dev_err(dev, "Failed to get backlight handle\n");
 		return err;
 	}
 
-- 
2.28.0

