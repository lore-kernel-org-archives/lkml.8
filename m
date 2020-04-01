Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20935C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 01:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F05A82145D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 01:28:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731719AbgDAB2a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 21:28:30 -0400
Received: from cmccmta3.chinamobile.com ([221.176.66.81]:10546 "EHLO
        cmccmta3.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731588AbgDAB2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 21:28:30 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.11]) by rmmx-syy-dmz-app12-12012 (RichMail) with SMTP id 2eec5e83ed50472-334ec; Wed, 01 Apr 2020 09:24:32 +0800 (CST)
X-RM-TRANSID: 2eec5e83ed50472-334ec
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[112.25.154.146])
        by rmsmtp-syy-appsvr06-12006 (RichMail) with SMTP id 2ee65e83ed4cdfa-5a587;
        Wed, 01 Apr 2020 09:24:32 +0800 (CST)
X-RM-TRANSID: 2ee65e83ed4cdfa-5a587
From:   Tang Bin <tangbin@cmss.chinamobile.com>
To:     minyard@acm.org, arnd@arndb.de
Cc:     gregkh@linuxfoundation.org,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>
Subject: [PATCH] ipmi:bt-bmc:avoid unnecessary judgement
Date:   Wed,  1 Apr 2020 09:25:57 +0800
Message-Id: <20200401012557.9664-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In this function,it will only trigger ifdevice and driver match,and
the driver has already used the device tree, so the judgement here is
unnecessary.

Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
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



