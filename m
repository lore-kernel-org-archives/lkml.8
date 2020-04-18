Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0A04C38A2B
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 08:02:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8ABD420857
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 08:02:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725892AbgDRIBk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 04:01:40 -0400
Received: from cmccmta3.chinamobile.com ([221.176.66.81]:10914 "EHLO
        cmccmta3.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725856AbgDRIBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 04:01:39 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.13]) by rmmx-syy-dmz-app09-12009 (RichMail) with SMTP id 2ee95e9ab3ce5d6-ab6a1; Sat, 18 Apr 2020 16:01:21 +0800 (CST)
X-RM-TRANSID: 2ee95e9ab3ce5d6-ab6a1
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[112.1.172.61])
        by rmsmtp-syy-appsvr07-12007 (RichMail) with SMTP id 2ee75e9ab3cff46-7159e;
        Sat, 18 Apr 2020 16:01:21 +0800 (CST)
X-RM-TRANSID: 2ee75e9ab3cff46-7159e
From:   Tang Bin <tangbin@cmss.chinamobile.com>
To:     minyard@acm.org, arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>,
        Shengju Zhang <zhangshengju@cmss.chinamobile.com>
Subject: [PATCH v2] ipmi:bt-bmc: Fix error handling and status check
Date:   Sat, 18 Apr 2020 16:02:29 +0800
Message-Id: <20200418080228.19028-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the function platform_get_irq() failed, the negative
value returned will not be detected here. So fix error
handling in bt_bmc_config_irq(). And if devm_request_irq()
failed, 'bt_bmc->irq' is assigned to zero maybe redundant,
it may be more suitable for using the correct negative values
to make the status check in the function bt_bmc_remove().

Signed-off-by: Shengju Zhang <zhangshengju@cmss.chinamobile.com>
Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
Changes from v1
 - fix the code of status check
---
 drivers/char/ipmi/bt-bmc.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/char/ipmi/bt-bmc.c b/drivers/char/ipmi/bt-bmc.c
index cd0349bff..33d3a5d50 100644
--- a/drivers/char/ipmi/bt-bmc.c
+++ b/drivers/char/ipmi/bt-bmc.c
@@ -399,15 +399,14 @@ static int bt_bmc_config_irq(struct bt_bmc *bt_bmc,
 	struct device *dev = &pdev->dev;
 	int rc;
 
-	bt_bmc->irq = platform_get_irq(pdev, 0);
-	if (!bt_bmc->irq)
-		return -ENODEV;
+	bt_bmc->irq = platform_get_irq_optional(pdev, 0);
+	if (bt_bmc->irq < 0)
+		return bt_bmc->irq;
 
 	rc = devm_request_irq(dev, bt_bmc->irq, bt_bmc_irq, IRQF_SHARED,
 			      DEVICE_NAME, bt_bmc);
 	if (rc < 0) {
 		dev_warn(dev, "Unable to request IRQ %d\n", bt_bmc->irq);
-		bt_bmc->irq = 0;
 		return rc;
 	}
 
@@ -474,7 +473,7 @@ static int bt_bmc_probe(struct platform_device *pdev)
 
 	bt_bmc_config_irq(bt_bmc, pdev);
 
-	if (bt_bmc->irq) {
+	if (bt_bmc->irq >= 0) {
 		dev_info(dev, "Using IRQ %d\n", bt_bmc->irq);
 	} else {
 		dev_info(dev, "No IRQ; using timer\n");
@@ -500,7 +499,7 @@ static int bt_bmc_remove(struct platform_device *pdev)
 	struct bt_bmc *bt_bmc = dev_get_drvdata(&pdev->dev);
 
 	misc_deregister(&bt_bmc->miscdev);
-	if (!bt_bmc->irq)
+	if (bt_bmc->irq < 0)
 		del_timer_sync(&bt_bmc->poll_timer);
 	return 0;
 }
-- 
2.20.1.windows.1



