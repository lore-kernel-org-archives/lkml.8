Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D3ACC3F2DB
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 10:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C88332072D
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 10:41:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="bVrdxbNg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387889AbgCDKlI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 05:41:08 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33395 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387846AbgCDKlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 05:41:05 -0500
Received: by mail-wr1-f67.google.com with SMTP id x7so1787404wrr.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 02:41:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6ZkUuOYw6oIDhs4T3fveXw/SmZpKnvsfwNQEL/dPUzE=;
        b=bVrdxbNgsGJPKweUPvY2xJjH2VdFtgn1cOPYGeYqMIzuVbE1TcCuXRbBBA6IKUbNQc
         7rbrsv5eUvF8J6TibSLe/RW8T6KORHyhANkAucODgmVUFR+4IT9zeKIDon8IzxCS/2e7
         TNOmXuii7mZyaV/u7Va1gzoBKHRg0Gi2jmWu7bnpzaemAMmn7b5wgzFJA2eCUtWc6YY9
         YgTzv6wKAWnKWFE0E7GbZU31PHZTfNs6N4UMO0oodvXIrn6U2Soc1FtRnGBRR+H/1Sbx
         ZmiTc1pAm+JUB/DlrzGirdPeP2Cf9Fa1gzFA4KTQJty6G+w6j1Z/BDL2x9CBDDmty5xn
         jbww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6ZkUuOYw6oIDhs4T3fveXw/SmZpKnvsfwNQEL/dPUzE=;
        b=f6QhftJ4D2GHufny9toyO5ibHI6UT/BnYZbMxtUBwm5pcht8QMUVPxFxviYjU52VXG
         mp3yNe931kG+4HndTgbv9pRf6ejGB5Ll60bkbkVGpz8dnhzxJnY9pxjXv7uUTW+3PfVO
         Hzw6CRiV7iZkbdOC6dcXpQn5rGdsXbPwiSpQqYd71AV3dMpT85Bxa3r6QU/UAfEGsZhc
         1KqgtP5WNEZ+Jm3XJ6oa1v/KjKuq28OjTeOzg6Lz6wtYfSBMDgw1PVcwHBzlGVV8pELb
         zkStRPS0F8fTjFsrTXdgq1ZsAEaTbADDxg3L0Qncuhw5WuC/2EDxZjJzjbAprJ80uZPX
         nBlA==
X-Gm-Message-State: ANhLgQ3Hk6qBK4r9QNvC5zbQ1K0TMufaDDdJmCgpInuSdgp4lp/htRdn
        qX0kSTSQPYXiwo6JpUUtUUDF9A==
X-Google-Smtp-Source: ADFU+vtD3x1fiJXCg5Qp3/2BAnBmsyEPwtPcQlLFwNFmLEseD7F6O5FqDCofDPKVJYjNdqlbUDLMYg==
X-Received: by 2002:a05:6000:18f:: with SMTP id p15mr3750356wrx.149.1583318462824;
        Wed, 04 Mar 2020 02:41:02 -0800 (PST)
Received: from bender.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id c14sm24006398wro.36.2020.03.04.02.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 02:41:02 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     p.zabel@pengutronix.de, heiko@sntech.de, a.hajda@samsung.com,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@siol.net, boris.brezillon@collabora.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 04/11] drm/bridge: synopsys: dw-hdmi: add bus format negociation
Date:   Wed,  4 Mar 2020 11:40:45 +0100
Message-Id: <20200304104052.17196-5-narmstrong@baylibre.com>
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

Add the atomic_get_output_bus_fmts, atomic_get_input_bus_fmts to negociate
the possible output and input formats for the current mode and monitor,
and use the negotiated formats in a basic atomic_check callback.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Reviewed-by: Jernej Škrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 281 +++++++++++++++++++++-
 1 file changed, 277 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index 9f2918898f60..de19e8993e1d 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -2097,11 +2097,10 @@ static int dw_hdmi_setup(struct dw_hdmi *hdmi, struct drm_display_mode *mode)
 	hdmi->hdmi_data.video_mode.mpixelrepetitionoutput = 0;
 	hdmi->hdmi_data.video_mode.mpixelrepetitioninput = 0;
 
