Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9774C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 09:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82529206D7
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 09:21:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="P4bEHbFe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbgD1JV6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 05:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726477AbgD1JV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 05:21:58 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96072C03C1A9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 02:21:56 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id f13so23716232wrm.13
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 02:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2cLq0w8TGR36+W3YRP72xjNvZ3bw9fmtT1+3RjgE/Tc=;
        b=P4bEHbFevVQ5KU9k6DnsiU/uvu2lKw96YtQSNTZWRu12/7WmLzR7TJd3TDGV8k4Cx2
         q8nOXSaelMy5TRT9I+Peqb13FpfXbfTd1ntvAMOkDMSdrREPsT1um6ibH6ArZ8CfELzA
         Ed4bI06QHFzLHIVK73cyrnS67KiIORQGe3HuA7IywRCYy57SSaqugxcDWdvZztzYn6NW
         TlOpqrb6XU35NcSHiKpJQmhOVghhmP7d6dLWxnUM3ecT7FQGnNp9S9f2WCg5+4PRDBL9
         x5mtluu91d2IFGpmhWOkGd1jr4iyx707nHWIOyHbPrGoRz4rHhwSvgvB6jDs0CvlO8yH
         HXmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2cLq0w8TGR36+W3YRP72xjNvZ3bw9fmtT1+3RjgE/Tc=;
        b=ghnwUcTsu/fmGIXqYKOnrMjqMHeeXmDCrz8ZPcltodw32SzDduDV0WLWKoOXdzp8rY
         9+uVqXWtSegqP+GS17TBN32vF0FCT3lKHX0uKZ6BMJMzvkRS4UVeQMCaIA2sfgmUJ0GR
         MbNcI5iSirXXm/BLitE/QYR9U96aWiusYq+DJqra/j5uwcmgJ8lOTZ8x4gsz+4l8hn8R
         qW0itbY9Yzi934QRAiCagmS5zjC/na2+9b0SDBdB0Jguv+gwi+fshwysOkMAT0GcOm1V
         UURhcZktBI5GHbTDqmpovDAefMZ65+ofLG0JFOKVpc+PXHN5wX9HbYf1SwJd1hnJ/z9y
         xKPg==
X-Gm-Message-State: AGi0PuaXZRAdW5UnPz27PtoxOx0DBEUv4Ddob+kwiOLn+LNAimcfN0CV
        w0ncl09UV4QsIsbGvEeR5xHBaw==
X-Google-Smtp-Source: APiQypK/F5J4biTNEmlibX5kxJGlzXkr4Zfavai0prURf4Z5JUdj8rlNiP+V33qMLKDMbEU/iVJ5pQ==
X-Received: by 2002:a5d:6946:: with SMTP id r6mr29841088wrw.291.1588065715131;
        Tue, 28 Apr 2020 02:21:55 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e35:2ec0:82b0:4460:3fd3:382:4a71])
        by smtp.gmail.com with ESMTPSA id w12sm24070297wrk.56.2020.04.28.02.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 02:21:54 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        martin.blumenstingl@googlemail.com,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v2] drm/meson: add mode selection limits against specific SoC revisions
Date:   Tue, 28 Apr 2020 11:21:47 +0200
Message-Id: <20200428092147.13698-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Amlogic S805X/Y uses the same die as the S905X, but with more
limited graphics capabilities.

This adds a soc version detection adding specific limitations on the HDMI
mode selections.

Here, we limit to HDMI 1.3a max HDMI PHY clock frequency.

Changes sinces v1:
- Moved frequency check in the vclk code, and also checks DMT modes

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/gpu/drm/meson/meson_drv.c     | 29 ++++++++++++++++++++++++++-
 drivers/gpu/drm/meson/meson_drv.h     |  6 ++++++
 drivers/gpu/drm/meson/meson_dw_hdmi.c |  2 +-
 drivers/gpu/drm/meson/meson_vclk.c    | 16 ++++++++++++++-
 drivers/gpu/drm/meson/meson_vclk.h    |  3 ++-
 5 files changed, 52 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/meson/meson_drv.c b/drivers/gpu/drm/meson/meson_drv.c
index 6f29fab79952..621f6de0f076 100644
--- a/drivers/gpu/drm/meson/meson_drv.c
+++ b/drivers/gpu/drm/meson/meson_drv.c
@@ -11,6 +11,7 @@
 #include <linux/component.h>
 #include <linux/module.h>
 #include <linux/of_graph.h>
+#include <linux/sys_soc.h>
 #include <linux/platform_device.h>
 #include <linux/soc/amlogic/meson-canvas.h>
 
@@ -183,6 +184,24 @@ static void meson_remove_framebuffers(void)
 	kfree(ap);
 }
 
