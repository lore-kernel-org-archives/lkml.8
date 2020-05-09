Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35790C47254
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 11:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11B1920A8B
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 11:27:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=48.io header.i=@48.io header.b="q8enCW2W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728469AbgEIL1D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 07:27:03 -0400
Received: from 48.io ([37.205.10.103]:60552 "EHLO pruto.48.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727993AbgEIL1B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 07:27:01 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by pruto.48.io (Postfix) with ESMTPSA id 762B694C91;
        Sat,  9 May 2020 13:18:43 +0200 (CEST)
DMARC-Filter: OpenDMARC Filter v1.3.2 pruto.48.io 762B694C91
Authentication-Results: pruto.48.io; dmarc=none (p=none dis=none) header.from=48.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=48.io; s=default;
        t=1589023123; bh=O95HQb+eKrzYJGAAvZyUidtJu6EvpStYBMsCe/HsdKU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=q8enCW2WkGcEePXOd74RmgJr5ty06CgzIPc/4f2O5gCz0EQOrEjY50bpsTO/ox2Ex
         kSsNPis7cxIrSCLNbPHmd8uV3MCdLMITivVjWKmlBxYLI90W1/v7CAan77DfFq8lWa
         ANlf83W31t0rb8U2CmGxopPxjDal5TKNF7Kfx0f8=
From:   srk@48.io
To:     Andrzej Hajda <a.hajda@samsung.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Lubomir Rintel <lkundrak@v3.sk>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sean Cross <xobs@kosagi.com>,
        Richard Marko <srk@48.io>, Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH 2/2] drm/panel: simple: Add Innolux N133HSE panel support
Date:   Sat,  9 May 2020 13:18:34 +0200
Message-Id: <20200509111834.26335-3-srk@48.io>
In-Reply-To: <20200509111834.26335-1-srk@48.io>
References: <20200509111834.26335-1-srk@48.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Cross <xobs@kosagi.com>

The Innolux N133HSE panel is a 13.3" 1920x1080 panel that contains an
integrated backlight, and connects via eDP.

It is used in the Kosagi Novena.

Signed-off-by: Sean Cross <xobs@kosagi.com>
Signed-off-by: Richard Marko <srk@48.io>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Thierry Reding <thierry.reding@gmail.com>
To: dri-devel@lists.freedesktop.org
---
 drivers/gpu/drm/panel/panel-simple.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 3ad828eaefe1..c8a93771d398 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -1906,6 +1906,30 @@ static const struct panel_desc innolux_n116bge = {
 	},
 };
 
+static const struct drm_display_mode innolux_n133hse_ea1_mode = {
+	.clock = 138500,
+	.hdisplay = 1920,
+	.hsync_start = 1920 + 46,
+	.hsync_end = 1920 + 46 + 30,
+	.htotal = 1920 + 46 + 30 + 84,
+	.vdisplay = 1080,
+	.vsync_start = 1080 + 2,
+	.vsync_end = 1080 + 2 + 4,
+	.vtotal = 1080 + 2 + 4 + 26,
+	.vrefresh = 60,
+};
+
+static const struct panel_desc innolux_n133hse_ea1 = {
+	.modes = &innolux_n133hse_ea1_mode,
+	.num_modes = 1,
+	.bpc = 8,
+	.size = {
+		.width = 293,
+		.height = 165,
+	},
+	.connector_type = DRM_MODE_CONNECTOR_eDP,
+};
+
 static const struct drm_display_mode innolux_n156bge_l21_mode = {
 	.clock = 69300,
 	.hdisplay = 1366,
@@ -3577,6 +3601,9 @@ static const struct of_device_id platform_of_match[] = {
 	}, {
 		.compatible = "innolux,n116bge",
 		.data = &innolux_n116bge,
+	}, {
+		.compatible = "innolux,n133hse-ea1",
+		.data = &innolux_n133hse_ea1,
 	}, {
 		.compatible = "innolux,n156bge-l21",
 		.data = &innolux_n156bge_l21,
-- 
2.25.1

