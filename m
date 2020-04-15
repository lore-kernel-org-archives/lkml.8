Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BBCAC2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 17:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 304BF20784
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 17:28:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411053AbgDOR2K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 13:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2410995AbgDOR1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 13:27:38 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBD60C061A0F;
        Wed, 15 Apr 2020 10:27:37 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id D660A2A1D66
Received: by jupiter.universe (Postfix, from userid 1000)
        id 19DA24800EA; Wed, 15 Apr 2020 19:27:34 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        kernel@collabora.com,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCHv2 1/3] drm/panel: simple: Add support for AUO G190EAN01 panel
Date:   Wed, 15 Apr 2020 19:27:23 +0200
Message-Id: <20200415172725.84257-2-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200415172725.84257-1-sebastian.reichel@collabora.com>
References: <20200415172725.84257-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add timings for the G190EAN01 dual channel LVDS panel.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 .../bindings/display/panel/panel-simple.yaml  |  2 ++
 drivers/gpu/drm/panel/panel-simple.c          | 33 +++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
index 8fc117d1547c..7c9a08d846b9 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
@@ -59,6 +59,8 @@ properties:
       - auo,g133han01
         # AU Optronics Corporation 18.5" FHD (1920x1080) TFT LCD panel
       - auo,g185han01
+        # AU Optronics Corporation 19.0" (1280x1024) TFT LCD panel
+      - auo,g190ean01
         # AU Optronics Corporation 31.5" FHD (1920x1080) TFT LCD panel
       - auo,p320hvn03
         # AU Optronics Corporation 21.5" FHD (1920x1080) color TFT LCD panel
diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 44a1f5dfb571..8d1cf68ca01b 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -933,6 +933,36 @@ static const struct panel_desc auo_g185han01 = {
 	.connector_type = DRM_MODE_CONNECTOR_LVDS,
 };
 
+static const struct display_timing auo_g190ean01_timings = {
+	.pixelclock = { 90000000, 108000000, 135000000 },
+	.hactive = { 1280, 1280, 1280 },
+	.hfront_porch = { 126, 184, 1266 },
+	.hback_porch = { 84, 122, 844 },
+	.hsync_len = { 70, 102, 704 },
+	.vactive = { 1024, 1024, 1024 },
+	.vfront_porch = { 4, 26, 76 },
+	.vback_porch = { 2, 8, 25 },
+	.vsync_len = { 2, 8, 25 },
+};
+
+static const struct panel_desc auo_g190ean01 = {
+	.timings = &auo_g190ean01_timings,
+	.num_timings = 1,
+	.bpc = 8,
+	.size = {
+		.width = 376,
+		.height = 301,
+	},
+	.delay = {
+		.prepare = 50,
+		.enable = 200,
+		.disable = 110,
+		.unprepare = 1000,
+	},
+	.bus_format = MEDIA_BUS_FMT_RGB888_1X7X4_SPWG,
+	.connector_type = DRM_MODE_CONNECTOR_LVDS,
+};
+
 static const struct display_timing auo_p320hvn03_timings = {
 	.pixelclock = { 106000000, 148500000, 164000000 },
 	.hactive = { 1920, 1920, 1920 },
@@ -3497,6 +3527,9 @@ static const struct of_device_id platform_of_match[] = {
 	}, {
 		.compatible = "auo,g185han01",
 		.data = &auo_g185han01,
+	}, {
+		.compatible = "auo,g190ean01",
+		.data = &auo_g190ean01,
 	}, {
 		.compatible = "auo,p320hvn03",
 		.data = &auo_p320hvn03,
-- 
2.25.1

