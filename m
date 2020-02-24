Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBC70C11D30
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 17:39:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E79521556
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 17:39:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbgBXRjP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 12:39:15 -0500
Received: from mailoutvs62.siol.net ([185.57.226.253]:51166 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726208AbgBXRjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 12:39:14 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id F27065236E8;
        Mon, 24 Feb 2020 18:39:11 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta11.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta11.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id JRsQv1euN1Bq; Mon, 24 Feb 2020 18:39:11 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id A7E775236BE;
        Mon, 24 Feb 2020 18:39:11 +0100 (CET)
Received: from localhost.localdomain (cpe-194-152-20-232.static.triera.net [194.152.20.232])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id 0743E5236E8;
        Mon, 24 Feb 2020 18:39:09 +0100 (CET)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     mripard@kernel.org, wens@csie.org
Cc:     jernej.skrabec@siol.net, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] drm/sun4i: de2/de3: Remove unsupported VI layer formats
Date:   Mon, 24 Feb 2020 18:38:55 +0100
Message-Id: <20200224173901.174016-2-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200224173901.174016-1-jernej.skrabec@siol.net>
References: <20200224173901.174016-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

YUV444 and YVU444 are planar formats, but HW format RGB888 is packed.
This means that those two mappings were never correct. Remove them.

Fixes: 60a3dcf96aa8 ("drm/sun4i: Add DE2 definitions for YUV formats")
Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/sun4i/sun8i_mixer.c    | 12 ------------
 drivers/gpu/drm/sun4i/sun8i_vi_layer.c |  2 --
 2 files changed, 14 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c b/drivers/gpu/drm/sun4i/=
sun8i_mixer.c
index 7c24f8f832a5..3a78dbbceb8a 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
@@ -196,12 +196,6 @@ static const struct de2_fmt_info de2_formats[] =3D {
 		.rgb =3D false,
 		.csc =3D SUN8I_CSC_MODE_YUV2RGB,
 	},
-	{
-		.drm_fmt =3D DRM_FORMAT_YUV444,
-		.de2_fmt =3D SUN8I_MIXER_FBFMT_RGB888,
-		.rgb =3D true,
-		.csc =3D SUN8I_CSC_MODE_YUV2RGB,
-	},
 	{
 		.drm_fmt =3D DRM_FORMAT_YUV422,
 		.de2_fmt =3D SUN8I_MIXER_FBFMT_YUV422,
@@ -220,12 +214,6 @@ static const struct de2_fmt_info de2_formats[] =3D {
 		.rgb =3D false,
 		.csc =3D SUN8I_CSC_MODE_YUV2RGB,
 	},
-	{
-		.drm_fmt =3D DRM_FORMAT_YVU444,
-		.de2_fmt =3D SUN8I_MIXER_FBFMT_RGB888,
-		.rgb =3D true,
-		.csc =3D SUN8I_CSC_MODE_YVU2RGB,
-	},
 	{
 		.drm_fmt =3D DRM_FORMAT_YVU422,
 		.de2_fmt =3D SUN8I_MIXER_FBFMT_YUV422,
diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c b/drivers/gpu/drm/sun=
4i/sun8i_vi_layer.c
index 42d445d23773..6a244d6fafd9 100644
--- a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
@@ -431,11 +431,9 @@ static const u32 sun8i_vi_layer_formats[] =3D {
 	DRM_FORMAT_YUV411,
 	DRM_FORMAT_YUV420,
 	DRM_FORMAT_YUV422,
-	DRM_FORMAT_YUV444,
 	DRM_FORMAT_YVU411,
 	DRM_FORMAT_YVU420,
 	DRM_FORMAT_YVU422,
-	DRM_FORMAT_YVU444,
 };
=20
 struct sun8i_vi_layer *sun8i_vi_layer_init_one(struct drm_device *drm,
--=20
2.25.1

