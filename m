Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6085FC3F2D1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 10:41:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2837621744
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 10:41:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="U/U/KiI5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387911AbgCDKlK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 05:41:10 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37044 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387872AbgCDKlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 05:41:08 -0500
Received: by mail-wr1-f66.google.com with SMTP id q8so1763580wrm.4
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 02:41:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=05GmesXdW073k2ThBbeiRKr/Oe1AMG//k9yDOxDZStc=;
        b=U/U/KiI5JLOZevcMUF+9Xsb2DBBUFZDM2606GLhQwATjzhcx9dTIsbnNoQ1lr9UW6E
         vB+rEBog8owFcLIprm/qqULio8u6RRJLR6T6wqiUg1gkwnQ+ibvuoXx0LGuaeKOqaiXn
         CguoreMjpdmvMwL6cdquv1EdYXyneCRuvsthQR4kArsTv4apxu84n1q0VRFUPao3GO1R
         IMnPLbD3CYbF78KrFuMZ+4t2JXbJh+JhoG9MTphCDIfU4Hk8htY8rUnSf7TNm2Y1KUgz
         phqvrbxrZK/0spwcZY4VrzioGHP2qv1XKPCDZQ6S11bJL03xdtxKe8iI3+Qcl0hluuLH
         99rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=05GmesXdW073k2ThBbeiRKr/Oe1AMG//k9yDOxDZStc=;
        b=AI+zksV2oNFWijUXjnWGRpjhfXEMEmaHI3T5lV4aDsjLXhMnpKr3FmdhVmYWNC5Nxv
         A9zhHkHXgJRWhrg1ymvIH6Um42PiI+DtRkoKZO4M8arSAOMoQLyz1R947uaRPt5GxvIz
         kzohokgZa1A4lBcM0P7PWUo7gQpsCo3XTtbkNsjjBSDMjE+geeHamOdRpnKJVyFPNmbb
         +PtiJVeeKGxh9XRDS8FFkrSd/btREoXug5uRoQkG91wczICQ9Vle1HaGR8BUzQ+U3ZYf
         /8947e9QLyLGMOrLKXhtb9m6KzTd/3aot5xjQV4i2U2Ec7ivyZ7a2aMO4Ftew+ReVcp4
         tY7g==
X-Gm-Message-State: ANhLgQ1W3kzEIN6E4GnBK0CB8lhVRjXyDnSzdzzGwZkV+0Af4b3voN2Y
        B6HNWF9NpYvc9Tav479lpnVm2A==
X-Google-Smtp-Source: ADFU+vtJw0egIlXgBDOkbFEXsnhTQjbYHbr4BOS2yBiHRitOhRYMVeYYBEjHxfS0CzUiZMRFusqU5g==
X-Received: by 2002:adf:df8f:: with SMTP id z15mr3454925wrl.184.1583318466092;
        Wed, 04 Mar 2020 02:41:06 -0800 (PST)
Received: from bender.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id c14sm24006398wro.36.2020.03.04.02.41.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 02:41:05 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     a.hajda@samsung.com, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@siol.net,
        boris.brezillon@collabora.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 07/11] drm/meson: meson_dw_hdmi: add bridge and switch to drm_bridge_funcs
Date:   Wed,  4 Mar 2020 11:40:48 +0100
Message-Id: <20200304104052.17196-8-narmstrong@baylibre.com>
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

Switch the dw-hdmi driver to drm_bridge_funcs by implementing a new local
bridge, connecting it to the dw-hdmi bridge, then implement the
atomic_get_input_bus_fmts/atomic_get_output_bus_fmts.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Jernej Škrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/meson/meson_dw_hdmi.c | 85 ++++++++++++++++++++-------
 1 file changed, 65 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/meson/meson_dw_hdmi.c b/drivers/gpu/drm/meson/meson_dw_hdmi.c
index 3bb7ffe5fc39..8f51d032262c 100644
--- a/drivers/gpu/drm/meson/meson_dw_hdmi.c
+++ b/drivers/gpu/drm/meson/meson_dw_hdmi.c
@@ -16,6 +16,7 @@
 
 #include <drm/bridge/dw_hdmi.h>
 #include <drm/drm_atomic_helper.h>
+#include <drm/drm_bridge.h>
 #include <drm/drm_device.h>
 #include <drm/drm_edid.h>
 #include <drm/drm_probe_helper.h>
