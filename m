Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE211C11D30
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 17:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 888E421556
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 17:39:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbgBXRjV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 12:39:21 -0500
Received: from mailoutvs35.siol.net ([185.57.226.226]:51253 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726208AbgBXRjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 12:39:19 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id B5E49523735;
        Mon, 24 Feb 2020 18:39:16 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta11.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta11.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id VgrH-4XPApOv; Mon, 24 Feb 2020 18:39:16 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 52FC25236BB;
        Mon, 24 Feb 2020 18:39:16 +0100 (CET)
Received: from localhost.localdomain (cpe-194-152-20-232.static.triera.net [194.152.20.232])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id 0463C5236EE;
        Mon, 24 Feb 2020 18:39:14 +0100 (CET)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     mripard@kernel.org, wens@csie.org
Cc:     jernej.skrabec@siol.net, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] drm/sun4i: Fix DE2 VI layer format support
Date:   Mon, 24 Feb 2020 18:38:57 +0100
Message-Id: <20200224173901.174016-4-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200224173901.174016-1-jernej.skrabec@siol.net>
References: <20200224173901.174016-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DE2 VI layer doesn't support blending which means alpha channel is
ignored. Replace all formats with alpha with "don't care" (X) channel.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/sun4i/sun8i_mixer.c    | 56 ++++++++++++++++++++++++++
 drivers/gpu/drm/sun4i/sun8i_vi_layer.c | 22 +++++-----
 2 files changed, 67 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c b/drivers/gpu/drm/sun4i/=
sun8i_mixer.c
index 655445bfe64a..4a64f7ae437a 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
@@ -106,48 +106,104 @@ static const struct de2_fmt_info de2_formats[] =3D=
 {
 		.rgb =3D true,
 		.csc =3D SUN8I_CSC_MODE_OFF,
 	},
+	{
+		/* for DE2 VI layer which ignores alpha */
+		.drm_fmt =3D DRM_FORMAT_XRGB4444,
+		.de2_fmt =3D SUN8I_MIXER_FBFMT_ARGB4444,
+		.rgb =3D true,
+		.csc =3D SUN8I_CSC_MODE_OFF,
+	},
 	{
 		.drm_fmt =3D DRM_FORMAT_ABGR4444,
 		.de2_fmt =3D SUN8I_MIXER_FBFMT_ABGR4444,
 		.rgb =3D true,
 		.csc =3D SUN8I_CSC_MODE_OFF,
 	},
+	{
+		/* for DE2 VI layer which ignores alpha */
+		.drm_fmt =3D DRM_FORMAT_XBGR4444,
+		.de2_fmt =3D SUN8I_MIXER_FBFMT_ABGR4444,
+		.rgb =3D true,
+		.csc =3D SUN8I_CSC_MODE_OFF,
+	},
 	{
 		.drm_fmt =3D DRM_FORMAT_RGBA4444,
 		.de2_fmt =3D SUN8I_MIXER_FBFMT_RGBA4444,
 		.rgb =3D true,
 		.csc =3D SUN8I_CSC_MODE_OFF,
 	},
+	{
+		/* for DE2 VI layer which ignores alpha */
+		.drm_fmt =3D DRM_FORMAT_RGBX4444,
+		.de2_fmt =3D SUN8I_MIXER_FBFMT_RGBA4444,
+		.rgb =3D true,
+		.csc =3D SUN8I_CSC_MODE_OFF,
+	},
 	{
 		.drm_fmt =3D DRM_FORMAT_BGRA4444,
 		.de2_fmt =3D SUN8I_MIXER_FBFMT_BGRA4444,
 		.rgb =3D true,
 		.csc =3D SUN8I_CSC_MODE_OFF,
 	},
+	{
+		/* for DE2 VI layer which ignores alpha */
+		.drm_fmt =3D DRM_FORMAT_BGRX4444,
+		.de2_fmt =3D SUN8I_MIXER_FBFMT_BGRA4444,
+		.rgb =3D true,
+		.csc =3D SUN8I_CSC_MODE_OFF,
+	},
 	{
 		.drm_fmt =3D DRM_FORMAT_ARGB1555,
 		.de2_fmt =3D SUN8I_MIXER_FBFMT_ARGB1555,
 		.rgb =3D true,
 		.csc =3D SUN8I_CSC_MODE_OFF,
 	},
