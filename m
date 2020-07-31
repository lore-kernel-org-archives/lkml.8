Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A17B2C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 08:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88C12208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 08:00:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731887AbgGaIAX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 04:00:23 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:59752 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731671AbgGaIAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 04:00:04 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id E898E8040A6C;
        Fri, 31 Jul 2020 08:00:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id qMeaNV9clg4S; Fri, 31 Jul 2020 11:00:01 +0300 (MSK)
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Mark Brown <broonie@kernel.org>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Feng Tang <feng.tang@intel.com>, Vinod Koul <vkoul@kernel.org>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 6/8] spi: dw-dma: Move DMAC register cleanup to DMA transfer method
Date:   Fri, 31 Jul 2020 10:59:51 +0300
Message-ID: <20200731075953.14416-7-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20200731075953.14416-1-Sergey.Semin@baikalelectronics.ru>
References: <20200731075953.14416-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DW APB SSI DMA driver doesn't use the native SPI core wait API since
commit bdbdf0f06337 ("spi: dw: Locally wait for the DMA transfers
completion"). Due to that the driver can now clear the DMAC register
in a single place synchronously with the DMA transactions completion
or failure. After that all the possible code paths are still covered:
1) DMA completion callbacks are executed in case if the corresponding DMA
transactions are finished. When they are, one of them will eventually wake
the SPI messages pump kernel thread and dw_spi_dma_transfer_all() method
will clean the DMAC register as implied by this patch.
2) dma_stop is called when the SPI core detects an error either returned
from the transfer_one() callback or set in the SPI message status field.
Both types of errors will be noticed by the dw_spi_dma_transfer_all()
method.
3) dma_exit is called when either SPI controller driver or the
corresponding device is removed. In any case the SPI core will first
flush the SPI messages pump kernel thread, so any pending or in-fly
SPI transfers will be finished before that.

Due to all of that let's simplify the DW APB SSI DMA driver a bit and
move the DMAC register cleanup to a single place in the
dw_spi_dma_transfer_all() method.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 drivers/spi/spi-dw-dma.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-dw-dma.c b/drivers/spi/spi-dw-dma.c
index 32ef7913a73d..f8508c0c7978 100644
--- a/drivers/spi/spi-dw-dma.c
+++ b/drivers/spi/spi-dw-dma.c
@@ -153,8 +153,6 @@ static void dw_spi_dma_exit(struct dw_spi *dws)
 		dmaengine_terminate_sync(dws->rxchan);
 		dma_release_channel(dws->rxchan);
 	}
-
-	dw_writel(dws, DW_SPI_DMACR, 0);
 }
 
 static irqreturn_t dw_spi_dma_transfer_handler(struct dw_spi *dws)
@@ -253,7 +251,6 @@ static void dw_spi_dma_tx_done(void *arg)
 	if (test_bit(RX_BUSY, &dws->dma_chan_busy))
 		return;
 
-	dw_writel(dws, DW_SPI_DMACR, 0);
 	complete(&dws->dma_completion);
 }
 
@@ -352,7 +349,6 @@ static void dw_spi_dma_rx_done(void *arg)
 	if (test_bit(TX_BUSY, &dws->dma_chan_busy))
 		return;
 
-	dw_writel(dws, DW_SPI_DMACR, 0);
 	complete(&dws->dma_completion);
 }
 
@@ -442,13 +438,13 @@ static int dw_spi_dma_transfer_all(struct dw_spi *dws,
 	/* Submit DMA Tx transfer */
 	ret = dw_spi_dma_submit_tx(dws, xfer);
 	if (ret)
-		return ret;
+		goto err_clear_dmac;
 
 	/* Submit DMA Rx transfer if required */
 	if (xfer->rx_buf) {
 		ret = dw_spi_dma_submit_rx(dws, xfer);
 		if (ret)
-			return ret;
+			goto err_clear_dmac;
 
 		/* rx must be started before tx due to spi instinct */
 		dma_async_issue_pending(dws->rxchan);
@@ -456,7 +452,12 @@ static int dw_spi_dma_transfer_all(struct dw_spi *dws,
 
 	dma_async_issue_pending(dws->txchan);
 
-	return dw_spi_dma_wait(dws, xfer);
+	ret = dw_spi_dma_wait(dws, xfer);
+
+err_clear_dmac:
+	dw_writel(dws, DW_SPI_DMACR, 0);
+
+	return ret;
 }
 
 static int dw_spi_dma_transfer(struct dw_spi *dws, struct spi_transfer *xfer)
@@ -489,8 +490,6 @@ static void dw_spi_dma_stop(struct dw_spi *dws)
 		dmaengine_terminate_sync(dws->rxchan);
 		clear_bit(RX_BUSY, &dws->dma_chan_busy);
 	}
-
-	dw_writel(dws, DW_SPI_DMACR, 0);
 }
 
 static const struct dw_spi_dma_ops dw_spi_dma_mfld_ops = {
-- 
2.27.0

