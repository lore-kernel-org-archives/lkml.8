Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF3B3C3F2DE
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 10:41:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5F682072D
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 10:41:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="r2MYqfzd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387958AbgCDKlP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 05:41:15 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50625 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387901AbgCDKlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 05:41:13 -0500
Received: by mail-wm1-f68.google.com with SMTP id a5so1453039wmb.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 02:41:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n38Pxw3whs5fznpPVxQ1dxhIU8Emvi8naZ5TfMMjuYM=;
        b=r2MYqfzdvVoDUW66p/VV4VfzD3pDZTULdjd/Fe2J80Z7imVNlSyofmxKLNb/2/89q6
         UD/0gn3kmjyaTd3j786ghUAjVxoh6m3bcF1HoTk08KNiS3ypv8cjQPxIwdB5e4wuvx1d
         p/QzSfQC7Ymv0QuJKpi9g2E0TA9SH74g5HpE0IGbsXH5x5NsVu/dxno6R515C7eXo929
         64U2IimPXxxvrNz1yhZSq8VVnpxoe4ECC4QUdBVaSg8kzZDobPJxLzL9UlAnrYGh+yFo
         CKLk9sFWaRhU3+eOYxcO3CfKCvCj3xggz6yxW0UDSQgAqnKRqEoQREagH4IN94DpgXmO
         6maA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n38Pxw3whs5fznpPVxQ1dxhIU8Emvi8naZ5TfMMjuYM=;
        b=RF7pEthtbBJ++LkmksAdTSyW/S6F4lxSFS4ysSC4pgb8wMGccqrA80pCdFqHJAj6ff
         tmKUqZoPL3M6hzdqOvGfwYIj5pgMwr74JkdyTSlVpXdVK0tr57EAC9pFUm0v8BINVEzs
         ZIgca6qZ7497+ORj0m5WoZrDUYsKLUghAz2nu3UuWVUvhJ6V87ZEc+fs2gFg4v8rgBSg
         wrNQv2k5UEkqb2KDidWMvXD7i+oVYfOkY6/Nz2mnmiXKDMjDImTyTAX+eOwVQs3ejfBM
         yHD2eYFQU6JRG/3Jx3ccvsrTsYkRj6A46PtBdskX+nAm8CXMnEVL61mIuzmftIQwrzuL
         l1Nw==
X-Gm-Message-State: ANhLgQ1BqbT3TQmM3tWze9bWBUFhwHgADe9aEGjxo3xmxAA/BkBsvmBC
        JS+ut5QUA94ENf+eMnobUZYHwQ==
X-Google-Smtp-Source: ADFU+vsENT48+5JvIVgSQf23iBf7GP5lA+KcoRwznuVpTeZxVqwpbePrrqLqD0iGtf6DyC1FQanS6A==
X-Received: by 2002:a1c:b0c3:: with SMTP id z186mr2986960wme.36.1583318470363;
        Wed, 04 Mar 2020 02:41:10 -0800 (PST)
Received: from bender.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id c14sm24006398wro.36.2020.03.04.02.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 02:41:09 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     a.hajda@samsung.com, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@siol.net,
        boris.brezillon@collabora.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 11/11] drm/meson: Add YUV420 output support
Date:   Wed,  4 Mar 2020 11:40:52 +0100
Message-Id: <20200304104052.17196-12-narmstrong@baylibre.com>
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

This patch adds support for the YUV420 output from the Amlogic Meson SoCs
Video Processing Unit to the HDMI Controller.

The YUV420 is obtained by generating a YUV444 pixel stream like
the classic HDMI display modes, but then the Video Encoder output
can be configured to down-sample the YUV444 pixel stream to a YUV420
stream.
In addition if pixel stream down-sampling, the Y Cb Cr components must
also be mapped differently to align with the HDMI2.0 specifications.

This mode needs a different clock generation scheme since the TMDS PHY
clock must match the 10x ratio with the YUV420 pixel clock, but
the video encoder must run at 2x the pixel clock.

