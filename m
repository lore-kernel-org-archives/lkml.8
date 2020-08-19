Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8BE0C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 09:25:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1E0720639
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 09:25:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbgHSJZ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 05:25:59 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:9772 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727068AbgHSJZu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 05:25:50 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id DD9CC1EE5B223832F4C5;
        Wed, 19 Aug 2020 17:25:47 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.487.0; Wed, 19 Aug 2020 17:25:40 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <airlied@linux.ie>, <daniel@ffwll.ch>, <tzimmermann@suse.de>,
        <kraxel@redhat.com>, <alexander.deucher@amd.com>,
        <tglx@linutronix.de>, <dri-devel@lists.freedesktop.org>,
        <xinliang.liu@linaro.org>, <linux-kernel@vger.kernel.org>
CC:     <linuxarm@huawei.com>
Subject: [PATCH drm/hisilicon v2 4/4] drm/hisilicon: Use drm_err instead of DRM_ERROR in hibmc_drm_drv
Date:   Wed, 19 Aug 2020 17:23:34 +0800
Message-ID: <1597829014-39942-5-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1597829014-39942-1-git-send-email-tiantao6@hisilicon.com>
References: <1597829014-39942-1-git-send-email-tiantao6@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use drm_err instead of DRM_ERROR in hibmc_drm_drv

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
---
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
index 2b4f821..085d1b2 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
@@ -98,13 +98,13 @@ static int hibmc_kms_init(struct hibmc_drm_private *priv)
 
 	ret = hibmc_de_init(priv);
 	if (ret) {
-		DRM_ERROR("failed to init de: %d\n", ret);
+		drm_err(priv->dev, "failed to init de: %d\n", ret);
 		return ret;
 	}
 
 	ret = hibmc_vdac_init(priv);
 	if (ret) {
-		DRM_ERROR("failed to init vdac: %d\n", ret);
+		drm_err(priv->dev, "failed to init vdac: %d\n", ret);
 		return ret;
 	}
 
@@ -212,7 +212,7 @@ static int hibmc_hw_map(struct hibmc_drm_private *priv)
 	iosize = pci_resource_len(pdev, 1);
 	priv->mmio = devm_ioremap(dev->dev, ioaddr, iosize);
 	if (!priv->mmio) {
-		DRM_ERROR("Cannot map mmio region\n");
+		drm_err(dev, "Cannot map mmio region\n");
 		return -ENOMEM;
 	}
 
@@ -220,7 +220,7 @@ static int hibmc_hw_map(struct hibmc_drm_private *priv)
 	size = pci_resource_len(pdev, 0);
 	priv->fb_map = devm_ioremap(dev->dev, addr, size);
 	if (!priv->fb_map) {
-		DRM_ERROR("Cannot map framebuffer\n");
+		drm_err(dev, "Cannot map framebuffer\n");
 		return -ENOMEM;
 	}
 	priv->fb_base = addr;
@@ -265,7 +265,7 @@ static int hibmc_load(struct drm_device *dev)
 
 	priv = drmm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv) {
-		DRM_ERROR("no memory to allocate for hibmc_drm_private\n");
+		drm_err(dev, "no memory to allocate for hibmc_drm_private\n");
 		return -ENOMEM;
 	}
 	dev->dev_private = priv;
@@ -285,17 +285,17 @@ static int hibmc_load(struct drm_device *dev)
 
 	ret = drm_vblank_init(dev, dev->mode_config.num_crtc);
 	if (ret) {
-		DRM_ERROR("failed to initialize vblank: %d\n", ret);
+		drm_err(dev, "failed to initialize vblank: %d\n", ret);
 		goto err;
 	}
 
 	ret = pci_enable_msi(dev->pdev);
 	if (ret) {
-		DRM_WARN("enabling MSI failed: %d\n", ret);
+		drm_warn(dev, "enabling MSI failed: %d\n", ret);
 	} else {
 		ret = drm_irq_install(dev, dev->pdev->irq);
 		if (ret)
-			DRM_WARN("install irq failed: %d\n", ret);
+			drm_warn(dev, "install irq failed: %d\n", ret);
 	}
 
 	/* reset all the states of crtc/plane/encoder/connector */
@@ -305,7 +305,7 @@ static int hibmc_load(struct drm_device *dev)
 
 err:
 	hibmc_unload(dev);
-	DRM_ERROR("failed to initialize drm driver: %d\n", ret);
+	drm_err(dev, "failed to initialize drm driver: %d\n", ret);
 	return ret;
 }
 
@@ -331,19 +331,19 @@ static int hibmc_pci_probe(struct pci_dev *pdev,
 
 	ret = pci_enable_device(pdev);
 	if (ret) {
-		DRM_ERROR("failed to enable pci device: %d\n", ret);
+		drm_err(dev, "failed to enable pci device: %d\n", ret);
 		goto err_free;
 	}
 
 	ret = hibmc_load(dev);
 	if (ret) {
-		DRM_ERROR("failed to load hibmc: %d\n", ret);
+		drm_err(dev, "failed to load hibmc: %d\n", ret);
 		goto err_disable;
 	}
 
 	ret = drm_dev_register(dev, 0);
 	if (ret) {
-		DRM_ERROR("failed to register drv for userspace access: %d\n",
+		drm_err(dev, "failed to register drv for userspace access: %d\n",
 			  ret);
 		goto err_unload;
 	}
-- 
2.7.4

