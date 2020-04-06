Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6157CC2BA18
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 05:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E716206C0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 05:34:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbgDFFeD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 01:34:03 -0400
Received: from cmccmta1.chinamobile.com ([221.176.66.79]:19347 "EHLO
        cmccmta1.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbgDFFeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 01:34:02 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.5]) by rmmx-syy-dmz-app01-12001 (RichMail) with SMTP id 2ee15e8abf1d281-9b1d2; Mon, 06 Apr 2020 13:33:19 +0800 (CST)
X-RM-TRANSID: 2ee15e8abf1d281-9b1d2
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[117.136.19.171])
        by rmsmtp-syy-appsvr03-12003 (RichMail) with SMTP id 2ee35e8abf1b3ee-48510;
        Mon, 06 Apr 2020 13:33:19 +0800 (CST)
X-RM-TRANSID: 2ee35e8abf1b3ee-48510
From:   Tang Bin <tangbin@cmss.chinamobile.com>
To:     b.zolnierkie@samsung.com, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, ludovic.desroches@microchip.com,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>
Subject: [PATCH] video: fbdev: don't print error message on platform_get_irq() failure
Date:   Mon,  6 Apr 2020 13:34:50 +0800
Message-Id: <20200406053450.8380-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The platform_get_irq() can print error message,so remove the redundant
dev_err() here.

Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
 drivers/video/fbdev/atmel_lcdfb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/video/fbdev/atmel_lcdfb.c b/drivers/video/fbdev/atmel_lcdfb.c
index d567f5d56..1e2521925 100644
--- a/drivers/video/fbdev/atmel_lcdfb.c
+++ b/drivers/video/fbdev/atmel_lcdfb.c
@@ -1114,7 +1114,6 @@ static int __init atmel_lcdfb_probe(struct platform_device *pdev)
 
 	sinfo->irq_base = platform_get_irq(pdev, 0);
 	if (sinfo->irq_base < 0) {
-		dev_err(dev, "unable to get irq\n");
 		ret = sinfo->irq_base;
 		goto stop_clk;
 	}
-- 
2.20.1.windows.1



