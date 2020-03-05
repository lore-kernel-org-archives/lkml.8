Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96457C3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 14:38:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63CF620732
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 14:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583419082;
	bh=Nq21Zn7lmxw3VMLr+ecx62CvDwEVWmGJ6qp6TAzXBp4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=I2GWCZ4YdgOWAYyzPHlVNPrgIhpFxlxFluxKNfTo7jJBWUP79ti5RhFQ4eNItm36i
	 8nygSU+xiZWfXRXt6o6tpxNk5SJYLa5f50BtFai6Gr422xQ7D6LJAbNautatMxBECQ
	 bv2WpLXqalTdQ2mBtEWWtTm7NnYDwpryt42zeTWE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbgCEOiB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 09:38:01 -0500
Received: from foss.arm.com ([217.140.110.172]:49502 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726204AbgCEOiA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 09:38:00 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5F4361FB;
        Thu,  5 Mar 2020 06:37:59 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D789E3F534;
        Thu,  5 Mar 2020 06:37:58 -0800 (PST)
Date:   Thu, 05 Mar 2020 14:37:57 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     andrew.smirnov@gmail.com, angelo@sysam.it, broonie@kernel.org,
        eha@deif.com, gustavo@embeddedor.com, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        mhosny@nvidia.com, weic@nvidia.com
Subject: Applied "spi: spi-fsl-dspi: Remove unused chip->void_write_data" to the spi tree
In-Reply-To:  <20200304220044.11193-3-olteanv@gmail.com>
Message-Id:  <applied-20200304220044.11193-3-olteanv@gmail.com>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: spi-fsl-dspi: Remove unused chip->void_write_data

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

From 6d6af5796e5d9a88ae83c9c753023bba61deb18b Mon Sep 17 00:00:00 2001
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Thu, 5 Mar 2020 00:00:34 +0200
Subject: [PATCH] spi: spi-fsl-dspi: Remove unused chip->void_write_data

This variable has been present since the initial submission of the
driver, and held, for some reason, the value of zero, to be sent on the
wire in the case there wasn't any TX buffer for the current transfer.

Since quite a while now, however, it isn't doing anything at all.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Link: https://lore.kernel.org/r/20200304220044.11193-3-olteanv@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-fsl-dspi.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 896d7a0f45b0..63ec1d634d08 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -110,7 +110,6 @@
 
 struct chip_data {
 	u32			ctar_val;
-	u16			void_write_data;
 };
 
 enum dspi_trans_mode {
@@ -235,7 +234,6 @@ struct fsl_dspi {
 	const void				*tx;
 	void					*rx;
 	void					*rx_end;
-	u16					void_write_data;
 	u16					tx_cmd;
 	u8					bits_per_word;
 	u8					bytes_per_word;
@@ -795,8 +793,6 @@ static int dspi_transfer_one_message(struct spi_controller *ctlr,
 				dspi->tx_cmd |= SPI_PUSHR_CMD_CONT;
 		}
 
-		dspi->void_write_data = dspi->cur_chip->void_write_data;
-
 		dspi->tx = transfer->tx_buf;
 		dspi->rx = transfer->rx_buf;
 		dspi->rx_end = dspi->rx + transfer->len;
@@ -897,8 +893,6 @@ static int dspi_setup(struct spi_device *spi)
 		sck_cs_delay = pdata->sck_cs_delay;
 	}
 
-	chip->void_write_data = 0;
-
 	clkrate = clk_get_rate(dspi->clk);
 	hz_to_spi_baud(&pbr, &br, spi->max_speed_hz, clkrate);
 
-- 
2.20.1

