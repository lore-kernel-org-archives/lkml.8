Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7FC3C1975A
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 13:31:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B413920736
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 13:31:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="JrtREJLS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727408AbgCLNbj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 09:31:39 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43826 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727240AbgCLNbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 09:31:38 -0400
Received: by mail-wr1-f68.google.com with SMTP id b2so1253805wrj.10
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 06:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fhKS2QmlEqe7YF4t+EF2enhYAsFiUYK9CnO2h0EUAe8=;
        b=JrtREJLSfg0ful938Ewd1LT16qXXEeOh8IBaTuhMKFrcRMVSBkMsuqzNmExITbxwAx
         D7DHgauvoRll0zTikGxpEmneu70O3SbW6peZBRqNKP6jYcKa7GSuMOb/yzbZihxYzbSb
         3O6UjNb+jYyFi3ECc54Lp7HQbP8CJ/qzsvNQeXjDd1iRRw3KUv6W3spUI1OLrcG2WQPp
         Me6o4fhFIXmoJIKYRf9FscwDdI21KiG+HhecDAde/fajhssQOlUhbfVtp7WDgiPJPOyE
         UVZmzzu7xeTevXU53/NlGrZ3QkzRZcmO7vme+8SRtgJU1urmK0aIlzGmCmauoeokY1L2
         lUig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fhKS2QmlEqe7YF4t+EF2enhYAsFiUYK9CnO2h0EUAe8=;
        b=s3oEXTxgRmuOo8VreafGnYU7DUsW4+ULne3P7laYpbjanYzx6zsU55p1pqOISiZ5xK
         O41xkUofnSfeA3ofITMwUJ0quudwjGlowgdqsnwY61wckTWglQE/boVi5m2k+OfPPs2L
         nBmIxIHRX9htk8Nfhb4bFCgmzfiS20oy0gh3Rw+S8zaEOfYqWquFNZxDOi+h7rbZ90ws
         xbEArETKhyuJ6VKj2d8iLmt+TRwMPXz3+peSKShOLRG06X0dNBN3leV20qGNOabLRrlS
         d/i4z1akCNmXu1WMFtZH1Wwx6wRqvl5t4OjHGfqTWo7GXhPuqykR4l2OaQR4fyA2SI0A
         lHRg==
X-Gm-Message-State: ANhLgQ1zDJZlOtIhm+nwvavXKvT1Whq9Q9wYfoCXM66hJx/ybhOEps3q
        lsGg0Ca+k8Cym3Ml+ziXzDEHiw==
X-Google-Smtp-Source: ADFU+vt0MdII7T+2dH+DamoAkX5rNnGfgWPSAC2NKHVuJYX+JaFCSwlEQhFIHqNbvg6KRrhi9MNm9w==
X-Received: by 2002:adf:9b19:: with SMTP id b25mr11104897wrc.368.1584019896447;
        Thu, 12 Mar 2020 06:31:36 -0700 (PDT)
Received: from bender.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id m21sm12242885wmi.27.2020.03.12.06.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 06:31:35 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     broonie@kernel.org
Cc:     Sunny Luo <sunny.luo@amlogic.com>, linux-spi@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yixun Lan <yixun.lan@amlogic.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 2/9] spi: meson-spicc: enhance output enable feature
Date:   Thu, 12 Mar 2020 14:31:24 +0100
Message-Id: <20200312133131.26430-3-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200312133131.26430-1-narmstrong@baylibre.com>
References: <20200312133131.26430-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sunny Luo <sunny.luo@amlogic.com>

The SPICC controller in Meson-AXG is capable of driving the CLK/MOSI/SS
signal lines through the idle state (between two transmission operation),
which avoid the signals floating in unexpected state.

Signed-off-by: Sunny Luo <sunny.luo@amlogic.com>
Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/spi/spi-meson-spicc.c | 53 +++++++++++++++++++++++++++++++++--
 1 file changed, 51 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-meson-spicc.c b/drivers/spi/spi-meson-spicc.c
