Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57697C2BA2B
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 06:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36CF120757
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 06:26:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725927AbgDKG0R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 02:26:17 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:36264 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725855AbgDKG0R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 02:26:17 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id A4E5B11C0BFD9F02F034;
        Sat, 11 Apr 2020 14:26:13 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Sat, 11 Apr 2020 14:26:04 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <puck.chen@hisilicon.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <tzimmermann@suse.de>, <kraxel@redhat.com>,
        <alexander.deucher@amd.com>, <tglx@linutronix.de>,
        <dri-devel@lists.freedesktop.org>, <xinliang.liu@linaro.org>,
        <linux-kernel@vger.kernel.org>
CC:     <linuxarm@huawei.com>
Subject: [PATCH v2] drm/hisilicon: Code refactoring for hibmc_drv_vdac
Date:   Sat, 11 Apr 2020 14:25:15 +0800
Message-ID: <1586586315-12764-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

code refactoring for hibmc_drv_vdac.c, no actual function changes.

v2:
remove the debug message.

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
Reviewed-by: Joe Perches <joe@perches.com>
---
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c | 50 +++++++-----------------
 1 file changed, 14 insertions(+), 36 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c
index 678ac2e..077b7996 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c
@@ -52,32 +52,6 @@ static const struct drm_connector_funcs hibmc_connector_funcs = {
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
 };
 
-static struct drm_connector *
-hibmc_connector_init(struct hibmc_drm_private *priv)
-{
-	struct drm_device *dev = priv->dev;
-	struct drm_connector *connector;
-	int ret;
-
-	connector = devm_kzalloc(dev->dev, sizeof(*connector), GFP_KERNEL);
-	if (!connector) {
-		DRM_ERROR("failed to alloc memory when init connector\n");
-		return ERR_PTR(-ENOMEM);
-	}
-
-	ret = drm_connector_init(dev, connector,
-				 &hibmc_connector_funcs,
-				 DRM_MODE_CONNECTOR_VGA);
-	if (ret) {
-		DRM_ERROR("failed to init connector: %d\n", ret);
-		return ERR_PTR(ret);
-	}
-	drm_connector_helper_add(connector,
-				 &hibmc_connector_helper_funcs);
-
-	return connector;
-}
-
 static void hibmc_encoder_mode_set(struct drm_encoder *encoder,
 				   struct drm_display_mode *mode,
 				   struct drm_display_mode *adj_mode)
@@ -109,18 +83,9 @@ int hibmc_vdac_init(struct hibmc_drm_private *priv)
 	struct drm_connector *connector;
 	int ret;
 
-	connector = hibmc_connector_init(priv);
-	if (IS_ERR(connector)) {
-		DRM_ERROR("failed to create connector: %ld\n",
-			  PTR_ERR(connector));
-		return PTR_ERR(connector);
-	}
-
 	encoder = devm_kzalloc(dev->dev, sizeof(*encoder), GFP_KERNEL);
-	if (!encoder) {
-		DRM_ERROR("failed to alloc memory when init encoder\n");
+	if (!encoder)
 		return -ENOMEM;
-	}
 
 	encoder->possible_crtcs = 0x1;
 	ret = drm_encoder_init(dev, encoder, &hibmc_encoder_funcs,
@@ -131,6 +96,19 @@ int hibmc_vdac_init(struct hibmc_drm_private *priv)
 	}
 
 	drm_encoder_helper_add(encoder, &hibmc_encoder_helper_funcs);
+
+	connector = devm_kzalloc(dev->dev, sizeof(*connector), GFP_KERNEL);
+	if (!connector)
+		return -ENOMEM;
+
+	ret = drm_connector_init(dev, connector, &hibmc_connector_funcs,
+				 DRM_MODE_CONNECTOR_VGA);
+	if (ret) {
+		DRM_ERROR("failed to init connector: %d\n", ret);
+		return ret;
+	}
+	drm_connector_helper_add(connector, &hibmc_connector_helper_funcs);
+
 	drm_connector_attach_encoder(connector, encoder);
 
 	return 0;
-- 
2.7.4

