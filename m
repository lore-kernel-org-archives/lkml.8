Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C39F3C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 13:26:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C765206BE
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 13:26:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="jEGP7tdM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731045AbgGAN0E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 09:26:04 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:25542 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730930AbgGANZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 09:25:47 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 061DP7lv015052;
        Wed, 1 Jul 2020 15:25:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=Noyc1sz1H7BSum1HD5Fbfe/NwPdfyZxzQktyj1gbcR4=;
 b=jEGP7tdMUBz+N9DIWyUWJvXYMOydVixvFQe7YQkf9qhtuT6D7Y+lJ4oWJwYe05y/Lj/a
 pGKGLunNMGyskdw+v/gq92Hv6oE7v3j3LyIlFlTSG9OJ6K8ra8pDdRO0TDK6ZDBx92x5
 6Nf7GB/WmLTh7z3S77Bpx1mW8U0/s6BIGr/mm99F3NXWCSWZFXQGat2oU33PDNmuBcJd
 tLLtJPyrkjQ8fELG7ki0bjMTE5x2ajVxR8QwNH2tiJTChblTTRGbEKtERB7/IlNlD9Wh
 FUj8oQy+/YcpNcEKCSFxHU46TEcy/REweZPsoXZbIMoZbC/yIXlA3AgYlC68/WQfu3PG kA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 31wu89tnd6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Jul 2020 15:25:33 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id DA2C410002A;
        Wed,  1 Jul 2020 15:25:32 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id CD2B82B6DD8;
        Wed,  1 Jul 2020 15:25:32 +0200 (CEST)
Received: from localhost (10.75.127.48) by SFHDAG3NODE3.st.com (10.75.127.9)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 1 Jul 2020 15:25:31
 +0200
From:   Benjamin Gaignard <benjamin.gaignard@st.com>
To:     <robh+dt@kernel.org>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <linus.walleij@linaro.org>,
        <gregkh@linuxfoundation.org>
CC:     <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <stefano.stabellini@xilinx.com>,
        <tomase@xilinx.com>, <devicetree@vger.kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH v4 4/5] bus: stm32: Add stm32 ETZPC firewall bus controller
Date:   Wed, 1 Jul 2020 15:25:22 +0200
Message-ID: <20200701132523.32533-5-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20200701132523.32533-1-benjamin.gaignard@st.com>
References: <20200701132523.32533-1-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG5NODE2.st.com (10.75.127.14) To SFHDAG3NODE3.st.com
 (10.75.127.9)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-01_08:2020-07-01,2020-07-01 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add STM32 Extended TrustZone Protection bus controller.
For each of device-tree nodes it will check and apply
firewall configuration. If it doesn't match the device
will not be probed by platform bus.

A device could be configured to be accessible by trusted world,
co-processor or non-secure world.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 drivers/bus/stm32/Kconfig                   |   8 ++
 drivers/bus/stm32/Makefile                  |   1 +
 drivers/bus/stm32/stm32-etzpc.c             | 163 ++++++++++++++++++++++++++++
 include/dt-bindings/bus/stm32/stm32-etzpc.h |  90 +++++++++++++++
 4 files changed, 262 insertions(+)
 create mode 100644 drivers/bus/stm32/stm32-etzpc.c
 create mode 100644 include/dt-bindings/bus/stm32/stm32-etzpc.h

diff --git a/drivers/bus/stm32/Kconfig b/drivers/bus/stm32/Kconfig
index 57221e833e2d..5dc6e2504de5 100644
--- a/drivers/bus/stm32/Kconfig
+++ b/drivers/bus/stm32/Kconfig
@@ -1,3 +1,11 @@
 config FIREWALL_CONTROLLERS
 	bool "Support of bus firewall controllers"
 	depends on OF
+
+config STM32_ETZPC
+	bool "STM32 ETZPC bus controller"
+	depends on MACH_STM32MP157
+	select FIREWALL_CONTROLLERS
+	help
+	  Select y to enable STM32 Extended TrustZone Protection
+	  Controller (ETZPC)
diff --git a/drivers/bus/stm32/Makefile b/drivers/bus/stm32/Makefile
index eb6b978d6450..d42e99b5865e 100644
--- a/drivers/bus/stm32/Makefile
+++ b/drivers/bus/stm32/Makefile
@@ -1 +1,2 @@
 obj-$(CONFIG_FIREWALL_CONTROLLERS) += firewall.o
