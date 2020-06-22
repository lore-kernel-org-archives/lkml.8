Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94230C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 15:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7193F2070E
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 15:01:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gE/TTU+D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729483AbgFVPBS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 11:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729065AbgFVPBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 11:01:17 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B466BC061573
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 08:01:17 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id h95so8747207pje.4
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 08:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dZVD0oXPQ4Vgqd6246WLtuLGZy0JHZAVsnDaKWilj8U=;
        b=gE/TTU+DUc4/SwYXVs8HGxNbuuc+CfEim7+eHmeeIy3ghku8uXPB1lkSAAzBCmPLQK
         XuhmUzZLXhLDipNrHe9+UaHN79UyS5wk/bsHSwDNG1yZwF9mw6DjhqAwCXZBe0yEtMhy
         j4S5loJiHU72q1+yCqJ/1G1e+KOQdWh4bTlpY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dZVD0oXPQ4Vgqd6246WLtuLGZy0JHZAVsnDaKWilj8U=;
        b=Tsbh9gyQRYm2c8qS60uVpDiRSViQuJTAK1R+EKTkHQwbzQnayX7uQ/Ed9/29i1s07K
         wC/MHx1SMTnnVLO0SIkkZ7nYn211RWVb72IUCrjoqVcuVAxo+pHX6BEaxGY54Icim7Hf
         nb5haBSk4UMmWy5pkdwRZWYthye5iMv/5dCFjADNoBZ8yoWw1VsPMFu0D3OlrEBlD2+/
         Sz5YQWuGkX5hTm+Teq/D8A0afud4c7oBe05xnS7lxjV8pxAFZtwQbytRj3P4PU+6dblo
         h6OjhogbaH8+wBBzKINioIlPB/4lMnbfDGfLpkqhODjlEc+o9zNUUzoHTY1LokPjwLlW
         6kqw==
X-Gm-Message-State: AOAM531T/15mE4SCFVKLqQLpsxYGa3plOzyuS7Q188tqVvXLgLMCX5WC
        AXjSbNV7R7krNaSIDLPeZ3KHbA==
X-Google-Smtp-Source: ABdhPJx4uZC5fXg6XELfgCrKxRoKDGalQWvOZ7PrYOynWWRBfztarOhfdQkY30e4WtakXs5VctClyg==
X-Received: by 2002:a17:90a:2c48:: with SMTP id p8mr19049280pjm.189.1592838077126;
        Mon, 22 Jun 2020 08:01:17 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:b852:bd51:9305:4261])
        by smtp.gmail.com with ESMTPSA id h9sm14465808pfe.32.2020.06.22.08.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 08:01:16 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     linux-arm-kernel@lists.infradead.org,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        yongqiang.niu@mediatek.com, tfiga@chromium.org
Subject: [PATCH v2] drm/mediatek: check plane visibility in atomic_update
Date:   Mon, 22 Jun 2020 23:01:09 +0800
Message-Id: <20200622150109.91205-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.27.0.111.gc72c7da667-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Disable the plane if it's not visible. Otherwise mtk_ovl_layer_config()
would proceed with invalid plane and we may see vblank timeout.

Fixes: 119f5173628a ("drm/mediatek: Add DRM Driver for Mediatek SoC MT8173.")
Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
---
v2: Add fixes tag
---
 drivers/gpu/drm/mediatek/mtk_drm_plane.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_plane.c b/drivers/gpu/drm/mediatek/mtk_drm_plane.c
index c2bd683a87c8..74dc71c7f3b6 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_plane.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_plane.c
@@ -164,6 +164,16 @@ static int mtk_plane_atomic_check(struct drm_plane *plane,
 						   true, true);
 }
 
+static void mtk_plane_atomic_disable(struct drm_plane *plane,
+				     struct drm_plane_state *old_state)
+{
+	struct mtk_plane_state *state = to_mtk_plane_state(plane->state);
+
+	state->pending.enable = false;
+	wmb(); /* Make sure the above parameter is set before update */
+	state->pending.dirty = true;
+}
+
 static void mtk_plane_atomic_update(struct drm_plane *plane,
 				    struct drm_plane_state *old_state)
 {
@@ -178,6 +188,9 @@ static void mtk_plane_atomic_update(struct drm_plane *plane,
 	if (!crtc || WARN_ON(!fb))
 		return;
 
+	if (!plane->state->visible)
+		return mtk_plane_atomic_disable(plane, old_state);
+
 	gem = fb->obj[0];
 	mtk_gem = to_mtk_gem_obj(gem);
 	addr = mtk_gem->dma_addr;
@@ -200,16 +213,6 @@ static void mtk_plane_atomic_update(struct drm_plane *plane,
 	state->pending.dirty = true;
 }
 
-static void mtk_plane_atomic_disable(struct drm_plane *plane,
-				     struct drm_plane_state *old_state)
-{
-	struct mtk_plane_state *state = to_mtk_plane_state(plane->state);
-
-	state->pending.enable = false;
-	wmb(); /* Make sure the above parameter is set before update */
-	state->pending.dirty = true;
-}
-
 static const struct drm_plane_helper_funcs mtk_plane_helper_funcs = {
 	.prepare_fb = drm_gem_fb_prepare_fb,
 	.atomic_check = mtk_plane_atomic_check,
-- 
2.27.0.111.gc72c7da667-goog

