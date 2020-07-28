Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B3CC433EC
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 12:57:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 742A72070B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 12:57:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729771AbgG1M5I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 08:57:08 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:8844 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729622AbgG1M5H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 08:57:07 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 84C4B6635318109F9F2B;
        Tue, 28 Jul 2020 20:57:04 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Tue, 28 Jul 2020 20:56:59 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <airlied@linux.ie>, <daniel@ffwll.ch>, <tzimmermann@suse.de>,
        <kraxel@redhat.com>, <alexander.deucher@amd.com>,
        <tglx@linutronix.de>, <dri-devel@lists.freedesktop.org>,
        <xinliang.liu@linaro.org>, <linux-kernel@vger.kernel.org>
CC:     <linuxarm@huawei.com>
Subject: [PATCH v3] drm/hisilicon: Fixed the warning: Assignment of 0/1 to bool variable
Date:   Tue, 28 Jul 2020 20:55:07 +0800
Message-ID: <1595940907-17874-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fixed the following warning:
hibmc_drm_drv.c:296:1-18:WARNING: Assignment of 0/1 to bool variable.
hibmc_drm_drv.c:301:2-19: WARNING: Assignment of 0/1 to bool variable.

v2:
using the pci_dev.msi_enabled instead of priv->msi_enabled.

v3:
just call pci_enable_msi() and pci_disable_msi(), it's no need to
set dev->pdev->msi_enabled again.

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
---
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c | 5 +----
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h | 1 -
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
index 249c298..b8d839a 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
@@ -254,9 +254,8 @@ static int hibmc_unload(struct drm_device *dev)
 
 	if (dev->irq_enabled)
 		drm_irq_uninstall(dev);
-	if (priv->msi_enabled)
-		pci_disable_msi(dev->pdev);
 
+	pci_disable_msi(dev->pdev);
 	hibmc_kms_fini(priv);
 	hibmc_mm_fini(priv);
 	dev->dev_private = NULL;
@@ -294,12 +293,10 @@ static int hibmc_load(struct drm_device *dev)
 		goto err;
 	}
 
-	priv->msi_enabled = 0;
 	ret = pci_enable_msi(dev->pdev);
 	if (ret) {
 		DRM_WARN("enabling MSI failed: %d\n", ret);
 	} else {
-		priv->msi_enabled = 1;
 		ret = drm_irq_install(dev, dev->pdev->irq);
 		if (ret)
 			DRM_WARN("install irq failed: %d\n", ret);
diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
index 6097687..a683763 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
@@ -25,7 +25,6 @@ struct hibmc_drm_private {
 	void __iomem   *fb_map;
 	unsigned long  fb_base;
 	unsigned long  fb_size;
-	bool msi_enabled;
 
 	/* drm */
 	struct drm_device  *dev;
-- 
2.7.4

