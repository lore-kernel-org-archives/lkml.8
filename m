Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F6B0C3B187
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 13:26:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEFDF206DB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 13:26:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729220AbgBKN0X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 08:26:23 -0500
Received: from mga05.intel.com ([192.55.52.43]:43808 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729189AbgBKN0S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 08:26:18 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Feb 2020 05:26:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,428,1574150400"; 
   d="scan'208";a="256468928"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 11 Feb 2020 05:26:13 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 8C92C6C5; Tue, 11 Feb 2020 15:26:04 +0200 (EET)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Lee Jones <lee.jones@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Zha Qipeng <qipeng.zha@intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 17/18] platform/x86: intel_pmc_ipc: Convert to MFD
Date:   Tue, 11 Feb 2020 16:26:02 +0300
Message-Id: <20200211132603.73509-18-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200211132603.73509-1-mika.westerberg@linux.intel.com>
References: <20200211132603.73509-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver only creates a bunch of platform devices sharing resources
belonging to the PMC device. This is pretty much what MFD subsystem is
for so move the driver there, renaming it to intel_pmc_bxt.c which
should be more clear what it is.

MFD subsystem provides nice helper APIs for subdevice creation so
convert the driver to use those. Unfortunately the ACPI device includes
separate resources for most of the subdevices so we cannot simply call
mfd_add_devices() to create all of them but instead we need to call it
separately for each device.

The new MFD driver continues to expose two sysfs attributes that allow
userspace to send IPC commands to the PMC/SCU to avoid breaking any
existing applications that may use these. Generally this is bad idea so
document this in the ABI documentation.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 .../ABI/obsolete/sysfs-driver-intel_pmc_bxt   |  22 +
 arch/x86/include/asm/intel_pmc_ipc.h          |  47 --
 arch/x86/include/asm/intel_telemetry.h        |   1 +
 drivers/mfd/Kconfig                           |  16 +-
 drivers/mfd/Makefile                          |   1 +
 drivers/mfd/intel_pmc_bxt.c                   | 491 +++++++++++++
 drivers/platform/x86/Kconfig                  |  16 +-
 drivers/platform/x86/Makefile                 |   1 -
 drivers/platform/x86/intel_pmc_ipc.c          | 645 ------------------
 .../platform/x86/intel_telemetry_debugfs.c    |  12 +-
 drivers/platform/x86/intel_telemetry_pltdrv.c |   2 +
 drivers/usb/typec/tcpm/Kconfig                |   2 +-
 include/linux/mfd/intel_pmc_bxt.h             |  21 +
 13 files changed, 567 insertions(+), 710 deletions(-)
 create mode 100644 Documentation/ABI/obsolete/sysfs-driver-intel_pmc_bxt
 delete mode 100644 arch/x86/include/asm/intel_pmc_ipc.h
 create mode 100644 drivers/mfd/intel_pmc_bxt.c
 delete mode 100644 drivers/platform/x86/intel_pmc_ipc.c
 create mode 100644 include/linux/mfd/intel_pmc_bxt.h

diff --git a/Documentation/ABI/obsolete/sysfs-driver-intel_pmc_bxt b/Documentation/ABI/obsolete/sysfs-driver-intel_pmc_bxt
new file mode 100644
index 000000000000..b298be32d426
--- /dev/null
+++ b/Documentation/ABI/obsolete/sysfs-driver-intel_pmc_bxt
@@ -0,0 +1,22 @@
+These files allow sending arbitrary IPC commands to the PMC/SCU which
+may be dangerous. These will be removed eventually and should not be
+used in any new applications.
+
+What:		/sys/bus/platform/devices/INT34D2:00/simplecmd
+Date:		Jun 2015
+KernelVersion:	4.1
+Contact:	Mika Westerberg <mika.westerberg@linux.intel.com>
+Description:	This interface allows userspace to send an arbitrary
+		IPC command to the PMC/SCU.
+
+		Format: %d %d where first number is command and
+		second number is subcommand.
+
+What:		/sys/bus/platform/devices/INT34D2:00/northpeak
+Date:		Jun 2015
+KernelVersion:	4.1
+Contact:	Mika Westerberg <mika.westerberg@linux.intel.com>
+Description:	This interface allows userspace to send an arbitrary
+		command to the Northpeak through the PMC/SCU.
+
+		Format: %u.
diff --git a/arch/x86/include/asm/intel_pmc_ipc.h b/arch/x86/include/asm/intel_pmc_ipc.h
deleted file mode 100644
index 22848df5faaf..000000000000
--- a/arch/x86/include/asm/intel_pmc_ipc.h
+++ /dev/null
@@ -1,47 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ASM_X86_INTEL_PMC_IPC_H_
-#define  _ASM_X86_INTEL_PMC_IPC_H_
-
-/* Commands */
-#define PMC_IPC_USB_PWR_CTRL		0xF0
-#define PMC_IPC_PMIC_BLACKLIST_SEL	0xEF
-#define PMC_IPC_PHY_CONFIG		0xEE
-#define PMC_IPC_NORTHPEAK_CTRL		0xED
-#define PMC_IPC_PM_DEBUG		0xEC
-#define PMC_IPC_PMC_FW_MSG_CTRL		0xEA
-
-/* IPC return code */
-#define IPC_ERR_NONE			0
-#define IPC_ERR_CMD_NOT_SUPPORTED	1
-#define IPC_ERR_CMD_NOT_SERVICED	2
-#define IPC_ERR_UNABLE_TO_SERVICE	3
-#define IPC_ERR_CMD_INVALID		4
-#define IPC_ERR_CMD_FAILED		5
-#define IPC_ERR_EMSECURITY		6
-#define IPC_ERR_UNSIGNEDKERNEL		7
-
-/* GCR reg offsets from gcr base*/
-#define PMC_GCR_PMC_CFG_REG		0x08
-#define PMC_GCR_TELEM_DEEP_S0IX_REG	0x78
-#define PMC_GCR_TELEM_SHLW_S0IX_REG	0x80
-
-#if IS_ENABLED(CONFIG_INTEL_PMC_IPC)
-
-int intel_pmc_s0ix_counter_read(u64 *data);
-int intel_pmc_gcr_read64(u32 offset, u64 *data);
-
-#else
-
-static inline int intel_pmc_s0ix_counter_read(u64 *data)
-{
-	return -EINVAL;
-}
-
-static inline int intel_pmc_gcr_read64(u32 offset, u64 *data)
-{
-	return -EINVAL;
-}
-
-#endif /*CONFIG_INTEL_PMC_IPC*/
-
-#endif
diff --git a/arch/x86/include/asm/intel_telemetry.h b/arch/x86/include/asm/intel_telemetry.h
index 2c0e7d7a10e9..8046e70dfd7c 100644
--- a/arch/x86/include/asm/intel_telemetry.h
+++ b/arch/x86/include/asm/intel_telemetry.h
@@ -53,6 +53,7 @@ struct telemetry_plt_config {
 	struct telemetry_unit_config ioss_config;
 	struct mutex telem_trace_lock;
 	struct mutex telem_lock;
+	struct intel_pmc_dev *pmc;
 	struct intel_scu_ipc_dev *scu;
 	bool telem_in_use;
 };
diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 20b294ef2873..d41a965d819b 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -551,7 +551,7 @@ config INTEL_SOC_PMIC
 
 config INTEL_SOC_PMIC_BXTWC
 	tristate "Support for Intel Broxton Whiskey Cove PMIC"
-	depends on INTEL_PMC_IPC
+	depends on MFD_INTEL_PMC_BXT
 	select MFD_CORE
 	select REGMAP_IRQ
 	help