+obj-$(CONFIG_STM32_ETZPC) += stm32-etzpc.o
diff --git a/drivers/bus/stm32/stm32-etzpc.c b/drivers/bus/stm32/stm32-etzpc.c
new file mode 100644
index 000000000000..ad0e16eea66b
--- /dev/null
+++ b/drivers/bus/stm32/stm32-etzpc.c
@@ -0,0 +1,163 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) STMicroelectronics 2020 - All Rights Reserved
+ * Author: Benjamin Gaignard <benjamin.gaignard@st.com> for STMicroelectronics.
+ */
+
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+#include <dt-bindings/bus/stm32/stm32-etzpc.h>
+
+#include "firewall.h"
+
+#define ETZPC_DECPROT	0x010
+#define ETZPC_NUM_LOCKS	94
+
+struct stm32_etzpc {
+	struct regmap_field *fields[ETZPC_NUM_LOCKS];
+};
+
+static int stm32_etzpc_set_config(struct device *dev,
+				  struct of_phandle_args *out_args)
+{
+	struct stm32_etzpc *etzpc = dev_get_drvdata(dev);
+	int index = out_args->args[0];
+	unsigned int value = out_args->args[1];
+	u32 status;
+
+	if (out_args->args_count != 2)
+		return -EINVAL;
+
+	if (index >= ETZPC_NUM_LOCKS)
+		return -EINVAL;
+
+	if (value > STM32_ETZPC_NON_SECURE)
+		return -EINVAL;
+
+	regmap_field_force_write(etzpc->fields[index], value);
+
+	/* Hardware could denied the new value, read it back to check it */
+	regmap_field_read(etzpc->fields[index], &status);
+
+	if (value != status) {
+		pr_info("failed to set configuration: index %d, value %d\n",
+			index, value);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static struct firewall_ops stm32_etzpc_ops = {
+	.set_config = stm32_etzpc_set_config,
+};
+
+static const struct regmap_config stm32_etzpc_regmap_cfg = {
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_stride = sizeof(u32),
+	.max_register = 0x3FF,
+};
+
+static void stm32_etzpc_populate(struct device *parent)
+{
+	struct device_node *child;
+
+	if (!parent)
+		return;
+
+	for_each_available_child_of_node(dev_of_node(parent), child) {
+		if (firewall_set_default_config(child)) {
+			/*
+			 * Failed to set firewall configuration mark the node
+			 * as populated so platform bus won't probe it
+			 */
+			of_node_set_flag(child, OF_POPULATED);
+			dev_info(parent, "%s: Bad firewall configuration\n",
+				 child->name);
+		}
+	}
+}
+
+static int stm32_etzpc_probe(struct platform_device *pdev)
+{
+	struct stm32_etzpc *etzpc;
+	struct device *firewall;
+	struct regmap *regmap;
+	struct resource *res;
+	void __iomem *mmio;
+	int i;
+
+	etzpc = devm_kzalloc(&pdev->dev, sizeof(*etzpc), GFP_KERNEL);
+	if (!etzpc)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	mmio = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(mmio))
+		return PTR_ERR(mmio);
+
+	regmap = devm_regmap_init_mmio(&pdev->dev, mmio,
+				       &stm32_etzpc_regmap_cfg);
+
+	for (i = 0; i < ETZPC_NUM_LOCKS; i++) {
+		struct reg_field field;
+
+		/*
+		 * Each hardware block status is defined by
+		 * a 2 bits field and all of them are packed into
+		 * 32 bits registers. Do some computation to get
+		 * register offset and the shift.
+		 */
+		field.reg = ETZPC_DECPROT + (i >> 4) * sizeof(u32);
+		field.lsb = (i % 0x10) << 1;
+		field.msb = field.lsb + 1;
+
+		etzpc->fields[i] = devm_regmap_field_alloc(&pdev->dev,
+							   regmap, field);
+	}
+
+	platform_set_drvdata(pdev, etzpc);
+
+	firewall = firewall_register(dev_of_node(&pdev->dev),
+				     &stm32_etzpc_ops);
+	if (!firewall)
+		return -EINVAL;
+
+	dev_set_drvdata(firewall, etzpc);
+
+	stm32_etzpc_populate(&pdev->dev);
+
+	return 0;
+}
+
+static const struct of_device_id stm32_etzpc_of_match[] = {
+	{ .compatible = "st,stm32-etzpc-bus" },
+	{ /* end node */ }
+};
+MODULE_DEVICE_TABLE(of, stm32_etzpc_of_match);
+
+static struct platform_driver stm32_etzpc_driver = {
+	.probe  = stm32_etzpc_probe,
+	.driver = {
+		.name = "stm32-etzpc",
+		.of_match_table = stm32_etzpc_of_match,
+	},
+};
+
+static int __init stm32_etzpc_init(void)
+{
+	return platform_driver_register(&stm32_etzpc_driver);
+}
+arch_initcall(stm32_etzpc_init);
+
+MODULE_AUTHOR("Benjamin Gaignard <benjamin.gaignard@st.com>");
+MODULE_DESCRIPTION("STMicroelectronics STM32 Bus Firewall Controller");
diff --git a/include/dt-bindings/bus/stm32/stm32-etzpc.h b/include/dt-bindings/bus/stm32/stm32-etzpc.h
new file mode 100644
index 000000000000..9c4783b9783c
--- /dev/null
+++ b/include/dt-bindings/bus/stm32/stm32-etzpc.h
@@ -0,0 +1,90 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) STMicroelectronics 2020 - All Rights Reserved
+ * Author: Benjamin Gaignard <benjamin.gaignard@st.com> for STMicroelectronics.
+ */
+
+#ifndef _STM32_ETZPC_H_
+#define _STM32_ETZPC_H_
+
+/* ETZPC configurations: trust-zone, non-secure or coprocessor*/
+#define STM32_ETZPC_TRUST	1
+#define STM32_ETPCZ_COPRO	2
+#define STM32_ETZPC_NON_SECURE	3
+
+/* ETZPC hard blocks index */
+#define STM32_ETZPC_USART1	3
+#define STM32_ETZPC_SPI6	4
+#define STM32_ETZPC_I2C4	5
+#define STM32_ETZPC_RNG1	7
+#define STM32_ETZPC_HASH1	8
+#define STM32_ETZPC_CRYP1	9
+#define STM32_ETZPC_I2C6	12
+#define STM32_ETZPC_TIM2	16
+#define STM32_ETZPC_TIM3	17
+#define STM32_ETZPC_TIM4	18
+#define STM32_ETZPC_TIM5	19
+#define STM32_ETZPC_TIM6	20
+#define STM32_ETZPC_TIM7	21
+#define STM32_ETZPC_TIM12	22
+#define STM32_ETZPC_TIM13	23
+#define STM32_ETZPC_TIM14	24
+#define STM32_ETZPC_LPTIM1	25
+#define STM32_ETZPC_SPI2	27
+#define STM32_ETZPC_SPI3	28
+#define STM32_ETZPC_USART2	30
+#define STM32_ETZPC_USART3	31
+#define STM32_ETZPC_USART4	32
+#define STM32_ETZPC_USART5	33
+#define STM32_ETZPC_I2C1	34
+#define STM32_ETZPC_I2C2	35
+#define STM32_ETZPC_I2C3	36
+#define STM32_ETZPC_I2C5	37
+#define STM32_ETZPC_CEC		38
+#define STM32_ETZPC_DAC		39
+#define STM32_ETZPC_UART7	40
+#define STM32_ETZPC_UART8	41
+#define STM32_ETZPC_MDIOS	44
+#define STM32_ETZPC_TIM1	48
+#define STM32_ETZPC_TIM8	49
+#define STM32_ETZPC_USART6	51
+#define STM32_ETZPC_SPI1	52
+#define STM32_ETZPC_SPI4	53
+#define STM32_ETZPC_TIM15	54
+#define STM32_ETZPC_TIM16	55
+#define STM32_ETZPC_TIM17	56
+#define STM32_ETZPC_SPI5	57
+#define STM32_ETZPC_SAI1	58
+#define STM32_ETZPC_SAI2	59
+#define STM32_ETZPC_SAI3	60
+#define STM32_ETZPC_DFSDM	61
+#define STM32_ETZPC_TT_FDCAN	62
+#define STM32_ETZPC_LPTIM2	64
+#define STM32_ETZPC_LPTIM3	65
+#define STM32_ETZPC_LPTIM4	66
+#define STM32_ETZPC_LPTIM5	67
+#define STM32_ETZPC_SAI4	68
+#define STM32_ETZPC_VREFBUF	69
+#define STM32_ETZPC_DCMI	70
+#define STM32_ETZPC_CRC2	71
+#define STM32_ETZPC_ADC		72
+#define STM32_ETZPC_HASH2	73
+#define STM32_ETZPC_RNG2	74
+#define STM32_ETZPC_CRYP2	75
+#define STM32_ETZPC_SRAM1	80
+#define STM32_ETZPC_SRAM2	81
+#define STM32_ETZPC_SRAM3	82
+#define STM32_ETZPC_SRAM4	83
+#define STM32_ETZPC_RETRAM	84
+#define STM32_ETZPC_OTG		85
+#define STM32_ETZPC_SDMMC3	86
+#define STM32_ETZPC_DLYBSD3	87
+#define STM32_ETZPC_DMA1	88
+#define STM32_ETZPC_DMA2	89
+#define STM32_ETZPC_DMAMUX	90
+#define STM32_ETZPC_FMC		91
+#define STM32_ETZPC_QSPI	92
+#define STM32_ETZPC_DLYBQ	93
+#define STM32_ETZPC_ETH1	94
+
+#endif /* _STM32_ETZPC_H_ */
-- 
2.15.0

