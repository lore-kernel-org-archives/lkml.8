Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3D51C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 23:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 796BE21556
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 23:41:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UGFppwtD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbgFQXlQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 19:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727806AbgFQXlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 19:41:05 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA489C0613ED;
        Wed, 17 Jun 2020 16:41:04 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id x18so5028826lji.1;
        Wed, 17 Jun 2020 16:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lirhIx0iRlu3vfHaJJDD4eWpH3fBzn3WOnUPZr0Pdc8=;
        b=UGFppwtD0S5aRu9OWJnC+hJtvi9i+WRb8+BaxEQnvQ9nBaBQYWzUVtupwJFIvS4YAx
         sqE1UFcQKsTgRkcprPyaOb7GMTJmXZwCqNvxmqpkS6bkNacwLTVv2wF8z0uBtWYyAyAt
         XwCGFzgtqDGS2/iRx7p2vNFmJ2I5s6ffcKxgnAAfJziw7WZV9+RSWFXhwq1tq55IExpq
         7S4TvBNbV4gKMUp468nQRIgs2h0lFGXIOnIUPZHwWYl0bheD2opdfw1UJJ/KGuBv+9IW
         UvaKTavhUU65GB5kzn7eCIe9+m9kqz8kJx6ntzazRhYt2nSOUmfGWTASYjVU2Aw/VbfZ
         BGjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lirhIx0iRlu3vfHaJJDD4eWpH3fBzn3WOnUPZr0Pdc8=;
        b=HKpXHD0DtJW3BeAPYEFt/iCjHhQgfOr7NR/4xpMXAFRp2Cbi1N/Tamw/Ea83byXDwf
         m6+LXKekSRS/45SqjujwKJaQ8RmVJupuRTqRQbRzxgc5Hc/KI5DSXk47TkG8mdP0PNM+
         ku6WqyEb95CGvdqU6YDm4ktcY5nzxm2pUQVqtWoc6ZFaeIl32ztM4YHfbKJD+3QIa1x6
         zzyj9KkRIlGlBkAGTFFhSVDiYwjlBvTd7yQ1594dNQM7L6Si1vUk2+Mjn5X5nB0r9n5Z
         aMnUwOkYDgxGzgczVfmXOm1vmpQ7S5X6jUHHTFElZOWF9kyi8/v1oj+uYUidHrz7BwjA
         nGcw==
X-Gm-Message-State: AOAM532XPaul8qZqnlO1zPQlFu+878+cZvTOERb1Sj3WHZ7b4uzQUQ87
        NWCJnYNAfDzKpkeZxW1fHP0=
X-Google-Smtp-Source: ABdhPJwbNPhhk36ZR70FeX2ugPoqhRhe7oYpCWKRrs0eFMjwGmC3mutK7RmOplQMyq6VuXvzu9kQDA==
X-Received: by 2002:a2e:7c03:: with SMTP id x3mr778161ljc.227.1592437263111;
        Wed, 17 Jun 2020 16:41:03 -0700 (PDT)
Received: from localhost.localdomain (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.gmail.com with ESMTPSA id c8sm287871lfc.46.2020.06.17.16.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 16:41:02 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Derek Basehore <dbasehore@chromium.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sean Paul <sean@poorly.run>, Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Daniel Stone <daniel@fooishbar.org>
Cc:     dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] drm/tegra: plane: Support horizontal reflection
Date:   Thu, 18 Jun 2020 02:40:39 +0300
Message-Id: <20200617234040.1094-3-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200617234040.1094-1-digetx@gmail.com>
References: <20200617234040.1094-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support horizontal reflection mode which will allow to support 180°
rotation mode when combined with the vertical reflection.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/gpu/drm/tegra/dc.c    | 38 +++++++++++++++++++++++++++++------
 drivers/gpu/drm/tegra/dc.h    |  1 +
 drivers/gpu/drm/tegra/plane.c |  1 +
 drivers/gpu/drm/tegra/plane.h |  1 +
 4 files changed, 35 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/tegra/dc.c b/drivers/gpu/drm/tegra/dc.c
