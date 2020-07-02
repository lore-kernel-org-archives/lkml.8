Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E889BC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 07:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBEF520884
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 07:08:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbgGBHI2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 03:08:28 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7343 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726362AbgGBHI2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 03:08:28 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 843A99133502F6EBF772;
        Thu,  2 Jul 2020 15:08:25 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.487.0; Thu, 2 Jul 2020 15:08:17 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <puck.chen@hisilicon.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <tzimmermann@suse.de>, <kraxel@redhat.com>,
        <alexander.deucher@amd.com>, <tglx@linutronix.de>,
        <dri-devel@lists.freedesktop.org>, <xinliang.liu@linaro.org>,
        <linux-kernel@vger.kernel.org>
CC:     <linuxarm@huawei.com>
Subject: [PATCH v2] drm/hisilicon: Use drmm_kzalloc() instead of devm_kzalloc()
Date:   Thu, 2 Jul 2020 15:06:42 +0800
Message-ID: <1593673602-49027-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

using the new API drmm_kzalloc() instead of devm_kzalloc()

v2:
keep the DRM include statements sorted alphabetically.

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
index a6fd0c2..b557728 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
@@ -11,18 +11,18 @@
  *	Jianhua Li <lijianhua@huawei.com>
  */
 
+#include <drm/drm_gem_vram_helper.h>
+#include <drm/drm_atomic_helper.h>
+#include <drm/drm_probe_helper.h>
+#include <drm/drm_fb_helper.h>
+#include <drm/drm_managed.h>
+#include <drm/drm_vblank.h>
+#include <drm/drm_print.h>
 #include <linux/console.h>
 #include <linux/module.h>
-#include <linux/pci.h>
-
-#include <drm/drm_atomic_helper.h>
 #include <drm/drm_drv.h>
-#include <drm/drm_fb_helper.h>
-#include <drm/drm_gem_vram_helper.h>
 #include <drm/drm_irq.h>
-#include <drm/drm_print.h>
-#include <drm/drm_probe_helper.h>
-#include <drm/drm_vblank.h>
+#include <linux/pci.h>
 
 #include "hibmc_drm_drv.h"
 #include "hibmc_drm_regs.h"
@@ -267,7 +267,7 @@ static int hibmc_load(struct drm_device *dev)
 	struct hibmc_drm_private *priv;
 	int ret;
 
-	priv = devm_kzalloc(dev->dev, sizeof(*priv), GFP_KERNEL);
+	priv = drmm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv) {
 		DRM_ERROR("no memory to allocate for hibmc_drm_private\n");
 		return -ENOMEM;
-- 
2.7.4

