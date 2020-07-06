Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68581C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 14:54:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40D0720715
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 14:54:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729425AbgGFOx7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 10:53:59 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7256 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729205AbgGFOx6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 10:53:58 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 57FE0F2D4B30F8383611;
        Mon,  6 Jul 2020 22:47:30 +0800 (CST)
Received: from DESKTOP-8RFUVS3.china.huawei.com (10.174.185.226) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.487.0; Mon, 6 Jul 2020 22:47:23 +0800
From:   Zenghui Yu <yuzenghui@huawei.com>
To:     <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC:     <xinliang.liu@linaro.org>, <zourongrong@gmail.com>,
        <john.stultz@linaro.org>, <kong.kongxinwei@hisilicon.com>,
        <puck.chen@hisilicon.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <tzimmermann@suse.de>, <sam@ravnborg.org>,
        <wanghaibin.wang@huawei.com>, Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH] drm/hisilicon/hibmc: Move drm_fbdev_generic_setup() down to avoid the splat
Date:   Mon, 6 Jul 2020 22:47:13 +0800
Message-ID: <20200706144713.1123-1-yuzenghui@huawei.com>
X-Mailer: git-send-email 2.23.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.185.226]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The HiSilicon hibmc driver triggers a splat at boot time as below

[   14.137806] ------------[ cut here ]------------
[   14.142405] hibmc-drm 0000:0a:00.0: Device has not been registered.
[   14.148661] WARNING: CPU: 0 PID: 496 at drivers/gpu/drm/drm_fb_helper.c:2233 drm_fbdev_generic_setup+0x15c/0x1b8
[   14.158787] [...]
[   14.278307] Call trace:
[   14.280742]  drm_fbdev_generic_setup+0x15c/0x1b8
[   14.285337]  hibmc_pci_probe+0x354/0x418
[   14.289242]  local_pci_probe+0x44/0x98
[   14.292974]  work_for_cpu_fn+0x20/0x30
[   14.296708]  process_one_work+0x1c4/0x4e0
[   14.300698]  worker_thread+0x2c8/0x528
[   14.304431]  kthread+0x138/0x140
[   14.307646]  ret_from_fork+0x10/0x18
[   14.311205] ---[ end trace a2000ec2d838af4d ]---

This turned out to be due to the fbdev device hasn't been registered when
drm_fbdev_generic_setup() is invoked. Let's fix the splat by moving it down
after drm_dev_register() which will follow the "Display driver example"
documented by commit de99f0600a79 ("drm/drv: DOC: Add driver example
code").

Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
---
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
index a6fd0c29e5b8..544b9993c99e 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
@@ -307,8 +307,6 @@ static int hibmc_load(struct drm_device *dev)
 	/* reset all the states of crtc/plane/encoder/connector */
 	drm_mode_config_reset(dev);
 
-	drm_fbdev_generic_setup(dev, dev->mode_config.preferred_depth);
-
 	return 0;
 
 err:
@@ -355,6 +353,9 @@ static int hibmc_pci_probe(struct pci_dev *pdev,
 			  ret);
 		goto err_unload;
 	}
+
+	drm_fbdev_generic_setup(dev, dev->mode_config.preferred_depth);
+
 	return 0;
 
 err_unload:
-- 
2.19.1

