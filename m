Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11A1EC352BE
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 08:50:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEF17221F7
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 08:50:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726054AbgDRIuB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 04:50:01 -0400
Received: from cmccmta2.chinamobile.com ([221.176.66.80]:49500 "EHLO
        cmccmta2.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbgDRIuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 04:50:01 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.15]) by rmmx-syy-dmz-app06-12006 (RichMail) with SMTP id 2ee65e9abf2bed7-abf78; Sat, 18 Apr 2020 16:49:47 +0800 (CST)
X-RM-TRANSID: 2ee65e9abf2bed7-abf78
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[112.1.172.61])
        by rmsmtp-syy-appsvr08-12008 (RichMail) with SMTP id 2ee85e9abf28d92-79717;
        Sat, 18 Apr 2020 16:49:47 +0800 (CST)
X-RM-TRANSID: 2ee85e9abf28d92-79717
From:   Tang Bin <tangbin@cmss.chinamobile.com>
To:     f.fainelli@gmail.com, davem@davemloft.net
Cc:     bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>
Subject: [PATCH] net: systemport: Omit superfluous error message in bcm_sysport_probe()
Date:   Sat, 18 Apr 2020 16:51:06 +0800
Message-Id: <20200418085105.12584-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the function bcm_sysport_probe(), when get irq failed, the function
platform_get_irq() logs an error message, so remove redundant message
here.

Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
 drivers/net/ethernet/broadcom/bcmsysport.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bcmsysport.c b/drivers/net/ethernet/broadcom/bcmsysport.c
index af7ce5c54..c99e5a3fa 100644
--- a/drivers/net/ethernet/broadcom/bcmsysport.c
+++ b/drivers/net/ethernet/broadcom/bcmsysport.c
@@ -2475,7 +2475,6 @@ static int bcm_sysport_probe(struct platform_device *pdev)
 		priv->wol_irq = platform_get_irq(pdev, 1);
 	}
 	if (priv->irq0 <= 0 || (priv->irq1 <= 0 && !priv->is_lite)) {
-		dev_err(&pdev->dev, "invalid interrupts\n");
 		ret = -EINVAL;
 		goto err_free_netdev;
 	}
-- 
2.20.1.windows.1



