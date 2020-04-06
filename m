Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E4A4C2BA18
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 04:33:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEEEC20753
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 04:33:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbgDFEdb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 00:33:31 -0400
Received: from cmccmta2.chinamobile.com ([221.176.66.80]:3991 "EHLO
        cmccmta2.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbgDFEda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 00:33:30 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.9]) by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee55e8ab0fd965-9aa61; Mon, 06 Apr 2020 12:33:03 +0800 (CST)
X-RM-TRANSID: 2ee55e8ab0fd965-9aa61
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[112.1.173.122])
        by rmsmtp-syy-appsvr05-12005 (RichMail) with SMTP id 2ee55e8ab0fb2ea-b5e8c;
        Mon, 06 Apr 2020 12:33:03 +0800 (CST)
X-RM-TRANSID: 2ee55e8ab0fb2ea-b5e8c
From:   Tang Bin <tangbin@cmss.chinamobile.com>
To:     minyard@acm.org, arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>
Subject: [PATCH v2]ipmi:bt-bmc:Avoid unnecessary judgement
Date:   Mon,  6 Apr 2020 12:34:15 +0800
Message-Id: <20200406043415.12292-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In this driver,only the platform_device and platform_driver
matches,can trigger bt_bmc_probe(),and the trigger mode is
just Device Tree.Thus remove redundant judgments.

Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
Changes from v1:
 - improve the commit message.

 drivers/char/ipmi/bt-bmc.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/char/ipmi/bt-bmc.c b/drivers/char/ipmi/bt-bmc.c
index d36aeacb2..890ad55aa 100644
--- a/drivers/char/ipmi/bt-bmc.c
+++ b/drivers/char/ipmi/bt-bmc.c
@@ -430,9 +430,6 @@ static int bt_bmc_probe(struct platform_device *pdev)
 	struct device *dev;
 	int rc;
 
-	if (!pdev || !pdev->dev.of_node)
-		return -ENODEV;
-
 	dev = &pdev->dev;
 	dev_info(dev, "Found bt bmc device\n");
 
-- 
2.20.1.windows.1



