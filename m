Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D33F9C18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:23:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99809208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:23:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ObyrWGxp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731186AbgCJNXz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 09:23:55 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50396 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728897AbgCJNXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 09:23:50 -0400
Received: by mail-wm1-f67.google.com with SMTP id a5so1398656wmb.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 06:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O7VFPOQteOsoA9wrAjHcwnb1g72zqJyx1KebEqSTfWc=;
        b=ObyrWGxpGlO/bqT+/yUxqcQFTozpCud6NoZnOgK7IWK/kxZC0fA5HVoorZSIzM5c8E
         gKbVvyvTU0HT255wWQuzqnjvevMe1f1t//HpSCIwhFqDHsIK0mZqnUaCikjDp9oTxjiT
         okAYGxUBK1y7KASseA/vRKktKpGNdyU/LECFFKjiYTOsLrshWh2EkJGAaZ/rN+qubdsf
         DGbopHTpQXlw6H+xhhAAADjdC7QT2rvalLyAJAmMRu+gla7sovjQypdwWfCO3/rgyVwj
         IEZoRxHJA8iO9LtQp2R5dHLthgApHdPeMpg9dzIn/VId/uIrc3LrWWBa/HvqF3cFLpmh
         WSSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O7VFPOQteOsoA9wrAjHcwnb1g72zqJyx1KebEqSTfWc=;
        b=TmEcYEoZ9hocRJMooxktRdMVKkL8OFtB/qUlX89GCHI2JKa07sJN/Yb2vEqirpeOd/
         CDtVB3eqnHMio5hDMrBItHiE/uhzuUwTfaDKCSFDf8kL6Zs7xvJs/goIG6LJbt5+pNAW
         tgEEE+VnucYIxsY8bUKuhq7pt7M7NXnGDDem2bJInIViyY3NcnU6V436BkCoUob+dL5W
         icT9k9i01doyGxl3diYiYsnGn2imbKUWq4plO1IVKJ5spwXfSzQqAS1yVSDM8upGFIBg
         aH2Ida+X6uYgyVmGxnOqsDW/F2m370e4ssuZ/x1KgGVu4cSoHA62MC7qhIXi8c4fTU2U
         H0+g==
X-Gm-Message-State: ANhLgQ3J9PPaMUocnpQsLaiqLu6Oy3okmFpZc+RARQTdnmqY/0GhOhEk
        fiztEFLdmTXBRXAoEtzitFB0kw==
X-Google-Smtp-Source: ADFU+vvhBGXUAca/6CA//7dyfAicLuxQrphfkIsnJQ389qNsYIX4rpoqdBNsZeyj6CcQTUh3wUHzwA==
X-Received: by 2002:a05:600c:210d:: with SMTP id u13mr2285850wml.92.1583846626740;
        Tue, 10 Mar 2020 06:23:46 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id s22sm3761199wmc.16.2020.03.10.06.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 06:23:46 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>,
        Mathieu Malaterre <malat@debian.org>,
        "H . Nikolaus Schaller" <hns@goldelico.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 12/14] nvmem: add driver for JZ4780 efuse
Date:   Tue, 10 Mar 2020 13:22:55 +0000
Message-Id: <20200310132257.23358-13-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200310132257.23358-1-srinivas.kandagatla@linaro.org>
References: <20200310132257.23358-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>

This patch brings support for the JZ4780 efuse. Currently it only exposes
a read only access to the entire 8K bits efuse memory and nvmem cells.

To fetch for example the MAC address:

dd if=/sys/devices/platform/134100d0.efuse/jz4780-efuse0/nvmem bs=1 skip=34 count=6 status=none | xxd

Tested-by: Mathieu Malaterre <malat@debian.org>
Signed-off-by: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Signed-off-by: Mathieu Malaterre <malat@debian.org>
Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/Kconfig        |  12 ++
 drivers/nvmem/Makefile       |   2 +
 drivers/nvmem/jz4780-efuse.c | 239 +++++++++++++++++++++++++++++++++++
 3 files changed, 253 insertions(+)
 create mode 100644 drivers/nvmem/jz4780-efuse.c

diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index 35efab1ba8d9..d7b7f6d688e7 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -55,6 +55,18 @@ config NVMEM_IMX_OCOTP_SCU
 	  This is a driver for the SCU On-Chip OTP Controller (OCOTP)
 	  available on i.MX8 SoCs.
 
+config JZ4780_EFUSE
+	tristate "JZ4780 EFUSE Memory Support"
+	depends on MACH_INGENIC || COMPILE_TEST
+	depends on HAS_IOMEM
+	depends on OF
+	select REGMAP_MMIO
+	help
+	  Say Y here to include support for JZ4780 efuse memory found on
+	  all JZ4780 SoC based devices.
+	  To compile this driver as a module, choose M here: the module
+	  will be called nvmem_jz4780_efuse.
+
 config NVMEM_LPC18XX_EEPROM
 	tristate "NXP LPC18XX EEPROM Memory Support"
 	depends on ARCH_LPC18XX || COMPILE_TEST
diff --git a/drivers/nvmem/Makefile b/drivers/nvmem/Makefile
index 6b466cd1427b..65a268d17807 100644
--- a/drivers/nvmem/Makefile
+++ b/drivers/nvmem/Makefile
@@ -18,6 +18,8 @@ obj-$(CONFIG_NVMEM_IMX_OCOTP)	+= nvmem-imx-ocotp.o
 nvmem-imx-ocotp-y		:= imx-ocotp.o
 obj-$(CONFIG_NVMEM_IMX_OCOTP_SCU)	+= nvmem-imx-ocotp-scu.o
 nvmem-imx-ocotp-scu-y		:= imx-ocotp-scu.o
+obj-$(CONFIG_JZ4780_EFUSE)		+= nvmem_jz4780_efuse.o
+nvmem_jz4780_efuse-y		:= jz4780-efuse.o
 obj-$(CONFIG_NVMEM_LPC18XX_EEPROM)	+= nvmem_lpc18xx_eeprom.o
 nvmem_lpc18xx_eeprom-y	:= lpc18xx_eeprom.o
 obj-$(CONFIG_NVMEM_LPC18XX_OTP)	+= nvmem_lpc18xx_otp.o
