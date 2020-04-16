Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EC50C2BB85
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:26:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62F76214D8
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:26:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="uphDWYUj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395211AbgDPP0J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 11:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2442485AbgDPPZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 11:25:16 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9737C061A10
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 08:25:14 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id h9so5306065wrc.8
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 08:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tEJnMkZw0RJ36/X+ECc1wDu3rwX96mNLlTRyC+ecg4U=;
        b=uphDWYUjdVH+wTPu3vZ5qko80GhYY4bEnpaLdGCRQxYsa5xQygV+jhvBNY6u96N805
         XPGI8maKX4H65Pqo/cMOmdud7o1OFpzHdsZOryhxEe34Nra0xsrg9+zweVhDdaWAApQY
         JvsUvC4BU+w9WWiGwRq3u8kwzpU/JRWGIfEWmbOGcA2wQmVVcOUxLi8mDTWRrYEDW6HM
         7kOCeDY8LRbf2HpDO/JG0+zgPi9k9lZKl+2wpIEcg7AkQLnVzJFpcjDcL+n1m3FuVw1h
         f8+viuSBFwwpqA+hGYmboESVwbRenIUdVkaiDBRhw30mw4G9O7xoLkuH9QQs4bImm9Oq
         vetA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tEJnMkZw0RJ36/X+ECc1wDu3rwX96mNLlTRyC+ecg4U=;
        b=C4op30xS4xrkqaeW1fe/EJQCPab1+0pH6qfdrY8mL4s7isv7vZ5ckvOXkH+eu9j3tc
         c61nHK1wUrlmOkg68wini/oRI8Zxmt72nNBg8tmVie141LXGeOoWjxCT29fFQxZL/0+e
         OzoDYpxUgx8QKFVDv7OMLGhJ2EarVuhTk+7dJcX9NzbFyAKc3hXBLuueavOAtvuchaCm
         Bw+9/i78akUmDcDUQxjyaILmtOySYNuwK6pfLOwcOu2YmoDNmUWXgBhRnkC9UE1BYUkn
         d0fF/0fmNROnQ+10m1r9dnK0FYdrmWNSqJZflEtAHZxbJr4Gw4xI6LbRkE72uGQzZ6t4
         9GUw==
X-Gm-Message-State: AGi0PuaUb/XRxgTH9AtEnGpcVqsIbLKg9z3rnfC1bDjbdKOPZR5wKopg
        VSQS1piWs3Up/ohc6ecjHwut0Q==
X-Google-Smtp-Source: APiQypKLCqMbQ3N+mDsDetSq4hSANWeFKlg5uBHYD59l+NTqJ8dqPCUc4WCHm2PBB17zcHTv1ViRuQ==
X-Received: by 2002:a5d:68ca:: with SMTP id p10mr35766334wrw.154.1587050713430;
        Thu, 16 Apr 2020 08:25:13 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e35:2ec0:82b0:39cc:a07:8b48:cc56])
        by smtp.gmail.com with ESMTPSA id i17sm18019489wru.39.2020.04.16.08.25.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 08:25:12 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     daniel@ffwll.ch, dri-devel@lists.freedesktop.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH v5 4/8] drm/meson: crtc: handle commit of Amlogic FBC frames
Date:   Thu, 16 Apr 2020 17:24:56 +0200
Message-Id: <20200416152500.29429-5-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200416152500.29429-1-narmstrong@baylibre.com>
References: <20200416152500.29429-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the VD1 Amlogic FBC decoder is now configured by the overlay driver,
commit the right registers to decode the Amlogic FBC frame.

Tested-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/gpu/drm/meson/meson_crtc.c | 118 +++++++++++++++++++++--------
 1 file changed, 88 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/meson/meson_crtc.c b/drivers/gpu/drm/meson/meson_crtc.c
index e66b6271ff58..d6dcfd654e9c 100644
--- a/drivers/gpu/drm/meson/meson_crtc.c
+++ b/drivers/gpu/drm/meson/meson_crtc.c
@@ -291,6 +291,10 @@ static void meson_crtc_enable_vd1(struct meson_drm *priv)
 			    VPP_VD1_PREBLEND | VPP_VD1_POSTBLEND |
 			    VPP_COLOR_MNG_ENABLE,
 			    priv->io_base + _REG(VPP_MISC));
+
+	writel_bits_relaxed(VIU_CTRL0_AFBC_TO_VD1,
+			    priv->viu.vd1_afbc ? VIU_CTRL0_AFBC_TO_VD1 : 0,
+			    priv->io_base + _REG(VIU_MISC_CTRL0));
 }
 
 static void meson_g12a_crtc_enable_vd1(struct meson_drm *priv)
@@ -300,6 +304,10 @@ static void meson_g12a_crtc_enable_vd1(struct meson_drm *priv)
 		       VD_BLEND_POSTBLD_SRC_VD1 |
 		       VD_BLEND_POSTBLD_PREMULT_EN,
 		       priv->io_base + _REG(VD1_BLEND_SRC_CTRL));
+
+	writel_relaxed(priv->viu.vd1_afbc ?
+		       (VD1_AXI_SEL_AFBC | AFBC_VD1_SEL) : 0,
+		       priv->io_base + _REG(VD1_AFBCD0_MISC_CTRL));
 }
 
 void meson_crtc_irq(struct meson_drm *priv)
