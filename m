Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9796EC1975A
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 13:32:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63F65206E7
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 13:32:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="v6+dB29X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbgCLNcB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 09:32:01 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46432 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727461AbgCLNbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 09:31:46 -0400
Received: by mail-wr1-f65.google.com with SMTP id n15so7446676wrw.13
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 06:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ysgTmW9ZLhpEDIjfoCrSPsioEcbHMMnVx5neQlx80G8=;
        b=v6+dB29Xyenrhk4NaFR7iQNJZSWzKs/Zq9VWJ4o/maiRmzn1FJJiRssz44fuqooP6z
         191ZSbVzN+ZfzSIMcwPPQ5izObfW1BF7Qk1QO8Gdpqyu7uiVRpID+pfhATIeu61fRmGX
         kJmfYt3XZagBYOUJGUxz0aiM80wIeM1ZYD9BbZT9fLoxsvQznfd9IKVaBUsszl/CQjnA
         WuRnGkJyY5H8Uz9p/gWzt0TDCrpVcEwZO7IbCEpc97w+PuG4jmHk8im0QEqo9Ear0Ipo
         2LQYb9VSrQqme4gk+K3GF1vbgfQsT9Y5pb7YOCsSw/Bb09uhhP4njCzkH0K6vC5R/JMv
         9ilQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ysgTmW9ZLhpEDIjfoCrSPsioEcbHMMnVx5neQlx80G8=;
        b=t1NORcpSLzBo1Q9obDUNH2YQsuAyXgxgCKC6zEoi1Y3sLe/LiUxMDi3CzePuqxxc5y
         6SG6ZofokyedQOk8ekWKC4Rc29z29QjzPod6oeGSF6Odl7ggC5b9MvPcD3ker17W1zBw
         Dny5FvDBn1DoZjdu6GH88f9/xm6A3NnyDmlc95Gskb6WWCNj6DLZ9228eyip5E7QobZg
         vjorUSSFbmtLSqA7PPuyu00QmbcPTvAXRxqdAV0uIDvDonE5SfTOAqUT7LQCupBR+e+H
         W2RcqVRUTW14vBdkt9ApZeT904GkYjdkQQ8bsFSLxmb+oL2cMXHHF9B5VRHERFlhZPfg
         BvOg==
X-Gm-Message-State: ANhLgQ3f7o0mlorR7vpwgqiSvN8lYFjvQhHP/wAik5kH+kclc02gylw3
        OPvf1qIkWO2MzvlqKEUrdIUXgg==
X-Google-Smtp-Source: ADFU+vurnjaYzt7zIZenRaisc19C05PAgySImkcj7ODdYzNCIV8i6gly0uLMljAD0nLyCFdeF3tr6Q==
X-Received: by 2002:adf:94c2:: with SMTP id 60mr11120426wrr.396.1584019903410;
        Thu, 12 Mar 2020 06:31:43 -0700 (PDT)
Received: from bender.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id m21sm12242885wmi.27.2020.03.12.06.31.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 06:31:42 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     broonie@kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-spi@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 9/9] spi: meson-spicc: add support for Amlogic G12A
Date:   Thu, 12 Mar 2020 14:31:31 +0100
Message-Id: <20200312133131.26430-10-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200312133131.26430-1-narmstrong@baylibre.com>
References: <20200312133131.26430-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the SPICC controllers on the Amlogic G12A SoCs family.

The G12A SPICC controllers inherit from the AXG enhanced registers but
takes an external pclk for the baud rate generator and can achieve up to
166MHz SCLK.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/spi/spi-meson-spicc.c | 54 +++++++++++++++++++++++++++++------
 1 file changed, 46 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-meson-spicc.c b/drivers/spi/spi-meson-spicc.c
