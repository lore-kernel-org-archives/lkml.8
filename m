Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74DE0C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 02:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DF5B207DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 02:52:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732146AbgFWCwF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 22:52:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:33024 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731933AbgFWCvj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 22:51:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 216E2B19B;
        Tue, 23 Jun 2020 02:51:38 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-realtek-soc@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?James=20Tai=20=5B=E6=88=B4=E5=BF=97=E5=B3=B0=5D?= 
        <james.tai@realtek.com>,
        =?UTF-8?q?Stanley=20Chang=20=5B=E6=98=8C=E8=82=B2=E5=BE=B7=5D?= 
        <stanley_chang@realtek.com>, Edgar Lee <cylee12@realtek.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 18/29] nvmem: Add Realtek DHC eFuse driver
Date:   Tue, 23 Jun 2020 04:50:55 +0200
Message-Id: <20200623025106.31273-19-afaerber@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200623025106.31273-1-afaerber@suse.de>
References: <20200623025106.31273-1-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement enough of a read-only nvmem driver to easily read efuse cells.

Cc: Cheng-Yu Lee <cylee12@realtek.com>
Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 v2: New
 
 MAINTAINERS                   |  1 +
 drivers/nvmem/Kconfig         |  9 ++++
 drivers/nvmem/Makefile        |  2 +
 drivers/nvmem/rtk-dhc-efuse.c | 86 +++++++++++++++++++++++++++++++++++
 4 files changed, 98 insertions(+)
 create mode 100644 drivers/nvmem/rtk-dhc-efuse.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 1d0d6ab20451..02117fbf0e57 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2312,6 +2312,7 @@ F:	Documentation/devicetree/bindings/soc/realtek/
 F:	arch/arm/boot/dts/rtd*
 F:	arch/arm/mach-realtek/
 F:	arch/arm64/boot/dts/realtek/
+F:	drivers/nvmem/rtk-dhc-efuse.c
 F:	drivers/soc/realtek/
 
 ARM/RENESAS ARM64 ARCHITECTURE
diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index d7b7f6d688e7..75cf43b16cf9 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -129,6 +129,15 @@ config NVMEM_SPMI_SDAM
 	  Qualcomm Technologies, Inc. PMICs. It provides the clients
 	  an interface to read/write to the SDAM module's shared memory.
 
+config REALTEK_DHC_EFUSE
+	tristate "Realtek DHC eFuse Support"
+	depends on ARCH_REALTEK || COMPILE_TEST
+	depends on HAS_IOMEM
+	help
+	  Say y here to enable read-only access to the Realtek Digital Home
+	  This driver can also be built as a module. If so, the module
+	  will be called nvmem-rtk-dhc-efuse.
+
 config ROCKCHIP_EFUSE
 	tristate "Rockchip eFuse Support"
 	depends on ARCH_ROCKCHIP || COMPILE_TEST
diff --git a/drivers/nvmem/Makefile b/drivers/nvmem/Makefile
index a7c377218341..67cefdfa44e6 100644
--- a/drivers/nvmem/Makefile
+++ b/drivers/nvmem/Makefile
@@ -33,6 +33,8 @@ obj-$(CONFIG_ROCKCHIP_EFUSE)	+= nvmem_rockchip_efuse.o
 nvmem_rockchip_efuse-y		:= rockchip-efuse.o
 obj-$(CONFIG_ROCKCHIP_OTP)	+= nvmem-rockchip-otp.o
 nvmem-rockchip-otp-y		:= rockchip-otp.o
+obj-$(CONFIG_REALTEK_DHC_EFUSE)	+= nvmem-rtk-dhc-efuse.o
+nvmem-rtk-dhc-efuse-y		:= rtk-dhc-efuse.o
 obj-$(CONFIG_NVMEM_SUNXI_SID)	+= nvmem_sunxi_sid.o
 nvmem_stm32_romem-y 		:= stm32-romem.o
 obj-$(CONFIG_NVMEM_STM32_ROMEM) += nvmem_stm32_romem.o
diff --git a/drivers/nvmem/rtk-dhc-efuse.c b/drivers/nvmem/rtk-dhc-efuse.c
new file mode 100644
index 000000000000..4672db2c2619
--- /dev/null
+++ b/drivers/nvmem/rtk-dhc-efuse.c
@@ -0,0 +1,86 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Realtek Digital Home Center eFuse
+ *
+ * Copyright (c) 2020 Andreas Färber
+ */
+
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/nvmem-provider.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+struct dhc_efuse {
+	struct device *dev;
+	void __iomem *base;
+	struct nvmem_device *nvmem;
+};
+
+static int dhc_efuse_reg_read(void *priv, unsigned int offset, void *val,
+	size_t bytes)
+{
+	struct dhc_efuse *efuse = priv;
+	u8 *buf = val;
+
+	while (bytes--)
+		*buf++ = readb_relaxed(efuse->base + offset++);
+
+	return 0;
+}
+
+static int dhc_efuse_probe(struct platform_device *pdev)
+{
+	struct dhc_efuse *efuse;
+	struct nvmem_config config = {};
+	struct resource *res;
+
+	efuse = devm_kzalloc(&pdev->dev, sizeof(*efuse), GFP_KERNEL);
+	if (!efuse)
+		return -ENOMEM;
+
+	efuse->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
+	if (IS_ERR(efuse->base))
+		return PTR_ERR(efuse->base);
+
+	efuse->dev = &pdev->dev;
+
+	config.dev = &pdev->dev;
+	config.name = "dhc-efuse";
+	config.owner = THIS_MODULE;
+	config.type = NVMEM_TYPE_OTP;
+	config.read_only = true,
+	config.word_size = 4;
+	config.stride = 1;
+	config.size = resource_size(res);
+	config.reg_read = dhc_efuse_reg_read;
+	config.priv = efuse;
+
+	efuse->nvmem = devm_nvmem_register(&pdev->dev, &config);
+	if (IS_ERR(efuse->nvmem)) {
+		dev_err(&pdev->dev, "failed to register nvmem (%ld)\n",
+			PTR_ERR(efuse->nvmem));
+		return PTR_ERR(efuse->nvmem);
+	}
+
+	return 0;
+}
+
+static const struct of_device_id dhc_efuse_dt_ids[] = {
+	 { .compatible = "realtek,rtd1195-efuse" },
+	 { }
+};
+
+static struct platform_driver dhc_efuse_driver = {
+	.probe = dhc_efuse_probe,
+	.driver = {
+		.name = "rtk-dhc-efuse",
+		.of_match_table	= dhc_efuse_dt_ids,
+	},
+};
+module_platform_driver(dhc_efuse_driver);
+
+MODULE_DESCRIPTION("Realtek DHC eFuse driver");
+MODULE_LICENSE("GPL");
-- 
2.26.2

