Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93750C33CAF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 16:18:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FC2C21744
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 16:18:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="VRPmxcaq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728942AbgAMQSJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 11:18:09 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:50276 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728801AbgAMQSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 11:18:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1578932279; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J3z5w0J/a8B4Msjz2/v9/hSWCfiswHbHO7q2kYy3wcw=;
        b=VRPmxcaq+6MT/1QPjnKaN9/+z0YjS0d2UkhZUi+SaKGEkV18eLuWFZXzrtchY6Ur7/0npu
        IrXkZZIm6N8m9KmLFpYYFWZV+2YqVgohVNFWNGcacQigy+05D9fdyDQ0jSJFnQEDCMYtCv
        ApSsDd8ng69OQYVuf03J6oWL6bNJPbI=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     od@zcrc.me, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v3 3/3] drm/panel: simple: Add support for the Frida FRD350H54004 panel
Date:   Mon, 13 Jan 2020 13:17:41 -0300
Message-Id: <20200113161741.32061-3-paul@crapouillou.net>
In-Reply-To: <20200113161741.32061-1-paul@crapouillou.net>
References: <20200113161741.32061-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The FRD350H54004 is a simple 3.5" 320x240 24-bit TFT panel, found for
instance inside the Anbernic RG-350 handheld gaming console.

v2: Order alphabetically
v3: Add connector_type, and update timings according to the constraints
    listed in the datasheet

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/gpu/drm/panel/panel-simple.c | 30 ++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index e14c14ac62b5..d6f77bc494c7 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -1440,6 +1440,33 @@ static const struct panel_desc foxlink_fl500wvr00_a0t = {
 	.bus_format = MEDIA_BUS_FMT_RGB888_1X24,
 };
 
+static const struct drm_display_mode frida_frd350h54004_mode = {
+	.clock = 6000,
+	.hdisplay = 320,
+	.hsync_start = 320 + 44,
+	.hsync_end = 320 + 44 + 16,
+	.htotal = 320 + 44 + 16 + 20,
+	.vdisplay = 240,
+	.vsync_start = 240 + 2,
+	.vsync_end = 240 + 2 + 6,
+	.vtotal = 240 + 2 + 6 + 2,
+	.vrefresh = 60,
+	.flags = DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC,
+};
+
+static const struct panel_desc frida_frd350h54004 = {
+	.modes = &frida_frd350h54004_mode,
+	.num_modes = 1,
+	.bpc = 8,
+	.size = {
+		.width = 77,
+		.height = 64,
+	},
+	.bus_format = MEDIA_BUS_FMT_RGB888_1X24,
+	.bus_flags = DRM_BUS_FLAG_DE_HIGH | DRM_BUS_FLAG_PIXDATA_POSEDGE,
+	.connector_type = DRM_MODE_CONNECTOR_DPI,
+};
+
 static const struct drm_display_mode friendlyarm_hd702e_mode = {
 	.clock		= 67185,
 	.hdisplay	= 800,
@@ -3309,6 +3336,9 @@ static const struct of_device_id platform_of_match[] = {
 	}, {
 		.compatible = "foxlink,fl500wvr00-a0t",
 		.data = &foxlink_fl500wvr00_a0t,
+	}, {
+		.compatible = "frida,frd350h54004",
+		.data = &frida_frd350h54004,
 	}, {
 		.compatible = "friendlyarm,hd702e",
 		.data = &friendlyarm_hd702e,
-- 
2.24.1

