Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60DE4C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 08:08:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39EC8206A1
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 08:08:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="PyLrch+f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbgGCIIB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 04:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725891AbgGCIHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 04:07:46 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78DA5C08C5DD
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jul 2020 01:07:46 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id s10so31648241wrw.12
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jul 2020 01:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/ng/jUwloNmcdfo+1PiIEF30ni1dXh2rT+0xtNGPS4s=;
        b=PyLrch+fX/y3on1e2GaZG7BbOXo3AxtFqG3wdXsEOSq2iC38M5weP7wSyKmLRJWcCc
         F3ovW8aquYh2TDG8N7rWl5GEK5lpKOs1QgLKxfFg715G8DcIcV3uYSOqKDkz0kaPNJFP
         a867mkMngjEdS9w4S/KEOUG9T3gXA62ZonFMi2soZEyW6CLDDXiuKeHUDRS48dvcQTeH
         EaT71E5n+v6C5r3yMt4S+9gkoISwt0XraBFa2+3885t7ljkzyRWC8w4kTl8H14Z1W6oL
         xHQVTvHtX4ooAqOUt+3CRepyul/8hK/WDp3a710K7pwq5UcOXGvLZ4rAz2zOjjFsb70j
         FlVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/ng/jUwloNmcdfo+1PiIEF30ni1dXh2rT+0xtNGPS4s=;
        b=EoIVW+1IcRSV3nYXkP5RZYoCa6rULTtMmThbJYGE3PRngBAtTdyK9CirQqkLRbao1Z
         Dfcbf8RLz96vNBQ0wekcwIv4iLOGmTrbJ2LiJozHbztcrHNyx5Bux3TSanNe2+0MHjVv
         aBczLMMEdSMRCseQ8ivz2ElKYSFUvs96CIue3aEg8U0jfil0ts0J64URf0ydzUA2itQJ
         CmKOy7b4uanWyZrjtWl9XMU7A5KxhnxFDw7TsKRI8eL3Vp87GUpqXw10yIuO59REFC+K
         pQ9YsUPrVlKLvHQdekXyY/vO9ktDoBqi6PN2g+AEbVzQv4k7aCjFKQwMwoquAtR84jYf
         dWBw==
X-Gm-Message-State: AOAM5324myxVFvDm30+G4ZkCJVnz7iusXQXlKy9po+WiXD4afc1GCE3X
        xrUtmBeCdfoiWK4ZVm+b1j6XCA==
X-Google-Smtp-Source: ABdhPJwUXFlxviRDdo8T8RyU2xfFfWIniJJPgGGQKHZ5n/u/fWnGMblZd1yorghXWb7RlCzqeH+T9Q==
X-Received: by 2002:a5d:6ac7:: with SMTP id u7mr7285462wrw.25.1593763665073;
        Fri, 03 Jul 2020 01:07:45 -0700 (PDT)
Received: from bender.baylibre.local ([2a01:e35:2ec0:82b0:6959:e617:6562:cabf])
        by smtp.gmail.com with ESMTPSA id 1sm12682403wmf.0.2020.07.03.01.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2020 01:07:44 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     daniel@ffwll.ch, dri-devel@lists.freedesktop.org
Cc:     jianxin.pan@amlogic.com, Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH v9 5/6] drm/meson: overlay: setup overlay for Amlogic FBC Scatter Memory layout
Date:   Fri,  3 Jul 2020 10:07:27 +0200
Message-Id: <20200703080728.25207-6-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200703080728.25207-1-narmstrong@baylibre.com>
References: <20200703080728.25207-1-narmstrong@baylibre.com>
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
Reviewed-by: Kevin Hilman <khilman@baylibre.com>
---
 drivers/gpu/drm/meson/meson_overlay.c | 53 ++++++++++++++++++---------
 1 file changed, 35 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/meson/meson_overlay.c b/drivers/gpu/drm/meson/meson_overlay.c
index 1566a887d482..1f7b2055e012 100644
--- a/drivers/gpu/drm/meson/meson_overlay.c
+++ b/drivers/gpu/drm/meson/meson_overlay.c
@@ -490,6 +490,10 @@ static void meson_overlay_atomic_update(struct drm_plane *plane,
 						AMLOGIC_FBC_OPTION_MEM_SAVING))
 			priv->viu.vd1_afbc_mode |= AFBC_BLK_MEM_MODE;
 
+		if ((fb->modifier & __fourcc_mod_amlogic_layout_mask) ==
+				AMLOGIC_FBC_LAYOUT_SCATTER)
+			priv->viu.vd1_afbc_mode |= AFBC_SCATTER_MODE;
+
 		priv->viu.vd1_afbc_en = 0x1600 | AFBC_DEC_ENABLE;
 
 		priv->viu.vd1_afbc_conv_ctrl = AFBC_CONV_LBUF_LEN(256);
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
 
-		if (layout != AMLOGIC_FBC_LAYOUT_BASIC) {
+		if (layout != AMLOGIC_FBC_LAYOUT_BASIC &&
+		    layout != AMLOGIC_FBC_LAYOUT_SCATTER) {
 			DRM_DEBUG_KMS("%llx invalid layout %x\n",
 				      modifier, layout);
 			return false;
@@ -800,8 +814,11 @@ static const uint32_t supported_drm_formats[] = {
 };
 
 static const uint64_t format_modifiers[] = {
+	DRM_FORMAT_MOD_AMLOGIC_FBC(AMLOGIC_FBC_LAYOUT_SCATTER,
+				   AMLOGIC_FBC_OPTION_MEM_SAVING),
 	DRM_FORMAT_MOD_AMLOGIC_FBC(AMLOGIC_FBC_LAYOUT_BASIC,
 				   AMLOGIC_FBC_OPTION_MEM_SAVING),
+	DRM_FORMAT_MOD_AMLOGIC_FBC(AMLOGIC_FBC_LAYOUT_SCATTER, 0),
 	DRM_FORMAT_MOD_AMLOGIC_FBC(AMLOGIC_FBC_LAYOUT_BASIC, 0),
 	DRM_FORMAT_MOD_LINEAR,
 	DRM_FORMAT_MOD_INVALID,
-- 
2.22.0