index 351ccd8dd2c2..77f7d0e0e46a 100644
--- a/drivers/spi/spi-meson-spicc.c
+++ b/drivers/spi/spi-meson-spicc.c
@@ -147,6 +147,7 @@ struct meson_spicc_data {
 	unsigned int			fifo_size;
 	bool				has_oen;
 	bool				has_enhance_clk_div;
+	bool				has_pclk;
 };
 
 struct meson_spicc_device {
@@ -154,6 +155,7 @@ struct meson_spicc_device {
 	struct platform_device		*pdev;
 	void __iomem			*base;
 	struct clk			*core;
+	struct clk			*pclk;
 	struct clk			*clk;
 	struct spi_message		*message;
 	struct spi_transfer		*xfer;
@@ -514,6 +516,10 @@ static void meson_spicc_cleanup(struct spi_device *spi)
  * Clk path for AXG series:
  *    src -> pow2 fixed div -> pow2 div -> mux -> out
  *    src -> enh fixed div -> enh div -> mux -> out
+ *
+ * Clk path for G12A series:
+ *    pclk -> pow2 fixed div -> pow2 div -> mux -> out
+ *    pclk -> enh fixed div -> enh div -> mux -> out
  */
 
 static int meson_spicc_clk_init(struct meson_spicc_device *spicc)
@@ -542,7 +548,10 @@ static int meson_spicc_clk_init(struct meson_spicc_device *spicc)
 	init.name = name;
 	init.ops = &clk_fixed_factor_ops;
 	init.flags = 0;
-	parent_data[0].hw = __clk_get_hw(spicc->core);
+	if (spicc->data->has_pclk)
+		parent_data[0].hw = __clk_get_hw(spicc->pclk);
+	else
+		parent_data[0].hw = __clk_get_hw(spicc->core);
 	init.num_parents = 1;
 
 	pow2_fixed_div->mult = 1,
@@ -589,7 +598,10 @@ static int meson_spicc_clk_init(struct meson_spicc_device *spicc)
 	init.name = name;
 	init.ops = &clk_fixed_factor_ops;
 	init.flags = 0;
-	parent_data[0].hw = __clk_get_hw(spicc->core);
+	if (spicc->data->has_pclk)
+		parent_data[0].hw = __clk_get_hw(spicc->pclk);
+	else
+		parent_data[0].hw = __clk_get_hw(spicc->core);
 	init.num_parents = 1;
 
 	enh_fixed_div->mult = 1,
@@ -648,7 +660,7 @@ static int meson_spicc_probe(struct platform_device *pdev)
 {
 	struct spi_master *master;
 	struct meson_spicc_device *spicc;
-	int ret, irq, rate;
+	int ret, irq;
 
 	master = spi_alloc_master(&pdev->dev, sizeof(*spicc));
 	if (!master) {
@@ -697,12 +709,26 @@ static int meson_spicc_probe(struct platform_device *pdev)
 		goto out_master;
 	}
 
+	if (spicc->data->has_pclk) {
+		spicc->pclk = devm_clk_get(&pdev->dev, "pclk");
+		if (IS_ERR(spicc->pclk)) {
+			dev_err(&pdev->dev, "pclk clock request failed\n");
+			ret = PTR_ERR(spicc->pclk);
+			goto out_master;
+		}
+	}
+
 	ret = clk_prepare_enable(spicc->core);
 	if (ret) {
 		dev_err(&pdev->dev, "core clock enable failed\n");
 		goto out_master;
 	}
-	rate = clk_get_rate(spicc->core);
+
+	ret = clk_prepare_enable(spicc->pclk);
+	if (ret) {
+		dev_err(&pdev->dev, "pclk clock enable failed\n");
+		goto out_master;
+	}
 
 	device_reset_optional(&pdev->dev);
 
@@ -715,6 +741,7 @@ static int meson_spicc_probe(struct platform_device *pdev)
 				     SPI_BPW_MASK(8);
 	master->flags = (SPI_MASTER_MUST_RX | SPI_MASTER_MUST_TX);
 	master->min_speed_hz = spicc->data->min_speed_hz;
+	master->max_speed_hz = spicc->data->max_speed_hz;
 	master->setup = meson_spicc_setup;
 	master->cleanup = meson_spicc_cleanup;
 	master->prepare_message = meson_spicc_prepare_message;
@@ -722,10 +749,6 @@ static int meson_spicc_probe(struct platform_device *pdev)
 	master->transfer_one = meson_spicc_transfer_one;
 	master->use_gpio_descriptors = true;
 
-	/* Setup max rate according to the Meson datasheet */
-	master->max_speed_hz = min_t(unsigned int, rate >> 1,
-				     spicc->data->max_speed_hz);
-
 	meson_spicc_oen_enable(spicc);
 
 	ret = meson_spicc_clk_init(spicc);
@@ -744,6 +767,7 @@ static int meson_spicc_probe(struct platform_device *pdev)
 
 out_clk:
 	clk_disable_unprepare(spicc->core);
+	clk_disable_unprepare(spicc->pclk);
 
 out_master:
 	spi_master_put(master);
@@ -759,6 +783,7 @@ static int meson_spicc_remove(struct platform_device *pdev)
 	writel(0, spicc->base + SPICC_CONREG);
 
 	clk_disable_unprepare(spicc->core);
+	clk_disable_unprepare(spicc->pclk);
 
 	return 0;
 }
@@ -777,6 +802,15 @@ static const struct meson_spicc_data meson_spicc_axg_data = {
 	.has_enhance_clk_div	= true,
 };
 
+static const struct meson_spicc_data meson_spicc_g12a_data = {
+	.max_speed_hz		= 166666666,
+	.min_speed_hz		= 50000,
+	.fifo_size		= 15,
+	.has_oen		= true,
+	.has_enhance_clk_div	= true,
+	.has_pclk		= true,
+};
+
 static const struct of_device_id meson_spicc_of_match[] = {
 	{
 		.compatible	= "amlogic,meson-gx-spicc",
@@ -786,6 +820,10 @@ static const struct of_device_id meson_spicc_of_match[] = {
 		.compatible = "amlogic,meson-axg-spicc",
 		.data		= &meson_spicc_axg_data,
 	},
+	{
+		.compatible = "amlogic,meson-g12a-spicc",
+		.data		= &meson_spicc_g12a_data,
+	},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, meson_spicc_of_match);
-- 
2.22.0

