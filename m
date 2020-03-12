Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA170C10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 13:31:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9427C206E7
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 13:31:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="crid5weI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727469AbgCLNbu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 09:31:50 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50474 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727421AbgCLNbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 09:31:43 -0400
Received: by mail-wm1-f65.google.com with SMTP id a5so6118459wmb.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 06:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xtd57ANFwEVXtL9Ksemj5kAkfq1D3BufSA8HrwoNyGM=;
        b=crid5weIqLsxtB221E29RJHYKJ4O8HbVMdLMr8N6vDiqh1vo6BPFf2nP8ki8C+Hj8F
         +Eomn9sIwNriAp2P+lvdLmD3bLHQD41BfoRK0DA+NDGzpeqsduE/C8bCF7ddw/du1GCo
         Bk8QhkCflUQipTosllgUBmooWikSHyWLX41R+o7Y549gWUexa0zGki1FxTzDCyKwB3uX
         y7oGBx5v2Wj0zm9UF8t6TJ+FIFqG3+lrwSCDLTgST+UV7KPrFhT5JP3zGvgDqWIVdYFL
         ypuMa+rtMVyG3c+zwI1/YAeJckKDrQpo4SbcYzOoGd4hZELK5JKBcyBH/eGX9YrL5BLP
         ayfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xtd57ANFwEVXtL9Ksemj5kAkfq1D3BufSA8HrwoNyGM=;
        b=Z+PxcdGrcqx1bnMz85Gn89aOtdMz8CLfwB7nBqDSGCxX5CQnUGuTchyfUXG9BSPcTy
         I7HC9jtaxTXR1ctQ8uezRUWdxSw822bWo4apOZKsme4jE2I2+/vAGcsLZ3Nn65TfmG6o
         KYNrma1BIINH0O3Ilus6lLjvDYmJFeRfcB4R+a2OQ2KhVZBHnkCjhrujLahaIWHEyxeS
         MwQmMaTMrDTPcWfSMd3OoSwJrbwCcag/M6yRISD8JZxCMXKLTZ3aRys4wn8RPQW1t6Tp
         32cQCvZo5KVhhGkH0epqCjPE16e/QzsrmcALlDkY/RkJBfyKx+AerB+sKb9WB3OkFu+A
         e0dQ==
X-Gm-Message-State: ANhLgQ2RvegOiJGMtE/xp1p0l04oIAOKAYGemYvTM2P5J7jMxryMKHvh
        R1aElxOycZF6fY4WVsCUQt3Zl236rgtXoQ==
X-Google-Smtp-Source: ADFU+vv/Bf0cjqi786SLwyoflMdPEUVQYzJUoEEq10USnSQe6YhOpU8nPOsloJnqi5KX9B8MoPtHgg==
X-Received: by 2002:a1c:4805:: with SMTP id v5mr4776912wma.98.1584019900193;
        Thu, 12 Mar 2020 06:31:40 -0700 (PDT)
Received: from bender.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id m21sm12242885wmi.27.2020.03.12.06.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 06:31:39 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     broonie@kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-spi@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/9] spi: meson-spicc: setup IO line delay
Date:   Thu, 12 Mar 2020 14:31:28 +0100
Message-Id: <20200312133131.26430-7-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200312133131.26430-1-narmstrong@baylibre.com>
References: <20200312133131.26430-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now the controller can support frequencies higher than 30MHz, we need
the setup the I/O line delays in regard of the SPI clock frequency.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/spi/spi-meson-spicc.c | 61 ++++++++++++++++++++++++++++++++++-
 1 file changed, 60 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-meson-spicc.c b/drivers/spi/spi-meson-spicc.c
index b5bd3a897e8f..4494a791f4a7 100644
--- a/drivers/spi/spi-meson-spicc.c
+++ b/drivers/spi/spi-meson-spicc.c
@@ -106,7 +106,21 @@
 #define SPICC_SWAP_RO		BIT(14) /* RX FIFO Data Swap Read-Only */
 #define SPICC_SWAP_W1		BIT(15) /* RX FIFO Data Swap Write-Only */
 #define SPICC_DLYCTL_RO_MASK	GENMASK(20, 15) /* Delay Control Read-Only */
