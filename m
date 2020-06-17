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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B84AAC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 23:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 959E921556
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 23:41:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BEku1n40"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbgFQXlT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 19:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727043AbgFQXlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 19:41:04 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1979C061755;
        Wed, 17 Jun 2020 16:41:03 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id i27so4961576ljb.12;
        Wed, 17 Jun 2020 16:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xltqyEfwrx8qT/CORRGTWXmzlbt9i4EassNZ2G9y7tE=;
        b=BEku1n40/Xnsjf59bRGYdTjZwuEud3inCy82ivQq2zFfIDTBIX85BM/9nR3smARZoV
         iaFwihC/aAe4vO2pJBovuMPuEOVeDPjQOqTOgrnh0WAjgKQ21CEh6+Zog4OAtQYG46to
         cEscvGvVVlVXW7vE2KT1cCd/ERsIInyY0S/ZgeFI4BqE/JRaXM1rs4RAUdq0L22pbWRk
         vffAMF/f2nQk0kVBKzC0Nqs4oL45s1+9SwmoCIcSWebPLHTAF6u/CaWGG1Ho/Y35Hnam
         16Zw9dt8qSZ9zJVImUtI/bfP4EDauQu/MyWtES2ZDcZ7i1xVTkWmVCN4OEBIykxHBAfj
         yJDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xltqyEfwrx8qT/CORRGTWXmzlbt9i4EassNZ2G9y7tE=;
        b=F8cnZjQB/rnH4fEgKwalnHS7Q12xDh/i/XZMGmrUEa/OXcK3eyc7EUQOvj8sjI10Tv
         h5nSQtan2NePMmCNHhEL7Y2Yl9nYQKZ6/UvshhHdiXYWp8AaTEty0FATUgebJf6H3Dms
         s5pkc/PYEOMrvCeN1x1lZfi4Pn1QXtNF4qjEACgs39VX04n3Bd0L6FQC6pyy+ArMhB/w
         +FrahRijiBYRjMSAYWc/eeMJLOXro9s+mmahGiglyouKBr2mjWaaPBb0Lp4UzLLKlw71
         eBOj0lodgHaY2iN6KYz165rBCLOGFxmCmjIKILVaonp3TRL71C6ubaFZXcJA/5J388Rx
         3oJA==
X-Gm-Message-State: AOAM5335XJYefc9XF5JrAOBE+R9r9/Xo7n4uqorrK9mtUmrsRxA47qWa
        aChcJIMNM+adIdjF4tufrz4=
X-Google-Smtp-Source: ABdhPJzFPcMwk85WsfMjXGVdLczf/bH01bsX9EzaXAeWYS4zo/ADuFMsPuQVPLGoV7fmgcVzpYYJfg==
X-Received: by 2002:a2e:b4c1:: with SMTP id r1mr881604ljm.370.1592437262021;
        Wed, 17 Jun 2020 16:41:02 -0700 (PDT)
Received: from localhost.localdomain (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.gmail.com with ESMTPSA id c8sm287871lfc.46.2020.06.17.16.41.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 16:41:01 -0700 (PDT)
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
Subject: [PATCH v3 1/3] drm/tegra: plane: Rename bottom_up to reflect_y
Date:   Thu, 18 Jun 2020 02:40:38 +0300
Message-Id: <20200617234040.1094-2-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200617234040.1094-1-digetx@gmail.com>
References: <20200617234040.1094-1-digetx@gmail.com>
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
index 04d6848d19fc..bb92c1ed44e9 100644
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

