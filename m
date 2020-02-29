Return-Path: <SRS0=iO2y=4R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3469FC3F2CD
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 16:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10DC02468E
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 16:31:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727240AbgB2QbQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Feb 2020 11:31:16 -0500
Received: from mailoutvs3.siol.net ([185.57.226.194]:46131 "EHLO mail.siol.net"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727119AbgB2QbO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 11:31:14 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTP id B2E4A523546;
        Sat, 29 Feb 2020 17:31:11 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta12.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta12.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id x5SUtkwt73i7; Sat, 29 Feb 2020 17:31:11 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTPS id 48D40523169;
        Sat, 29 Feb 2020 17:31:11 +0100 (CET)
Received: from localhost.localdomain (cpe-194-152-20-232.static.triera.net [194.152.20.232])
        (Authenticated sender: 031275009)
        by mail.siol.net (Zimbra) with ESMTPSA id D39045235E7;
        Sat, 29 Feb 2020 17:31:08 +0100 (CET)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     a.hajda@samsung.com, narmstrong@baylibre.com
Cc:     Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@siol.net, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] drm/bridge: dw-hdmi: Add support for RGB limited range
Date:   Sat, 29 Feb 2020 17:30:43 +0100
Message-Id: <20200229163043.158262-5-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200229163043.158262-1-jernej.skrabec@siol.net>
References: <20200229163043.158262-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CEA 861 standard request that RGB quantization range is "limited" for
CEA modes. Support that by adding CSC matrix which downscales values.

This allows to proper color reproduction on TV and PC monitor at the
same time. In future, override property can be added, like "Broadcast
RGB" in i915 driver.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 36 +++++++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/=
bridge/synopsys/dw-hdmi.c
index 3d6021119942..101c90156fa0 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -92,6 +92,12 @@ static const u16 csc_coeff_rgb_in_eitu709[3][4] =3D {
 	{ 0x6756, 0x78ab, 0x2000, 0x0200 }
 };
=20
+static const u16 csc_coeff_rgb_limited[3][4] =3D {
+	{ 0x1B7C, 0x0000, 0x0000, 0x0020 },
+	{ 0x0000, 0x1B7C, 0x0000, 0x0020 },
+	{ 0x0000, 0x0000, 0x1B7C, 0x0020 }
+};
+
 struct hdmi_vmode {
 	bool mdataenablepolarity;
=20
@@ -109,6 +115,7 @@ struct hdmi_data_info {
 	unsigned int pix_repet_factor;
 	unsigned int hdcp_enable;
 	struct hdmi_vmode video_mode;
+	bool rgb_limited_range;
 };
=20
 struct dw_hdmi_i2c {
@@ -960,6 +967,13 @@ static int is_color_space_conversion(struct dw_hdmi =
*hdmi)
 		hdmi_bus_fmt_is_rgb(hdmi->hdmi_data.enc_out_bus_format);
 }
=20
+static int is_rgb_downscale_needed(struct dw_hdmi *hdmi)
+{
+	return  hdmi_bus_fmt_is_rgb(hdmi->hdmi_data.enc_in_bus_format) &&
+		hdmi_bus_fmt_is_rgb(hdmi->hdmi_data.enc_out_bus_format) &&
+		hdmi->hdmi_data.rgb_limited_range;
+}
+
 static int is_color_space_decimation(struct dw_hdmi *hdmi)
 {
 	if (!hdmi_bus_fmt_is_yuv422(hdmi->hdmi_data.enc_out_bus_format))
@@ -1006,6 +1020,8 @@ static void dw_hdmi_update_csc_coeffs(struct dw_hdm=
i *hdmi)
 				csc_coeff =3D &csc_coeff_rgb_in_eitu709;
 			csc_scale =3D 0;
 		}
+	} else if (is_rgb_downscale_needed(hdmi)) {
+		csc_coeff =3D &csc_coeff_rgb_limited;
 	}
=20
 	/* The CSC registers are sequential, alternating MSB then LSB */
@@ -1615,6 +1631,18 @@ static void hdmi_config_AVI(struct dw_hdmi *hdmi, =
struct drm_display_mode *mode)
 	drm_hdmi_avi_infoframe_from_display_mode(&frame,
 						 &hdmi->connector, mode);
=20
+	if (hdmi_bus_fmt_is_rgb(hdmi->hdmi_data.enc_out_bus_format)) {
+		drm_hdmi_avi_infoframe_quant_range(&frame, &hdmi->connector,
+						   mode,
+						   hdmi->hdmi_data.rgb_limited_range ?
+						   HDMI_QUANTIZATION_RANGE_LIMITED :
+						   HDMI_QUANTIZATION_RANGE_FULL);
+	} else {
+		frame.quantization_range =3D HDMI_QUANTIZATION_RANGE_DEFAULT;
+		frame.ycc_quantization_range =3D
+			HDMI_YCC_QUANTIZATION_RANGE_LIMITED;
+	}
+
 	if (hdmi_bus_fmt_is_yuv444(hdmi->hdmi_data.enc_out_bus_format))
 		frame.colorspace =3D HDMI_COLORSPACE_YUV444;
 	else if (hdmi_bus_fmt_is_yuv422(hdmi->hdmi_data.enc_out_bus_format))
@@ -1990,13 +2018,13 @@ static void dw_hdmi_enable_video_path(struct dw_h=
dmi *hdmi)
 	hdmi_writeb(hdmi, hdmi->mc_clkdis, HDMI_MC_CLKDIS);
=20
 	/* Enable csc path */
-	if (is_color_space_conversion(hdmi)) {
+	if (is_color_space_conversion(hdmi) || is_rgb_downscale_needed(hdmi)) {
 		hdmi->mc_clkdis &=3D ~HDMI_MC_CLKDIS_CSCCLK_DISABLE;
 		hdmi_writeb(hdmi, hdmi->mc_clkdis, HDMI_MC_CLKDIS);
 	}
=20
 	/* Enable color space conversion if needed */
-	if (is_color_space_conversion(hdmi))
+	if (is_color_space_conversion(hdmi) || is_rgb_downscale_needed(hdmi))
 		hdmi_writeb(hdmi, HDMI_MC_FLOWCTRL_FEED_THROUGH_OFF_CSC_IN_PATH,
 			    HDMI_MC_FLOWCTRL);
 	else
@@ -2100,6 +2128,10 @@ static int dw_hdmi_setup(struct dw_hdmi *hdmi, str=
uct drm_display_mode *mode)
 	/* TOFIX: Default to RGB888 output format */
 	hdmi->hdmi_data.enc_out_bus_format =3D MEDIA_BUS_FMT_RGB888_1X24;
=20
+	hdmi->hdmi_data.rgb_limited_range =3D hdmi->sink_is_hdmi &&
+		drm_default_rgb_quant_range(mode) =3D=3D
+		HDMI_QUANTIZATION_RANGE_LIMITED;
+
 	hdmi->hdmi_data.pix_repet_factor =3D 0;
 	hdmi->hdmi_data.hdcp_enable =3D 0;
 	hdmi->hdmi_data.video_mode.mdataenablepolarity =3D true;
--=20
2.25.1