@@ -632,6 +632,20 @@ config MFD_INTEL_MSIC
 	  Passage) chip. This chip embeds audio, battery, GPIO, etc.
 	  devices used in Intel Medfield platforms.
 
+config MFD_INTEL_PMC_BXT
+	tristate "Intel PMC Driver for Broxton"
+	depends on X86
+	depends on X86_PLATFORM_DEVICES
+	depends on ACPI
+	select INTEL_SCU_IPC
+	select MFD_CORE
+	help
+	  This driver provides support for the PMC (Power Management
+	  Controller) on Intel Broxton and Apollo Lake. The PMC is a
+	  multi-function device that exposes IPC, General Control
+	  Register and P-unit access. In addition this creates devices
+	  for iTCO watchdog and telemetry that are part of the PMC.
+
 config MFD_IPAQ_MICRO
 	bool "Atmel Micro ASIC (iPAQ h3100/h3600/h3700) Support"
 	depends on SA1100_H3100 || SA1100_H3600
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index b83f172545e1..444264d42a20 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -212,6 +212,7 @@ obj-$(CONFIG_MFD_INTEL_LPSS)	+= intel-lpss.o
 obj-$(CONFIG_MFD_INTEL_LPSS_PCI)	+= intel-lpss-pci.o
 obj-$(CONFIG_MFD_INTEL_LPSS_ACPI)	+= intel-lpss-acpi.o
 obj-$(CONFIG_MFD_INTEL_MSIC)	+= intel_msic.o
+obj-$(CONFIG_MFD_INTEL_PMC_BXT)	+= intel_pmc_bxt.o
 obj-$(CONFIG_MFD_PALMAS)	+= palmas.o
 obj-$(CONFIG_MFD_VIPERBOARD)    += viperboard.o
 obj-$(CONFIG_MFD_RC5T583)	+= rc5t583.o rc5t583-irq.o
