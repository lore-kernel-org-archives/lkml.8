Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52F4EC10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 17:39:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C06A2067C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 17:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584034758;
	bh=vVq3WkUEBy1Kz7gOyxAyQ01VgufITwSIS7Ud5MXKG7s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=d71YbJ3660bxuJTEBkPycQibUHoif1jDnubLUkrRCTs0l2kexHPDC0nnFeajHo8as
	 YbHoGm9Ge8M6pVJT/+PuRY0LLJZTC2FGwPCbYgkJmwHWSjBYvuol86iFyIk/amfFRD
	 nMdZlHxqX1OIyuysmO8jMvFBRe7yLm9tWHoF5yzg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbgCLRjR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 13:39:17 -0400
Received: from foss.arm.com ([217.140.110.172]:38908 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726127AbgCLRjQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 13:39:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 79E0530E;
        Thu, 12 Mar 2020 10:39:15 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F293F3F6CF;
        Thu, 12 Mar 2020 10:39:14 -0700 (PDT)
Date:   Thu, 12 Mar 2020 17:39:13 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     broonie@kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Applied "spi: meson-spicc: add min sclk for each compatible" to the spi tree
In-Reply-To:  <20200312133131.26430-6-narmstrong@baylibre.com>
Message-Id:  <applied-20200312133131.26430-6-narmstrong@baylibre.com>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: meson-spicc: add min sclk for each compatible

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

From 8791068dab979819e01f41736953b9b2e462867b Mon Sep 17 00:00:00 2001
From: Neil Armstrong <narmstrong@baylibre.com>
Date: Thu, 12 Mar 2020 14:31:27 +0100
Subject: [PATCH] spi: meson-spicc: add min sclk for each compatible

The G12A SPICC controller variant takes the source clock from a specific
clock instead of the bus clock.
The minimal clock calculus won't work with the G12A support, thus add the
minimal supported clock for each variant and pass this to the SPI core.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Link: https://lore.kernel.org/r/20200312133131.26430-6-narmstrong@baylibre.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-meson-spicc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-meson-spicc.c b/drivers/spi/spi-meson-spicc.c
index 710b4e780daa..b5bd3a897e8f 100644
--- a/drivers/spi/spi-meson-spicc.c
+++ b/drivers/spi/spi-meson-spicc.c
@@ -132,6 +132,7 @@
 
 struct meson_spicc_data {
 	unsigned int			max_speed_hz;
+	unsigned int			min_speed_hz;
 	bool				has_oen;
 	bool				has_enhance_clk_div;
 };
@@ -685,7 +686,7 @@ static int meson_spicc_probe(struct platform_device *pdev)
 				     SPI_BPW_MASK(16) |
 				     SPI_BPW_MASK(8);
 	master->flags = (SPI_MASTER_MUST_RX | SPI_MASTER_MUST_TX);
-	master->min_speed_hz = rate >> 9;
+	master->min_speed_hz = spicc->data->min_speed_hz;
 	master->setup = meson_spicc_setup;
 	master->cleanup = meson_spicc_cleanup;
 	master->prepare_message = meson_spicc_prepare_message;
@@ -736,10 +737,12 @@ static int meson_spicc_remove(struct platform_device *pdev)
 
 static const struct meson_spicc_data meson_spicc_gx_data = {
 	.max_speed_hz		= 30000000,
+	.min_speed_hz		= 325000,
 };
 
 static const struct meson_spicc_data meson_spicc_axg_data = {
 	.max_speed_hz		= 80000000,
+	.min_speed_hz		= 325000,
 	.has_oen		= true,
 	.has_enhance_clk_div	= true,
 };
-- 
2.20.1

