Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC1F6C54FD7
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 08:50:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9351720714
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 08:50:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="aYBMrSDL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727575AbgCYIum (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 04:50:42 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53398 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727501AbgCYIuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 04:50:39 -0400
Received: by mail-wm1-f65.google.com with SMTP id b12so1387810wmj.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 01:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fPJX5pxHatWlhsndvDxqYNXpPbJWSaIQ/yvG8JwAaPQ=;
        b=aYBMrSDLGFsR9VGiA3afn25swSvBzlrBXb5UxObkLtHAfr5/+WOEvT0kDWgdi4FwZQ
         zjXQdJNgPta9PL4WL8iKpMmwrCQUjzd7L5DroRcX2ImHVgy2LegXPtXrazdftqoeVc1x
         2JDqjdl6bhSvwuIox3qPuKmXyKjgduvx0k6LVHhGYu7wNyvXwXb8oxn2Wxep8JR3Hxmh
         RNa4Dxv30pWkhHsYO3464gILGOeas27+J+86DpavRaAJ7e6k8QqAH9FkhtwLZQSBiRJ1
         bFMxqGTXHot17KqkZH0jUGmqpKnDXFuM9gVBRsTp5fT56nLY0EtNYwRzcv0if1ux9Ukw
         OuOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fPJX5pxHatWlhsndvDxqYNXpPbJWSaIQ/yvG8JwAaPQ=;
        b=LL0gd1rZ42560+iKW0kAnX04eqAVX0Ypjod6gLo/8Vc86YDQf3ZA3Cf/YQWykSU1Nj
         n1OOO46Cx7/Hu0Incq6ibH85ojJYPiN/ZqkXVMRZQC2SOeTg5FhSOVRXnOrb/TqiX8vb
         nGa0gysm9//i8GGqhlEOPW/Mhg3dhjcdgwM0vu9vPuuLc4GTXJ5roxs9zzMUXmJdFnEl
         6pe77534FcyxFCpXyIeK5OUCREjUWZov3Af7KCCR8nfdKf9BJNaWM8CrHXSyCCtBOBiV
         3bL8pZWtMM2ZJW+LmTnqez8BLVF05ZqqAoByQZynp2UU+xcCxGPfYdTNuYPVkBKKbV8S
         QC7g==
X-Gm-Message-State: ANhLgQ2SSq2zgkLhVKm3A5OvydPyrLa/tDA3X/ajtIT94/3JfzlAKAvB
        vJdsY5lIzt11vH2xSGbOxW7u0Q==
X-Google-Smtp-Source: ADFU+vuYjdCM+0T2o7saCgezXhu9RnRogVZPN6H0/ZPkKnWZxBuY5GQnR1RGVO/FZ47BMHplkvQV5g==
X-Received: by 2002:a1c:9a43:: with SMTP id c64mr2217618wme.173.1585126237494;
        Wed, 25 Mar 2020 01:50:37 -0700 (PDT)
Received: from bender.baylibre.local ([2a01:e35:2ec0:82b0:5c5f:613e:f775:b6a2])
        by smtp.gmail.com with ESMTPSA id o16sm33892229wrs.44.2020.03.25.01.50.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 01:50:37 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     daniel@ffwll.ch, dri-devel@lists.freedesktop.org
Cc:     ppaalanen@gmail.com, mjourdan@baylibre.com, brian.starkey@arm.com,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH v4 6/8] drm/meson: overlay: setup overlay for Amlogic FBC Memory Saving mode
Date:   Wed, 25 Mar 2020 09:50:23 +0100
Message-Id: <20200325085025.30631-7-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200325085025.30631-1-narmstrong@baylibre.com>
References: <20200325085025.30631-1-narmstrong@baylibre.com>
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
 drivers/gpu/drm/meson/meson_overlay.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/meson/meson_overlay.c b/drivers/gpu/drm/meson/meson_overlay.c
index 51fa038ad5d7..8b9d4984b2a7 100644
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
 
@@ -763,6 +771,8 @@ static const uint32_t supported_drm_formats[] = {
 };
 
 static const uint64_t format_modifiers[] = {
+	DRM_FORMAT_MOD_AMLOGIC_FBC(DRM_FORMAT_MOD_AMLOGIC_FBC_LAYOUT_BASIC |
+				   DRM_FORMAT_MOD_AMLOGIC_FBC_MEM_SAVING),
 	DRM_FORMAT_MOD_AMLOGIC_FBC(DRM_FORMAT_MOD_AMLOGIC_FBC_LAYOUT_BASIC),
 	DRM_FORMAT_MOD_LINEAR,
 	DRM_FORMAT_MOD_INVALID,
-- 
2.22.0

