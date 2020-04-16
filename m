Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB3A7C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:32:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D019721927
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:32:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437366AbgDPOcQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 10:32:16 -0400
Received: from cmccmta1.chinamobile.com ([221.176.66.79]:12038 "EHLO
        cmccmta1.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393013AbgDPOEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 10:04:08 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.5]) by rmmx-syy-dmz-app04-12004 (RichMail) with SMTP id 2ee45e9865c9f24-87203; Thu, 16 Apr 2020 22:03:53 +0800 (CST)
X-RM-TRANSID: 2ee45e9865c9f24-87203
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[112.1.173.7])
        by rmsmtp-syy-appsvr03-12003 (RichMail) with SMTP id 2ee35e9865c63fd-fa69c;
        Thu, 16 Apr 2020 22:03:53 +0800 (CST)
X-RM-TRANSID: 2ee35e9865c63fd-fa69c
From:   Tang Bin <tangbin@cmss.chinamobile.com>
To:     aisheng.dong@nxp.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com
Cc:     linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>
Subject: [PATCH] i2c:imx-lpi2c: Omit superfluous error message in lpi2c_imx_probe()
Date:   Thu, 16 Apr 2020 22:05:29 +0800
Message-Id: <20200416140529.20036-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the function lpi2c_imx_probe(), when get irq failed, the function
platform_get_irq() logs an error message, so remove redundant message
here.

Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
 drivers/i2c/busses/i2c-imx-lpi2c.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-imx-lpi2c.c b/drivers/i2c/busses/i2c-imx-lpi2c.c
index c92b56485..ee16e7e22 100644
--- a/drivers/i2c/busses/i2c-imx-lpi2c.c
+++ b/drivers/i2c/busses/i2c-imx-lpi2c.c
@@ -557,10 +557,8 @@ static int lpi2c_imx_probe(struct platform_device *pdev)
 		return PTR_ERR(lpi2c_imx->base);
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "can't get irq number\n");
+	if (irq < 0)
 		return irq;
-	}
 
 	lpi2c_imx->adapter.owner	= THIS_MODULE;
 	lpi2c_imx->adapter.algo		= &lpi2c_imx_algo;
-- 
2.20.1.windows.1



