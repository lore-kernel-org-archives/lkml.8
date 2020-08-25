Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46A2AC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 02:32:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21E76205CB
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 02:32:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bXlerMt0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728105AbgHYCcG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 22:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbgHYCcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 22:32:00 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AB3FC061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 19:32:00 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id t23so8030050qto.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 19:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KcHo4i74kj3qxvqHgzH/WtshfHI04sb5YBeB8ltiN6M=;
        b=bXlerMt0OP/DxGB9ODmOPs/BsBN8mhHhuUSoRdd1d4HTrPx3FLeAjDd4EJPq80T3In
         149kAVcKf3Z/q6AIoBqrU/iv61bAPEr9TUolDZ9MjOTJd3cymANVF4WbDCPD91VOjgOd
         ofHJs8Z1WmXm7y9M9lhEn9EJ1o1FKbdr7s9PdxHFebejeQU7rmKa624+3tXWNla4H3H6
         JwZiMAye7nLbWR9ttYmo7qmSUZmRv0fWVqWXp84+D7csnhRooX8P0wuRaaPYOeKq3E4o
         Q7Jp8ArrHyKR/Yr/bHVgy4bsmchRF6nrfBP1R725xMMSrkMIq8u8WT1+RIabtTwTPLjA
         k8Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KcHo4i74kj3qxvqHgzH/WtshfHI04sb5YBeB8ltiN6M=;
        b=iSoF1/jwxY6AjPCModLUKwWlY1T0n2/Po3XbGbZZmnw99OPm7+tNjttW7HNni56AoI
         eRoD9vceNbwGPXAMJ2ziD/Ca6kt3BLR7TOFwN4fTiv79q0yXikt1g3zu+tYcgrrBU1PA
         7BT6Z7ZspP30UveyXrxZf4hMwxD8f95/PRhNCr/p0A8MND2NLPD6TbROSRfyCmpBT5ao
         lFmLxMrunBLRGaZLC5yPYQ3Qtbn/X5DBZgcCz/hnNKVTidqchBx6lC+ouzTYWU81oYEW
         1bmzAZwzhrX4hJN2E+LUUKGPMRwygFWd7fNPV1Qz6vAeaUK2FRBaCyBub6YNeRvN4ge1
         qy9g==
X-Gm-Message-State: AOAM531p5CkvroE5x0Dj/lMLQrTDaOX2UbGatOG99giB92+ecxw6iDWl
        MZXhGpAAMDS2u2vkePh4OgbE8ra8O78=
X-Google-Smtp-Source: ABdhPJzVOgmVALB2L78x2p4uLPmykpU+KtBYc2ZqCABjDekUH2FfuaHspH5bqev5/RfMoQZqvzYbCg==
X-Received: by 2002:ac8:4748:: with SMTP id k8mr7535293qtp.114.1598322718750;
        Mon, 24 Aug 2020 19:31:58 -0700 (PDT)
Received: from atma2.hitronhub.home ([2607:fea8:56e0:6d60::2db6])
        by smtp.gmail.com with ESMTPSA id x137sm11095372qkb.47.2020.08.24.19.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 19:31:58 -0700 (PDT)
From:   Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Brian Starkey <brian.starkey@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Simon Ser <contact@emersion.fr>,
        Leandro Ribeiro <leandro.ribeiro@collabora.com>,
        melissa.srw@gmail.com, daniels@collabora.com,
        Emil Velikov <emil.l.velikov@gmail.com>
Subject: [PATCH v5 1/3] drm/vkms: Decouple crc operations from composer
Date:   Mon, 24 Aug 2020 22:31:40 -0400
Message-Id: <20200825023142.2561220-2-rodrigosiqueiramelo@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200825023142.2561220-1-rodrigosiqueiramelo@gmail.com>
References: <20200825023142.2561220-1-rodrigosiqueiramelo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the vkms_composer.c, some of the functions related to CRC and compose
have interdependence between each other. This patch reworks some
functions inside vkms_composer to make crc and composer computation
decoupled.

