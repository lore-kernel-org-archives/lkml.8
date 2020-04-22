Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10B68C55189
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 01:07:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E57E92072D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 01:07:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbgDVBHu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 21:07:50 -0400
Received: from cmccmta1.chinamobile.com ([221.176.66.79]:4379 "EHLO
        cmccmta1.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbgDVBHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 21:07:49 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.5]) by rmmx-syy-dmz-app02-12002 (RichMail) with SMTP id 2ee25e9f98d6b5c-f5e92; Wed, 22 Apr 2020 09:07:34 +0800 (CST)
X-RM-TRANSID: 2ee25e9f98d6b5c-f5e92
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[112.25.154.146])
        by rmsmtp-syy-appsvr03-12003 (RichMail) with SMTP id 2ee35e9f98d3d10-2c015;
        Wed, 22 Apr 2020 09:07:34 +0800 (CST)
X-RM-TRANSID: 2ee35e9f98d3d10-2c015
From:   Tang Bin <tangbin@cmss.chinamobile.com>
To:     kuba@kernel.org, khalasa@piap.pl, davem@davemloft.net,
        linus.walleij@linaro.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>,
        Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Subject: [PATCH v2] net: ethernet: ixp4xx: Add error handling in ixp4xx_eth_probe()
Date:   Wed, 22 Apr 2020 09:09:22 +0800
Message-Id: <20200422010922.17728-1-tangbin@cmss.chinamobile.com>
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
v2:
 - add fixed tag
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



