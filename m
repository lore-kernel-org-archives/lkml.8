Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B38C47256
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 06:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9084520714
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 06:20:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbgEFGUB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 02:20:01 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:60946 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726480AbgEFGUB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 02:20:01 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 3247C663FE700C20C1EF;
        Wed,  6 May 2020 14:19:59 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Wed, 6 May 2020
 14:19:49 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <broonie@kernel.org>, <yanaijie@huawei.com>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] spi: a3700: make a3700_spi_init() return void
Date:   Wed, 6 May 2020 14:19:11 +0800
Message-ID: <20200506061911.19923-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warning:

drivers/spi/spi-armada-3700.c:283:8-11: Unneeded variable: "ret". Return
"0" on line 315

Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/spi/spi-armada-3700.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-armada-3700.c b/drivers/spi/spi-armada-3700.c
index e450ee17787f..fcde419e480c 100644
--- a/drivers/spi/spi-armada-3700.c
+++ b/drivers/spi/spi-armada-3700.c
@@ -276,11 +276,11 @@ static int a3700_spi_fifo_flush(struct a3700_spi *a3700_spi)
 	return -ETIMEDOUT;
 }
 
-static int a3700_spi_init(struct a3700_spi *a3700_spi)
+static void a3700_spi_init(struct a3700_spi *a3700_spi)
 {
 	struct spi_master *master = a3700_spi->master;
 	u32 val;
-	int i, ret = 0;
+	int i;
 
 	/* Reset SPI unit */
 	val = spireg_read(a3700_spi, A3700_SPI_IF_CFG_REG);
@@ -311,8 +311,6 @@ static int a3700_spi_init(struct a3700_spi *a3700_spi)
 	/* Mask the interrupts and clear cause bits */
 	spireg_write(a3700_spi, A3700_SPI_INT_MASK_REG, 0);
 	spireg_write(a3700_spi, A3700_SPI_INT_STAT_REG, ~0U);
-
-	return ret;
 }
 
 static irqreturn_t a3700_spi_interrupt(int irq, void *dev_id)
@@ -886,9 +884,7 @@ static int a3700_spi_probe(struct platform_device *pdev)
 	master->min_speed_hz = DIV_ROUND_UP(clk_get_rate(spi->clk),
 						A3700_SPI_MAX_PRESCALE);
 
-	ret = a3700_spi_init(spi);
-	if (ret)
-		goto error_clk;
+	a3700_spi_init(spi);
 
 	ret = devm_request_irq(dev, spi->irq, a3700_spi_interrupt, 0,
 			       dev_name(dev), master);
-- 
2.21.1