@@ -383,36 +391,86 @@ void meson_crtc_irq(struct meson_drm *priv)
 	/* Update the VD1 registers */
 	if (priv->viu.vd1_enabled && priv->viu.vd1_commit) {
 
-		switch (priv->viu.vd1_planes) {
-		case 3:
-			meson_canvas_config(priv->canvas,
-					    priv->canvas_id_vd1_2,
-					    priv->viu.vd1_addr2,
-					    priv->viu.vd1_stride2,
-					    priv->viu.vd1_height2,
-					    MESON_CANVAS_WRAP_NONE,
-					    MESON_CANVAS_BLKMODE_LINEAR,
-					    MESON_CANVAS_ENDIAN_SWAP64);
-		/* fallthrough */
-		case 2:
-			meson_canvas_config(priv->canvas,
-					    priv->canvas_id_vd1_1,
-					    priv->viu.vd1_addr1,
-					    priv->viu.vd1_stride1,
-					    priv->viu.vd1_height1,
-					    MESON_CANVAS_WRAP_NONE,
-					    MESON_CANVAS_BLKMODE_LINEAR,
-					    MESON_CANVAS_ENDIAN_SWAP64);
-		/* fallthrough */
-		case 1:
-			meson_canvas_config(priv->canvas,
-					    priv->canvas_id_vd1_0,
-					    priv->viu.vd1_addr0,
-					    priv->viu.vd1_stride0,
-					    priv->viu.vd1_height0,
-					    MESON_CANVAS_WRAP_NONE,
-					    MESON_CANVAS_BLKMODE_LINEAR,
-					    MESON_CANVAS_ENDIAN_SWAP64);
+		if (priv->viu.vd1_afbc) {
+			writel_relaxed(priv->viu.vd1_afbc_head_addr,
+				       priv->io_base +
+				       _REG(AFBC_HEAD_BADDR));
+			writel_relaxed(priv->viu.vd1_afbc_body_addr,
+				       priv->io_base +
+				       _REG(AFBC_BODY_BADDR));
+			writel_relaxed(priv->viu.vd1_afbc_en,
+				       priv->io_base +
+				       _REG(AFBC_ENABLE));
+			writel_relaxed(priv->viu.vd1_afbc_mode,
+				       priv->io_base +
+				       _REG(AFBC_MODE));
+			writel_relaxed(priv->viu.vd1_afbc_size_in,
+				       priv->io_base +
+				       _REG(AFBC_SIZE_IN));
+			writel_relaxed(priv->viu.vd1_afbc_dec_def_color,
+				       priv->io_base +
+				       _REG(AFBC_DEC_DEF_COLOR));
+			writel_relaxed(priv->viu.vd1_afbc_conv_ctrl,
+				       priv->io_base +
+				       _REG(AFBC_CONV_CTRL));
+			writel_relaxed(priv->viu.vd1_afbc_size_out,
+				       priv->io_base +
+				       _REG(AFBC_SIZE_OUT));
+			writel_relaxed(priv->viu.vd1_afbc_vd_cfmt_ctrl,
+				       priv->io_base +
+				       _REG(AFBC_VD_CFMT_CTRL));
+			writel_relaxed(priv->viu.vd1_afbc_vd_cfmt_w,
+				       priv->io_base +
+				       _REG(AFBC_VD_CFMT_W));
+			writel_relaxed(priv->viu.vd1_afbc_mif_hor_scope,
+				       priv->io_base +
+				       _REG(AFBC_MIF_HOR_SCOPE));
+			writel_relaxed(priv->viu.vd1_afbc_mif_ver_scope,
+				       priv->io_base +
+				       _REG(AFBC_MIF_VER_SCOPE));
+			writel_relaxed(priv->viu.vd1_afbc_pixel_hor_scope,
+				       priv->io_base+
+				       _REG(AFBC_PIXEL_HOR_SCOPE));
+			writel_relaxed(priv->viu.vd1_afbc_pixel_ver_scope,
+				       priv->io_base +
+				       _REG(AFBC_PIXEL_VER_SCOPE));
+			writel_relaxed(priv->viu.vd1_afbc_vd_cfmt_h,
+				       priv->io_base +
+				       _REG(AFBC_VD_CFMT_H));
+		} else {
+			switch (priv->viu.vd1_planes) {
+			case 3:
+				meson_canvas_config(priv->canvas,
+						    priv->canvas_id_vd1_2,
+						    priv->viu.vd1_addr2,
+						    priv->viu.vd1_stride2,
+						    priv->viu.vd1_height2,
+						    MESON_CANVAS_WRAP_NONE,
+						    MESON_CANVAS_BLKMODE_LINEAR,
+						    MESON_CANVAS_ENDIAN_SWAP64);
+			/* fallthrough */
+			case 2:
+				meson_canvas_config(priv->canvas,
+						    priv->canvas_id_vd1_1,
+						    priv->viu.vd1_addr1,
+						    priv->viu.vd1_stride1,
+						    priv->viu.vd1_height1,
+						    MESON_CANVAS_WRAP_NONE,
+						    MESON_CANVAS_BLKMODE_LINEAR,
+						    MESON_CANVAS_ENDIAN_SWAP64);
+			/* fallthrough */
+			case 1:
+				meson_canvas_config(priv->canvas,
+						    priv->canvas_id_vd1_0,
+						    priv->viu.vd1_addr0,
+						    priv->viu.vd1_stride0,
+						    priv->viu.vd1_height0,
+						    MESON_CANVAS_WRAP_NONE,
+						    MESON_CANVAS_BLKMODE_LINEAR,
+						    MESON_CANVAS_ENDIAN_SWAP64);
+			}
+
+			writel_relaxed(0, priv->io_base + _REG(AFBC_ENABLE));
 		}
 
 		writel_relaxed(priv->viu.vd1_if0_gen_reg,
-- 
2.22.0