-	/* TOFIX: Get input format from plat data or fallback to RGB888 */
 	if (hdmi->plat_data->input_bus_format)
 		hdmi->hdmi_data.enc_in_bus_format =
 			hdmi->plat_data->input_bus_format;
-	else
+	else if (hdmi->hdmi_data.enc_in_bus_format == MEDIA_BUS_FMT_FIXED)
 		hdmi->hdmi_data.enc_in_bus_format = MEDIA_BUS_FMT_RGB888_1X24;
 
 	/* TOFIX: Get input encoding from plat data or fallback to none */
@@ -2111,8 +2110,8 @@ static int dw_hdmi_setup(struct dw_hdmi *hdmi, struct drm_display_mode *mode)
 	else
 		hdmi->hdmi_data.enc_in_encoding = V4L2_YCBCR_ENC_DEFAULT;
 
-	/* TOFIX: Default to RGB888 output format */
-	hdmi->hdmi_data.enc_out_bus_format = MEDIA_BUS_FMT_RGB888_1X24;
+	if (hdmi->hdmi_data.enc_out_bus_format == MEDIA_BUS_FMT_FIXED)
+		hdmi->hdmi_data.enc_out_bus_format = MEDIA_BUS_FMT_RGB888_1X24;
 
 	hdmi->hdmi_data.pix_repet_factor = 0;
 	hdmi->hdmi_data.hdcp_enable = 0;
@@ -2390,6 +2389,277 @@ static const struct drm_connector_helper_funcs dw_hdmi_connector_helper_funcs =
 	.atomic_check = dw_hdmi_connector_atomic_check,
 };
 
