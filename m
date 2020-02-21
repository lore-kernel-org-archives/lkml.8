Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E70EFC35640
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 05:55:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C45FA20637
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 05:55:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbgBUFzx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 00:55:53 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:10230 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725800AbgBUFzx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 00:55:53 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id F3B5E120A2489A8B1745;
        Fri, 21 Feb 2020 13:55:48 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.439.0; Fri, 21 Feb 2020 13:55:43 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <puck.chen@hisilicon.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <tzimmermann@suse.de>, <kraxel@redhat.com>,
        <alexander.deucher@amd.com>, <tglx@linutronix.de>,
        <dri-devel@lists.freedesktop.org>, <xinliang.liu@linaro.org>,
        <linux-kernel@vger.kernel.org>
CC:     <linuxarm@huawei.com>
Subject: [PATCH] drm/hisilicon: Fixed pcie resource conflict using the general API
Date:   Fri, 21 Feb 2020 13:55:23 +0800
Message-ID: <1582264523-61170-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

the kernel provide the drm_fb_helper_remove_conflicting_pci_framebuffer
to remvoe the pcie resource conflict,there is no need to driver it again.

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
---
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c | 22 +++++-----------------
 1 file changed, 5 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
index 7ebe831..0f7dba7 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
@@ -47,22 +47,6 @@ static irqreturn_t hibmc_drm_interrupt(int irq, void *arg)
 	return IRQ_HANDLED;
 }
 
-static void hibmc_remove_framebuffers(struct pci_dev *pdev)
-{
-	struct apertures_struct *ap;
-
-	ap = alloc_apertures(1);
-	if (!ap)
-		return;
-
-	ap->ranges[0].base = pci_resource_start(pdev, 0);
-	ap->ranges[0].size = pci_resource_len(pdev, 0);
-
-	drm_fb_helper_remove_conflicting_framebuffers(ap, "hibmcdrmfb", false);
-
-	kfree(ap);
-}
-
 static struct drm_driver hibmc_driver = {
 	.driver_features	= DRIVER_GEM | DRIVER_MODESET | DRIVER_ATOMIC,
 	.fops			= &hibmc_fops,
@@ -343,7 +327,11 @@ static int hibmc_pci_probe(struct pci_dev *pdev,
 	struct drm_device *dev;
 	int ret;
 
-	hibmc_remove_framebuffers(pdev);
+	ret = drm_fb_helper_remove_conflicting_pci_framebuffers(pdev,
+								"hibmcdrmfb");
+	if (ret)
+		return ret;
+
 
 	dev = drm_dev_alloc(&hibmc_driver, &pdev->dev);
 	if (IS_ERR(dev)) {
-- 
2.7.4

