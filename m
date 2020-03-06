Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8098C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 13:07:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 797DF2072A
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 13:07:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbgCFNHm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 08:07:42 -0500
Received: from mail.baikalelectronics.com ([87.245.175.226]:36390 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726974AbgCFNHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 08:07:39 -0500
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 0EE9D8030700;
        Fri,  6 Mar 2020 13:07:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id WuyWbmOsoFDx; Fri,  6 Mar 2020 16:07:34 +0300 (MSK)
From:   <Sergey.Semin@baikalelectronics.ru>
List-Id: <soc.lore.kernel.org>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        <soc@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/6] soc: bt1: Add Baikal-T1 AXI-bus EHB driver
Date:   Fri, 6 Mar 2020 16:07:19 +0300
In-Reply-To: <20200306130721.10347-1-Sergey.Semin@baikalelectronics.ru>
References: <20200306130721.10347-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Message-Id: <20200306130735.0EE9D8030700@mail.baikalelectronics.ru>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Serge Semin <Sergey.Semin@baikalelectronics.ru>

AXI3-bus is the main communication bus connecting all high-speed peripheral
IP-cores with RAM controller and MIPS P5600 cores. Baikal-T1 SoC provides a
way to detect the bus protocol errors and report a short info about it by
means of the AXI-bus Errors Handler Block (AXI EHB). The block rises an
interrupt indicating an AXI protocol error at an attempt either to reach
a non-existent slave device or to perform an invalid operation with a
slave IP-block. This driver provides the interrupt handler, which prints
an error message with a faulty address and updates an errors counter,
and exposes a sysfs-node to inject the described types of errors.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Signed-off-by: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Paul Burton <paulburton@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Olof Johansson <olof@lixom.net>
Cc: soc@kernel.org
---
 drivers/soc/Kconfig             |   1 +
 drivers/soc/Makefile            |   1 +
 drivers/soc/baikal-t1/Kconfig   |  22 +++
 drivers/soc/baikal-t1/Makefile  |   2 +
 drivers/soc/baikal-t1/axi-ehb.c | 250 ++++++++++++++++++++++++++++++++
 drivers/soc/baikal-t1/common.h  |  37 +++++
 6 files changed, 313 insertions(+)
 create mode 100644 drivers/soc/baikal-t1/Kconfig
 create mode 100644 drivers/soc/baikal-t1/Makefile
 create mode 100644 drivers/soc/baikal-t1/axi-ehb.c
 create mode 100644 drivers/soc/baikal-t1/common.h

diff --git a/drivers/soc/Kconfig b/drivers/soc/Kconfig
index 1778f8c62861..af2c2ca5d643 100644
--- a/drivers/soc/Kconfig
+++ b/drivers/soc/Kconfig
@@ -5,6 +5,7 @@ source "drivers/soc/actions/Kconfig"
 source "drivers/soc/amlogic/Kconfig"
 source "drivers/soc/aspeed/Kconfig"
 source "drivers/soc/atmel/Kconfig"
+source "drivers/soc/baikal-t1/Kconfig"
 source "drivers/soc/bcm/Kconfig"
 source "drivers/soc/fsl/Kconfig"
 source "drivers/soc/imx/Kconfig"
diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
index 8b49d782a1ab..0cf4d91f3d09 100644
--- a/drivers/soc/Makefile
+++ b/drivers/soc/Makefile
@@ -6,6 +6,7 @@
 obj-$(CONFIG_ARCH_ACTIONS)	+= actions/
 obj-$(CONFIG_SOC_ASPEED)	+= aspeed/
 obj-$(CONFIG_ARCH_AT91)		+= atmel/
+obj-$(CONFIG_SOC_BAIKAL_T1)	+= baikal-t1/
 obj-y				+= bcm/
 obj-$(CONFIG_ARCH_DOVE)		+= dove/
 obj-$(CONFIG_MACH_DOVE)		+= dove/
