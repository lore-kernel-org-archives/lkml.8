Return-Path: <SRS0=j177=6Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEEF8C38A2A
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 13:04:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB4F32082E
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 13:04:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729022AbgEJNEH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 09:04:07 -0400
Received: from smtp01.smtpout.orange.fr ([80.12.242.123]:24834 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728743AbgEJNEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 09:04:07 -0400
Received: from localhost.localdomain ([93.23.13.120])
        by mwinf5d53 with ME
        id d13z2200A2bQer90313z03; Sun, 10 May 2020 15:04:05 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 10 May 2020 15:04:05 +0200
X-ME-IP: 93.23.13.120
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     michal.simek@xilinx.com, rajan.vaja@xilinx.com,
        jolly.shah@xilinx.com, gregkh@linuxfoundation.org,
        tejas.patel@xilinx.com, manish.narani@xilinx.com,
        ravi.patel@xilinx.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] firmware: xilinx: Fix an error handling path in 'zynqmp_firmware_probe()'
Date:   Sun, 10 May 2020 15:03:57 +0200
Message-Id: <20200510130357.233364-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If 'mfd_add_devices()' fails, we must undo 'zynqmp_pm_api_debugfs_init()'
otherwise some debugfs directory and files will be left.

Just move the call to 'zynqmp_pm_api_debugfs_init()' a few lines below to
fix the issue.

Fixes: e23d9c6d0d49 ("drivers: soc: xilinx: Add ZynqMP power domain driver")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Not related to this fix, but I think that:
   - a call to 'of_platform_depopulate()' is missing in the remove function
   - we shouldn't return of_platform_populate(); directly because we
     don't have the opportunity to call 'mfd_remove_devices()' as done in
     the remove function, and 'of_platform_depopulate()' for what have
     been populated yet

I'm not familiar with this API, so I just point it out to get feedback.
---
 drivers/firmware/xilinx/zynqmp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 8095fa84d5d7..8d1ff2454e2e 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -1235,8 +1235,6 @@ static int zynqmp_firmware_probe(struct platform_device *pdev)
 	pr_info("%s Trustzone version v%d.%d\n", __func__,
 		pm_tz_version >> 16, pm_tz_version & 0xFFFF);
 
-	zynqmp_pm_api_debugfs_init();
-
 	ret = mfd_add_devices(&pdev->dev, PLATFORM_DEVID_NONE, firmware_devs,
 			      ARRAY_SIZE(firmware_devs), NULL, 0, NULL);
 	if (ret) {
@@ -1244,6 +1242,8 @@ static int zynqmp_firmware_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	zynqmp_pm_api_debugfs_init();
+
 	return of_platform_populate(dev->of_node, NULL, NULL, dev);
 }
 
-- 
2.25.1

