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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF749C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 19:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E6F82071A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 19:04:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lWA21eD5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbgFNTEO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jun 2020 15:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727769AbgFNTEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jun 2020 15:04:10 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94A89C08C5C5;
        Sun, 14 Jun 2020 12:04:09 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id q19so16593340lji.2;
        Sun, 14 Jun 2020 12:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ye8LBDqYIu3EMl0SpXZiBgFDVin4wanrCIFCoDUlTCY=;
        b=lWA21eD5Zk5I44oSNWVi8lPf1+OiG9NoVYobu2YDCitzaIbXYxMWu6KCSGjP2CfwXR
         Yyi98taZ/99CCIdTM04RG3JncNPOBcJThLWBsTq0ka+1tOFxHhAMERjhmS/ym4mCVRnD
         mr/VlnBHemWMS/Y5rNS5LTd0gfrajlTAxoGA51gVt0h1pWbG3Ay6q8hbYhyMghmPrtBD
         vAys9NzIkmhguLsQDydvcjIh5hakbQyNG5HWvpNNgUrvRPX6KRJ8IF3C8kl4TwtPAE27
         FiQDOr7ZaOIcJ+Bz4n0pdU0SXYAiEHhlmXYEcur1VkD5AhG87InFCfqmOOX2X89wFf2/
         kYhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ye8LBDqYIu3EMl0SpXZiBgFDVin4wanrCIFCoDUlTCY=;
        b=RlQnymM3iBElyXI/nCOxL1UrOPS3yfHjp+VL+Jsl561tTEEcMm43ZW9NP7o4BZjOHj
         db9FhMLV2YF1/zWnH41qrjMPYhMRLy35p3GRaH83X2e0Ax764vflkoaS0HaR5B32pXxx
         ukK1n4rKMm9QVm0b4E41rb9U2FMPOX25hf+REw0u/SAD+VuOOzhG2/K0hRA6X3aDNKIw
         zdP8sjpU3zwsrIbKb75xJq76N4rP+hFpJbW22C1nQbIwUOzPO0sh5WZ7mSPbE9S5bvzt
         cFmQzTgITQHSZ1mtkCove0vAu8uXKK67rOWGTpeveRzb1HkalUVJlgMDqRJtVdHdC3zO
         wd/Q==
X-Gm-Message-State: AOAM530ZbK7/xG6u8bMUx/PkgVfLUAjdGQPXO664Bz0HW69i/CXbhFVK
        kFZN37P3lqM053LK0qK+dAw=
X-Google-Smtp-Source: ABdhPJydq3O7wM9zT04En/+a1wqWXkBZL51pkj7tiQD3UNNMIhI879CJqKO/A2fgNVQHGp4WYUhJNw==
X-Received: by 2002:a2e:8705:: with SMTP id m5mr10782304lji.269.1592161447898;
        Sun, 14 Jun 2020 12:04:07 -0700 (PDT)
Received: from localhost.localdomain (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.gmail.com with ESMTPSA id p15sm3410856ljn.53.2020.06.14.12.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2020 12:04:07 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Derek Basehore <dbasehore@chromium.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sean Paul <sean@poorly.run>
Cc:     dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 4/6] drm/tegra: plane: Rename bottom_up to reflect_y
Date:   Sun, 14 Jun 2020 22:03:46 +0300
Message-Id: <20200614190348.12193-5-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200614190348.12193-1-digetx@gmail.com>
References: <20200614190348.12193-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This makes the naming consistent with the DRM core.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/gpu/drm/tegra/dc.c    | 10 +++++-----
 drivers/gpu/drm/tegra/dc.h    |  2 +-
 drivers/gpu/drm/tegra/plane.c |  2 +-
 drivers/gpu/drm/tegra/plane.h |  2 +-
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/tegra/dc.c b/drivers/gpu/drm/tegra/dc.c
index 83f31c6e891c..ed282f88e409 100644
--- a/drivers/gpu/drm/tegra/dc.c
+++ b/drivers/gpu/drm/tegra/dc.c
@@ -404,7 +404,7 @@ static void tegra_dc_setup_window(struct tegra_plane *plane,
 		tegra_plane_writel(plane, window->stride[0], DC_WIN_LINE_STRIDE);
 	}
 
