Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33C34C3F68F
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 19:18:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07D8422527
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 19:18:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="tLRb2ev7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728033AbgBFTS5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 14:18:57 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53712 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728015AbgBFTSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 14:18:52 -0500
Received: by mail-wm1-f67.google.com with SMTP id s10so1209446wmh.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 11:18:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fthTlSvdqndaDon1km3RUC8MaAbjzEmDQ4T+qx7kFIg=;
        b=tLRb2ev7H3keiN0RtJlGvE0tnAN6Lp0TIP6ZilsTp6GnzlFiPUDJeg+GERg0Z3V/+S
         nH7l+EzoTX7RphmWgUdXloilUCNO7I21UbRnrf150VhhttkCXCZi2+zZ41TWWGKhu+S1
         NToFdQtwoZh+53Xq5u3o4U93i9Rrl1i7Xt3PUJwPz5N87x6LBXxTqg8a/dMq0UYmtjiC
         oSCL1qoIrxk5VMC+8kjkQYRHlKCDu8iHUCbTYPXYxu5bC/0pg3Wxxi8mtbDNUM5FBret
         rx4NqAz1K3STqXJb3E8584rHGl+wYFMgdQ53v2g3ua+1o2iGrwiuM99y2F92rFFkL5po
         RGmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fthTlSvdqndaDon1km3RUC8MaAbjzEmDQ4T+qx7kFIg=;
        b=FpndNqeJh/I+mIDcfWu2X055LuaEHcR7M2MPWZu2/9FiCvAjVfKAP4R9Pj+CZ/zmnL
         59D+aZgdiqD2bj85Et6ZxRJ/j6Grxb3mDJ9davcL60cg09nXYAgfNa1r9whyLUv9ChpZ
         Ee/SO//Jt39FgRWFHQhF6jPG6xLHWNQNaeuRxpPjxv+ZSwY/0ed8BA8xI/3UNHcnqcin
         pMX76qLHn4eNAISZ5LXK2p9OcUSgYjfx+06fIjXK+erV30egNE1vu/6EN1OaiawgXWTu
         daT2A++nO2Y0EiTHi5t1uYgJVK8XzgisTZG0w20elXfwiVTt7hmiROlBr0YCskcZupW8
         0lgQ==
X-Gm-Message-State: APjAAAVazXapRcmeYB2zq5zEqg3B70/2briUUZE/iawIMxCRVuEera71
        7wXOksvENe4dMsSbdxTm+r+mJg==
X-Google-Smtp-Source: APXvYqwlQi9eASN0rOmDcfSxEfYRW3a2yYVPMtn73nQR0JHbukVgLpa0edWoF2Pu+QOpxSmJNLlT9w==
X-Received: by 2002:a7b:cc6a:: with SMTP id n10mr6240559wmj.170.1581016729357;
        Thu, 06 Feb 2020 11:18:49 -0800 (PST)
Received: from bender.baylibre.local ([2a01:e35:2ec0:82b0:7d33:17f7:8097:ecc7])
        by smtp.gmail.com with ESMTPSA id m3sm272662wrs.53.2020.02.06.11.18.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 11:18:48 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     a.hajda@samsung.com, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@siol.net,
        boris.brezillon@collabora.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 09/11] drm/meson: venc: add support for YUV420 setup
Date:   Thu,  6 Feb 2020 20:18:32 +0100
Message-Id: <20200206191834.6125-10-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200206191834.6125-1-narmstrong@baylibre.com>
References: <20200206191834.6125-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds encoding support for the YUV420 output from the
Amlogic Meson SoCs Video Processing Unit to the HDMI Controller.

The YUV420 is obtained by generating a YUV444 pixel stream like
the classic HDMI display modes, but then the Video Encoder output
can be configured to down-sample the YUV444 pixel stream to a YUV420
stream.

In addition if pixel stream down-sampling, the Y Cb Cr components must
also be mapped differently to align with the HDMI2.0 specifications.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/gpu/drm/meson/meson_dw_hdmi.c | 3 ++-
 drivers/gpu/drm/meson/meson_venc.c    | 8 +++++---
 drivers/gpu/drm/meson/meson_venc.h    | 2 ++
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/meson/meson_dw_hdmi.c b/drivers/gpu/drm/meson/meson_dw_hdmi.c
index 686c47106a18..f5d46d082534 100644
--- a/drivers/gpu/drm/meson/meson_dw_hdmi.c
+++ b/drivers/gpu/drm/meson/meson_dw_hdmi.c
@@ -772,7 +772,8 @@ static void meson_venc_hdmi_encoder_mode_set(struct drm_bridge *bridge,
 	DRM_DEBUG_DRIVER("\"%s\" vic %d\n", mode->name, vic);
 
 	/* VENC + VENC-DVI Mode setup */
-	meson_venc_hdmi_mode_set(priv, vic, mode);
+	meson_venc_hdmi_mode_set(priv, vic, ycrcb_map, false,
+				 VPU_HDMI_OUTPUT_CBYCR);
 
 	/* VCLK Set clock */
 	dw_hdmi_set_vclk(dw_hdmi, mode);
diff --git a/drivers/gpu/drm/meson/meson_venc.c b/drivers/gpu/drm/meson/meson_venc.c
index a9ab78970bfe..f93c725b6f02 100644
--- a/drivers/gpu/drm/meson/meson_venc.c
+++ b/drivers/gpu/drm/meson/meson_venc.c
@@ -946,6 +946,8 @@ bool meson_venc_hdmi_venc_repeat(int vic)
 EXPORT_SYMBOL_GPL(meson_venc_hdmi_venc_repeat);
 
 void meson_venc_hdmi_mode_set(struct meson_drm *priv, int vic,
+			      unsigned int ycrcb_map,
+			      bool yuv420_mode,
 			      const struct drm_display_mode *mode)
 {
 	union meson_hdmi_venc_mode *vmode = NULL;
@@ -1528,14 +1530,14 @@ void meson_venc_hdmi_mode_set(struct meson_drm *priv, int vic,
 	if (mode->flags & DRM_MODE_FLAG_PVSYNC)
 		reg |= VPU_HDMI_INV_VSYNC;
 
-	/* Output data format: CbYCr */
-	reg |= VPU_HDMI_OUTPUT_CBYCR;
+	/* Output data format */
+	reg |= ycrcb_map;
 
 	/*
 	 * Write rate to the async FIFO between VENC and HDMI.
 	 * One write every 2 wr_clk.
 	 */
-	if (venc_repeat)
+	if (venc_repeat || yuv420_mode)
 		reg |= VPU_HDMI_WR_RATE(2);
 
 	/*
diff --git a/drivers/gpu/drm/meson/meson_venc.h b/drivers/gpu/drm/meson/meson_venc.h
index 1abdcbdf51c0..9138255ffc9e 100644
--- a/drivers/gpu/drm/meson/meson_venc.h
+++ b/drivers/gpu/drm/meson/meson_venc.h
@@ -60,6 +60,8 @@ extern struct meson_cvbs_enci_mode meson_cvbs_enci_ntsc;
 void meson_venci_cvbs_mode_set(struct meson_drm *priv,
 			       struct meson_cvbs_enci_mode *mode);
 void meson_venc_hdmi_mode_set(struct meson_drm *priv, int vic,
+			      unsigned int ycrcb_map,
+			      bool yuv420_mode,
 			      const struct drm_display_mode *mode);
 unsigned int meson_venci_get_field(struct meson_drm *priv);
 
-- 
2.22.0

