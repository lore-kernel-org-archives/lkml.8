Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EC4EC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 12:56:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 032B62088E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 12:56:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729118AbgGBM4B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 08:56:01 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:43564 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728661AbgGBM4B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 08:56:01 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id B27037EA7A15A2B43017;
        Thu,  2 Jul 2020 20:55:59 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Thu, 2 Jul 2020 20:55:50 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <puck.chen@hisilicon.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <tzimmermann@suse.de>, <kraxel@redhat.com>,
        <alexander.deucher@amd.com>, <tglx@linutronix.de>,
        <dri-devel@lists.freedesktop.org>, <xinliang.liu@linaro.org>,
        <linux-kernel@vger.kernel.org>
CC:     <linuxarm@huawei.com>
Subject: [PATCH] drm/hisilicon: Fixed the warning: Assignment of 0/1 to bool variable
Date:   Thu, 2 Jul 2020 20:54:15 +0800
Message-ID: <1593694455-31268-1-git-send-email-tiantao6@hisilicon.com>
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

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
---
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
index 249c298..2fc0c97 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
@@ -294,12 +294,12 @@ static int hibmc_load(struct drm_device *dev)
 		goto err;
 	}
 
-	priv->msi_enabled = 0;
+	priv->msi_enabled = false;
 	ret = pci_enable_msi(dev->pdev);
 	if (ret) {
 		DRM_WARN("enabling MSI failed: %d\n", ret);
 	} else {
-		priv->msi_enabled = 1;
+		priv->msi_enabled = true;
 		ret = drm_irq_install(dev, dev->pdev->irq);
 		if (ret)
 			DRM_WARN("install irq failed: %d\n", ret);
-- 
2.7.4

