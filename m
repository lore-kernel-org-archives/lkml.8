Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0382AC433FE
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 06:31:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D900521744
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 06:30:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbgGQGa6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 02:30:58 -0400
Received: from mga12.intel.com ([192.55.52.136]:34707 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727788AbgGQGa4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 02:30:56 -0400
IronPort-SDR: J3Pk8qD/aHosi+nsnSQOquTLMpLuxpNM9MGimICkxZO6NpvT3tezumI9KFkMRvs8jSLYTXstg+
 xGbsZXF3vkBg==
X-IronPort-AV: E=McAfee;i="6000,8403,9684"; a="129107947"
X-IronPort-AV: E=Sophos;i="5.75,362,1589266800"; 
   d="scan'208";a="129107947"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2020 23:30:55 -0700
IronPort-SDR: DTYY0vqV6KCgv8R8TYqyzwKlrfaXkdeIkaaSMhD9ACvLsC8OrSgole10N6LxMbNAfqxXg0ibbc
 +GwpdBb17JzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,362,1589266800"; 
   d="scan'208";a="282697277"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by orsmga003.jf.intel.com with ESMTP; 16 Jul 2020 23:30:52 -0700
From:   Dilip Kota <eswara.kota@linux.intel.com>
To:     broonie@kernel.org, robh@kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, daniel.schwierzeck@gmail.com,
        hauke@hauke-m.de, andriy.shevchenko@intel.com,
        cheol.yong.kim@intel.com, chuanhua.lei@linux.intel.com,
        qi-ming.wu@intel.com, Dilip Kota <eswara.kota@linux.intel.com>
Subject: [PATCH v2 8/8] spi: lantiq: Add support to Lightning Mountain SoC
Date:   Fri, 17 Jul 2020 14:27:57 +0800
Message-Id: <4d61a75381aca9479f9fc15d07a7b05534da6bb3.1594957019.git.eswara.kota@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <efb650b0faa49a00788c4e0ca8ef7196bdba851d.1594957019.git.eswara.kota@linux.intel.com>
References: <efb650b0faa49a00788c4e0ca8ef7196bdba851d.1594957019.git.eswara.kota@linux.intel.com>
In-Reply-To: <efb650b0faa49a00788c4e0ca8ef7196bdba851d.1594957019.git.eswara.kota@linux.intel.com>
References: <efb650b0faa49a00788c4e0ca8ef7196bdba851d.1594957019.git.eswara.kota@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to SPI controller on Intel Atom based Lightning Mountain SoC
which reuses Lantiq SPI controller IP.

Signed-off-by: Dilip Kota <eswara.kota@linux.intel.com>
---
 drivers/spi/Kconfig          |  4 ++--
 drivers/spi/spi-lantiq-ssc.c | 40 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 878849a33781b..be40310840d04 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -498,11 +498,11 @@ config SPI_NPCM_PSPI
 
 config SPI_LANTIQ_SSC
 	tristate "Lantiq SSC SPI controller"
-	depends on LANTIQ || COMPILE_TEST
+	depends on LANTIQ || X86 || COMPILE_TEST
 	help
 	  This driver supports the Lantiq SSC SPI controller in master
 	  mode. This controller is found on Intel (former Lantiq) SoCs like
-	  the Danube, Falcon, xRX200, xRX300.
+	  the Danube, Falcon, xRX200, xRX300, Lightning Mountain.
 
 config SPI_OC_TINY
 	tristate "OpenCores tiny SPI"
diff --git a/drivers/spi/spi-lantiq-ssc.c b/drivers/spi/spi-lantiq-ssc.c
index 2a433d9b5d8fe..81cb1c06e2ce5 100644
--- a/drivers/spi/spi-lantiq-ssc.c
+++ b/drivers/spi/spi-lantiq-ssc.c
@@ -703,6 +703,24 @@ static irqreturn_t lantiq_ssc_err_interrupt(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+static irqreturn_t intel_lgm_ssc_isr(int irq, void *data)
+{
+	struct lantiq_ssc_spi *spi = data;
+	const struct lantiq_ssc_hwcfg *hwcfg = spi->hwcfg;
+	u32 val = lantiq_ssc_readl(spi, hwcfg->irncr);
+
+	if (!(val & LTQ_SPI_IRNEN_ALL))
+		return IRQ_NONE;
+
+	if (val & LTQ_SPI_IRNEN_E)
+		return lantiq_ssc_err_interrupt(irq, data);
+
+	if ((val & hwcfg->irnen_t) || (val & hwcfg->irnen_r))
+		return lantiq_ssc_xmit_interrupt(irq, data);
+
+	return IRQ_HANDLED;
+}
+
 static int transfer_start(struct lantiq_ssc_spi *spi, struct spi_device *spidev,
 			  struct spi_transfer *t)
 {
@@ -803,6 +821,17 @@ static int lantiq_ssc_transfer_one(struct spi_master *master,
 	return transfer_start(spi, spidev, t);
 }
 
+static int intel_lgm_cfg_irq(struct platform_device *pdev, struct lantiq_ssc_spi *spi)
+{
+	int irq;
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
+
+	return devm_request_irq(&pdev->dev, irq, intel_lgm_ssc_isr, 0, "spi", spi);
+}
+
 static int lantiq_cfg_irq(struct platform_device *pdev, struct lantiq_ssc_spi *spi)
 {
 	int irq, err;
@@ -855,10 +884,21 @@ static const struct lantiq_ssc_hwcfg lantiq_ssc_xrx = {
 	.irq_ack	= false,
 };
 
+static const struct lantiq_ssc_hwcfg intel_ssc_lgm = {
+	.cfg_irq	= intel_lgm_cfg_irq,
+	.irnen_r	= LTQ_SPI_IRNEN_R_XRX,
+	.irnen_t	= LTQ_SPI_IRNEN_T_XRX,
+	.irnicr		= 0xFC,
+	.irncr		= 0xF8,
+	.fifo_size_mask	= GENMASK(7, 0),
+	.irq_ack	= true,
+};
+
 static const struct of_device_id lantiq_ssc_match[] = {
 	{ .compatible = "lantiq,ase-spi", .data = &lantiq_ssc_xway, },
 	{ .compatible = "lantiq,falcon-spi", .data = &lantiq_ssc_xrx, },
 	{ .compatible = "lantiq,xrx100-spi", .data = &lantiq_ssc_xrx, },
+	{ .compatible = "intel,lgm-spi", .data = &intel_ssc_lgm, },
 	{},
 };
 MODULE_DEVICE_TABLE(of, lantiq_ssc_match);
-- 
2.11.0

