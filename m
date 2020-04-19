Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 926D2C38A29
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 07:04:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78F9A21974
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 07:04:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726091AbgDSHEM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 03:04:12 -0400
Received: from cmccmta1.chinamobile.com ([221.176.66.79]:3503 "EHLO
        cmccmta1.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgDSHEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 03:04:12 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.7]) by rmmx-syy-dmz-app01-12001 (RichMail) with SMTP id 2ee15e9bf7d9fad-b8006; Sun, 19 Apr 2020 15:03:55 +0800 (CST)
X-RM-TRANSID: 2ee15e9bf7d9fad-b8006
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[112.1.172.61])
        by rmsmtp-syy-appsvr04-12004 (RichMail) with SMTP id 2ee45e9bf7d8382-b3824;
        Sun, 19 Apr 2020 15:03:55 +0800 (CST)
X-RM-TRANSID: 2ee45e9bf7d8382-b3824
From:   Tang Bin <tangbin@cmss.chinamobile.com>
To:     kgene@kernel.org, krzk@kernel.org, linux@armlinux.org.uk
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>,
        Shengju Zhang <zhangshengju@cmss.chinamobile.com>
Subject: [PATCH] ARM: samsung: Omit superfluous error message in s3c_adc_probe()
Date:   Sun, 19 Apr 2020 15:05:41 +0800
Message-Id: <20200419070541.14820-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the function s3c_adc_probe(), when get irq failed,
the function platform_get_irq() logs an error message,
so remove redundant message here.

Signed-off-by: Shengju Zhang <zhangshengju@cmss.chinamobile.com>
Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
 arch/arm/plat-samsung/adc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm/plat-samsung/adc.c b/arch/arm/plat-samsung/adc.c
index 4f7b27239..839bf7d5f 100644
--- a/arch/arm/plat-samsung/adc.c
+++ b/arch/arm/plat-samsung/adc.c
@@ -354,10 +354,8 @@ static int s3c_adc_probe(struct platform_device *pdev)
 	}
 
 	adc->irq = platform_get_irq(pdev, 1);
-	if (adc->irq <= 0) {
-		dev_err(dev, "failed to get adc irq\n");
+	if (adc->irq <= 0)
 		return -ENOENT;
-	}
 
 	ret = devm_request_irq(dev, adc->irq, s3c_adc_irq, 0, dev_name(dev),
 				adc);
-- 
2.20.1.windows.1



