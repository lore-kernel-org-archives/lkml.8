Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E22D1C3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 07:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B89FF2467D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 07:33:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=walle.cc header.i=@walle.cc header.b="iBIzRz55"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbgCJHdc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 03:33:32 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:53173 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726195AbgCJHdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 03:33:31 -0400
Received: from mwalle01.sab.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 70E5923EDA;
        Tue, 10 Mar 2020 08:33:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1583825609;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=mGzo69y07vEikBiBYw51X7LqR4nXAnMjmqLFsIzeY0g=;
        b=iBIzRz5537ewx9ux46LYo3F+UVQAT5T+jWgeQUuy0Z2+rqVnvLuzdJdGcrHnuJm57LNSI7
        wv+B3Bz284fy9Fm5iJfq/n7ztHPr6dGnAFwWVgtNGWWahZ1FbKW7uq9FePGHSwf9oxpa25
        ChDL8L9SrCV4wdUYnlf0H7omv4G++f0=
From:   Michael Walle <michael@walle.cc>
To:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org
Cc:     Sumit Semwal <sumit.semwal@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH] spi: spi-fsl-dspi: fix DMA mapping
Date:   Tue, 10 Mar 2020 08:33:13 +0100
Message-Id: <20200310073313.21277-1-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: ++++
X-Rspamd-Server: web
X-Rspamd-Queue-Id: 70E5923EDA
X-Spamd-Result: default: False [4.90 / 15.00];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         NEURAL_SPAM(0.00)[0.643];
         BROKEN_CONTENT_TYPE(1.50)[];
         DKIM_SIGNED(0.00)[];
         RCPT_COUNT_SEVEN(0.00)[9];
         MID_CONTAINS_FROM(1.00)[];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         ASN(0.00)[asn:12941, ipnet:213.135.0.0/19, country:DE]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the correct device to request the DMA mapping. Otherwise the IOMMU
doesn't get the mapping and it will generate a page fault.

The error messages look like:
[    3.008452] arm-smmu 5000000.iommu: Unhandled context fault: fsr=0x402, iova=0xf9800000, fsynr=0x3f0022, cbfrsynra=0x828, cb=8
[    3.020123] arm-smmu 5000000.iommu: Unhandled context fault: fsr=0x402, iova=0xf9800000, fsynr=0x3f0022, cbfrsynra=0x828, cb=8

This was tested on a custom board with a LS1028A SoC.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 drivers/spi/spi-fsl-dspi.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index cf8a141bbaf2..ad63804ef690 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -510,14 +510,16 @@ static int dspi_request_dma(struct fsl_dspi *dspi, phys_addr_t phy_addr)
 		goto err_tx_channel;
 	}
 
-	dma->tx_dma_buf = dma_alloc_coherent(dev, dspi->devtype_data->dma_bufsize,
+	dma->tx_dma_buf = dma_alloc_coherent(dma->chan_tx->device->dev,
+					     dspi->devtype_data->dma_bufsize,
 					     &dma->tx_dma_phys, GFP_KERNEL);
 	if (!dma->tx_dma_buf) {
 		ret = -ENOMEM;
 		goto err_tx_dma_buf;
 	}
 
-	dma->rx_dma_buf = dma_alloc_coherent(dev, dspi->devtype_data->dma_bufsize,
+	dma->rx_dma_buf = dma_alloc_coherent(dma->chan_rx->device->dev,
+					     dspi->devtype_data->dma_bufsize,
 					     &dma->rx_dma_phys, GFP_KERNEL);
 	if (!dma->rx_dma_buf) {
 		ret = -ENOMEM;
@@ -554,10 +556,12 @@ static int dspi_request_dma(struct fsl_dspi *dspi, phys_addr_t phy_addr)
 	return 0;
 
 err_slave_config:
-	dma_free_coherent(dev, dspi->devtype_data->dma_bufsize,
+	dma_free_coherent(dma->chan_rx->device->dev,
+			  dspi->devtype_data->dma_bufsize,
 			  dma->rx_dma_buf, dma->rx_dma_phys);
 err_rx_dma_buf:
-	dma_free_coherent(dev, dspi->devtype_data->dma_bufsize,
+	dma_free_coherent(dma->chan_tx->device->dev,
+			  dspi->devtype_data->dma_bufsize,
 			  dma->tx_dma_buf, dma->tx_dma_phys);
 err_tx_dma_buf:
 	dma_release_channel(dma->chan_tx);
@@ -573,20 +577,19 @@ static int dspi_request_dma(struct fsl_dspi *dspi, phys_addr_t phy_addr)
 static void dspi_release_dma(struct fsl_dspi *dspi)
 {
 	struct fsl_dspi_dma *dma = dspi->dma;
-	struct device *dev = &dspi->pdev->dev;
 
 	if (!dma)
 		return;
 
 	if (dma->chan_tx) {
-		dma_unmap_single(dev, dma->tx_dma_phys,
+		dma_unmap_single(dma->chan_tx->device->dev, dma->tx_dma_phys,
 				 dspi->devtype_data->dma_bufsize,
 				 DMA_TO_DEVICE);
 		dma_release_channel(dma->chan_tx);
 	}
 
 	if (dma->chan_rx) {
-		dma_unmap_single(dev, dma->rx_dma_phys,
+		dma_unmap_single(dma->chan_rx->device->dev, dma->rx_dma_phys,
 				 dspi->devtype_data->dma_bufsize,
 				 DMA_FROM_DEVICE);
 		dma_release_channel(dma->chan_rx);
-- 
2.20.1

