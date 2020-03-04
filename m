Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A88CC3F2DC
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 10:41:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 239AE2072D
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 10:41:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="UlLnoNwk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387922AbgCDKlM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 05:41:12 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40142 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387901AbgCDKlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 05:41:09 -0500
Received: by mail-wr1-f68.google.com with SMTP id r17so1746152wrj.7
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 02:41:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q1GUIN7KBO8lXS2YCrGPVdl4nGtrL7ahFAkqfmqdfyk=;
        b=UlLnoNwk9f5kegUhbueRDDWxZmwwbTz/9mK+jbJqiY+TA5vkYqqeQEZSng7llq7Ln6
         3XpI+06DOJVJceGP5no37stEXbDHZ9K4e2HgIdYK6KzzQfx4tN6dZKpckkjjYtiqaD4U
         0ocl7+LLwqGahhZMCEC2sKutkJSzaJfrJA07Ci2+EHpXnlVdi2gItXlFoaE04b7Rmikb
         uWbA0hC9Pp8iG18Sg88HEaQABd8tzPImtE1jI2GiYyjRayS8JxOyx70SvBrjABZIJd3S
         EU6XkbgbaUbzirFLd1Gep8pcDuB8xylF8PtdRjXQ2pg9CPjtqdFRRoabYHLvUP0DUY5x
         KVNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q1GUIN7KBO8lXS2YCrGPVdl4nGtrL7ahFAkqfmqdfyk=;
        b=cvFzA6huP3Vy9btM2oZZpE/OVHhfG/S7whYiGNXnCzjF/TJ267rFzth8J4bRO6g4G8
         g2WyKX47PGjpkh9WvuANc5U1McmsYhIeFhfmkIMwtRlk92gqEgHY/Lg2VeULApQSFlKD
         ptxCIAY5H8lYyoeE2sCbPnxWJZJSn+j9SOxjAdQw+X4Cgzedc4medlwLlhraTn2rCi8Y
         +yY4GmFzjfB70bt4POXYCOy8h0JM2AvJi9dume48SXgxstFuK+693aKOC3D/kASWKnFL
         9q/iFXoCiKrp0NxI9q3wTUjhg462PQ2Dp+qvmyr5WX3TcyBDOr9N3OJ1/qqBPCLe69I3
         xAQA==
X-Gm-Message-State: ANhLgQ1DHSlBqggpDE9/92nOyw8KusUTOxlhErh87kH8Z0mGSe9zKfQt
        PRTfDstxwkqClKB599KIRPVd2w==
X-Google-Smtp-Source: ADFU+vvS03o6Ek7ni9t7Qukh+4J0GibYOTSNDC/K49iSwuqzgXiSA2El3UXkF9I+ytl2/KPQDxRQLQ==
X-Received: by 2002:adf:90cd:: with SMTP id i71mr3254354wri.63.1583318468390;
        Wed, 04 Mar 2020 02:41:08 -0800 (PST)
Received: from bender.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id c14sm24006398wro.36.2020.03.04.02.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 02:41:07 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     a.hajda@samsung.com, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@siol.net,
        boris.brezillon@collabora.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 09/11] drm/meson: venc: add support for YUV420 setup
Date:   Wed,  4 Mar 2020 11:40:50 +0100
Message-Id: <20200304104052.17196-10-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200304104052.17196-1-narmstrong@baylibre.com>
References: <20200304104052.17196-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Reviewed-by: Jernej Škrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/meson/meson_dw_hdmi.c | 3 ++-
 drivers/gpu/drm/meson/meson_venc.c    | 8 +++++---
 drivers/gpu/drm/meson/meson_venc.h    | 2 ++
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/meson/meson_dw_hdmi.c b/drivers/gpu/drm/meson/meson_dw_hdmi.c
index 72c118142eaf..b2105c0fe205 100644
--- a/drivers/gpu/drm/meson/meson_dw_hdmi.c
+++ b/drivers/gpu/drm/meson/meson_dw_hdmi.c
@@ -752,7 +752,8 @@ static void meson_venc_hdmi_encoder_mode_set(struct drm_bridge *bridge,
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

