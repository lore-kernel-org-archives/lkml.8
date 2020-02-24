Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ABDCC11D2F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 17:39:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68BD120838
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 17:39:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbgBXRjT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 12:39:19 -0500
Received: from mailoutvs56.siol.net ([185.57.226.247]:51202 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727730AbgBXRjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 12:39:18 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 6BA325236FE;
        Mon, 24 Feb 2020 18:39:14 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta11.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta11.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id bqT9S_aBDHSX; Mon, 24 Feb 2020 18:39:14 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id ED0725236BB;
        Mon, 24 Feb 2020 18:39:13 +0100 (CET)
Received: from localhost.localdomain (cpe-194-152-20-232.static.triera.net [194.152.20.232])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id AD65E5236FE;
        Mon, 24 Feb 2020 18:39:11 +0100 (CET)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     mripard@kernel.org, wens@csie.org
Cc:     jernej.skrabec@siol.net, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] drm/sun4i: Add separate DE3 VI layer formats
Date:   Mon, 24 Feb 2020 18:38:56 +0100
Message-Id: <20200224173901.174016-3-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200224173901.174016-1-jernej.skrabec@siol.net>
References: <20200224173901.174016-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DE3 VI layers support alpha blending, but DE2 VI layers do not.
Additionally, DE3 VI layers support 10-bit RGB and YUV formats.

Make a separate list for DE3.

Fixes: c50519e6db4d ("drm/sun4i: Add basic support for DE3")
Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/sun4i/sun8i_mixer.c    | 36 ++++++++++++++++
 drivers/gpu/drm/sun4i/sun8i_mixer.h    | 11 +++++
 drivers/gpu/drm/sun4i/sun8i_vi_layer.c | 58 ++++++++++++++++++++++++--
 3 files changed, 102 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c b/drivers/gpu/drm/sun4i/=
sun8i_mixer.c
index 3a78dbbceb8a..655445bfe64a 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
@@ -148,6 +148,30 @@ static const struct de2_fmt_info de2_formats[] =3D {
 		.rgb =3D true,
 		.csc =3D SUN8I_CSC_MODE_OFF,
 	},
+	{
+		.drm_fmt =3D DRM_FORMAT_ARGB2101010,
+		.de2_fmt =3D SUN8I_MIXER_FBFMT_ARGB2101010,
+		.rgb =3D true,
+		.csc =3D SUN8I_CSC_MODE_OFF,
+	},
+	{
+		.drm_fmt =3D DRM_FORMAT_ABGR2101010,
+		.de2_fmt =3D SUN8I_MIXER_FBFMT_ABGR2101010,
+		.rgb =3D true,
+		.csc =3D SUN8I_CSC_MODE_OFF,
+	},
+	{
+		.drm_fmt =3D DRM_FORMAT_RGBA1010102,
+		.de2_fmt =3D SUN8I_MIXER_FBFMT_RGBA1010102,
+		.rgb =3D true,
+		.csc =3D SUN8I_CSC_MODE_OFF,
+	},
+	{
+		.drm_fmt =3D DRM_FORMAT_BGRA1010102,
+		.de2_fmt =3D SUN8I_MIXER_FBFMT_BGRA1010102,
+		.rgb =3D true,
+		.csc =3D SUN8I_CSC_MODE_OFF,
+	},
 	{
 		.drm_fmt =3D DRM_FORMAT_UYVY,
 		.de2_fmt =3D SUN8I_MIXER_FBFMT_UYVY,
@@ -232,6 +256,18 @@ static const struct de2_fmt_info de2_formats[] =3D {
 		.rgb =3D false,
 		.csc =3D SUN8I_CSC_MODE_YVU2RGB,
 	},
+	{
+		.drm_fmt =3D DRM_FORMAT_P010,
+		.de2_fmt =3D SUN8I_MIXER_FBFMT_P010_YUV,
+		.rgb =3D false,
+		.csc =3D SUN8I_CSC_MODE_YUV2RGB,
+	},
+	{
+		.drm_fmt =3D DRM_FORMAT_P210,
+		.de2_fmt =3D SUN8I_MIXER_FBFMT_P210_YUV,
+		.rgb =3D false,
+		.csc =3D SUN8I_CSC_MODE_YUV2RGB,
+	},
 };
=20
 const struct de2_fmt_info *sun8i_mixer_format_info(u32 format)
diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.h b/drivers/gpu/drm/sun4i/=
sun8i_mixer.h
index c6cc94057faf..345b28b0a80a 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.h
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.h
@@ -93,6 +93,10 @@
 #define SUN8I_MIXER_FBFMT_ABGR1555	17
 #define SUN8I_MIXER_FBFMT_RGBA5551	18
 #define SUN8I_MIXER_FBFMT_BGRA5551	19
