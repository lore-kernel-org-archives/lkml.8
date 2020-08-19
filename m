Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1994C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 07:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 765EB20738
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 07:39:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbgHSHjG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 03:39:06 -0400
Received: from mga09.intel.com ([134.134.136.24]:60300 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726685AbgHSHjB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 03:39:01 -0400
IronPort-SDR: GtNmEcsyaOYGzP9aDKtabZtadMk6fCce3PCf6iIFPKH+4XW0ahI0OuZJyAGuM3T99NJ+bIQvmH
 tGFOy4XPAcnw==
X-IronPort-AV: E=McAfee;i="6000,8403,9717"; a="156134596"
X-IronPort-AV: E=Sophos;i="5.76,330,1592895600"; 
   d="scan'208";a="156134596"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2020 00:38:57 -0700
IronPort-SDR: AS3Yjidaweo/U2jxW5LCQHs/aVrKXQa9Dq/wHr/8X2xNNBu3TPEdKlgozkyLdNmzzU37ObrOor
 ++dlbxiWZHpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,330,1592895600"; 
   d="scan'208";a="441513799"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.141])
  by orsmga004.jf.intel.com with ESMTP; 19 Aug 2020 00:38:55 -0700
From:   Xu Yilun <yilun.xu@intel.com>
To:     broonie@kernel.org, lee.jones@linaro.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, yilun.xu@intel.com,
        matthew.gerlach@linux.intel.com, russell.h.weight@intel.com,
        lgoncalv@redhat.com, hao.wu@intel.com
Subject: [PATCH v4 2/2] mfd: intel-m10-bmc: add Max10 BMC chip support for Intel FPGA PAC
Date:   Wed, 19 Aug 2020 15:34:57 +0800
Message-Id: <1597822497-25107-3-git-send-email-yilun.xu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1597822497-25107-1-git-send-email-yilun.xu@intel.com>
References: <1597822497-25107-1-git-send-email-yilun.xu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements the basic functions of the BMC chip for some Intel
FPGA PCIe Acceleration Cards (PAC). The BMC is implemented using the
intel max10 CPLD.

This BMC chip is connected to FPGA by a SPI bus. To provide direct
register access from FPGA, the "SPI slave to Avalon Master Bridge"
(spi-avmm) IP is integrated in the chip. It converts encoded streams of
bytes from the host to the internal register read/write on Avalon bus.
So This driver uses the regmap-spi-avmm for register accessing.

Signed-off-by: Xu Yilun <yilun.xu@intel.com>
Signed-off-by: Wu Hao <hao.wu@intel.com>
Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
Signed-off-by: Russ Weight <russell.h.weight@intel.com>
Reviewed-by: Tom Rix <trix@redhat.com>
---
v2: Split out the regmap-spi-avmm part.
    Rename the file intel-m10-bmc-main.c to intel-m10-bmc.c, cause
     there is only one source file left for this module now.
v3: add the sub devices in mfd_cell.
    some minor fixes.
v4: no change.
---
 .../ABI/testing/sysfs-driver-intel-m10-bmc         |  15 ++
 drivers/mfd/Kconfig                                |  13 ++
 drivers/mfd/Makefile                               |   2 +
 drivers/mfd/intel-m10-bmc.c                        | 169 +++++++++++++++++++++
 include/linux/mfd/intel-m10-bmc.h                  |  57 +++++++
 5 files changed, 256 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-intel-m10-bmc
 create mode 100644 drivers/mfd/intel-m10-bmc.c
 create mode 100644 include/linux/mfd/intel-m10-bmc.h

diff --git a/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc b/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc
new file mode 100644
index 0000000..979a2d6
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc
@@ -0,0 +1,15 @@
+What:		/sys/bus/spi/devices/.../bmc_version
+Date:		June 2020
+KernelVersion:	5.10
+Contact:	Xu Yilun <yilun.xu@intel.com>
+Description:	Read only. Returns the hardware build version of Intel
+		MAX10 BMC chip.
+		Format: "0x%x".
+
+What:		/sys/bus/spi/devices/.../bmcfw_version
+Date:		June 2020
+KernelVersion:	5.10
+Contact:	Xu Yilun <yilun.xu@intel.com>
+Description:	Read only. Returns the firmware version of Intel MAX10
+		BMC chip.
+		Format: "0x%x".
diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 33df083..57745f5 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -2118,5 +2118,18 @@ config SGI_MFD_IOC3
 	  If you have an SGI Origin, Octane, or a PCI IOC3 card,
 	  then say Y. Otherwise say N.
 
