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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD50AC433E2
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 19:04:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B17EA2071A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 19:04:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cp+Gd07S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727839AbgFNTER (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jun 2020 15:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727811AbgFNTEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jun 2020 15:04:10 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5191CC08C5C6;
        Sun, 14 Jun 2020 12:04:10 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id c21so8240131lfb.3;
        Sun, 14 Jun 2020 12:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lFel57lgzkdFi66A+blGOSEVo/1btB7qpZRFUjdwuaU=;
        b=Cp+Gd07SBw9hSPEujgevVcOyWCocSb8AE/x3IHu8df9vPU4L80W7M4vTmH3z8C5QZo
         sUwDBB1USSZa8/cRaTnUDXQQh26YkN9PcTptM7CRUh0Hlypdw0iYtKz0m5PHo9saGd34
         f7LuEUID+FA4+nCs13JgBvmjoVLBPVG3E0OzL3zqHyDfnGYp6GqPaVn1yMlannrwdSQj
         uaS/ZdJiGJAy5IMSi1N/f4RiuZbW8R4cYXz/HApJ4FrP5vfc9G4VzMk0zPDmGaptxbLR
         0iDcSNq6vBdY4cUMXIlEGALaMgAh1z9P3IzZiCaB9tHEPlpuQseCx6Fvhl4lXfXPltJh
         n/vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lFel57lgzkdFi66A+blGOSEVo/1btB7qpZRFUjdwuaU=;
        b=DsNbHFo0T90szZ6bqfw6SwTD6JbSogDsrVaX5lmlXj/lSRBWoqk27lL7SA2NwW3rR3
         BktClbRTgvDorI0Hn5qF4noDoDxUhBfPVFzO8qKTLZ0AUKVRvnRlgJ5xu1qoSKeEJSEw
         LUXV9dfFv6lpIBDm9Bf/EjYOS+0oWPC3zuEWzWyjLdsrMr+1Fguyw3tfeU93LpT2Tu+E
         z/zCAIUQHXCd6iau3ng7CGgMW+T7+kHpH65PKb58THr+p37aXPWfy8Fp50LjYTYLIsdj
         /0HrqBbKyECA/Ghctc4vRpBzigJAhtUcMzLkYj8yttU7XMeLV3wlEC3JV9iCQt8D/sl+
         FOlw==
X-Gm-Message-State: AOAM533aRRTpxwsoNwy6+EjaNWmCfzBU7pu3VR28b90ZlaHYpo0CRXPg
        exnC+mo/Sy3+BucEdWoOpwE=
X-Google-Smtp-Source: ABdhPJyiXu1TKbJxhwNWXMC6HYJcqRA74MiBjR//OFPlqWLa+1PMQnVOxILMzoDr1ib24Jk+ABNhDA==
X-Received: by 2002:ac2:485a:: with SMTP id 26mr12022269lfy.57.1592161448852;
        Sun, 14 Jun 2020 12:04:08 -0700 (PDT)
Received: from localhost.localdomain (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.gmail.com with ESMTPSA id p15sm3410856ljn.53.2020.06.14.12.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2020 12:04:08 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Derek Basehore <dbasehore@chromium.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sean Paul <sean@poorly.run>
Cc:     dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 5/6] drm/tegra: plane: Support horizontal reflection mode
Date:   Sun, 14 Jun 2020 22:03:47 +0300
Message-Id: <20200614190348.12193-6-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200614190348.12193-1-digetx@gmail.com>
References: <20200614190348.12193-1-digetx@gmail.com>
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

