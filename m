Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5398EC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 09:48:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3179F20656
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 09:48:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbgFKJsg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 05:48:36 -0400
Received: from alexa-out-blr-01.qualcomm.com ([103.229.18.197]:19527 "EHLO
        alexa-out-blr-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726684AbgFKJse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 05:48:34 -0400
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by alexa-out-blr-01.qualcomm.com with ESMTP/TLS/AES256-SHA; 11 Jun 2020 15:18:26 +0530
Received: from c-rbokka-linux.qualcomm.com ([10.206.232.238])
  by ironmsg02-blr.qualcomm.com with ESMTP; 11 Jun 2020 15:18:05 +0530
Received: by c-rbokka-linux.qualcomm.com (Postfix, from userid 203305)
        id E3B302CB3; Thu, 11 Jun 2020 15:18:04 +0530 (IST)
From:   Ravi Kumar Bokka <rbokka@codeaurora.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        rnayak@codeaurora.org, saiprakash.ranjan@codeaurora.org,
        dhavalp@codeaurora.org, mturney@codeaurora.org,
        sparate@codeaurora.org, c_rbokka@codeaurora.org,
        mkurumel@codeaurora.org, Ravi Kumar Bokka <rbokka@codeaurora.org>
Subject: [RFC v2 2/3] drivers: nvmem: Add QTI qfprom-efuse support
Date:   Thu, 11 Jun 2020 15:18:01 +0530
Message-Id: <1591868882-16553-3-git-send-email-rbokka@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591868882-16553-1-git-send-email-rbokka@codeaurora.org>
References: <1591868882-16553-1-git-send-email-rbokka@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for QTI qfprom-efuse controller. This driver can
access the raw qfprom regions for fuse blowing.

The current existed qfprom driver is only supports for cpufreq, thermal sensors
drivers by read out calibration data, speed bins..etc which is stored
by qfprom efuses.

Signed-off-by: Ravi Kumar Bokka <rbokka@codeaurora.org>
---
 drivers/nvmem/Kconfig  |   1 +
 drivers/nvmem/qfprom.c | 405 ++++++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 385 insertions(+), 21 deletions(-)

diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index d7b7f6d..623d59e 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -117,6 +117,7 @@ config QCOM_QFPROM
 	help
 	  Say y here to enable QFPROM support. The QFPROM provides access
 	  functions for QFPROM data to rest of the drivers via nvmem interface.
+	  And this driver provides access QTI qfprom efuse via nvmem interface.
 
 	  This driver can also be built as a module. If so, the module
 	  will be called nvmem_qfprom.
diff --git a/drivers/nvmem/qfprom.c b/drivers/nvmem/qfprom.c
index 8a91717..312318c 100644
--- a/drivers/nvmem/qfprom.c
+++ b/drivers/nvmem/qfprom.c
@@ -3,17 +3,266 @@
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
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
+#include <linux/regulator/consumer.h>
+
+#define QFPROM_BLOW_STATUS_BUSY 0x1
+#define QFPROM_BLOW_STATUS_READY 0x0
+
+/* Blow timer clock frequency in Mhz for 10nm LPe technology */
+#define QFPROM_BLOW_TIMER_OFFSET 0x03c
+#define QFPROM_BLOW_TIMER_RESET_VALUE 0x0
+
+/* Amount of time required to hold charge to blow fuse in micro-seconds */
+#define QFPROM_FUSE_BLOW_POLL_PERIOD 100
+#define QFPROM_BLOW_STATUS_OFFSET 0x048
+
+#define QFPROM_ACCEL_OFFSET 0x044
+
+/**
+ * struct qfprom_efuse_platform_data - structure holding qfprom-efuse
+ * platform data
+ *
+ * @name: qfprom-efuse compatible name
+ * @fuse_blow_time_in_us: Should contain the wait time when doing the fuse blow
+ * @accel_value: Should contain qfprom accel value
+ * @accel_reset_value: The reset value of qfprom accel value
+ * @qfprom_blow_timer_value: The timer value of qfprom when doing efuse blow
+ * @qfprom_blow_reset_freq: The frequency required to set when fuse blowing
+ * is done
+ * @qfprom_blow_set_freq: The frequency required to set when we start the
+ * fuse blowing
+ * @qfprom_max_vol: max voltage required to set fuse blow
+ * @qfprom_min_vol: min voltage required to set fuse blow
+ */
+struct qfprom_efuse_platform_data {
+	const char *name;
+	u8 fuse_blow_time_in_us;
+	u32 accel_value;
+	u32 accel_reset_value;
+	u32 qfprom_blow_timer_value;
+	u32 qfprom_blow_reset_freq;
+	u32 qfprom_blow_set_freq;
+	u32 qfprom_max_vol;
+	u32 qfprom_min_vol;
+};
+
+/**
+ * struct qfprom_priv - structure holding qfprom attributes
+ *
+ * @qfpraw: iomapped memory space for qfprom-efuse raw address space
+ * @qfpconf: iomapped memory space for qfprom-efuse configuration address space
+ * @qfpcorrected: iomapped memory space for qfprom corrected address space
+
+ * @dev: qfprom device structure
+ * @secclk: clock supply
+ * @vcc: regulator supply
 
+ * @qfprom_efuse_platform_data: qfprom platform data
+ */
 struct qfprom_priv {
-	void __iomem *base;
+	void __iomem *qfpraw;
+	void __iomem *qfpconf;
+	void __iomem *qfpcorrected;
+	struct device *dev;
+	struct clk *secclk;
+	struct regulator *vcc;
+	struct qfprom_efuse_platform_data efuse;
 };
 
+/*
+ * restore the gcc_sec_ctrl_clk frequency to default value(19.2 MHz)
+ */
+static int qfprom_reset_clock_settings(const struct qfprom_priv *priv)
+{
+	int ret;
+
+	ret = clk_set_rate(priv->secclk, priv->efuse.qfprom_blow_reset_freq);
+	if (ret) {
+		dev_err(priv->dev, "clk_set_rate() failed to enable secclk\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+/*
+ * set the gcc_sec_ctrl_clk to 4.8 MHz
+ */
+static int qfprom_set_clock_settings(const struct qfprom_priv *priv)
+{
+	int ret;
+
+	ret = clk_set_rate(priv->secclk, priv->efuse.qfprom_blow_set_freq);
+	if (ret) {
+		dev_err(priv->dev, "clk_set_rate() failed to enable secclk\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+/*
+ * set and reset the voltage for 1.8V and OFF(0V) on VDD_QFPROM (LDO11)
+ */
+static int qfprom_set_voltage_settings(const struct qfprom_priv *priv,
+					int min_uV, int max_uV)
+{
+	int ret;
+
+	ret = regulator_set_voltage(priv->vcc, min_uV, max_uV);
+	if (ret) {
+		dev_err(priv->dev, "regulator_set_voltage() failed!\n");
+		return ret;
+	}
+
+	ret = regulator_enable(priv->vcc);
+	if (ret) {
+		dev_err(priv->dev, "failed to enable regulator\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+/*
+ * resets the value of the blow timer, accel register and the clock
+ * and voltage settings
+ */
+static int qfprom_disable_fuse_blowing(const struct qfprom_priv *priv)
+{
+	int ret;
+
+	ret = qfprom_set_voltage_settings(priv, 0, priv->efuse.qfprom_max_vol);
+	if (ret) {
+		dev_err(priv->dev, "qfprom_set_voltage_settings failed\n");
+		return ret;
+	}
+
+	ret = qfprom_reset_clock_settings(priv);
+	if (ret) {
+		dev_err(priv->dev, "qfprom_reset_clock_settings failed\n");
+		return ret;
+	}
+
+	writel(QFPROM_BLOW_TIMER_RESET_VALUE, priv->qfpconf +
+			QFPROM_BLOW_TIMER_OFFSET);
+	writel(priv->efuse.accel_reset_value,
+		priv->qfpconf + QFPROM_ACCEL_OFFSET);
+
+	return 0;
+}
+
+/*
+ * sets the value of the blow timer, accel register and the clock
+ * and voltage settings
+ */
+static int qfprom_enable_fuse_blowing(const struct qfprom_priv *priv)
+{
+	int ret;
+
+	ret = qfprom_set_clock_settings(priv);
+	if (ret) {
+		dev_err(priv->dev, "qpfrom_set_clock_settings()\n");
+		return ret;
+	}
+
+	ret = qfprom_set_voltage_settings(priv, priv->efuse.qfprom_min_vol,
+						priv->efuse.qfprom_max_vol);
+
+	if (ret) {
+		dev_err(priv->dev, "qfprom_set_voltage_settings()\n");
+		return ret;
+	}
+
+	writel(priv->efuse.qfprom_blow_timer_value, priv->qfpconf +
+	       QFPROM_BLOW_TIMER_OFFSET);
+	writel(priv->efuse.accel_value, priv->qfpconf + QFPROM_ACCEL_OFFSET);
+
+	return 0;
+}
+
+/*
+ * API for writing to raw qfprom region - fuse blowing
+ * returns success or failure code as per the conditions
+ */
+static int qfprom_efuse_reg_write(void *context, unsigned int reg, void *_val,
+					size_t bytes)
+{
+	struct qfprom_priv *priv = context;
+	u32 *value = _val;
+	u32 align_check;
+	u32 blow_status = QFPROM_BLOW_STATUS_BUSY;
+	int ret;
+	int i = 0, words = bytes / 4;
+
+	dev_info(priv->dev,
+		 "writing to raw qfprom region : 0x%08x of size: %zd\n",
+		 reg, bytes);
+
+	if (bytes % 4 != 0x00) {
+		dev_err(priv->dev, "Bytes: %zd should be word align\n", bytes);
+		return -EINVAL;
+	}
+
+	align_check = (reg & 0xF);
+	if (value && ((align_check & ~3) == align_check)) {
+		ret = qfprom_enable_fuse_blowing(priv);
+		if (ret) {
+			dev_err(priv->dev, "qfprom_enable_fuse_blowing\n");
+			return ret;
+		}
+
+		ret = readl_relaxed_poll_timeout(priv->qfpconf +
+				QFPROM_BLOW_STATUS_OFFSET, blow_status,
+				(blow_status  != QFPROM_BLOW_STATUS_BUSY),
+				QFPROM_FUSE_BLOW_POLL_PERIOD,
+				priv->efuse.fuse_blow_time_in_us);
+
+		if (ret) {
+			dev_err(priv->dev, "Timeout blow status ready\n");
+			return ret;
+		}
+
+		if (blow_status == QFPROM_BLOW_STATUS_READY) {
+			while (words--)
+				writel(*value++,
+				       priv->qfpraw + reg + (i++ * 4));
+
+			ret = readl_relaxed_poll_timeout(priv->qfpconf +
+				QFPROM_BLOW_STATUS_OFFSET, blow_status,
+				(blow_status  != QFPROM_BLOW_STATUS_BUSY),
+				QFPROM_FUSE_BLOW_POLL_PERIOD,
+				priv->efuse.fuse_blow_time_in_us);
+
+			if (ret) {
+				dev_err(priv->dev, "Timeout blow-status ready\n");
+				return ret;
+			}
+		}
+
+		ret = qfprom_disable_fuse_blowing(priv);
+		if (ret)
+			return ret;
+	} else {
+		dev_err(priv->dev, "Invalid input parameter fuse blow address");
+		return -EINVAL;
+	}
+
+	dev_info(priv->dev, "written successfully raw qfprom region\n");
+
+	return 0;
+}
+
 static int qfprom_reg_read(void *context,
 			unsigned int reg, void *_val, size_t bytes)
 {
@@ -22,47 +271,161 @@ static int qfprom_reg_read(void *context,
 	int i = 0, words = bytes;
 
 	while (words--)
-		*val++ = readb(priv->base + reg + i++);
+		*val++ = readb(priv->qfpraw + reg + i++);
 
 	return 0;
 }
 
-static struct nvmem_config econfig = {
-	.name = "qfprom",
-	.stride = 1,
-	.word_size = 1,
-	.reg_read = qfprom_reg_read,
-};
+static int qfprom_reg_write(void *context,
+			 unsigned int reg, void *_val, size_t bytes)
+{
+	struct qfprom_priv *priv = context;
+	u8 *val = _val;
+	int i = 0, words = bytes;
+
+	while (words--)
+		writeb(*val++, priv->qfpraw + reg + i++);
+
+	return 0;
+}
 
 static int qfprom_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct resource *res;
-	struct nvmem_device *nvmem;
+	struct resource *qfpraw, *qfpconf, *qfpcorrected;
+	struct nvmem_device *nvmem, *nvmem_efuse;
+	struct nvmem_config *econfig, *econfig_efuse;
 	struct qfprom_priv *priv;
+	const struct qfprom_efuse_platform_data *drvdata;
+	int ret;
+
+	drvdata = of_device_get_match_data(&pdev->dev);
+	if (!drvdata)
+		return -EINVAL;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	priv->base = devm_ioremap_resource(dev, res);
-	if (IS_ERR(priv->base))
-		return PTR_ERR(priv->base);
+	priv->efuse.fuse_blow_time_in_us = drvdata->fuse_blow_time_in_us;
+	priv->efuse.accel_value = drvdata->accel_value;
+	priv->efuse.accel_reset_value = drvdata->accel_reset_value;
+	priv->efuse.qfprom_blow_timer_value = drvdata->qfprom_blow_timer_value;
+	priv->efuse.qfprom_blow_reset_freq = drvdata->qfprom_blow_reset_freq;
+	priv->efuse.qfprom_blow_set_freq = drvdata->qfprom_blow_set_freq;
+	priv->efuse.qfprom_max_vol = drvdata->qfprom_max_vol;
+	priv->efuse.qfprom_min_vol = drvdata->qfprom_min_vol;
+	priv->dev = dev;
+
+	qfpraw = platform_get_resource_byname(pdev, IORESOURCE_MEM, "raw");
+
+	priv->qfpraw = devm_ioremap_resource(dev, qfpraw);
+	if (IS_ERR(priv->qfpraw)) {
+		ret = PTR_ERR(priv->qfpraw);
+		goto err;
+	}
+
+	qfpconf = platform_get_resource_byname(pdev, IORESOURCE_MEM, "conf");
+
+	priv->qfpconf = devm_ioremap_resource(dev, qfpconf);
+	if (IS_ERR(priv->qfpconf)) {
+		ret = PTR_ERR(priv->qfpconf);
+		goto err;
+	}
+
+	qfpcorrected = platform_get_resource_byname(pdev, IORESOURCE_MEM,
+						    "corrected");
+
+	priv->qfpcorrected = devm_ioremap_resource(dev, qfpcorrected);
+	if (IS_ERR(priv->qfpcorrected)) {
+		ret = PTR_ERR(priv->qfpcorrected);
+		goto err;
+	}
+
+	priv->vcc = devm_regulator_get(&pdev->dev, "vcc");
+	if (IS_ERR(priv->vcc)) {
+		ret = PTR_ERR(priv->vcc);
+		if (ret == -ENODEV)
+			ret = -EPROBE_DEFER;
+		goto err;
+	}
 
-	econfig.size = resource_size(res);
-	econfig.dev = dev;
-	econfig.priv = priv;
+	priv->secclk = devm_clk_get(dev, "secclk");
+	if (IS_ERR(priv->secclk)) {
+		ret = PTR_ERR(priv->secclk);
+		if (ret != -EPROBE_DEFER)
+			dev_err(dev, "secclk error getting : %d\n", ret);
+		goto err;
+	}
 
-	nvmem = devm_nvmem_register(dev, &econfig);
+	ret = clk_prepare_enable(priv->secclk);
+	if (ret) {
+		dev_err(dev, "clk_prepare_enable() failed\n");
+		goto err;
+	}
 
-	return PTR_ERR_OR_ZERO(nvmem);
+	econfig_efuse = devm_kzalloc(dev, sizeof(*econfig_efuse), GFP_KERNEL);
+	if (!econfig_efuse)
+		return -ENOMEM;
+
+	econfig_efuse->dev = dev;
+	econfig_efuse->name = "qfprom-efuse";
+	econfig_efuse->stride = 1;
+	econfig_efuse->word_size = 1;
+	econfig_efuse->reg_read = qfprom_reg_read;
+	econfig_efuse->reg_write = qfprom_efuse_reg_write;
+	econfig_efuse->size = resource_size(qfpraw);
+	econfig_efuse->priv = priv;
+
+	nvmem_efuse = devm_nvmem_register(dev, econfig_efuse);
+	if (IS_ERR(nvmem_efuse)) {
+		dev_err(&pdev->dev, "failed to register nvmem config\n");
+		return PTR_ERR(nvmem_efuse);
+	}
+
+	econfig = devm_kzalloc(dev, sizeof(*econfig), GFP_KERNEL);
+	if (!econfig)
+		return -ENOMEM;
+
+	econfig->name = "qfprom",
+	econfig->stride = 1,
+	econfig->word_size = 1,
+	econfig->reg_read = qfprom_reg_read,
+	econfig->reg_write = qfprom_reg_write,
+	econfig->size = resource_size(qfpcorrected);
+	econfig->dev = dev;
+	econfig->priv = priv;
+
+	nvmem = devm_nvmem_register(dev, econfig);
+	if (IS_ERR(nvmem)) {
+		dev_err(&pdev->dev, "failed to register nvmem config\n");
+		return PTR_ERR(nvmem);
+	}
+
+err:
+	clk_disable_unprepare(priv->secclk);
+	return ret;
 }
 
+static const struct qfprom_efuse_platform_data sc7180_qfp_efuse_data = {
+	.name = "qfprom",
+	.fuse_blow_time_in_us = 10,
+	.accel_value = 0xD10,
+	.accel_reset_value = 0x800,
+	.qfprom_blow_timer_value = 25,
+	.qfprom_blow_reset_freq = 19200000,
+	.qfprom_blow_set_freq = 4800000,
+	.qfprom_max_vol = 1904000,
+	.qfprom_min_vol = 1800000,
+};
+
 static const struct of_device_id qfprom_of_match[] = {
-	{ .compatible = "qcom,qfprom",},
+	{ .compatible = "qcom,qfprom",
+	  .data = &sc7180_qfp_efuse_data
+	},
 	{/* sentinel */},
 };
+
 MODULE_DEVICE_TABLE(of, qfprom_of_match);
 
 static struct platform_driver qfprom_driver = {
-- 
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, hosted by the Linux Foundation.

