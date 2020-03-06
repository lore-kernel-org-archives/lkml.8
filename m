Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75B25C10F25
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 13:06:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4433A21D56
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 13:06:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727303AbgCFNGT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 08:06:19 -0500
Received: from mail.baikalelectronics.com ([87.245.175.226]:36268 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727146AbgCFNGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 08:06:18 -0500
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 696EF8030704;
        Fri,  6 Mar 2020 13:06:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id l4r-N2OjJRza; Fri,  6 Mar 2020 16:06:13 +0300 (MSK)
From:   <Sergey.Semin@baikalelectronics.ru>
To:     Lee Jones <lee.jones@linaro.org>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] mfd: Add Baikal-T1 Boot Controller driver
Date:   Fri, 6 Mar 2020 16:05:28 +0300
In-Reply-To: <20200306130528.9973-1-Sergey.Semin@baikalelectronics.ru>
References: <20200306130528.9973-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Message-Id: <20200306130614.696EF8030704@mail.baikalelectronics.ru>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Serge Semin <Sergey.Semin@baikalelectronics.ru>

Baikal-T1 Boot Controller is an IP block embedded into the SoC and
responsible for the chip proper pre-initialization and further
booting up from some memory device. From the Linux kernel point of view
it's just a multi-functional device, which exports three physically mapped
ROMs and a single SPI controller.

Primarily the ROMs are intended to be used for transparent access of
the memory devices with system bootup code. First ROM device is an
embedded into the SoC firmware, which is supposed to be used just for
the chip debug and tests. Second ROM device provides a MMIO-based
access to an external SPI flash. Third ROM mirrors either the Internal
or SPI ROM region, depending on the state of the external BOOTCFG_{0,1}
chip pins selecting the system boot device.

External SPI flash can be also accessed by the DW APB SSI SPI controller
embedded into the Baikal-T1 Boot Controller. In this case the memory mapped
SPI flash region shouldn't be accessed.

Taking into account all the peculiarities described above, we created
an MFD-based driver for the Baikal-T1 controller. Aside from ordinary
OF-based sub-device registration it also provides a simple API to
serialize an access to the external SPI flash from either the MMIO-based
SPI interface or embedded SPI controller.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Signed-off-by: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Paul Burton <paulburton@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
---
 drivers/mfd/Kconfig              |  13 ++
 drivers/mfd/Makefile             |   1 +
 drivers/mfd/bt1-boot-ctl.c       | 345 +++++++++++++++++++++++++++++++
 include/linux/mfd/bt1-boot-ctl.h |  46 +++++
 4 files changed, 405 insertions(+)
 create mode 100644 drivers/mfd/bt1-boot-ctl.c
 create mode 100644 include/linux/mfd/bt1-boot-ctl.h

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 2b203290e7b9..769320dfe25d 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -211,6 +211,19 @@ config MFD_AXP20X_RSB
 	  components like regulators or the PEK (Power Enable Key) under the
 	  corresponding menus.
 
+config MFD_BT1_BOOT
+	tristate "Baikal-T1 Boot Controller support"
+	select MFD_CORE
+	depends on (MIPS_BAIKAL_T1 || COMPILE_TEST) && OF
+	help
+	  If you say Y here you get support for Baikal-T1 SoC Boot Controller
+	  block embedded into the chip. It enables an access to the memory
+	  mapped Internal ROM, SPI ROM, Bootup ROM (this memory region content
+	  depends on the bootup mode) and DW APB SSI-based SPI interface.
+	  Aside from registering the sub-devices this driver provides an APIs,
+	  to switch the Boot SPI interface being handled by the memory mapped
+	  SPI ROM or the DW APB SSI modules.
+
 config MFD_CROS_EC_DEV
 	tristate "ChromeOS Embedded Controller multifunction device"
 	select MFD_CORE
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index b83f172545e1..4c282973090b 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -13,6 +13,7 @@ obj-$(CONFIG_MFD_ASIC3)		+= asic3.o tmio_core.o
 obj-$(CONFIG_ARCH_BCM2835)	+= bcm2835-pm.o
 obj-$(CONFIG_MFD_BCM590XX)	+= bcm590xx.o
 obj-$(CONFIG_MFD_BD9571MWV)	+= bd9571mwv.o
+obj-$(CONFIG_MFD_BT1_BOOT)	+= bt1-boot-ctl.o
 obj-$(CONFIG_MFD_CROS_EC_DEV)	+= cros_ec_dev.o
 obj-$(CONFIG_MFD_EXYNOS_LPASS)	+= exynos-lpass.o
 
