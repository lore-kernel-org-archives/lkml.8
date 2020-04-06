Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD165C2BA18
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 05:54:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B777020801
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 05:54:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbgDFFyd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 01:54:33 -0400
Received: from cmccmta1.chinamobile.com ([221.176.66.79]:4118 "EHLO
        cmccmta1.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbgDFFyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 01:54:33 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.9]) by rmmx-syy-dmz-app04-12004 (RichMail) with SMTP id 2ee45e8ac3f6540-9b709; Mon, 06 Apr 2020 13:53:59 +0800 (CST)
X-RM-TRANSID: 2ee45e8ac3f6540-9b709
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[117.136.19.171])
        by rmsmtp-syy-appsvr05-12005 (RichMail) with SMTP id 2ee55e8ac3f388d-bce89;
        Mon, 06 Apr 2020 13:53:58 +0800 (CST)
X-RM-TRANSID: 2ee55e8ac3f388d-bce89
From:   Tang Bin <tangbin@cmss.chinamobile.com>
To:     stern@rowland.harvard.edu, gregkh@linuxfoundation.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com
Cc:     linux-usb@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>
Subject: [PATCH] usb: host: ehci-tegra: Remove superfluous dev_err() message
Date:   Mon,  6 Apr 2020 13:55:30 +0800
Message-Id: <20200406055530.10860-1-tangbin@cmss.chinamobile.com>
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
 drivers/usb/host/ehci-tegra.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/host/ehci-tegra.c b/drivers/usb/host/ehci-tegra.c
index d6433f206..75a075daf 100644
--- a/drivers/usb/host/ehci-tegra.c
+++ b/drivers/usb/host/ehci-tegra.c
@@ -480,7 +480,6 @@ static int tegra_ehci_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (!irq) {
-		dev_err(&pdev->dev, "Failed to get IRQ\n");
 		err = -ENODEV;
 		goto cleanup_phy;
 	}
-- 
2.20.1.windows.1



