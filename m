Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EED56C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8B472072E
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:40:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730317AbgCaJkC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 05:40:02 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:21755 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbgCaJkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 05:40:02 -0400
IronPort-SDR: zCAhpOhSPx8/Vxszb5joggHuxdzoaeF6Cr28gVHhISoHhgnjdEIz4pbo9Ak52hpiG+rfqSZ9kG
 q8d/wo/uIu6Y4XP3JdztNCjPNcbaBXtya2OS8pYtW+3xuSoqpl15ljbQ8dhk9Rv4bXPVeuI2hl
 09reSlBQh+08fCL9+b6N0AyKSd2DkQklOydUOu1bbLEL4FobeCfn6jcG0fS3YT203y/7xE+Mle
 ygqFIydrJyfjuHKWUEfaEanJRKxZ9ATZdgWsdfcqtjDkPosw5DmrnEgDLxNDP/BQvL2dovrK+Q
 fUQ=
X-IronPort-AV: E=Sophos;i="5.72,327,1580799600"; 
   d="scan'208";a="70857365"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 31 Mar 2020 02:40:02 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 31 Mar 2020 02:40:01 -0700
Received: from rob-ult-m19940.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1713.5 via Frontend Transport; Tue, 31 Mar 2020 02:40:02 -0700
From:   Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
To:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <nicolas.ferre@microchip.com>, <davem@davemloft.net>,
        <antoine.tenart@bootlin.com>, <andrew@lunn.ch>,
        <f.fainelli@gmail.com>,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        Cristian Birsan <cristian.birsan@microchip.com>
Subject: [PATCH] net: macb: Fix handling of fixed-link node
Date:   Tue, 31 Mar 2020 12:39:35 +0300
Message-ID: <20200331093935.23542-1-codrin.ciubotariu@microchip.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fixed-link nodes are treated as PHY nodes by of_mdiobus_child_is_phy().
We must check if the interface is a fixed-link before looking up for PHY
nodes.

Fixes: 7897b071ac3b ("net: macb: convert to phylink")
Tested-by: Cristian Birsan <cristian.birsan@microchip.com>
Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 2c28da1737fe..b3a51935e8e0 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -724,6 +724,9 @@ static int macb_mdiobus_register(struct macb *bp)
 {
 	struct device_node *child, *np = bp->pdev->dev.of_node;
 
+	if (of_phy_is_fixed_link(np))
+		return mdiobus_register(bp->mii_bus);
+
 	/* Only create the PHY from the device tree if at least one PHY is
 	 * described. Otherwise scan the entire MDIO bus. We do this to support
 	 * old device tree that did not follow the best practices and did not
-- 
2.20.1

