Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26680C11D2F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 17:39:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEB3820838
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 17:39:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728101AbgBXRj2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 12:39:28 -0500
Received: from mailoutvs13.siol.net ([185.57.226.204]:51305 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726208AbgBXRj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 12:39:26 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id A6940523703;
        Mon, 24 Feb 2020 18:39:21 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta11.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta11.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id NodN5chrT5Df; Mon, 24 Feb 2020 18:39:21 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 0C400523723;
        Mon, 24 Feb 2020 18:39:21 +0100 (CET)
Received: from localhost.localdomain (cpe-194-152-20-232.static.triera.net [194.152.20.232])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id B00F1523703;
        Mon, 24 Feb 2020 18:39:18 +0100 (CET)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     mripard@kernel.org, wens@csie.org
Cc:     jernej.skrabec@siol.net, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] drm/sun4i: de2: csc_mode in de2 format struct is mostly redundant
Date:   Mon, 24 Feb 2020 18:38:59 +0100
Message-Id: <20200224173901.174016-6-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200224173901.174016-1-jernej.skrabec@siol.net>
References: <20200224173901.174016-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For RGB formats CSC mode is always set to none and for YUV formats
almost always set to YUV to RGB.

Add a helper function to deduce CSC mode from format.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/sun4i/sun8i_mixer.c    | 48 --------------------------
 drivers/gpu/drm/sun4i/sun8i_mixer.h    |  6 ++--
 drivers/gpu/drm/sun4i/sun8i_vi_layer.c | 24 +++++++++++--
 3 files changed, 23 insertions(+), 55 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c b/drivers/gpu/drm/sun4i/=
