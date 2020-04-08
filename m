Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9A95C2BA1A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 09:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DF2820753
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 09:58:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="r0KMX/oH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728088AbgDHJ6r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 05:58:47 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:33800 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbgDHJ6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 05:58:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1586339919; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aSR9nQkyF4DBPaExFU5zaml0Mvv3jyWL8K6syxRKung=;
        b=r0KMX/oHKchaVf2qeMt8+U0VrIObQxTS/8l8eRllJ0Hgu6b5Mw5W5GPfR2B9/IzE9xcajM
        tk3U1sTjNeMrNN37j+IMgaU74Xl6PcAW/cWuwWAYEfw5YcN5tIFtxOZ3itEXhoPQKE8ceU
        w91Ilqg3ypxGcVjqyF6O//9sX2E1BTs=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     od@zcrc.me, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 2/2] drm/panel: NT39016: Add support for 50 Hz refresh rate
Date:   Wed,  8 Apr 2020 11:58:30 +0200
Message-Id: <20200408095830.8131-2-paul@crapouillou.net>
In-Reply-To: <20200408095830.8131-1-paul@crapouillou.net>
References: <20200408095830.8131-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By changing the pixel clock and the length of the back porch, it is
possible to obtain a perfect 50 Hz refresh rate.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/gpu/drm/panel/panel-novatek-nt39016.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-novatek-nt39016.c b/drivers/gpu/drm/panel/panel-novatek-nt39016.c
index f1286cf6528b..05cae8d62d56 100644
--- a/drivers/gpu/drm/panel/panel-novatek-nt39016.c
+++ b/drivers/gpu/drm/panel/panel-novatek-nt39016.c
@@ -325,7 +325,7 @@ static int nt39016_remove(struct spi_device *spi)
 }
 
 static const struct drm_display_mode kd035g6_display_modes[] = {
-	{
+	{	/* 60 Hz */
 		.clock = 6000,
 		.hdisplay = 320,
 		.hsync_start = 320 + 10,
@@ -338,6 +338,19 @@ static const struct drm_display_mode kd035g6_display_modes[] = {
 		.vrefresh = 60,
 		.flags = DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC,
 	},
+	{	/* 50 Hz */
+		.clock = 5400,
+		.hdisplay = 320,
+		.hsync_start = 320 + 42,
+		.hsync_end = 320 + 42 + 50,
+		.htotal = 320 + 42 + 50 + 20,
+		.vdisplay = 240,
+		.vsync_start = 240 + 5,
+		.vsync_end = 240 + 5 + 1,
+		.vtotal = 240 + 5 + 1 + 4,
+		.vrefresh = 50,
+		.flags = DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC,
+	},
 };
 
 static const struct nt39016_panel_info kd035g6_info = {
-- 
2.25.1

