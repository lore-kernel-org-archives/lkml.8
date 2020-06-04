Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 907E1C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 12:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C7772063A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 12:55:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727921AbgFDMzW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 08:55:22 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5786 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726003AbgFDMzW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 08:55:22 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id AC2FA10A86605A74B66A;
        Thu,  4 Jun 2020 20:55:18 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Thu, 4 Jun 2020
 20:55:11 +0800
From:   yu kuai <yukuai3@huawei.com>
To:     <linux@armlinux.org.uk>, <shawnguo@kernel.org>,
        <s.hauer@pengutronix.de>, <kernel@pengutronix.de>,
        <festevam@gmail.com>, <linux-imx@nxp.com>, <Anson.Huang@nxp.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>
Subject: [PATCH] ARM: imx6: add missing put_device() call in imx6q_suspend_init()
Date:   Thu, 4 Jun 2020 20:54:49 +0800
Message-ID: <20200604125449.3917164-1-yukuai3@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

if of_find_device_by_node() succeed, imx6q_suspend_init() doesn't have a
corresponding put_device(). Thus add a jump target to fix the exception
handling for this function implementation.

Signed-off-by: yu kuai <yukuai3@huawei.com>
---
 arch/arm/mach-imx/pm-imx6.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-imx/pm-imx6.c b/arch/arm/mach-imx/pm-imx6.c
index dd34dff13762..40c74b4c4d73 100644
--- a/arch/arm/mach-imx/pm-imx6.c
+++ b/arch/arm/mach-imx/pm-imx6.c
@@ -493,14 +493,14 @@ static int __init imx6q_suspend_init(const struct imx6_pm_socdata *socdata)
 	if (!ocram_pool) {
 		pr_warn("%s: ocram pool unavailable!\n", __func__);
 		ret = -ENODEV;
-		goto put_node;
+		goto put_device;
 	}
 
 	ocram_base = gen_pool_alloc(ocram_pool, MX6Q_SUSPEND_OCRAM_SIZE);
 	if (!ocram_base) {
 		pr_warn("%s: unable to alloc ocram!\n", __func__);
 		ret = -ENOMEM;
-		goto put_node;
+		goto put_device;
 	}
 
 	ocram_pbase = gen_pool_virt_to_phys(ocram_pool, ocram_base);
@@ -523,7 +523,7 @@ static int __init imx6q_suspend_init(const struct imx6_pm_socdata *socdata)
 	ret = imx6_pm_get_base(&pm_info->mmdc_base, socdata->mmdc_compat);
 	if (ret) {
 		pr_warn("%s: failed to get mmdc base %d!\n", __func__, ret);
-		goto put_node;
+		goto put_device;
 	}
 
 	ret = imx6_pm_get_base(&pm_info->src_base, socdata->src_compat);
@@ -570,7 +570,7 @@ static int __init imx6q_suspend_init(const struct imx6_pm_socdata *socdata)
 		&imx6_suspend,
 		MX6Q_SUSPEND_OCRAM_SIZE - sizeof(*pm_info));
 
-	goto put_node;
+	goto put_device;
 
 pl310_cache_map_failed:
 	iounmap(pm_info->gpc_base.vbase);
@@ -580,6 +580,8 @@ static int __init imx6q_suspend_init(const struct imx6_pm_socdata *socdata)
 	iounmap(pm_info->src_base.vbase);
 src_map_failed:
 	iounmap(pm_info->mmdc_base.vbase);
+put_device:
+	put_device(&pdev->dev);
 put_node:
 	of_node_put(node);
 
-- 
2.25.4