+config MFD_INTEL_M10_BMC
+	tristate "Intel MAX10 Board Management Controller"
+	depends on SPI_MASTER
+	select REGMAP_SPI_AVMM
+	select MFD_CORE
+	help
+	  Support for the Intel MAX10 board management controller using the
+	  SPI interface.
+
+	  This driver provides common support for accessing the device,
+	  additional drivers must be enabled in order to use the functionality
+	  of the device.
+
 endmenu
 endif
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index a60e5f8..dd2cc7b 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -264,3 +264,5 @@ obj-$(CONFIG_MFD_STMFX) 	+= stmfx.o
 obj-$(CONFIG_MFD_KHADAS_MCU) 	+= khadas-mcu.o
 
 obj-$(CONFIG_SGI_MFD_IOC3)	+= ioc3.o
+
+obj-$(CONFIG_MFD_INTEL_M10_BMC)   += intel-m10-bmc.o
diff --git a/drivers/mfd/intel-m10-bmc.c b/drivers/mfd/intel-m10-bmc.c
new file mode 100644
index 0000000..0dfd73a
--- /dev/null
+++ b/drivers/mfd/intel-m10-bmc.c
@@ -0,0 +1,169 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Intel Max10 Board Management Controller chip
+ *
+ * Copyright (C) 2018-2020 Intel Corporation. All rights reserved.
+ *
+ */
+#include <linux/bitfield.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/mfd/core.h>
+#include <linux/mfd/intel-m10-bmc.h>
+#include <linux/mutex.h>
+#include <linux/regmap.h>
+#include <linux/spi/spi.h>
+
+enum m10bmc_type {
+	M10_N3000,
+};
+
+static struct mfd_cell m10bmc_pacn3000_subdevs[] = {
+	{
+		.name = "n3000bmc-hwmon",
+	},
+	{
+		.name = "n3000bmc-pkvl",
+	},
+	{
+		.name = "m10bmc-secure",
+	},
+
+};
+
+static struct regmap_config intel_m10bmc_regmap_config = {
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_stride = 4,
+	.max_register = M10BMC_MEM_END,
+};
+
+static ssize_t bmc_version_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct intel_m10bmc *m10bmc = dev_get_drvdata(dev);
+	unsigned int val;
+	int ret;
+
+	ret = m10bmc_sys_read(m10bmc, M10BMC_BUILD_VER, &val);
+	if (ret)
+		return ret;
+
+	return sprintf(buf, "0x%x\n", val);
+}
+static DEVICE_ATTR_RO(bmc_version);
+
+static ssize_t bmcfw_version_show(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	struct intel_m10bmc *max10 = dev_get_drvdata(dev);
+	unsigned int val;
+	int ret;
+
+	ret = m10bmc_sys_read(max10, NIOS2_FW_VERSION, &val);
+	if (ret)
+		return ret;
+
+	return sprintf(buf, "0x%x\n", val);
+}
+static DEVICE_ATTR_RO(bmcfw_version);
+
+static struct attribute *m10bmc_attrs[] = {
+	&dev_attr_bmc_version.attr,
+	&dev_attr_bmcfw_version.attr,
+	NULL,
+};
+
+static struct attribute_group m10bmc_attr_group = {
+	.attrs = m10bmc_attrs,
+};
+
+static const struct attribute_group *m10bmc_dev_groups[] = {
+	&m10bmc_attr_group,
+	NULL
+};
+
+static int check_m10bmc_version(struct intel_m10bmc *m10bmc)
+{
+	unsigned int v;
+
+	if (m10bmc_raw_read(m10bmc, M10BMC_LEGACY_SYS_BASE + M10BMC_BUILD_VER,
+			    &v))
+		return -ENODEV;
+
+	if (v != 0xffffffff) {
+		dev_err(m10bmc->dev, "bad version M10BMC detected\n");
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static int intel_m10_bmc_spi_probe(struct spi_device *spi)
+{
+	const struct spi_device_id *id = spi_get_device_id(spi);
+	struct device *dev = &spi->dev;
+	struct mfd_cell *cells;
+	struct intel_m10bmc *m10bmc;
+	int ret, n_cell;
+
+	m10bmc = devm_kzalloc(dev, sizeof(*m10bmc), GFP_KERNEL);
+	if (!m10bmc)
+		return -ENOMEM;
+
+	m10bmc->dev = dev;
+
+	m10bmc->regmap =
+		devm_regmap_init_spi_avmm(spi, &intel_m10bmc_regmap_config);
+	if (IS_ERR(m10bmc->regmap)) {
+		ret = PTR_ERR(m10bmc->regmap);
+		dev_err(dev, "Failed to allocate regmap: %d\n", ret);
+		return ret;
+	}
+
+	spi_set_drvdata(spi, m10bmc);
+
+	ret = check_m10bmc_version(m10bmc);
+	if (ret) {
+		dev_err(dev, "Failed to identify m10bmc hardware\n");
+		return ret;
+	}
+
+	switch (id->driver_data) {
+	case M10_N3000:
+		cells = m10bmc_pacn3000_subdevs;
+		n_cell = ARRAY_SIZE(m10bmc_pacn3000_subdevs);
+		break;
+	default:
+		return -ENODEV;
+	}
+
+	ret = devm_mfd_add_devices(dev, PLATFORM_DEVID_AUTO, cells, n_cell,
+				   NULL, 0, NULL);
+	if (ret)
+		dev_err(dev, "Failed to register sub-devices: %d\n", ret);
+
+	return ret;
+}
+
+static const struct spi_device_id m10bmc_spi_id[] = {
+	{ "m10-n3000", M10_N3000 },
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, m10bmc_spi_id);
+
+static struct spi_driver intel_m10bmc_spi_driver = {
+	.driver = {
+		.name = "intel-m10-bmc",
+		.dev_groups = m10bmc_dev_groups,
+	},
+	.probe = intel_m10_bmc_spi_probe,
+	.id_table = m10bmc_spi_id,
+};
+
+module_spi_driver(intel_m10bmc_spi_driver);
+
+MODULE_DESCRIPTION("Intel Max10 BMC Device Driver");
+MODULE_AUTHOR("Intel Corporation");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("spi:intel-m10-bmc");
diff --git a/include/linux/mfd/intel-m10-bmc.h b/include/linux/mfd/intel-m10-bmc.h
new file mode 100644
index 0000000..4979756
--- /dev/null
+++ b/include/linux/mfd/intel-m10-bmc.h
@@ -0,0 +1,57 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Driver Header File for Intel Max10 Board Management Controller chip.
+ *
+ * Copyright (C) 2018-2020 Intel Corporation, Inc.
+ *
+ */
+#ifndef __INTEL_M10_BMC_H
+#define __INTEL_M10_BMC_H
+
+#include <linux/regmap.h>
+
+#define M10BMC_LEGACY_SYS_BASE	0x300400
+#define M10BMC_SYS_BASE		0x300800
+#define M10BMC_MEM_END		0x200000fc
+
+/* Register offset of system registers */
+#define NIOS2_FW_VERSION	0x0
+#define M10BMC_TEST_REG		0x3c
+#define M10BMC_BUILD_VER	0x68
+#define M10BMC_VER_MAJOR_MSK	GENMASK(23, 16)
+#define M10BMC_VER_PCB_INFO_MSK	GENMASK(31, 24)
+
+/**
+ * struct intel_m10bmc - Intel Max10 BMC MFD device private data structure
+ * @dev: this device
+ * @regmap: the regmap used to access registers by m10bmc itself
+ */
+struct intel_m10bmc {
+	struct device *dev;
+	struct regmap *regmap;
+};
+
+/*
+ * register access helper functions.
+ *
+ * m10bmc_raw_read - read m10bmc register per addr
+ * m10bmc_sys_read - read m10bmc system register per offset
+ */
+static inline int
+m10bmc_raw_read(struct intel_m10bmc *m10bmc, unsigned int addr,
+		unsigned int *val)
+{
+	int ret;
+
+	ret = regmap_read(m10bmc->regmap, addr, val);
+	if (ret)
+		dev_err(m10bmc->dev, "fail to read raw reg %x: %d\n",
+			addr, ret);
+
+	return ret;
+}
+
+#define m10bmc_sys_read(m10bmc, offset, val) \
+	m10bmc_raw_read(m10bmc, M10BMC_SYS_BASE + (offset), val)
+
+#endif /* __INTEL_M10_BMC_H */
-- 
2.7.4