+struct meson_drm_soc_attr {
+	struct meson_drm_soc_limits limits;
+	const struct soc_device_attribute *attrs;
+};
+
+static const struct meson_drm_soc_attr meson_drm_soc_attrs[] = {
+	/* S805X/S805Y HDMI PLL won't lock for HDMI PHY freq > 1,65GHz */
+	{
+		.limits = {
+			.max_hdmi_phy_freq = 1650000,
+		},
+		.attrs = (const struct soc_device_attribute []) {
+			{ .soc_id = "GXL (S805*)", },
+			{ /* sentinel */ },
+		}
+	},
+};
+
 static int meson_drv_bind_master(struct device *dev, bool has_components)
 {
 	struct platform_device *pdev = to_platform_device(dev);
@@ -191,7 +210,7 @@ static int meson_drv_bind_master(struct device *dev, bool has_components)
 	struct drm_device *drm;
 	struct resource *res;
 	void __iomem *regs;
-	int ret;
+	int ret, i;
 
 	/* Checks if an output connector is available */
 	if (!meson_vpu_has_available_connectors(dev)) {
@@ -281,6 +300,14 @@ static int meson_drv_bind_master(struct device *dev, bool has_components)
 	if (ret)
 		goto free_drm;
 
+	/* Assign limits per soc revision/package */
+	for (i = 0 ; i < ARRAY_SIZE(meson_drm_soc_attrs) ; ++i) {
+		if (soc_device_match(meson_drm_soc_attrs[i].attrs)) {
+			priv->limits = &meson_drm_soc_attrs[i].limits;
+			break;
+		}
+	}
+
 	/* Remove early framebuffers (ie. simplefb) */
 	meson_remove_framebuffers();
 
diff --git a/drivers/gpu/drm/meson/meson_drv.h b/drivers/gpu/drm/meson/meson_drv.h
index 04fdf3826643..5b23704a80d6 100644
--- a/drivers/gpu/drm/meson/meson_drv.h
+++ b/drivers/gpu/drm/meson/meson_drv.h
@@ -30,6 +30,10 @@ struct meson_drm_match_data {
 	struct meson_afbcd_ops *afbcd_ops;
 };
 
+struct meson_drm_soc_limits {
+	unsigned int max_hdmi_phy_freq;
+};
+
 struct meson_drm {
 	struct device *dev;
 	enum vpu_compatible compat;
@@ -48,6 +52,8 @@ struct meson_drm {
 	struct drm_plane *primary_plane;
 	struct drm_plane *overlay_plane;
 
+	const struct meson_drm_soc_limits *limits;
+
 	/* Components Data */
 	struct {
 		bool osd1_enabled;
diff --git a/drivers/gpu/drm/meson/meson_dw_hdmi.c b/drivers/gpu/drm/meson/meson_dw_hdmi.c
index e8c94915a4fc..5be963e9db05 100644
--- a/drivers/gpu/drm/meson/meson_dw_hdmi.c
+++ b/drivers/gpu/drm/meson/meson_dw_hdmi.c
@@ -695,7 +695,7 @@ dw_hdmi_mode_valid(struct drm_connector *connector,
 	dev_dbg(connector->dev->dev, "%s: vclk:%d phy=%d venc=%d hdmi=%d\n",
 		__func__, phy_freq, vclk_freq, venc_freq, hdmi_freq);
 
-	return meson_vclk_vic_supported_freq(phy_freq, vclk_freq);
+	return meson_vclk_vic_supported_freq(priv, phy_freq, vclk_freq);
 }
 
 /* Encoder */
diff --git a/drivers/gpu/drm/meson/meson_vclk.c b/drivers/gpu/drm/meson/meson_vclk.c
index fdf26dac9fa8..0eb86943a358 100644
--- a/drivers/gpu/drm/meson/meson_vclk.c
+++ b/drivers/gpu/drm/meson/meson_vclk.c
@@ -725,6 +725,13 @@ meson_vclk_dmt_supported_freq(struct meson_drm *priv, unsigned int freq)
 	/* In DMT mode, path after PLL is always /10 */
 	freq *= 10;
 
+	/* Check against soc revision/package limits */
+	if (priv->limits) {
+		if (priv->limits->max_hdmi_phy_freq &&
+		    freq > priv->limits->max_hdmi_phy_freq)
+			return MODE_CLOCK_HIGH;
+	}
+
 	if (meson_hdmi_pll_find_params(priv, freq, &m, &frac, &od))
 		return MODE_OK;
 
@@ -762,7 +769,7 @@ static void meson_hdmi_pll_generic_set(struct meson_drm *priv,
 }
 
 enum drm_mode_status
-meson_vclk_vic_supported_freq(unsigned int phy_freq,
+meson_vclk_vic_supported_freq(struct meson_drm *priv, unsigned int phy_freq,
 			      unsigned int vclk_freq)
 {
 	int i;
@@ -770,6 +777,13 @@ meson_vclk_vic_supported_freq(unsigned int phy_freq,
 	DRM_DEBUG_DRIVER("phy_freq = %d vclk_freq = %d\n",
 			 phy_freq, vclk_freq);
 
+	/* Check against soc revision/package limits */
+	if (priv->limits) {
+		if (priv->limits->max_hdmi_phy_freq &&
+		    phy_freq > priv->limits->max_hdmi_phy_freq)
+			return MODE_CLOCK_HIGH;
+	}
+
 	for (i = 0 ; params[i].pixel_freq ; ++i) {
 		DRM_DEBUG_DRIVER("i = %d pixel_freq = %d alt = %d\n",
 				 i, params[i].pixel_freq,
diff --git a/drivers/gpu/drm/meson/meson_vclk.h b/drivers/gpu/drm/meson/meson_vclk.h
index aed0ab2efa71..60617aaf18dd 100644
--- a/drivers/gpu/drm/meson/meson_vclk.h
+++ b/drivers/gpu/drm/meson/meson_vclk.h
@@ -25,7 +25,8 @@ enum {
 enum drm_mode_status
 meson_vclk_dmt_supported_freq(struct meson_drm *priv, unsigned int freq);
 enum drm_mode_status
-meson_vclk_vic_supported_freq(unsigned int phy_freq, unsigned int vclk_freq);
+meson_vclk_vic_supported_freq(struct meson_drm *priv, unsigned int phy_freq,
+			      unsigned int vclk_freq);
 
 void meson_vclk_setup(struct meson_drm *priv, unsigned int target,
 		      unsigned int phy_freq, unsigned int vclk_freq,
-- 
2.22.0

