Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B5AEC2BBD0
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 06:02:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 026582137B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 06:02:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=puresoftware-com.20150623.gappssmtp.com header.i=@puresoftware-com.20150623.gappssmtp.com header.b="YobLdZBk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728828AbgIHGCq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 02:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728654AbgIHGCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 02:02:45 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29EC1C061573
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 23:02:45 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id v15so9288519pgh.6
        for <linux-kernel@vger.kernel.org>; Mon, 07 Sep 2020 23:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=puresoftware-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=zNBvRrZjPxbBT7JprMip1sL4fZ/48zd8a70ne9wPaO8=;
        b=YobLdZBkZBrxmP5Y/Or5o5a0RApbkDOGe6tuhAhpFVgGoN355yiEHHInm9yFndi61f
         qqsm896vCbbg6IEHjXnoxMAw2YPTkBFXNLalU6yKh1cW/sSy6V69PFBENKyZLWQs6HkX
         PDw4oVQAiWJ2v7MGM8NZgBNHihkNEmRtLZM8j0LxuV/AKhiMsG2Atn2e3tvzuH3Y3aAR
         xUUzcXhBOMYFHF0Gg78AoJjosuquqNl+QIBZdDYPO4ef/93e1668iYWlt6qyEjHs6TpP
         l9BTs792GaB7nTmk7tHuqKB35G3uEVMGduslQGlK9uuY2RVDbzkoR61tw/cyeMz/tLSV
         bNtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zNBvRrZjPxbBT7JprMip1sL4fZ/48zd8a70ne9wPaO8=;
        b=Uuym5I1C3ZkgU4Mn73jKFTM0jYcOIDVlTaFGT868RP23wU+a/r56Ke3vsJptRMwOR2
         bCET+vIRiFscZcdu0PxiSs6pv3eqdz/E0MxFKiZgrpuwem6cplTB+IHmakXHS2yBmtwi
         8seTuK1xEI2oth+C1m7aHMIvsO4cHK9b+vOauINAmrbGBPm+11wmAssGYJqtsAeRVlVn
         wCf1SR+aVHkoowdzT9P6sK4YsiZaj1SrPwiT3D5zsELv2jvkMSjICsaVWM5SzcmpLZKr
         6+H5uoL5SAvGWDuYZXTFWDhMrE9fviHCdGt++uobfQW4pEUJj7HaYUStlZupD80hvxsU
         2KaA==
X-Gm-Message-State: AOAM532ajoUJHPwrDm/Od306IbTixVQ0Uqs6hqtxScOKFBOk0gAuwiOM
        C7/gpyosEHbpPfmYNs891OwCFQ==
X-Google-Smtp-Source: ABdhPJystQja5K8KbUNhK+XcdevCmgEwRl2n4AZI7pZg4devWCJcQgGCdfAwN02nAXGcGGPD7r0t9w==
X-Received: by 2002:a62:5212:: with SMTP id g18mr23637060pfb.8.1599544964538;
        Mon, 07 Sep 2020 23:02:44 -0700 (PDT)
Received: from DESKTOP-C4AMQCQ.domain.name ([182.69.226.142])
        by smtp.gmail.com with ESMTPSA id u21sm14645454pjn.27.2020.09.07.23.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2020 23:02:43 -0700 (PDT)
From:   kuldip dwivedi <kuldip.dwivedi@puresoftware.com>
To:     Ashish Kumar <ashish.kumar@nxp.com>,
        Yogesh Gaur <yogeshgaur.83@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Varun Sethi <V.Sethi@nxp.com>, Arokia Samy <arokia.samy@nxp.com>,
        kuldip dwivedi <kuldip.dwivedi@puresoftware.com>
Subject: [PATCH v1] spi: spi-nxp-fspi: Add ACPI support
Date:   Tue,  8 Sep 2020 11:32:27 +0530
Message-Id: <20200908060227.299-1-kuldip.dwivedi@puresoftware.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently NXP fspi  driver has support of DT only. Adding ACPI
support to the driver so that it can be used by UEFI firmware
booting in ACPI mode. This driver will be probed if any firmware
will expose HID "NXP0009" in DSDT table.

Signed-off-by: kuldip dwivedi <kuldip.dwivedi@puresoftware.com>
---

Notes:
    1. Add ACPI match table
    2. Change the DT specific APIs to device property APIs
       so that same API can be used in DT and ACPi mode.
    3. Omit clock configuration part - in ACPI world, the firmware
       is responsible for clock maintenance.
    4. This patch is tested on LX2160A platform

 drivers/spi/spi-nxp-fspi.c | 66 +++++++++++++++++++++++++++-----------
 1 file changed, 47 insertions(+), 19 deletions(-)

diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
index 1ccda82da206..acdb186ddfb2 100644
--- a/drivers/spi/spi-nxp-fspi.c
+++ b/drivers/spi/spi-nxp-fspi.c
@@ -3,7 +3,8 @@
 /*
  * NXP FlexSPI(FSPI) controller driver.
  *
- * Copyright 2019 NXP.
+ * Copyright 2019-2020 NXP
+ * Copyright 2020 Puresoftware Ltd.
  *
  * FlexSPI is a flexsible SPI host controller which supports two SPI
  * channels and up to 4 external devices. Each channel supports
@@ -30,6 +31,7 @@
  *     Frieder Schrempf <frieder.schrempf@kontron.de>
  */
 
