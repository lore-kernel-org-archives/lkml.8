Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FAAAC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 00:40:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED11720738
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 00:40:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727968AbgHCAkp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Aug 2020 20:40:45 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:9313 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726257AbgHCAko (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Aug 2020 20:40:44 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id BD4E0F42E83C1676A573;
        Mon,  3 Aug 2020 08:40:38 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Mon, 3 Aug 2020 08:40:30 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <airlied@linux.ie>, <daniel@ffwll.ch>, <tzimmermann@suse.de>,
        <kraxel@redhat.com>, <alexander.deucher@amd.com>,
        <tglx@linutronix.de>, <dri-devel@lists.freedesktop.org>,
        <xinliang.liu@linaro.org>, <linux-kernel@vger.kernel.org>
CC:     <linuxarm@huawei.com>
Subject: [PATCH drm/hisilicon v2 2/3] drm/hisilicon: Code refactoring for hibmc_drv_de
Date:   Mon, 3 Aug 2020 08:38:33 +0800
Message-ID: <1596415114-21175-3-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1596415114-21175-1-git-send-email-tiantao6@hisilicon.com>
References: <1596415114-21175-1-git-send-email-tiantao6@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The memory used to be allocated with devres helpers and released
automatically. In rare circumstances, the memory's release could
have happened before the DRM device got released, which would have
caused memory corruption of some kind. Now we're embedding the data
structures in struct hibmc_drm_private. The whole release problem
has been resolved, because struct hibmc_drm_private is allocated
with drmm_kzalloc and always released with the DRM device.

v2:
edit commit message.

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
---
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c  | 55 ++++++-------------------
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h |  2 +
 2 files changed, 15 insertions(+), 42 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
index 66132eb..af24c72 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
@@ -157,37 +157,6 @@ static const struct drm_plane_helper_funcs hibmc_plane_helper_funcs = {
 	.atomic_update = hibmc_plane_atomic_update,
 };
 
-static struct drm_plane *hibmc_plane_init(struct hibmc_drm_private *priv)
-{
-	struct drm_device *dev = priv->dev;
-	struct drm_plane *plane;
-	int ret = 0;
-
-	plane = devm_kzalloc(dev->dev, sizeof(*plane), GFP_KERNEL);
-	if (!plane) {
-		DRM_ERROR("failed to alloc memory when init plane\n");
-		return ERR_PTR(-ENOMEM);
-	}
-	/*
-	 * plane init
-	 * TODO: Now only support primary plane, overlay planes
-	 * need to do.
-	 */
-	ret = drm_universal_plane_init(dev, plane, 1, &hibmc_plane_funcs,
-				       channel_formats1,
-				       ARRAY_SIZE(channel_formats1),
-				       NULL,
-				       DRM_PLANE_TYPE_PRIMARY,
-				       NULL);
-	if (ret) {
-		DRM_ERROR("failed to init plane: %d\n", ret);
-		return ERR_PTR(ret);
-	}
-
-	drm_plane_helper_add(plane, &hibmc_plane_helper_funcs);
-	return plane;
-}
-
 static void hibmc_crtc_dpms(struct drm_crtc *crtc, int dpms)
 {
 	struct hibmc_drm_private *priv = crtc->dev->dev_private;
@@ -534,22 +503,24 @@ static const struct drm_crtc_helper_funcs hibmc_crtc_helper_funcs = {
 int hibmc_de_init(struct hibmc_drm_private *priv)
 {
 	struct drm_device *dev = priv->dev;
-	struct drm_crtc *crtc;
-	struct drm_plane *plane;
+	struct drm_crtc *crtc = &priv->crtc;
+	struct drm_plane *plane = &priv->plane;
 	int ret;
 
-	plane = hibmc_plane_init(priv);
-	if (IS_ERR(plane)) {
-		DRM_ERROR("failed to create plane: %ld\n", PTR_ERR(plane));
-		return PTR_ERR(plane);
-	}
+	ret = drm_universal_plane_init(dev, plane, 1, &hibmc_plane_funcs,
+				       channel_formats1,
+				       ARRAY_SIZE(channel_formats1),
+				       NULL,
+				       DRM_PLANE_TYPE_PRIMARY,
+				       NULL);
 
-	crtc = devm_kzalloc(dev->dev, sizeof(*crtc), GFP_KERNEL);
-	if (!crtc) {
-		DRM_ERROR("failed to alloc memory when init crtc\n");
-		return -ENOMEM;
+	if (ret) {
+		DRM_ERROR("failed to init plane: %d\n", ret);
+		return ret;
 	}
 
+	drm_plane_helper_add(plane, &hibmc_plane_helper_funcs);
+
 	ret = drm_crtc_init_with_planes(dev, crtc, plane,
 					NULL, &hibmc_crtc_funcs, NULL);
 	if (ret) {
diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
index a683763..91ef15c 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
@@ -28,6 +28,8 @@ struct hibmc_drm_private {
 
 	/* drm */
 	struct drm_device  *dev;
+	struct drm_plane plane;
+	struct drm_crtc crtc;
 	struct drm_encoder encoder;
 	struct drm_connector connector;
 	bool mode_config_initialized;
-- 
2.7.4

