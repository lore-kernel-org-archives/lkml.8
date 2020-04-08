Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 928DAC2D0EA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 11:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FAE320780
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 11:58:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728016AbgDHL6k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 07:58:40 -0400
Received: from cmccmta3.chinamobile.com ([221.176.66.81]:52343 "EHLO
        cmccmta3.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbgDHL6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 07:58:40 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.19]) by rmmx-syy-dmz-app11-12011 (RichMail) with SMTP id 2eeb5e8dbc5e212-d237d; Wed, 08 Apr 2020 19:58:23 +0800 (CST)
X-RM-TRANSID: 2eeb5e8dbc5e212-d237d
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[112.25.154.146])
        by rmsmtp-syy-appsvr10-12010 (RichMail) with SMTP id 2eea5e8dbc5c9b8-08603;
        Wed, 08 Apr 2020 19:58:23 +0800 (CST)
X-RM-TRANSID: 2eea5e8dbc5c9b8-08603
From:   Tang Bin <tangbin@cmss.chinamobile.com>
To:     minyard@acm.org, arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>
Subject: [PATCH v3]ipmi:bt-bmc:Avoid unnecessary judgement
Date:   Wed,  8 Apr 2020 19:59:58 +0800
Message-Id: <20200408115958.2848-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bt_bmc_probe() is only called with an openfirmware platform device.
Therefore there is no need to check that the passed in device is NULL or
that it has an openfirmware node.

Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
Changes from v2:
 - improve the commit message.

Changes from v1:
 - improve the commit message.
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