+#include <linux/acpi.h>
 #include <linux/bitops.h>
 #include <linux/clk.h>
 #include <linux/completion.h>
@@ -563,6 +565,9 @@ static int nxp_fspi_clk_prep_enable(struct nxp_fspi *f)
 {
 	int ret;
 
+	if (is_acpi_node(f->dev->fwnode))
+		return 0;
+
 	ret = clk_prepare_enable(f->clk_en);
 	if (ret)
 		return ret;
@@ -576,10 +581,15 @@ static int nxp_fspi_clk_prep_enable(struct nxp_fspi *f)
 	return 0;
 }
 
-static void nxp_fspi_clk_disable_unprep(struct nxp_fspi *f)
+static int nxp_fspi_clk_disable_unprep(struct nxp_fspi *f)
 {
+	if (is_acpi_node(f->dev->fwnode))
+		return 0;
+
 	clk_disable_unprepare(f->clk);
 	clk_disable_unprepare(f->clk_en);
+
+	return 0;
 }
 
 /*
@@ -900,6 +910,8 @@ static int nxp_fspi_default_setup(struct nxp_fspi *f)
 		return ret;
 
 	/* Reset the module */
+	fspi_writel(f, FSPI_MCR0_SWRST, (base + FSPI_MCR0));
+
 	/* w1c register, wait unit clear */
 	ret = fspi_readl_poll_tout(f, f->iobase + FSPI_MCR0,
 				   FSPI_MCR0_SWRST, 0, POLL_TOUT, false);
@@ -1001,7 +1013,7 @@ static int nxp_fspi_probe(struct platform_device *pdev)
 
 	f = spi_controller_get_devdata(ctlr);
 	f->dev = dev;
-	f->devtype_data = of_device_get_match_data(dev);
+	f->devtype_data = device_get_match_data(dev);
 	if (!f->devtype_data) {
 		ret = -ENODEV;
 		goto err_put_ctrl;
@@ -1011,6 +1023,8 @@ static int nxp_fspi_probe(struct platform_device *pdev)
 
 	/* find the resources - configuration register address space */
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "fspi_base");
+	if (!res)
+		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	f->iobase = devm_ioremap_resource(dev, res);
 	if (IS_ERR(f->iobase)) {
 		ret = PTR_ERR(f->iobase);
@@ -1020,8 +1034,11 @@ static int nxp_fspi_probe(struct platform_device *pdev)
 	/* find the resources - controller memory mapped space */
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "fspi_mmap");
 	if (!res) {
-		ret = -ENODEV;
-		goto err_put_ctrl;
+		res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+		if (!res) {
+			ret = -ENODEV;
+			goto err_put_ctrl;
+		}
 	}
 
 	/* assign memory mapped starting address and mapped size. */
@@ -1029,22 +1046,24 @@ static int nxp_fspi_probe(struct platform_device *pdev)
 	f->memmap_phy_size = resource_size(res);
 
 	/* find the clocks */
-	f->clk_en = devm_clk_get(dev, "fspi_en");
-	if (IS_ERR(f->clk_en)) {
-		ret = PTR_ERR(f->clk_en);
-		goto err_put_ctrl;
-	}
+	if (dev_of_node(&pdev->dev)) {
+		f->clk_en = devm_clk_get(dev, "fspi_en");
+		if (IS_ERR(f->clk_en)) {
+			ret = PTR_ERR(f->clk_en);
+			goto err_put_ctrl;
+		}
 
-	f->clk = devm_clk_get(dev, "fspi");
-	if (IS_ERR(f->clk)) {
-		ret = PTR_ERR(f->clk);
-		goto err_put_ctrl;
-	}
+		f->clk = devm_clk_get(dev, "fspi");
+		if (IS_ERR(f->clk)) {
+			ret = PTR_ERR(f->clk);
+			goto err_put_ctrl;
+		}
 
-	ret = nxp_fspi_clk_prep_enable(f);
-	if (ret) {
-		dev_err(dev, "can not enable the clock\n");
-		goto err_put_ctrl;
+		ret = nxp_fspi_clk_prep_enable(f);
+		if (ret) {
+			dev_err(dev, "can not enable the clock\n");
+			goto err_put_ctrl;
+		}
 	}
 
 	/* find the irq */
@@ -1127,6 +1146,14 @@ static const struct of_device_id nxp_fspi_dt_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, nxp_fspi_dt_ids);
 
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id nxp_fspi_acpi_ids[] = {
+	{ "NXP0009", .driver_data = (kernel_ulong_t)&lx2160a_data, },
+	{}
+};
+MODULE_DEVICE_TABLE(acpi, nxp_fspi_acpi_ids);
+#endif
+
 static const struct dev_pm_ops nxp_fspi_pm_ops = {
 	.suspend	= nxp_fspi_suspend,
 	.resume		= nxp_fspi_resume,
@@ -1136,6 +1163,7 @@ static struct platform_driver nxp_fspi_driver = {
 	.driver = {
 		.name	= "nxp-fspi",
 		.of_match_table = nxp_fspi_dt_ids,
+		.acpi_match_table = ACPI_PTR(nxp_fspi_acpi_ids),
 		.pm =   &nxp_fspi_pm_ops,
 	},
 	.probe          = nxp_fspi_probe,
-- 
2.17.1

