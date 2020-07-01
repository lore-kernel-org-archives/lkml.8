Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E62BC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 16:29:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B28320781
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 16:29:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="ZCsUdMBr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732431AbgGAQ3m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 12:29:42 -0400
Received: from vps.xff.cz ([195.181.215.36]:52350 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731672AbgGAQ3h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 12:29:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1593620973; bh=f/45zyltLN8VLr22IqV4zw/zoKLTG0OhDbBg5rPU60M=;
        h=From:To:Cc:Subject:Date:References:From;
        b=ZCsUdMBrHvyN1u7y6/gMpCnpn10Fo3OZF4oXwP0C1w1Hp7W7+qFKGnoXKZCZfjLRx
         PWMeiaramolWYcBpTAlgpM3uTZFON1/FtmgCa9sQeNFSEEVtpj3b2zzruCssZ6jbma
         Bik0JwiKKxwdU0u5pN5SIlAZqwuVp/xBCzj+Pvcw=
From:   Ondrej Jirman <megous@megous.com>
To:     linux-sunxi@googlegroups.com,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        Purism Kernel Team <kernel@puri.sm>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Icenowy Zheng <icenowy@aosc.io>
Cc:     Ondrej Jirman <megous@megous.com>, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Samuel Holland <samuel@sholland.org>,
        Martijn Braam <martijn@brixit.nl>, Luca Weiss <luca@z3ntu.xyz>,
        Bhushan Shah <bshah@kde.org>
Subject: [PATCH v7 07/13] drm/panel: st7703: Move code specific to jh057n closer together
Date:   Wed,  1 Jul 2020 18:29:22 +0200
Message-Id: <20200701162928.1638874-8-megous@megous.com>
In-Reply-To: <20200701162928.1638874-1-megous@megous.com>
References: <20200701162928.1638874-1-megous@megous.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's better than having it spread around the driver.

Signed-off-by: Ondrej Jirman <megous@megous.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpu/drm/panel/panel-sitronix-st7703.c | 48 +++++++++----------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-sitronix-st7703.c b/drivers/gpu/drm/panel/panel-sitronix-st7703.c
index 4721132ad3b1..61872f623fff 100644
--- a/drivers/gpu/drm/panel/panel-sitronix-st7703.c
+++ b/drivers/gpu/drm/panel/panel-sitronix-st7703.c
@@ -153,6 +153,30 @@ static int jh057n_init_sequence(struct st7703 *ctx)
 	return 0;
 }
 
+static const struct drm_display_mode jh057n00900_mode = {
+	.hdisplay    = 720,
+	.hsync_start = 720 + 90,
+	.hsync_end   = 720 + 90 + 20,
+	.htotal	     = 720 + 90 + 20 + 20,
+	.vdisplay    = 1440,
+	.vsync_start = 1440 + 20,
+	.vsync_end   = 1440 + 20 + 4,
+	.vtotal	     = 1440 + 20 + 4 + 12,
+	.clock	     = 75276,
+	.flags	     = DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC,
+	.width_mm    = 65,
+	.height_mm   = 130,
+};
+
+struct st7703_panel_desc jh057n00900_panel_desc = {
+	.mode = &jh057n00900_mode,
+	.lanes = 4,
+	.mode_flags = MIPI_DSI_MODE_VIDEO |
+		MIPI_DSI_MODE_VIDEO_BURST | MIPI_DSI_MODE_VIDEO_SYNC_PULSE,
+	.format = MIPI_DSI_FMT_RGB888,
+	.init_sequence = jh057n_init_sequence,
+};
+
 static int st7703_enable(struct drm_panel *panel)
 {
 	struct st7703 *ctx = panel_to_st7703(panel);
@@ -226,30 +250,6 @@ static int st7703_prepare(struct drm_panel *panel)
 	return ret;
 }
 
-static const struct drm_display_mode jh057n00900_mode = {
-	.hdisplay    = 720,
-	.hsync_start = 720 + 90,
-	.hsync_end   = 720 + 90 + 20,
-	.htotal	     = 720 + 90 + 20 + 20,
-	.vdisplay    = 1440,
-	.vsync_start = 1440 + 20,
-	.vsync_end   = 1440 + 20 + 4,
-	.vtotal	     = 1440 + 20 + 4 + 12,
-	.clock	     = 75276,
-	.flags	     = DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC,
-	.width_mm    = 65,
-	.height_mm   = 130,
-};
-
-struct st7703_panel_desc jh057n00900_panel_desc = {
-	.mode = &jh057n00900_mode,
-	.lanes = 4,
-	.mode_flags = MIPI_DSI_MODE_VIDEO |
-		MIPI_DSI_MODE_VIDEO_BURST | MIPI_DSI_MODE_VIDEO_SYNC_PULSE,
-	.format = MIPI_DSI_FMT_RGB888,
-	.init_sequence = jh057n_init_sequence,
-};
-
 static int st7703_get_modes(struct drm_panel *panel,
 			    struct drm_connector *connector)
 {
-- 
2.27.0