+/*
+ * Possible output formats :
+ * - MEDIA_BUS_FMT_UYYVYY16_0_5X48,
+ * - MEDIA_BUS_FMT_UYYVYY12_0_5X36,
+ * - MEDIA_BUS_FMT_UYYVYY10_0_5X30,
+ * - MEDIA_BUS_FMT_UYYVYY8_0_5X24,
+ * - MEDIA_BUS_FMT_YUV16_1X48,
+ * - MEDIA_BUS_FMT_RGB161616_1X48,
+ * - MEDIA_BUS_FMT_UYVY12_1X24,
+ * - MEDIA_BUS_FMT_YUV12_1X36,
+ * - MEDIA_BUS_FMT_RGB121212_1X36,
+ * - MEDIA_BUS_FMT_UYVY10_1X20,
+ * - MEDIA_BUS_FMT_YUV10_1X30,
+ * - MEDIA_BUS_FMT_RGB101010_1X30,
+ * - MEDIA_BUS_FMT_UYVY8_1X16,
+ * - MEDIA_BUS_FMT_YUV8_1X24,
+ * - MEDIA_BUS_FMT_RGB888_1X24,
+ */
+
+/* Can return a maximum of 11 possible output formats for a mode/connector */
+#define MAX_OUTPUT_SEL_FORMATS	11
+
+static u32 *dw_hdmi_bridge_atomic_get_output_bus_fmts(struct drm_bridge *bridge,
+					struct drm_bridge_state *bridge_state,
+					struct drm_crtc_state *crtc_state,
+					struct drm_connector_state *conn_state,
+					unsigned int *num_output_fmts)
+{
+	struct drm_connector *conn = conn_state->connector;
+	struct drm_display_info *info = &conn->display_info;
+	struct drm_display_mode *mode = &crtc_state->mode;
+	u8 max_bpc = conn_state->max_requested_bpc;
+	bool is_hdmi2_sink = info->hdmi.scdc.supported ||
+			     (info->color_formats & DRM_COLOR_FORMAT_YCRCB420);
+	u32 *output_fmts;
+	unsigned int i = 0;
+
+	*num_output_fmts = 0;
+
+	output_fmts = kcalloc(MAX_OUTPUT_SEL_FORMATS, sizeof(*output_fmts),
+			      GFP_KERNEL);
+	if (!output_fmts)
+		return NULL;
+
+	/* If dw-hdmi is the only bridge, avoid negociating with ourselves */
+	if (list_is_singular(&bridge->encoder->bridge_chain)) {
+		*num_output_fmts = 1;
+		output_fmts[0] = MEDIA_BUS_FMT_FIXED;
+
+		return output_fmts;
+	}
+
+	/*
+	 * If the current mode enforces 4:2:0, force the output but format
+	 * to 4:2:0 and do not add the YUV422/444/RGB formats
+	 */
+	if (conn->ycbcr_420_allowed &&
+	    (drm_mode_is_420_only(info, mode) ||
+	     (is_hdmi2_sink && drm_mode_is_420_also(info, mode)))) {
+
+		/* Order bus formats from 16bit to 8bit if supported */
+		if (max_bpc >= 16 && info->bpc == 16 &&
+		    (info->hdmi.y420_dc_modes & DRM_EDID_YCBCR420_DC_48))
+			output_fmts[i++] = MEDIA_BUS_FMT_UYYVYY16_0_5X48;
+
+		if (max_bpc >= 12 && info->bpc >= 12 &&
+		    (info->hdmi.y420_dc_modes & DRM_EDID_YCBCR420_DC_36))
+			output_fmts[i++] = MEDIA_BUS_FMT_UYYVYY12_0_5X36;
+
+		if (max_bpc >= 10 && info->bpc >= 10 &&
+		    (info->hdmi.y420_dc_modes & DRM_EDID_YCBCR420_DC_30))
+			output_fmts[i++] = MEDIA_BUS_FMT_UYYVYY10_0_5X30;
+
+		/* Default 8bit fallback */
+		output_fmts[i++] = MEDIA_BUS_FMT_UYYVYY8_0_5X24;
+
+		*num_output_fmts = i;
+
+		return output_fmts;
+	}
+
+	/*
+	 * Order bus formats from 16bit to 8bit and from YUV422 to RGB
+	 * if supported. In any case the default RGB888 format is added
+	 */
+
+	if (max_bpc >= 16 && info->bpc == 16) {
+		if (info->color_formats & DRM_COLOR_FORMAT_YCRCB444)
+			output_fmts[i++] = MEDIA_BUS_FMT_YUV16_1X48;
+
+		output_fmts[i++] = MEDIA_BUS_FMT_RGB161616_1X48;
+	}
+
+	if (max_bpc >= 12 && info->bpc >= 12) {
+		if (info->color_formats & DRM_COLOR_FORMAT_YCRCB422)
+			output_fmts[i++] = MEDIA_BUS_FMT_UYVY12_1X24;
+
+		if (info->color_formats & DRM_COLOR_FORMAT_YCRCB444)
+			output_fmts[i++] = MEDIA_BUS_FMT_YUV12_1X36;
+
+		output_fmts[i++] = MEDIA_BUS_FMT_RGB121212_1X36;
+	}
+
+	if (max_bpc >= 10 && info->bpc >= 10) {
+		if (info->color_formats & DRM_COLOR_FORMAT_YCRCB422)
+			output_fmts[i++] = MEDIA_BUS_FMT_UYVY10_1X20;
+
+		if (info->color_formats & DRM_COLOR_FORMAT_YCRCB444)
+			output_fmts[i++] = MEDIA_BUS_FMT_YUV10_1X30;
+
+		output_fmts[i++] = MEDIA_BUS_FMT_RGB101010_1X30;
+	}
+
+	if (info->color_formats & DRM_COLOR_FORMAT_YCRCB422)
+		output_fmts[i++] = MEDIA_BUS_FMT_UYVY8_1X16;
+
+	if (info->color_formats & DRM_COLOR_FORMAT_YCRCB444)
+		output_fmts[i++] = MEDIA_BUS_FMT_YUV8_1X24;
+
+	/* Default 8bit RGB fallback */
+	output_fmts[i++] = MEDIA_BUS_FMT_RGB888_1X24;
+
+	*num_output_fmts = i;
+
+	return output_fmts;
+}
+
+/*
+ * Possible input formats :
+ * - MEDIA_BUS_FMT_RGB888_1X24
+ * - MEDIA_BUS_FMT_YUV8_1X24
+ * - MEDIA_BUS_FMT_UYVY8_1X16
+ * - MEDIA_BUS_FMT_UYYVYY8_0_5X24
+ * - MEDIA_BUS_FMT_RGB101010_1X30
+ * - MEDIA_BUS_FMT_YUV10_1X30
+ * - MEDIA_BUS_FMT_UYVY10_1X20
+ * - MEDIA_BUS_FMT_UYYVYY10_0_5X30
+ * - MEDIA_BUS_FMT_RGB121212_1X36
+ * - MEDIA_BUS_FMT_YUV12_1X36
+ * - MEDIA_BUS_FMT_UYVY12_1X24
+ * - MEDIA_BUS_FMT_UYYVYY12_0_5X36
+ * - MEDIA_BUS_FMT_RGB161616_1X48
+ * - MEDIA_BUS_FMT_YUV16_1X48
+ * - MEDIA_BUS_FMT_UYYVYY16_0_5X48
+ */
+
+/* Can return a maximum of 3 possible input formats for an output format */
+#define MAX_INPUT_SEL_FORMATS	3
+
+static u32 *dw_hdmi_bridge_atomic_get_input_bus_fmts(struct drm_bridge *bridge,
+					struct drm_bridge_state *bridge_state,
+					struct drm_crtc_state *crtc_state,
+					struct drm_connector_state *conn_state,
+					u32 output_fmt,
+					unsigned int *num_input_fmts)
+{
+	u32 *input_fmts;
+	unsigned int i = 0;
+
+	*num_input_fmts = 0;
+
+	input_fmts = kcalloc(MAX_INPUT_SEL_FORMATS, sizeof(*input_fmts),
+			     GFP_KERNEL);
+	if (!input_fmts)
+		return NULL;
+
+	switch (output_fmt) {
+	/* If MEDIA_BUS_FMT_FIXED is tested, return default bus format */
+	case MEDIA_BUS_FMT_FIXED:
+		input_fmts[i++] = MEDIA_BUS_FMT_RGB888_1X24;
+		break;
+	/* 8bit */
+	case MEDIA_BUS_FMT_RGB888_1X24:
+		input_fmts[i++] = MEDIA_BUS_FMT_RGB888_1X24;
+		input_fmts[i++] = MEDIA_BUS_FMT_YUV8_1X24;
+		input_fmts[i++] = MEDIA_BUS_FMT_UYVY8_1X16;
+		break;
+	case MEDIA_BUS_FMT_YUV8_1X24:
+		input_fmts[i++] = MEDIA_BUS_FMT_YUV8_1X24;
+		input_fmts[i++] = MEDIA_BUS_FMT_UYVY8_1X16;
+		input_fmts[i++] = MEDIA_BUS_FMT_RGB888_1X24;
+		break;
+	case MEDIA_BUS_FMT_UYVY8_1X16:
+		input_fmts[i++] = MEDIA_BUS_FMT_UYVY8_1X16;
+		input_fmts[i++] = MEDIA_BUS_FMT_YUV8_1X24;
+		input_fmts[i++] = MEDIA_BUS_FMT_RGB888_1X24;
+		break;
+
+	/* 10bit */
+	case MEDIA_BUS_FMT_RGB101010_1X30:
+		input_fmts[i++] = MEDIA_BUS_FMT_RGB101010_1X30;
+		input_fmts[i++] = MEDIA_BUS_FMT_YUV10_1X30;
+		input_fmts[i++] = MEDIA_BUS_FMT_UYVY10_1X20;
+		break;
+	case MEDIA_BUS_FMT_YUV10_1X30:
+		input_fmts[i++] = MEDIA_BUS_FMT_YUV10_1X30;
+		input_fmts[i++] = MEDIA_BUS_FMT_UYVY10_1X20;
+		input_fmts[i++] = MEDIA_BUS_FMT_RGB101010_1X30;
+		break;
+	case MEDIA_BUS_FMT_UYVY10_1X20:
+		input_fmts[i++] = MEDIA_BUS_FMT_UYVY10_1X20;
+		input_fmts[i++] = MEDIA_BUS_FMT_YUV10_1X30;
+		input_fmts[i++] = MEDIA_BUS_FMT_RGB101010_1X30;
+		break;
+
+	/* 12bit */
+	case MEDIA_BUS_FMT_RGB121212_1X36:
+		input_fmts[i++] = MEDIA_BUS_FMT_RGB121212_1X36;
+		input_fmts[i++] = MEDIA_BUS_FMT_YUV12_1X36;
+		input_fmts[i++] = MEDIA_BUS_FMT_UYVY12_1X24;
+		break;
+	case MEDIA_BUS_FMT_YUV12_1X36:
+		input_fmts[i++] = MEDIA_BUS_FMT_YUV12_1X36;
+		input_fmts[i++] = MEDIA_BUS_FMT_UYVY12_1X24;
+		input_fmts[i++] = MEDIA_BUS_FMT_RGB121212_1X36;
+		break;
+	case MEDIA_BUS_FMT_UYVY12_1X24:
+		input_fmts[i++] = MEDIA_BUS_FMT_UYVY12_1X24;
+		input_fmts[i++] = MEDIA_BUS_FMT_YUV12_1X36;
+		input_fmts[i++] = MEDIA_BUS_FMT_RGB121212_1X36;
+		break;
+
+	/* 16bit */
+	case MEDIA_BUS_FMT_RGB161616_1X48:
+		input_fmts[i++] = MEDIA_BUS_FMT_RGB161616_1X48;
+		input_fmts[i++] = MEDIA_BUS_FMT_YUV16_1X48;
+		break;
+	case MEDIA_BUS_FMT_YUV16_1X48:
+		input_fmts[i++] = MEDIA_BUS_FMT_YUV16_1X48;
+		input_fmts[i++] = MEDIA_BUS_FMT_RGB161616_1X48;
+		break;
+
+	/*YUV 4:2:0 */
+	case MEDIA_BUS_FMT_UYYVYY8_0_5X24:
+	case MEDIA_BUS_FMT_UYYVYY10_0_5X30:
+	case MEDIA_BUS_FMT_UYYVYY12_0_5X36:
+	case MEDIA_BUS_FMT_UYYVYY16_0_5X48:
+		input_fmts[i++] = output_fmt;
+		break;
+	}
+
+	*num_input_fmts = i;
+
+	if (*num_input_fmts == 0) {
+		kfree(input_fmts);
+		input_fmts = NULL;
+	}
+
+	return input_fmts;
+}
+
+static int dw_hdmi_bridge_atomic_check(struct drm_bridge *bridge,
+				       struct drm_bridge_state *bridge_state,
+				       struct drm_crtc_state *crtc_state,
+				       struct drm_connector_state *conn_state)
+{
+	struct dw_hdmi *hdmi = bridge->driver_private;
+
+	hdmi->hdmi_data.enc_out_bus_format =
+			bridge_state->output_bus_cfg.format;
+
+	hdmi->hdmi_data.enc_in_bus_format =
+			bridge_state->input_bus_cfg.format;
+
+	dev_dbg(hdmi->dev, "input format 0x%04x, output format 0x%04x\n",
+		bridge_state->input_bus_cfg.format,
+		bridge_state->output_bus_cfg.format);
+
+	return 0;
+}
+
 static int dw_hdmi_bridge_attach(struct drm_bridge *bridge,
 				 enum drm_bridge_attach_flags flags)
 {
@@ -2511,6 +2781,9 @@ static const struct drm_bridge_funcs dw_hdmi_bridge_funcs = {
 	.atomic_reset = drm_atomic_helper_bridge_reset,
 	.attach = dw_hdmi_bridge_attach,
 	.detach = dw_hdmi_bridge_detach,
+	.atomic_check = dw_hdmi_bridge_atomic_check,
+	.atomic_get_output_bus_fmts = dw_hdmi_bridge_atomic_get_output_bus_fmts,
+	.atomic_get_input_bus_fmts = dw_hdmi_bridge_atomic_get_input_bus_fmts,
 	.enable = dw_hdmi_bridge_enable,
 	.disable = dw_hdmi_bridge_disable,
 	.mode_set = dw_hdmi_bridge_mode_set,
-- 
2.22.0

