Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0598C433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 18:50:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDF2E21835
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 18:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594752607;
	bh=DuP8lxtR7cMel6KrJOFaubAILbH4Zwjad03QHuumfco=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZttP/JCWgdGKmLLAWgmBoObJOFShW4EZXXKkAHKPJXqsh4i/UCy/IwugaYNzdgI0h
	 hzrcEr3K9WWgl6dwve7PmNU8obTN+qoCsJTfLxytqPu5Px/tM16MpykG6dGNrVIPWJ
	 fioNltvtjS2w5KvzsgTIazTX/PKUdbTdNSBoBnj4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730266AbgGNSuG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 14:50:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:46070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730256AbgGNSuE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 14:50:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D9FF22AAA;
        Tue, 14 Jul 2020 18:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594752603;
        bh=DuP8lxtR7cMel6KrJOFaubAILbH4Zwjad03QHuumfco=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P0T6LIuIwr2pzoE9b8SO69gIjmb0F2TaG++6022CxeIgLOuEF22chjuNw6Otnf5ef
         icMXnoTFtYqwcPnlmr3U922IBTW4hjsb/8RFHa6KOz9FhFi6NpKND5iyMfnJ4b13WF
         0zANZIcXI+sangk6wYbW83bECDX1bE0Ja7VdwtsU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hsin-Yi Wang <hsinyi@chromium.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 039/109] drm/mediatek: Check plane visibility in atomic_update
Date:   Tue, 14 Jul 2020 20:43:42 +0200
Message-Id: <20200714184107.392673396@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200714184105.507384017@linuxfoundation.org>
References: <20200714184105.507384017@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hsin-Yi Wang <hsinyi@chromium.org>

[ Upstream commit c0b8892e2461b5fa740e47efbb1269a487b04020 ]

Disable the plane if it's not visible. Otherwise mtk_ovl_layer_config()
would proceed with invalid plane and we may see vblank timeout.

Fixes: 119f5173628a ("drm/mediatek: Add DRM Driver for Mediatek SoC MT8173.")
Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
Reviewed-by: Tomasz Figa <tfiga@chromium.org>
Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/mediatek/mtk_drm_plane.c | 25 ++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_plane.c b/drivers/gpu/drm/mediatek/mtk_drm_plane.c
index 584a9ecadce62..b7592b16ea940 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_plane.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_plane.c
@@ -101,6 +101,16 @@ static int mtk_plane_atomic_check(struct drm_plane *plane,
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
@@ -115,6 +125,11 @@ static void mtk_plane_atomic_update(struct drm_plane *plane,
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
@@ -136,16 +151,6 @@ static void mtk_plane_atomic_update(struct drm_plane *plane,
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
2.25.1



