Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38E59C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 13:07:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1F3A222C3
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 13:07:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727306AbgCFNHs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 08:07:48 -0500
Received: from mail.baikalelectronics.com ([87.245.175.226]:36346 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbgCFNHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 08:07:38 -0500
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 287C48030704;
        Fri,  6 Mar 2020 13:07:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id FtOrceswA8HG; Fri,  6 Mar 2020 16:07:35 +0300 (MSK)
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
Subject: [PATCH 5/6] soc: bt1: Add Baikal-T1 APB-bus EHB driver
Date:   Fri, 6 Mar 2020 16:07:20 +0300
In-Reply-To: <20200306130721.10347-1-Sergey.Semin@baikalelectronics.ru>
References: <20200306130721.10347-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Message-Id: <20200306130736.287C48030704@mail.baikalelectronics.ru>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Serge Semin <Sergey.Semin@baikalelectronics.ru>

APB-bus is the system configuration bus utilized to access the peripheral
IP-cores configuration registers space. Baikal-T1 SoC provides a way to
detect the bus protocol errors and report a short info about it by means of
the APB-bus Errors Handler Block (APB EHB). In case if an attempted APB
transaction stays with no response for a pre-defined time an interrupt
occurs and the bus gets freed for a next operation. This driver provides
the interrupt handler to detect the erroneous address, prints an error
message about the faulty address, updates an errors counter. The counter
and the APB-bus operations timeout can be accessed via corresponding sysfs
nodes. A dedicated sysfs-node can be also used to artificially cause the
bus errors described above.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Signed-off-by: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Paul Burton <paulburton@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Olof Johansson <olof@lixom.net>
Cc: soc@kernel.org
---
 drivers/soc/baikal-t1/Kconfig   |  15 ++
 drivers/soc/baikal-t1/Makefile  |   1 +
 drivers/soc/baikal-t1/apb-ehb.c | 381 ++++++++++++++++++++++++++++++++
 3 files changed, 397 insertions(+)
 create mode 100644 drivers/soc/baikal-t1/apb-ehb.c

diff --git a/drivers/soc/baikal-t1/Kconfig b/drivers/soc/baikal-t1/Kconfig
index aca155350612..a021abea102f 100644
--- a/drivers/soc/baikal-t1/Kconfig
+++ b/drivers/soc/baikal-t1/Kconfig
@@ -19,4 +19,19 @@ config BT1_AXI_EHB
 
 	  If unsure, say N.
 
+config BT1_APB_EHB
+	bool "Baikal-T1 APB-bus Errors Handler Block"
+	depends on SOC_BAIKAL_T1 && OF
+	help
+	  Baikal-T1 APB-bus is used to access the IP-core blocks CSRs. In case
+	  if an attempted APB transaction stays with no response for a pre-
+	  defined time an interrupt occurs and the bus gets freed for a next
+	  operation. It is done by the APB-bus Errors Handler Block (APB EHB).
+	  This driver provides the interrupt handler to detect the erroneous
+	  address, prints an error message about the address fault, updates an
+	  errors counter. The counter and the APB-bus operations timeout can be
+	  accessed via corresponding sysfs nodes.
+
+	  If unsure, say N.
+
 endmenu
diff --git a/drivers/soc/baikal-t1/Makefile b/drivers/soc/baikal-t1/Makefile
index c069791058b9..ffb035600e01 100644
--- a/drivers/soc/baikal-t1/Makefile
+++ b/drivers/soc/baikal-t1/Makefile
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_BT1_AXI_EHB) += axi-ehb.o
+obj-$(CONFIG_BT1_APB_EHB) += apb-ehb.o
diff --git a/drivers/soc/baikal-t1/apb-ehb.c b/drivers/soc/baikal-t1/apb-ehb.c
new file mode 100644
index 000000000000..726cb75d29cb
--- /dev/null
+++ b/drivers/soc/baikal-t1/apb-ehb.c
@@ -0,0 +1,381 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2014 - 2020 BAIKAL ELECTRONICS, JSC
+ *
+ * Authors:
+ *   Serge Semin <Sergey.Semin@baikalelectronics.ru>
+ *
+ * Baikal-T1 APB-bus Errors Handler Block driver.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/device.h>
+#include <linux/atomic.h>
+#include <linux/platform_device.h>
+#include <linux/spinlock.h>
+#include <linux/interrupt.h>
+#include <linux/nmi.h>
+#include <linux/time64.h>
+#include <linux/clk.h>
+#include <linux/sysfs.h>
+
+#include "common.h"
+
+#define APB_EHB_ISR			0x00
+#define APB_EHB_ISR_PENDING		BIT(0)
+#define APB_EHB_ISR_MASK		BIT(1)
+#define APB_EHB_ADDR			0x04
+#define APB_EHB_TIMEOUT			0x08
+
+#define APB_EHB_TIMEOUT_MIN		0x000003FFU
+#define APB_EHB_TIMEOUT_MAX		0xFFFFFFFFU
+
+#define APB_EHB_N_TO_TOUT_US(_rate, _n) ({		\
+	uint64_t _tmp = USEC_PER_SEC * (uint64_t)(_n);	\
+	do_div(_tmp, _rate);				\
+	_tmp;						\
+})
+#define APB_EHB_TOUT_TO_N_US(_rate, _tout) ({		\
+	uint64_t _tmp = (_tout) * (uint64_t)(_rate);	\
+	do_div(_tmp, USEC_PER_SEC);			\
+	_tmp;						\
+})
+
+/*
+ * struct apb_ehb - Baikal-T1 APB EHB private data.
+ * @dev: Pointer to the device structure.
+ * @regs: Memory mapped block registers.
+ * @reg_isr_lock: Registers memory lock.
+ * @res: No-device error injection memory region.
+ * @irq: Errors IRQ number.
+ * @count: Number of errors detected.
+ * @ref: APB-reference clock.
+ */
+struct apb_ehb {
+	struct device *dev;
+
+	void __iomem *regs;
+	spinlock_t reg_isr_lock;
+	void __iomem *res;
+	int irq;
+
+	atomic_t count;
+
+	struct clk *ref;
+};
+
+static irqreturn_t apb_ehb_isr(int irq, void *data)
+{
+	struct apb_ehb *ehb = data;
+	unsigned long flags;
+	u32 addr;
+
+	addr = bt1_read(ehb->regs + APB_EHB_ADDR);
+
+	dev_crit_ratelimited(ehb->dev,
+		"APB-bus fault %d: Slave access timeout at 0x%08x\n",
+		atomic_inc_return(&ehb->count),
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
+	spin_lock_irqsave(&ehb->reg_isr_lock, flags);
+	bt1_update(ehb->regs + APB_EHB_ISR, APB_EHB_ISR_PENDING, 0);
+	spin_unlock_irqrestore(&ehb->reg_isr_lock, flags);
+
+	return IRQ_HANDLED;
+}
+
+static void apb_ehb_clear_data(void *data)
+{
+	struct apb_ehb *ehb = data;
+	struct platform_device *pdev = to_platform_device(ehb->dev);
+
+	platform_set_drvdata(pdev, NULL);
+}
+
+static struct apb_ehb *apb_ehb_create_data(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct apb_ehb *ehb;
+	int ret;
+
+	ehb = devm_kzalloc(dev, sizeof(*ehb), GFP_KERNEL);
+	if (!ehb)
+		return ERR_PTR(-ENOMEM);
+
+	ret = devm_add_action(dev, apb_ehb_clear_data, ehb);
+	if (ret) {
+		dev_err(dev, "Can't add APB EHB data clear action\n");
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
+static int apb_ehb_request_regs(struct apb_ehb *ehb)
+{
+	struct platform_device *pdev = to_platform_device(ehb->dev);
+
+	ehb->regs = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(ehb->regs)) {
+		dev_err(ehb->dev, "Couldn't map APB EHB registers\n");
+		return PTR_ERR(ehb->regs);
+	}
+
+	ehb->res = devm_platform_ioremap_resource(pdev, 1);
+	if (IS_ERR(ehb->regs)) {
+		dev_err(ehb->dev, "Couldn't map reserved region\n");
+		return PTR_ERR(ehb->res);
+	}
+
+	return 0;
+}
+
+static void apb_ehb_disable_clk(void *data)
+{
+	struct apb_ehb *ehb = data;
+
+	clk_disable_unprepare(ehb->ref);
+}
+
+static int apb_ehb_request_clk(struct apb_ehb *ehb)
+{
+	int ret;
+
+	ehb->ref = devm_clk_get(ehb->dev, "ref");
+	if (IS_ERR(ehb->ref)) {
+		dev_err(ehb->dev, "Couldn't get APB clock descriptor\n");
+		return PTR_ERR(ehb->ref);
+	}
+
+	ret = clk_prepare_enable(ehb->ref);
+	if (ret) {
+		dev_err(ehb->dev, "Couldn't enable the APB clock\n");
+		return ret;
+	}
+
+	ret = devm_add_action_or_reset(ehb->dev, apb_ehb_disable_clk, ehb);
+	if (ret)
+		dev_err(ehb->dev, "Can't add APB EHB clocks disable action\n");
+
+	return ret;
+}
+
+static void apb_ehb_clear_irq(void *data)
+{
+	struct apb_ehb *ehb = data;
+	unsigned long flags;
+
+	spin_lock_irqsave(&ehb->reg_isr_lock, flags);
+	bt1_update(ehb->regs + APB_EHB_ISR, APB_EHB_ISR_MASK, 0);
+	spin_unlock_irqrestore(&ehb->reg_isr_lock, flags);
+}
+
+static int apb_ehb_request_irq(struct apb_ehb *ehb)
+{
+	struct platform_device *pdev = to_platform_device(ehb->dev);
+	int ret;
+
+	spin_lock_init(&ehb->reg_isr_lock);
+
+	ehb->irq = platform_get_irq(pdev, 0);
+	if (ehb->irq < 0) {
+		dev_err(ehb->dev, "Couldn't find APB EHB IRQ number\n");
+		return ehb->irq;
+	}
+
+	ret = devm_request_irq(ehb->dev, ehb->irq, apb_ehb_isr, IRQF_SHARED,
+			       "apb_ehb", ehb);
+	if (ret) {
+		dev_err(ehb->dev, "Couldn't request APB EHB IRQ\n");
+		return ret;
+	}
+
+	ret = devm_add_action(ehb->dev, apb_ehb_clear_irq, ehb);
+	if (ret) {
+		dev_err(ehb->dev, "Can't add APB EHB IRQs clear action\n");
+		return ret;
+	}
+
+	/* Unmask IRQ and clear it' pending flag. */
+	bt1_update(ehb->regs + APB_EHB_ISR,
+		   APB_EHB_ISR_PENDING | APB_EHB_ISR_MASK, APB_EHB_ISR_MASK);
+
+	return 0;
+}
+
+static ssize_t count_show(struct device *dev, struct device_attribute *attr,
+			  char *buf)
+{
+	struct apb_ehb *ehb = dev_get_drvdata(dev);
+
+	return scnprintf(buf, PAGE_SIZE, "%d\n", atomic_read(&ehb->count));
+}
+static DEVICE_ATTR_RO(count);
+
+static ssize_t timeout_show(struct device *dev, struct device_attribute *attr,
+			    char *buf)
+{
+	struct apb_ehb *ehb = dev_get_drvdata(dev);
+	unsigned long timeout, rate;
+	u32 n;
+
+	rate = clk_get_rate(ehb->ref);
+	if (!rate)
+		return -ENODEV;
+
+	n = bt1_read(ehb->regs + APB_EHB_TIMEOUT);
+	timeout = APB_EHB_N_TO_TOUT_US(rate, n);
+
+	return scnprintf(buf, PAGE_SIZE, "%lu\n", timeout);
+}
+
+static ssize_t timeout_store(struct device *dev,
+			     struct device_attribute *attr,
+			     const char *buf, size_t count)
+{
+	struct apb_ehb *ehb = dev_get_drvdata(dev);
+	unsigned long timeout, rate;
+	u32 n;
+
+	if (kstrtoul(buf, 0, &timeout) < 0)
+		return -EINVAL;
+
+	rate = clk_get_rate(ehb->ref);
+	if (!rate)
+		return -ENODEV;
+
+	n = APB_EHB_TOUT_TO_N_US(rate, timeout);
+	n = clamp(n, APB_EHB_TIMEOUT_MIN, APB_EHB_TIMEOUT_MAX);
+
+	bt1_write(ehb->regs + APB_EHB_TIMEOUT, n);
+
+	return count;
+}
+static DEVICE_ATTR_RW(timeout);
+
+static int inject_error_show(struct device *dev, struct device_attribute *attr,
+			     char *buf)
+{
+	return scnprintf(buf, PAGE_SIZE, "Error injection: nodev irq\n");
+}
+
+static int inject_error_store(struct device *dev,
+			      struct device_attribute *attr,
+			      const char *data, size_t count)
+{
+	struct apb_ehb *ehb = dev_get_drvdata(dev);
+	unsigned long flags;
+
+	/*
+	 * Either dummy read from the unmapped address in the APB IO area
+	 * or manually set the IRQ status.
+	 */
+	if (!strncmp(data, "nodev", 5)) {
+		readl(ehb->res);
+	} else if (!strncmp(data, "irq", 3)) {
+		spin_lock_irqsave(&ehb->reg_isr_lock, flags);
+		bt1_write(ehb->regs + APB_EHB_ISR,
+			  APB_EHB_ISR_PENDING | APB_EHB_ISR_MASK);
+		spin_unlock_irqrestore(&ehb->reg_isr_lock, flags);
+	} else
+		return -EINVAL;
+
+	return count;
+}
+static DEVICE_ATTR_RW(inject_error);
+
+static struct attribute *apb_ehb_sysfs_attrs[] = {
+	&dev_attr_count.attr,
+	&dev_attr_timeout.attr,
+	&dev_attr_inject_error.attr,
+	NULL
+};
+ATTRIBUTE_GROUPS(apb_ehb_sysfs);
+
+static void apb_ehb_remove_sysfs(void *data)
+{
+	struct apb_ehb *ehb = data;
+
+	device_remove_groups(ehb->dev, apb_ehb_sysfs_groups);
+}
+
+static int apb_ehb_init_sysfs(struct apb_ehb *ehb)
+{
+	int ret;
+
+	ret = device_add_groups(ehb->dev, apb_ehb_sysfs_groups);
+	if (ret) {
+		dev_err(ehb->dev, "Failed to create EHB APB sysfs nodes\n");
+		return ret;
+	}
+
+	ret = devm_add_action_or_reset(ehb->dev, apb_ehb_remove_sysfs, ehb);
+	if (ret)
+		dev_err(ehb->dev, "Can't add APB EHB sysfs remove action\n");
+
+	return ret;
+}
+
+static int apb_ehb_probe(struct platform_device *pdev)
+{
+	struct apb_ehb *ehb;
+	int ret;
+
+	ehb = apb_ehb_create_data(pdev);
+	if (IS_ERR(ehb))
+		return PTR_ERR(ehb);
+
+	ret = apb_ehb_request_regs(ehb);
+	if (ret)
+		return ret;
+
+	ret = apb_ehb_request_clk(ehb);
+	if (ret)
+		return ret;
+
+	ret = apb_ehb_request_irq(ehb);
+	if (ret)
+		return ret;
+
+	ret = apb_ehb_init_sysfs(ehb);
+	if (ret)
+		return ret;
+
+	dev_info(ehb->dev, "APB-bus errors handler installed\n");
+
+	return 0;
+}
+
+static const struct of_device_id apb_ehb_of_match[] = {
+	{ .compatible = "be,bt1-apb-ehb" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, apb_ehb_of_match);
+
+static struct platform_driver apb_ehb_driver = {
+	.probe = apb_ehb_probe,
+	.driver = {
+		.name = "bt1-apb-ehb",
+		.of_match_table = of_match_ptr(apb_ehb_of_match)
+	}
+};
+module_platform_driver(apb_ehb_driver);
+
+MODULE_AUTHOR("Serge Semin <Sergey.Semin@baikalelectronics.ru>");
+MODULE_DESCRIPTION("Baikal-T1 APB EHB driver");
+MODULE_LICENSE("GPL v2");
-- 
2.25.1