This patch enables the bridge bus format negociation, and handles
the YUV420 case if selected by the negociation.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Jernej Škrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/meson/meson_dw_hdmi.c | 91 ++++++++++++++++++++-------
 1 file changed, 70 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/meson/meson_dw_hdmi.c b/drivers/gpu/drm/meson/meson_dw_hdmi.c
index b5b0d45eb314..e8c94915a4fc 100644
--- a/drivers/gpu/drm/meson/meson_dw_hdmi.c
+++ b/drivers/gpu/drm/meson/meson_dw_hdmi.c
@@ -150,6 +150,7 @@ struct meson_dw_hdmi {
 	struct regulator *hdmi_supply;
 	u32 irq_stat;
 	struct dw_hdmi *hdmi;
+	unsigned long output_bus_fmt;
 };
 #define encoder_to_meson_dw_hdmi(x) \
 	container_of(x, struct meson_dw_hdmi, encoder)
@@ -301,6 +302,10 @@ static void meson_hdmi_phy_setup_mode(struct meson_dw_hdmi *dw_hdmi,
 	struct meson_drm *priv = dw_hdmi->priv;
 	unsigned int pixel_clock = mode->clock;
 
+	/* For 420, pixel clock is half unlike venc clock */
+	if (dw_hdmi->output_bus_fmt == MEDIA_BUS_FMT_UYYVYY8_0_5X24)
+		pixel_clock /= 2;
+
 	if (dw_hdmi_is_compatible(dw_hdmi, "amlogic,meson-gxl-dw-hdmi") ||
 	    dw_hdmi_is_compatible(dw_hdmi, "amlogic,meson-gxm-dw-hdmi")) {
 		if (pixel_clock >= 371250) {
@@ -383,6 +388,10 @@ static void dw_hdmi_set_vclk(struct meson_dw_hdmi *dw_hdmi,
 
 	vclk_freq = mode->clock;
 
+	/* For 420, pixel clock is half unlike venc clock */
+	if (dw_hdmi->output_bus_fmt == MEDIA_BUS_FMT_UYYVYY8_0_5X24)
+		vclk_freq /= 2;
+
 	/* TMDS clock is pixel_clock * 10 */
 	phy_freq = vclk_freq * 10;
 
@@ -392,13 +401,16 @@ static void dw_hdmi_set_vclk(struct meson_dw_hdmi *dw_hdmi,
 		return;
 	}
 
+	/* 480i/576i needs global pixel doubling */
 	if (mode->flags & DRM_MODE_FLAG_DBLCLK)
 		vclk_freq *= 2;
 
 	venc_freq = vclk_freq;
 	hdmi_freq = vclk_freq;
 
-	if (meson_venc_hdmi_venc_repeat(vic))
+	/* VENC double pixels for 1080i, 720p and YUV420 modes */
+	if (meson_venc_hdmi_venc_repeat(vic) ||
+	    dw_hdmi->output_bus_fmt == MEDIA_BUS_FMT_UYYVYY8_0_5X24)
 		venc_freq *= 2;
 
 	vclk_freq = max(venc_freq, hdmi_freq);
@@ -445,8 +457,9 @@ static int dw_hdmi_phy_init(struct dw_hdmi *hdmi, void *data,
 	/* Enable normal output to PHY */
 	dw_hdmi->data->top_write(dw_hdmi, HDMITX_TOP_BIST_CNTL, BIT(12));
 
-	/* TMDS pattern setup (TOFIX Handle the YUV420 case) */
-	if (mode->clock > 340000) {
+	/* TMDS pattern setup */
+	if (mode->clock > 340000 &&
+	    dw_hdmi->output_bus_fmt == MEDIA_BUS_FMT_YUV8_1X24) {
 		dw_hdmi->data->top_write(dw_hdmi, HDMITX_TOP_TMDS_CLK_PTTN_01,
 				  0);
 		dw_hdmi->data->top_write(dw_hdmi, HDMITX_TOP_TMDS_CLK_PTTN_23,
@@ -621,6 +634,7 @@ dw_hdmi_mode_valid(struct drm_connector *connector,
 		   const struct drm_display_mode *mode)
 {
 	struct meson_drm *priv = connector->dev->dev_private;
+	bool is_hdmi2_sink = connector->display_info.hdmi.scdc.supported;
 	unsigned int phy_freq;
 	unsigned int vclk_freq;
 	unsigned int venc_freq;
@@ -630,9 +644,11 @@ dw_hdmi_mode_valid(struct drm_connector *connector,
 
 	DRM_DEBUG_DRIVER("Modeline " DRM_MODE_FMT "\n", DRM_MODE_ARG(mode));
 
-	/* If sink max TMDS clock, we reject the mode */
+	/* If sink does not support 540MHz, reject the non-420 HDMI2 modes */
 	if (connector->display_info.max_tmds_clock &&
-	    mode->clock > connector->display_info.max_tmds_clock)
+	    mode->clock > connector->display_info.max_tmds_clock &&
+	    !drm_mode_is_420_only(&connector->display_info, mode) &&
+	    !drm_mode_is_420_also(&connector->display_info, mode))
 		return MODE_BAD;
 
 	/* Check against non-VIC supported modes */
@@ -648,6 +664,12 @@ dw_hdmi_mode_valid(struct drm_connector *connector,
 
 	vclk_freq = mode->clock;
 
+	/* For 420, pixel clock is half unlike venc clock */
+	if (drm_mode_is_420_only(&connector->display_info, mode) ||
+	    (!is_hdmi2_sink &&
+	     drm_mode_is_420_also(&connector->display_info, mode)))
+		vclk_freq /= 2;
+
 	/* TMDS clock is pixel_clock * 10 */
 	phy_freq = vclk_freq * 10;
 
@@ -658,8 +680,11 @@ dw_hdmi_mode_valid(struct drm_connector *connector,
 	venc_freq = vclk_freq;
 	hdmi_freq = vclk_freq;
 
-	/* VENC double pixels for 1080i and 720p modes */
-	if (meson_venc_hdmi_venc_repeat(vic))
+	/* VENC double pixels for 1080i, 720p and YUV420 modes */
+	if (meson_venc_hdmi_venc_repeat(vic) ||
+	    drm_mode_is_420_only(&connector->display_info, mode) ||
+	    (!is_hdmi2_sink &&
+	     drm_mode_is_420_also(&connector->display_info, mode)))
 		venc_freq *= 2;
 
 	vclk_freq = max(venc_freq, hdmi_freq);
@@ -677,6 +702,7 @@ dw_hdmi_mode_valid(struct drm_connector *connector,
 
 static const u32 meson_dw_hdmi_out_bus_fmts[] = {
 	MEDIA_BUS_FMT_YUV8_1X24,
+	MEDIA_BUS_FMT_UYYVYY8_0_5X24,
 };
 
 static void meson_venc_hdmi_encoder_destroy(struct drm_encoder *encoder)
@@ -697,18 +723,23 @@ meson_venc_hdmi_encoder_get_inp_bus_fmts(struct drm_bridge *bridge,
 					unsigned int *num_input_fmts)
 {
 	u32 *input_fmts = NULL;
+	int i;
 
-	if (output_fmt == meson_dw_hdmi_out_bus_fmts[0]) {
-		*num_input_fmts = 1;
-		input_fmts = kcalloc(*num_input_fmts,
-				     sizeof(*input_fmts),
-				     GFP_KERNEL);
-		if (!input_fmts)
-			return NULL;
+	*num_input_fmts = 0;
 
-		input_fmts[0] = output_fmt;
-	} else {
-		*num_input_fmts = 0;
+	for (i = 0 ; i < ARRAY_SIZE(meson_dw_hdmi_out_bus_fmts) ; ++i) {
+		if (output_fmt == meson_dw_hdmi_out_bus_fmts[i]) {
+			*num_input_fmts = 1;
+			input_fmts = kcalloc(*num_input_fmts,
+					     sizeof(*input_fmts),
+					     GFP_KERNEL);
+			if (!input_fmts)
+				return NULL;
+
+			input_fmts[0] = output_fmt;
+
+			break;
+		}
 	}
 
 	return input_fmts;
@@ -719,6 +750,12 @@ static int meson_venc_hdmi_encoder_atomic_check(struct drm_bridge *bridge,
 					struct drm_crtc_state *crtc_state,
 					struct drm_connector_state *conn_state)
 {
+	struct meson_dw_hdmi *dw_hdmi = bridge_to_meson_dw_hdmi(bridge);
+
+	dw_hdmi->output_bus_fmt = bridge_state->output_bus_cfg.format;
+
+	DRM_DEBUG_DRIVER("output_bus_fmt %lx\n", dw_hdmi->output_bus_fmt);
+
 	return 0;
 }
 
@@ -756,18 +793,29 @@ static void meson_venc_hdmi_encoder_mode_set(struct drm_bridge *bridge,
 	struct meson_dw_hdmi *dw_hdmi = bridge_to_meson_dw_hdmi(bridge);
 	struct meson_drm *priv = dw_hdmi->priv;
 	int vic = drm_match_cea_mode(mode);
+	unsigned int ycrcb_map = VPU_HDMI_OUTPUT_CBYCR;
+	bool yuv420_mode = false;
 
 	DRM_DEBUG_DRIVER("\"%s\" vic %d\n", mode->name, vic);
 
+	if (dw_hdmi->output_bus_fmt == MEDIA_BUS_FMT_UYYVYY8_0_5X24) {
+		ycrcb_map = VPU_HDMI_OUTPUT_CRYCB;
+		yuv420_mode = true;
+	}
+
 	/* VENC + VENC-DVI Mode setup */
-	meson_venc_hdmi_mode_set(priv, vic, ycrcb_map, false,
-				 VPU_HDMI_OUTPUT_CBYCR);
+	meson_venc_hdmi_mode_set(priv, vic, ycrcb_map, yuv420_mode, mode);
 
 	/* VCLK Set clock */
 	dw_hdmi_set_vclk(dw_hdmi, mode);
 
-	/* Setup YUV444 to HDMI-TX, no 10bit diphering */
-	writel_relaxed(0, priv->io_base + _REG(VPU_HDMI_FMT_CTRL));
+	if (dw_hdmi->output_bus_fmt == MEDIA_BUS_FMT_UYYVYY8_0_5X24)
+		/* Setup YUV420 to HDMI-TX, no 10bit diphering */
+		writel_relaxed(2 | (2 << 2),
+			       priv->io_base + _REG(VPU_HDMI_FMT_CTRL));
+	else
+		/* Setup YUV444 to HDMI-TX, no 10bit diphering */
+		writel_relaxed(0, priv->io_base + _REG(VPU_HDMI_FMT_CTRL));
 }
 
 static const struct drm_bridge_funcs meson_venc_hdmi_encoder_bridge_funcs = {
@@ -1024,6 +1072,7 @@ static int meson_dw_hdmi_bind(struct device *dev, struct device *master,
 	dw_plat_data->phy_name = "meson_dw_hdmi_phy";
 	dw_plat_data->phy_data = meson_dw_hdmi;
 	dw_plat_data->input_bus_encoding = V4L2_YCBCR_ENC_709;
+	dw_plat_data->ycbcr_420_allowed = true;
 
 	if (dw_hdmi_is_compatible(meson_dw_hdmi, "amlogic,meson-gxl-dw-hdmi") ||
 	    dw_hdmi_is_compatible(meson_dw_hdmi, "amlogic,meson-gxm-dw-hdmi") ||
-- 
2.22.0

