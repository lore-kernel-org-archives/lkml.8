Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B59EC433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 00:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 705182074D
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 00:09:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbgFPAJr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 20:09:47 -0400
Received: from foss.arm.com ([217.140.110.172]:57002 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726452AbgFPAJo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 20:09:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CD7FC1045;
        Mon, 15 Jun 2020 17:09:43 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 447363F73C;
        Mon, 15 Jun 2020 17:09:42 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     broonie@kernel.org, nsaenzjulienne@suse.de, f.fainelli@gmail.com,
        rjui@broadcom.com, sbranden@broadcom.com
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-spi@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, kernel@martin.sperl.org,
        lukas@wunner.de, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] spi: bcm2835: Micro-optimise FIFO loops
Date:   Tue, 16 Jun 2020 01:09:29 +0100
Message-Id: <9242863077acf9a64e4b3720e479855b88d19e82.1592261248.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.23.0.dirty
In-Reply-To: <cover.1592261248.git.robin.murphy@arm.com>
References: <cover.1592261248.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The blind and counted loops are always called with nonzero count, so
convert them to do-while loops that lead to slightly more efficient
code generation. With GCC 8.3 this shaves off 1-2 instructions per
iteration in each case.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/spi/spi-bcm2835.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index aec70ac8911e..e9a91adf03eb 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -245,13 +245,13 @@ static inline void bcm2835_rd_fifo_count(struct bcm2835_spi *bs, int count)
 
 	bs->rx_len -= count;
 
-	while (count > 0) {
+	do {
 		val = bcm2835_rd(bs, BCM2835_SPI_FIFO);
 		len = min(count, 4);
 		memcpy(bs->rx_buf, &val, len);
 		bs->rx_buf += len;
 		count -= 4;
-	}
+	} while (count > 0);
 }
 
 /**
@@ -271,7 +271,7 @@ static inline void bcm2835_wr_fifo_count(struct bcm2835_spi *bs, int count)
 
 	bs->tx_len -= count;
 
-	while (count > 0) {
+	do {
 		if (bs->tx_buf) {
 			len = min(count, 4);
 			memcpy(&val, bs->tx_buf, len);
@@ -281,7 +281,7 @@ static inline void bcm2835_wr_fifo_count(struct bcm2835_spi *bs, int count)
 		}
 		bcm2835_wr(bs, BCM2835_SPI_FIFO, val);
 		count -= 4;
-	}
+	} while (count > 0);
 }
 
 /**
@@ -310,12 +310,11 @@ static inline void bcm2835_rd_fifo_blind(struct bcm2835_spi *bs, int count)
 	count = min(count, bs->rx_len);
 	bs->rx_len -= count;
 
-	while (count) {
+	do {
 		val = bcm2835_rd(bs, BCM2835_SPI_FIFO);
 		if (bs->rx_buf)
 			*bs->rx_buf++ = val;
-		count--;
-	}
+	} while (--count);
 }
 
 /**
@@ -330,11 +329,10 @@ static inline void bcm2835_wr_fifo_blind(struct bcm2835_spi *bs, int count)
 	count = min(count, bs->tx_len);
 	bs->tx_len -= count;
 
-	while (count) {
+	do {
 		val = bs->tx_buf ? *bs->tx_buf++ : 0;
 		bcm2835_wr(bs, BCM2835_SPI_FIFO, val);
-		count--;
-	}
+	} while (--count);
 }
 
 static void bcm2835_spi_reset_hw(struct bcm2835_spi *bs)
-- 
2.23.0.dirty

