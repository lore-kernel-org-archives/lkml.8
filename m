Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19264C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:26:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7DEC206D6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:26:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="gb9mZRBk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731972AbgDPP0V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 11:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2442487AbgDPPZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 11:25:18 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F668C061A41
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 08:25:18 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id h26so5320308wrb.7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 08:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pAAPmG/Jb3adRgVZcI3+WEZjd0CmBHlfGNHq+xKmSJk=;
        b=gb9mZRBkNIdN2fCnMt+El5mgw2WvvGR6aS/C/2wNRDwfSozMtKfOA60GbKoEAcQKqh
         UFBrc3r4cbHmlEcOVWXrrYXuHdY0f1fx0OouQPqCX7h1efZVVSZTEuP+hUsuKSdDZJ53
         C3Qr94o4eDf55MkwbkY1s7dimuMAbqWaORbJU7dtwPzVEaPPMB4RSlWTIp6Fy7gKcdbW
         9j26s6VN79Do1I2hDyLrmomQw4UevEVOHs/cvpMJTx106IwRMAZZkFzmvIv7Oz++m1IQ
         qBdvcByMosAJKufkkMKkWn5QQdEmnzKEEQGR6aEPP5O1q+uHNwKg6Pu/h2Wd/piNNkQP
         EBkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pAAPmG/Jb3adRgVZcI3+WEZjd0CmBHlfGNHq+xKmSJk=;
        b=U5aLb6WO/t8zOgzUrgEKr4sxNb2cRvbpGJPguZFu3GGvdMxRzoeimT84v2Cjh6YDZj
         BOSckqt22qPpieB/I19Ig1m0bd0Rtdn0jCZO0FrdJDFubr6YzDGvh8bGOOXD4K8+rpG4
         SIiYZf4DY9SklZA/Iq4NGguGiglnWs/ZoLRgLvZV2+DlB3tYb6+FDJQo6TMKI1PGTAWw
         wURrh0VSss3uTSyG4eagrEmY/N/zugKEzPAAZJguDrTM6LcLpbUz2FICsgOI4wC+bqrZ
         FCM052u+m7VVLWuMqnyDhqKxJi5B4gzjs7BMmmmzAtZWto4mGfid26m1xl8YNOdP7uy3
         MZhQ==
X-Gm-Message-State: AGi0PuZfl5/967WJqlS5pL2zqgeCN9P3j38w2zpeR3OqjW2PSn01hBSf
        s3Cin0Js89Ud5GGmOkPIrPxk1g==
X-Google-Smtp-Source: APiQypIYCGk/APKOgaU92vz2hRnB71h6Oa4IfHbO/xSY2Vhgx/msOHurLSBkaZDwyaPEWqpzBH8x2Q==
X-Received: by 2002:adf:c442:: with SMTP id a2mr33790736wrg.110.1587050716672;
        Thu, 16 Apr 2020 08:25:16 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e35:2ec0:82b0:39cc:a07:8b48:cc56])
        by smtp.gmail.com with ESMTPSA id i17sm18019489wru.39.2020.04.16.08.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 08:25:15 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     daniel@ffwll.ch, dri-devel@lists.freedesktop.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH v5 6/8] drm/meson: overlay: setup overlay for Amlogic FBC Memory Saving mode
Date:   Thu, 16 Apr 2020 17:24:58 +0200
Message-Id: <20200416152500.29429-7-narmstrong@baylibre.com>
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
a different superblock size for the Memory Saving mode.

Tested-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/gpu/drm/meson/meson_overlay.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/meson/meson_overlay.c b/drivers/gpu/drm/meson/meson_overlay.c
index 3127bd1a5d70..bbf86e9fc0ca 100644
--- a/drivers/gpu/drm/meson/meson_overlay.c
+++ b/drivers/gpu/drm/meson/meson_overlay.c
@@ -487,6 +487,9 @@ static void meson_overlay_atomic_update(struct drm_plane *plane,
 					  AFBC_HOLD_LINE_NUM(8) |
 					  AFBC_BURST_LEN(2);
 
+		if (fb->modifier & DRM_FORMAT_MOD_AMLOGIC_FBC_MEM_SAVING)
+			priv->viu.vd1_afbc_mode |= AFBC_BLK_MEM_MODE;
+
 		priv->viu.vd1_afbc_en = 0x1600 | AFBC_DEC_ENABLE;
 
 		priv->viu.vd1_afbc_conv_ctrl = AFBC_CONV_LBUF_LEN(256);
@@ -672,12 +675,17 @@ static void meson_overlay_atomic_update(struct drm_plane *plane,
 	}
 
 	if (priv->viu.vd1_afbc) {
+		/* Default mode is 4k per superblock */
+		unsigned long block_size = 4096;
 		unsigned long body_size;
 
-		/* Default mode is 4k per superblock */
+		/* 8bit mem saving mode is 3072bytes per superblock */
+		if (priv->viu.vd1_afbc_mode & AFBC_BLK_MEM_MODE)
+			block_size = 3072;
+
 		body_size = (ALIGN(priv->viu.vd1_stride0, 64) / 64) *
 			    (ALIGN(priv->viu.vd1_height0, 32) / 32) *
-			    4096;
+			    block_size;
 
 		priv->viu.vd1_afbc_body_addr = priv->viu.vd1_addr0 >> 4;
 
@@ -735,6 +743,9 @@ static bool meson_overlay_format_mod_supported(struct drm_plane *plane,
 		unsigned int layout = modifier &
 			DRM_FORMAT_MOD_AMLOGIC_FBC(
 				DRM_FORMAT_MOD_AMLOGIC_FBC_LAYOUT_MASK);
+		unsigned int options = modifier &
+			DRM_FORMAT_MOD_AMLOGIC_FBC(
+				DRM_FORMAT_MOD_AMLOGIC_FBC_OPTIONS_MASK);
 
 		if (format != DRM_FORMAT_YUV420_8BIT &&
 		    format != DRM_FORMAT_YUV420_10BIT) {
@@ -749,6 +760,13 @@ static bool meson_overlay_format_mod_supported(struct drm_plane *plane,
 			return false;
 		}
 
+		if (options &&
+		    options != DRM_FORMAT_MOD_AMLOGIC_FBC_MEM_SAVING) {
+			DRM_DEBUG_KMS("%llx invalid layout %x\n",
+				      modifier, layout);
+			return false;
+		}
+
 		return true;
 	}
 
@@ -782,6 +800,8 @@ static const uint32_t supported_drm_formats[] = {
 };
 
 static const uint64_t format_modifiers[] = {
+	DRM_FORMAT_MOD_AMLOGIC_FBC(DRM_FORMAT_MOD_AMLOGIC_FBC_LAYOUT_BASIC |
+				   DRM_FORMAT_MOD_AMLOGIC_FBC_MEM_SAVING),
 	DRM_FORMAT_MOD_AMLOGIC_FBC(DRM_FORMAT_MOD_AMLOGIC_FBC_LAYOUT_BASIC),
 	DRM_FORMAT_MOD_LINEAR,
 	DRM_FORMAT_MOD_INVALID,
-- 
2.22.0

