Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C79BC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 11:42:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4652B208D6
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 11:42:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbgEHLmx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 07:42:53 -0400
Received: from cmccmta1.chinamobile.com ([221.176.66.79]:4390 "EHLO
        cmccmta1.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726616AbgEHLmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 07:42:53 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.11]) by rmmx-syy-dmz-app02-12002 (RichMail) with SMTP id 2ee25eb545a8f18-5941c; Fri, 08 May 2020 19:42:32 +0800 (CST)
X-RM-TRANSID: 2ee25eb545a8f18-5941c
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[112.25.154.146])
        by rmsmtp-syy-appsvr06-12006 (RichMail) with SMTP id 2ee65eb545a4a75-390f4;
        Fri, 08 May 2020 19:42:32 +0800 (CST)
X-RM-TRANSID: 2ee65eb545a4a75-390f4
From:   Tang Bin <tangbin@cmss.chinamobile.com>
To:     stern@rowland.harvard.edu, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>,
        Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Subject: [PATCH] USB: EHCI: ehci-mv: fix error handling in mv_ehci_probe()
Date:   Fri,  8 May 2020 19:43:05 +0800
Message-Id: <20200508114305.15740-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the function platform_get_irq() failed, the negative value
returned will not be detected here. So fix error handling in
mv_ehci_probe(). And when get irq failed, the function
platform_get_irq() logs an error message, so remove redundant
message here.

Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
 drivers/usb/host/ehci-mv.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/host/ehci-mv.c b/drivers/usb/host/ehci-mv.c
index 1c079953e..b2da62bfd 100644
--- a/drivers/usb/host/ehci-mv.c
+++ b/drivers/usb/host/ehci-mv.c
@@ -166,9 +166,8 @@ static int mv_ehci_probe(struct platform_device *pdev)
 	hcd->regs = ehci_mv->op_regs;
 
 	hcd->irq = platform_get_irq(pdev, 0);
-	if (!hcd->irq) {
-		dev_err(&pdev->dev, "Cannot get irq.");
-		retval = -ENODEV;
+	if (hcd->irq < 0) {
+		retval = hcd->irq;
 		goto err_disable_clk;
 	}
 
-- 
2.20.1.windows.1



