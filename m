Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93023C433E7
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 10:08:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56B81206D7
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 10:08:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZthWRfFf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732065AbgGVKIm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 06:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731953AbgGVKIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 06:08:24 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E45C0619DE
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 03:08:24 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id f7so1330996wrw.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 03:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zRapNjxrqB1uxO6NAkm6u+cvOE2/riL4mk73jGOU64M=;
        b=ZthWRfFfDpWJeCimrfGmrOQruVkFndaV1M+Jv4Wfb4BQvPg1veV3wn9zlMGiigcGw4
         uOWHgveyl0J4F+1oD3dD25H85gAYSqfZs9a0tVwWrAvg1hG0PcdKbU5bFkZFmQCxRF1o
         xkaZ4Fg8SpoZPK2VHGdiXJknyiOgstQbGi6vxM8gtcwOgkbtustzQfXc9rMj0GkLNzHU
         A45yrjChbsm5GR4BjibhhDqWULnPHkn8nTAstOARMf80cinyx5/DkuTWG4Ak7mVFFmAk
         1ncKgRsP3WkmGeZiKT7LZpvmP5vjkQqOaxVGeZEWyCeKmJ9A2lsNNQtTJ61sn0Gh4gqF
         zWKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zRapNjxrqB1uxO6NAkm6u+cvOE2/riL4mk73jGOU64M=;
        b=H2S9ubr3WjOMOTPl7Ycl62Wuk9X4I4sabF1Gk/hrgznqt/jU2v/k6eIACtRj5BkNY1
         SjslLZPmEkF6qNd86wb8j372Movs9ZxFxSRZnPOXazGPvNIh9pmorDtUrVAIKG8VAEzM
         u3nxZp73o56Fnb2Hlo0pxTxAHAb41dNfz8Jc2Kyuda9yGhvhI+elUsjLEv/aPZuhjWET
         lzWeOz+u5w4i91Rr2bup6wwkzM5pWwo1a36iGP22x1k288q2k/oMy3gCwBmMxh/4vy+D
         H6Zlm2nHS2YDspY1xzEDovC6PGSiCdSqZ7FN8azrnRllqjBi0P+8AcUcI/+HEpvWxunk
         LeaA==
X-Gm-Message-State: AOAM531PWAZMDHXNmR/UtNHbnUZPl3hsd0EkhXNvL54iC07zUzpZ38MG
        iyA1RIysTnf78IWcEuSS3efCiw==
X-Google-Smtp-Source: ABdhPJxjbxLtfdabF9DWFtFZJGKcOnmhOl6csNV1FwIgXjxKQzB2X5YaFYaVybNJY4SBbYATESN9iQ==
X-Received: by 2002:adf:ec04:: with SMTP id x4mr12905440wrn.28.1595412502795;
        Wed, 22 Jul 2020 03:08:22 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id t13sm17098623wru.65.2020.07.22.03.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 03:08:21 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Ravi Kumar Bokka <rbokka@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 11/14] nvmem: qfprom: Add fuse blowing support
Date:   Wed, 22 Jul 2020 11:07:02 +0100
Message-Id: <20200722100705.7772-12-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200722100705.7772-1-srinivas.kandagatla@linaro.org>
References: <20200722100705.7772-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ravi Kumar Bokka <rbokka@codeaurora.org>

This patch adds support for blowing fuses to the qfprom driver if the
required properties are defined in the device tree.

[Srini: Fixed merge conflict with AUTO ID]
Signed-off-by: Ravi Kumar Bokka <rbokka@codeaurora.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/qfprom.c | 316 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 304 insertions(+), 12 deletions(-)

diff --git a/drivers/nvmem/qfprom.c b/drivers/nvmem/qfprom.c
index 8b425f8d847d..5e9e60e2e591 100644
--- a/drivers/nvmem/qfprom.c
+++ b/drivers/nvmem/qfprom.c
@@ -3,58 +3,350 @@
  * Copyright (C) 2015 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
  */
 
+#include <linux/clk.h>
 #include <linux/device.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
-#include <linux/io.h>
 #include <linux/nvmem-provider.h>
 #include <linux/platform_device.h>
