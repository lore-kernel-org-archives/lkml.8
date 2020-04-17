Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A087C2BB85
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 07:06:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B3ED221E9
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 07:06:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728677AbgDQHGf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 03:06:35 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2388 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728338AbgDQHGe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 03:06:34 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id CE01AEDE46B32705C65D;
        Fri, 17 Apr 2020 15:06:32 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.487.0; Fri, 17 Apr 2020
 15:06:22 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <eric@anholt.net>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <p.zabel@pengutronix.de>, <yanaijie@huawei.com>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC:     Hulk Robot <hulkci@huawei.com>
Subject: [PATCH] drm/v3d: remove unused 'v3d_v3d_pm_ops '
Date:   Fri, 17 Apr 2020 15:32:43 +0800
Message-ID: <20200417073243.40552-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following gcc warning:

drivers/gpu/drm/v3d/v3d_drv.c:73:32: warning: ‘v3d_v3d_pm_ops’ defined
but not used [-Wunused-const-variable=]
 static const struct dev_pm_ops v3d_v3d_pm_ops = {
                                ^~~~~~~~~~~~~~

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/gpu/drm/v3d/v3d_drv.c | 36 -----------------------------------
 1 file changed, 36 deletions(-)

diff --git a/drivers/gpu/drm/v3d/v3d_drv.c b/drivers/gpu/drm/v3d/v3d_drv.c
index 8d0c0daaac81..63f09c55a970 100644
--- a/drivers/gpu/drm/v3d/v3d_drv.c
+++ b/drivers/gpu/drm/v3d/v3d_drv.c
@@ -38,42 +38,6 @@
 #define DRIVER_MINOR 0
 #define DRIVER_PATCHLEVEL 0
 
-#ifdef CONFIG_PM
-static int v3d_runtime_suspend(struct device *dev)
-{
-	struct drm_device *drm = dev_get_drvdata(dev);
-	struct v3d_dev *v3d = to_v3d_dev(drm);
-
-	v3d_irq_disable(v3d);
-
-	clk_disable_unprepare(v3d->clk);
-
-	return 0;
-}
-
-static int v3d_runtime_resume(struct device *dev)
-{
-	struct drm_device *drm = dev_get_drvdata(dev);
-	struct v3d_dev *v3d = to_v3d_dev(drm);
-	int ret;
-
-	ret = clk_prepare_enable(v3d->clk);
-	if (ret != 0)
-		return ret;
-
-	/* XXX: VPM base */
-
-	v3d_mmu_set_page_table(v3d);
-	v3d_irq_enable(v3d);
-
-	return 0;
-}
-#endif
-
-static const struct dev_pm_ops v3d_v3d_pm_ops = {
-	SET_RUNTIME_PM_OPS(v3d_runtime_suspend, v3d_runtime_resume, NULL)
-};
-
 static int v3d_get_param_ioctl(struct drm_device *dev, void *data,
 			       struct drm_file *file_priv)
 {
-- 
2.21.1

