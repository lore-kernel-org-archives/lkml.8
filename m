Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBABDC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 15:31:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3AFB20732
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 15:31:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GCaW2vIs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729461AbgFVPbN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 11:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729155AbgFVPbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 11:31:12 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB431C061573
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 08:31:12 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id l63so8282488pge.12
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 08:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W7ixdH9XmCR/FGRBWjByQkDAMb4Q8iNrtrWXUPaU65E=;
        b=GCaW2vIs8IrqprYix18IRhF4GCZn+fvewA1HI3tj240Pvy5jWnECjwNMtHHB1x5egu
         rhNOAsJfnsQCNPXdT/l0XTf32ueyjcEd093oMY7/gqBRGas7eDy7Tb+yJ3woe7Nh1L2k
         BK59KeUXIf+/lckgrD2y2ZKa34XQvyzyntPkk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W7ixdH9XmCR/FGRBWjByQkDAMb4Q8iNrtrWXUPaU65E=;
        b=ua+j+ftpgXtDxcJvz5CTp63nRPw57bkjmXYxcEh2Lgulq1pm10KWMFYbk/smmvtsRt
         +NoEnbOlRYips/2og7wQvnKUxY+9/OoIYVo67/M1jWVOKT/IF8QSniQz2KM8K8xegcSb
         ys2Wc/+1Rkk9CJ6sA9ZGb4YySZYoSF6ElQA0GEM1Dhq+lgHBut4WiaYVRkF5R4kL1t/k
         1XXw04LLcqHV1MOdySNkYTu8t31A8Ajb+xxokkK96M4mD7gGazwwKG0UvSMCxlBngudn
         t5SMpKVcOzKTu3GB1uQDPGzq+MvMeEyXKSZcFAYfrt6KRiMxqFuu7dHDan/+MdjA+hf5
         CCmg==
X-Gm-Message-State: AOAM532k65oesTD7cq4uip0hrWOg+dkxUSy40YEfUCfLJrxKbuP81hBV
        M8hF/cSmZFqlck+KBpiP6U99rqrUOkc=
X-Google-Smtp-Source: ABdhPJyWELrsdwoWW5EjGH/mw6RztGq7UXdSlrI+wSZwEzbuiE+7gkSdERYqm6zry4UcsIZV7AV6aw==
X-Received: by 2002:a63:525a:: with SMTP id s26mr10961206pgl.155.1592839872030;
        Mon, 22 Jun 2020 08:31:12 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:b852:bd51:9305:4261])
        by smtp.gmail.com with ESMTPSA id e78sm14464926pfh.50.2020.06.22.08.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 08:31:11 -0700 (PDT)
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
Subject: [PATCH v3] drm/mediatek: check plane visibility in atomic_update
Date:   Mon, 22 Jun 2020 23:31:06 +0800
Message-Id: <20200622153106.112115-1-hsinyi@chromium.org>
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
Change-Id: Id5341d60ddfffc88a38d9db0caa089b2d6a1d29c
---
v3: Address comment
v2: Add fixes tag
---
 drivers/gpu/drm/mediatek/mtk_drm_plane.c | 25 ++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_plane.c b/drivers/gpu/drm/mediatek/mtk_drm_plane.c
index c2bd683a87c8..92141a19681b 100644
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
@@ -178,6 +188,11 @@ static void mtk_plane_atomic_update(struct drm_plane *plane,
 	if (!crtc || WARN_ON(!fb))
 		return;
 
+	if (!plane->state->visible) {
+		mtk_plane_atomic_disable(plane, old_state);
+		return;
+	}
+
 	gem = fb->obj[0];
 	mtk_gem = to_mtk_gem_obj(gem);
 	addr = mtk_gem->dma_addr;
@@ -200,16 +215,6 @@ static void mtk_plane_atomic_update(struct drm_plane *plane,
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

