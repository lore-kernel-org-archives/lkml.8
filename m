Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6E5EC11D2F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 17:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A34D120838
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 17:39:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728138AbgBXRjf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 12:39:35 -0500
Received: from mailoutvs52.siol.net ([185.57.226.243]:51325 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728074AbgBXRj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 12:39:26 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id D633A5236FC;
        Mon, 24 Feb 2020 18:39:23 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta11.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta11.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id bQ31Av_L3CjJ; Mon, 24 Feb 2020 18:39:23 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 6F5505236BE;
        Mon, 24 Feb 2020 18:39:23 +0100 (CET)
Received: from localhost.localdomain (cpe-194-152-20-232.static.triera.net [194.152.20.232])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id 118EE52373C;
        Mon, 24 Feb 2020 18:39:21 +0100 (CET)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     mripard@kernel.org, wens@csie.org
Cc:     jernej.skrabec@siol.net, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] drm/sun4i: de2: Don't return de2_fmt_info struct
Date:   Mon, 24 Feb 2020 18:39:00 +0100
Message-Id: <20200224173901.174016-7-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200224173901.174016-1-jernej.skrabec@siol.net>
References: <20200224173901.174016-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that de2_fmt_info contains only DRM <-> HW format mapping, it
doesn't make sense to return pointer to structure when searching by DRM
format. Rework that to return only HW format instead.

This doesn't make any functional change.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/sun4i/sun8i_mixer.c    | 15 +++++++++++----
 drivers/gpu/drm/sun4i/sun8i_mixer.h    |  7 +------
 drivers/gpu/drm/sun4i/sun8i_ui_layer.c | 10 +++++-----
 drivers/gpu/drm/sun4i/sun8i_vi_layer.c | 12 ++++++------
 4 files changed, 23 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c b/drivers/gpu/drm/sun4i/=
sun8i_mixer.c
index e078ec96de2d..56cc037fd312 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
@@ -27,6 +27,11 @@
 #include "sun8i_vi_layer.h"
 #include "sunxi_engine.h"
=20
+struct de2_fmt_info {
+	u32	drm_fmt;
+	u32	de2_fmt;
+};
+
 static const struct de2_fmt_info de2_formats[] =3D {
 	{
 		.drm_fmt =3D DRM_FORMAT_ARGB8888,
@@ -230,15 +235,17 @@ static const struct de2_fmt_info de2_formats[] =3D =
{
 	},
 };
=20
-const struct de2_fmt_info *sun8i_mixer_format_info(u32 format)
+int sun8i_mixer_drm_format_to_hw(u32 format, u32 *hw_format)
 {
 	unsigned int i;
=20
 	for (i =3D 0; i < ARRAY_SIZE(de2_formats); ++i)
-		if (de2_formats[i].drm_fmt =3D=3D format)
-			return &de2_formats[i];
+		if (de2_formats[i].drm_fmt =3D=3D format) {
+			*hw_format =3D de2_formats[i].de2_fmt;
+			return 0;
+		}
=20
-	return NULL;
+	return -EINVAL;
 }
=20
 static void sun8i_mixer_commit(struct sunxi_engine *engine)
diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.h b/drivers/gpu/drm/sun4i/=
sun8i_mixer.h
index 0dd4a347fa06..7576b523fdbb 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.h
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.h
@@ -143,11 +143,6 @@
 #define SUN50I_MIXER_CDC0_EN			0xd0000
 #define SUN50I_MIXER_CDC1_EN			0xd8000
=20
-struct de2_fmt_info {
-	u32	drm_fmt;
-	u32	de2_fmt;
-};
-
 /**
  * struct sun8i_mixer_cfg - mixer HW configuration
  * @vi_num: number of VI channels
@@ -207,5 +202,5 @@ sun8i_channel_base(struct sun8i_mixer *mixer, int cha=
nnel)
 		return DE2_CH_BASE + channel * DE2_CH_SIZE;
 }
=20
-const struct de2_fmt_info *sun8i_mixer_format_info(u32 format);
+int sun8i_mixer_drm_format_to_hw(u32 format, u32 *hw_format);
 #endif /* _SUN8I_MIXER_H_ */
diff --git a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c b/drivers/gpu/drm/sun=
4i/sun8i_ui_layer.c
index 99ee19a00415..a64aaea1ba74 100644
--- a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
@@ -174,20 +174,20 @@ static int sun8i_ui_layer_update_formats(struct sun=
8i_mixer *mixer, int channel,
 					 int overlay, struct drm_plane *plane)
 {
 	struct drm_plane_state *state =3D plane->state;
-	const struct de2_fmt_info *fmt_info;
 	const struct drm_format_info *fmt;
-	u32 val, ch_base;
+	u32 val, ch_base, hw_fmt;
+	int ret;
=20
 	ch_base =3D sun8i_channel_base(mixer, channel);
=20
 	fmt =3D state->fb->format;
-	fmt_info =3D sun8i_mixer_format_info(fmt->format);
-	if (!fmt_info || fmt->is_yuv) {
+	ret =3D sun8i_mixer_drm_format_to_hw(fmt->format, &hw_fmt);
+	if (ret || fmt->is_yuv) {
 		DRM_DEBUG_DRIVER("Invalid format\n");
 		return -EINVAL;
 	}
=20
-	val =3D fmt_info->de2_fmt << SUN8I_MIXER_CHAN_UI_LAYER_ATTR_FBFMT_OFFSE=
T;
+	val =3D hw_fmt << SUN8I_MIXER_CHAN_UI_LAYER_ATTR_FBFMT_OFFSET;
 	regmap_update_bits(mixer->engine.regs,
 			   SUN8I_MIXER_CHAN_UI_LAYER_ATTR(ch_base, overlay),
 			   SUN8I_MIXER_CHAN_UI_LAYER_ATTR_FBFMT_MASK, val);
diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c b/drivers/gpu/drm/sun=
4i/sun8i_vi_layer.c
index d783c2bfc77e..b1e1ba2da663 100644
--- a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
@@ -231,20 +231,20 @@ static int sun8i_vi_layer_update_formats(struct sun=
8i_mixer *mixer, int channel,
 					 int overlay, struct drm_plane *plane)
 {
 	struct drm_plane_state *state =3D plane->state;
-	const struct de2_fmt_info *fmt_info;
+	u32 val, ch_base, csc_mode, hw_fmt;
 	const struct drm_format_info *fmt;
-	u32 val, ch_base, csc_mode;
+	int ret;
=20
 	ch_base =3D sun8i_channel_base(mixer, channel);
=20
 	fmt =3D state->fb->format;
-	fmt_info =3D sun8i_mixer_format_info(fmt->format);
-	if (!fmt_info) {
+	ret =3D sun8i_mixer_drm_format_to_hw(fmt->format, &hw_fmt);
+	if (ret) {
 		DRM_DEBUG_DRIVER("Invalid format\n");
-		return -EINVAL;
+		return ret;
 	}
=20
-	val =3D fmt_info->de2_fmt << SUN8I_MIXER_CHAN_VI_LAYER_ATTR_FBFMT_OFFSE=
T;
+	val =3D hw_fmt << SUN8I_MIXER_CHAN_VI_LAYER_ATTR_FBFMT_OFFSET;
 	regmap_update_bits(mixer->engine.regs,
 			   SUN8I_MIXER_CHAN_VI_LAYER_ATTR(ch_base, overlay),
 			   SUN8I_MIXER_CHAN_VI_LAYER_ATTR_FBFMT_MASK, val);
--=20
2.25.1

