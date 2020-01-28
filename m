Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 652CFC2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 15:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2968324683
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 15:39:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="HUDdqXCB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbgA1Pit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 10:38:49 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:53023 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726772AbgA1Pij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 10:38:39 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00SFX6Nw021992;
        Tue, 28 Jan 2020 16:38:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=Ar4ysUo6whK/cok6Jdojo6d6gqeT3A3cGFa6YycKXws=;
 b=HUDdqXCBXSH4J6+9bwwuYs6E9kZAM1p5eGF5qzVMVnFj2Btihh1QQXcLDVcj0SPpMwlA
 ApMmu4k8KGPSluwjJ1paOuIC9+hzyGiFkA9O5wnAO54R8j1o/BX61qyZuJF+pxI3macr
 n4jWj3aBJrwe02jr6YiehZgY49YxLJOmx4nSsHc6K+yHchB96beFP3GLlELIvD2m0Psv
 BXBXlHkKuwJXa9ipKM8ODes1MY/tOQ7PZHn5wrPf12tCUxKmHXFNuiKcUm9OVvewVjoz
 PFEEaoqvVfe+F+ZGriUs7XGuyUwcMWqFUZK7w4P/1QZkllAhf72VPx+MBEviEs/TX6AB EA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2xrcaxxmdk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Jan 2020 16:38:24 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 807AF100034;
        Tue, 28 Jan 2020 16:38:24 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 6CD632BF9D0;
        Tue, 28 Jan 2020 16:38:24 +0100 (CET)
Received: from localhost (10.75.127.45) by SFHDAG3NODE3.st.com (10.75.127.9)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 28 Jan 2020 16:38:23
 +0100
From:   Benjamin Gaignard <benjamin.gaignard@st.com>
To:     <broonie@kernel.org>, <robh@kernel.org>, <arnd@arndb.de>,
        <shawnguo@kernel.org>, <s.hauer@pengutronix.de>,
        <fabio.estevam@nxp.com>, <sudeep.holla@arm.com>, <lkml@metux.net>
CC:     <loic.pallardy@st.com>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-imx@nxp.com>,
        <kernel@pengutronix.de>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <system-dt@lists.openampproject.org>,
        <stefano.stabellini@xilinx.com>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH v2 5/7] bus: firewall: Add driver for STM32 ETZPC controller
Date:   Tue, 28 Jan 2020 16:38:04 +0100
Message-ID: <20200128153806.7780-6-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20200128153806.7780-1-benjamin.gaignard@st.com>
References: <20200128153806.7780-1-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG3NODE3.st.com
 (10.75.127.9)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-28_05:2020-01-28,2020-01-28 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

STM32 Extended TrustZone Protection Controller (ETZPC) got 3 possible
configurations per hardware block:
- secure: hardware blocks are only accessible by software running on trust
  zone (i.e op-tee firmware).
- non-secure: hardware blocks are accessible by non-secure software (i.e.
    linux kernel).
- coprocessor: hardware blocks are only accessible by the coprocessor.

Each hardware block status is defined by a 2 bits field and all of
them are packed into 32 bits registers. ETZPC can manage up to 94
hardware blocks.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
version 2:
- provide the full list the hardware blocks
 drivers/bus/firewall/Kconfig                   |   7 ++
 drivers/bus/firewall/Makefile                  |   1 +
 drivers/bus/firewall/stm32-etzpc.c             | 140 +++++++++++++++++++++++++
 include/dt-bindings/bus/firewall/stm32-etzpc.h |  90 ++++++++++++++++
 4 files changed, 238 insertions(+)
 create mode 100644 drivers/bus/firewall/stm32-etzpc.c
 create mode 100644 include/dt-bindings/bus/firewall/stm32-etzpc.h

diff --git a/drivers/bus/firewall/Kconfig b/drivers/bus/firewall/Kconfig
index 893bacb955f5..f724c09801e0 100644
--- a/drivers/bus/firewall/Kconfig
+++ b/drivers/bus/firewall/Kconfig
@@ -4,4 +4,11 @@ config FIREWALL_CONTROLLERS
 	bool "Support of bus firewall controllers"
 	depends on OF
 
+config STM32_ETZPC
+	bool "STM32 ETZPC Domain Controller"
+	depends on FIREWALL_CONTROLLERS && MACH_STM32MP157
+	help
+	  Select y to enable STM32 Extended TrustZone Protection
+	  Controller (ETZPC)
+
 endmenu
diff --git a/drivers/bus/firewall/Makefile b/drivers/bus/firewall/Makefile
index eb6b978d6450..d42e99b5865e 100644
--- a/drivers/bus/firewall/Makefile
+++ b/drivers/bus/firewall/Makefile
@@ -1 +1,2 @@
 obj-$(CONFIG_FIREWALL_CONTROLLERS) += firewall.o
+obj-$(CONFIG_STM32_ETZPC) += stm32-etzpc.o
diff --git a/drivers/bus/firewall/stm32-etzpc.c b/drivers/bus/firewall/stm32-etzpc.c
new file mode 100644
index 000000000000..39999579fe92
--- /dev/null
+++ b/drivers/bus/firewall/stm32-etzpc.c
@@ -0,0 +1,140 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) STMicroelectronics 2020 - All Rights Reserved
+ * Author: Benjamin Gaignard <benjamin.gaignard@st.com> for STMicroelectronics.
+ */
+
+#include <linux/device.h>
+#include <linux/firewall.h>
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+#include <dt-bindings/bus/firewall/stm32-etzpc.h>
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
+		dev_info(dev, "failed to set configuration: index %d, value %d\n",
+			 index, value);
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
+	.fast_io = true,
+};
+
+static int stm32_etzpc_probe(struct platform_device *pdev)
+{
+	struct stm32_etzpc *etzpc;
+	struct resource *res;
+	void __iomem *mmio;
+	struct regmap *regmap;
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
+	return firewall_register(&pdev->dev, &stm32_etzpc_ops);
+}
+
+static int stm32_etzpc_remove(struct platform_device *pdev)
+{
+	firewall_unregister(&pdev->dev);
+
+	return 0;
+}
+
+static const struct of_device_id stm32_etzpc_of_match[] = {
+	{ .compatible = "st,stm32-etzpc" },
+	{ /* end node */ }
+};
+MODULE_DEVICE_TABLE(of, stm32_etzpc_of_match);
+
+static struct platform_driver stm32_etzpc_driver = {
+	.probe  = stm32_etzpc_probe,
+	.remove = stm32_etzpc_remove,
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
diff --git a/include/dt-bindings/bus/firewall/stm32-etzpc.h b/include/dt-bindings/bus/firewall/stm32-etzpc.h
new file mode 100644
index 000000000000..9c4783b9783c
--- /dev/null
+++ b/include/dt-bindings/bus/firewall/stm32-etzpc.h
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

