Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 231CAC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 18:14:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8AEE20658
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 18:14:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="hm8beoJ8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbgHSSOW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 14:14:22 -0400
Received: from crapouillou.net ([89.234.176.41]:33510 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726752AbgHSSOW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 14:14:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1597860859; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=5c5IoiPKi0fMwsMeS7rjzW98yLfOTqq/xBiDWbuXaD8=;
        b=hm8beoJ8EQWKWcZkodG9RmurbF7RTScERi3pXjHHxW/1sNVLufy7uD6bpQodd60XbU637G
        3uaT/kFvRLRF+J71CmDUOUFCcXuo7a9eUJz80M2Jvr57BsaKeCkPqaf3JErXtCp/7gqUxr
        TE3MpnX0HVX4lMKNBMczmCEfzOpX/ik=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     od@zcrc.me, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH] drm/panel: novatek,nt39016: Remove 'dev' field in priv struct
Date:   Wed, 19 Aug 2020 20:14:12 +0200
Message-Id: <20200819181412.137785-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is already a 'struct device' pointer in the drm_panel structure,
that we can access easily from our priv structure, so there's no need
for a separate 'dev' field there.

This also allows drm_panel_of_backlight() to work properly, as it
requires the drm_panel.dev field to be initialized.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/gpu/drm/panel/panel-novatek-nt39016.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-novatek-nt39016.c b/drivers/gpu/drm/panel/panel-novatek-nt39016.c
index 39f7be679da5..292ad1d58313 100644
--- a/drivers/gpu/drm/panel/panel-novatek-nt39016.c
+++ b/drivers/gpu/drm/panel/panel-novatek-nt39016.c
@@ -56,7 +56,6 @@ struct nt39016_panel_info {
 
 struct nt39016 {
 	struct drm_panel drm_panel;
-	struct device *dev;
 	struct regmap *map;
 	struct regulator *supply;
 	const struct nt39016_panel_info *panel_info;
@@ -124,7 +123,7 @@ static int nt39016_prepare(struct drm_panel *drm_panel)
 
 	err = regulator_enable(panel->supply);
 	if (err) {
-		dev_err(panel->dev, "Failed to enable power supply: %d\n", err);
+		dev_err(drm_panel->dev, "Failed to enable power supply: %d\n", err);
 		return err;
 	}
 
@@ -143,7 +142,7 @@ static int nt39016_prepare(struct drm_panel *drm_panel)
 	err = regmap_multi_reg_write(panel->map, nt39016_panel_regs,
 				     ARRAY_SIZE(nt39016_panel_regs));
 	if (err) {
-		dev_err(panel->dev, "Failed to init registers: %d\n", err);
+		dev_err(drm_panel->dev, "Failed to init registers: %d\n", err);
 		goto err_disable_regulator;
 	}
 
@@ -173,7 +172,7 @@ static int nt39016_enable(struct drm_panel *drm_panel)
 	ret = regmap_write(panel->map, NT39016_REG_SYSTEM,
 			   NT39016_SYSTEM_RESET_N | NT39016_SYSTEM_STANDBY);
 	if (ret) {
-		dev_err(panel->dev, "Unable to enable panel: %d\n", ret);
+		dev_err(drm_panel->dev, "Unable to enable panel: %d\n", ret);
 		return ret;
 	}
 
@@ -193,7 +192,7 @@ static int nt39016_disable(struct drm_panel *drm_panel)
 	err = regmap_write(panel->map, NT39016_REG_SYSTEM,
 			   NT39016_SYSTEM_RESET_N);
 	if (err) {
-		dev_err(panel->dev, "Unable to disable panel: %d\n", err);
+		dev_err(drm_panel->dev, "Unable to disable panel: %d\n", err);
 		return err;
 	}
 
@@ -252,7 +251,7 @@ static int nt39016_probe(struct spi_device *spi)
 	if (!panel)
 		return -ENOMEM;
 
-	panel->dev = dev;
+	panel->drm_panel.dev = dev;
 	spi_set_drvdata(spi, panel);
 
 	panel->panel_info = of_device_get_match_data(dev);
-- 
2.28.0

