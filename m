Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22FE4C54FC9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 16:16:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 003B9206E9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 16:16:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="TJcxWuWz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729226AbgDUQQT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 12:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729196AbgDUQQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 12:16:12 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D05C061A41
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 09:16:12 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id u13so17112073wrp.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 09:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bxjlfwjwrOxt5UTQatxMHEDDG1cEpZr3A7ziLWB5/Ps=;
        b=TJcxWuWz1iZePtAcZ/E3AYbh3x+CNrtUx8v+FYQOP4C4vDnuaNYFBe62GSKGvLmjbM
         Woqrs/gyHv5eVrRzPm8uUypT5aAAZAg20wQCY3Fve0YvAmOSpOlhE3akCajen3htbIdd
         G2oi3Y5BAT5RaFfbPBeAbQSu1rRlHjOhEMOO5iYTDUWEyoG4s9TFWs2YEV58HKQBpqkC
         vwCJ3FFAqXVQkX29Er0wLd6IufmyQne/UOYpZFYBhswlmjqJHMa8dYNs3eO0nzq0oR6P
         +3zz/pq8pkMR6cm2GA0c25SjOtEGAOJz9KDoorgX7XKsCGARbp3epRV8jwt0VEEnfFKQ
         iDZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bxjlfwjwrOxt5UTQatxMHEDDG1cEpZr3A7ziLWB5/Ps=;
        b=bw5YcfAUhn3+ax2SHr7VTU5NqV5vuP9lByIYILxeMcacZxMJXaPza6ZJRWlqw9nkUn
         yFzJT9gxuPq74CuEGuNu5Ujz6RFYxLjKGa+1WpMHLEHPnRNphVBAnemHas9/koieHG9P
         dGuuLlf4LsR7WZDSIU24GuPEyT+B2YDxtRSQiA8Z8F6gmotrUFw4UR5+KBxdCMPvcTU5
         QH3CKeKoLJyUVBf3DxVXgCDH2HUH0Xzj4mUumCYvrYVQiGT/yAlj9ts5Yp/JHtUHPkgV
         5WFtYtAw+7yAno46Wb/Gc7P3YA1tKtNPpQh7ty8a28rrZL828/qZdjOSAZ6JZ0kB5A3A
         B4Pw==
X-Gm-Message-State: AGi0PuYB/kSKLJIkrCPLBhKDERX5p0ueI76aer4VtGGlBmmKqsxxbiCy
        iDan+FRRFX/DAqd2k5bC3Wb/Iw==
X-Google-Smtp-Source: APiQypKSrF90nkPUeJv1B6kw+A1LEftlhBMrqlOM7dX47kD7No68QmGRWBakv5/GctmtsKTElciSog==
X-Received: by 2002:adf:b310:: with SMTP id j16mr23012380wrd.95.1587485770685;
        Tue, 21 Apr 2020 09:16:10 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e35:2ec0:82b0:39cc:a07:8b48:cc56])
        by smtp.gmail.com with ESMTPSA id m8sm4410873wrx.54.2020.04.21.09.16.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 09:16:10 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     daniel@ffwll.ch, dri-devel@lists.freedesktop.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH v6 4/6] drm/meson: overlay: setup overlay for Amlogic FBC Memory Saving mode
Date:   Tue, 21 Apr 2020 18:15:57 +0200
Message-Id: <20200421161559.2347-5-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200421161559.2347-1-narmstrong@baylibre.com>
References: <20200421161559.2347-1-narmstrong@baylibre.com>
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
index 2713d008cee8..b5c502876428 100644
--- a/drivers/gpu/drm/meson/meson_overlay.c
+++ b/drivers/gpu/drm/meson/meson_overlay.c
@@ -487,6 +487,10 @@ static void meson_overlay_atomic_update(struct drm_plane *plane,
 					  AFBC_HOLD_LINE_NUM(8) |
 					  AFBC_BURST_LEN(2);
 
+		if (fb->modifier & DRM_FORMAT_MOD_AMLOGIC_FBC(0,
+						AMLOGIC_FBC_OPTION_MEM_SAVING))
+			priv->viu.vd1_afbc_mode |= AFBC_BLK_MEM_MODE;
+
 		priv->viu.vd1_afbc_en = 0x1600 | AFBC_DEC_ENABLE;
 
 		priv->viu.vd1_afbc_conv_ctrl = AFBC_CONV_LBUF_LEN(256);
@@ -672,12 +676,17 @@ static void meson_overlay_atomic_update(struct drm_plane *plane,
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
 
@@ -735,6 +744,9 @@ static bool meson_overlay_format_mod_supported(struct drm_plane *plane,
 		unsigned int layout = modifier &
 			DRM_FORMAT_MOD_AMLOGIC_FBC(
 				__fourcc_mod_amlogic_layout_mask, 0);
+		unsigned int options =
+			(modifier >> __fourcc_mod_amlogic_options_shift) &
+			__fourcc_mod_amlogic_options_mask;
 
 		if (format != DRM_FORMAT_YUV420_8BIT &&
 		    format != DRM_FORMAT_YUV420_10BIT) {
@@ -749,6 +761,13 @@ static bool meson_overlay_format_mod_supported(struct drm_plane *plane,
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
 
@@ -782,6 +801,8 @@ static const uint32_t supported_drm_formats[] = {
 };
 
 static const uint64_t format_modifiers[] = {
+	DRM_FORMAT_MOD_AMLOGIC_FBC(AMLOGIC_FBC_LAYOUT_BASIC,
+				   AMLOGIC_FBC_OPTION_MEM_SAVING),
 	DRM_FORMAT_MOD_AMLOGIC_FBC(AMLOGIC_FBC_LAYOUT_BASIC, 0),
 	DRM_FORMAT_MOD_LINEAR,
 	DRM_FORMAT_MOD_INVALID,
-- 
2.22.0

