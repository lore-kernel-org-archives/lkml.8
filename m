Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22E01C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 18:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E83D1222C2
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 18:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581704372;
	bh=m4jyVE18pfZq4qi+TJEPKig9Dd0guUKdRgNJXmVZibI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PM2/+iLDUYZkHtvkpipw1vW7DxBU8YSrXU5xxPOrTlZxiXlCUb5gDzwOP/qjJ/K15
	 1ImSXGAUd9wI1gy0WA5gaGbE3TJZ9oPveq2Hna0qU3pRcanU1iH/XwTH+HDrIZn0oi
	 8Rwa7dVncfuKyd0scouo2WXoqriUQMta0IHnK/a0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394739AbgBNSTa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 13:19:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:54550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729781AbgBNPu2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 10:50:28 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF4962467E;
        Fri, 14 Feb 2020 15:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581695427;
        bh=m4jyVE18pfZq4qi+TJEPKig9Dd0guUKdRgNJXmVZibI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dZr/O+vnE8G4O7dcz2WBPSln8ZtVCNay0xOrOwOEM7YOGA9mH4No0ceUgBJFeSgiF
         JoBltEAnY0f58S9FUE4/wiuL7LOHxgSOs8kfCssloMx1dyFmHddtNzt1+g57S8vIyZ
         7z68xbNYtMwP9mfnTW58PyPSJN9SdfCDnX/gzD3U=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Philippe Schenker <philippe.schenker@toradex.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-spi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.5 071/542] spi: fsl-lpspi: fix only one cs-gpio working
Date:   Fri, 14 Feb 2020 10:41:03 -0500
Message-Id: <20200214154854.6746-71-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214154854.6746-1-sashal@kernel.org>
References: <20200214154854.6746-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Philippe Schenker <philippe.schenker@toradex.com>

[ Upstream commit bc3a8b295e5bca9d1ec2622a6ba38289f9fd3d8a ]

Why it does not work at the moment:
- num_chipselect sets the number of cs-gpios that are in the DT.
  This comes from drivers/spi/spi.c
- num_chipselect gets set with devm_spi_register_controller, that is
  called in drivers/spi/spi.c
- devm_spi_register_controller got called after num_chipselect has
  been used.

How this commit fixes the issue:
- devm_spi_register_controller gets called before num_chipselect is
  being used.

Fixes: c7a402599504 ("spi: lpspi: use the core way to implement cs-gpio function")
Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
Link: https://lore.kernel.org/r/20191204141312.1411251-1-philippe.schenker@toradex.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-fsl-lpspi.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index 2cc0ddb4a9889..1375bdfc587bf 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -862,6 +862,22 @@ static int fsl_lpspi_probe(struct platform_device *pdev)
 	fsl_lpspi->dev = &pdev->dev;
 	fsl_lpspi->is_slave = is_slave;
 
+	controller->bits_per_word_mask = SPI_BPW_RANGE_MASK(8, 32);
+	controller->transfer_one = fsl_lpspi_transfer_one;
+	controller->prepare_transfer_hardware = lpspi_prepare_xfer_hardware;
+	controller->unprepare_transfer_hardware = lpspi_unprepare_xfer_hardware;
+	controller->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
+	controller->flags = SPI_MASTER_MUST_RX | SPI_MASTER_MUST_TX;
+	controller->dev.of_node = pdev->dev.of_node;
+	controller->bus_num = pdev->id;
+	controller->slave_abort = fsl_lpspi_slave_abort;
+
+	ret = devm_spi_register_controller(&pdev->dev, controller);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "spi_register_controller error.\n");
+		goto out_controller_put;
+	}
+
 	if (!fsl_lpspi->is_slave) {
 		for (i = 0; i < controller->num_chipselect; i++) {
 			int cs_gpio = of_get_named_gpio(np, "cs-gpios", i);
@@ -885,16 +901,6 @@ static int fsl_lpspi_probe(struct platform_device *pdev)
 		controller->prepare_message = fsl_lpspi_prepare_message;
 	}
 
-	controller->bits_per_word_mask = SPI_BPW_RANGE_MASK(8, 32);
-	controller->transfer_one = fsl_lpspi_transfer_one;
-	controller->prepare_transfer_hardware = lpspi_prepare_xfer_hardware;
-	controller->unprepare_transfer_hardware = lpspi_unprepare_xfer_hardware;
-	controller->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
-	controller->flags = SPI_MASTER_MUST_RX | SPI_MASTER_MUST_TX;
-	controller->dev.of_node = pdev->dev.of_node;
-	controller->bus_num = pdev->id;
-	controller->slave_abort = fsl_lpspi_slave_abort;
-
 	init_completion(&fsl_lpspi->xfer_done);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -952,12 +958,6 @@ static int fsl_lpspi_probe(struct platform_device *pdev)
 	if (ret < 0)
 		dev_err(&pdev->dev, "dma setup error %d, use pio\n", ret);
 
-	ret = devm_spi_register_controller(&pdev->dev, controller);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "spi_register_controller error.\n");
-		goto out_controller_put;
-	}
-
 	return 0;
 
 out_controller_put:
-- 
2.20.1