+#define SUN8I_MIXER_FBFMT_ARGB2101010	20
+#define SUN8I_MIXER_FBFMT_ABGR2101010	21
+#define SUN8I_MIXER_FBFMT_RGBA1010102	22
+#define SUN8I_MIXER_FBFMT_BGRA1010102	23
=20
 #define SUN8I_MIXER_FBFMT_YUYV		0
 #define SUN8I_MIXER_FBFMT_UYVY		1
@@ -109,6 +113,13 @@
 /* format 12 is semi-planar YUV411 UVUV */
 /* format 13 is semi-planar YUV411 VUVU */
 #define SUN8I_MIXER_FBFMT_YUV411	14
+/* format 15 doesn't exist */
+/* format 16 is P010 YVU */
+#define SUN8I_MIXER_FBFMT_P010_YUV	17
+/* format 18 is P210 YVU */
+#define SUN8I_MIXER_FBFMT_P210_YUV	19
+/* format 20 is packed YVU444 10-bit */
+/* format 21 is packed YUV444 10-bit */
=20
 /*
  * Sub-engines listed bellow are unused for now. The EN registers are he=
re only
diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c b/drivers/gpu/drm/sun=
4i/sun8i_vi_layer.c
index 6a244d6fafd9..6c0084a3c3d7 100644
--- a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
@@ -436,24 +436,76 @@ static const u32 sun8i_vi_layer_formats[] =3D {
 	DRM_FORMAT_YVU422,
 };
=20
+static const u32 sun8i_vi_layer_de3_formats[] =3D {
+	DRM_FORMAT_ABGR1555,
+	DRM_FORMAT_ABGR2101010,
+	DRM_FORMAT_ABGR4444,
+	DRM_FORMAT_ABGR8888,
+	DRM_FORMAT_ARGB1555,
+	DRM_FORMAT_ARGB2101010,
+	DRM_FORMAT_ARGB4444,
+	DRM_FORMAT_ARGB8888,
+	DRM_FORMAT_BGR565,
+	DRM_FORMAT_BGR888,
+	DRM_FORMAT_BGRA1010102,
+	DRM_FORMAT_BGRA5551,
+	DRM_FORMAT_BGRA4444,
+	DRM_FORMAT_BGRA8888,
+	DRM_FORMAT_BGRX8888,
+	DRM_FORMAT_RGB565,
+	DRM_FORMAT_RGB888,
+	DRM_FORMAT_RGBA1010102,
+	DRM_FORMAT_RGBA4444,
+	DRM_FORMAT_RGBA5551,
+	DRM_FORMAT_RGBA8888,
+	DRM_FORMAT_RGBX8888,
+	DRM_FORMAT_XBGR8888,
+	DRM_FORMAT_XRGB8888,
+
+	DRM_FORMAT_NV16,
+	DRM_FORMAT_NV12,
+	DRM_FORMAT_NV21,
+	DRM_FORMAT_NV61,
+	DRM_FORMAT_P010,
+	DRM_FORMAT_P210,
+	DRM_FORMAT_UYVY,
+	DRM_FORMAT_VYUY,
+	DRM_FORMAT_YUYV,
+	DRM_FORMAT_YVYU,
+	DRM_FORMAT_YUV411,
+	DRM_FORMAT_YUV420,
+	DRM_FORMAT_YUV422,
+	DRM_FORMAT_YVU411,
+	DRM_FORMAT_YVU420,
+	DRM_FORMAT_YVU422,
+};
+
 struct sun8i_vi_layer *sun8i_vi_layer_init_one(struct drm_device *drm,
 					       struct sun8i_mixer *mixer,
 					       int index)
 {
 	u32 supported_encodings, supported_ranges;
+	unsigned int plane_cnt, format_count;
 	struct sun8i_vi_layer *layer;
-	unsigned int plane_cnt;
+	const u32 *formats;
 	int ret;
=20
 	layer =3D devm_kzalloc(drm->dev, sizeof(*layer), GFP_KERNEL);
 	if (!layer)
 		return ERR_PTR(-ENOMEM);
=20
+	if (mixer->cfg->is_de3) {
+		formats =3D sun8i_vi_layer_de3_formats;
+		format_count =3D ARRAY_SIZE(sun8i_vi_layer_de3_formats);
+	} else {
+		formats =3D sun8i_vi_layer_formats;
+		format_count =3D ARRAY_SIZE(sun8i_vi_layer_formats);
+	}
+
 	/* possible crtcs are set later */
 	ret =3D drm_universal_plane_init(drm, &layer->plane, 0,
 				       &sun8i_vi_layer_funcs,
-				       sun8i_vi_layer_formats,
-				       ARRAY_SIZE(sun8i_vi_layer_formats),
+				       formats, format_count,
 				       NULL, DRM_PLANE_TYPE_OVERLAY, NULL);
 	if (ret) {
 		dev_err(drm->dev, "Couldn't initialize layer\n");
--=20
2.25.1

