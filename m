Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FF2BC35641
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 09:09:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E197F20679
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 09:09:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="pahC2mJo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728321AbgBUJJK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 04:09:10 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45488 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728092AbgBUJIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 04:08:55 -0500
Received: by mail-wr1-f68.google.com with SMTP id g3so1066870wrs.12
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 01:08:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ISULOS1UCLwuUa+INumyziDbxt+K8PYtRxwNxV5Yeuk=;
        b=pahC2mJoXh8wRpsQW3z6MRPhFZ48wI4PBusGzip2wSTL4343A+K/DiCgAi+D5W12yB
         zLmBLGSftm/vkPTDvdYIko9Zc3ymwOLg7Q/y+eBdY3Y2N1MkiVAiSNd1arYd9zedRI+h
         8j5YhhAox4I6Y3okI64il5v67MAiWw7Ij5kD1no3UAKfcgXLAdXxSbxrMhR0hL2/1UgF
         X2eK5RoD0ZWptmDj4mlrpPTqToRrzJcrUcVBIUiBvSRbupVVxAGLKIv1BaUO2fRM7U/a
         0Plg+uBl5ATK/FK0vejMWnX+iKfQ0AAuIyVlDV6wAQtdhPgex6iHXKhbC8bJzpt0D7o6
         23eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ISULOS1UCLwuUa+INumyziDbxt+K8PYtRxwNxV5Yeuk=;
        b=caLMhN/pX5ilUDr+71D2+F4BHVhfuUoe+T4zuaJgJDo69C8Z64LdG2PL/UkeY6cD3m
         zyigG5rRwANF86CtCxU67ooZAYScywcrRry94wfHU+nRgUkp3ph+5D6CihFeA1NKud7w
         m46fEMBNPpi6nWn0zjFFgY9GUdtAjF/Df+Ia4KfP98w8NrLvuOefj3nCy3CvhtIzIA8s
         ZLyndOzhy2GyqHo3DXH2aax0yuH8oluMd/oOhsrAXOaM1jwarTAqFG5E55NhdSA93LDb
         F2e934lgJ3Q0OdwDEry+qG4ZEMNGQm++K3ebJfTGGTQiVbgynaKCos2dO6ad2rsVvB05
         CTzA==
X-Gm-Message-State: APjAAAUa2bk/E53YcOSL9rTHVhL4LbcyumNHJdjZYHn2VUQhZKHhbkhg
        8aRnuTmvD2lYzu40GDjC+8pQFQ==
X-Google-Smtp-Source: APXvYqyCuOvGTZE/AybZ/gDHe4QEN8i+qZ4WSIQkyZ28ryol7htc0w2Gv8nV5eA51FhpQ1L2JtzRQA==
X-Received: by 2002:a5d:4a91:: with SMTP id o17mr45217966wrq.232.1582276133906;
        Fri, 21 Feb 2020 01:08:53 -0800 (PST)
Received: from bender.baylibre.local ([2a01:e35:2ec0:82b0:4ca8:b25b:98e4:858])
        by smtp.gmail.com with ESMTPSA id h5sm3173288wmf.8.2020.02.21.01.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2020 01:08:52 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     daniel@ffwll.ch, dri-devel@lists.freedesktop.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] drm/meson: crtc: handle commit of Amlogic FBC frames
Date:   Fri, 21 Feb 2020 10:08:45 +0100
Message-Id: <20200221090845.7397-5-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200221090845.7397-1-narmstrong@baylibre.com>
References: <20200221090845.7397-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the VD1 Amlogic FBC decoder is now configured by the overlay driver,
commit the right registers to decode the Amlogic FBC frame.

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

