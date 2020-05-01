Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F469C47257
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 15:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20D39216FD
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 15:24:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729519AbgEAPX7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 11:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729413AbgEAPX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 11:23:56 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B028C061A0C
        for <linux-kernel@vger.kernel.org>; Fri,  1 May 2020 08:23:56 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id D52482A3118
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org,
        Collabora Kernel ML <kernel@collabora.com>
Cc:     matthias.bgg@gmail.com, drinkcat@chromium.org, hsinyi@chromium.org,
        laurent.pinchart@ideasonboard.com, Sam Ravnborg <sam@ravnborg.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v4 5/7] drm/mediatek: mtk_dsi: Use simple encoder
Date:   Fri,  1 May 2020 17:23:33 +0200
Message-Id: <20200501152335.1805790-6-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200501152335.1805790-1-enric.balletbo@collabora.com>
References: <20200501152335.1805790-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mtk_dsi driver uses an empty implementation for its encoder. Replace
the code with the generic simple encoder.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Acked-by: Sam Ravnborg <sam@ravnborg.org>
Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
---

Changes in v4: None
Changes in v3: None
Changes in v2: None

 drivers/gpu/drm/mediatek/mtk_dsi.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
index 38cbdcb15fff..e02d16a086ac 100644
--- a/drivers/gpu/drm/mediatek/mtk_dsi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
@@ -22,6 +22,7 @@
 #include <drm/drm_panel.h>
 #include <drm/drm_print.h>
 #include <drm/drm_probe_helper.h>
+#include <drm/drm_simple_kms_helper.h>
 
 #include "mtk_drm_ddp_comp.h"
 
@@ -788,15 +789,6 @@ static void mtk_output_dsi_disable(struct mtk_dsi *dsi)
 	dsi->enabled = false;
 }
 
-static void mtk_dsi_encoder_destroy(struct drm_encoder *encoder)
-{
-	drm_encoder_cleanup(encoder);
-}
-
-static const struct drm_encoder_funcs mtk_dsi_encoder_funcs = {
-	.destroy = mtk_dsi_encoder_destroy,
-};
-
 static int mtk_dsi_create_conn_enc(struct drm_device *drm, struct mtk_dsi *dsi);
 static void mtk_dsi_destroy_conn_enc(struct mtk_dsi *dsi);
 
@@ -1126,8 +1118,8 @@ static int mtk_dsi_encoder_init(struct drm_device *drm, struct mtk_dsi *dsi)
 {
 	int ret;
 
-	ret = drm_encoder_init(drm, &dsi->encoder, &mtk_dsi_encoder_funcs,
-			       DRM_MODE_ENCODER_DSI, NULL);
+	ret = drm_simple_encoder_init(drm, &dsi->encoder,
+				      DRM_MODE_ENCODER_DSI);
 	if (ret) {
 		DRM_ERROR("Failed to encoder init to drm\n");
 		return ret;
-- 
2.26.2

