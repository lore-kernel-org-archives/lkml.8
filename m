Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD7F2C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 08:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95361207BB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 08:41:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbgGVIl1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 04:41:27 -0400
Received: from lucky1.263xmail.com ([211.157.147.134]:36208 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbgGVIl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 04:41:27 -0400
Received: from localhost (unknown [192.168.167.69])
        by lucky1.263xmail.com (Postfix) with ESMTP id 3F84AC1209;
        Wed, 22 Jul 2020 16:37:43 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P18496T139713711163136S1595407061138531_;
        Wed, 22 Jul 2020 16:37:42 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <82baf5b43f5d54575472d2b82e280558>
X-RL-SENDER: jon.lin@rock-chips.com
X-SENDER: jon.lin@rock-chips.com
X-LOGIN-NAME: jon.lin@rock-chips.com
X-FST-TO: broonie@kernel.org
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
X-System-Flag: 0
From:   Jon Lin <jon.lin@rock-chips.com>
To:     broonie@kernel.org
Cc:     heiko@sntech.de, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jon Lin <jon.lin@rock-chips.com>
Subject: [PATCH v2 1/3] spi: rockchip: Config spi rx dma burst size depend on xfer length
Date:   Wed, 22 Jul 2020 16:37:35 +0800
Message-Id: <20200722083737.8820-1-jon.lin@rock-chips.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The burst length can be adjusted according to the transmission
length to improve the transmission rate

Signed-off-by: Jon Lin <jon.lin@rock-chips.com>
---
 drivers/spi/spi-rockchip.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 9b8a5e1233c0..63593a5b87fa 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -384,6 +384,19 @@ static void rockchip_spi_dma_txcb(void *data)
 	spi_finalize_current_transfer(ctlr);
 }
 
+static u32 rockchip_spi_calc_burst_size(u32 data_len)
+{
+	u32 i;
+
+	/* burst size: 1, 2, 4, 8 */
+	for (i = 1; i < 8; i <<= 1) {
+		if (data_len & i)
+			break;
+	}
+
+	return i;
+}
+
 static int rockchip_spi_prepare_dma(struct rockchip_spi *rs,
 		struct spi_controller *ctlr, struct spi_transfer *xfer)
 {
@@ -397,7 +410,8 @@ static int rockchip_spi_prepare_dma(struct rockchip_spi *rs,
 			.direction = DMA_DEV_TO_MEM,
 			.src_addr = rs->dma_addr_rx,
 			.src_addr_width = rs->n_bytes,
-			.src_maxburst = 1,
+			.src_maxburst = rockchip_spi_calc_burst_size(xfer->len /
+								     rs->n_bytes),
 		};
 
 		dmaengine_slave_config(ctlr->dma_rx, &rxconf);
@@ -525,7 +539,8 @@ static void rockchip_spi_config(struct rockchip_spi *rs,
 		writel_relaxed(rs->fifo_len / 2 - 1, rs->regs + ROCKCHIP_SPI_RXFTLR);
 
 	writel_relaxed(rs->fifo_len / 2, rs->regs + ROCKCHIP_SPI_DMATDLR);
-	writel_relaxed(0, rs->regs + ROCKCHIP_SPI_DMARDLR);
+	writel_relaxed(rockchip_spi_calc_burst_size(xfer->len / rs->n_bytes) - 1,
+		       rs->regs + ROCKCHIP_SPI_DMARDLR);
 	writel_relaxed(dmacr, rs->regs + ROCKCHIP_SPI_DMACR);
 
 	/* the hardware only supports an even clock divisor, so
-- 
2.17.1



