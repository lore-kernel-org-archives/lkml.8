Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46312C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:26:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A252206D6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:26:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="khWHx9oT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395232AbgDPP0c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 11:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2442492AbgDPPZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 11:25:22 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB897C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 08:25:21 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id h26so5320569wrb.7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 08:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oEh+32nEVm+L3h2nqrkEI2RZhWGyawtUviLim3KeczU=;
        b=khWHx9oTBXuB1jvkx97Q7Ge3/eNg08KayjK9LifGmWHefyOs7Sar790b9XmaDvc0/w
         2/LUWAfRz1Ldbt51o+u5U9gqAT6VWQYogG8wd+u0DfUzRzfWx4l7Sy/eBJ2Qwp7m2hBz
         SY/fHyKGKj/BBPQ7Dpp3bXD9VmvE+hxO6eKTuGr9bt4wmulAK6Hen19GujLVgVOKMEuv
         nzYVdHUTkD2vc6+VGUdlcQGC2sI5IjfZFiMhw2T8kZP4rGB5i9FXFufcXIw9p5Pm0Hd+
         Nx9goUzds5pn7AToyiRxOEyFwPlLVRXSsS2N454QXl/9Kv5XRHGibSR1dXoLe+NcJNc6
         yUfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oEh+32nEVm+L3h2nqrkEI2RZhWGyawtUviLim3KeczU=;
        b=X5nx7WiDFoy2row1GATEIJJFzBYxex1fcA30pCcjzuDciRtFIPf4yyUdIMMMce92W8
         l9s9H/omfrNX/8Av9jy2EtHb5oYEtnShx/FcO0RBFVgjt3daKEDeBam2i7ZZ26D9b9xJ
         tDjKzM0W2D9iAvF1F2Xi7qrsIfYMrFKF7S62Zkdo2xLA7IssfbFxEQQVQbJxgYvsVrKn
         0GB5c4etw3UWFmeSvNV9myHK1uZNr4l9gVpYdtsPNe+Yoei17tbqiE/7+KJ/f8yV90WZ
         W2PjIx+3siiJSPnyoL2ijbw9rltcm4uatauUfVXfkkhj1y6isL9xPAoSapJeTrRVa0dC
         /kGw==
X-Gm-Message-State: AGi0PuZdzs/c2LDsMNWgz+LrK5r9Ky6JzZoELeOj5BJj4h0fM/wxdbaF
        5vNuohddXvBLcvmOugy1TI+mmQ==
X-Google-Smtp-Source: APiQypI7osjvHZzGJMQeIwOy4gibMUTIGvmyObz0ROfmiYS5Bg1uOzdAvHxwUv2g/n16I6yxGVwXHw==
X-Received: by 2002:a5d:5151:: with SMTP id u17mr34134663wrt.240.1587050720509;
        Thu, 16 Apr 2020 08:25:20 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e35:2ec0:82b0:39cc:a07:8b48:cc56])
        by smtp.gmail.com with ESMTPSA id i17sm18019489wru.39.2020.04.16.08.25.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 08:25:19 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     daniel@ffwll.ch, dri-devel@lists.freedesktop.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH v5 8/8] drm/meson: overlay: setup overlay for Amlogic FBC Scatter Memory layout
Date:   Thu, 16 Apr 2020 17:25:00 +0200
Message-Id: <20200416152500.29429-9-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200416152500.29429-1-narmstrong@baylibre.com>
References: <20200416152500.29429-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Setup the Amlogic FBC decoder for the VD1 video overlay plane to use
read the FBC header as Scatter Memory layout reference.

Tested-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/gpu/drm/meson/meson_overlay.c | 53 ++++++++++++++++++---------
 1 file changed, 35 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/meson/meson_overlay.c b/drivers/gpu/drm/meson/meson_overlay.c