-	if (window->bottom_up)
+	if (window->reflect_y)
 		v_offset += window->src.h - 1;
 
 	tegra_plane_writel(plane, h_offset, DC_WINBUF_ADDR_H_OFFSET);
@@ -470,7 +470,7 @@ static void tegra_dc_setup_window(struct tegra_plane *plane,
 		value |= COLOR_EXPAND;
 	}
 
-	if (window->bottom_up)
+	if (window->reflect_y)
 		value |= V_DIRECTION;
 
 	if (tegra_plane_use_horizontal_filtering(plane, window)) {
@@ -642,9 +642,9 @@ static int tegra_plane_atomic_check(struct drm_plane *plane,
 	rotation = drm_rotation_simplify(state->rotation, rotation);
 
 	if (rotation & DRM_MODE_REFLECT_Y)
-		plane_state->bottom_up = true;
+		plane_state->reflect_y = true;
 	else
-		plane_state->bottom_up = false;
+		plane_state->reflect_y = false;
 
 	/*
 	 * Tegra doesn't support different strides for U and V planes so we
@@ -706,7 +706,7 @@ static void tegra_plane_atomic_update(struct drm_plane *plane,
 	window.dst.w = drm_rect_width(&plane->state->dst);
 	window.dst.h = drm_rect_height(&plane->state->dst);
 	window.bits_per_pixel = fb->format->cpp[0] * 8;
-	window.bottom_up = tegra_fb_is_bottom_up(fb) || state->bottom_up;
+	window.reflect_y = tegra_fb_is_bottom_up(fb) || state->reflect_y;
 
 	/* copy from state */
 	window.zpos = plane->state->normalized_zpos;
diff --git a/drivers/gpu/drm/tegra/dc.h b/drivers/gpu/drm/tegra/dc.h
index 3d8ddccd758f..98e1b625168e 100644
--- a/drivers/gpu/drm/tegra/dc.h
+++ b/drivers/gpu/drm/tegra/dc.h
@@ -136,7 +136,7 @@ struct tegra_dc_window {
 	unsigned int stride[2];
 	unsigned long base[3];
 	unsigned int zpos;
-	bool bottom_up;
+	bool reflect_y;
 
 	struct tegra_bo_tiling tiling;
 	u32 format;
diff --git a/drivers/gpu/drm/tegra/plane.c b/drivers/gpu/drm/tegra/plane.c
index 9ccfb56e9b01..e05ef6013a97 100644
--- a/drivers/gpu/drm/tegra/plane.c
+++ b/drivers/gpu/drm/tegra/plane.c
@@ -61,7 +61,7 @@ tegra_plane_atomic_duplicate_state(struct drm_plane *plane)
 	copy->tiling = state->tiling;
 	copy->format = state->format;
 	copy->swap = state->swap;
-	copy->bottom_up = state->bottom_up;
+	copy->reflect_y = state->reflect_y;
 	copy->opaque = state->opaque;
 
 	for (i = 0; i < 2; i++)
diff --git a/drivers/gpu/drm/tegra/plane.h b/drivers/gpu/drm/tegra/plane.h
index a158a915109a..8047fc916d8c 100644
--- a/drivers/gpu/drm/tegra/plane.h
+++ b/drivers/gpu/drm/tegra/plane.h
@@ -46,7 +46,7 @@ struct tegra_plane_state {
 	u32 format;
 	u32 swap;
 
-	bool bottom_up;
+	bool reflect_y;
 
 	/* used for legacy blending support only */
 	struct tegra_plane_legacy_blending_state blending[2];
-- 
2.26.0

