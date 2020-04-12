Return-Path: <SRS0=29S8=54=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E5A6C2BA2B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 09:26:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F25FD206DA
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 09:26:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbgDLJ0N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Apr 2020 05:26:13 -0400
Received: from cmccmta2.chinamobile.com ([221.176.66.80]:3994 "EHLO
        cmccmta2.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbgDLJ0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Apr 2020 05:26:13 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.19]) by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee55e92de9da03-1fbc8; Sun, 12 Apr 2020 17:25:51 +0800 (CST)
X-RM-TRANSID: 2ee55e92de9da03-1fbc8
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[112.1.172.56])
        by rmsmtp-syy-appsvr10-12010 (RichMail) with SMTP id 2eea5e92de9c9bf-68f8a;
        Sun, 12 Apr 2020 17:25:51 +0800 (CST)
X-RM-TRANSID: 2eea5e92de9c9bf-68f8a
From:   Tang Bin <tangbin@cmss.chinamobile.com>
To:     khalasa@piap.pl, davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>,
        Shengju Zhang <zhangshengju@cmss.chinamobile.com>
Subject: [PATCH] net: ethernet: ixp4xx: Add error handling in ixp4xx_eth_probe()
Date:   Sun, 12 Apr 2020 17:27:28 +0800
Message-Id: <20200412092728.8396-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function ixp4xx_eth_probe() does not perform sufficient error
checking after executing devm_ioremap_resource(),which can result
in crashes if a critical error path is encountered.

Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
Signed-off-by: Shengju Zhang <zhangshengju@cmss.chinamobile.com>
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



