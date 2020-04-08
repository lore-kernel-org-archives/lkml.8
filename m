Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF6F3C2D0EA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 09:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8B0120753
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 09:58:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="IqCD+Fe8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728078AbgDHJ6k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 05:58:40 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:33762 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbgDHJ6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 05:58:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1586339918; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=g62+P3BKA22iNR7eW+jsO/H0my3pBTnlVMgtoacBEdI=;
        b=IqCD+Fe8iXpPYgZyB4FiufcmedzXHNTYVtshHKXUrSBnmvcKn6oDW1WYFWaua7QWS0vIhH
        xb1EW+/mtjoDCBoXPpGywY0A2ILVc33DoC/RXCx5bBK2ErUgyGDtXtVAGf5r5J7igRmeNR
        6oVPctrzbvuwalTWhSrWobxLzOYTa0U=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     od@zcrc.me, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 1/2] drm/panel: NT39016: Add support for multiple modes
Date:   Wed,  8 Apr 2020 11:58:29 +0200
Message-Id: <20200408095830.8131-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for multiple drm_display_mode entries. This will allow to
add a 50 Hz mode later.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/gpu/drm/panel/panel-novatek-nt39016.c | 33 +++++++++++++------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-novatek-nt39016.c b/drivers/gpu/drm/panel/panel-novatek-nt39016.c
index a470810f7dbe..f1286cf6528b 100644
--- a/drivers/gpu/drm/panel/panel-novatek-nt39016.c
+++ b/drivers/gpu/drm/panel/panel-novatek-nt39016.c
@@ -49,7 +49,8 @@ enum nt39016_regs {
 #define NT39016_SYSTEM_STANDBY	BIT(1)
 
 struct nt39016_panel_info {
-	struct drm_display_mode display_mode;
+	const struct drm_display_mode *display_modes;
+	unsigned int num_modes;
 	u16 width_mm, height_mm;
 	u32 bus_format, bus_flags;
 };
@@ -212,15 +213,22 @@ static int nt39016_get_modes(struct drm_panel *drm_panel,
 	struct nt39016 *panel = to_nt39016(drm_panel);
 	const struct nt39016_panel_info *panel_info = panel->panel_info;
 	struct drm_display_mode *mode;
+	unsigned int i;
 
-	mode = drm_mode_duplicate(connector->dev, &panel_info->display_mode);
-	if (!mode)
-		return -ENOMEM;
+	for (i = 0; i < panel_info->num_modes; i++) {
+		mode = drm_mode_duplicate(connector->dev,
+					  &panel_info->display_modes[i]);
+		if (!mode)
+			return -ENOMEM;
+
+		drm_mode_set_name(mode);
 
-	drm_mode_set_name(mode);
+		mode->type = DRM_MODE_TYPE_DRIVER;
+		if (panel_info->num_modes == 1)
+			mode->type |= DRM_MODE_TYPE_PREFERRED;
 
-	mode->type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED;
-	drm_mode_probed_add(connector, mode);
+		drm_mode_probed_add(connector, mode);
+	}
 
 	connector->display_info.bpc = 8;
 	connector->display_info.width_mm = panel_info->width_mm;
@@ -230,7 +238,7 @@ static int nt39016_get_modes(struct drm_panel *drm_panel,
 					 &panel_info->bus_format, 1);
 	connector->display_info.bus_flags = panel_info->bus_flags;
 
-	return 1;
+	return panel_info->num_modes;
 }
 
 static const struct drm_panel_funcs nt39016_funcs = {
@@ -316,8 +324,8 @@ static int nt39016_remove(struct spi_device *spi)
 	return 0;
 }
 
-static const struct nt39016_panel_info kd035g6_info = {
-	.display_mode = {
+static const struct drm_display_mode kd035g6_display_modes[] = {
+	{
 		.clock = 6000,
 		.hdisplay = 320,
 		.hsync_start = 320 + 10,
@@ -330,6 +338,11 @@ static const struct nt39016_panel_info kd035g6_info = {
 		.vrefresh = 60,
 		.flags = DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC,
 	},
+};
+
+static const struct nt39016_panel_info kd035g6_info = {
+	.display_modes = kd035g6_display_modes,
+	.num_modes = ARRAY_SIZE(kd035g6_display_modes),
 	.width_mm = 71,
 	.height_mm = 53,
 	.bus_format = MEDIA_BUS_FMT_RGB888_1X24,
-- 
2.25.1