diff --git a/drivers/mfd/bt1-boot-ctl.c b/drivers/mfd/bt1-boot-ctl.c
new file mode 100644
index 000000000000..9e3cd47a2e7a
--- /dev/null
+++ b/drivers/mfd/bt1-boot-ctl.c
@@ -0,0 +1,345 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2020 BAIKAL ELECTRONICS, JSC
+ *
+ * Authors:
+ *   Serge Semin <Sergey.Semin@baikalelectronics.ru>
+ *
+ * Baikal-T1 Boot Controller driver.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/device.h>
+#include <linux/platform_device.h>
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/clk.h>
+#include <linux/mutex.h>
+#include <linux/mfd/core.h>
+#include <linux/mfd/bt1-boot-ctl.h>
+
+/*
+ * Baikal-T1 boot controller control registers. These are vendor-specific
+ * registers, which can be used to detect the CPU boot mode and toggle the
+ * Boot SPI flash access modes - either over SPI controller registers
+ * or transparently over a 16 MB memory region mapped at the 0x1C000000
+ * base address.
+ */
+#define BC_CSR				0x00
+#define BC_CSR_MODE_FLD			0
+#define BC_CSR_MODE_MASK		GENMASK(1, BC_CSR_MODE_FLD)
+#define BC_CSR_MODE_ROM			0
+#define BC_CSR_MODE_SRAM		1
+#define BC_CSR_MODE_FLASH		2
+#define BC_CSR_SPI_RDA			BIT(8)
+#define BC_MAR				0x04
+#define BC_MAR_BSAB			BIT(0)
+#define BC_DRID				0x08
+#define BC_VID				0x0C
+#define BC_SPI				0x100
+#define BC_SPI_SSIENR			0x108
+#define BC_SPI_DR_START			0x160
+#define BC_SPI_DR_END			0x1EC
+
+#define BC_GET_FLD(_name, _data) \
+	(((u32)(_data) & BC_ ##_name## _MASK) >> BC_ ##_name## _FLD)
+
+/*
+ * struct bt1_bc - Baikal-T1 Boot Controller private data.
+ * @pdev: platform device instance of the boot controller.
+ * @dev: pointer to the corresponding device structure.
+ * @regs: memory mapped control registers.
+ * @spi_mode: current SPI interface mode.
+ * @spi_mtx: mutex to serialize access to the SPI interfae.
+ * @boot_mode: current SoC boot mode.
+ * @pclk: APB clock.
+ */
+struct bt1_bc {
+	struct platform_device *pdev;
+	struct device *dev;
+
+	void __iomem *regs;
+	enum bt1_bc_spi_mode spi_mode;
+	struct mutex spi_mtx;
+
+	int boot_mode;
+
+	struct clk *pclk;
+};
+
+/*
+ * Baikal-T1 Boot SPI registers state expected to be specified so the
+ * physically mapped ROM interface would work. If DW APB SSI controller
+ * configuration differs from them, the APB-terminator will report the
+ * slave access timeout error.
+ * Note we speed the transfer up to half the DW APB SSI reference clock
+ * instead of leaving a sixth part of it. This increases the interface
+ * performace threefold.
+ */
+static const u32 bc_spi_dump[] = {
+	0x00000307, 0x00000003, 0x00000001, 0x00000000,
+	0x00000001, 0x00000002, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000006, 0x0000003f,
+	0x00000001, 0x00000001, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00100012, 0x3332322a,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000
+};
+
+static inline u32 bc_read(void __iomem *reg)
+{
+	return readl(reg);
+}
+
+static inline void bc_write(void __iomem *reg, u32 data)
+{
+	writel(data, reg);
+}
+
+static inline u32 bc_update(void __iomem *reg, u32 mask, u32 data)
+{
+	u32 old;
+
+	old = readl_relaxed(reg);
+	writel((old & ~mask) | (data & mask), reg);
+
+	return old & mask;
+}
+
+static const char *bc_boot_mode(int mode)
+{
+	switch (mode) {
+	case BC_CSR_MODE_ROM:
+		return "Internal ROM";
+	case BC_CSR_MODE_SRAM:
+		return "Static RAM";
+	case BC_CSR_MODE_FLASH:
+		return "SPI Flash";
+	}
+
+	return "Unknown";
+}
+
+static void bc_spi_map_config(struct bt1_bc *bc)
+{
+	int i, addr;
+
+	bc_write(bc->regs + BC_SPI_SSIENR, 0x0);
+	for (i = 0; i < ARRAY_SIZE(bc_spi_dump); ++i) {
+		addr = BC_SPI + 4*i;
+		if ((addr < BC_SPI_DR_START || addr >= BC_SPI_DR_END) &&
+		    addr != BC_SPI_SSIENR) {
+			bc_write(bc->regs + addr, bc_spi_dump[i]);
+		}
+	}
+	bc_write(bc->regs + BC_SPI_SSIENR, 0x1);
+}
+
+/*
+ * __bt1_bc_spi_lock() - lock Boot Controller SPI interface.
+ * @bc: bt1_bc structure.
+ * @mode: SPI interface mode.
+ *
+ * Exclusive lock primitive to serialize access to the shared SPI flash
+ * by acquiring the mutex and enabling the requested mode.
+ */
+int __bt1_bc_spi_lock(struct bt1_bc *bc, enum bt1_bc_spi_mode mode)
+{
+	int ret;
+
+	if (mode != BT1_BC_SPI_MAP && mode != BT1_BC_SPI_DW)
+		return -EINVAL;
+
+	ret = mutex_lock_interruptible(&bc->spi_mtx);
+	if (ret)
+		return ret;
+
+	if (mode == BT1_BC_SPI_MAP) {
+		if (bc->spi_mode == BT1_BC_SPI_DW)
+			bc_spi_map_config(bc);
+		bc_update(bc->regs + BC_CSR, BC_CSR_SPI_RDA, 0);
+	} else {
+		bc_update(bc->regs + BC_CSR, BC_CSR_SPI_RDA, BC_CSR_SPI_RDA);
+	}
+
+	bc->spi_mode = mode;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(__bt1_bc_spi_lock);
+
+/*
+ * bt1_bc_spi_unlock() - unlock Boot Controller SPI interface.
+ * @bc: bt1_bc structure.
+ * @mode: SPI interface mode.
+ *
+ * Exclusive unlock primitive to release the shared SPI flash resource.
+ */
+void bt1_bc_spi_unlock(struct bt1_bc *bc)
+{
+	mutex_unlock(&bc->spi_mtx);
+}
+EXPORT_SYMBOL_GPL(bt1_bc_spi_unlock);
+
+static struct bt1_bc *bc_create_data(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct bt1_bc *bc;
+
+	bc = devm_kzalloc(dev, sizeof(*bc), GFP_KERNEL);
+	if (!bc)
+		return ERR_PTR(-ENOMEM);
+
+	bc->pdev = pdev;
+	bc->dev = dev;
+
+	return bc;
+}
+
+static int bc_request_regs(struct bt1_bc *bc)
+{
+	bc->regs = devm_platform_ioremap_resource(bc->pdev, 0);
+	if (IS_ERR(bc->regs)) {
+		dev_err(bc->dev, "Couldn't map the controller registers\n");
+		return PTR_ERR(bc->regs);
+	}
+
+	return 0;
+}
+
+static void bc_disable_clk(void *data)
+{
+	struct bt1_bc *bc = data;
+
+	clk_disable_unprepare(bc->pclk);
+}
+
+static int bc_request_clk(struct bt1_bc *bc)
+{
+	int ret;
+
+	bc->pclk = devm_clk_get(bc->dev, "pclk");
+	if (IS_ERR(bc->pclk)) {
+		dev_err(bc->dev, "Couldn't get the APB clock descriptor\n");
+		return PTR_ERR(bc->pclk);
+	}
+
+	ret = clk_prepare_enable(bc->pclk);
+	if (ret) {
+		dev_err(bc->dev, "Couldn't enable the APB clock\n");
+		return ret;
+	}
+
+	ret = devm_add_action_or_reset(bc->dev, bc_disable_clk, bc);
+	if (ret) {
+		dev_err(bc->dev, "Can't add the APB clock disable action\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static void bc_clear_iface(void *data)
+{
+	struct bt1_bc *bc = data;
+
+	mutex_destroy(&bc->spi_mtx);
+	platform_set_drvdata(bc->pdev, NULL);
+}
+
+static int bc_init_iface(struct bt1_bc *bc)
+{
+	u32 data;
+	int ret;
+
+	/*
+	 * Make sure the interface is initialized in a way so SRAM and SPI
+	 * DW would be accessible by default.
+	 */
+	bc_write(bc->regs + BC_MAR, 0);
+	data = bc_read(bc->regs + BC_CSR);
+	bc_write(bc->regs + BC_CSR, data | BC_CSR_SPI_RDA);
+
+	bc->spi_mode = BT1_BC_SPI_DW;
+	bc->boot_mode = BC_GET_FLD(CSR_MODE, data);
+
+	platform_set_drvdata(bc->pdev, bc);
+	mutex_init(&bc->spi_mtx);
+
+	ret = devm_add_action_or_reset(bc->dev, bc_clear_iface, bc);
+	if (ret) {
+		dev_err(bc->dev, "Can't add the interface clearance action\n");
+		return ret;
+	}
+
+	dev_info(bc->dev, "System loader started from %s\n",
+		 bc_boot_mode(bc->boot_mode));
+
+	return 0;
+}
+
+static int bc_register_devices(struct bt1_bc *bc)
+{
+	int ret;
+
+	ret = devm_of_platform_populate(bc->dev);
+	if (ret)
+		dev_err(bc->dev, "Failed to add sub-devices\n");
+
+	return ret;
+}
+
+static int bc_probe(struct platform_device *pdev)
+{
+	struct bt1_bc *bc;
+	int ret;
+
+	bc = bc_create_data(pdev);
+	if (IS_ERR(bc))
+		return PTR_ERR(bc);
+
+	ret = bc_request_regs(bc);
+	if (ret)
+		return ret;
+
+	ret = bc_request_clk(bc);
+	if (ret)
+		return ret;
+
+	ret = bc_init_iface(bc);
+	if (ret)
+		return ret;
+
+	return bc_register_devices(bc);
+}
+
+static const struct of_device_id bc_of_match[] = {
+	{ .compatible = "be,bt1-boot-ctl" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, bc_of_match);
+
+static struct platform_driver bc_driver = {
+	.probe = bc_probe,
+	.driver = {
+		.name = "bt1-boot-ctl",
+		.of_match_table = of_match_ptr(bc_of_match)
+	}
+};
+module_platform_driver(bc_driver);
+
+MODULE_AUTHOR("Serge Semin <Sergey.Semin@baikalelectronics.ru>");
+MODULE_DESCRIPTION("Baikal-T1 Boot Controller driver");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/mfd/bt1-boot-ctl.h b/include/linux/mfd/bt1-boot-ctl.h
new file mode 100644
index 000000000000..2c2dcc01a015
--- /dev/null
+++ b/include/linux/mfd/bt1-boot-ctl.h
@@ -0,0 +1,46 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020 BAIKAL ELECTRONICS, JSC
+ *
+ * Baikal-T1 Boot Controller driver.
+ */
+#ifndef __MFD_BT1_BOOT_CTL_H__
+#define __MFD_BT1_BOOT_CTL_H__
+
+struct bt1_bc;
+
+/*
+ * enum bt1_bc_spi_mode - Boot Controller SPI interface modes.
+ * @BT1_BC_SPI_MAP: memory mapped SPI Flash.
+ * @BT1_BC_SPI_DW: DW APB SSI-based access.
+ */
+enum bt1_bc_spi_mode {
+	BT1_BC_SPI_MAP,
+	BT1_BC_SPI_DW
+};
+
+extern int __bt1_bc_spi_lock(struct bt1_bc *bc, enum bt1_bc_spi_mode mode);
+extern void bt1_bc_spi_unlock(struct bt1_bc *bc);
+
+/*
+ * bt1_bc_spi_map_lock() - Lock Boot SPI Controller in the trasparent mode.
+ * @__bc: bt1_bc structure.
+ *
+ * Helper macro to lock the Baikal-T1 Boot SPI interface in the mode,
+ * when the SPI Flash is directly mapped to a memory region in the
+ * read-only mode.
+ */
+#define bt1_bc_spi_map_lock(__bc) \
+	__bt1_bc_spi_lock(__bc, BT1_BC_SPI_MAP)
+
+/*
+ * bt1_bc_spi_dw_lock() - Lock Boot SPI Controller in the DW SSI mode.
+ * @__bc: bt1_bc structure.
+ *
+ * Helper macro to lock the Baikal-T1 Boot SPI interface in the
+ * DW SSI controller mode.
+ */
+#define bt1_bc_spi_dw_lock(__bc) \
+	__bt1_bc_spi_lock(__bc, BT1_BC_SPI_DW)
+
+#endif /* __MFD_BT1_BOOT_CTL_H__ */
-- 
2.25.1

