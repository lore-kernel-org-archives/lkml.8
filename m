Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30C4AC433E4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 12:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F26B520739
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 12:57:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="Ftr2O4Kf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728872AbgGPM5G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 08:57:06 -0400
Received: from crapouillou.net ([89.234.176.41]:59394 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726863AbgGPM5E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 08:57:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1594904216; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UXVJEzr99w/7orElqKOLhLQwbYcOBGYdsx3Qi8Km2b8=;
        b=Ftr2O4KfjMmYkxroaUSB6tD55JtcuDXjyNzz2kF/PyEnFKiERZafbni/CQ7VWtdhbqEvxr
        U5KYRzNF7AOLDhQXrc/8uuc6Sgfn5hCpwiCGmAnyl3xQK2HDnyQxFzP867mPZHByHl84BS
        rFoYjWKbVkuJTx6qKkVKIOw6VY3BzI0=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     od@zcrc.me, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 2/2] drm/panel-simple: Add 50 Hz mode to the Frida FRD350H54004 panel
Date:   Thu, 16 Jul 2020 14:56:47 +0200
Message-Id: <20200716125647.10964-2-paul@crapouillou.net>
In-Reply-To: <20200716125647.10964-1-paul@crapouillou.net>
References: <20200716125647.10964-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By changing the pixel clock and the length of the back porch, it is
possible to obtain a perfect 50 Hz refresh rate.

v2: Rebase on drm-misc-next

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/gpu/drm/panel/panel-simple.c | 40 +++++++++++++++++++---------
 1 file changed, 27 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 8b0bab9dd075..88493538a147 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -1753,22 +1753,36 @@ static const struct panel_desc foxlink_fl500wvr00_a0t = {
 	.bus_format = MEDIA_BUS_FMT_RGB888_1X24,
 };
 
-static const struct drm_display_mode frida_frd350h54004_mode = {
-	.clock = 6000,
-	.hdisplay = 320,
-	.hsync_start = 320 + 44,
-	.hsync_end = 320 + 44 + 16,
-	.htotal = 320 + 44 + 16 + 20,
-	.vdisplay = 240,
-	.vsync_start = 240 + 2,
-	.vsync_end = 240 + 2 + 6,
-	.vtotal = 240 + 2 + 6 + 2,
-	.flags = DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC,
+static const struct drm_display_mode frida_frd350h54004_modes[] = {
+	{ /* 60 Hz */
+		.clock = 6000,
+		.hdisplay = 320,
+		.hsync_start = 320 + 44,
+		.hsync_end = 320 + 44 + 16,
+		.htotal = 320 + 44 + 16 + 20,
+		.vdisplay = 240,
+		.vsync_start = 240 + 2,
+		.vsync_end = 240 + 2 + 6,
+		.vtotal = 240 + 2 + 6 + 2,
+		.flags = DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC,
+	},
+	{ /* 50 Hz */
+		.clock = 5400,
+		.hdisplay = 320,
+		.hsync_start = 320 + 56,
+		.hsync_end = 320 + 56 + 16,
+		.htotal = 320 + 56 + 16 + 40,
+		.vdisplay = 240,
+		.vsync_start = 240 + 2,
+		.vsync_end = 240 + 2 + 6,
+		.vtotal = 240 + 2 + 6 + 2,
+		.flags = DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC,
+	},
 };
 
 static const struct panel_desc frida_frd350h54004 = {
-	.modes = &frida_frd350h54004_mode,
-	.num_modes = 1,
+	.modes = frida_frd350h54004_modes,
+	.num_modes = ARRAY_SIZE(frida_frd350h54004_modes),
 	.bpc = 8,
 	.size = {
 		.width = 77,
-- 
2.27.0