@@ -135,6 +136,7 @@ struct meson_dw_hdmi_data {
 
 struct meson_dw_hdmi {
 	struct drm_encoder encoder;
+	struct drm_bridge bridge;
 	struct dw_hdmi_plat_data dw_plat_data;
 	struct meson_drm *priv;
 	struct device *dev;
@@ -151,6 +153,8 @@ struct meson_dw_hdmi {
 };
 #define encoder_to_meson_dw_hdmi(x) \
 	container_of(x, struct meson_dw_hdmi, encoder)
+#define bridge_to_meson_dw_hdmi(x) \
+	container_of(x, struct meson_dw_hdmi, bridge)
 
 static inline int dw_hdmi_is_compatible(struct meson_dw_hdmi *dw_hdmi,
 					const char *compat)
@@ -368,7 +372,7 @@ static inline void meson_dw_hdmi_phy_reset(struct meson_dw_hdmi *dw_hdmi)
 }
 
 static void dw_hdmi_set_vclk(struct meson_dw_hdmi *dw_hdmi,
-			     struct drm_display_mode *mode)
+			     const struct drm_display_mode *mode)
 {
 	struct meson_drm *priv = dw_hdmi->priv;
 	int vic = drm_match_cea_mode(mode);
@@ -663,6 +667,10 @@ dw_hdmi_mode_valid(struct drm_connector *connector,
 
 /* Encoder */
 
+static const u32 meson_dw_hdmi_out_bus_fmts[] = {
+	MEDIA_BUS_FMT_YUV8_1X24,
+};
+
 static void meson_venc_hdmi_encoder_destroy(struct drm_encoder *encoder)
 {
 	drm_encoder_cleanup(encoder);
@@ -672,16 +680,43 @@ static const struct drm_encoder_funcs meson_venc_hdmi_encoder_funcs = {
 	.destroy        = meson_venc_hdmi_encoder_destroy,
 };
 
-static int meson_venc_hdmi_encoder_atomic_check(struct drm_encoder *encoder,
+static u32 *
+meson_venc_hdmi_encoder_get_inp_bus_fmts(struct drm_bridge *bridge,
+					struct drm_bridge_state *bridge_state,
+					struct drm_crtc_state *crtc_state,
+					struct drm_connector_state *conn_state,
+					u32 output_fmt,
+					unsigned int *num_input_fmts)
+{
+	u32 *input_fmts = NULL;
+
+	if (output_fmt == meson_dw_hdmi_out_bus_fmts[0]) {
+		*num_input_fmts = 1;
+		input_fmts = kcalloc(*num_input_fmts,
+				     sizeof(*input_fmts),
+				     GFP_KERNEL);
+		if (!input_fmts)
+			return NULL;
+
+		input_fmts[0] = output_fmt;
+	} else {
+		*num_input_fmts = 0;
+	}
+
+	return input_fmts;
+}
+
+static int meson_venc_hdmi_encoder_atomic_check(struct drm_bridge *bridge,
+					struct drm_bridge_state *bridge_state,
 					struct drm_crtc_state *crtc_state,
 					struct drm_connector_state *conn_state)
 {
 	return 0;
 }
 
-static void meson_venc_hdmi_encoder_disable(struct drm_encoder *encoder)
+static void meson_venc_hdmi_encoder_disable(struct drm_bridge *bridge)
 {
-	struct meson_dw_hdmi *dw_hdmi = encoder_to_meson_dw_hdmi(encoder);
+	struct meson_dw_hdmi *dw_hdmi = bridge_to_meson_dw_hdmi(bridge);
 	struct meson_drm *priv = dw_hdmi->priv;
 
 	DRM_DEBUG_DRIVER("\n");
@@ -693,9 +728,9 @@ static void meson_venc_hdmi_encoder_disable(struct drm_encoder *encoder)
 	writel_relaxed(0, priv->io_base + _REG(ENCP_VIDEO_EN));
 }
 
-static void meson_venc_hdmi_encoder_enable(struct drm_encoder *encoder)
+static void meson_venc_hdmi_encoder_enable(struct drm_bridge *bridge)
 {
-	struct meson_dw_hdmi *dw_hdmi = encoder_to_meson_dw_hdmi(encoder);
+	struct meson_dw_hdmi *dw_hdmi = bridge_to_meson_dw_hdmi(bridge);
 	struct meson_drm *priv = dw_hdmi->priv;
 
 	DRM_DEBUG_DRIVER("%s\n", priv->venc.hdmi_use_enci ? "VENCI" : "VENCP");
@@ -706,11 +741,11 @@ static void meson_venc_hdmi_encoder_enable(struct drm_encoder *encoder)
 		writel_relaxed(1, priv->io_base + _REG(ENCP_VIDEO_EN));
 }
 
-static void meson_venc_hdmi_encoder_mode_set(struct drm_encoder *encoder,
-				   struct drm_display_mode *mode,
-				   struct drm_display_mode *adjusted_mode)
+static void meson_venc_hdmi_encoder_mode_set(struct drm_bridge *bridge,
+				   const struct drm_display_mode *mode,
+				   const struct drm_display_mode *adjusted_mode)
 {
-	struct meson_dw_hdmi *dw_hdmi = encoder_to_meson_dw_hdmi(encoder);
+	struct meson_dw_hdmi *dw_hdmi = bridge_to_meson_dw_hdmi(bridge);
 	struct meson_drm *priv = dw_hdmi->priv;
 	int vic = drm_match_cea_mode(mode);
 
@@ -726,12 +761,15 @@ static void meson_venc_hdmi_encoder_mode_set(struct drm_encoder *encoder,
 	writel_relaxed(0, priv->io_base + _REG(VPU_HDMI_FMT_CTRL));
 }
 
-static const struct drm_encoder_helper_funcs
-				meson_venc_hdmi_encoder_helper_funcs = {
-	.atomic_check	= meson_venc_hdmi_encoder_atomic_check,
-	.disable	= meson_venc_hdmi_encoder_disable,
-	.enable		= meson_venc_hdmi_encoder_enable,
-	.mode_set	= meson_venc_hdmi_encoder_mode_set,
+static const struct drm_bridge_funcs meson_venc_hdmi_encoder_bridge_funcs = {
+	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
+	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
+	.atomic_get_input_bus_fmts = meson_venc_hdmi_encoder_get_inp_bus_fmts,
+	.atomic_reset = drm_atomic_helper_bridge_reset,
+	.atomic_check = meson_venc_hdmi_encoder_atomic_check,
+	.enable	= meson_venc_hdmi_encoder_enable,
+	.disable = meson_venc_hdmi_encoder_disable,
+	.mode_set = meson_venc_hdmi_encoder_mode_set,
 };
 
 /* DW HDMI Regmap */
@@ -852,6 +890,7 @@ static int meson_dw_hdmi_bind(struct device *dev, struct device *master,
 	struct drm_device *drm = data;
 	struct meson_drm *priv = drm->dev_private;
 	struct dw_hdmi_plat_data *dw_plat_data;
+	struct drm_bridge *next_bridge;
 	struct drm_encoder *encoder;
 	struct resource *res;
 	int irq;
@@ -953,8 +992,6 @@ static int meson_dw_hdmi_bind(struct device *dev, struct device *master,
 
 	/* Encoder */
 
-	drm_encoder_helper_add(encoder, &meson_venc_hdmi_encoder_helper_funcs);
-
 	ret = drm_encoder_init(drm, encoder, &meson_venc_hdmi_encoder_funcs,
 			       DRM_MODE_ENCODER_TMDS, "meson_hdmi");
 	if (ret) {
@@ -962,6 +999,9 @@ static int meson_dw_hdmi_bind(struct device *dev, struct device *master,
 		return ret;
 	}
 
+	meson_dw_hdmi->bridge.funcs = &meson_venc_hdmi_encoder_bridge_funcs;
+	drm_bridge_attach(encoder, &meson_dw_hdmi->bridge, NULL, 0);
+
 	encoder->possible_crtcs = BIT(0);
 
 	DRM_DEBUG_DRIVER("encoder initialized\n");
@@ -984,11 +1024,16 @@ static int meson_dw_hdmi_bind(struct device *dev, struct device *master,
 
 	platform_set_drvdata(pdev, meson_dw_hdmi);
 
-	meson_dw_hdmi->hdmi = dw_hdmi_bind(pdev, encoder,
-					   &meson_dw_hdmi->dw_plat_data);
+	meson_dw_hdmi->hdmi = dw_hdmi_probe(pdev,
+					    &meson_dw_hdmi->dw_plat_data);
 	if (IS_ERR(meson_dw_hdmi->hdmi))
 		return PTR_ERR(meson_dw_hdmi->hdmi);
 
+	next_bridge = of_drm_find_bridge(pdev->dev.of_node);
+	if (next_bridge)
+		drm_bridge_attach(encoder, next_bridge,
+				  &meson_dw_hdmi->bridge, 0);
+
 	DRM_DEBUG_DRIVER("HDMI controller initialized\n");
 
 	return 0;
-- 
2.22.0