diff --git a/drivers/nvmem/jz4780-efuse.c b/drivers/nvmem/jz4780-efuse.c
new file mode 100644
index 000000000000..51d140980b1e
--- /dev/null
+++ b/drivers/nvmem/jz4780-efuse.c
@@ -0,0 +1,239 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * JZ4780 EFUSE Memory Support driver
+ *
+ * Copyright (c) 2017 PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
+ * Copyright (c) 2020 H. Nikolaus Schaller <hns@goldelico.com>
+ */
+
+/*
+ * Currently supports JZ4780 efuse which has 8K programmable bit.
+ * Efuse is separated into seven segments as below:
+ *
+ * -----------------------------------------------------------------------
+ * | 64 bit | 128 bit | 128 bit | 3520 bit | 8 bit | 2296 bit | 2048 bit |
+ * -----------------------------------------------------------------------
+ *
+ * The rom itself is accessed using a 9 bit address line and an 8 word wide bus
+ * which reads/writes based on strobes. The strobe is configured in the config
+ * register and is based on number of cycles of the bus clock.
+ *
+ * Driver supports read only as the writes are done in the Factory.
+ */
+
+#include <linux/bitops.h>
+#include <linux/clk.h>
+#include <linux/module.h>
+#include <linux/nvmem-provider.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/timer.h>
+
+#define JZ_EFUCTRL		(0x0)	/* Control Register */
+#define JZ_EFUCFG		(0x4)	/* Configure Register*/
+#define JZ_EFUSTATE		(0x8)	/* Status Register */
+#define JZ_EFUDATA(n)		(0xC + (n) * 4)
+
+/* We read 32 byte chunks to avoid complexity in the driver. */
+#define JZ_EFU_READ_SIZE 32
+
+#define EFUCTRL_ADDR_MASK	0x3FF
+#define EFUCTRL_ADDR_SHIFT	21
+#define EFUCTRL_LEN_MASK	0x1F
+#define EFUCTRL_LEN_SHIFT	16
+#define EFUCTRL_PG_EN		BIT(15)
+#define EFUCTRL_WR_EN		BIT(1)
+#define EFUCTRL_RD_EN		BIT(0)
+
+#define EFUCFG_INT_EN		BIT(31)
+#define EFUCFG_RD_ADJ_MASK	0xF
+#define EFUCFG_RD_ADJ_SHIFT	20
+#define EFUCFG_RD_STR_MASK	0xF
+#define EFUCFG_RD_STR_SHIFT	16
+#define EFUCFG_WR_ADJ_MASK	0xF
+#define EFUCFG_WR_ADJ_SHIFT	12
+#define EFUCFG_WR_STR_MASK	0xFFF
+#define EFUCFG_WR_STR_SHIFT	0
+
+#define EFUSTATE_WR_DONE	BIT(1)
+#define EFUSTATE_RD_DONE	BIT(0)
+
+struct jz4780_efuse {
+	struct device *dev;
+	struct regmap *map;
+	struct clk *clk;
+};
+
+/* main entry point */
+static int jz4780_efuse_read(void *context, unsigned int offset,
+			     void *val, size_t bytes)
+{
+	struct jz4780_efuse *efuse = context;
+
+	while (bytes > 0) {
+		unsigned int start = offset & ~(JZ_EFU_READ_SIZE - 1);
+		unsigned int chunk = min(bytes, (start + JZ_EFU_READ_SIZE)
+					 - offset);
+		char buf[JZ_EFU_READ_SIZE];
+		unsigned int tmp;
+		u32 ctrl;
+		int ret;
+
+		ctrl = (start << EFUCTRL_ADDR_SHIFT)
+			| ((JZ_EFU_READ_SIZE - 1) << EFUCTRL_LEN_SHIFT)
+			| EFUCTRL_RD_EN;
+
+		regmap_update_bits(efuse->map, JZ_EFUCTRL,
+				   (EFUCTRL_ADDR_MASK << EFUCTRL_ADDR_SHIFT) |
+				   (EFUCTRL_LEN_MASK << EFUCTRL_LEN_SHIFT) |
+				   EFUCTRL_PG_EN | EFUCTRL_WR_EN |
+				   EFUCTRL_RD_EN,
+				   ctrl);
+
+		ret = regmap_read_poll_timeout(efuse->map, JZ_EFUSTATE,
+					       tmp, tmp & EFUSTATE_RD_DONE,
+					       1 * MSEC_PER_SEC,
+					       50 * MSEC_PER_SEC);
+		if (ret < 0) {
+			dev_err(efuse->dev, "Time out while reading efuse data");
+			return ret;
+		}
+
+		ret = regmap_bulk_read(efuse->map, JZ_EFUDATA(0),
+				       buf, JZ_EFU_READ_SIZE / sizeof(u32));
+		if (ret < 0)
+			return ret;
+
+		memcpy(val, &buf[offset - start], chunk);
+
+		val += chunk;
+		offset += chunk;
+		bytes -= chunk;
+	}
+
+	return 0;
+}
+
+static struct nvmem_config jz4780_efuse_nvmem_config = {
+	.name = "jz4780-efuse",
+	.size = 1024,
+	.word_size = 1,
+	.stride = 1,
+	.owner = THIS_MODULE,
+	.reg_read = jz4780_efuse_read,
+};
+
+static const struct regmap_config jz4780_efuse_regmap_config = {
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_stride = 4,
+	.max_register = JZ_EFUDATA(7),
+};
+
+static void clk_disable_unprepare_helper(void *clock)
+{
+	clk_disable_unprepare(clock);
+}
+
+static int jz4780_efuse_probe(struct platform_device *pdev)
+{
+	struct nvmem_device *nvmem;
+	struct jz4780_efuse *efuse;
+	struct nvmem_config cfg;
+	unsigned long clk_rate;
+	unsigned long rd_adj;
+	unsigned long rd_strobe;
+	struct device *dev = &pdev->dev;
+	void __iomem *regs;
+	int ret;
+
+	efuse = devm_kzalloc(dev, sizeof(*efuse), GFP_KERNEL);
+	if (!efuse)
+		return -ENOMEM;
+
+	regs = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(regs))
+		return PTR_ERR(regs);
+
+	efuse->map = devm_regmap_init_mmio(dev, regs,
+					   &jz4780_efuse_regmap_config);
+	if (IS_ERR(efuse->map))
+		return PTR_ERR(efuse->map);
+
+	efuse->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(efuse->clk))
+		return PTR_ERR(efuse->clk);
+
+	ret = clk_prepare_enable(efuse->clk);
+	if (ret < 0)
+		return ret;
+
+	ret = devm_add_action_or_reset(&pdev->dev,
+				       clk_disable_unprepare_helper,
+				       efuse->clk);
+	if (ret < 0)
+		return ret;
+
+	clk_rate = clk_get_rate(efuse->clk);
+
+	efuse->dev = dev;
+
+	/*
+	 * rd_adj and rd_strobe are 4 bit values
+	 * conditions:
+	 *   bus clk_period * (rd_adj + 1) > 6.5ns
+	 *   bus clk_period * (rd_adj + 5 + rd_strobe) > 35ns
+	 *   i.e. rd_adj >= 6.5ns / clk_period
+	 *   i.e. rd_strobe >= 35 ns / clk_period - 5 - rd_adj + 1
+	 * constants:
+	 *   1 / 6.5ns == 153846154 Hz
+	 *   1 / 35ns == 28571429 Hz
+	 */
+
+	rd_adj = clk_rate / 153846154;
+	rd_strobe = clk_rate / 28571429 - 5 - rd_adj + 1;
+
+	if (rd_adj > EFUCFG_RD_ADJ_MASK ||
+	    rd_strobe > EFUCFG_RD_STR_MASK) {
+		dev_err(&pdev->dev, "Cannot set clock configuration\n");
+		return -EINVAL;
+	}
+
+	regmap_update_bits(efuse->map, JZ_EFUCFG,
+			   (EFUCFG_RD_ADJ_MASK << EFUCFG_RD_ADJ_SHIFT) |
+			   (EFUCFG_RD_STR_MASK << EFUCFG_RD_STR_SHIFT),
+			   (rd_adj << EFUCFG_RD_ADJ_SHIFT) |
+			   (rd_strobe << EFUCFG_RD_STR_SHIFT));
+
+	cfg = jz4780_efuse_nvmem_config;
+	cfg.dev = &pdev->dev;
+	cfg.priv = efuse;
+
+	nvmem = devm_nvmem_register(dev, &cfg);
+	if (IS_ERR(nvmem))
+		return PTR_ERR(nvmem);
+
+	return 0;
+}
+
+static const struct of_device_id jz4780_efuse_match[] = {
+	{ .compatible = "ingenic,jz4780-efuse" },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, jz4780_efuse_match);
+
+static struct platform_driver jz4780_efuse_driver = {
+	.probe  = jz4780_efuse_probe,
+	.driver = {
+		.name = "jz4780-efuse",
+		.of_match_table = jz4780_efuse_match,
+	},
+};
+module_platform_driver(jz4780_efuse_driver);
+
+MODULE_AUTHOR("PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>");
+MODULE_AUTHOR("H. Nikolaus Schaller <hns@goldelico.com>");
+MODULE_AUTHOR("Paul Cercueil <paul@crapouillou.net>");
+MODULE_DESCRIPTION("Ingenic JZ4780 efuse driver");
+MODULE_LICENSE("GPL v2");
-- 
2.21.0

