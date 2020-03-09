Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BCBBC18E5A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 18:20:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 265D620873
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 18:20:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727720AbgCISUH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 14:20:07 -0400
Received: from foss.arm.com ([217.140.110.172]:55738 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727510AbgCISTP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 14:19:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 40ADC106F;
        Mon,  9 Mar 2020 11:19:15 -0700 (PDT)
Received: from donnerap.arm.com (donnerap.cambridge.arm.com [10.1.197.25])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E6C583F67D;
        Mon,  9 Mar 2020 11:19:13 -0700 (PDT)
From:   Andre Przywara <andre.przywara@arm.com>
To:     "David S . Miller" <davem@davemloft.net>,
        Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Cc:     Michal Simek <michal.simek@xilinx.com>,
        Robert Hancock <hancock@sedsystems.ca>, netdev@vger.kernel.org,
        rmk+kernel@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH v2 08/14] net: axienet: Mark eth_irq as optional
Date:   Mon,  9 Mar 2020 18:18:45 +0000
Message-Id: <20200309181851.190164-9-andre.przywara@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200309181851.190164-1-andre.przywara@arm.com>
References: <20200309181851.190164-1-andre.przywara@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the DT binding, the Ethernet core interrupt is optional.

Use platform_get_irq_optional() to avoid the error message when the
IRQ is not specified.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index 2f417136bfae..f73a9eab1120 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -1868,7 +1868,7 @@ static int axienet_probe(struct platform_device *pdev)
 		lp->rx_irq = irq_of_parse_and_map(np, 1);
 		lp->tx_irq = irq_of_parse_and_map(np, 0);
 		of_node_put(np);
-		lp->eth_irq = platform_get_irq(pdev, 0);
+		lp->eth_irq = platform_get_irq_optional(pdev, 0);
 	} else {
 		/* Check for these resources directly on the Ethernet node. */
 		struct resource *res = platform_get_resource(pdev,
@@ -1876,7 +1876,7 @@ static int axienet_probe(struct platform_device *pdev)
 		lp->dma_regs = devm_ioremap_resource(&pdev->dev, res);
 		lp->rx_irq = platform_get_irq(pdev, 1);
 		lp->tx_irq = platform_get_irq(pdev, 0);
-		lp->eth_irq = platform_get_irq(pdev, 2);
+		lp->eth_irq = platform_get_irq_optional(pdev, 2);
 	}
 	if (IS_ERR(lp->dma_regs)) {
 		dev_err(&pdev->dev, "could not map DMA regs\n");
-- 
2.17.1

