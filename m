Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E55F2C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 07:48:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7CD520899
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 07:48:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="oOEjfQkc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728196AbgGBHsW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 03:48:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbgGBHsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 03:48:11 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DDE6C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 00:48:10 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id w3so14285249wmi.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 00:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gH8Vn1HTtpNj65SmBS3hC6q15Gun4PcDgr8IzPQIXVQ=;
        b=oOEjfQkc/23VPtuyqR4DMbz/ZhfMBtlxzlMpUT9kFVlTae21pzoLeHJg0p9SEi9Btb
         YKHe7N6/qZe5TsnmTMnpmjth33AmeSOGd0myu0lXCPafmkMfgLg1hmyXBqTj/Gxad7Fy
         EGhQRbT1B2ZJBe77hKciHMpDIKkp28W1VajzD53sGgUbyp8s6gq3lshATxAkki/UlxBf
         RNlcWvgUXnv7HvVo6Dwn0RB76bYHPl2Gwz/lz1TYp4cfI6jD1hCd/LTH4IXTHwIp2u6t
         TzJIWiv4k87qIE78njht9Xj98RDkbpR8e4KwCw2P4OuHNwipMNDkLmu8WMYbyuwATr2t
         DxqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gH8Vn1HTtpNj65SmBS3hC6q15Gun4PcDgr8IzPQIXVQ=;
        b=p3MwtqhjThmP63z94CQJVzNQnnNP5J9WiE+FxxE5mr8GT5U1zrmnVFVfKSYOjrFop8
         u05Rl0vzvnHHjAerg1h+X+t6AMgOvQi3Ix1+g29wvF1Ljv+m7NpOq+tW0bDQch2QGbeH
         XM6hvpGlytn7ZEBdwG+mRHnDcniay9A5GKTMCb/EhJkEObpPlbGcAZgohA6UROY9HSSo
         hklBoZ+MG6MQDBZIcDdBUWKvkWbT3Ddp17RLs9xpYZxhc8cCUmHkMU+xI6vKG80BpntY
         cLmjq/aj4yLfZ3QsWMXUostLCQUrdRqL1MTIIm8Z2U7jqvGYb7zL53K4eagLlsoQPriq
         7ceg==
X-Gm-Message-State: AOAM530AWb2WiOZ+p1Ky282gnsqsMxilrMhENRd2MjzYwV01ibFddvu0
        D2P5H3tIddBf1N28d7CMUJzOaA==
X-Google-Smtp-Source: ABdhPJyIBtqhzOw83s4MX/++PQkYOiWfUrCWuGZhv4s9I1CJJGuhyB0fRbsmeoUaZ4BiTuS/Ddhfmg==
X-Received: by 2002:a1c:f314:: with SMTP id q20mr30392840wmq.18.1593676089110;
        Thu, 02 Jul 2020 00:48:09 -0700 (PDT)
Received: from bender.baylibre.local ([2a01:e35:2ec0:82b0:7023:727a:c688:cf9b])
        by smtp.gmail.com with ESMTPSA id z1sm10001882wru.30.2020.07.02.00.48.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 00:48:08 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     daniel@ffwll.ch, dri-devel@lists.freedesktop.org
Cc:     jianxin.pan@amlogic.com, Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH v8 4/6] drm/meson: overlay: setup overlay for Amlogic FBC Memory Saving mode
Date:   Thu,  2 Jul 2020 09:47:57 +0200
Message-Id: <20200702074759.32356-5-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200702074759.32356-1-narmstrong@baylibre.com>
References: <20200702074759.32356-1-narmstrong@baylibre.com>
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
 drivers/gpu/drm/meson/meson_overlay.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/meson/meson_overlay.c b/drivers/gpu/drm/meson/meson_overlay.c
index 293f606ba164..1566a887d482 100644
--- a/drivers/gpu/drm/meson/meson_overlay.c
+++ b/drivers/gpu/drm/meson/meson_overlay.c
@@ -486,6 +486,10 @@ static void meson_overlay_atomic_update(struct drm_plane *plane,
 					  AFBC_HOLD_LINE_NUM(8) |
 					  AFBC_BURST_LEN(2);
 
+		if (fb->modifier & DRM_FORMAT_MOD_AMLOGIC_FBC(0,
+						AMLOGIC_FBC_OPTION_MEM_SAVING))
+			priv->viu.vd1_afbc_mode |= AFBC_BLK_MEM_MODE;
+
 		priv->viu.vd1_afbc_en = 0x1600 | AFBC_DEC_ENABLE;
 
 		priv->viu.vd1_afbc_conv_ctrl = AFBC_CONV_LBUF_LEN(256);
@@ -671,12 +675,17 @@ static void meson_overlay_atomic_update(struct drm_plane *plane,
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
 
@@ -734,6 +743,9 @@ static bool meson_overlay_format_mod_supported(struct drm_plane *plane,
 		unsigned int layout = modifier &
 			DRM_FORMAT_MOD_AMLOGIC_FBC(
 				__fourcc_mod_amlogic_layout_mask, 0);
+		unsigned int options =
+			(modifier >> __fourcc_mod_amlogic_options_shift) &
+			__fourcc_mod_amlogic_options_mask;
 
 		if (format != DRM_FORMAT_YUV420_8BIT &&
 		    format != DRM_FORMAT_YUV420_10BIT) {
@@ -748,6 +760,13 @@ static bool meson_overlay_format_mod_supported(struct drm_plane *plane,
 			return false;
 		}
 
+		if (options &&
+		    options != AMLOGIC_FBC_OPTION_MEM_SAVING) {
+			DRM_DEBUG_KMS("%llx invalid layout %x\n",
+				      modifier, layout);
+			return false;
+		}
+
 		return true;
 	}
 
@@ -781,6 +800,8 @@ static const uint32_t supported_drm_formats[] = {
 };
 
 static const uint64_t format_modifiers[] = {
+	DRM_FORMAT_MOD_AMLOGIC_FBC(AMLOGIC_FBC_LAYOUT_BASIC,
+				   AMLOGIC_FBC_OPTION_MEM_SAVING),
 	DRM_FORMAT_MOD_AMLOGIC_FBC(AMLOGIC_FBC_LAYOUT_BASIC, 0),
 	DRM_FORMAT_MOD_LINEAR,
 	DRM_FORMAT_MOD_INVALID,
-- 
2.22.0

