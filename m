Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4583FC35E01
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 18:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2523920637
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 18:35:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731583AbgBYSfo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 13:35:44 -0500
Received: from lists.gateworks.com ([108.161.130.12]:33873 "EHLO
        lists.gateworks.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727983AbgBYSfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 13:35:44 -0500
Received: from 68-189-91-139.static.snlo.ca.charter.com ([68.189.91.139] helo=tharvey.pdc.gateworks.com)
        by lists.gateworks.com with esmtp (Exim 4.82)
        (envelope-from <tharvey@gateworks.com>)
        id 1j6f4T-0007kM-P9; Tue, 25 Feb 2020 18:36:41 +0000
From:   Tim Harvey <tharvey@gateworks.com>
To:     linux-kernel@vger.kernel.org, linux-can@vger.kernel.org,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     =?UTF-8?q?Timo=20Schl=C3=BC=C3=9Fler?= <schluessler@krause.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH] can: mcp251x: convert to half-duplex SPI
Date:   Tue, 25 Feb 2020 10:35:34 -0800
Message-Id: <1582655734-20890-1-git-send-email-tharvey@gateworks.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some SPI host controllers such as the Cavium Thunder do not support
full-duplex SPI. Using half-duplex transfers allows the driver to work
with those host controllers.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 drivers/net/can/spi/mcp251x.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/spi/mcp251x.c b/drivers/net/can/spi/mcp251x.c
index 5009ff2..840c31c 100644
--- a/drivers/net/can/spi/mcp251x.c
+++ b/drivers/net/can/spi/mcp251x.c
@@ -290,23 +290,23 @@ static u8 mcp251x_read_reg(struct spi_device *spi, u8 reg)
 	priv->spi_tx_buf[0] = INSTRUCTION_READ;
 	priv->spi_tx_buf[1] = reg;
 
-	mcp251x_spi_trans(spi, 3);
-	val = priv->spi_rx_buf[2];
+	spi_write_then_read(spi, priv->spi_tx_buf, 2, &val, 1);
 
 	return val;
 }
 
 static void mcp251x_read_2regs(struct spi_device *spi, u8 reg, u8 *v1, u8 *v2)
 {
+	u8 val[4] = {0};
 	struct mcp251x_priv *priv = spi_get_drvdata(spi);
 
 	priv->spi_tx_buf[0] = INSTRUCTION_READ;
 	priv->spi_tx_buf[1] = reg;
 
-	mcp251x_spi_trans(spi, 4);
+	spi_write_then_read(spi, priv->spi_tx_buf, 2, val, 2);
 
-	*v1 = priv->spi_rx_buf[2];
-	*v2 = priv->spi_rx_buf[3];
+	*v1 = val[0];
+	*v2 = val[1];
 }
 
 static void mcp251x_write_reg(struct spi_device *spi, u8 reg, u8 val)
-- 
2.7.4

