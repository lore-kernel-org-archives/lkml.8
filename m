Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5AEBC35641
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:38:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA16520578
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582274284;
	bh=qXBQpGHuxOcxtmfWos87rZV4Lw8QLXlsO+sJcM2OHFU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xF/NUYmcqzSKErJqpHTeiHuOUiFvIzilH+vTua4dNrkUbm6DNSPXrTKi3To6ScNYV
	 Dkwcawke8Uib8erFCNS2opwBzO5heLBBJQn9koK6n3Vj1qqH6ldgxQb10iVo81YFWX
	 lg4BafujiZxrPBiaE832RLedWLXErdLvNXVpzNAE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731714AbgBUIiD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 03:38:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:36332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731484AbgBUIDc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 03:03:32 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 305B62073A;
        Fri, 21 Feb 2020 08:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582272211;
        bh=qXBQpGHuxOcxtmfWos87rZV4Lw8QLXlsO+sJcM2OHFU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EmtMvusYMpWzptcPmz/LKzIcDP6bQRDhkcdwexVkgVSBgbMHkE6DoqCrQf8isyXqA
         +mE/t36ZhG+kz+FvCtr1h+b/PyplcHpfpogFhI+0LGfQQNKAMVMcSxZqLss8TwiwOY
         ClIvTMV1BWHZkeO4dgFNG0B6uYjOW05aFxJzu2fs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 057/344] spi: fsl-lpspi: fix only one cs-gpio working
Date:   Fri, 21 Feb 2020 08:37:36 +0100
Message-Id: <20200221072354.228024212@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200221072349.335551332@linuxfoundation.org>
References: <20200221072349.335551332@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index 3528ed5eea9b5..92e460d4f3d10 100644
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



