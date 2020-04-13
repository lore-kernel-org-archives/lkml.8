Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22156C2BA2B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 21:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB0A320644
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 21:52:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pp3345.net header.i=@pp3345.net header.b="S3g50iG3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389272AbgDMVwO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 17:52:14 -0400
Received: from saul.pp3345.net ([163.172.111.124]:56720 "EHLO saul.pp3345.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727856AbgDMVwJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 17:52:09 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: dev@pp3345.net)
        by saul.pp3345.net (Postcow) with ESMTPSA id E7CE79A45E9;
        Mon, 13 Apr 2020 23:42:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pp3345.net; s=saul;
        t=1586814168; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:openpgp:autocrypt;
        bh=mLQh6rOSSTr8rmQR2noDfKObP5yY0fFQpqQZs6nN01o=;
        b=S3g50iG3NvTpyXkm0fE3BQrytPBc0hVuNOqZqWWZReRhYHDkPpv/AWcOtXAzK+RO2Z9caZ
        niApSpo3IrrnTCrYQGcch+t49uDyopW2VQZz0oBUWTpley6Ndrp/lLwHZNP9/CoydXdtVA
        x9zoiMG/JruBzaD+Wf3oIC89cTG5HA50ZGFWQJBh1/Zp4UFZMEZebvHSIz/WlG71f7BI5D
        MTagjHk5oN8XqAzkmb1abCSp4pRUhmX0XGqrHIg/satzT2ItkZ8S+zLVRkr5XFmMvb8C2U
        4S+vdW4qHMRx7ymW2Ls/HIuAilhsS0rMhyueo5sTCw7RowA+Mbd/TaVNk0af4w==
From:   Yussuf Khalil <dev@pp3345.net>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Yussuf Khalil <dev@pp3345.net>
Subject: [PATCH 1/5] drm/modes: Indicate CEA-861 CE modes to user-space
Date:   Mon, 13 Apr 2020 23:40:22 +0200
Message-Id: <20200413214024.46500-2-dev@pp3345.net>
In-Reply-To: <20200413214024.46500-1-dev@pp3345.net>
References: <20200413214024.46500-1-dev@pp3345.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new flag to mark modes that are considered a CE mode according to the
CEA-861 specification. Modes without this flag are implicitly considered to
be IT modes.

User-space applications may use this flag to determine possible
implications of using a CE mode (e.g., limited RGB range).

There is no use for this flag inside the kernel, so we set it only when
communicating a mode to user-space.

Signed-off-by: Yussuf Khalil <dev@pp3345.net>
---
 drivers/gpu/drm/drm_modes.c | 14 ++++++++++++++
 include/uapi/drm/drm_mode.h |  2 ++
 2 files changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/drm_modes.c b/drivers/gpu/drm/drm_modes.c
index d4d64518e11b..0d8a032f437d 100644
--- a/drivers/gpu/drm/drm_modes.c
+++ b/drivers/gpu/drm/drm_modes.c
@@ -1973,6 +1973,14 @@ void drm_mode_convert_to_umode(struct drm_mode_modeinfo *out,
 		break;
 	}
 
+	if (drm_match_cea_mode(in) > 1) {
+		/*
+		 * All modes in CTA-861-G Table 1 are CE modes, except 640x480p
+		 * (VIC 1).
+		 */
+		out->flags |= DRM_MODE_FLAG_CEA_861_CE_MODE;
+	}
+
 	strncpy(out->name, in->name, DRM_DISPLAY_MODE_LEN);
 	out->name[DRM_DISPLAY_MODE_LEN-1] = 0;
 }
@@ -2045,6 +2053,12 @@ int drm_mode_convert_umode(struct drm_device *dev,
 		return -EINVAL;
 	}
 
+	/*
+	 * The CEA-861 CE mode flag is purely informational and intended for
+	 * userspace only.
+	 */
+	out->flags &= ~DRM_MODE_FLAG_CEA_861_CE_MODE;
+
 	out->status = drm_mode_validate_driver(dev, out);
 	if (out->status != MODE_OK)
 		return -EINVAL;
diff --git a/include/uapi/drm/drm_mode.h b/include/uapi/drm/drm_mode.h
index 735c8cfdaaa1..5e78b350b2e2 100644
--- a/include/uapi/drm/drm_mode.h
+++ b/include/uapi/drm/drm_mode.h
@@ -124,6 +124,8 @@ extern "C" {
 #define  DRM_MODE_FLAG_PIC_AR_256_135 \
 			(DRM_MODE_PICTURE_ASPECT_256_135<<19)
 
+#define DRM_MODE_FLAG_CEA_861_CE_MODE (1<<23)
+
 #define  DRM_MODE_FLAG_ALL	(DRM_MODE_FLAG_PHSYNC |		\
 				 DRM_MODE_FLAG_NHSYNC |		\
 				 DRM_MODE_FLAG_PVSYNC |		\
-- 
2.26.0