diff --git a/drivers/mfd/intel_pmc_bxt.c b/drivers/mfd/intel_pmc_bxt.c
new file mode 100644
index 000000000000..3596d3b0b6d1
--- /dev/null
+++ b/drivers/mfd/intel_pmc_bxt.c
@@ -0,0 +1,491 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Driver for the Intel Broxton PMC
+ *
+ * (C) Copyright 2014 - 2020 Intel Corporation
+ *
+ * This driver is based on Intel SCU IPC driver (intel_scu_ipc.c) by
+ * Sreedhara DS <sreedhara.ds@intel.com>
+ *
+ * The PMC running on the ARC processor communicates with another entity
+ * running in the IA core through an IPC mechanism which in turn sends
+ * messages between the IA and the PMC.
+ */
+
+#include <linux/acpi.h>
+#include <linux/delay.h>
+#include <linux/errno.h>
+#include <linux/interrupt.h>
+#include <linux/io-64-nonatomic-lo-hi.h>
+#include <linux/mfd/core.h>
+#include <linux/mfd/intel_pmc_bxt.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/platform_data/itco_wdt.h>
+
+#include <asm/intel_scu_ipc.h>
+
+/* Residency with clock rate at 19.2MHz to usecs */
+#define S0IX_RESIDENCY_IN_USECS(d, s)		\
+({						\
+	u64 result = 10ull * ((d) + (s));	\
+	do_div(result, 192);			\
+	result;					\
+})
+
+/* Resources exported from IFWI */
+#define PLAT_RESOURCE_IPC_INDEX		0
+#define PLAT_RESOURCE_IPC_SIZE		0x1000
+#define PLAT_RESOURCE_GCR_OFFSET	0x1000
+#define PLAT_RESOURCE_GCR_SIZE		0x1000
+#define PLAT_RESOURCE_BIOS_DATA_INDEX	1
+#define PLAT_RESOURCE_BIOS_IFACE_INDEX	2
+#define PLAT_RESOURCE_TELEM_SSRAM_INDEX	3
+#define PLAT_RESOURCE_ISP_DATA_INDEX	4
+#define PLAT_RESOURCE_ISP_IFACE_INDEX	5
+#define PLAT_RESOURCE_GTD_DATA_INDEX	6
+#define PLAT_RESOURCE_GTD_IFACE_INDEX	7
+#define PLAT_RESOURCE_ACPI_IO_INDEX	0
+
+/*
+ * BIOS does not create an ACPI device for each PMC function, but
+ * exports multiple resources from one ACPI device (IPC) for multiple
+ * functions. This driver is responsible for creating a child device and
+ * to export resources for those functions.
+ */
+#define TCO_DEVICE_NAME			"iTCO_wdt"
+#define SMI_EN_OFFSET			0x40
+#define SMI_EN_SIZE			4
+#define TCO_BASE_OFFSET			0x60
+#define TCO_REGS_SIZE			16
+#define PUNIT_DEVICE_NAME		"intel_punit_ipc"
+#define TELEMETRY_DEVICE_NAME		"intel_telemetry"
+#define TELEM_SSRAM_SIZE		240
+#define TELEM_PMC_SSRAM_OFFSET		0x1B00
+#define TELEM_PUNIT_SSRAM_OFFSET	0x1A00
+
+/* Commands */
+#define PMC_NORTHPEAK_CTRL		0xED
+
+/* PMC_CFG_REG bit masks */
+#define PMC_CFG_NO_REBOOT_EN		BIT(4)
+
+/* Index to cells array in below struct */
+enum {
+	PMC_TCO,
+	PMC_PUNIT,
+	PMC_TELEM,
+};
+
+struct intel_pmc_dev {
+	struct device *dev;
+	struct intel_scu_ipc_dev *scu;
+
+	struct mfd_cell cells[PMC_TELEM + 1];
+
+	void __iomem *gcr_mem_base;
+	spinlock_t gcr_lock;
+
+	struct resource *telem_base;
+};
+
+static inline bool is_gcr_valid(u32 offset)
+{
+	return offset < PLAT_RESOURCE_GCR_SIZE - 8;
+}
+
+/**
+ * intel_pmc_gcr_read64() - Read a 64-bit PMC GCR register
+ * @pmc: PMC device pointer
+ * @offset: offset of GCR register from GCR address base
+ * @data: data pointer for storing the register output
+ *
+ * Reads the 64-bit PMC GCR register at given offset.
+ *
+ * Return: Negative value on error or 0 on success.
+ */
+int intel_pmc_gcr_read64(struct intel_pmc_dev *pmc, u32 offset, u64 *data)
+{
+	if (!is_gcr_valid(offset))
+		return -EINVAL;
+
+	spin_lock(&pmc->gcr_lock);
+	*data = readq(pmc->gcr_mem_base + offset);
+	spin_unlock(&pmc->gcr_lock);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(intel_pmc_gcr_read64);
+
+/**
+ * intel_pmc_gcr_update() - Update PMC GCR register bits
+ * @pmc: PMC device pointer
+ * @offset: offset of GCR register from GCR address base
+ * @mask: bit mask for update operation
+ * @val: update value
+ *
+ * Updates the bits of given GCR register as specified by
+ * @mask and @val.
+ *
+ * Return: Negative value on error or 0 on success.
+ */
+static int intel_pmc_gcr_update(struct intel_pmc_dev *pmc, u32 offset, u32 mask,
+				u32 val)
+{
+	u32 new_val;
+
+	if (!is_gcr_valid(offset))
+		return -EINVAL;
+
+	spin_lock(&pmc->gcr_lock);
+	new_val = readl(pmc->gcr_mem_base + offset);
+
+	new_val = (new_val & ~mask) | (val & mask);
+	writel(new_val, pmc->gcr_mem_base + offset);
+
+	new_val = readl(pmc->gcr_mem_base + offset);
+	spin_unlock(&pmc->gcr_lock);
+
+	/* Check whether the bit update is successful */
+	return (new_val & mask) != (val & mask) ? -EIO : 0;
+}
+
+/**
+ * intel_pmc_s0ix_counter_read() - Read S0ix residency.
+ * @pmc: PMC device pointer
+ * @data: Out param that contains current S0ix residency count.
+ *
+ * Writes to @data how many usecs the system has been in low-power S0ix
+ * state.
+ *
+ * Return: An error code or 0 on success.
+ */
+int intel_pmc_s0ix_counter_read(struct intel_pmc_dev *pmc, u64 *data)
+{
+	u64 deep, shlw;
+
+	spin_lock(&pmc->gcr_lock);
+	deep = readq(pmc->gcr_mem_base + PMC_GCR_TELEM_DEEP_S0IX_REG);
+	shlw = readq(pmc->gcr_mem_base + PMC_GCR_TELEM_SHLW_S0IX_REG);
+	spin_unlock(&pmc->gcr_lock);
+
+	*data = S0IX_RESIDENCY_IN_USECS(deep, shlw);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(intel_pmc_s0ix_counter_read);
+
+static ssize_t intel_pmc_simple_cmd_store(struct device *dev,
+					  struct device_attribute *attr,
+					  const char *buf, size_t count)
+{
+	struct intel_pmc_dev *pmc = dev_get_drvdata(dev);
+	struct intel_scu_ipc_dev *scu = pmc->scu;
+	int subcmd;
+	int cmd;
+	int ret;
+
+	ret = sscanf(buf, "%d %d", &cmd, &subcmd);
+	if (ret != 2) {
+		dev_err(dev, "Invalid values, expected: cmd subcmd\n");
+		return -EINVAL;
+	}
+
+	ret = intel_scu_ipc_dev_simple_command(scu, cmd, subcmd);
+	return ret ?: count;
+}
+static DEVICE_ATTR(simplecmd, 0200, NULL, intel_pmc_simple_cmd_store);
+
+static ssize_t intel_pmc_northpeak_store(struct device *dev,
+					 struct device_attribute *attr,
+					 const char *buf, size_t count)
+{
+	struct intel_pmc_dev *pmc = dev_get_drvdata(dev);
+	struct intel_scu_ipc_dev *scu = pmc->scu;
+	unsigned long val;
+	int subcmd;
+	int ret;
+
+	ret = kstrtoul(buf, 0, &val);
+	if (ret)
+		return ret;
+
+	if (val)
+		subcmd = 1;
+	else
+		subcmd = 0;
+
+	ret = intel_scu_ipc_dev_simple_command(scu, PMC_NORTHPEAK_CTRL, subcmd);
+	return ret ?: count;
+}
+static DEVICE_ATTR(northpeak, 0200, NULL, intel_pmc_northpeak_store);
+
+static struct attribute *intel_pmc_attrs[] = {
+	&dev_attr_northpeak.attr,
+	&dev_attr_simplecmd.attr,
+	NULL
+};
+
+static const struct attribute_group intel_pmc_group = {
+	.attrs = intel_pmc_attrs,
+};
+
+static const struct attribute_group *intel_pmc_groups[] = {
+	&intel_pmc_group,
+	NULL
+};
+
+/* Templates used to construct MFD cells */
+
+static const struct mfd_cell punit = {
+	.name = PUNIT_DEVICE_NAME,
+};
+
+static int update_no_reboot_bit(void *priv, bool set)
+{
+	struct intel_pmc_dev *pmc = priv;
+	u32 bits = PMC_CFG_NO_REBOOT_EN;
+	u32 value = set ? bits : 0;
+
+	return intel_pmc_gcr_update(pmc, PMC_GCR_PMC_CFG_REG, bits, value);
+}
+
+static const struct itco_wdt_platform_data tco_pdata = {
+	.name = "Apollo Lake SoC",
+	.version = 5,
+	.update_no_reboot_bit = update_no_reboot_bit,
+};
+
+static const struct mfd_cell tco = {
+	.name = TCO_DEVICE_NAME,
+	.ignore_resource_conflicts = true,
+};
+
+static const struct resource telem_res[] = {
+	DEFINE_RES_MEM(TELEM_PUNIT_SSRAM_OFFSET, TELEM_SSRAM_SIZE),
+	DEFINE_RES_MEM(TELEM_PMC_SSRAM_OFFSET, TELEM_SSRAM_SIZE),
+};
+
+static const struct mfd_cell telem = {
+	.name = TELEMETRY_DEVICE_NAME,
+	.resources = telem_res,
+	.num_resources = ARRAY_SIZE(telem_res),
+};
+
+static int intel_pmc_get_tco_resources(struct platform_device *pdev,
+				       struct intel_pmc_dev *pmc)
+{
+	struct itco_wdt_platform_data *pdata;
+	struct resource *res, *tco_res;
+
+	if (acpi_has_watchdog())
+		return 0;
+
+	res = platform_get_resource(pdev, IORESOURCE_IO,
+				    PLAT_RESOURCE_ACPI_IO_INDEX);
+	if (!res) {
+		dev_err(&pdev->dev, "Failed to get IO resource\n");
+		return -EINVAL;
+	}
+
+	tco_res = devm_kcalloc(&pdev->dev, 2, sizeof(*tco_res), GFP_KERNEL);
+	if (!tco_res)
+		return -ENOMEM;
+
+	tco_res[0].flags = IORESOURCE_IO;
+	tco_res[0].start = res->start + TCO_BASE_OFFSET;
+	tco_res[0].end = tco_res[0].start + TCO_REGS_SIZE - 1;
+	tco_res[1].flags = IORESOURCE_IO;
+	tco_res[1].start = res->start + SMI_EN_OFFSET;
+	tco_res[1].end = tco_res[1].start + SMI_EN_SIZE - 1;
+
+	pmc->cells[PMC_TCO].resources = tco_res;
+	pmc->cells[PMC_TCO].num_resources = 2;
+
+	pdata = devm_kmemdup(&pdev->dev, &tco_pdata, sizeof(*pdata), GFP_KERNEL);
+	if (!pdata)
+		return -ENOMEM;
+
+	pdata->no_reboot_priv = pmc;
+	pmc->cells[PMC_TCO].platform_data = pdata;
+	pmc->cells[PMC_TCO].pdata_size = sizeof(*pdata);
+
+	return 0;
+}
+
+static int intel_pmc_get_resources(struct platform_device *pdev,
+				   struct intel_pmc_dev *pmc,
+				   struct intel_scu_ipc_pdata *pdata)
+{
+	struct resource *res, *punit_res;
+	struct resource gcr_res;
+	size_t npunit_res = 0;
+	int ret;
+
+	pdata->irq = platform_get_irq_optional(pdev, 0);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM,
+				    PLAT_RESOURCE_IPC_INDEX);
+	if (!res) {
+		dev_err(&pdev->dev, "Failed to get IPC resource\n");
+		return -EINVAL;
+	}
+
+	/* IPC registers */
+	pdata->mem.flags = res->flags;
+	pdata->mem.start = res->start;
+	pdata->mem.end = res->start + PLAT_RESOURCE_IPC_SIZE - 1;
+
+	/* GCR registers */
+	gcr_res.flags = res->flags;
+	gcr_res.start = res->start + PLAT_RESOURCE_GCR_OFFSET;
+	gcr_res.end = gcr_res.start + PLAT_RESOURCE_GCR_SIZE - 1;
+
+	pmc->gcr_mem_base = devm_ioremap_resource(&pdev->dev, &gcr_res);
+	if (IS_ERR(pmc->gcr_mem_base))
+		return PTR_ERR(pmc->gcr_mem_base);
+
+	pmc->cells[PMC_TCO] = tco;
+	pmc->cells[PMC_PUNIT] = punit;
+	pmc->cells[PMC_TELEM] = telem;
+
+	/* iTCO watchdog only if there is no WDAT ACPI table */
+	ret = intel_pmc_get_tco_resources(pdev, pmc);
+	if (ret)
+		return ret;
+
+	punit_res = devm_kcalloc(&pdev->dev, 6, sizeof(*punit_res), GFP_KERNEL);
+	if (!punit_res)
+		return -ENOMEM;
+
+	/* This is index 0 to cover BIOS data register */
+	res = platform_get_resource(pdev, IORESOURCE_MEM,
+				    PLAT_RESOURCE_BIOS_DATA_INDEX);
+	if (!res) {
+		dev_err(&pdev->dev, "Failed to get resource of P-unit BIOS data\n");
+		return -EINVAL;
+	}
+	punit_res[npunit_res++] = *res;
+
+	/* This is index 1 to cover BIOS interface register */
+	res = platform_get_resource(pdev, IORESOURCE_MEM,
+				    PLAT_RESOURCE_BIOS_IFACE_INDEX);
+	if (!res) {
+		dev_err(&pdev->dev, "Failed to get resource of P-unit BIOS interface\n");
+		return -EINVAL;
+	}
+	punit_res[npunit_res++] = *res;
+
+	/* This is index 2 to cover ISP data register, optional */
+	res = platform_get_resource(pdev, IORESOURCE_MEM,
+				    PLAT_RESOURCE_ISP_DATA_INDEX);
+	if (res)
+		punit_res[npunit_res++] = *res;
+
+	/* This is index 3 to cover ISP interface register, optional */
+	res = platform_get_resource(pdev, IORESOURCE_MEM,
+				    PLAT_RESOURCE_ISP_IFACE_INDEX);
+	if (res)
+		punit_res[npunit_res++] = *res;
+
+	/* This is index 4 to cover GTD data register, optional */
+	res = platform_get_resource(pdev, IORESOURCE_MEM,
+				    PLAT_RESOURCE_GTD_DATA_INDEX);
+	if (res)
+		punit_res[npunit_res++] = *res;
+
+	/* This is index 5 to cover GTD interface register, optional */
+	res = platform_get_resource(pdev, IORESOURCE_MEM,
+				    PLAT_RESOURCE_GTD_IFACE_INDEX);
+	if (res)
+		punit_res[npunit_res++] = *res;
+
+	pmc->cells[PMC_PUNIT].resources = punit_res;
+	pmc->cells[PMC_PUNIT].num_resources = npunit_res;
+
+	/* Telemetry SSRAM is optional */
+	res = platform_get_resource(pdev, IORESOURCE_MEM,
+				    PLAT_RESOURCE_TELEM_SSRAM_INDEX);
+	if (res)
+		pmc->telem_base = res;
+
+	return 0;
+}
+
+static int intel_pmc_create_devices(struct intel_pmc_dev *pmc)
+{
+	int ret;
+
+	if (pmc->cells[PMC_TCO].num_resources) {
+		ret = devm_mfd_add_devices(pmc->dev, PLATFORM_DEVID_AUTO,
+					   &pmc->cells[PMC_TCO], 1, NULL, 0, NULL);
+		if (ret)
+			return ret;
+	}
+
+	ret = devm_mfd_add_devices(pmc->dev, PLATFORM_DEVID_AUTO,
+				   &pmc->cells[PMC_PUNIT], 1, NULL, 0, NULL);
+	if (ret)
+		return ret;
+
+	if (pmc->telem_base) {
+		ret = devm_mfd_add_devices(pmc->dev, PLATFORM_DEVID_AUTO,
+					   &pmc->cells[PMC_TELEM], 1,
+					   pmc->telem_base, 0, NULL);
+	}
+
+	return ret;
+}
+
+static const struct acpi_device_id intel_pmc_acpi_ids[] = {
+	{ "INT34D2" },
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, intel_pmc_acpi_ids);
+
+static int intel_pmc_probe(struct platform_device *pdev)
+{
+	struct intel_scu_ipc_pdata pdata = {};
+	struct intel_pmc_dev *pmc;
+	int ret;
+
+	pmc = devm_kzalloc(&pdev->dev, sizeof(*pmc), GFP_KERNEL);
+	if (!pmc)
+		return -ENOMEM;
+
+	pmc->dev = &pdev->dev;
+	spin_lock_init(&pmc->gcr_lock);
+
+	ret = intel_pmc_get_resources(pdev, pmc, &pdata);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to request resources\n");
+		return ret;
+	}
+
+	pmc->scu = devm_intel_scu_ipc_register(&pdev->dev, &pdata);
+	if (IS_ERR(pmc->scu))
+		return PTR_ERR(pmc->scu);
+
+	platform_set_drvdata(pdev, pmc);
+
+	ret = intel_pmc_create_devices(pmc);
+	if (ret)
+		dev_err(&pdev->dev, "Failed to create PMC devices\n");
+
+	return ret;
+}
+
+static struct platform_driver intel_pmc_driver = {
+	.probe = intel_pmc_probe,
+	.driver = {
+		.name = "intel_pmc_bxt",
+		.acpi_match_table = intel_pmc_acpi_ids,
+		.dev_groups = intel_pmc_groups,
+	},
+};
+
+module_platform_driver(intel_pmc_driver);
+
+MODULE_AUTHOR("Mika Westerberg <mika.westerberg@linux.intel.com>");
+MODULE_AUTHOR("Zha Qipeng <qipeng.zha@intel.com>");
+MODULE_DESCRIPTION("Intel Broxton PMC driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 65eb53fc9206..91acc99a48bc 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -1261,7 +1261,8 @@ config INTEL_UNCORE_FREQ_CONTROL
 config INTEL_BXTWC_PMIC_TMU
 	tristate "Intel BXT Whiskey Cove TMU Driver"
 	depends on REGMAP
-	depends on INTEL_SOC_PMIC_BXTWC && INTEL_PMC_IPC
+	depends on MFD_INTEL_PMC_BXT
+	depends on INTEL_SOC_PMIC_BXTWC
 	---help---
 	  Select this driver to use Intel BXT Whiskey Cove PMIC TMU feature.
 	  This driver enables the alarm wakeup functionality in the TMU unit
@@ -1319,15 +1320,6 @@ config INTEL_PMC_CORE
 		- LTR Ignore
 		- MPHY/PLL gating status (Sunrisepoint PCH only)
 
-config INTEL_PMC_IPC
-	tristate "Intel PMC IPC Driver"
-	depends on ACPI
-	select INTEL_SCU_IPC
-	---help---
-	This driver provides support for PMC control on some Intel platforms.
-	The PMC is an ARC processor which defines IPC commands for communication
-	with other entities in the CPU.
-
 config INTEL_PUNIT_IPC
 	tristate "Intel P-Unit IPC Driver"
 	---help---
@@ -1366,7 +1358,9 @@ config INTEL_SCU_IPC_UTIL
 
 config INTEL_TELEMETRY
 	tristate "Intel SoC Telemetry Driver"
-	depends on INTEL_PMC_IPC && INTEL_PUNIT_IPC && X86_64
+	depends on X86_64
+	depends on MFD_INTEL_PMC_BXT
+	depends on INTEL_PUNIT_IPC
 	---help---
 	  This driver provides interfaces to configure and use
 	  telemetry for INTEL SoC from APL onwards. It is also
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index 818d81bc291b..e6edc30db352 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -137,7 +137,6 @@ obj-$(CONFIG_INTEL_MFLD_THERMAL)	+= intel_mid_thermal.o
 obj-$(CONFIG_INTEL_MID_POWER_BUTTON)	+= intel_mid_powerbtn.o
 obj-$(CONFIG_INTEL_MRFLD_PWRBTN)	+= intel_mrfld_pwrbtn.o
 obj-$(CONFIG_INTEL_PMC_CORE)		+= intel_pmc_core.o intel_pmc_core_pltdrv.o
-obj-$(CONFIG_INTEL_PMC_IPC)		+= intel_pmc_ipc.o
 obj-$(CONFIG_INTEL_PUNIT_IPC)		+= intel_punit_ipc.o
 obj-$(CONFIG_INTEL_SCU_IPC)		+= intel_scu_ipc.o
 obj-$(CONFIG_INTEL_SCU_IPC_UTIL)	+= intel_scu_ipcutil.o
diff --git a/drivers/platform/x86/intel_pmc_ipc.c b/drivers/platform/x86/intel_pmc_ipc.c
deleted file mode 100644
index c006609ef74b..000000000000
--- a/drivers/platform/x86/intel_pmc_ipc.c
+++ /dev/null
@@ -1,645 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Driver for the Intel PMC IPC mechanism
- *
- * (C) Copyright 2014-2015 Intel Corporation
- *
- * This driver is based on Intel SCU IPC driver(intel_scu_ipc.c) by
- *     Sreedhara DS <sreedhara.ds@intel.com>
- *
- * PMC running in ARC processor communicates with other entity running in IA
- * core through IPC mechanism which in turn messaging between IA core ad PMC.
- */
-
-#include <linux/acpi.h>
-#include <linux/delay.h>
-#include <linux/errno.h>
-#include <linux/interrupt.h>
-#include <linux/io-64-nonatomic-lo-hi.h>
-#include <linux/module.h>
-#include <linux/platform_device.h>
-
-#include <asm/intel_pmc_ipc.h>
-#include <asm/intel_scu_ipc.h>
-
-#include <linux/platform_data/itco_wdt.h>
-
-/* Residency with clock rate at 19.2MHz to usecs */
-#define S0IX_RESIDENCY_IN_USECS(d, s)		\
-({						\
-	u64 result = 10ull * ((d) + (s));	\
-	do_div(result, 192);			\
-	result;					\
-})
-
-/* exported resources from IFWI */
-#define PLAT_RESOURCE_IPC_INDEX		0
-#define PLAT_RESOURCE_IPC_SIZE		0x1000
-#define PLAT_RESOURCE_GCR_OFFSET	0x1000
-#define PLAT_RESOURCE_GCR_SIZE		0x1000
-#define PLAT_RESOURCE_BIOS_DATA_INDEX	1
-#define PLAT_RESOURCE_BIOS_IFACE_INDEX	2
-#define PLAT_RESOURCE_TELEM_SSRAM_INDEX	3
-#define PLAT_RESOURCE_ISP_DATA_INDEX	4
-#define PLAT_RESOURCE_ISP_IFACE_INDEX	5
-#define PLAT_RESOURCE_GTD_DATA_INDEX	6
-#define PLAT_RESOURCE_GTD_IFACE_INDEX	7
-#define PLAT_RESOURCE_ACPI_IO_INDEX	0
-
-/*
- * BIOS does not create an ACPI device for each PMC function,
- * but exports multiple resources from one ACPI device(IPC) for
- * multiple functions. This driver is responsible to create a
- * platform device and to export resources for those functions.
- */
-#define TCO_DEVICE_NAME			"iTCO_wdt"
-#define SMI_EN_OFFSET			0x40
-#define SMI_EN_SIZE			4
-#define TCO_BASE_OFFSET			0x60
-#define TCO_REGS_SIZE			16
-#define PUNIT_DEVICE_NAME		"intel_punit_ipc"
-#define TELEMETRY_DEVICE_NAME		"intel_telemetry"
-#define TELEM_SSRAM_SIZE		240
-#define TELEM_PMC_SSRAM_OFFSET		0x1B00
-#define TELEM_PUNIT_SSRAM_OFFSET	0x1A00
-#define TCO_PMC_OFFSET			0x08
-#define TCO_PMC_SIZE			0x04
-
-/* PMC register bit definitions */
-
-/* PMC_CFG_REG bit masks */
-#define PMC_CFG_NO_REBOOT_MASK		BIT_MASK(4)
-#define PMC_CFG_NO_REBOOT_EN		(1 << 4)
-#define PMC_CFG_NO_REBOOT_DIS		(0 << 4)
-
-static struct intel_pmc_ipc_dev {
-	struct device *dev;
-
-	/* The following PMC BARs share the same ACPI device with the IPC */
-	resource_size_t acpi_io_base;
-	int acpi_io_size;
-	struct platform_device *tco_dev;
-
-	/* gcr */
-	void __iomem *gcr_mem_base;
-	bool has_gcr_regs;
-	spinlock_t gcr_lock;
-
-	/* punit */
-	struct platform_device *punit_dev;
-	unsigned int punit_res_count;
-
-	/* Telemetry */
-	resource_size_t telem_pmc_ssram_base;
-	resource_size_t telem_punit_ssram_base;
-	int telem_pmc_ssram_size;
-	int telem_punit_ssram_size;
-	u8 telem_res_inval;
-	struct platform_device *telemetry_dev;
-} ipcdev;
-
-static inline u64 gcr_data_readq(u32 offset)
-{
-	return readq(ipcdev.gcr_mem_base + offset);
-}
-
-static inline int is_gcr_valid(u32 offset)
-{
-	if (!ipcdev.has_gcr_regs)
-		return -EACCES;
-
-	if (offset > PLAT_RESOURCE_GCR_SIZE)
-		return -EINVAL;
-
-	return 0;
-}
-
-/**
- * intel_pmc_gcr_read64() - Read a 64-bit PMC GCR register
- * @offset:	offset of GCR register from GCR address base
- * @data:	data pointer for storing the register output
- *
- * Reads the 64-bit PMC GCR register at given offset.
- *
- * Return:	negative value on error or 0 on success.
- */
-int intel_pmc_gcr_read64(u32 offset, u64 *data)
-{
-	int ret;
-
-	spin_lock(&ipcdev.gcr_lock);
-
-	ret = is_gcr_valid(offset);
-	if (ret < 0) {
-		spin_unlock(&ipcdev.gcr_lock);
-		return ret;
-	}
-
-	*data = readq(ipcdev.gcr_mem_base + offset);
-
-	spin_unlock(&ipcdev.gcr_lock);
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(intel_pmc_gcr_read64);
-
-/**
- * intel_pmc_gcr_update() - Update PMC GCR register bits
- * @offset:	offset of GCR register from GCR address base
- * @mask:	bit mask for update operation
- * @val:	update value
- *
- * Updates the bits of given GCR register as specified by
- * @mask and @val.
- *
- * Return:	negative value on error or 0 on success.
- */
-static int intel_pmc_gcr_update(u32 offset, u32 mask, u32 val)
-{
-	u32 new_val;
-	int ret = 0;
-
-	spin_lock(&ipcdev.gcr_lock);
-
-	ret = is_gcr_valid(offset);
-	if (ret < 0)
-		goto gcr_ipc_unlock;
-
-	new_val = readl(ipcdev.gcr_mem_base + offset);
-
-	new_val &= ~mask;
-	new_val |= val & mask;
-
-	writel(new_val, ipcdev.gcr_mem_base + offset);
-
-	new_val = readl(ipcdev.gcr_mem_base + offset);
-
-	/* check whether the bit update is successful */
-	if ((new_val & mask) != (val & mask)) {
-		ret = -EIO;
-		goto gcr_ipc_unlock;
-	}
-
-gcr_ipc_unlock:
-	spin_unlock(&ipcdev.gcr_lock);
-	return ret;
-}
-
-static int update_no_reboot_bit(void *priv, bool set)
-{
-	u32 value = set ? PMC_CFG_NO_REBOOT_EN : PMC_CFG_NO_REBOOT_DIS;
-
-	return intel_pmc_gcr_update(PMC_GCR_PMC_CFG_REG,
-				    PMC_CFG_NO_REBOOT_MASK, value);
-}
-
-static ssize_t intel_pmc_ipc_simple_cmd_store(struct device *dev,
-					      struct device_attribute *attr,
-					      const char *buf, size_t count)
-{
-	struct intel_scu_ipc_dev *scu = dev_get_drvdata(dev);
-	int subcmd;
-	int cmd;
-	int ret;
-
-	ret = sscanf(buf, "%d %d", &cmd, &subcmd);
-	if (ret != 2) {
-		dev_err(dev, "Error args\n");
-		return -EINVAL;
-	}
-
-	ret = intel_scu_ipc_dev_simple_command(scu, cmd, subcmd);
-	if (ret) {
-		dev_err(dev, "command %d error with %d\n", cmd, ret);
-		return ret;
-	}
-	return (ssize_t)count;
-}
-static DEVICE_ATTR(simplecmd, 0200, NULL, intel_pmc_ipc_simple_cmd_store);
-
-static ssize_t intel_pmc_ipc_northpeak_store(struct device *dev,
-					     struct device_attribute *attr,
-					     const char *buf, size_t count)
-{
-	struct intel_scu_ipc_dev *scu = dev_get_drvdata(dev);
-	unsigned long val;
-	int subcmd;
-	int ret;
-
-	ret = kstrtoul(buf, 0, &val);
-	if (ret)
-		return ret;
-
-	if (val)
-		subcmd = 1;
-	else
-		subcmd = 0;
-	ret = intel_scu_ipc_dev_simple_command(scu, PMC_IPC_NORTHPEAK_CTRL, subcmd);
-	if (ret) {
-		dev_err(dev, "command north %d error with %d\n", subcmd, ret);
-		return ret;
-	}
-	return (ssize_t)count;
-}
-static DEVICE_ATTR(northpeak, 0200, NULL, intel_pmc_ipc_northpeak_store);
-
-static struct attribute *intel_ipc_attrs[] = {
-	&dev_attr_northpeak.attr,
-	&dev_attr_simplecmd.attr,
-	NULL
-};
-
-static const struct attribute_group intel_ipc_group = {
-	.attrs = intel_ipc_attrs,
-};
-
-static const struct attribute_group *intel_ipc_groups[] = {
-	&intel_ipc_group,
-	NULL
-};
-
-static struct resource punit_res_array[] = {
-	/* Punit BIOS */
-	{
-		.flags = IORESOURCE_MEM,
-	},
-	{
-		.flags = IORESOURCE_MEM,
-	},
-	/* Punit ISP */
-	{
-		.flags = IORESOURCE_MEM,
-	},
-	{
-		.flags = IORESOURCE_MEM,
-	},
-	/* Punit GTD */
-	{
-		.flags = IORESOURCE_MEM,
-	},
-	{
-		.flags = IORESOURCE_MEM,
-	},
-};
-
-#define TCO_RESOURCE_ACPI_IO		0
-#define TCO_RESOURCE_SMI_EN_IO		1
-#define TCO_RESOURCE_GCR_MEM		2
-static struct resource tco_res[] = {
-	/* ACPI - TCO */
-	{
-		.flags = IORESOURCE_IO,
-	},
-	/* ACPI - SMI */
-	{
-		.flags = IORESOURCE_IO,
-	},
-};
-
-static struct itco_wdt_platform_data tco_info = {
-	.name = "Apollo Lake SoC",
-	.version = 5,
-	.no_reboot_priv = &ipcdev,
-	.update_no_reboot_bit = update_no_reboot_bit,
-};
-
-#define TELEMETRY_RESOURCE_PUNIT_SSRAM	0
-#define TELEMETRY_RESOURCE_PMC_SSRAM	1
-static struct resource telemetry_res[] = {
-	/*Telemetry*/
-	{
-		.flags = IORESOURCE_MEM,
-	},
-	{
-		.flags = IORESOURCE_MEM,
-	},
-};
-
-static int ipc_create_punit_device(void)
-{
-	struct platform_device *pdev;
-	const struct platform_device_info pdevinfo = {
-		.parent = ipcdev.dev,
-		.name = PUNIT_DEVICE_NAME,
-		.id = -1,
-		.res = punit_res_array,
-		.num_res = ipcdev.punit_res_count,
-		};
-
-	pdev = platform_device_register_full(&pdevinfo);
-	if (IS_ERR(pdev))
-		return PTR_ERR(pdev);
-
-	ipcdev.punit_dev = pdev;
-
-	return 0;
-}
-
-static int ipc_create_tco_device(void)
-{
-	struct platform_device *pdev;
-	struct resource *res;
-	const struct platform_device_info pdevinfo = {
-		.parent = ipcdev.dev,
-		.name = TCO_DEVICE_NAME,
-		.id = -1,
-		.res = tco_res,
-		.num_res = ARRAY_SIZE(tco_res),
-		.data = &tco_info,
-		.size_data = sizeof(tco_info),
-		};
-
-	res = tco_res + TCO_RESOURCE_ACPI_IO;
-	res->start = ipcdev.acpi_io_base + TCO_BASE_OFFSET;
-	res->end = res->start + TCO_REGS_SIZE - 1;
-
-	res = tco_res + TCO_RESOURCE_SMI_EN_IO;
-	res->start = ipcdev.acpi_io_base + SMI_EN_OFFSET;
-	res->end = res->start + SMI_EN_SIZE - 1;
-
-	pdev = platform_device_register_full(&pdevinfo);
-	if (IS_ERR(pdev))
-		return PTR_ERR(pdev);
-
-	ipcdev.tco_dev = pdev;
-
-	return 0;
-}
-
-static int ipc_create_telemetry_device(void)
-{
-	struct platform_device *pdev;
-	struct resource *res;
-	const struct platform_device_info pdevinfo = {
-		.parent = ipcdev.dev,
-		.name = TELEMETRY_DEVICE_NAME,
-		.id = -1,
-		.res = telemetry_res,
-		.num_res = ARRAY_SIZE(telemetry_res),
-		};
-
-	res = telemetry_res + TELEMETRY_RESOURCE_PUNIT_SSRAM;
-	res->start = ipcdev.telem_punit_ssram_base;
-	res->end = res->start + ipcdev.telem_punit_ssram_size - 1;
-
-	res = telemetry_res + TELEMETRY_RESOURCE_PMC_SSRAM;
-	res->start = ipcdev.telem_pmc_ssram_base;
-	res->end = res->start + ipcdev.telem_pmc_ssram_size - 1;
-
-	pdev = platform_device_register_full(&pdevinfo);
-	if (IS_ERR(pdev))
-		return PTR_ERR(pdev);
-
-	ipcdev.telemetry_dev = pdev;
-
-	return 0;
-}
-
-static int ipc_create_pmc_devices(void)
-{
-	int ret;
-
-	/* If we have ACPI based watchdog use that instead */
-	if (!acpi_has_watchdog()) {
-		ret = ipc_create_tco_device();
-		if (ret) {
-			dev_err(ipcdev.dev, "Failed to add tco platform device\n");
-			return ret;
-		}
-	}
-
-	ret = ipc_create_punit_device();
-	if (ret) {
-		dev_err(ipcdev.dev, "Failed to add punit platform device\n");
-		platform_device_unregister(ipcdev.tco_dev);
-		return ret;
-	}
-
-	if (!ipcdev.telem_res_inval) {
-		ret = ipc_create_telemetry_device();
-		if (ret) {
-			dev_warn(ipcdev.dev,
-				"Failed to add telemetry platform device\n");
-			platform_device_unregister(ipcdev.punit_dev);
-			platform_device_unregister(ipcdev.tco_dev);
-		}
-	}
-
-	return ret;
-}
-
-static int ipc_plat_get_res(struct platform_device *pdev,
-			    struct intel_scu_ipc_pdata *pdata)
-{
-	struct resource *res, *punit_res = punit_res_array;
-	resource_size_t start;
-	void __iomem *addr;
-	int size;
-
-	res = platform_get_resource(pdev, IORESOURCE_IO,
-				    PLAT_RESOURCE_ACPI_IO_INDEX);
-	if (!res) {
-		dev_err(&pdev->dev, "Failed to get io resource\n");
-		return -ENXIO;
-	}
-	size = resource_size(res);
-	ipcdev.acpi_io_base = res->start;
-	ipcdev.acpi_io_size = size;
-	dev_info(&pdev->dev, "io res: %pR\n", res);
-
-	ipcdev.punit_res_count = 0;
-
-	/* This is index 0 to cover BIOS data register */
-	res = platform_get_resource(pdev, IORESOURCE_MEM,
-				    PLAT_RESOURCE_BIOS_DATA_INDEX);
-	if (!res) {
-		dev_err(&pdev->dev, "Failed to get res of punit BIOS data\n");
-		return -ENXIO;
-	}
-	punit_res[ipcdev.punit_res_count++] = *res;
-	dev_info(&pdev->dev, "punit BIOS data res: %pR\n", res);
-
-	/* This is index 1 to cover BIOS interface register */
-	res = platform_get_resource(pdev, IORESOURCE_MEM,
-				    PLAT_RESOURCE_BIOS_IFACE_INDEX);
-	if (!res) {
-		dev_err(&pdev->dev, "Failed to get res of punit BIOS iface\n");
-		return -ENXIO;
-	}
-	punit_res[ipcdev.punit_res_count++] = *res;
-	dev_info(&pdev->dev, "punit BIOS interface res: %pR\n", res);
-
-	/* This is index 2 to cover ISP data register, optional */
-	res = platform_get_resource(pdev, IORESOURCE_MEM,
-				    PLAT_RESOURCE_ISP_DATA_INDEX);
-	if (res) {
-		punit_res[ipcdev.punit_res_count++] = *res;
-		dev_info(&pdev->dev, "punit ISP data res: %pR\n", res);
-	}
-
-	/* This is index 3 to cover ISP interface register, optional */
-	res = platform_get_resource(pdev, IORESOURCE_MEM,
-				    PLAT_RESOURCE_ISP_IFACE_INDEX);
-	if (res) {
-		punit_res[ipcdev.punit_res_count++] = *res;
-		dev_info(&pdev->dev, "punit ISP interface res: %pR\n", res);
-	}
-
-	/* This is index 4 to cover GTD data register, optional */
-	res = platform_get_resource(pdev, IORESOURCE_MEM,
-				    PLAT_RESOURCE_GTD_DATA_INDEX);
-	if (res) {
-		punit_res[ipcdev.punit_res_count++] = *res;
-		dev_info(&pdev->dev, "punit GTD data res: %pR\n", res);
-	}
-
-	/* This is index 5 to cover GTD interface register, optional */
-	res = platform_get_resource(pdev, IORESOURCE_MEM,
-				    PLAT_RESOURCE_GTD_IFACE_INDEX);
-	if (res) {
-		punit_res[ipcdev.punit_res_count++] = *res;
-		dev_info(&pdev->dev, "punit GTD interface res: %pR\n", res);
-	}
-
-	pdata->irq = platform_get_irq(pdev, 0);
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM,
-				    PLAT_RESOURCE_IPC_INDEX);
-	if (!res) {
-		dev_err(&pdev->dev, "Failed to get ipc resource\n");
-		return -ENXIO;
-	}
-	dev_info(&pdev->dev, "ipc res: %pR\n", res);
-
-	pdata->mem.flags = res->flags;
-	pdata->mem.start = res->start;
-	pdata->mem.end = res->start + PLAT_RESOURCE_IPC_SIZE - 1;
-
-	start = res->start + PLAT_RESOURCE_GCR_OFFSET;
-	if (!devm_request_mem_region(&pdev->dev, start, PLAT_RESOURCE_GCR_SIZE,
-				     "pmc_ipc_plat"))
-		return -EBUSY;
-
-	addr = devm_ioremap(&pdev->dev, start, PLAT_RESOURCE_GCR_SIZE);
-	if (!addr)
-		return -ENOMEM;
-
-	ipcdev.gcr_mem_base = addr;
-
-	ipcdev.telem_res_inval = 0;
-	res = platform_get_resource(pdev, IORESOURCE_MEM,
-				    PLAT_RESOURCE_TELEM_SSRAM_INDEX);
-	if (!res) {
-		dev_err(&pdev->dev, "Failed to get telemetry ssram resource\n");
-		ipcdev.telem_res_inval = 1;
-	} else {
-		ipcdev.telem_punit_ssram_base = res->start +
-						TELEM_PUNIT_SSRAM_OFFSET;
-		ipcdev.telem_punit_ssram_size = TELEM_SSRAM_SIZE;
-		ipcdev.telem_pmc_ssram_base = res->start +
-						TELEM_PMC_SSRAM_OFFSET;
-		ipcdev.telem_pmc_ssram_size = TELEM_SSRAM_SIZE;
-		dev_info(&pdev->dev, "telemetry ssram res: %pR\n", res);
-	}
-
-	return 0;
-}
-
-/**
- * intel_pmc_s0ix_counter_read() - Read S0ix residency.
- * @data: Out param that contains current S0ix residency count.
- *
- * Return: an error code or 0 on success.
- */
-int intel_pmc_s0ix_counter_read(u64 *data)
-{
-	u64 deep, shlw;
-
-	if (!ipcdev.has_gcr_regs)
-		return -EACCES;
-
-	deep = gcr_data_readq(PMC_GCR_TELEM_DEEP_S0IX_REG);
-	shlw = gcr_data_readq(PMC_GCR_TELEM_SHLW_S0IX_REG);
-
-	*data = S0IX_RESIDENCY_IN_USECS(deep, shlw);
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(intel_pmc_s0ix_counter_read);
-
-#ifdef CONFIG_ACPI
-static const struct acpi_device_id ipc_acpi_ids[] = {
-	{ "INT34D2", 0},
-	{ }
-};
-MODULE_DEVICE_TABLE(acpi, ipc_acpi_ids);
-#endif
-
-static int ipc_plat_probe(struct platform_device *pdev)
-{
-	struct intel_scu_ipc_pdata pdata = {};
-	struct intel_scu_ipc_dev *scu;
-	int ret;
-
-	ipcdev.dev = &pdev->dev;
-	spin_lock_init(&ipcdev.gcr_lock);
-
-	ret = ipc_plat_get_res(pdev, &pdata);
-	if (ret) {
-		dev_err(&pdev->dev, "Failed to request resource\n");
-		return ret;
-	}
-
-	scu = devm_intel_scu_ipc_register(&pdev->dev, &pdata);
-	if (IS_ERR(scu))
-		return PTR_ERR(scu);
-
-	platform_set_drvdata(pdev, scu);
-
-	ret = ipc_create_pmc_devices();
-	if (ret) {
-		dev_err(&pdev->dev, "Failed to create pmc devices\n");
-		return ret;
-	}
-
-	ipcdev.has_gcr_regs = true;
-
-	return 0;
-}
-
-static int ipc_plat_remove(struct platform_device *pdev)
-{
-	platform_device_unregister(ipcdev.tco_dev);
-	platform_device_unregister(ipcdev.punit_dev);
-	platform_device_unregister(ipcdev.telemetry_dev);
-	ipcdev.dev = NULL;
-	return 0;
-}
-
-static struct platform_driver ipc_plat_driver = {
-	.remove = ipc_plat_remove,
-	.probe = ipc_plat_probe,
-	.driver = {
-		.name = "pmc-ipc-plat",
-		.acpi_match_table = ACPI_PTR(ipc_acpi_ids),
-		.dev_groups = intel_ipc_groups,
-	},
-};
-
-static int __init intel_pmc_ipc_init(void)
-{
-	return platform_driver_register(&ipc_plat_driver);
-}
-
-static void __exit intel_pmc_ipc_exit(void)
-{
-	platform_driver_unregister(&ipc_plat_driver);
-}
-
-MODULE_AUTHOR("Zha Qipeng <qipeng.zha@intel.com>");
-MODULE_DESCRIPTION("Intel PMC IPC driver");
-MODULE_LICENSE("GPL v2");
-
-/* Some modules are dependent on this, so init earlier */
-fs_initcall(intel_pmc_ipc_init);
-module_exit(intel_pmc_ipc_exit);
diff --git a/drivers/platform/x86/intel_telemetry_debugfs.c b/drivers/platform/x86/intel_telemetry_debugfs.c
index 85a456aa0ab9..3a533fa22760 100644
--- a/drivers/platform/x86/intel_telemetry_debugfs.c
+++ b/drivers/platform/x86/intel_telemetry_debugfs.c
@@ -15,6 +15,7 @@
  */
 #include <linux/debugfs.h>
 #include <linux/device.h>
+#include <linux/mfd/intel_pmc_bxt.h>
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/seq_file.h>
@@ -22,7 +23,6 @@
 
 #include <asm/cpu_device_id.h>
 #include <asm/intel-family.h>
-#include <asm/intel_pmc_ipc.h>
 #include <asm/intel_telemetry.h>
 
 #define DRIVER_NAME			"telemetry_soc_debugfs"
@@ -648,10 +648,11 @@ DEFINE_SHOW_ATTRIBUTE(telem_soc_states);
 
 static int telem_s0ix_res_get(void *data, u64 *val)
 {
+	struct telemetry_plt_config *plt_config = telemetry_get_pltdata();
 	u64 s0ix_total_res;
 	int ret;
 
-	ret = intel_pmc_s0ix_counter_read(&s0ix_total_res);
+	ret = intel_pmc_s0ix_counter_read(plt_config->pmc, &s0ix_total_res);
 	if (ret) {
 		pr_err("Failed to read S0ix residency");
 		return ret;
@@ -838,12 +839,15 @@ static int pm_suspend_exit_cb(void)
 	 */
 	if (suspend_shlw_ctr_exit == suspend_shlw_ctr_temp &&
 	    suspend_deep_ctr_exit == suspend_deep_ctr_temp) {
-		ret = intel_pmc_gcr_read64(PMC_GCR_TELEM_SHLW_S0IX_REG,
+		struct telemetry_plt_config *plt_config = telemetry_get_pltdata();
+		struct intel_pmc_dev *pmc = plt_config->pmc;
+
+		ret = intel_pmc_gcr_read64(pmc, PMC_GCR_TELEM_SHLW_S0IX_REG,
 					  &suspend_shlw_res_exit);
 		if (ret < 0)
 			goto out;
 
-		ret = intel_pmc_gcr_read64(PMC_GCR_TELEM_DEEP_S0IX_REG,
+		ret = intel_pmc_gcr_read64(pmc, PMC_GCR_TELEM_DEEP_S0IX_REG,
 					  &suspend_deep_res_exit);
 		if (ret < 0)
 			goto out;
diff --git a/drivers/platform/x86/intel_telemetry_pltdrv.c b/drivers/platform/x86/intel_telemetry_pltdrv.c
index efcf214d25b1..d2aee90fb0c5 100644
--- a/drivers/platform/x86/intel_telemetry_pltdrv.c
+++ b/drivers/platform/x86/intel_telemetry_pltdrv.c
@@ -1118,6 +1118,8 @@ static int telemetry_pltdrv_probe(struct platform_device *pdev)
 
 	telm_conf = (struct telemetry_plt_config *)id->driver_data;
 
+	telm_conf->pmc = dev_get_drvdata(pdev->dev.parent);
+
 	mem = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(mem))
 		return PTR_ERR(mem);
diff --git a/drivers/usb/typec/tcpm/Kconfig b/drivers/usb/typec/tcpm/Kconfig
index 5b986d6c801d..fa3f39336246 100644
--- a/drivers/usb/typec/tcpm/Kconfig
+++ b/drivers/usb/typec/tcpm/Kconfig
@@ -41,8 +41,8 @@ config TYPEC_FUSB302
 config TYPEC_WCOVE
 	tristate "Intel WhiskeyCove PMIC USB Type-C PHY driver"
 	depends on ACPI
+	depends on MFD_INTEL_PMC_BXT
 	depends on INTEL_SOC_PMIC
-	depends on INTEL_PMC_IPC
 	depends on BXT_WC_PMIC_OPREGION
 	help
 	  This driver adds support for USB Type-C on Intel Broxton platforms
diff --git a/include/linux/mfd/intel_pmc_bxt.h b/include/linux/mfd/intel_pmc_bxt.h
new file mode 100644
index 000000000000..a5fb41910d78
--- /dev/null
+++ b/include/linux/mfd/intel_pmc_bxt.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef MFD_INTEL_PMC_BXT_H
+#define MFD_INTEL_PMC_BXT_H
+
+#include <linux/types.h>
+
+/* GCR reg offsets from GCR base */
+#define PMC_GCR_PMC_CFG_REG		0x08
+#define PMC_GCR_TELEM_DEEP_S0IX_REG	0x78
+#define PMC_GCR_TELEM_SHLW_S0IX_REG	0x80
+
+/*
+ * Pointer to the PMC device can be obtained by calling
+ * dev_get_drvdata() to the parent MFD device.
+ */
+struct intel_pmc_dev;
+
+int intel_pmc_s0ix_counter_read(struct intel_pmc_dev *pmc, u64 *data);
+int intel_pmc_gcr_read64(struct intel_pmc_dev *pmc, u32 offset, u64 *data);
+
+#endif /* MFD_INTEL_PMC_BXT_H */
-- 
2.25.0

