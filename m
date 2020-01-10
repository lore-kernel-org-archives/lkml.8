Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6DEBC33CA2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 11:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 955162072A
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 11:54:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728147AbgAJLyh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 06:54:37 -0500
Received: from foss.arm.com ([217.140.110.172]:43158 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727878AbgAJLye (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 06:54:34 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 11C0F139F;
        Fri, 10 Jan 2020 03:54:34 -0800 (PST)
Received: from donnerap.arm.com (donnerap.cambridge.arm.com [10.1.197.44])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EABEB3F534;
        Fri, 10 Jan 2020 03:54:32 -0800 (PST)
From:   Andre Przywara <andre.przywara@arm.com>
To:     "David S . Miller" <davem@davemloft.net>,
        Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Cc:     Michal Simek <michal.simek@xilinx.com>,
        Robert Hancock <hancock@sedsystems.ca>, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 08/14] net: axienet: Drop MDIO interrupt registers from ethtools dump
Date:   Fri, 10 Jan 2020 11:54:09 +0000
Message-Id: <20200110115415.75683-9-andre.przywara@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200110115415.75683-1-andre.przywara@arm.com>
References: <20200110115415.75683-1-andre.przywara@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Newer revisions of the IP don't have these registers. Since we don't
really use them, just drop them from the ethtools dump.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index e83c7b005f50..7a747345e98e 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -1239,10 +1239,6 @@ static void axienet_ethtools_get_regs(struct net_device *ndev,
 	data[20] = axienet_ior(lp, XAE_MDIO_MCR_OFFSET);
 	data[21] = axienet_ior(lp, XAE_MDIO_MWD_OFFSET);
 	data[22] = axienet_ior(lp, XAE_MDIO_MRD_OFFSET);
-	data[23] = axienet_ior(lp, XAE_MDIO_MIS_OFFSET);
-	data[24] = axienet_ior(lp, XAE_MDIO_MIP_OFFSET);
-	data[25] = axienet_ior(lp, XAE_MDIO_MIE_OFFSET);
-	data[26] = axienet_ior(lp, XAE_MDIO_MIC_OFFSET);
 	data[27] = axienet_ior(lp, XAE_UAW0_OFFSET);
 	data[28] = axienet_ior(lp, XAE_UAW1_OFFSET);
 	data[29] = axienet_ior(lp, XAE_FMI_OFFSET);
-- 
2.17.1

