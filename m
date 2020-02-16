Return-Path: <SRS0=C9WH=4E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE7F8C2BA83
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Feb 2020 15:58:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CFDA20729
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Feb 2020 15:58:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="tUeA1wGJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728393AbgBPP6d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Feb 2020 10:58:33 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:45924 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728239AbgBPP6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Feb 2020 10:58:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1581868710; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=2zq/wwIxPTj/fKmDjIa6URfrDJL7kUowjKmyTJvEAZM=;
        b=tUeA1wGJAoaGDx/wPduGvxu9AvFh6kk8l5/E2DBUvxCagu9aLiYn7V4w4Yftkl4XMpBfXc
        MI3bOAfWMlxIeV0NLH4o+djng3P5+9j9aa0LaOslJ72b6RsKojtO4TqD6IrcnCciRWXYSy
        pLIe+MyXm4OmkmEORcRnKA/w+3XUdXk=
From:   Paul Cercueil <paul@crapouillou.net>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>
Cc:     od@zcrc.me, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 1/3] gpu/drm: ingenic: Add trick to support 16bpp on 24-bit panels
Date:   Sun, 16 Feb 2020 12:58:09 -0300
Message-Id: <20200216155811.68463-1-paul@crapouillou.net>
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

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/gpu/drm/ingenic/ingenic-drm.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/ingenic/ingenic-drm.c b/drivers/gpu/drm/ingenic/ingenic-drm.c
index 6d47ef7b148c..034961a40e98 100644
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
@@ -435,7 +437,22 @@ static void ingenic_drm_encoder_atomic_mode_set(struct drm_encoder *encoder,
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
+				if (finfo &&
+				    finfo->format != DRM_FORMAT_XRGB8888)
+					cfg |= JZ_LCD_CFG_MODE_GENERIC_18BIT;
+				else
+					cfg |= JZ_LCD_CFG_MODE_GENERIC_24BIT;
 				break;
 			case MEDIA_BUS_FMT_RGB888_3X8:
 				cfg |= JZ_LCD_CFG_MODE_8BIT_SERIAL;
-- 
2.25.0

