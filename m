Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FE1CC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 13:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49AE2207BB
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 13:12:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=puresoftware-com.20150623.gappssmtp.com header.i=@puresoftware-com.20150623.gappssmtp.com header.b="1onrWeHH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728745AbgHUNMM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 09:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728424AbgHUNMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 09:12:08 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1523C061386
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 06:12:07 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id p37so989442pgl.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 06:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=puresoftware-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=D2PwpsMUTCasLz9FqCzUHUP5KXb5LPz5R+x6aX8WiZQ=;
        b=1onrWeHHMmDVknpA2uV25ha9IJr0G5mTStI8ZlUbClOQix1A+pPdhjnagMz/u4XR65
         qDAk6aPswygvKlb9PqI7ZKCOdUyGppai4bsY/M7TUb91W7908R2FrpRbMaY9+KfA7YgH
         qEdalhB8uYl50TiRpFs+7n8BpXTjpviu6lC1XRKpMQF7yqFz8taEWWOpKwaK0kpFWoTZ
         GNUle4PRsbS16PtZzBmXzfoUrG5xTZCUkt3Kv/aNIAKSvzWLeJJ5Wz5bkewNlBfLheKV
         Sv7fZy+d66IcfsVfp2FrUBGzXu0b4vkuUY5hI0kooIvRZxawjobiWs2hKuMFWHK5JdFi
         890g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=D2PwpsMUTCasLz9FqCzUHUP5KXb5LPz5R+x6aX8WiZQ=;
        b=mMr4BSc5e3NAMag0g/cytXRFFqZzqEq7w4NhsBF5Ta8bsDIdWk8wL1HaHnasRcB504
         8sJHMxiF78j5NtlJmh7EmAJyaZBCPrpu2BQJ+iFHGWeYxNrjNyfHKFA7sNWsWZkcp+k2
         45tACmtdlqnoS2e6mqUqAKu58D6ajYnDqSdzZ339c3Kh/FUq3q6l0Qn+n2RGrGbYVNlO
         vVxv0rR7Io1kkdkrTX6GHfd4+eCbS8z8jrKfc5qzpQHrGGGeNV1oljoUz3fUQDJEdEne
         xJwA00MxEXNjFAGCxo2nZALpP8sIcRvH6B94qF9y6SQs70biVSKDj72VekDJ/cwa8+GL
         4w1g==
X-Gm-Message-State: AOAM531GOwfs6Qghz3okRHjEPgFWGicGmdow3KdhBoIOOyjfwmKD3QQV
        csX2FFm6vs5gXk2iDa2r01FpOg==
X-Google-Smtp-Source: ABdhPJzfb0gN2abYX4GdmaZSHtC8hbDKtREiTizuy/pbCL5T4rwYku3c2SEIQzNgqnnRz+2iLNBuoA==
X-Received: by 2002:a62:1dc3:: with SMTP id d186mr2475579pfd.93.1598015526392;
        Fri, 21 Aug 2020 06:12:06 -0700 (PDT)
Received: from DESKTOP-C4AMQCQ.domain.name ([106.215.106.193])
        by smtp.gmail.com with ESMTPSA id l4sm2147732pgk.74.2020.08.21.06.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 06:12:05 -0700 (PDT)
From:   kuldip dwivedi <kuldip.dwivedi@puresoftware.com>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Qiang Zhao <qiang.zhao@nxp.com>,
        Pankaj Bansal <pankaj.bansal@nxp.com>,
        Varun Sethi <V.Sethi@nxp.com>,
        kuldip dwivedi <kuldip.dwivedi@puresoftware.com>,
        tanveer <tanveer.alam@puresoftware.com>
Subject: [PATCH] spi: spi-fsl-dspi: Add ACPI support
Date:   Fri, 21 Aug 2020 18:40:29 +0530
Message-Id: <20200821131029.11440-1-kuldip.dwivedi@puresoftware.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently fsl DSPI driver has support of DT only. Adding ACPI
support to the drive so that it can be used by UEFI firmware
boot in ACPI mode. This driver will be probed if any firmware
will expose HID "NXP0005" in DSDT table.

Signed-off-by: tanveer <tanveer.alam@puresoftware.com>
Signed-off-by: kuldip dwivedi <kuldip.dwivedi@puresoftware.com>
---
 drivers/spi/spi-fsl-dspi.c | 91 +++++++++++++++++++++++++++++---------
 1 file changed, 69 insertions(+), 22 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 91c6affe139c..7100a8a0a30e 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -2,10 +2,12 @@
 //
 // Copyright 2013 Freescale Semiconductor, Inc.
 // Copyright 2020 NXP
+// Copyright 2020 Puresoftware Ltd.
 //
 // Freescale DSPI driver
 // This file contains a driver for the Freescale DSPI
 
+#include <linux/acpi.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/dmaengine.h>
@@ -1070,6 +1072,12 @@ static void dspi_cleanup(struct spi_device *spi)
 	kfree(chip);
 }
 
