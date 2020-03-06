Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD5F1C3F2CE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 03:43:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E07920848
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 03:43:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbgCFDns (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 22:43:48 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:11181 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726490AbgCFDnn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 22:43:43 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 8A50CF91B8D15A427E9D;
        Fri,  6 Mar 2020 11:43:40 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.439.0; Fri, 6 Mar 2020 11:43:33 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <puck.chen@hisilicon.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <tzimmermann@suse.de>, <kraxel@redhat.com>,
        <alexander.deucher@amd.com>, <tglx@linutronix.de>,
        <dri-devel@lists.freedesktop.org>, <xinliang.liu@linaro.org>,
        <linux-kernel@vger.kernel.org>
CC:     <linuxarm@huawei.com>
Subject: [PATCH 2/4] drm/hisilicon: Code cleanup for hibmc_drv_vdac
Date:   Fri, 6 Mar 2020 11:43:02 +0800
Message-ID: <1583466184-7060-5-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1583466184-7060-1-git-send-email-tiantao6@hisilicon.com>
References: <1583466184-7060-1-git-send-email-tiantao6@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

code cleanup for hibmc_drv_vdac.c, no actual function changes.

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
Signed-off-by: Gong junjie <gongjunjie2@huawei.com>
---
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c | 49 ++++++++----------------
 1 file changed, 16 insertions(+), 33 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c
index 678ac2e..f0e6bb8 100644
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
@@ -109,13 +83,6 @@ int hibmc_vdac_init(struct hibmc_drm_private *priv)
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
 	if (!encoder) {
 		DRM_ERROR("failed to alloc memory when init encoder\n");
@@ -131,6 +98,22 @@ int hibmc_vdac_init(struct hibmc_drm_private *priv)
 	}
 
 	drm_encoder_helper_add(encoder, &hibmc_encoder_helper_funcs);
+	connector = devm_kzalloc(dev->dev, sizeof(*connector), GFP_KERNEL);
+	if (!connector) {
+		DRM_ERROR("failed to alloc memory when init connector\n");
+		return -ENOMEM;
+	}
+
+	ret = drm_connector_init(dev, connector,
+				 &hibmc_connector_funcs,
+				 DRM_MODE_CONNECTOR_VGA);
+	if (ret) {
+		DRM_ERROR("failed to init connector: %d\n", ret);
+		return ret;
+	}
+
+	drm_connector_helper_add(connector, &hibmc_connector_helper_funcs);
+	drm_connector_register(connector);
 	drm_connector_attach_encoder(connector, encoder);
 
 	return 0;
-- 
2.7.4

