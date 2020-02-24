Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B269C11D30
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 17:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17E542084E
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 17:39:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728078AbgBXRjZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 12:39:25 -0500
Received: from mailoutvs31.siol.net ([185.57.226.222]:51270 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727992AbgBXRjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 12:39:23 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 49E9C523704;
        Mon, 24 Feb 2020 18:39:19 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta11.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta11.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id dGtPwmvNvSTs; Mon, 24 Feb 2020 18:39:18 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id A9B095236EE;
        Mon, 24 Feb 2020 18:39:18 +0100 (CET)
Received: from localhost.localdomain (cpe-194-152-20-232.static.triera.net [194.152.20.232])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id 5A5E5523705;
        Mon, 24 Feb 2020 18:39:16 +0100 (CET)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     mripard@kernel.org, wens@csie.org
Cc:     jernej.skrabec@siol.net, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] drm/sun4i: de2: rgb field in de2 format struct is redundant
Date:   Mon, 24 Feb 2020 18:38:58 +0100
Message-Id: <20200224173901.174016-5-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200224173901.174016-1-jernej.skrabec@siol.net>
References: <20200224173901.174016-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drm_format_info structure already contains information if format is RGB
or YUV. Use that instead.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/sun4i/sun8i_mixer.c    | 48 --------------------------
 drivers/gpu/drm/sun4i/sun8i_mixer.h    |  1 -
 drivers/gpu/drm/sun4i/sun8i_ui_layer.c |  6 ++--
 drivers/gpu/drm/sun4i/sun8i_vi_layer.c |  6 ++--
 4 files changed, 8 insertions(+), 53 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c b/drivers/gpu/drm/sun4i/=
