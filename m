Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC234C3F2CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 14:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B166B20732
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 14:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583419036;
	bh=TMu1XlUsxXBLWcxCeBBNE3wS1X3+6iruFXtBq+3ZRFg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=UHRvdLthg2fmN1BmOmWzNPYVTNaBGNcanTBkhuCpIafs2dOEGG6GR9BEmg9to6eop
	 GVy8xu+lOfxWo0tTRHzxiEyKdEfNpDMWYrKWJ0oFCnj/XufsdWc/F4EFSWMBpvuSwf
	 9DOXDvR0ZcM5sTe9xXMgq+GK3IAQ246OmNjEf9do=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbgCEOhQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 09:37:16 -0500
Received: from foss.arm.com ([217.140.110.172]:49294 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726092AbgCEOhP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 09:37:15 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 025461FB;
        Thu,  5 Mar 2020 06:37:15 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7A47D3F534;
        Thu,  5 Mar 2020 06:37:14 -0800 (PST)
Date:   Thu, 05 Mar 2020 14:37:13 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     andrew.smirnov@gmail.com, angelo@sysam.it, broonie@kernel.org,
        eha@deif.com, gustavo@embeddedor.com, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        mhosny@nvidia.com, weic@nvidia.com
Subject: Applied "spi: spi-fsl-dspi: Take software timestamp in dspi_fifo_write" to the spi tree
In-Reply-To:  <20200304220044.11193-13-olteanv@gmail.com>
Message-Id:  <applied-20200304220044.11193-13-olteanv@gmail.com>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: spi-fsl-dspi: Take software timestamp in dspi_fifo_write

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From e9bac90036d394b01cc7d5297a11d33b8ab92a91 Mon Sep 17 00:00:00 2001
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Thu, 5 Mar 2020 00:00:44 +0200
Subject: [PATCH] spi: spi-fsl-dspi: Take software timestamp in dspi_fifo_write

Although the SPI system timestamps are supposed to reflect the moment
that the peripheral has received a word rather than the moment when the
CPU has enqueued that word to the FIFO, in practice it is easier to just
record the latter time than the former (with a smaller error).

With the recent migration of TCFQ users from poll back to interrupt mode
(this time for XSPI FIFO), it's wiser to keep the interrupt latency
outside of the measurement of the PTP system timestamp itself. If there
proves to be any constant offset that requires static compensation, that
can always be added later. So far that does not appear to be the case at
least on the LS1021A-TSN board, where testing shows that the phc2sys
offset is able to remain within +/- 200 ns even after 68 hours of
testing.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Link: https://lore.kernel.org/r/20200304220044.11193-13-olteanv@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-fsl-dspi.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index d5983be32180..b5ab0afbfa26 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -838,19 +838,18 @@ static void dspi_setup_accel(struct fsl_dspi *dspi)
 
 static void dspi_fifo_write(struct fsl_dspi *dspi)
 {
+	struct spi_transfer *xfer = dspi->cur_transfer;
+	struct spi_message *msg = dspi->cur_msg;
+	int bytes_sent;
+
 	dspi_setup_accel(dspi);
 
+	spi_take_timestamp_pre(dspi->ctlr, xfer, dspi->progress, !dspi->irq);
+
 	if (dspi->devtype_data->trans_mode == DSPI_EOQ_MODE)
 		dspi_eoq_fifo_write(dspi);
 	else
 		dspi_xspi_fifo_write(dspi);
-}
-
-static int dspi_rxtx(struct fsl_dspi *dspi)
-{
-	struct spi_transfer *xfer = dspi->cur_transfer;
-	struct spi_message *msg = dspi->cur_msg;
-	int bytes_sent;
 
 	/* Update total number of bytes that were transferred */
 	bytes_sent = dspi->words_in_flight * dspi->oper_word_size;
@@ -859,16 +858,16 @@ static int dspi_rxtx(struct fsl_dspi *dspi)
 
 	spi_take_timestamp_post(dspi->ctlr, dspi->cur_transfer,
 				dspi->progress, !dspi->irq);
+}
 
+static int dspi_rxtx(struct fsl_dspi *dspi)
+{
 	dspi_fifo_read(dspi);
 
 	if (!dspi->len)
 		/* Success! */
 		return 0;
 
-	spi_take_timestamp_pre(dspi->ctlr, dspi->cur_transfer,
-			       dspi->progress, !dspi->irq);
-
 	dspi_fifo_write(dspi);
 
 	return -EINPROGRESS;
-- 
2.20.1