+#include <linux/regulator/consumer.h>
+
+/* Blow timer clock frequency in Mhz */
+#define QFPROM_BLOW_TIMER_OFFSET 0x03c
+
+/* Amount of time required to hold charge to blow fuse in micro-seconds */
+#define QFPROM_FUSE_BLOW_POLL_US	100
+#define QFPROM_FUSE_BLOW_TIMEOUT_US	1000
+
+#define QFPROM_BLOW_STATUS_OFFSET	0x048
+#define QFPROM_BLOW_STATUS_BUSY		0x1
+#define QFPROM_BLOW_STATUS_READY	0x0
+
+#define QFPROM_ACCEL_OFFSET		0x044
+
+#define QFPROM_VERSION_OFFSET		0x0
+#define QFPROM_MAJOR_VERSION_SHIFT	28
+#define QFPROM_MAJOR_VERSION_MASK	GENMASK(31, QFPROM_MAJOR_VERSION_SHIFT)
+#define QFPROM_MINOR_VERSION_SHIFT	16
+#define QFPROM_MINOR_VERSION_MASK	GENMASK(27, QFPROM_MINOR_VERSION_SHIFT)
+
+static bool read_raw_data;
+module_param(read_raw_data, bool, 0644);
+MODULE_PARM_DESC(read_raw_data, "Read raw instead of corrected data");
 
+/**
+ * struct qfprom_soc_data - config that varies from SoC to SoC.
+ *
+ * @accel_value:             Should contain qfprom accel value.
+ * @qfprom_blow_timer_value: The timer value of qfprom when doing efuse blow.
+ * @qfprom_blow_set_freq:    The frequency required to set when we start the
+ *                           fuse blowing.
+ */
+struct qfprom_soc_data {
+	u32 accel_value;
+	u32 qfprom_blow_timer_value;
+	u32 qfprom_blow_set_freq;
+};
+
+/**
+ * struct qfprom_priv - structure holding qfprom attributes
+ *
+ * @qfpraw:       iomapped memory space for qfprom-efuse raw address space.
+ * @qfpconf:      iomapped memory space for qfprom-efuse configuration address
+ *                space.
+ * @qfpcorrected: iomapped memory space for qfprom corrected address space.
+ * @qfpsecurity:  iomapped memory space for qfprom security control space.
+ * @dev:          qfprom device structure.
+ * @secclk:       Clock supply.
+ * @vcc:          Regulator supply.
+ * @soc_data:     Data that for things that varies from SoC to SoC.
+ */
 struct qfprom_priv {
-	void __iomem *base;
+	void __iomem *qfpraw;
+	void __iomem *qfpconf;
+	void __iomem *qfpcorrected;
+	void __iomem *qfpsecurity;
+	struct device *dev;
+	struct clk *secclk;
+	struct regulator *vcc;
+	const struct qfprom_soc_data *soc_data;
+};
+
+/**
+ * struct qfprom_touched_values - saved values to restore after blowing
+ *
+ * @clk_rate: The rate the clock was at before blowing.
+ * @accel_val: The value of the accel reg before blowing.
+ * @timer_val: The value of the timer before blowing.
+ */
+struct qfprom_touched_values {
+	unsigned long clk_rate;
+	u32 accel_val;
+	u32 timer_val;
 };
 
