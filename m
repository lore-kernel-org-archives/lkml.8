Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CB99C2D0EC
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 02:50:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E97ED2082D
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 02:50:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgDKCu2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 22:50:28 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:13150 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726650AbgDKCu2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 22:50:28 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 2D05D414D6D0EC0728D2;
        Sat, 11 Apr 2020 10:50:25 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.487.0; Sat, 11 Apr 2020 10:50:17 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <puck.chen@hisilicon.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <tzimmermann@suse.de>, <kraxel@redhat.com>,
        <alexander.deucher@amd.com>, <tglx@linutronix.de>,
        <dri-devel@lists.freedesktop.org>, <xinliang.liu@linaro.org>,
        <linux-kernel@vger.kernel.org>
CC:     <linuxarm@huawei.com>
Subject: [PATCH] drm/hisilicon: Add the shutdown for hibmc_pci_driver
Date:   Sat, 11 Apr 2020 10:49:30 +0800
Message-ID: <1586573370-41945-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add the shutdown function to release the resource.

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
---
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
index a6fd0c2..126d4f4 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
@@ -232,6 +232,21 @@ static int hibmc_hw_map(struct hibmc_drm_private *priv)
 	return 0;
 }
 
+static void hibmc_hw_unmap(struct hibmc_drm_private *priv)
+{
+	struct drm_device *dev = priv->dev;
+
+	if (priv->mmio)	{
+		devm_iounmap(dev->dev, priv->mmio);
+		priv->mmio = NULL;
+	}
+
+	if (priv->fb_map) {
+		devm_iounmap(dev->dev, priv->fb_map);
+		priv->fb_map = NULL;
+	}
+}
+
 static int hibmc_hw_init(struct hibmc_drm_private *priv)
 {
 	int ret;
@@ -258,6 +273,7 @@ static int hibmc_unload(struct drm_device *dev)
 
 	hibmc_kms_fini(priv);
 	hibmc_mm_fini(priv);
+	hibmc_hw_unmap(priv);
 	dev->dev_private = NULL;
 	return 0;
 }
@@ -374,6 +390,12 @@ static void hibmc_pci_remove(struct pci_dev *pdev)
 	drm_dev_unregister(dev);
 	hibmc_unload(dev);
 	drm_dev_put(dev);
+	pci_disable_device(pdev);
+}
+
+static void hibmc_pci_shutdown(struct pci_dev *pdev)
+{
+	hibmc_pci_remove(pdev);
 }
 
 static struct pci_device_id hibmc_pci_table[] = {
@@ -386,6 +408,7 @@ static struct pci_driver hibmc_pci_driver = {
 	.id_table =	hibmc_pci_table,
 	.probe =	hibmc_pci_probe,
 	.remove =	hibmc_pci_remove,
+	.shutdown = hibmc_pci_shutdown,
 	.driver.pm =    &hibmc_pm_ops,
 };
 
-- 
2.7.4