diff --git a/drivers/soc/baikal-t1/Kconfig b/drivers/soc/baikal-t1/Kconfig
new file mode 100644
index 000000000000..aca155350612
--- /dev/null
+++ b/drivers/soc/baikal-t1/Kconfig
@@ -0,0 +1,22 @@
+# SPDX-License-Identifier: GPL-2.0
+menu "Baikal-T1 SoC drivers"
+
+config SOC_BAIKAL_T1
+	def_bool y
+	depends on MIPS_BAIKAL_T1 || COMPILE_TEST
+
+config BT1_AXI_EHB
+	bool "Baikal-T1 AXI-bus Errors Handler Block"
+	depends on SOC_BAIKAL_T1 && OF
+	help
+	  Baikal-T1 CCU registers space as being MFD provides an access to the
+	  AXI-bus Errors Handler Block (AXI EHB). It rises an interrupt
+	  indicating an AXI protocol error at an attempt either to reach a
+	  non-existent slave device or to perform an invalid operation with a
+	  slave IP-block. This driver provides the interrupt handler, which
+	  prints an error message with a faulty address and updates an errors
+	  counter.
+
+	  If unsure, say N.
+
+endmenu
diff --git a/drivers/soc/baikal-t1/Makefile b/drivers/soc/baikal-t1/Makefile
new file mode 100644
index 000000000000..c069791058b9
--- /dev/null
+++ b/drivers/soc/baikal-t1/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_BT1_AXI_EHB) += axi-ehb.o
diff --git a/drivers/soc/baikal-t1/axi-ehb.c b/drivers/soc/baikal-t1/axi-ehb.c
new file mode 100644
index 000000000000..36929958cb4f
--- /dev/null
+++ b/drivers/soc/baikal-t1/axi-ehb.c
@@ -0,0 +1,250 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2014 - 2020 BAIKAL ELECTRONICS, JSC
+ *
+ * Authors:
+ *   Serge Semin <Sergey.Semin@baikalelectronics.ru>
+ *
+ * Baikal-T1 AXI-bus Errors Handler Block driver.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/device.h>
+#include <linux/atomic.h>
+#include <linux/platform_device.h>
+#include <linux/interrupt.h>
+#include <linux/nmi.h>
+#include <linux/sysfs.h>
+
+
+#include "common.h"
+
+#define AXI_EHB_WERRL			0x00
+#define AXI_EHB_WERRH			0x04
+#define AXI_EHB_WERRH_TYPE		BIT(23)
+#define AXI_EHB_WERRH_ADDR_FLD		24
+#define AXI_EHB_WERRH_ADDR_MASK		GENMASK(31, AXI_EHB_WERRH_ADDR_FLD)
+
+/*
+ * struct axi_ehb - Baikal-T1 AXI EHB private data.
+ * @dev: Pointer to the device structure.
+ * @regs: Memory mapped block registers.
+ * @irq: Errors IRQ number.
+ * @count: Number of errors detected.
+ */
+struct axi_ehb {
+	struct device *dev;
+
+	void __iomem *regs;
+	int irq;
+
+	atomic_t count;
+};
+
+static irqreturn_t axi_ehb_isr(int irq, void *data)
+{
+	struct axi_ehb *ehb = data;
+	u64 addr, val;
+
+	addr = bt1_read(ehb->regs + AXI_EHB_WERRL);
+	val = bt1_read(ehb->regs + AXI_EHB_WERRH);
+
+	addr |= (u64)(BT1_GET_FLD(AXI_EHB_WERRH_ADDR, val)) << 32;
+
+	dev_crit_ratelimited(ehb->dev,
+		"AXI-bus fault %d: %s at %08llx\n",
+		atomic_inc_return(&ehb->count),
+		val & AXI_EHB_WERRH_TYPE ? "no slave" : "slave protocol error",
+		addr);
+
+	/*
+	 * Print backtrace on each CPU. This might be pointless if the fault
+	 * has happened on the same CPU as the IRQ handler is executed or
+	 * the other core proceeded further execution despite the error.
+	 * But if it's not, by looking at the trace we would get straight to
+	 * the cause of the problem.
+	 */
+	trigger_all_cpu_backtrace();
+
+	return IRQ_HANDLED;
+}
+
+static void axi_ehb_clear_data(void *data)
+{
+	struct axi_ehb *ehb = data;
+	struct platform_device *pdev = to_platform_device(ehb->dev);
+
+	platform_set_drvdata(pdev, NULL);
+}
+
+static struct axi_ehb *axi_ehb_create_data(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct axi_ehb *ehb;
+	int ret;
+
+	ehb = devm_kzalloc(dev, sizeof(*ehb), GFP_KERNEL);
+	if (!ehb)
+		return ERR_PTR(-ENOMEM);
+
+	ret = devm_add_action(dev, axi_ehb_clear_data, ehb);
+	if (ret) {
+		dev_err(dev, "Can't add AXI EHB data clear action\n");
+		return ERR_PTR(ret);
+	}
+
+	ehb->dev = dev;
+	atomic_set(&ehb->count, 0);
+	platform_set_drvdata(pdev, ehb);
+
+	return ehb;
+}
+
+static int axi_ehb_request_regs(struct axi_ehb *ehb)
+{
+	struct platform_device *pdev = to_platform_device(ehb->dev);
+
+	ehb->regs = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(ehb->regs)) {
+		dev_err(ehb->dev, "Couldn't map AXI EHB registers\n");
+		return PTR_ERR(ehb->regs);
+	}
+
+	return 0;
+}
+
+static int axi_ehb_request_irq(struct axi_ehb *ehb)
+{
+	struct platform_device *pdev = to_platform_device(ehb->dev);
+	int ret;
+
+	ehb->irq = platform_get_irq(pdev, 0);
+	if (ehb->irq < 0) {
+		dev_err(ehb->dev, "Couldn't find AXI EHB IRQ number\n");
+		return ehb->irq;
+	}
+
+	ret = devm_request_irq(ehb->dev, ehb->irq, axi_ehb_isr, IRQF_SHARED,
+			       "axi_ehb", ehb);
+	if (ret) {
+		dev_err(ehb->dev, "Couldn't request AXI EHB IRQ\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static ssize_t count_show(struct device *dev,
+			  struct device_attribute *attr, char *buf)
+{
+	struct axi_ehb *ehb = dev_get_drvdata(dev);
+
+	return scnprintf(buf, PAGE_SIZE, "%d\n", atomic_read(&ehb->count));
+}
+static DEVICE_ATTR_RO(count);
+
+static int inject_error_show(struct device *dev, struct device_attribute *attr,
+			     char *buf)
+{
+	return scnprintf(buf, PAGE_SIZE, "Error injection: bus unaligned\n");
+}
+
+static int inject_error_store(struct device *dev,
+			      struct device_attribute *attr,
+			      const char *data, size_t count)
+{
+	struct axi_ehb *ehb = dev_get_drvdata(dev);
+
+	/*
+	 * Performing unaligned read from the memory will cause the CM bus
+	 * error while unaligned writing - the AXI bus write error handled
+	 * by this driver.
+	 */
+	if (!strncmp(data, "bus", 3))
+		readb(ehb->regs + AXI_EHB_WERRL);
+	else if (!strncmp(data, "unaligned", 9))
+		writeb(0, ehb->regs + AXI_EHB_WERRL);
+	else
+		return -EINVAL;
+
+	return count;
+}
+static DEVICE_ATTR_RW(inject_error);
+
+static struct attribute *axi_ehb_sysfs_attrs[] = {
+	&dev_attr_count.attr,
+	&dev_attr_inject_error.attr,
+	NULL
+};
+ATTRIBUTE_GROUPS(axi_ehb_sysfs);
+
+static void axi_ehb_remove_sysfs(void *data)
+{
+	struct axi_ehb *ehb = data;
+
+	device_remove_groups(ehb->dev, axi_ehb_sysfs_groups);
+}
+
+static int axi_ehb_init_sysfs(struct axi_ehb *ehb)
+{
+	int ret;
+
+	ret = device_add_groups(ehb->dev, axi_ehb_sysfs_groups);
+	if (ret) {
+		dev_err(ehb->dev, "Failed to add sysfs files group\n");
+		return ret;
+	}
+
+	ret = devm_add_action_or_reset(ehb->dev, axi_ehb_remove_sysfs, ehb);
+	if (ret)
+		dev_err(ehb->dev, "Can't add AXI EHB sysfs remove action\n");
+
+	return ret;
+}
+
+static int axi_ehb_probe(struct platform_device *pdev)
+{
+	struct axi_ehb *ehb;
+	int ret;
+
+	ehb = axi_ehb_create_data(pdev);
+	if (IS_ERR(ehb))
+		return PTR_ERR(ehb);
+
+	ret = axi_ehb_request_regs(ehb);
+	if (ret)
+		return ret;
+
+	ret = axi_ehb_request_irq(ehb);
+	if (ret)
+		return ret;
+
+	ret = axi_ehb_init_sysfs(ehb);
+	if (ret)
+		return ret;
+
+	dev_info(ehb->dev, "AXI-bus errors handler installed\n");
+
+	return 0;
+}
+
+static const struct of_device_id axi_ehb_of_match[] = {
+	{ .compatible = "be,bt1-axi-ehb" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, axi_ehb_of_match);
+
+static struct platform_driver axi_ehb_driver = {
+	.probe = axi_ehb_probe,
+	.driver = {
+		.name = "bt1-axi-ehb",
+		.of_match_table = of_match_ptr(axi_ehb_of_match)
+	}
+};
+module_platform_driver(axi_ehb_driver);
+
+MODULE_AUTHOR("Serge Semin <Sergey.Semin@baikalelectronics.ru>");
+MODULE_DESCRIPTION("Baikal-T1 AXI EHB driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/soc/baikal-t1/common.h b/drivers/soc/baikal-t1/common.h
new file mode 100644
index 000000000000..d1d7c4e11bd4
--- /dev/null
+++ b/drivers/soc/baikal-t1/common.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2019 - 2020 BAIKAL ELECTRONICS, JSC
+ *
+ * Baikal-T1 SoC common methods.
+ */
+#ifndef __SOC_BT1_COMMON_H__
+#define __SOC_BT1_COMMON_H__
+
+#include <linux/io.h>
+
+#define BT1_GET_FLD(_name, _data) \
+	(((u32)(_data) & _name ## _MASK) >> _name ## _FLD)
+
+#define BT1_SET_FLD(_name, _data, _val) \
+	(((u32)(_data) & ~_name ## _MASK) | \
+	(((u32)(_val) << _name ## _FLD) & _name ## _MASK))
+
+static inline u32 bt1_read(void __iomem *reg)
+{
+	return readl(reg);
+}
+
+static inline void bt1_write(void __iomem *reg, u32 data)
+{
+	writel(data, reg);
+}
+
+static inline void bt1_update(void __iomem *reg, u32 mask, u32 data)
+{
+	u32 old;
+
+	old = readl_relaxed(reg);
+	writel((old & ~mask) | (data & mask), reg);
+}
+
+#endif /* __SOC_BT1_COMMON_H__ */
-- 
2.25.1

