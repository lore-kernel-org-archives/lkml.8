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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C847C433E3
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 19:04:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55C0B2071A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 19:04:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ACmbn+5L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbgFNTES (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jun 2020 15:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbgFNTEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jun 2020 15:04:11 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E024C08C5C2;
        Sun, 14 Jun 2020 12:04:11 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id 9so16558642ljv.5;
        Sun, 14 Jun 2020 12:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1tlVNSxgPSIVY7njRp82EoP3y9oei5GEhi6LB4YQ4wY=;
        b=ACmbn+5LXY4ZgSyB5eD2v8bAUH7BhdjMukZJxujxn21BKNuQCWiZ6pskW4u3Tm5yr0
         tDiPjS6qceDlCgDUbJgscgg2oTd5+P+OKeH6aTet8up1loIk7GrZbca3gwLO6ZWhtC6k
         9DBOA9ckjUqT0Hw5EeYNOvsiUYVNxxeWEPZ9ycUTi8JEGh9wjMhDi5c7Sz53SMGozPTz
         7ObH4sMO3A2aHTAMMmPDsjHZZ/kqv8nbR5PqpesorGkwfOGlhTZchvKwB+EtvAGaMEm2
         SNmyqRbk4oasOKl1C6l2Aefo6oBLjDcj19++pAZE3rLyK1NK1BN6ZOUpXqoF3Zvq7Z0e
         s5sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1tlVNSxgPSIVY7njRp82EoP3y9oei5GEhi6LB4YQ4wY=;
        b=nNfKASHXZem8VEr+sdrUVYV7zFcHNLgeQX9hcU8rtNzNe1ZCum3EB49MA33T3tyCiJ
         giGHptgFX2AGszWQ6GbLUg/jNntgCR50igXlxrpGYtF27/I+iCQJuc0JUYpZNmGi9eRl
         0192mMX1jQQNgtflQ7AbS6SjcgJ/Ikn51k4BvmBVhwiFjYfU/GmUkOPXC7Yv3jenHawt
         OJUhU7hhj/ldrUqvdg7SwoXTJDQUEZtLyzOEIBDaZPEfhVwtyCtNU0TT3NVhUD3N9t4n
         g+7E8sdhGdzl3RKJUOZSH+od5IJQP2OgRlXJLev+fp2NXZN0B8la8DT3jRoHyeFzAAyD
         FzAA==
X-Gm-Message-State: AOAM531xStREwjr+pKl0GFdUKbLy0APtkPq1sWxtYVzFfGh7SEN2+i+a
        CWHBD0tw3T8QmPZBp17lUbM=
X-Google-Smtp-Source: ABdhPJxQT3G2mCw18H746uY1ijS4rGlw8gNoDzHcB1Pz3EhK7VWgAyWf/terviKuL7YatcalbXOC6Q==
X-Received: by 2002:a2e:6c12:: with SMTP id h18mr11938124ljc.62.1592161449972;
        Sun, 14 Jun 2020 12:04:09 -0700 (PDT)
Received: from localhost.localdomain (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.gmail.com with ESMTPSA id p15sm3410856ljn.53.2020.06.14.12.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2020 12:04:09 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Derek Basehore <dbasehore@chromium.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sean Paul <sean@poorly.run>
Cc:     dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 6/6] =?UTF-8?q?drm/tegra:=20plane:=20Support=20180?= =?UTF-8?q?=C2=B0=20rotation?=
Date:   Sun, 14 Jun 2020 22:03:48 +0300
Message-Id: <20200614190348.12193-7-digetx@gmail.com>
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

Combining horizontal and vertical reflections gives us 180 degrees of
rotation.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/gpu/drm/tegra/dc.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tegra/dc.c b/drivers/gpu/drm/tegra/dc.c
index f31bca27cde4..ddd9b88f8fce 100644
--- a/drivers/gpu/drm/tegra/dc.c
+++ b/drivers/gpu/drm/tegra/dc.c
@@ -608,6 +608,7 @@ static int tegra_plane_atomic_check(struct drm_plane *plane,
 {
 	struct tegra_plane_state *plane_state = to_tegra_plane_state(state);
 	unsigned int rotation = DRM_MODE_ROTATE_0 |
+				DRM_MODE_ROTATE_180 |
 				DRM_MODE_REFLECT_X |
 				DRM_MODE_REFLECT_Y;
 	struct tegra_bo_tiling *tiling = &plane_state->tiling;
@@ -659,6 +660,14 @@ static int tegra_plane_atomic_check(struct drm_plane *plane,
 	else
 		plane_state->reflect_y = false;
 
+	if (tegra_fb_is_bottom_up(state->fb))
+		plane_state->reflect_y = true;
+
+	if (rotation & DRM_MODE_ROTATE_180) {
+		plane_state->reflect_x = !plane_state->reflect_x;
+		plane_state->reflect_y = !plane_state->reflect_y;
+	}
+
 	/*
 	 * Tegra doesn't support different strides for U and V planes so we
 	 * error out if the user tries to display a framebuffer with such a
@@ -720,7 +729,7 @@ static void tegra_plane_atomic_update(struct drm_plane *plane,
 	window.dst.h = drm_rect_height(&plane->state->dst);
 	window.bits_per_pixel = fb->format->cpp[0] * 8;
 	window.reflect_x = state->reflect_x;
-	window.reflect_y = tegra_fb_is_bottom_up(fb) || state->reflect_y;
+	window.reflect_y = state->reflect_y;
 
 	/* copy from state */
 	window.zpos = plane->state->normalized_zpos;
@@ -806,6 +815,7 @@ static struct drm_plane *tegra_primary_plane_create(struct drm_device *drm,
 	err = drm_plane_create_rotation_property(&plane->base,
 						 DRM_MODE_ROTATE_0,
 						 DRM_MODE_ROTATE_0 |
+						 DRM_MODE_ROTATE_180 |
 						 DRM_MODE_REFLECT_X |
 						 DRM_MODE_REFLECT_Y);
 	if (err < 0)
@@ -1094,6 +1104,7 @@ static struct drm_plane *tegra_dc_overlay_plane_create(struct drm_device *drm,
 	err = drm_plane_create_rotation_property(&plane->base,
 						 DRM_MODE_ROTATE_0,
 						 DRM_MODE_ROTATE_0 |
+						 DRM_MODE_ROTATE_180 |
 						 DRM_MODE_REFLECT_X |
 						 DRM_MODE_REFLECT_Y);
 	if (err < 0)
-- 
2.26.0

