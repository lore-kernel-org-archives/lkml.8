Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AFD5C3F2D1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 18:29:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21FBE217F4
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 18:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583346563;
	bh=0J9HGN97mCTEi6VJz79STZBi/uIqq6bjdQoj/rWllCs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=cWnEjVCqpa3047pX/VL4uQt2mJEVYttxFD8cjNucyZ1lloXylP7SUvK58MylmNpl5
	 Ax4vyTtLC3SdrAmUl0nIHm7jkYatZOa29HDTG5TMbqwr+63FuOpBb6cDro2aIrhAyv
	 RtMCcSpm8W3M1BAwbw7stMIDDGB6Hvlk8vyGAt2U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730180AbgCDS3V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 13:29:21 -0500
Received: from foss.arm.com ([217.140.110.172]:38294 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725795AbgCDS3V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 13:29:21 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C25C231B;
        Wed,  4 Mar 2020 10:29:20 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 44F483F6C4;
        Wed,  4 Mar 2020 10:29:20 -0800 (PST)
Date:   Wed, 04 Mar 2020 18:29:18 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     broonie@kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Applied "spi: spi-fsl-dspi: Support SPI software timestamping in all non-DMA modes" to the spi tree
In-Reply-To:  <20200302001958.11105-6-olteanv@gmail.com>
Message-Id:  <applied-20200302001958.11105-6-olteanv@gmail.com>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: spi-fsl-dspi: Support SPI software timestamping in all non-DMA modes

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

From 63669902f74a6133c209fc03109becf5a2141284 Mon Sep 17 00:00:00 2001
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Mon, 2 Mar 2020 02:19:57 +0200
Subject: [PATCH] spi: spi-fsl-dspi: Support SPI software timestamping in all
 non-DMA modes

There's no reason to keep this .ptp_sts_supported property explicitly in
devtype_data, since it can be deduced from the operating mode alone.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Message-Id: <20200302001958.11105-6-olteanv@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-fsl-dspi.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index d21cc5cdc8a4..c26a42f8ecbc 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -122,7 +122,6 @@ enum dspi_trans_mode {
 struct fsl_dspi_devtype_data {
 	enum dspi_trans_mode	trans_mode;
 	u8			max_clock_factor;
-	bool			ptp_sts_supported;
 	bool			xspi_mode;
 	int			fifo_size;
 	int			dma_bufsize;
@@ -150,48 +149,41 @@ static const struct fsl_dspi_devtype_data devtype_data[] = {
 	[LS1021A] = {
 		.trans_mode		= DSPI_TCFQ_MODE,
 		.max_clock_factor	= 8,
-		.ptp_sts_supported	= true,
 		.xspi_mode		= true,
 		.fifo_size		= 4,
 	},
 	[LS1012A] = {
 		.trans_mode		= DSPI_TCFQ_MODE,
 		.max_clock_factor	= 8,
-		.ptp_sts_supported	= true,
 		.xspi_mode		= true,
 		.fifo_size		= 16,
 	},
 	[LS1043A] = {
 		.trans_mode		= DSPI_TCFQ_MODE,
 		.max_clock_factor	= 8,
-		.ptp_sts_supported	= true,
 		.xspi_mode		= true,
 		.fifo_size		= 16,
 	},
 	[LS1046A] = {
 		.trans_mode		= DSPI_TCFQ_MODE,
 		.max_clock_factor	= 8,
-		.ptp_sts_supported	= true,
 		.xspi_mode		= true,
 		.fifo_size		= 16,
 	},
 	[LS2080A] = {
 		.trans_mode		= DSPI_TCFQ_MODE,
 		.max_clock_factor	= 8,
-		.ptp_sts_supported	= true,
 		.xspi_mode		= true,
 		.fifo_size		= 4,
 	},
 	[LS2085A] = {
 		.trans_mode		= DSPI_TCFQ_MODE,
 		.max_clock_factor	= 8,
-		.ptp_sts_supported	= true,
 		.fifo_size		= 4,
 	},
 	[LX2160A] = {
 		.trans_mode		= DSPI_TCFQ_MODE,
 		.max_clock_factor	= 8,
-		.ptp_sts_supported	= true,
 		.xspi_mode		= true,
 		.fifo_size		= 4,
 	},
@@ -1246,7 +1238,8 @@ static int dspi_probe(struct platform_device *pdev)
 	ctlr->max_speed_hz =
 		clk_get_rate(dspi->clk) / dspi->devtype_data->max_clock_factor;
 
-	ctlr->ptp_sts_supported = dspi->devtype_data->ptp_sts_supported;
+	if (dspi->devtype_data->trans_mode != DSPI_DMA_MODE)
+		ctlr->ptp_sts_supported = true;
 
 	platform_set_drvdata(pdev, ctlr);
 
-- 
2.20.1

