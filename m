Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EF14C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 17:28:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8B612084D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 17:28:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411059AbgDOR2U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 13:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2410994AbgDOR1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 13:27:38 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB89FC061A0E;
        Wed, 15 Apr 2020 10:27:37 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id D077C2A1D5E
Received: by jupiter.universe (Postfix, from userid 1000)
        id 25A4E4800FB; Wed, 15 Apr 2020 19:27:34 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        kernel@collabora.com,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCHv2 3/3] drm/panel: simple: Add support for AUO G121EAN01.4 panel
Date:   Wed, 15 Apr 2020 19:27:25 +0200
Message-Id: <20200415172725.84257-4-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200415172725.84257-1-sebastian.reichel@collabora.com>
References: <20200415172725.84257-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add timings for the AUO G121EAN01.4 panel.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 .../bindings/display/panel/panel-simple.yaml  |  2 ++
 drivers/gpu/drm/panel/panel-simple.c          | 28 +++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
index b3f1f4c83da6..db05bfc0fa6a 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
@@ -55,6 +55,8 @@ properties:
       - auo,g101evn010
         # AU Optronics Corporation 10.4" (800x600) color TFT LCD panel
       - auo,g104sn02
+        # AU Optronics Corporation 12.1" (1280x800) TFT LCD panel
+      - auo,g121ean01
         # AU Optronics Corporation 13.3" FHD (1920x1080) TFT LCD panel
       - auo,g133han01
         # AU Optronics Corporation 15.6" (1366x768) TFT LCD panel
diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index a80dced09b16..e1979952691e 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -873,6 +873,31 @@ static const struct panel_desc auo_g104sn02 = {
 	},
 };
 
+static const struct drm_display_mode auo_g121ean01_mode = {
+	.clock = 66700,
+	.hdisplay = 1280,
+	.hsync_start = 1280 + 58,
+	.hsync_end = 1280 + 58 + 8,
+	.htotal = 1280 + 58 + 8 + 70,
+	.vdisplay = 800,
+	.vsync_start = 800 + 6,
+	.vsync_end = 800 + 6 + 4,
+	.vtotal = 800 + 6 + 4 + 10,
+	.vrefresh = 60,
+};
+
+static const struct panel_desc auo_g121ean01 = {
+	.modes = &auo_g121ean01_mode,
+	.num_modes = 1,
+	.bpc = 8,
+	.size = {
+		.width = 261,
+		.height = 163,
+	},
+	.bus_format = MEDIA_BUS_FMT_RGB888_1X7X4_SPWG,
+	.connector_type = DRM_MODE_CONNECTOR_LVDS,
+};
+
 static const struct display_timing auo_g133han01_timings = {
 	.pixelclock = { 134000000, 141200000, 149000000 },
 	.hactive = { 1920, 1920, 1920 },
@@ -3546,6 +3571,9 @@ static const struct of_device_id platform_of_match[] = {
 	}, {
 		.compatible = "auo,g104sn02",
 		.data = &auo_g104sn02,
+	}, {
+		.compatible = "auo,g121ean01",
+		.data = &auo_g121ean01,
 	}, {
 		.compatible = "auo,g133han01",
 		.data = &auo_g133han01,
-- 
2.25.1

