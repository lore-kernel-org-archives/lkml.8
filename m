Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ADEFC3F2D7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 23:25:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CFC620866
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 23:25:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388642AbgCDXZp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 18:25:45 -0500
Received: from mailoutvs4.siol.net ([185.57.226.195]:47953 "EHLO mail.siol.net"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388622AbgCDXZo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 18:25:44 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 8EAAC523EAA;
        Thu,  5 Mar 2020 00:25:42 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta11.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta11.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 4GlHJmcXyjtl; Thu,  5 Mar 2020 00:25:42 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 34B7152273A;
        Thu,  5 Mar 2020 00:25:42 +0100 (CET)
Received: from localhost.localdomain (cpe-194-152-20-232.static.triera.net [194.152.20.232])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id AECC4523FC2;
        Thu,  5 Mar 2020 00:25:39 +0100 (CET)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     a.hajda@samsung.com, narmstrong@baylibre.com
Cc:     Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@siol.net, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] drm/bridge: dw-hdmi: rework csc related functions
Date:   Thu,  5 Mar 2020 00:25:12 +0100
Message-Id: <20200304232512.51616-5-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200304232512.51616-1-jernej.skrabec@siol.net>
References: <20200304232512.51616-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

is_color_space_conversion() is a misnomer. It checks not only if color
space conversion is needed, but also if format conversion is needed.
This is actually desired behaviour because result of this function
determines if CSC block should be enabled or not (CSC block can also do
format conversion).

In order to clear misunderstandings, let's rework
is_color_space_conversion() to do exactly what is supposed to do and add
another function which will determine if CSC block must be enabled or
not.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 31 +++++++++++++++--------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/=
bridge/synopsys/dw-hdmi.c
index c8a02e5b5e1b..7724191e0a8b 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -963,11 +963,14 @@ static void hdmi_video_sample(struct dw_hdmi *hdmi)
=20
 static int is_color_space_conversion(struct dw_hdmi *hdmi)
 {
-	return (hdmi->hdmi_data.enc_in_bus_format !=3D
-			hdmi->hdmi_data.enc_out_bus_format) ||
-	       (hdmi_bus_fmt_is_rgb(hdmi->hdmi_data.enc_in_bus_format) &&
-		hdmi_bus_fmt_is_rgb(hdmi->hdmi_data.enc_out_bus_format) &&
-		hdmi->hdmi_data.rgb_limited_range);
+	struct hdmi_data_info *hdmi_data =3D &hdmi->hdmi_data;
+	bool is_input_rgb, is_output_rgb;
+
+	is_input_rgb =3D hdmi_bus_fmt_is_rgb(hdmi_data->enc_in_bus_format);
+	is_output_rgb =3D hdmi_bus_fmt_is_rgb(hdmi_data->enc_out_bus_format);
+
+	return (is_input_rgb !=3D is_output_rgb) ||
+	       (is_input_rgb && is_output_rgb && hdmi_data->rgb_limited_range);
 }
=20
 static int is_color_space_decimation(struct dw_hdmi *hdmi)
@@ -994,6 +997,13 @@ static int is_color_space_interpolation(struct dw_hd=
mi *hdmi)
 	return 0;
 }
=20
+static bool is_conversion_needed(struct dw_hdmi *hdmi)
+{
+	return is_color_space_conversion(hdmi) ||
+	       is_color_space_decimation(hdmi) ||
+	       is_color_space_interpolation(hdmi);
+}
+
 static void dw_hdmi_update_csc_coeffs(struct dw_hdmi *hdmi)
 {
 	const u16 (*csc_coeff)[3][4] =3D &csc_coeff_default;
@@ -2014,18 +2024,19 @@ static void dw_hdmi_enable_video_path(struct dw_h=
dmi *hdmi)
 	hdmi_writeb(hdmi, hdmi->mc_clkdis, HDMI_MC_CLKDIS);
=20
 	/* Enable csc path */
-	if (is_color_space_conversion(hdmi)) {
+	if (is_conversion_needed(hdmi)) {
 		hdmi->mc_clkdis &=3D ~HDMI_MC_CLKDIS_CSCCLK_DISABLE;
 		hdmi_writeb(hdmi, hdmi->mc_clkdis, HDMI_MC_CLKDIS);
-	}
=20
-	/* Enable color space conversion if needed */
-	if (is_color_space_conversion(hdmi))
 		hdmi_writeb(hdmi, HDMI_MC_FLOWCTRL_FEED_THROUGH_OFF_CSC_IN_PATH,
 			    HDMI_MC_FLOWCTRL);
-	else
+	} else {
+		hdmi->mc_clkdis |=3D HDMI_MC_CLKDIS_CSCCLK_DISABLE;
+		hdmi_writeb(hdmi, hdmi->mc_clkdis, HDMI_MC_CLKDIS);
+
 		hdmi_writeb(hdmi, HDMI_MC_FLOWCTRL_FEED_THROUGH_OFF_CSC_BYPASS,
 			    HDMI_MC_FLOWCTRL);
+	}
 }
=20
 /* Workaround to clear the overflow condition */
--=20
2.25.1