+	{
+		/* for DE2 VI layer which ignores alpha */
+		.drm_fmt =3D DRM_FORMAT_XRGB1555,
+		.de2_fmt =3D SUN8I_MIXER_FBFMT_ARGB1555,
+		.rgb =3D true,
+		.csc =3D SUN8I_CSC_MODE_OFF,
+	},
 	{
 		.drm_fmt =3D DRM_FORMAT_ABGR1555,
 		.de2_fmt =3D SUN8I_MIXER_FBFMT_ABGR1555,
 		.rgb =3D true,
 		.csc =3D SUN8I_CSC_MODE_OFF,
 	},
+	{
+		/* for DE2 VI layer which ignores alpha */
+		.drm_fmt =3D DRM_FORMAT_XBGR1555,
+		.de2_fmt =3D SUN8I_MIXER_FBFMT_ABGR1555,
+		.rgb =3D true,
+		.csc =3D SUN8I_CSC_MODE_OFF,
+	},
 	{
 		.drm_fmt =3D DRM_FORMAT_RGBA5551,
 		.de2_fmt =3D SUN8I_MIXER_FBFMT_RGBA5551,
 		.rgb =3D true,
 		.csc =3D SUN8I_CSC_MODE_OFF,
 	},
+	{
+		/* for DE2 VI layer which ignores alpha */
+		.drm_fmt =3D DRM_FORMAT_RGBX5551,
+		.de2_fmt =3D SUN8I_MIXER_FBFMT_RGBA5551,
+		.rgb =3D true,
+		.csc =3D SUN8I_CSC_MODE_OFF,
+	},
 	{
 		.drm_fmt =3D DRM_FORMAT_BGRA5551,
 		.de2_fmt =3D SUN8I_MIXER_FBFMT_BGRA5551,
 		.rgb =3D true,
 		.csc =3D SUN8I_CSC_MODE_OFF,
 	},
+	{
+		/* for DE2 VI layer which ignores alpha */
+		.drm_fmt =3D DRM_FORMAT_BGRX5551,
+		.de2_fmt =3D SUN8I_MIXER_FBFMT_BGRA5551,
+		.rgb =3D true,
+		.csc =3D SUN8I_CSC_MODE_OFF,
+	},
 	{
 		.drm_fmt =3D DRM_FORMAT_ARGB2101010,
 		.de2_fmt =3D SUN8I_MIXER_FBFMT_ARGB2101010,
diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c b/drivers/gpu/drm/sun=
4i/sun8i_vi_layer.c
index 6c0084a3c3d7..b8398ca18b0f 100644
--- a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
@@ -398,26 +398,26 @@ static const struct drm_plane_funcs sun8i_vi_layer_=
funcs =3D {
 };
=20
 /*
- * While all RGB formats are supported, VI planes don't support
- * alpha blending, so there is no point having formats with alpha
- * channel if their opaque analog exist.
+ * While DE2 VI layer supports same RGB formats as UI layer, alpha
+ * channel is ignored. This structure lists all unique variants
+ * where alpha channel is replaced with "don't care" (X) channel.
  */
 static const u32 sun8i_vi_layer_formats[] =3D {
-	DRM_FORMAT_ABGR1555,
-	DRM_FORMAT_ABGR4444,
-	DRM_FORMAT_ARGB1555,
-	DRM_FORMAT_ARGB4444,
 	DRM_FORMAT_BGR565,
 	DRM_FORMAT_BGR888,
-	DRM_FORMAT_BGRA5551,
-	DRM_FORMAT_BGRA4444,
+	DRM_FORMAT_BGRX4444,
+	DRM_FORMAT_BGRX5551,
 	DRM_FORMAT_BGRX8888,
 	DRM_FORMAT_RGB565,
 	DRM_FORMAT_RGB888,
-	DRM_FORMAT_RGBA4444,
-	DRM_FORMAT_RGBA5551,
+	DRM_FORMAT_RGBX4444,
+	DRM_FORMAT_RGBX5551,
 	DRM_FORMAT_RGBX8888,
+	DRM_FORMAT_XBGR1555,
+	DRM_FORMAT_XBGR4444,
 	DRM_FORMAT_XBGR8888,
+	DRM_FORMAT_XRGB1555,
+	DRM_FORMAT_XRGB4444,
 	DRM_FORMAT_XRGB8888,
=20
 	DRM_FORMAT_NV16,
--=20
2.25.1

