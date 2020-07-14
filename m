Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38E6DC433F1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 19:11:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D10422507
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 19:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594753898;
	bh=5xQaXOvzaMzuCHOjvnMhRJ706dOF3RTUM41C/MZ1DuM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=m5CzlTkmkSjHbU1dZvxPuNoD2Y25BxcTf9p0kFN71OwvAHJKqUyV6nq52aJ24AWfN
	 P9SR3PvevXUEkZs/7Ii70tM7RhBL/jxA4jlqmQjeV4obcXqBUR87hgyB1OAyUtEI2a
	 qSqmNslJjccLBxRW7q00oIW6Q5pKdu9F5uYeRXRQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730025AbgGNSsx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 14:48:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:44356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730001AbgGNSso (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 14:48:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D379222B42;
        Tue, 14 Jul 2020 18:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594752524;
        bh=5xQaXOvzaMzuCHOjvnMhRJ706dOF3RTUM41C/MZ1DuM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EdDS+6nnoGJf7V2v6xnzkd6/h+bUSdGYnNIJ0N1/dWJ0b8ZbqcpnqbFzmEBs1LPaT
         mNeDDJnQ39gt4BxeTsaRzBLKXh9NGiKsLxGw4mFC4k7e69naUVvg+Wvq6coFjBTjNs
         AKg156DlkAiPlK8Gkbe0w/z8zRnfOzZXJs27ZHFY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peng Ma <peng.ma@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 002/109] spi: spi-fsl-dspi: Adding shutdown hook
Date:   Tue, 14 Jul 2020 20:43:05 +0200
Message-ID: <20200714184105.636023679@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200714184105.507384017@linuxfoundation.org>
References: <20200714184105.507384017@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Message-ID: <20200714184305.odIfHSMM7WZIHV60sg-bX40RAtNTQ4ICh9u2XQtUpis@z>

From: Peng Ma <peng.ma@nxp.com>

[ Upstream commit dc234825997ec6ff05980ca9e2204f4ac3f8d695 ]

We need to ensure dspi controller could be stopped in order for kexec
to start the next kernel.
So add the shutdown operation support.

Signed-off-by: Peng Ma <peng.ma@nxp.com>
Link: https://lore.kernel.org/r/20200424061216.27445-1-peng.ma@nxp.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-fsl-dspi.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 9a06818d28169..e34278a00b708 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0+
 //
 // Copyright 2013 Freescale Semiconductor, Inc.
+// Copyright 2020 NXP
 //
 // Freescale DSPI driver
 // This file contains a driver for the Freescale DSPI
@@ -33,6 +34,9 @@
 #define SPI_MCR_CLR_TXF			BIT(11)
 #define SPI_MCR_CLR_RXF			BIT(10)
 #define SPI_MCR_XSPI			BIT(3)
+#define SPI_MCR_DIS_TXF			BIT(13)
+#define SPI_MCR_DIS_RXF			BIT(12)
+#define SPI_MCR_HALT			BIT(0)
 
 #define SPI_TCR				0x08
 #define SPI_TCR_GET_TCNT(x)		(((x) & GENMASK(31, 16)) >> 16)
@@ -1169,6 +1173,24 @@ static int dspi_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static void dspi_shutdown(struct platform_device *pdev)
+{
+	struct spi_controller *ctlr = platform_get_drvdata(pdev);
+	struct fsl_dspi *dspi = spi_controller_get_devdata(ctlr);
+
+	/* Disable RX and TX */
+	regmap_update_bits(dspi->regmap, SPI_MCR,
+			   SPI_MCR_DIS_TXF | SPI_MCR_DIS_RXF,
+			   SPI_MCR_DIS_TXF | SPI_MCR_DIS_RXF);
+
+	/* Stop Running */
+	regmap_update_bits(dspi->regmap, SPI_MCR, SPI_MCR_HALT, SPI_MCR_HALT);
+
+	dspi_release_dma(dspi);
+	clk_disable_unprepare(dspi->clk);
+	spi_unregister_controller(dspi->ctlr);
+}
+
 static struct platform_driver fsl_dspi_driver = {
 	.driver.name		= DRIVER_NAME,
 	.driver.of_match_table	= fsl_dspi_dt_ids,
@@ -1176,6 +1198,7 @@ static struct platform_driver fsl_dspi_driver = {
 	.driver.pm		= &dspi_pm,
 	.probe			= dspi_probe,
 	.remove			= dspi_remove,
+	.shutdown		= dspi_shutdown,
 };
 module_platform_driver(fsl_dspi_driver);
 
-- 
2.25.1



