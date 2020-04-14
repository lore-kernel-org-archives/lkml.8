Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C265C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 14:13:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EEE620578
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 14:13:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733194AbgDNONw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 10:13:52 -0400
Received: from cmccmta2.chinamobile.com ([221.176.66.80]:11702 "EHLO
        cmccmta2.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728815AbgDNONo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 10:13:44 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.11]) by rmmx-syy-dmz-app07-12007 (RichMail) with SMTP id 2ee75e95c4f7db4-5501f; Tue, 14 Apr 2020 22:13:14 +0800 (CST)
X-RM-TRANSID: 2ee75e95c4f7db4-5501f
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[112.3.208.246])
        by rmsmtp-syy-appsvr06-12006 (RichMail) with SMTP id 2ee65e95c4f78b7-93ad2;
        Tue, 14 Apr 2020 22:13:14 +0800 (CST)
X-RM-TRANSID: 2ee65e95c4f78b7-93ad2
From:   Tang Bin <tangbin@cmss.chinamobile.com>
To:     minyard@acm.org, arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>,
        Shengju Zhang <zhangshengju@cmss.chinamobile.com>
Subject: [PATCH 3/3] ipmi:bt-bmc: Fix error handling and status check
Date:   Tue, 14 Apr 2020 22:14:24 +0800
Message-Id: <20200414141423.4968-1-tangbin@cmss.chinamobile.com>
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

Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
Signed-off-by: Shengju Zhang <zhangshengju@cmss.chinamobile.com>
---
 drivers/char/ipmi/bt-bmc.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/char/ipmi/bt-bmc.c b/drivers/char/ipmi/bt-bmc.c
index 1d4bf5c65..1740c6dc8 100644
--- a/drivers/char/ipmi/bt-bmc.c
+++ b/drivers/char/ipmi/bt-bmc.c
@@ -399,16 +399,14 @@ static int bt_bmc_config_irq(struct bt_bmc *bt_bmc,
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
-	if (rc < 0) {
-		bt_bmc->irq = 0;
+	if (rc < 0)
 		return rc;
-	}
 
 	/*
 	 * Configure IRQs on the bmc clearing the H2B and HBUSY bits;
@@ -499,7 +497,7 @@ static int bt_bmc_remove(struct platform_device *pdev)
 	struct bt_bmc *bt_bmc = dev_get_drvdata(&pdev->dev);
 
 	misc_deregister(&bt_bmc->miscdev);
-	if (!bt_bmc->irq)
+	if (bt_bmc->irq < 0)
 		del_timer_sync(&bt_bmc->poll_timer);
 	return 0;
 }
-- 
2.20.1.windows.1