index 8425e5ae1273..ba70ef94a82a 100644
--- a/drivers/spi/spi-meson-spicc.c
+++ b/drivers/spi/spi-meson-spicc.c
@@ -9,11 +9,13 @@
 
 #include <linux/bitfield.h>
 #include <linux/clk.h>
+#include <linux/clk-provider.h>
 #include <linux/device.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/spi/spi.h>
 #include <linux/types.h>
@@ -113,12 +115,23 @@
 
 #define SPICC_DWADDR	0x24	/* Write Address of DMA */
 
+#define SPICC_ENH_CTL0	0x38	/* Enhanced Feature */
+#define SPICC_ENH_MOSI_OEN		BIT(25)
+#define SPICC_ENH_CLK_OEN		BIT(26)
+#define SPICC_ENH_CS_OEN		BIT(27)
+#define SPICC_ENH_CLK_CS_DELAY_EN	BIT(28)
+#define SPICC_ENH_MAIN_CLK_AO		BIT(29)
+
 #define writel_bits_relaxed(mask, val, addr) \
 	writel_relaxed((readl_relaxed(addr) & ~(mask)) | (val), addr)
 
 #define SPICC_BURST_MAX	16
 #define SPICC_FIFO_HALF 10
 
+struct meson_spicc_data {
+	bool				has_oen;
+};
+
 struct meson_spicc_device {
 	struct spi_master		*master;
 	struct platform_device		*pdev;
@@ -126,6 +139,7 @@ struct meson_spicc_device {
 	struct clk			*core;
 	struct spi_message		*message;
 	struct spi_transfer		*xfer;
+	const struct meson_spicc_data	*data;
 	u8				*tx_buf;
 	u8				*rx_buf;
 	unsigned int			bytes_per_word;
@@ -136,6 +150,19 @@ struct meson_spicc_device {
 	bool				is_last_burst;
 };
 
+static void meson_spicc_oen_enable(struct meson_spicc_device *spicc)
+{
+	u32 conf;
+
+	if (!spicc->data->has_oen)
+		return;
+
+	conf = readl_relaxed(spicc->base + SPICC_ENH_CTL0) |
+		SPICC_ENH_MOSI_OEN | SPICC_ENH_CLK_OEN | SPICC_ENH_CS_OEN;
+
+	writel_relaxed(conf, spicc->base + SPICC_ENH_CTL0);
+}
+
 static inline bool meson_spicc_txfull(struct meson_spicc_device *spicc)
 {
 	return !!FIELD_GET(SPICC_TF,
@@ -489,6 +516,13 @@ static int meson_spicc_probe(struct platform_device *pdev)
 	spicc = spi_master_get_devdata(master);
 	spicc->master = master;
 
+	spicc->data = of_device_get_match_data(&pdev->dev);
+	if (!spicc->data) {
+		dev_err(&pdev->dev, "failed to get match data\n");
+		ret = -EINVAL;
+		goto out_master;
+	}
+
 	spicc->pdev = pdev;
 	platform_set_drvdata(pdev, spicc);
 
@@ -548,6 +582,8 @@ static int meson_spicc_probe(struct platform_device *pdev)
 	else
 		master->max_speed_hz = rate >> 2;
 
+	meson_spicc_oen_enable(spicc);
+
 	ret = devm_spi_register_master(&pdev->dev, master);
 	if (ret) {
 		dev_err(&pdev->dev, "spi master registration failed\n");
@@ -577,9 +613,22 @@ static int meson_spicc_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct meson_spicc_data meson_spicc_gx_data = {
+};
+
+static const struct meson_spicc_data meson_spicc_axg_data = {
+	.has_oen		= true,
+};
+
 static const struct of_device_id meson_spicc_of_match[] = {
-	{ .compatible = "amlogic,meson-gx-spicc", },
-	{ .compatible = "amlogic,meson-axg-spicc", },
+	{
+		.compatible	= "amlogic,meson-gx-spicc",
+		.data		= &meson_spicc_gx_data,
+	},
+	{
+		.compatible = "amlogic,meson-axg-spicc",
+		.data		= &meson_spicc_axg_data,
+	},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, meson_spicc_of_match);
-- 
2.22.0