+/**
+ * qfprom_disable_fuse_blowing() - Undo enabling of fuse blowing.
+ * @priv: Our driver data.
+ * @old:  The data that was stashed from before fuse blowing.
+ *
+ * Resets the value of the blow timer, accel register and the clock
+ * and voltage settings.
+ *
+ * Prints messages if there are errors but doesn't return an error code
+ * since there's not much we can do upon failure.
+ */
+static void qfprom_disable_fuse_blowing(const struct qfprom_priv *priv,
+					const struct qfprom_touched_values *old)
+{
+	int ret;
+
+	ret = regulator_disable(priv->vcc);
+	if (ret)
+		dev_warn(priv->dev, "Failed to disable regulator (ignoring)\n");
+
+	ret = clk_set_rate(priv->secclk, old->clk_rate);
+	if (ret)
+		dev_warn(priv->dev,
+			 "Failed to set clock rate for disable (ignoring)\n");
+
+	clk_disable_unprepare(priv->secclk);
+
+	writel(old->timer_val, priv->qfpconf + QFPROM_BLOW_TIMER_OFFSET);
+	writel(old->accel_val, priv->qfpconf + QFPROM_ACCEL_OFFSET);
+}
+
+/**
+ * qfprom_enable_fuse_blowing() - Enable fuse blowing.
+ * @priv: Our driver data.
+ * @old:  We'll stash stuff here to use when disabling.
+ *
+ * Sets the value of the blow timer, accel register and the clock
+ * and voltage settings.
+ *
+ * Prints messages if there are errors so caller doesn't need to.
+ *
+ * Return: 0 or -err.
+ */
+static int qfprom_enable_fuse_blowing(const struct qfprom_priv *priv,
+				      struct qfprom_touched_values *old)
+{
+	int ret;
+
+	ret = clk_prepare_enable(priv->secclk);
+	if (ret) {
+		dev_err(priv->dev, "Failed to enable clock\n");
+		return ret;
+	}
+
+	old->clk_rate = clk_get_rate(priv->secclk);
+	ret = clk_set_rate(priv->secclk, priv->soc_data->qfprom_blow_set_freq);
+	if (ret) {
+		dev_err(priv->dev, "Failed to set clock rate for enable\n");
+		goto err_clk_prepared;
+	}
+
+	ret = regulator_enable(priv->vcc);
+	if (ret) {
+		dev_err(priv->dev, "Failed to enable regulator\n");
+		goto err_clk_rate_set;
+	}
+
+	old->timer_val = readl(priv->qfpconf + QFPROM_BLOW_TIMER_OFFSET);
+	old->accel_val = readl(priv->qfpconf + QFPROM_ACCEL_OFFSET);
+	writel(priv->soc_data->qfprom_blow_timer_value,
+	       priv->qfpconf + QFPROM_BLOW_TIMER_OFFSET);
+	writel(priv->soc_data->accel_value,
+	       priv->qfpconf + QFPROM_ACCEL_OFFSET);
+
+	return 0;
+
+err_clk_rate_set:
+	clk_set_rate(priv->secclk, old->clk_rate);
+err_clk_prepared:
+	clk_disable_unprepare(priv->secclk);
+	return ret;
+}
+
+/**
+ * qfprom_efuse_reg_write() - Write to fuses.
+ * @context: Our driver data.
+ * @reg:     The offset to write at.
+ * @_val:    Pointer to data to write.
+ * @bytes:   The number of bytes to write.
+ *
+ * Writes to fuses.  WARNING: THIS IS PERMANENT.
+ *
+ * Return: 0 or -err.
+ */
+static int qfprom_reg_write(void *context, unsigned int reg, void *_val,
+			    size_t bytes)
+{
+	struct qfprom_priv *priv = context;
+	struct qfprom_touched_values old;
+	int words = bytes / 4;
+	u32 *value = _val;
+	u32 blow_status;
+	int ret;
+	int i;
+
+	dev_dbg(priv->dev,
+		"Writing to raw qfprom region : %#010x of size: %zu\n",
+		reg, bytes);
+
+	/*
+	 * The hardware only allows us to write word at a time, but we can
+	 * read byte at a time.  Until the nvmem framework allows a separate
+	 * word_size and stride for reading vs. writing, we'll enforce here.
+	 */
+	if (bytes % 4) {
+		dev_err(priv->dev,
+			"%zu is not an integral number of words\n", bytes);
+		return -EINVAL;
+	}
+	if (reg % 4) {
+		dev_err(priv->dev,
+			"Invalid offset: %#x.  Must be word aligned\n", reg);
+		return -EINVAL;
+	}
+
+	ret = qfprom_enable_fuse_blowing(priv, &old);
+	if (ret)
+		return ret;
+
+	ret = readl_relaxed_poll_timeout(
+		priv->qfpconf + QFPROM_BLOW_STATUS_OFFSET,
+		blow_status, blow_status == QFPROM_BLOW_STATUS_READY,
+		QFPROM_FUSE_BLOW_POLL_US, QFPROM_FUSE_BLOW_TIMEOUT_US);
+
+	if (ret) {
+		dev_err(priv->dev,
+			"Timeout waiting for initial ready; aborting.\n");
+		goto exit_enabled_fuse_blowing;
+	}
+
+	for (i = 0; i < words; i++)
+		writel(value[i], priv->qfpraw + reg + (i * 4));
+
+	ret = readl_relaxed_poll_timeout(
+		priv->qfpconf + QFPROM_BLOW_STATUS_OFFSET,
+		blow_status, blow_status == QFPROM_BLOW_STATUS_READY,
+		QFPROM_FUSE_BLOW_POLL_US, QFPROM_FUSE_BLOW_TIMEOUT_US);
+
+	/* Give an error, but not much we can do in this case */
+	if (ret)
+		dev_err(priv->dev, "Timeout waiting for finish.\n");
+
+exit_enabled_fuse_blowing:
+	qfprom_disable_fuse_blowing(priv, &old);
+
+	return ret;
+}
+
 static int qfprom_reg_read(void *context,
 			unsigned int reg, void *_val, size_t bytes)
 {
 	struct qfprom_priv *priv = context;
 	u8 *val = _val;
 	int i = 0, words = bytes;
+	void __iomem *base = priv->qfpcorrected;
+
+	if (read_raw_data && priv->qfpraw)
+		base = priv->qfpraw;
 
 	while (words--)
-		*val++ = readb(priv->base + reg + i++);
+		*val++ = readb(base + reg + i++);
 
 	return 0;
 }
 