index bbf86e9fc0ca..29b85509dbf8 100644
--- a/drivers/gpu/drm/meson/meson_overlay.c
+++ b/drivers/gpu/drm/meson/meson_overlay.c
@@ -487,6 +487,10 @@ static void meson_overlay_atomic_update(struct drm_plane *plane,
 					  AFBC_HOLD_LINE_NUM(8) |
 					  AFBC_BURST_LEN(2);
 
+		if ((fb->modifier & DRM_FORMAT_MOD_AMLOGIC_FBC_LAYOUT_MASK) ==
+				DRM_FORMAT_MOD_AMLOGIC_FBC_LAYOUT_SCATTER)
+			priv->viu.vd1_afbc_mode |= AFBC_SCATTER_MODE;
+
 		if (fb->modifier & DRM_FORMAT_MOD_AMLOGIC_FBC_MEM_SAVING)
 			priv->viu.vd1_afbc_mode |= AFBC_BLK_MEM_MODE;
 
@@ -675,23 +679,32 @@ static void meson_overlay_atomic_update(struct drm_plane *plane,
 	}
 
 	if (priv->viu.vd1_afbc) {
-		/* Default mode is 4k per superblock */
-		unsigned long block_size = 4096;
-		unsigned long body_size;
-
-		/* 8bit mem saving mode is 3072bytes per superblock */
-		if (priv->viu.vd1_afbc_mode & AFBC_BLK_MEM_MODE)
-			block_size = 3072;
-
-		body_size = (ALIGN(priv->viu.vd1_stride0, 64) / 64) *
-			    (ALIGN(priv->viu.vd1_height0, 32) / 32) *
-			    block_size;
-
-		priv->viu.vd1_afbc_body_addr = priv->viu.vd1_addr0 >> 4;
-
-		/* Header is after body content */
-		priv->viu.vd1_afbc_head_addr = (priv->viu.vd1_addr0 +
-						body_size) >> 4;
+		if (priv->viu.vd1_afbc_mode & AFBC_SCATTER_MODE) {
+			/*
+			 * In Scatter mode, the header contains the physical
+			 * body content layout, thus the body content
+			 * size isn't needed.
+			 */
+			priv->viu.vd1_afbc_head_addr = priv->viu.vd1_addr0 >> 4;
+			priv->viu.vd1_afbc_body_addr = 0;
+		} else {
+			/* Default mode is 4k per superblock */
+			unsigned long block_size = 4096;
+			unsigned long body_size;
+
+			/* 8bit mem saving mode is 3072bytes per superblock */
+			if (priv->viu.vd1_afbc_mode & AFBC_BLK_MEM_MODE)
+				block_size = 3072;
+
+			body_size = (ALIGN(priv->viu.vd1_stride0, 64) / 64) *
+				    (ALIGN(priv->viu.vd1_height0, 32) / 32) *
+				    block_size;
+
+			priv->viu.vd1_afbc_body_addr = priv->viu.vd1_addr0 >> 4;
+			/* Header is after body content */
+			priv->viu.vd1_afbc_head_addr = (priv->viu.vd1_addr0 +
+							body_size) >> 4;
+		}
 	}
 
 	priv->viu.vd1_enabled = true;
@@ -754,7 +767,8 @@ static bool meson_overlay_format_mod_supported(struct drm_plane *plane,
 			return false;
 		}
 
-		if (layout != DRM_FORMAT_MOD_AMLOGIC_FBC_LAYOUT_BASIC) {
+		if (layout != DRM_FORMAT_MOD_AMLOGIC_FBC_LAYOUT_BASIC &&
+		    layout != DRM_FORMAT_MOD_AMLOGIC_FBC_LAYOUT_SCATTER) {
 			DRM_DEBUG_KMS("%llx invalid layout %x\n",
 				      modifier, layout);
 			return false;
@@ -800,8 +814,11 @@ static const uint32_t supported_drm_formats[] = {
 };
 
 static const uint64_t format_modifiers[] = {
+	DRM_FORMAT_MOD_AMLOGIC_FBC(DRM_FORMAT_MOD_AMLOGIC_FBC_LAYOUT_SCATTER |
+				   DRM_FORMAT_MOD_AMLOGIC_FBC_MEM_SAVING),
 	DRM_FORMAT_MOD_AMLOGIC_FBC(DRM_FORMAT_MOD_AMLOGIC_FBC_LAYOUT_BASIC |
 				   DRM_FORMAT_MOD_AMLOGIC_FBC_MEM_SAVING),
+	DRM_FORMAT_MOD_AMLOGIC_FBC(DRM_FORMAT_MOD_AMLOGIC_FBC_LAYOUT_SCATTER),
 	DRM_FORMAT_MOD_AMLOGIC_FBC(DRM_FORMAT_MOD_AMLOGIC_FBC_LAYOUT_BASIC),
 	DRM_FORMAT_MOD_LINEAR,
 	DRM_FORMAT_MOD_INVALID,
-- 
2.22.0

