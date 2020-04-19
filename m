Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24B11C38A29
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 09:17:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08B9721974
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 09:17:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725987AbgDSJRg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 05:17:36 -0400
Received: from cmccmta2.chinamobile.com ([221.176.66.80]:49504 "EHLO
        cmccmta2.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgDSJRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 05:17:35 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.3]) by rmmx-syy-dmz-app06-12006 (RichMail) with SMTP id 2ee65e9c1714477-b951d; Sun, 19 Apr 2020 17:17:09 +0800 (CST)
X-RM-TRANSID: 2ee65e9c1714477-b951d
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[112.1.172.61])
        by rmsmtp-syy-appsvr02-12002 (RichMail) with SMTP id 2ee25e9c1712c28-0a62f;
        Sun, 19 Apr 2020 17:17:09 +0800 (CST)
X-RM-TRANSID: 2ee25e9c1712c28-0a62f
From:   Tang Bin <tangbin@cmss.chinamobile.com>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>,
        Shengju Zhang <zhangshengju@cmss.chinamobile.com>
Subject: [PATCH] mfd: asic3: Delete superfluous error message in asic3_probe()
Date:   Sun, 19 Apr 2020 17:18:55 +0800
Message-Id: <20200419091855.12932-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the function asic3_probe(), when get irq failed, the function
asic3_irq_probe() can called platform_get_irq(), which logs an
error message, so remove redundant message here.

Signed-off-by: Shengju Zhang <zhangshengju@cmss.chinamobile.com>
Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
 drivers/mfd/asic3.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mfd/asic3.c b/drivers/mfd/asic3.c
index a6bd2134c..7694de3f1 100644
--- a/drivers/mfd/asic3.c
+++ b/drivers/mfd/asic3.c
@@ -987,10 +987,8 @@ static int __init asic3_probe(struct platform_device *pdev)
 	asic3_write_register(asic, ASIC3_OFFSET(CLOCK, SEL), clksel);
 
 	ret = asic3_irq_probe(pdev);
-	if (ret < 0) {
-		dev_err(asic->dev, "Couldn't probe IRQs\n");
+	if (ret < 0)
 		goto out_unmap;
-	}
 
 	asic->gpio.label = "asic3";
 	asic->gpio.base = pdata->gpio_base;
-- 
2.20.1.windows.1



