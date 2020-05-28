Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D206FC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 11:47:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B55B92088E
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 11:47:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388510AbgE1Lrt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 07:47:49 -0400
Received: from cmccmta3.chinamobile.com ([221.176.66.81]:5585 "EHLO
        cmccmta3.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388326AbgE1Lrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 07:47:48 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.13]) by rmmx-syy-dmz-app12-12012 (RichMail) with SMTP id 2eec5ecfa4d1012-158dc; Thu, 28 May 2020 19:47:30 +0800 (CST)
X-RM-TRANSID: 2eec5ecfa4d1012-158dc
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[112.25.154.146])
        by rmsmtp-syy-appsvr07-12007 (RichMail) with SMTP id 2ee75ecfa4cf278-b3077;
        Thu, 28 May 2020 19:47:29 +0800 (CST)
X-RM-TRANSID: 2ee75ecfa4cf278-b3077
From:   Tang Bin <tangbin@cmss.chinamobile.com>
To:     gregkh@linuxfoundation.org, thierry.reding@gmail.com,
        balbi@kernel.org, jonathanh@nvidia.com
Cc:     linux-usb@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>,
        Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Subject: [PATCH] usb: phy: tegra: Fix unnecessary check in tegra_usb_phy_probe()
Date:   Thu, 28 May 2020 19:47:17 +0800
Message-Id: <20200528114717.21028-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the function tegra_usb_phy_probe(), if usb_add_phy_dev() failed,
the return value will be given to err, and if usb_add_phy_dev() succeed,
the return value will be zero. Thus it is unnecessary to repeated check
here.

Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
 drivers/usb/phy/phy-tegra-usb.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/usb/phy/phy-tegra-usb.c b/drivers/usb/phy/phy-tegra-usb.c
index c294dc617..27c2e9843 100644
--- a/drivers/usb/phy/phy-tegra-usb.c
+++ b/drivers/usb/phy/phy-tegra-usb.c
@@ -1200,11 +1200,7 @@ static int tegra_usb_phy_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, tegra_phy);
 
-	err = usb_add_phy_dev(&tegra_phy->u_phy);
-	if (err)
-		return err;
-
-	return 0;
+	return usb_add_phy_dev(&tegra_phy->u_phy);
 }
 
 static int tegra_usb_phy_remove(struct platform_device *pdev)
-- 
2.20.1.windows.1



