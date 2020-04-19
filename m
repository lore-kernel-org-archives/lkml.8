Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD0BAC38A29
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 09:17:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C5D121974
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 09:17:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726012AbgDSJRx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 05:17:53 -0400
Received: from cmccmta3.chinamobile.com ([221.176.66.81]:5123 "EHLO
        cmccmta3.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgDSJRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 05:17:53 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.7]) by rmmx-syy-dmz-app12-12012 (RichMail) with SMTP id 2eec5e9c1732645-b9893; Sun, 19 Apr 2020 17:17:38 +0800 (CST)
X-RM-TRANSID: 2eec5e9c1732645-b9893
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[112.1.172.61])
        by rmsmtp-syy-appsvr04-12004 (RichMail) with SMTP id 2ee45e9c172fdbc-c19ef;
        Sun, 19 Apr 2020 17:17:37 +0800 (CST)
X-RM-TRANSID: 2ee45e9c172fdbc-c19ef
From:   Tang Bin <tangbin@cmss.chinamobile.com>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>,
        Shengju Zhang <zhangshengju@cmss.chinamobile.com>
Subject: [PATCH] mfd: asic3: Add error checking return in asic3_mfd_probe()
Date:   Sun, 19 Apr 2020 17:19:23 +0800
Message-Id: <20200419091923.5728-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the function asic3_mfd_probe(), when get resource or irq
failed, the value returned just detected and debug error message,
but there were no error checking return. So add the right error
checking return. And remove the redundant 'ret = 0'.

Signed-off-by: Shengju Zhang <zhangshengju@cmss.chinamobile.com>
Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
 drivers/mfd/asic3.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/asic3.c b/drivers/mfd/asic3.c
index 7694de3f1..827449b7a 100644
--- a/drivers/mfd/asic3.c
+++ b/drivers/mfd/asic3.c
@@ -881,12 +881,18 @@ static int __init asic3_mfd_probe(struct platform_device *pdev,
 	int irq, ret;
 
 	mem_sdio = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	if (!mem_sdio)
+	if (!mem_sdio) {
 		dev_dbg(asic->dev, "no SDIO MEM resource\n");
+		ret = -EINVAL;
+		goto out;
+	}
 
 	irq = platform_get_irq(pdev, 1);
-	if (irq < 0)
+	if (irq < 0) {
 		dev_dbg(asic->dev, "no SDIO IRQ resource\n");
+		ret = irq;
+		goto out;
+	}
 
 	/* DS1WM */
 	asic3_set_register(asic, ASIC3_OFFSET(EXTCF, SELECT),
@@ -924,7 +930,6 @@ static int __init asic3_mfd_probe(struct platform_device *pdev,
 			goto out;
 	}
 
-	ret = 0;
 	if (pdata->leds) {
 		int i;
 
-- 
2.20.1.windows.1



