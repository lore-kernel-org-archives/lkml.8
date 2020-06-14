Return-Path: <SRS0=Atmy=73=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C622C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 20:02:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 614E72074D
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 20:02:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vMkCjCpZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727909AbgFNUB4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jun 2020 16:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726938AbgFNUBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jun 2020 16:01:47 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02511C08C5C5;
        Sun, 14 Jun 2020 13:01:47 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id d27so3706655lfq.5;
        Sun, 14 Jun 2020 13:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lFel57lgzkdFi66A+blGOSEVo/1btB7qpZRFUjdwuaU=;
        b=vMkCjCpZdLUYv4suIqfx/3MUEZK1a6KD7CNZtbYGdSdsPJeaicMH3Vge7RWPzTknLh
         EBruytN8H/ucQwnaWfYH7FRtktEa54ZS9pRuJHdxX+TBGNZ58+vP5DndOQ1jQJk2T659
         nf93A936pfBRYyHl5QXaT4NudEW35KwfecF/No1EP0u8FKIiOV6/WRaVGGw+cPhh02Ug
         l32ioBRxMnesvhq/nW7pCAeaeZq5jeS9AyVoni47+tY1jEYQ+trPXen6z486WezTghUw
         c2Ij7fzQh1vt3D7P1iQY646Fz4CuDgvZyru32vFUh6y+CNKN+LxsZZ600CJGSTuhefZq
         s99A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lFel57lgzkdFi66A+blGOSEVo/1btB7qpZRFUjdwuaU=;
        b=EoP0ccg6wIlOn6g/GpmFGdi1hqCrifmsoeXXwerD39f2AUbOncDrXFOEmedOYoEQjQ
         tByBHmpFciIi33o8WcXNZhITi5Ko8JGNHFmwv+ZZlumv9sKV8/LnzNQtc7G3H9ARl0+U
         9qoyHajewJJCRVM3mQ61ke5M0133PTfGaUCrsgJyySoDpDdQS9GT0zaIfoQiH/n3BXxS
         bNaqznsS66l1qDFC2I/MbAZKTMsdgFXzdQ7pDXYTq49YfL71VgNcoAROFc/M+ok530o+
         Zw9k5UTPR0HTUjTExMuytnFbdawXN6DbQ1aPXtoojhpm3btLgmOZC8EdpOIqgH1lMPw2
         6ljA==
X-Gm-Message-State: AOAM532ILANr0KaFE1kHgxVzcs/tiM12uTt7/BvxmJDxvz+/c0cusYqg
        XpyzeAYddvcPnkm7Wei2nLs=
X-Google-Smtp-Source: ABdhPJzNUu4NpTHxztFbm6URTJe+XIxQZ+nkTLzrk8ITpSUydiX1sZV0V1uqoL2VvkWht7I0fO+RYg==
X-Received: by 2002:a19:c212:: with SMTP id l18mr11722963lfc.68.1592164905521;
        Sun, 14 Jun 2020 13:01:45 -0700 (PDT)
Received: from localhost.localdomain (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.gmail.com with ESMTPSA id 144sm1422105lfm.87.2020.06.14.13.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2020 13:01:45 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Derek Basehore <dbasehore@chromium.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sean Paul <sean@poorly.run>
Cc:     dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/5] drm/tegra: plane: Support horizontal reflection mode
Date:   Sun, 14 Jun 2020 23:01:20 +0300
Message-Id: <20200614200121.14147-5-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200614200121.14147-1-digetx@gmail.com>
References: <20200614200121.14147-1-digetx@gmail.com>
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
 drivers/gpu/drm/tegra/dc.c    | 24 ++++++++++++++++++++----
 drivers/gpu/drm/tegra/dc.h    |  1 +
 drivers/gpu/drm/tegra/plane.c |  1 +
 drivers/gpu/drm/tegra/plane.h |  1 +
 4 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/tegra/dc.c b/drivers/gpu/drm/tegra/dc.c
index ed282f88e409..f31bca27cde4 100644
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
 
@@ -601,7 +607,9 @@ static int tegra_plane_atomic_check(struct drm_plane *plane,
 				    struct drm_plane_state *state)
 {
 	struct tegra_plane_state *plane_state = to_tegra_plane_state(state);
-	unsigned int rotation = DRM_MODE_ROTATE_0 | DRM_MODE_REFLECT_Y;
+	unsigned int rotation = DRM_MODE_ROTATE_0 |
+				DRM_MODE_REFLECT_X |
+				DRM_MODE_REFLECT_Y;
 	struct tegra_bo_tiling *tiling = &plane_state->tiling;
 	struct tegra_plane *tegra = to_tegra_plane(plane);
 	struct tegra_dc *dc = to_tegra_dc(state->crtc);
@@ -641,6 +649,11 @@ static int tegra_plane_atomic_check(struct drm_plane *plane,
 
 	rotation = drm_rotation_simplify(state->rotation, rotation);
 
+	if (rotation & DRM_MODE_REFLECT_X)
+		plane_state->reflect_x = true;
+	else
+		plane_state->reflect_x = false;
+
 	if (rotation & DRM_MODE_REFLECT_Y)
 		plane_state->reflect_y = true;
 	else
@@ -706,6 +719,7 @@ static void tegra_plane_atomic_update(struct drm_plane *plane,
 	window.dst.w = drm_rect_width(&plane->state->dst);
 	window.dst.h = drm_rect_height(&plane->state->dst);
 	window.bits_per_pixel = fb->format->cpp[0] * 8;
+	window.reflect_x = state->reflect_x;
 	window.reflect_y = tegra_fb_is_bottom_up(fb) || state->reflect_y;
 
 	/* copy from state */
@@ -792,6 +806,7 @@ static struct drm_plane *tegra_primary_plane_create(struct drm_device *drm,
 	err = drm_plane_create_rotation_property(&plane->base,
 						 DRM_MODE_ROTATE_0,
 						 DRM_MODE_ROTATE_0 |
+						 DRM_MODE_REFLECT_X |
 						 DRM_MODE_REFLECT_Y);
 	if (err < 0)
 		dev_err(dc->dev, "failed to create rotation property: %d\n",
@@ -1079,6 +1094,7 @@ static struct drm_plane *tegra_dc_overlay_plane_create(struct drm_device *drm,
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