-static struct nvmem_config econfig = {
-	.name = "qfprom",
-	.stride = 1,
-	.word_size = 1,
-	.id = NVMEM_DEVID_AUTO,
-	.reg_read = qfprom_reg_read,
+static const struct qfprom_soc_data qfprom_7_8_data = {
+	.accel_value = 0xD10,
+	.qfprom_blow_timer_value = 25,
+	.qfprom_blow_set_freq = 4800000,
 };
 
 static int qfprom_probe(struct platform_device *pdev)
 {
+	struct nvmem_config econfig = {
+		.name = "qfprom",
+		.stride = 1,
+		.word_size = 1,
+		.id = NVMEM_DEVID_AUTO,
+		.reg_read = qfprom_reg_read,
+	};
 	struct device *dev = &pdev->dev;
 	struct resource *res;
 	struct nvmem_device *nvmem;
 	struct qfprom_priv *priv;
+	int ret;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
+	/* The corrected section is always provided */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	priv->base = devm_ioremap_resource(dev, res);
-	if (IS_ERR(priv->base))
-		return PTR_ERR(priv->base);
+	priv->qfpcorrected = devm_ioremap_resource(dev, res);
+	if (IS_ERR(priv->qfpcorrected))
+		return PTR_ERR(priv->qfpcorrected);
 
 	econfig.size = resource_size(res);
 	econfig.dev = dev;
 	econfig.priv = priv;
 
+	priv->dev = dev;
+
+	/*
+	 * If more than one region is provided then the OS has the ability
+	 * to write.
+	 */
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	if (res) {
+		u32 version;
+		int major_version, minor_version;
+
+		priv->qfpraw = devm_ioremap_resource(dev, res);
+		if (IS_ERR(priv->qfpraw))
+			return PTR_ERR(priv->qfpraw);
+		res = platform_get_resource(pdev, IORESOURCE_MEM, 2);
+		priv->qfpconf = devm_ioremap_resource(dev, res);
+		if (IS_ERR(priv->qfpconf))
+			return PTR_ERR(priv->qfpconf);
+		res = platform_get_resource(pdev, IORESOURCE_MEM, 3);
+		priv->qfpsecurity = devm_ioremap_resource(dev, res);
+		if (IS_ERR(priv->qfpsecurity))
+			return PTR_ERR(priv->qfpsecurity);
+
+		version = readl(priv->qfpsecurity + QFPROM_VERSION_OFFSET);
+		major_version = (version & QFPROM_MAJOR_VERSION_MASK) >>
+				QFPROM_MAJOR_VERSION_SHIFT;
+		minor_version = (version & QFPROM_MINOR_VERSION_MASK) >>
+				QFPROM_MINOR_VERSION_SHIFT;
+
+		if (major_version == 7 && minor_version == 8)
+			priv->soc_data = &qfprom_7_8_data;
+
+		priv->vcc = devm_regulator_get(&pdev->dev, "vcc");
+		if (IS_ERR(priv->vcc))
+			return PTR_ERR(priv->vcc);
+
+		priv->secclk = devm_clk_get(dev, "core");
+		if (IS_ERR(priv->secclk)) {
+			ret = PTR_ERR(priv->secclk);
+			if (ret != -EPROBE_DEFER)
+				dev_err(dev, "Error getting clock: %d\n", ret);
+			return ret;
+		}
+
+		/* Only enable writing if we have SoC data. */
+		if (priv->soc_data)
+			econfig.reg_write = qfprom_reg_write;
+	}
+
 	nvmem = devm_nvmem_register(dev, &econfig);
 
 	return PTR_ERR_OR_ZERO(nvmem);
-- 
2.21.0