-#define SPICC_DLYCTL_W1_MASK	GENMASK(21, 16) /* Delay Control Write-Only */
+#define SPICC_MO_DELAY_MASK	GENMASK(17, 16) /* Master Output Delay */
+#define SPICC_MO_NO_DELAY	0
+#define SPICC_MO_DELAY_1_CYCLE	1
+#define SPICC_MO_DELAY_2_CYCLE	2
+#define SPICC_MO_DELAY_3_CYCLE	3
+#define SPICC_MI_DELAY_MASK	GENMASK(19, 18) /* Master Input Delay */
+#define SPICC_MI_NO_DELAY	0
+#define SPICC_MI_DELAY_1_CYCLE	1
+#define SPICC_MI_DELAY_2_CYCLE	2
+#define SPICC_MI_DELAY_3_CYCLE	3
+#define SPICC_MI_CAP_DELAY_MASK	GENMASK(21, 20) /* Master Capture Delay */
+#define SPICC_CAP_AHEAD_2_CYCLE	0
+#define SPICC_CAP_AHEAD_1_CYCLE	1
+#define SPICC_CAP_NO_DELAY	2
+#define SPICC_CAP_DELAY_1_CYCLE	3
 #define SPICC_FIFORST_RO_MASK	GENMASK(22, 21) /* FIFO Softreset Read-Only */
 #define SPICC_FIFORST_W1_MASK	GENMASK(23, 22) /* FIFO Softreset Write-Only */
 
@@ -328,6 +342,49 @@ static irqreturn_t meson_spicc_irq(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+static void meson_spicc_auto_io_delay(struct meson_spicc_device *spicc)
+{
+	u32 div, hz;
+	u32 mi_delay, cap_delay;
+	u32 conf;
+
+	if (spicc->data->has_enhance_clk_div) {
+		div = FIELD_GET(SPICC_ENH_DATARATE_MASK,
+				readl_relaxed(spicc->base + SPICC_ENH_CTL0));
+		div++;
+		div <<= 1;
+	} else {
+		div = FIELD_GET(SPICC_DATARATE_MASK,
+				readl_relaxed(spicc->base + SPICC_CONREG));
+		div += 2;
+		div = 1 << div;
+	}
+
+	mi_delay = SPICC_MI_NO_DELAY;
+	cap_delay = SPICC_CAP_AHEAD_2_CYCLE;
+	hz = clk_get_rate(spicc->clk);
+
+	if (hz >= 100000000)
+		cap_delay = SPICC_CAP_DELAY_1_CYCLE;
+	else if (hz >= 80000000)
+		cap_delay = SPICC_CAP_NO_DELAY;
+	else if (hz >= 40000000)
+		cap_delay = SPICC_CAP_AHEAD_1_CYCLE;
+	else if (div >= 16)
+		mi_delay = SPICC_MI_DELAY_3_CYCLE;
+	else if (div >= 8)
+		mi_delay = SPICC_MI_DELAY_2_CYCLE;
+	else if (div >= 6)
+		mi_delay = SPICC_MI_DELAY_1_CYCLE;
+
+	conf = readl_relaxed(spicc->base + SPICC_TESTREG);
+	conf &= ~(SPICC_MO_DELAY_MASK | SPICC_MI_DELAY_MASK
+		  | SPICC_MI_CAP_DELAY_MASK);
+	conf |= FIELD_PREP(SPICC_MI_DELAY_MASK, mi_delay);
+	conf |= FIELD_PREP(SPICC_MI_CAP_DELAY_MASK, cap_delay);
+	writel_relaxed(conf, spicc->base + SPICC_TESTREG);
+}
+
 static void meson_spicc_setup_xfer(struct meson_spicc_device *spicc,
 				   struct spi_transfer *xfer)
 {
@@ -346,6 +403,8 @@ static void meson_spicc_setup_xfer(struct meson_spicc_device *spicc,
 		writel_relaxed(conf, spicc->base + SPICC_CONREG);
 
 	clk_set_rate(spicc->clk, xfer->speed_hz);
+
+	meson_spicc_auto_io_delay(spicc);
 }
 
 static int meson_spicc_transfer_one(struct spi_master *master,
-- 
2.22.0

