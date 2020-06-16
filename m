Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CA4FC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 00:09:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AA202074D
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 00:09:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbgFPAJm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 20:09:42 -0400
Received: from foss.arm.com ([217.140.110.172]:56968 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726452AbgFPAJl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 20:09:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 457A531B;
        Mon, 15 Jun 2020 17:09:40 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B11E93F73C;
        Mon, 15 Jun 2020 17:09:38 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     broonie@kernel.org, nsaenzjulienne@suse.de, f.fainelli@gmail.com,
        rjui@broadcom.com, sbranden@broadcom.com
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-spi@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, kernel@martin.sperl.org,
        lukas@wunner.de, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] spi: bcm3835: Tidy up bcm2835_spi_reset_hw()
Date:   Tue, 16 Jun 2020 01:09:27 +0100
Message-Id: <eca458ae1a0d3934d0627f90e25d294fefd4b13d.1592261248.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.23.0.dirty
In-Reply-To: <cover.1592261248.git.robin.murphy@arm.com>
References: <cover.1592261248.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It doesn't need a struct spi_controller, and every callsite has
already retrieved the appropriate struct bcm2835_spi, so just pass
that directly.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/spi/spi-bcm2835.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index 237bd306c268..524a91e52111 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -335,9 +335,8 @@ static inline void bcm2835_wr_fifo_blind(struct bcm2835_spi *bs, int count)
 	}
 }
 
-static void bcm2835_spi_reset_hw(struct spi_controller *ctlr)
+static void bcm2835_spi_reset_hw(struct bcm2835_spi *bs)
 {
-	struct bcm2835_spi *bs = spi_controller_get_devdata(ctlr);
 	u32 cs = bcm2835_rd(bs, BCM2835_SPI_CS);
 
 	/* Disable SPI interrupts and transfer */
@@ -386,7 +385,7 @@ static irqreturn_t bcm2835_spi_interrupt(int irq, void *dev_id)
 
 	if (!bs->rx_len) {
 		/* Transfer complete - reset SPI HW */
-		bcm2835_spi_reset_hw(ctlr);
+		bcm2835_spi_reset_hw(bs);
 		/* wake up the framework */
 		complete(&ctlr->xfer_completion);
 	}
@@ -607,7 +606,7 @@ static void bcm2835_spi_dma_rx_done(void *data)
 	bcm2835_spi_undo_prologue(bs);
 
 	/* reset fifo and HW */
-	bcm2835_spi_reset_hw(ctlr);
+	bcm2835_spi_reset_hw(bs);
 
 	/* and mark as completed */;
 	complete(&ctlr->xfer_completion);
@@ -641,7 +640,7 @@ static void bcm2835_spi_dma_tx_done(void *data)
 		dmaengine_terminate_async(ctlr->dma_rx);
 
 	bcm2835_spi_undo_prologue(bs);
-	bcm2835_spi_reset_hw(ctlr);
+	bcm2835_spi_reset_hw(bs);
 	complete(&ctlr->xfer_completion);
 }
 
@@ -825,14 +824,14 @@ static int bcm2835_spi_transfer_one_dma(struct spi_controller *ctlr,
 	if (!bs->rx_buf && !bs->tx_dma_active &&
 	    cmpxchg(&bs->rx_dma_active, true, false)) {
 		dmaengine_terminate_async(ctlr->dma_rx);
-		bcm2835_spi_reset_hw(ctlr);
+		bcm2835_spi_reset_hw(bs);
 	}
 
 	/* wait for wakeup in framework */
 	return 1;
 
 err_reset_hw:
-	bcm2835_spi_reset_hw(ctlr);
+	bcm2835_spi_reset_hw(bs);
 	bcm2835_spi_undo_prologue(bs);
 	return ret;
 }
@@ -1074,7 +1073,7 @@ static int bcm2835_spi_transfer_one_poll(struct spi_controller *ctlr,
 	}
 
 	/* Transfer complete - reset SPI HW */
-	bcm2835_spi_reset_hw(ctlr);
+	bcm2835_spi_reset_hw(bs);
 	/* and return without waiting for completion */
 	return 0;
 }
@@ -1182,7 +1181,7 @@ static void bcm2835_spi_handle_err(struct spi_controller *ctlr,
 	bcm2835_spi_undo_prologue(bs);
 
 	/* and reset */
-	bcm2835_spi_reset_hw(ctlr);
+	bcm2835_spi_reset_hw(bs);
 }
 
 static int chip_match_name(struct gpio_chip *chip, void *data)
-- 
2.23.0.dirty