sun8i_mixer.c
index 45e3cd9e718c..e078ec96de2d 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
@@ -31,250 +31,202 @@ static const struct de2_fmt_info de2_formats[] =3D =
{
 	{
 		.drm_fmt =3D DRM_FORMAT_ARGB8888,
 		.de2_fmt =3D SUN8I_MIXER_FBFMT_ARGB8888,
-		.csc =3D SUN8I_CSC_MODE_OFF,
 	},
 	{
 		.drm_fmt =3D DRM_FORMAT_ABGR8888,
 		.de2_fmt =3D SUN8I_MIXER_FBFMT_ABGR8888,
-		.csc =3D SUN8I_CSC_MODE_OFF,
 	},
 	{
 		.drm_fmt =3D DRM_FORMAT_RGBA8888,
 		.de2_fmt =3D SUN8I_MIXER_FBFMT_RGBA8888,
-		.csc =3D SUN8I_CSC_MODE_OFF,
 	},
 	{
 		.drm_fmt =3D DRM_FORMAT_BGRA8888,
 		.de2_fmt =3D SUN8I_MIXER_FBFMT_BGRA8888,
-		.csc =3D SUN8I_CSC_MODE_OFF,
 	},
 	{
 		.drm_fmt =3D DRM_FORMAT_XRGB8888,
 		.de2_fmt =3D SUN8I_MIXER_FBFMT_XRGB8888,
-		.csc =3D SUN8I_CSC_MODE_OFF,
 	},
 	{
 		.drm_fmt =3D DRM_FORMAT_XBGR8888,
 		.de2_fmt =3D SUN8I_MIXER_FBFMT_XBGR8888,
-		.csc =3D SUN8I_CSC_MODE_OFF,
 	},
 	{
 		.drm_fmt =3D DRM_FORMAT_RGBX8888,
 		.de2_fmt =3D SUN8I_MIXER_FBFMT_RGBX8888,
-		.csc =3D SUN8I_CSC_MODE_OFF,
 	},
 	{
 		.drm_fmt =3D DRM_FORMAT_BGRX8888,
 		.de2_fmt =3D SUN8I_MIXER_FBFMT_BGRX8888,
-		.csc =3D SUN8I_CSC_MODE_OFF,
 	},
 	{
 		.drm_fmt =3D DRM_FORMAT_RGB888,
 		.de2_fmt =3D SUN8I_MIXER_FBFMT_RGB888,
-		.csc =3D SUN8I_CSC_MODE_OFF,
 	},
 	{
 		.drm_fmt =3D DRM_FORMAT_BGR888,
 		.de2_fmt =3D SUN8I_MIXER_FBFMT_BGR888,
-		.csc =3D SUN8I_CSC_MODE_OFF,
 	},
 	{
 		.drm_fmt =3D DRM_FORMAT_RGB565,
 		.de2_fmt =3D SUN8I_MIXER_FBFMT_RGB565,
-		.csc =3D SUN8I_CSC_MODE_OFF,
 	},
 	{
 		.drm_fmt =3D DRM_FORMAT_BGR565,
 		.de2_fmt =3D SUN8I_MIXER_FBFMT_BGR565,
-		.csc =3D SUN8I_CSC_MODE_OFF,
 	},
 	{
 		.drm_fmt =3D DRM_FORMAT_ARGB4444,
 		.de2_fmt =3D SUN8I_MIXER_FBFMT_ARGB4444,
-		.csc =3D SUN8I_CSC_MODE_OFF,
 	},
 	{
 		/* for DE2 VI layer which ignores alpha */
 		.drm_fmt =3D DRM_FORMAT_XRGB4444,
 		.de2_fmt =3D SUN8I_MIXER_FBFMT_ARGB4444,
-		.csc =3D SUN8I_CSC_MODE_OFF,
 	},
 	{
 		.drm_fmt =3D DRM_FORMAT_ABGR4444,
 		.de2_fmt =3D SUN8I_MIXER_FBFMT_ABGR4444,
-		.csc =3D SUN8I_CSC_MODE_OFF,
 	},
 	{
 		/* for DE2 VI layer which ignores alpha */
 		.drm_fmt =3D DRM_FORMAT_XBGR4444,
 		.de2_fmt =3D SUN8I_MIXER_FBFMT_ABGR4444,
-		.csc =3D SUN8I_CSC_MODE_OFF,
 	},
 	{
 		.drm_fmt =3D DRM_FORMAT_RGBA4444,
 		.de2_fmt =3D SUN8I_MIXER_FBFMT_RGBA4444,
-		.csc =3D SUN8I_CSC_MODE_OFF,
 	},
 	{
 		/* for DE2 VI layer which ignores alpha */
 		.drm_fmt =3D DRM_FORMAT_RGBX4444,
 		.de2_fmt =3D SUN8I_MIXER_FBFMT_RGBA4444,
-		.csc =3D SUN8I_CSC_MODE_OFF,
 	},
 	{
 		.drm_fmt =3D DRM_FORMAT_BGRA4444,
 		.de2_fmt =3D SUN8I_MIXER_FBFMT_BGRA4444,
-		.csc =3D SUN8I_CSC_MODE_OFF,
 	},
 	{
 		/* for DE2 VI layer which ignores alpha */
 		.drm_fmt =3D DRM_FORMAT_BGRX4444,
 		.de2_fmt =3D SUN8I_MIXER_FBFMT_BGRA4444,
-		.csc =3D SUN8I_CSC_MODE_OFF,
 	},
 	{
 		.drm_fmt =3D DRM_FORMAT_ARGB1555,
 		.de2_fmt =3D SUN8I_MIXER_FBFMT_ARGB1555,
-		.csc =3D SUN8I_CSC_MODE_OFF,
 	},
 	{
 		/* for DE2 VI layer which ignores alpha */
 		.drm_fmt =3D DRM_FORMAT_XRGB1555,
 		.de2_fmt =3D SUN8I_MIXER_FBFMT_ARGB1555,
-		.csc =3D SUN8I_CSC_MODE_OFF,
 	},
 	{
 		.drm_fmt =3D DRM_FORMAT_ABGR1555,
 		.de2_fmt =3D SUN8I_MIXER_FBFMT_ABGR1555,
-		.csc =3D SUN8I_CSC_MODE_OFF,
 	},
 	{
 		/* for DE2 VI layer which ignores alpha */
 		.drm_fmt =3D DRM_FORMAT_XBGR1555,
 		.de2_fmt =3D SUN8I_MIXER_FBFMT_ABGR1555,
-		.csc =3D SUN8I_CSC_MODE_OFF,
 	},
 	{
 		.drm_fmt =3D DRM_FORMAT_RGBA5551,
 		.de2_fmt =3D SUN8I_MIXER_FBFMT_RGBA5551,
-		.csc =3D SUN8I_CSC_MODE_OFF,
 	},
 	{
 		/* for DE2 VI layer which ignores alpha */
 		.drm_fmt =3D DRM_FORMAT_RGBX5551,
 		.de2_fmt =3D SUN8I_MIXER_FBFMT_RGBA5551,
-		.csc =3D SUN8I_CSC_MODE_OFF,
 	},
 	{
 		.drm_fmt =3D DRM_FORMAT_BGRA5551,
 		.de2_fmt =3D SUN8I_MIXER_FBFMT_BGRA5551,
-		.csc =3D SUN8I_CSC_MODE_OFF,
 	},
 	{
 		/* for DE2 VI layer which ignores alpha */
 		.drm_fmt =3D DRM_FORMAT_BGRX5551,
 		.de2_fmt =3D SUN8I_MIXER_FBFMT_BGRA5551,
-		.csc =3D SUN8I_CSC_MODE_OFF,
 	},
 	{
 		.drm_fmt =3D DRM_FORMAT_ARGB2101010,
 		.de2_fmt =3D SUN8I_MIXER_FBFMT_ARGB2101010,
-		.csc =3D SUN8I_CSC_MODE_OFF,
 	},
 	{
 		.drm_fmt =3D DRM_FORMAT_ABGR2101010,
 		.de2_fmt =3D SUN8I_MIXER_FBFMT_ABGR2101010,
-		.csc =3D SUN8I_CSC_MODE_OFF,
 	},
 	{
 		.drm_fmt =3D DRM_FORMAT_RGBA1010102,
 		.de2_fmt =3D SUN8I_MIXER_FBFMT_RGBA1010102,
-		.csc =3D SUN8I_CSC_MODE_OFF,
 	},
 	{
 		.drm_fmt =3D DRM_FORMAT_BGRA1010102,
 		.de2_fmt =3D SUN8I_MIXER_FBFMT_BGRA1010102,
-		.csc =3D SUN8I_CSC_MODE_OFF,
 	},
 	{
 		.drm_fmt =3D DRM_FORMAT_UYVY,
 		.de2_fmt =3D SUN8I_MIXER_FBFMT_UYVY,
-		.csc =3D SUN8I_CSC_MODE_YUV2RGB,
 	},
 	{
 		.drm_fmt =3D DRM_FORMAT_VYUY,
 		.de2_fmt =3D SUN8I_MIXER_FBFMT_VYUY,
-		.csc =3D SUN8I_CSC_MODE_YUV2RGB,
 	},
 	{
 		.drm_fmt =3D DRM_FORMAT_YUYV,
 		.de2_fmt =3D SUN8I_MIXER_FBFMT_YUYV,
-		.csc =3D SUN8I_CSC_MODE_YUV2RGB,
 	},
 	{
 		.drm_fmt =3D DRM_FORMAT_YVYU,
 		.de2_fmt =3D SUN8I_MIXER_FBFMT_YVYU,
-		.csc =3D SUN8I_CSC_MODE_YUV2RGB,
 	},
 	{
 		.drm_fmt =3D DRM_FORMAT_NV16,
 		.de2_fmt =3D SUN8I_MIXER_FBFMT_NV16,
-		.csc =3D SUN8I_CSC_MODE_YUV2RGB,
 	},
 	{
 		.drm_fmt =3D DRM_FORMAT_NV61,
 		.de2_fmt =3D SUN8I_MIXER_FBFMT_NV61,
-		.csc =3D SUN8I_CSC_MODE_YUV2RGB,
 	},
 	{
 		.drm_fmt =3D DRM_FORMAT_NV12,
 		.de2_fmt =3D SUN8I_MIXER_FBFMT_NV12,
-		.csc =3D SUN8I_CSC_MODE_YUV2RGB,
 	},
 	{
 		.drm_fmt =3D DRM_FORMAT_NV21,
 		.de2_fmt =3D SUN8I_MIXER_FBFMT_NV21,
-		.csc =3D SUN8I_CSC_MODE_YUV2RGB,
 	},
 	{
 		.drm_fmt =3D DRM_FORMAT_YUV422,
 		.de2_fmt =3D SUN8I_MIXER_FBFMT_YUV422,
-		.csc =3D SUN8I_CSC_MODE_YUV2RGB,
 	},
 	{
 		.drm_fmt =3D DRM_FORMAT_YUV420,
 		.de2_fmt =3D SUN8I_MIXER_FBFMT_YUV420,
-		.csc =3D SUN8I_CSC_MODE_YUV2RGB,
 	},
 	{
 		.drm_fmt =3D DRM_FORMAT_YUV411,
 		.de2_fmt =3D SUN8I_MIXER_FBFMT_YUV411,
-		.csc =3D SUN8I_CSC_MODE_YUV2RGB,
 	},
 	{
 		.drm_fmt =3D DRM_FORMAT_YVU422,
 		.de2_fmt =3D SUN8I_MIXER_FBFMT_YUV422,
-		.csc =3D SUN8I_CSC_MODE_YVU2RGB,
 	},
 	{
 		.drm_fmt =3D DRM_FORMAT_YVU420,
 		.de2_fmt =3D SUN8I_MIXER_FBFMT_YUV420,
-		.csc =3D SUN8I_CSC_MODE_YVU2RGB,
 	},
 	{
 		.drm_fmt =3D DRM_FORMAT_YVU411,
 		.de2_fmt =3D SUN8I_MIXER_FBFMT_YUV411,
-		.csc =3D SUN8I_CSC_MODE_YVU2RGB,
 	},
 	{
 		.drm_fmt =3D DRM_FORMAT_P010,
 		.de2_fmt =3D SUN8I_MIXER_FBFMT_P010_YUV,
-		.csc =3D SUN8I_CSC_MODE_YUV2RGB,
 	},
 	{
 		.drm_fmt =3D DRM_FORMAT_P210,
 		.de2_fmt =3D SUN8I_MIXER_FBFMT_P210_YUV,
-		.csc =3D SUN8I_CSC_MODE_YUV2RGB,
 	},
 };
