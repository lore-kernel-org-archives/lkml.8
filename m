Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D6FC2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 14:18:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCE072075E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 14:18:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389464AbgDNOSk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 10:18:40 -0400
Received: from cmccmta1.chinamobile.com ([221.176.66.79]:3498 "EHLO
        cmccmta1.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389443AbgDNOSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 10:18:32 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.11]) by rmmx-syy-dmz-app01-12001 (RichMail) with SMTP id 2ee15e95c61edff-54dfc; Tue, 14 Apr 2020 22:18:09 +0800 (CST)
X-RM-TRANSID: 2ee15e95c61edff-54dfc
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[112.3.208.246])
        by rmsmtp-syy-appsvr06-12006 (RichMail) with SMTP id 2ee65e95c61f0fb-943a7;
        Tue, 14 Apr 2020 22:18:09 +0800 (CST)
X-RM-TRANSID: 2ee65e95c61f0fb-943a7
From:   Tang Bin <tangbin@cmss.chinamobile.com>
To:     minyard@acm.org, arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>,
        Shengju Zhang <zhangshengju@cmss.chinamobile.com>
Subject: [PATCH] ipmi:bt-bmc: Delete superfluous dev_warm() in bt_bmc_config_irq()
Date:   Tue, 14 Apr 2020 22:19:51 +0800
Message-Id: <20200414141951.19120-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The priority of dev_warm() is higher than dev_info(),so if the
function bt_bmc_probe() uses dev_info() to print error message,
the dev_warm() is redundant.Thus should be removed.

Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
Signed-off-by: Shengju Zhang <zhangshengju@cmss.chinamobile.com>
---
 drivers/char/ipmi/bt-bmc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/char/ipmi/bt-bmc.c b/drivers/char/ipmi/bt-bmc.c
index cd0349bff..1d4bf5c65 100644
--- a/drivers/char/ipmi/bt-bmc.c
+++ b/drivers/char/ipmi/bt-bmc.c
@@ -406,7 +406,6 @@ static int bt_bmc_config_irq(struct bt_bmc *bt_bmc,
 	rc = devm_request_irq(dev, bt_bmc->irq, bt_bmc_irq, IRQF_SHARED,
 			      DEVICE_NAME, bt_bmc);
 	if (rc < 0) {
-		dev_warn(dev, "Unable to request IRQ %d\n", bt_bmc->irq);
 		bt_bmc->irq = 0;
 		return rc;
 	}
-- 
2.20.1.windows.1



