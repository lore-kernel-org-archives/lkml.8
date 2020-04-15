Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E3C1C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 17:27:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32C3D2084D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 17:27:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411029AbgDOR1s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 13:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2410996AbgDOR1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 13:27:38 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0FEFC061A10;
        Wed, 15 Apr 2020 10:27:37 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id DB5022A1D68
Received: by jupiter.universe (Postfix, from userid 1000)
        id 229804800F9; Wed, 15 Apr 2020 19:27:34 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        kernel@collabora.com,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCHv2 2/3] drm/panel: simple: Add support for AUO G156XTN01.0 panel
Date:   Wed, 15 Apr 2020 19:27:24 +0200
Message-Id: <20200415172725.84257-3-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200415172725.84257-1-sebastian.reichel@collabora.com>
References: <20200415172725.84257-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add timings for the AUO G156XTN01.0 panel.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 .../bindings/display/panel/panel-simple.yaml  |  2 ++
 drivers/gpu/drm/panel/panel-simple.c          | 28 +++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
index 7c9a08d846b9..b3f1f4c83da6 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
@@ -57,6 +57,8 @@ properties:
       - auo,g104sn02
         # AU Optronics Corporation 13.3" FHD (1920x1080) TFT LCD panel
       - auo,g133han01
+        # AU Optronics Corporation 15.6" (1366x768) TFT LCD panel
+      - auo,g156xtn01
         # AU Optronics Corporation 18.5" FHD (1920x1080) TFT LCD panel
       - auo,g185han01
         # AU Optronics Corporation 19.0" (1280x1024) TFT LCD panel
diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 8d1cf68ca01b..a80dced09b16 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -903,6 +903,31 @@ static const struct panel_desc auo_g133han01 = {
 	.connector_type = DRM_MODE_CONNECTOR_LVDS,
 };
 
+static const struct drm_display_mode auo_g156xtn01_mode = {
+	.clock = 76000,
+	.hdisplay = 1366,
+	.hsync_start = 1366 + 33,
+	.hsync_end = 1366 + 33 + 67,
+	.htotal = 1560,
+	.vdisplay = 768,
+	.vsync_start = 768 + 4,
+	.vsync_end = 768 + 4 + 4,
+	.vtotal = 806,
+	.vrefresh = 60,
+};
+
+static const struct panel_desc auo_g156xtn01 = {
+	.modes = &auo_g156xtn01_mode,
+	.num_modes = 1,
+	.bpc = 8,
+	.size = {
+		.width = 344,
+		.height = 194,
+	},
+	.bus_format = MEDIA_BUS_FMT_RGB888_1X7X4_SPWG,
+	.connector_type = DRM_MODE_CONNECTOR_LVDS,
+};
+
 static const struct display_timing auo_g185han01_timings = {
 	.pixelclock = { 120000000, 144000000, 175000000 },
 	.hactive = { 1920, 1920, 1920 },
@@ -3524,6 +3549,9 @@ static const struct of_device_id platform_of_match[] = {
 	}, {
 		.compatible = "auo,g133han01",
 		.data = &auo_g133han01,
+	}, {
+		.compatible = "auo,g156xtn01",
+		.data = &auo_g156xtn01,
 	}, {
 		.compatible = "auo,g185han01",
 		.data = &auo_g185han01,
-- 
2.25.1