=20
diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.h b/drivers/gpu/drm/sun4i/=
sun8i_mixer.h
index 447ad0b01b00..0dd4a347fa06 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.h
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.h
@@ -10,7 +10,6 @@
 #include <linux/regmap.h>
 #include <linux/reset.h>
=20
-#include "sun8i_csc.h"
 #include "sunxi_engine.h"
=20
 #define SUN8I_MIXER_SIZE(w, h)			(((h) - 1) << 16 | ((w) - 1))
@@ -145,9 +144,8 @@
 #define SUN50I_MIXER_CDC1_EN			0xd8000
=20
 struct de2_fmt_info {
-	u32			drm_fmt;
-	u32			de2_fmt;
-	enum sun8i_csc_mode	csc;
+	u32	drm_fmt;
+	u32	de2_fmt;
 };
=20
 /**
diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c b/drivers/gpu/drm/sun=
4i/sun8i_vi_layer.c
index a2eb4371026d..d783c2bfc77e 100644
--- a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
@@ -12,6 +12,7 @@
 #include <drm/drm_plane_helper.h>
 #include <drm/drm_probe_helper.h>
=20
+#include "sun8i_csc.h"
 #include "sun8i_vi_layer.h"
 #include "sun8i_mixer.h"
 #include "sun8i_vi_scaler.h"
@@ -210,13 +211,29 @@ static int sun8i_vi_layer_update_coord(struct sun8i=
_mixer *mixer, int channel,
 	return 0;
 }
=20
+static bool sun8i_vi_layer_get_csc_mode(const struct drm_format_info *fo=
rmat)
+{
+	if (!format->is_yuv)
+		return SUN8I_CSC_MODE_OFF;
+
+	switch (format->format) {
+	case DRM_FORMAT_YVU411:
+	case DRM_FORMAT_YVU420:
+	case DRM_FORMAT_YVU422:
+	case DRM_FORMAT_YVU444:
+		return SUN8I_CSC_MODE_YVU2RGB;
+	default:
+		return SUN8I_CSC_MODE_YUV2RGB;
+	}
+}
+
 static int sun8i_vi_layer_update_formats(struct sun8i_mixer *mixer, int =
channel,
 					 int overlay, struct drm_plane *plane)
 {
 	struct drm_plane_state *state =3D plane->state;
 	const struct de2_fmt_info *fmt_info;
 	const struct drm_format_info *fmt;
-	u32 val, ch_base;
+	u32 val, ch_base, csc_mode;
=20
 	ch_base =3D sun8i_channel_base(mixer, channel);
=20
@@ -232,8 +249,9 @@ static int sun8i_vi_layer_update_formats(struct sun8i=
_mixer *mixer, int channel,
 			   SUN8I_MIXER_CHAN_VI_LAYER_ATTR(ch_base, overlay),
 			   SUN8I_MIXER_CHAN_VI_LAYER_ATTR_FBFMT_MASK, val);
=20
-	if (fmt_info->csc !=3D SUN8I_CSC_MODE_OFF) {
-		sun8i_csc_set_ccsc_coefficients(mixer, channel, fmt_info->csc,
+	csc_mode =3D sun8i_vi_layer_get_csc_mode(fmt);
+	if (csc_mode !=3D SUN8I_CSC_MODE_OFF) {
+		sun8i_csc_set_ccsc_coefficients(mixer, channel, csc_mode,
 						state->color_encoding,
 						state->color_range);
 		sun8i_csc_enable_ccsc(mixer, channel, true);
--=20
2.25.1

