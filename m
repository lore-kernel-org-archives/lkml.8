Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AA42C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 16:23:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 521B42073B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 16:23:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729768AbgEZQXX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 12:23:23 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:57673 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727110AbgEZQXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 12:23:22 -0400
X-Originating-IP: 90.76.143.236
Received: from localhost (lfbn-tou-1-1075-236.w90-76.abo.wanadoo.fr [90.76.143.236])
        (Authenticated sender: antoine.tenart@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 1BB0D1BF203;
        Tue, 26 May 2020 16:23:16 +0000 (UTC)
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     davem@davemloft.net, andrew@lunn.ch, f.fainelli@gmail.com,
        hkallweit1@gmail.com
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        alexandre.belloni@bootlin.com, thomas.petazzoni@bootlin.com,
        allan.nielsen@microchip.com
Subject: [PATCH net-next 2/4] net: phy: mscc-miim: remove redundant timeout check
Date:   Tue, 26 May 2020 18:22:54 +0200
Message-Id: <20200526162256.466885-3-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200526162256.466885-1-antoine.tenart@bootlin.com>
References: <20200526162256.466885-1-antoine.tenart@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

readl_poll_timeout already returns -ETIMEDOUT if the condition isn't
satisfied, there's no need to check again the condition after calling
it. Remove the redundant timeout check.

Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
---
 drivers/net/phy/mdio-mscc-miim.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/net/phy/mdio-mscc-miim.c b/drivers/net/phy/mdio-mscc-miim.c
index 0b7544f593fb..42119f661452 100644
--- a/drivers/net/phy/mdio-mscc-miim.c
+++ b/drivers/net/phy/mdio-mscc-miim.c
@@ -43,12 +43,8 @@ static int mscc_miim_wait_ready(struct mii_bus *bus)
 	struct mscc_miim_dev *miim = bus->priv;
 	u32 val;
 
-	readl_poll_timeout(miim->regs + MSCC_MIIM_REG_STATUS, val,
-			   !(val & MSCC_MIIM_STATUS_STAT_BUSY), 50, 10000);
-	if (val & MSCC_MIIM_STATUS_STAT_BUSY)
-		return -ETIMEDOUT;
-
-	return 0;
+	return readl_poll_timeout(miim->regs + MSCC_MIIM_REG_STATUS, val,
+				  !(val & MSCC_MIIM_STATUS_STAT_BUSY), 50, 10000);
 }
 
 static int mscc_miim_read(struct mii_bus *bus, int mii_id, int regnum)
-- 
2.26.2

