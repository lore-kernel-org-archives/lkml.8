Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE06BC352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 15:51:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 958722082F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 15:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581436318;
	bh=GO35Wl/Exr8/93NoO5ex5866PISS7aichWnVTvHaP9U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=I5YCqq3OqVqVQyYwNyV4M4P7BShxMAlzMQiqrctHhcwHdaZZaaEYCmbpxv4dcO/aU
	 SvZgtPSIEvtOkPF09kUAyzjn1zz2oYNw6sJMqP9ZfWt1NUQANOEyhMk9aOhu/ScnAq
	 n1plKM65zKZhA+NhxA9J2cN5CwQQ8o9L+HKJ/8ig=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730681AbgBKPv6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 10:51:58 -0500
Received: from foss.arm.com ([217.140.110.172]:48972 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729876AbgBKPvz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 10:51:55 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7D6E113A1;
        Tue, 11 Feb 2020 07:51:55 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0287F3F68E;
        Tue, 11 Feb 2020 07:51:54 -0800 (PST)
Date:   Tue, 11 Feb 2020 15:51:53 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Alok Chauhan <alokc@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dilip Kota <dkota@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Girish Mahadevan <girishm@codeaurora.org>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: Applied "spi: spi-geni-qcom: Grow a dev pointer to simplify code" to the spi tree
In-Reply-To: <20200204191206.97036-3-swboyd@chromium.org>
Message-Id: <applied-20200204191206.97036-3-swboyd@chromium.org>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: spi-geni-qcom: Grow a dev pointer to simplify code

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.7

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

From ea1e5b3354b1610ac16a780535fbdabfda9e6912 Mon Sep 17 00:00:00 2001
From: Stephen Boyd <swboyd@chromium.org>
Date: Tue, 4 Feb 2020 11:12:05 -0800
Subject: [PATCH] spi: spi-geni-qcom: Grow a dev pointer to simplify code

Some lines are long here. Use a struct dev pointer to shorten lines and
simplify code. The clk_get() call can fail because of EPROBE_DEFER
problems too, so just remove the error print message because it isn't
useful.

Cc: Girish Mahadevan <girishm@codeaurora.org>
Cc: Dilip Kota <dkota@codeaurora.org>
Cc: Alok Chauhan <alokc@codeaurora.org>
Cc: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Link: https://lore.kernel.org/r/20200204191206.97036-3-swboyd@chromium.org
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-geni-qcom.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index 46e501fc87f3..f0ca7f5ae714 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -536,6 +536,7 @@ static int spi_geni_probe(struct platform_device *pdev)
 	struct spi_geni_master *mas;
 	void __iomem *base;
 	struct clk *clk;
+	struct device *dev = &pdev->dev;
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
@@ -545,28 +546,25 @@ static int spi_geni_probe(struct platform_device *pdev)
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
-	clk = devm_clk_get(&pdev->dev, "se");
-	if (IS_ERR(clk)) {
-		dev_err(&pdev->dev, "Err getting SE Core clk %ld\n",
-						PTR_ERR(clk));
+	clk = devm_clk_get(dev, "se");
+	if (IS_ERR(clk))
 		return PTR_ERR(clk);
-	}
 
-	spi = spi_alloc_master(&pdev->dev, sizeof(*mas));
+	spi = spi_alloc_master(dev, sizeof(*mas));
 	if (!spi)
 		return -ENOMEM;
 
 	platform_set_drvdata(pdev, spi);
 	mas = spi_master_get_devdata(spi);
 	mas->irq = irq;
-	mas->dev = &pdev->dev;
-	mas->se.dev = &pdev->dev;
-	mas->se.wrapper = dev_get_drvdata(pdev->dev.parent);
+	mas->dev = dev;
+	mas->se.dev = dev;
+	mas->se.wrapper = dev_get_drvdata(dev->parent);
 	mas->se.base = base;
 	mas->se.clk = clk;
 
 	spi->bus_num = -1;
-	spi->dev.of_node = pdev->dev.of_node;
+	spi->dev.of_node = dev->of_node;
 	spi->mode_bits = SPI_CPOL | SPI_CPHA | SPI_LOOP | SPI_CS_HIGH;
 	spi->bits_per_word_mask = SPI_BPW_RANGE_MASK(4, 32);
 	spi->num_chipselect = 4;
@@ -579,13 +577,13 @@ static int spi_geni_probe(struct platform_device *pdev)
 
 	init_completion(&mas->xfer_done);
 	spin_lock_init(&mas->lock);
-	pm_runtime_enable(&pdev->dev);
+	pm_runtime_enable(dev);
 
 	ret = spi_geni_init(mas);
 	if (ret)
 		goto spi_geni_probe_runtime_disable;
 
-	ret = request_irq(mas->irq, geni_spi_isr, 0, dev_name(&pdev->dev), spi);
+	ret = request_irq(mas->irq, geni_spi_isr, 0, dev_name(dev), spi);
 	if (ret)
 		goto spi_geni_probe_runtime_disable;
 
@@ -597,7 +595,7 @@ static int spi_geni_probe(struct platform_device *pdev)
 spi_geni_probe_free_irq:
 	free_irq(mas->irq, spi);
 spi_geni_probe_runtime_disable:
-	pm_runtime_disable(&pdev->dev);
+	pm_runtime_disable(dev);
 	spi_master_put(spi);
 	return ret;
 }
-- 
2.20.1

