Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBC4FC4BA0B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 04:30:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97CC8222C2
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 04:30:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="IWlayfR7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbgBZEaz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 23:30:55 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:33598 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbgBZEay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 23:30:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1582691453; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=EBs+WyA9SoX0izZ/2YmeENtSC3EofRpkHiHuspGvF2k=;
        b=IWlayfR7Bunx4LFkE4p/wAp7BSODGzofuzBCHue4eX+xxz559in2m6Opf0JBNiCgI3FL3B
        y6iNKebknpDSFT0C8kuXLbA+I9wNvGVD9/WYBH37JmnzN+DlrbUyVHl2AoxbIDekC17JTr
        rtCiqoTGTX927hJ5zMIpjEQ+yD3ph2w=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>
Cc:     od@zcrc.me, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 1/3] gpu/drm: ingenic: Add trick to support 16bpp on 24-bit panels
Date:   Wed, 26 Feb 2020 01:30:39 -0300
Message-Id: <20200226043041.289764-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the panel interface is 24-bit but our primary plane is 16bpp,
configure as if the panel was 18-bit. This tricks permits the display
of 16bpp data on a 24-bit panel by wiring each color component to the
MSBs of the 24-bit interface.

v2: Check bytes-per-pixel count instead of fourcc format

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/gpu/drm/ingenic/ingenic-drm.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/ingenic/ingenic-drm.c b/drivers/gpu/drm/ingenic/ingenic-drm.c
index 6d47ef7b148c..5493a80d7d2f 100644
--- a/drivers/gpu/drm/ingenic/ingenic-drm.c
+++ b/drivers/gpu/drm/ingenic/ingenic-drm.c
@@ -400,6 +400,8 @@ static void ingenic_drm_encoder_atomic_mode_set(struct drm_encoder *encoder,
 	struct drm_display_mode *mode = &crtc_state->adjusted_mode;
 	struct drm_connector *conn = conn_state->connector;
 	struct drm_display_info *info = &conn->display_info;
+	struct drm_plane_state *plane_state = crtc_state->crtc->primary->state;
+	const struct drm_format_info *finfo = NULL;
 	unsigned int cfg;
 
 	priv->panel_is_sharp = info->bus_flags & DRM_BUS_FLAG_SHARP_SIGNALS;
@@ -435,7 +437,21 @@ static void ingenic_drm_encoder_atomic_mode_set(struct drm_encoder *encoder,
 				cfg |= JZ_LCD_CFG_MODE_GENERIC_18BIT;
 				break;
 			case MEDIA_BUS_FMT_RGB888_1X24:
-				cfg |= JZ_LCD_CFG_MODE_GENERIC_24BIT;
+				if (plane_state && plane_state->fb)
+					finfo = plane_state->fb->format;
+
+				/*
+				 * If the panel interface is 24-bit but our
+				 * primary plane is 16bpp, configure as if the
+				 * panel was 18-bit. This tricks permits the
+				 * display of 16bpp data on a 24-bit panel by
+				 * wiring each color component to the MSBs of
+				 * the 24-bit interface.
+				 */
+				if (finfo && finfo->cpp[0] < 3)
+					cfg |= JZ_LCD_CFG_MODE_GENERIC_18BIT;
+				else
+					cfg |= JZ_LCD_CFG_MODE_GENERIC_24BIT;
 				break;
 			case MEDIA_BUS_FMT_RGB888_3X8:
 				cfg |= JZ_LCD_CFG_MODE_8BIT_SERIAL;
-- 
2.25.0