sun8i_mixer.c
index 4a64f7ae437a..45e3cd9e718c 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
@@ -31,297 +31,249 @@ static const struct de2_fmt_info de2_formats[] =3D =
{
 	{
 		.drm_fmt =3D DRM_FORMAT_ARGB8888,
 		.de2_fmt =3D SUN8I_MIXER_FBFMT_ARGB8888,
-		.rgb =3D true,
 		.csc =3D SUN8I_CSC_MODE_OFF,
 	},
 	{
 		.drm_fmt =3D DRM_FORMAT_ABGR8888,
 		.de2_fmt =3D SUN8I_MIXER_FBFMT_ABGR8888,
-		.rgb =3D true,
 		.csc =3D SUN8I_CSC_MODE_OFF,
 	},
 	{
 		.drm_fmt =3D DRM_FORMAT_RGBA8888,
 		.de2_fmt =3D SUN8I_MIXER_FBFMT_RGBA8888,
-		.rgb =3D true,
 		.csc =3D SUN8I_CSC_MODE_OFF,
 	},
 	{
 		.drm_fmt =3D DRM_FORMAT_BGRA8888,
 		.de2_fmt =3D SUN8I_MIXER_FBFMT_BGRA8888,
-		.rgb =3D true,
 		.csc =3D SUN8I_CSC_MODE_OFF,
 	},
 	{
 		.drm_fmt =3D DRM_FORMAT_XRGB8888,
 		.de2_fmt =3D SUN8I_MIXER_FBFMT_XRGB8888,
-		.rgb =3D true,
 		.csc =3D SUN8I_CSC_MODE_OFF,
 	},
 	{
 		.drm_fmt =3D DRM_FORMAT_XBGR8888,
 		.de2_fmt =3D SUN8I_MIXER_FBFMT_XBGR8888,
-		.rgb =3D true,
 		.csc =3D SUN8I_CSC_MODE_OFF,
 	},
 	{
 		.drm_fmt =3D DRM_FORMAT_RGBX8888,
 		.de2_fmt =3D SUN8I_MIXER_FBFMT_RGBX8888,
-		.rgb =3D true,
 		.csc =3D SUN8I_CSC_MODE_OFF,
 	},
 	{
 		.drm_fmt =3D DRM_FORMAT_BGRX8888,
 		.de2_fmt =3D SUN8I_MIXER_FBFMT_BGRX8888,
-		.rgb =3D true,
 		.csc =3D SUN8I_CSC_MODE_OFF,
 	},
 	{
 		.drm_fmt =3D DRM_FORMAT_RGB888,
 		.de2_fmt =3D SUN8I_MIXER_FBFMT_RGB888,
-		.rgb =3D true,
 		.csc =3D SUN8I_CSC_MODE_OFF,
 	},
 	{
 		.drm_fmt =3D DRM_FORMAT_BGR888,
 		.de2_fmt =3D SUN8I_MIXER_FBFMT_BGR888,
-		.rgb =3D true,
 		.csc =3D SUN8I_CSC_MODE_OFF,
 	},
 	{
 		.drm_fmt =3D DRM_FORMAT_RGB565,
 		.de2_fmt =3D SUN8I_MIXER_FBFMT_RGB565,
-		.rgb =3D true,
 		.csc =3D SUN8I_CSC_MODE_OFF,
 	},
 	{
 		.drm_fmt =3D DRM_FORMAT_BGR565,
 		.de2_fmt =3D SUN8I_MIXER_FBFMT_BGR565,
-		.rgb =3D true,
 		.csc =3D SUN8I_CSC_MODE_OFF,
 	},
 	{
 		.drm_fmt =3D DRM_FORMAT_ARGB4444,
 		.de2_fmt =3D SUN8I_MIXER_FBFMT_ARGB4444,
-		.rgb =3D true,
 		.csc =3D SUN8I_CSC_MODE_OFF,
 	},
 	{
 		/* for DE2 VI layer which ignores alpha */
 		.drm_fmt =3D DRM_FORMAT_XRGB4444,
 		.de2_fmt =3D SUN8I_MIXER_FBFMT_ARGB4444,
-		.rgb =3D true,
 		.csc =3D SUN8I_CSC_MODE_OFF,
 	},
 	{
 		.drm_fmt =3D DRM_FORMAT_ABGR4444,
 		.de2_fmt =3D SUN8I_MIXER_FBFMT_ABGR4444,
-		.rgb =3D true,
 		.csc =3D SUN8I_CSC_MODE_OFF,
 	},
 	{
 		/* for DE2 VI layer which ignores alpha */
 		.drm_fmt =3D DRM_FORMAT_XBGR4444,
 		.de2_fmt =3D SUN8I_MIXER_FBFMT_ABGR4444,
-		.rgb =3D true,
 		.csc =3D SUN8I_CSC_MODE_OFF,
 	},
 	{
 		.drm_fmt =3D DRM_FORMAT_RGBA4444,
 		.de2_fmt =3D SUN8I_MIXER_FBFMT_RGBA4444,
-		.rgb =3D true,
 		.csc =3D SUN8I_CSC_MODE_OFF,
 	},
 	{
 		/* for DE2 VI layer which ignores alpha */
 		.drm_fmt =3D DRM_FORMAT_RGBX4444,
 		.de2_fmt =3D SUN8I_MIXER_FBFMT_RGBA4444,
-		.rgb =3D true,
 		.csc =3D SUN8I_CSC_MODE_OFF,
 	},
 	{
 		.drm_fmt =3D DRM_FORMAT_BGRA4444,
 		.de2_fmt =3D SUN8I_MIXER_FBFMT_BGRA4444,
-		.rgb =3D true,
 		.csc =3D SUN8I_CSC_MODE_OFF,
 	},
 	{
 		/* for DE2 VI layer which ignores alpha */
 		.drm_fmt =3D DRM_FORMAT_BGRX4444,
 		.de2_fmt =3D SUN8I_MIXER_FBFMT_BGRA4444,
-		.rgb =3D true,
 		.csc =3D SUN8I_CSC_MODE_OFF,
 	},
 	{
 		.drm_fmt =3D DRM_FORMAT_ARGB1555,
 		.de2_fmt =3D SUN8I_MIXER_FBFMT_ARGB1555,
-		.rgb =3D true,
 		.csc =3D SUN8I_CSC_MODE_OFF,
 	},
 	{
 		/* for DE2 VI layer which ignores alpha */
 		.drm_fmt =3D DRM_FORMAT_XRGB1555,
 		.de2_fmt =3D SUN8I_MIXER_FBFMT_ARGB1555,
-		.rgb =3D true,
 		.csc =3D SUN8I_CSC_MODE_OFF,
 	},
 	{
 		.drm_fmt =3D DRM_FORMAT_ABGR1555,
 		.de2_fmt =3D SUN8I_MIXER_FBFMT_ABGR1555,
-		.rgb =3D true,
 		.csc =3D SUN8I_CSC_MODE_OFF,
 	},
 	{
 		/* for DE2 VI layer which ignores alpha */
 		.drm_fmt =3D DRM_FORMAT_XBGR1555,
 		.de2_fmt =3D SUN8I_MIXER_FBFMT_ABGR1555,
-		.rgb =3D true,
 		.csc =3D SUN8I_CSC_MODE_OFF,
 	},
 	{
 		.drm_fmt =3D DRM_FORMAT_RGBA5551,
 		.de2_fmt =3D SUN8I_MIXER_FBFMT_RGBA5551,
-		.rgb =3D true,
 		.csc =3D SUN8I_CSC_MODE_OFF,
 	},
 	{
 		/* for DE2 VI layer which ignores alpha */
 		.drm_fmt =3D DRM_FORMAT_RGBX5551,
 		.de2_fmt =3D SUN8I_MIXER_FBFMT_RGBA5551,
-		.rgb =3D true,
 		.csc =3D SUN8I_CSC_MODE_OFF,
 	},
 	{
 		.drm_fmt =3D DRM_FORMAT_BGRA5551,
 		.de2_fmt =3D SUN8I_MIXER_FBFMT_BGRA5551,
-		.rgb =3D true,
 		.csc =3D SUN8I_CSC_MODE_OFF,
 	},
 	{
 		/* for DE2 VI layer which ignores alpha */
 		.drm_fmt =3D DRM_FORMAT_BGRX5551,
 		.de2_fmt =3D SUN8I_MIXER_FBFMT_BGRA5551,
-		.rgb =3D true,
 		.csc =3D SUN8I_CSC_MODE_OFF,
 	},
 	{
 		.drm_fmt =3D DRM_FORMAT_ARGB2101010,
 		.de2_fmt =3D SUN8I_MIXER_FBFMT_ARGB2101010,
-		.rgb =3D true,
 		.csc =3D SUN8I_CSC_MODE_OFF,
 	},
 	{
 		.drm_fmt =3D DRM_FORMAT_ABGR2101010,
 		.de2_fmt =3D SUN8I_MIXER_FBFMT_ABGR2101010,
-		.rgb =3D true,
 		.csc =3D SUN8I_CSC_MODE_OFF,
 	},
 	{
 		.drm_fmt =3D DRM_FORMAT_RGBA1010102,
 		.de2_fmt =3D SUN8I_MIXER_FBFMT_RGBA1010102,
-		.rgb =3D true,
 		.csc =3D SUN8I_CSC_MODE_OFF,
 	},
 	{
 		.drm_fmt =3D DRM_FORMAT_BGRA1010102,
 		.de2_fmt =3D SUN8I_MIXER_FBFMT_BGRA1010102,
-		.rgb =3D true,
 		.csc =3D SUN8I_CSC_MODE_OFF,
 	},
 	{
 		.drm_fmt =3D DRM_FORMAT_UYVY,
 		.de2_fmt =3D SUN8I_MIXER_FBFMT_UYVY,
-		.rgb =3D false,
 		.csc =3D SUN8I_CSC_MODE_YUV2RGB,
 	},
 	{
 		.drm_fmt =3D DRM_FORMAT_VYUY,
 		.de2_fmt =3D SUN8I_MIXER_FBFMT_VYUY,
-		.rgb =3D false,
 		.csc =3D SUN8I_CSC_MODE_YUV2RGB,
 	},
 	{
 		.drm_fmt =3D DRM_FORMAT_YUYV,
 		.de2_fmt =3D SUN8I_MIXER_FBFMT_YUYV,
-		.rgb =3D false,
 		.csc =3D SUN8I_CSC_MODE_YUV2RGB,
 	},
 	{
 		.drm_fmt =3D DRM_FORMAT_YVYU,
 		.de2_fmt =3D SUN8I_MIXER_FBFMT_YVYU,
-		.rgb =3D false,
 		.csc =3D SUN8I_CSC_MODE_YUV2RGB,
 	},
 	{
 		.drm_fmt =3D DRM_FORMAT_NV16,
 		.de2_fmt =3D SUN8I_MIXER_FBFMT_NV16,
-		.rgb =3D false,
 		.csc =3D SUN8I_CSC_MODE_YUV2RGB,
 	},
 	{
 		.drm_fmt =3D DRM_FORMAT_NV61,
 		.de2_fmt =3D SUN8I_MIXER_FBFMT_NV61,
-		.rgb =3D false,
 		.csc =3D SUN8I_CSC_MODE_YUV2RGB,
 	},
 	{
 		.drm_fmt =3D DRM_FORMAT_NV12,
 		.de2_fmt =3D SUN8I_MIXER_FBFMT_NV12,
-		.rgb =3D false,
 		.csc =3D SUN8I_CSC_MODE_YUV2RGB,
 	},
 	{
 		.drm_fmt =3D DRM_FORMAT_NV21,
 		.de2_fmt =3D SUN8I_MIXER_FBFMT_NV21,
-		.rgb =3D false,
 		.csc =3D SUN8I_CSC_MODE_YUV2RGB,
 	},
 	{
 		.drm_fmt =3D DRM_FORMAT_YUV422,
 		.de2_fmt =3D SUN8I_MIXER_FBFMT_YUV422,
-		.rgb =3D false,
 		.csc =3D SUN8I_CSC_MODE_YUV2RGB,
 	},
 	{
 		.drm_fmt =3D DRM_FORMAT_YUV420,
 		.de2_fmt =3D SUN8I_MIXER_FBFMT_YUV420,
-		.rgb =3D false,
 		.csc =3D SUN8I_CSC_MODE_YUV2RGB,
 	},
 	{
 		.drm_fmt =3D DRM_FORMAT_YUV411,
 		.de2_fmt =3D SUN8I_MIXER_FBFMT_YUV411,
-		.rgb =3D false,
 		.csc =3D SUN8I_CSC_MODE_YUV2RGB,
 	},
 	{
 		.drm_fmt =3D DRM_FORMAT_YVU422,
 		.de2_fmt =3D SUN8I_MIXER_FBFMT_YUV422,
-		.rgb =3D false,
 		.csc =3D SUN8I_CSC_MODE_YVU2RGB,
 	},
 	{
 		.drm_fmt =3D DRM_FORMAT_YVU420,
 		.de2_fmt =3D SUN8I_MIXER_FBFMT_YUV420,
-		.rgb =3D false,
 		.csc =3D SUN8I_CSC_MODE_YVU2RGB,
 	},
 	{
 		.drm_fmt =3D DRM_FORMAT_YVU411,
 		.de2_fmt =3D SUN8I_MIXER_FBFMT_YUV411,
-		.rgb =3D false,
 		.csc =3D SUN8I_CSC_MODE_YVU2RGB,
 	},
 	{
 		.drm_fmt =3D DRM_FORMAT_P010,
 		.de2_fmt =3D SUN8I_MIXER_FBFMT_P010_YUV,
-		.rgb =3D false,
 		.csc =3D SUN8I_CSC_MODE_YUV2RGB,
 	},
 	{
 		.drm_fmt =3D DRM_FORMAT_P210,
 		.de2_fmt =3D SUN8I_MIXER_FBFMT_P210_YUV,
-		.rgb =3D false,
 		.csc =3D SUN8I_CSC_MODE_YUV2RGB,
 	},
 };
diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.h b/drivers/gpu/drm/sun4i/=
sun8i_mixer.h
index 345b28b0a80a..447ad0b01b00 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.h
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.h
@@ -147,7 +147,6 @@
 struct de2_fmt_info {
 	u32			drm_fmt;
 	u32			de2_fmt;
-	bool			rgb;
 	enum sun8i_csc_mode	csc;
 };
=20
diff --git a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c b/drivers/gpu/drm/sun=
4i/sun8i_ui_layer.c
index c87fd842918e..99ee19a00415 100644
--- a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
@@ -175,12 +175,14 @@ static int sun8i_ui_layer_update_formats(struct sun=
8i_mixer *mixer, int channel,
 {
 	struct drm_plane_state *state =3D plane->state;
 	const struct de2_fmt_info *fmt_info;
+	const struct drm_format_info *fmt;
 	u32 val, ch_base;
=20
 	ch_base =3D sun8i_channel_base(mixer, channel);
=20
-	fmt_info =3D sun8i_mixer_format_info(state->fb->format->format);
-	if (!fmt_info || !fmt_info->rgb) {
+	fmt =3D state->fb->format;
+	fmt_info =3D sun8i_mixer_format_info(fmt->format);
+	if (!fmt_info || fmt->is_yuv) {
 		DRM_DEBUG_DRIVER("Invalid format\n");
 		return -EINVAL;
 	}
diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c b/drivers/gpu/drm/sun=
4i/sun8i_vi_layer.c
index b8398ca18b0f..a2eb4371026d 100644
--- a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
@@ -215,11 +215,13 @@ static int sun8i_vi_layer_update_formats(struct sun=
8i_mixer *mixer, int channel,
 {
 	struct drm_plane_state *state =3D plane->state;
 	const struct de2_fmt_info *fmt_info;
+	const struct drm_format_info *fmt;
 	u32 val, ch_base;
=20
 	ch_base =3D sun8i_channel_base(mixer, channel);
=20
-	fmt_info =3D sun8i_mixer_format_info(state->fb->format->format);
+	fmt =3D state->fb->format;
+	fmt_info =3D sun8i_mixer_format_info(fmt->format);
 	if (!fmt_info) {
 		DRM_DEBUG_DRIVER("Invalid format\n");
 		return -EINVAL;
@@ -239,7 +241,7 @@ static int sun8i_vi_layer_update_formats(struct sun8i=
_mixer *mixer, int channel,
 		sun8i_csc_enable_ccsc(mixer, channel, false);
 	}
=20
-	if (fmt_info->rgb)
+	if (!fmt->is_yuv)
 		val =3D SUN8I_MIXER_CHAN_VI_LAYER_ATTR_RGB_MODE;
 	else
 		val =3D 0;
--=20
2.25.1