index bb92c1ed44e9..f8149dc3b1b4 100644
--- a/drivers/gpu/drm/tegra/dc.c
+++ b/drivers/gpu/drm/tegra/dc.c
@@ -368,6 +368,12 @@ static void tegra_dc_setup_window(struct tegra_plane *plane,
 	h_size = window->src.w * bpp;
 	v_size = window->src.h;
 
+	if (window->reflect_x)
+		h_offset += (window->src.w - 1) * bpp;
+
+	if (window->reflect_y)
+		v_offset += window->src.h - 1;
+
 	value = V_PRESCALED_SIZE(v_size) | H_PRESCALED_SIZE(h_size);
 	tegra_plane_writel(plane, value, DC_WIN_PRESCALED_SIZE);
 
@@ -404,9 +410,6 @@ static void tegra_dc_setup_window(struct tegra_plane *plane,
 		tegra_plane_writel(plane, window->stride[0], DC_WIN_LINE_STRIDE);
 	}
 
-	if (window->reflect_y)
-		v_offset += window->src.h - 1;
-
 	tegra_plane_writel(plane, h_offset, DC_WINBUF_ADDR_H_OFFSET);
 	tegra_plane_writel(plane, v_offset, DC_WINBUF_ADDR_V_OFFSET);
 
@@ -470,6 +473,9 @@ static void tegra_dc_setup_window(struct tegra_plane *plane,
 		value |= COLOR_EXPAND;
 	}
 
+	if (window->reflect_x)
+		value |= H_DIRECTION;
+
 	if (window->reflect_y)
 		value |= V_DIRECTION;
 
@@ -601,7 +607,10 @@ static int tegra_plane_atomic_check(struct drm_plane *plane,
 				    struct drm_plane_state *state)
 {
 	struct tegra_plane_state *plane_state = to_tegra_plane_state(state);
-	unsigned int rotation = DRM_MODE_ROTATE_0 | DRM_MODE_REFLECT_Y;
+	unsigned int supported_rotation = DRM_MODE_ROTATE_0 |
+					  DRM_MODE_REFLECT_X |
+					  DRM_MODE_REFLECT_Y;
+	unsigned int rotation = state->rotation;
 	struct tegra_bo_tiling *tiling = &plane_state->tiling;
 	struct tegra_plane *tegra = to_tegra_plane(plane);
 	struct tegra_dc *dc = to_tegra_dc(state->crtc);
@@ -639,7 +648,21 @@ static int tegra_plane_atomic_check(struct drm_plane *plane,
 		return -EINVAL;
 	}
 
-	rotation = drm_rotation_simplify(state->rotation, rotation);
+	/*
+	 * Older userspace used custom BO flag in order to specify the Y
+	 * reflection, while modern userspace uses the generic DRM rotation
+	 * property in order to achieve the same result.  The legacy BO flag
+	 * duplicates the DRM rotation property when both are set.
+	 */
+	if (tegra_fb_is_bottom_up(state->fb))
+		rotation |= DRM_MODE_REFLECT_Y;
+
+	rotation = drm_rotation_simplify(rotation, supported_rotation);
+
+	if (rotation & DRM_MODE_REFLECT_X)
+		plane_state->reflect_x = true;
+	else
+		plane_state->reflect_x = false;
 
 	if (rotation & DRM_MODE_REFLECT_Y)
 		plane_state->reflect_y = true;
@@ -706,7 +729,8 @@ static void tegra_plane_atomic_update(struct drm_plane *plane,
 	window.dst.w = drm_rect_width(&plane->state->dst);
 	window.dst.h = drm_rect_height(&plane->state->dst);
 	window.bits_per_pixel = fb->format->cpp[0] * 8;
-	window.reflect_y = tegra_fb_is_bottom_up(fb) || state->reflect_y;
+	window.reflect_x = state->reflect_x;
+	window.reflect_y = state->reflect_y;
 
 	/* copy from state */
 	window.zpos = plane->state->normalized_zpos;
@@ -792,6 +816,7 @@ static struct drm_plane *tegra_primary_plane_create(struct drm_device *drm,
 	err = drm_plane_create_rotation_property(&plane->base,
 						 DRM_MODE_ROTATE_0,
 						 DRM_MODE_ROTATE_0 |
+						 DRM_MODE_REFLECT_X |
 						 DRM_MODE_REFLECT_Y);
 	if (err < 0)
 		dev_err(dc->dev, "failed to create rotation property: %d\n",
@@ -1080,6 +1105,7 @@ static struct drm_plane *tegra_dc_overlay_plane_create(struct drm_device *drm,
 	err = drm_plane_create_rotation_property(&plane->base,
 						 DRM_MODE_ROTATE_0,
 						 DRM_MODE_ROTATE_0 |
+						 DRM_MODE_REFLECT_X |
 						 DRM_MODE_REFLECT_Y);
 	if (err < 0)
 		dev_err(dc->dev, "failed to create rotation property: %d\n",
diff --git a/drivers/gpu/drm/tegra/dc.h b/drivers/gpu/drm/tegra/dc.h
index 98e1b625168e..051d03dcb9b0 100644
--- a/drivers/gpu/drm/tegra/dc.h
+++ b/drivers/gpu/drm/tegra/dc.h
@@ -136,6 +136,7 @@ struct tegra_dc_window {
 	unsigned int stride[2];
 	unsigned long base[3];
 	unsigned int zpos;
+	bool reflect_x;
 	bool reflect_y;
 
 	struct tegra_bo_tiling tiling;
diff --git a/drivers/gpu/drm/tegra/plane.c b/drivers/gpu/drm/tegra/plane.c
index e05ef6013a97..4cd0461cc508 100644
--- a/drivers/gpu/drm/tegra/plane.c
+++ b/drivers/gpu/drm/tegra/plane.c
@@ -61,6 +61,7 @@ tegra_plane_atomic_duplicate_state(struct drm_plane *plane)
 	copy->tiling = state->tiling;
 	copy->format = state->format;
 	copy->swap = state->swap;
+	copy->reflect_x = state->reflect_x;
 	copy->reflect_y = state->reflect_y;
 	copy->opaque = state->opaque;
 
diff --git a/drivers/gpu/drm/tegra/plane.h b/drivers/gpu/drm/tegra/plane.h
index 8047fc916d8c..c691dd79b27b 100644
--- a/drivers/gpu/drm/tegra/plane.h
+++ b/drivers/gpu/drm/tegra/plane.h
@@ -46,6 +46,7 @@ struct tegra_plane_state {
 	u32 format;
 	u32 swap;
 
+	bool reflect_x;
 	bool reflect_y;
 
 	/* used for legacy blending support only */
-- 
2.26.0