+static const struct acpi_device_id fsl_dspi_acpi_ids[] = {
+	{ "NXP0005", .driver_data = (kernel_ulong_t)&devtype_data[LS2085A], },
+	{},
+};
+MODULE_DEVICE_TABLE(acpi, fsl_dspi_acpi_ids);
+
 static const struct of_device_id fsl_dspi_dt_ids[] = {
 	{
 		.compatible = "fsl,vf610-dspi",
@@ -1272,6 +1280,7 @@ static int dspi_probe(struct platform_device *pdev)
 	struct resource *res;
 	void __iomem *base;
 	bool big_endian;
+	u32 clk_rate;
 
 	ctlr = spi_alloc_master(&pdev->dev, sizeof(struct fsl_dspi));
 	if (!ctlr)
@@ -1300,20 +1309,41 @@ static int dspi_probe(struct platform_device *pdev)
 		big_endian = true;
 	} else {
 
-		ret = of_property_read_u32(np, "spi-num-chipselects", &cs_num);
+		if (is_acpi_node(pdev->dev.fwnode))
+			ret = device_property_read_u32(&pdev->dev,
+					"spi-num-chipselects", &cs_num);
+		else
+			ret = of_property_read_u32(np,
+					"spi-num-chipselects", &cs_num);
 		if (ret < 0) {
 			dev_err(&pdev->dev, "can't get spi-num-chipselects\n");
 			goto out_ctlr_put;
 		}
 		ctlr->num_chipselect = cs_num;
 
-		of_property_read_u32(np, "bus-num", &bus_num);
+		if (is_acpi_node(pdev->dev.fwnode)) {
+			ret = device_property_read_u32(&pdev->dev,
+							"bus-num", &bus_num);
+			if (ret < 0) {
+				dev_err(&pdev->dev, "can't get bus-num\n");
+				goto out_ctlr_put;
+			}
+		} else {
+			of_property_read_u32(np, "bus-num", &bus_num);
+		}
 		ctlr->bus_num = bus_num;
 
-		if (of_property_read_bool(np, "spi-slave"))
-			ctlr->slave = true;
+		if (!is_acpi_node(pdev->dev.fwnode)) {
+			if (of_property_read_bool(np, "spi-slave"))
+				ctlr->slave = true;
+		}
+
+		if (is_acpi_node(pdev->dev.fwnode))
+			dspi->devtype_data = device_get_match_data(&pdev->dev);
+		else
+			dspi->devtype_data =
+				of_device_get_match_data(&pdev->dev);
 
-		dspi->devtype_data = of_device_get_match_data(&pdev->dev);
 		if (!dspi->devtype_data) {
 			dev_err(&pdev->dev, "can't get devtype_data\n");
 			ret = -EFAULT;
@@ -1367,15 +1397,18 @@ static int dspi_probe(struct platform_device *pdev)
 		}
 	}
 
-	dspi->clk = devm_clk_get(&pdev->dev, "dspi");
-	if (IS_ERR(dspi->clk)) {
-		ret = PTR_ERR(dspi->clk);
-		dev_err(&pdev->dev, "unable to get clock\n");
-		goto out_ctlr_put;
+	if (!is_acpi_node(pdev->dev.fwnode)) {
+		dspi->clk = devm_clk_get(&pdev->dev, "dspi");
+		if (IS_ERR(dspi->clk)) {
+			ret = PTR_ERR(dspi->clk);
+			dev_err(&pdev->dev, "unable to get clock\n");
+			goto out_ctlr_put;
+		}
+
+		ret = clk_prepare_enable(dspi->clk);
+		if (ret)
+			goto out_ctlr_put;
 	}
-	ret = clk_prepare_enable(dspi->clk);
-	if (ret)
-		goto out_ctlr_put;
 
 	ret = dspi_init(dspi);
 	if (ret)
@@ -1408,8 +1441,21 @@ static int dspi_probe(struct platform_device *pdev)
 		}
 	}
 
-	ctlr->max_speed_hz =
-		clk_get_rate(dspi->clk) / dspi->devtype_data->max_clock_factor;
+	if (is_acpi_node(pdev->dev.fwnode)) {
+		ret = device_property_read_u32(&pdev->dev,
+					       "clock-frequency", &clk_rate);
+		if (ret < 0) {
+			dev_err(&pdev->dev, "can't get clock-frequency\n");
+			goto out_ctlr_put;
+		}
+
+		ctlr->max_speed_hz =
+			clk_rate / dspi->devtype_data->max_clock_factor;
+	} else {
+		clk_rate = clk_get_rate(dspi->clk);
+		ctlr->max_speed_hz =
+			clk_rate / dspi->devtype_data->max_clock_factor;
+	}
 
 	if (dspi->devtype_data->trans_mode != DSPI_DMA_MODE)
 		ctlr->ptp_sts_supported = true;
@@ -1465,13 +1511,14 @@ static void dspi_shutdown(struct platform_device *pdev)
 }
 
 static struct platform_driver fsl_dspi_driver = {
-	.driver.name		= DRIVER_NAME,
-	.driver.of_match_table	= fsl_dspi_dt_ids,
-	.driver.owner		= THIS_MODULE,
-	.driver.pm		= &dspi_pm,
-	.probe			= dspi_probe,
-	.remove			= dspi_remove,
-	.shutdown		= dspi_shutdown,
+	.driver.name			= DRIVER_NAME,
+	.driver.of_match_table		= fsl_dspi_dt_ids,
+	.driver.acpi_match_table	= ACPI_PTR(fsl_dspi_acpi_ids),
+	.driver.owner			= THIS_MODULE,
+	.driver.pm			= &dspi_pm,
+	.probe				= dspi_probe,
+	.remove				= dspi_remove,
+	.shutdown			= dspi_shutdown,
 };
 module_platform_driver(fsl_dspi_driver);
 
-- 
2.17.1

