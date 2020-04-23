Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83B74C55191
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 02:15:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D90C2074F
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 02:15:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbgDWCPA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 22:15:00 -0400
Received: from cmccmta1.chinamobile.com ([221.176.66.79]:13043 "EHLO
        cmccmta1.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbgDWCPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 22:15:00 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.15]) by rmmx-syy-dmz-app04-12004 (RichMail) with SMTP id 2ee45ea0fa15e79-111ec; Thu, 23 Apr 2020 10:14:45 +0800 (CST)
X-RM-TRANSID: 2ee45ea0fa15e79-111ec
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[112.25.154.146])
        by rmsmtp-syy-appsvr08-12008 (RichMail) with SMTP id 2ee85ea0fa0c83d-2ea42;
        Thu, 23 Apr 2020 10:14:44 +0800 (CST)
X-RM-TRANSID: 2ee85ea0fa0c83d-2ea42
From:   Tang Bin <tangbin@cmss.chinamobile.com>
To:     kuba@kernel.org, khalasa@piap.pl, davem@davemloft.net,
        linus.walleij@linaro.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>,
        Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Subject: [PATCH v3] net: ethernet: ixp4xx: Add error handling in ixp4xx_eth_probe()
Date:   Thu, 23 Apr 2020 10:16:31 +0800
Message-Id: <20200423021631.20800-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function ixp4xx_eth_probe() does not perform sufficient error
checking after executing devm_ioremap_resource(), which can result
in crashes if a critical error path is encountered.

Fixes: f458ac479777 ("ARM/net: ixp4xx: Pass ethernet physical base as resource")
Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
v3:
 - remove extra line, between the tags
v2:
 - add fixes tag
---
 drivers/net/ethernet/xscale/ixp4xx_eth.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/xscale/ixp4xx_eth.c b/drivers/net/ethernet/xscale/ixp4xx_eth.c
index 269596c15..2e5202923 100644
--- a/drivers/net/ethernet/xscale/ixp4xx_eth.c
+++ b/drivers/net/ethernet/xscale/ixp4xx_eth.c
@@ -1387,6 +1387,8 @@ static int ixp4xx_eth_probe(struct platform_device *pdev)
 		return -ENODEV;
 	regs_phys = res->start;
 	port->regs = devm_ioremap_resource(dev, res);
+	if (IS_ERR(port->regs))
+		return PTR_ERR(port->regs);
 
 	switch (port->id) {
 	case IXP4XX_ETH_NPEA:
-- 
2.20.1.windows.1



