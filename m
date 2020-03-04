Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19A80C3F2CE
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 23:25:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBEB320866
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 23:25:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388606AbgCDXZi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 18:25:38 -0500
Received: from mailoutvs57.siol.net ([185.57.226.248]:47896 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388476AbgCDXZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 18:25:37 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 0EC59523FC2;
        Thu,  5 Mar 2020 00:25:35 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta11.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta11.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Qvcs2Es7GE1z; Thu,  5 Mar 2020 00:25:34 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id AFFDF52273A;
        Thu,  5 Mar 2020 00:25:34 +0100 (CET)
Received: from localhost.localdomain (cpe-194-152-20-232.static.triera.net [194.152.20.232])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id 08014523EAA;
        Thu,  5 Mar 2020 00:25:31 +0100 (CET)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     a.hajda@samsung.com, narmstrong@baylibre.com
Cc:     Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@siol.net, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH v2 1/4] drm/bridge: dw-hdmi: fix AVI frame colorimetry
Date:   Thu,  5 Mar 2020 00:25:09 +0100
Message-Id: <20200304232512.51616-2-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200304232512.51616-1-jernej.skrabec@siol.net>
References: <20200304232512.51616-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CTA-861-F explicitly states that for RGB colorspace colorimetry should
be set to "none". Fix that.

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Fixes: def23aa7e982 ("drm: bridge: dw-hdmi: Switch to V4L bus format and =
encodings")
Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 46 +++++++++++++----------
 1 file changed, 26 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/=
bridge/synopsys/dw-hdmi.c
index 67fca439bbfb..24965e53d351 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -1624,28 +1624,34 @@ static void hdmi_config_AVI(struct dw_hdmi *hdmi,=
 struct drm_display_mode *mode)
 		frame.colorspace =3D HDMI_COLORSPACE_RGB;
=20
 	/* Set up colorimetry */
-	switch (hdmi->hdmi_data.enc_out_encoding) {
-	case V4L2_YCBCR_ENC_601:
-		if (hdmi->hdmi_data.enc_in_encoding =3D=3D V4L2_YCBCR_ENC_XV601)
-			frame.colorimetry =3D HDMI_COLORIMETRY_EXTENDED;
-		else
+	if (!hdmi_bus_fmt_is_rgb(hdmi->hdmi_data.enc_out_bus_format)) {
+		switch (hdmi->hdmi_data.enc_out_encoding) {
+		case V4L2_YCBCR_ENC_601:
+			if (hdmi->hdmi_data.enc_in_encoding =3D=3D V4L2_YCBCR_ENC_XV601)
+				frame.colorimetry =3D HDMI_COLORIMETRY_EXTENDED;
+			else
+				frame.colorimetry =3D HDMI_COLORIMETRY_ITU_601;
+			frame.extended_colorimetry =3D
+					HDMI_EXTENDED_COLORIMETRY_XV_YCC_601;
+			break;
+		case V4L2_YCBCR_ENC_709:
+			if (hdmi->hdmi_data.enc_in_encoding =3D=3D V4L2_YCBCR_ENC_XV709)
+				frame.colorimetry =3D HDMI_COLORIMETRY_EXTENDED;
+			else
+				frame.colorimetry =3D HDMI_COLORIMETRY_ITU_709;
+			frame.extended_colorimetry =3D
+					HDMI_EXTENDED_COLORIMETRY_XV_YCC_709;
+			break;
+		default: /* Carries no data */
 			frame.colorimetry =3D HDMI_COLORIMETRY_ITU_601;
+			frame.extended_colorimetry =3D
+					HDMI_EXTENDED_COLORIMETRY_XV_YCC_601;
+			break;
+		}
+	} else {
+		frame.colorimetry =3D HDMI_COLORIMETRY_NONE;
 		frame.extended_colorimetry =3D
-				HDMI_EXTENDED_COLORIMETRY_XV_YCC_601;
-		break;
-	case V4L2_YCBCR_ENC_709:
-		if (hdmi->hdmi_data.enc_in_encoding =3D=3D V4L2_YCBCR_ENC_XV709)
-			frame.colorimetry =3D HDMI_COLORIMETRY_EXTENDED;
-		else
-			frame.colorimetry =3D HDMI_COLORIMETRY_ITU_709;
-		frame.extended_colorimetry =3D
-				HDMI_EXTENDED_COLORIMETRY_XV_YCC_709;
-		break;
-	default: /* Carries no data */
-		frame.colorimetry =3D HDMI_COLORIMETRY_ITU_601;
-		frame.extended_colorimetry =3D
-				HDMI_EXTENDED_COLORIMETRY_XV_YCC_601;
-		break;
+			HDMI_EXTENDED_COLORIMETRY_XV_YCC_601;
 	}
=20
 	frame.scan_mode =3D HDMI_SCAN_MODE_NONE;
--=20
2.25.1