This patch is preparation work for making vkms able to support new
features.

Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
---
 drivers/gpu/drm/vkms/vkms_composer.c | 49 ++++++++++++++++------------
 1 file changed, 29 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/vkms_composer.c
index 4f3b07a32b60..4d8bc04bb6ee 100644
--- a/drivers/gpu/drm/vkms/vkms_composer.c
+++ b/drivers/gpu/drm/vkms/vkms_composer.c
@@ -108,35 +108,31 @@ static void compose_cursor(struct vkms_composer *cursor_composer,
 	      primary_composer, cursor_composer);
 }
 
-static uint32_t _vkms_get_crc(struct vkms_composer *primary_composer,
-			      struct vkms_composer *cursor_composer)
+static int compose_planes(void **vaddr_out,
+			  struct vkms_composer *primary_composer,
+			  struct vkms_composer *cursor_composer)
 {
 	struct drm_framebuffer *fb = &primary_composer->fb;
 	struct drm_gem_object *gem_obj = drm_gem_fb_get_obj(fb, 0);
 	struct vkms_gem_object *vkms_obj = drm_gem_to_vkms_gem(gem_obj);
-	void *vaddr_out = kzalloc(vkms_obj->gem.size, GFP_KERNEL);
-	u32 crc = 0;
 
-	if (!vaddr_out) {
-		DRM_ERROR("Failed to allocate memory for output frame.");
-		return 0;
+	if (!*vaddr_out) {
+		*vaddr_out = kzalloc(vkms_obj->gem.size, GFP_KERNEL);
+		if (!*vaddr_out) {
+			DRM_ERROR("Cannot allocate memory for output frame.");
+			return -ENOMEM;
+		}
 	}
 
-	if (WARN_ON(!vkms_obj->vaddr)) {
-		kfree(vaddr_out);
-		return crc;
-	}
+	if (WARN_ON(!vkms_obj->vaddr))
+		return -EINVAL;
 
-	memcpy(vaddr_out, vkms_obj->vaddr, vkms_obj->gem.size);
+	memcpy(*vaddr_out, vkms_obj->vaddr, vkms_obj->gem.size);
 
 	if (cursor_composer)
-		compose_cursor(cursor_composer, primary_composer, vaddr_out);
+		compose_cursor(cursor_composer, primary_composer, *vaddr_out);
 
-	crc = compute_crc(vaddr_out, primary_composer);
-
-	kfree(vaddr_out);
-
-	return crc;
+	return 0;
 }
 
 /**
@@ -157,9 +153,11 @@ void vkms_composer_worker(struct work_struct *work)
 	struct vkms_output *out = drm_crtc_to_vkms_output(crtc);
 	struct vkms_composer *primary_composer = NULL;
 	struct vkms_composer *cursor_composer = NULL;
+	void *vaddr_out = NULL;
 	u32 crc32 = 0;
 	u64 frame_start, frame_end;
 	bool crc_pending;
+	int ret;
 
 	spin_lock_irq(&out->composer_lock);
 	frame_start = crtc_state->frame_start;
@@ -183,14 +181,25 @@ void vkms_composer_worker(struct work_struct *work)
 	if (crtc_state->num_active_planes == 2)
 		cursor_composer = crtc_state->active_planes[1]->composer;
 
-	if (primary_composer)
-		crc32 = _vkms_get_crc(primary_composer, cursor_composer);
+	if (!primary_composer)
+		return;
+
+	ret = compose_planes(&vaddr_out, primary_composer, cursor_composer);
+	if (ret) {
+		if (ret == -EINVAL)
+			kfree(vaddr_out);
+		return;
+	}
+
+	crc32 = compute_crc(vaddr_out, primary_composer);
 
 	/*
 	 * The worker can fall behind the vblank hrtimer, make sure we catch up.
 	 */
 	while (frame_start <= frame_end)
 		drm_crtc_add_crc_entry(crtc, true, frame_start++, &crc32);
+
+	kfree(vaddr_out);
 }
 
 static const char * const pipe_crc_sources[] = {"auto"};
-- 
2.28.0

