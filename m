Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3020C10F25
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 07:02:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C54EA20873
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 07:02:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728417AbgCKHCD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 03:02:03 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:52394 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726160AbgCKHCD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 03:02:03 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id DC51B1098833C4977055;
        Wed, 11 Mar 2020 15:01:47 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Wed, 11 Mar 2020 15:01:40 +0800
From:   Chen Zhou <chenzhou10@huawei.com>
To:     <davem@davemloft.net>
CC:     <willy@infradead.org>, <andrew@lunn.ch>, <hkallweit1@gmail.com>,
        <kuba@kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <chenzhou10@huawei.com>
Subject: [PATCH -next] net: ibm: remove set but not used variables 'err'
Date:   Wed, 11 Mar 2020 14:54:11 +0800
Message-ID: <20200311065411.172692-1-chenzhou10@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/net/ethernet/ibm/emac/core.c: In function __emac_mdio_write:
drivers/net/ethernet/ibm/emac/core.c:875:9: warning:
	variable err set but not used [-Wunused-but-set-variable]

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
---
 drivers/net/ethernet/ibm/emac/core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/ibm/emac/core.c b/drivers/net/ethernet/ibm/emac/core.c
index b7fc177..06248a7 100644
--- a/drivers/net/ethernet/ibm/emac/core.c
+++ b/drivers/net/ethernet/ibm/emac/core.c
@@ -872,7 +872,7 @@ static void __emac_mdio_write(struct emac_instance *dev, u8 id, u8 reg,
 {
 	struct emac_regs __iomem *p = dev->emacp;
 	u32 r = 0;
-	int n, err = -ETIMEDOUT;
+	int n;
 
 	mutex_lock(&dev->mdio_lock);
 
@@ -919,7 +919,6 @@ static void __emac_mdio_write(struct emac_instance *dev, u8 id, u8 reg,
 			goto bail;
 		}
 	}
-	err = 0;
  bail:
 	if (emac_has_feature(dev, EMAC_FTR_HAS_RGMII))
 		rgmii_put_mdio(dev->rgmii_dev, dev->rgmii_port);
-- 
2.7.4

