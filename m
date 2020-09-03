Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF35FC433E9
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 16:18:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8A1820775
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 16:18:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=eclypsium.com header.i=@eclypsium.com header.b="QoXzJgux"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728468AbgICQSQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 12:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbgICQSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 12:18:15 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47EF9C061244
        for <linux-kernel@vger.kernel.org>; Thu,  3 Sep 2020 09:18:15 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id z2so2300023qtv.12
        for <linux-kernel@vger.kernel.org>; Thu, 03 Sep 2020 09:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eL4Q/DniRhGPVEX39OxUWpITk9reYSD7n2NfjjFzzu0=;
        b=QoXzJguxJEc5aw9wGXwidtTFQmYRUecSWU3yVWKUTDqU8JS36R0Nu8+0wxAbHxQzAw
         l7x12w2h3Y4zETSgWk1EPr/bXWBSlqamLFPxohoaJ2Of9A4ROvp8RrIHpIn9psgaMRMK
         Ky0YR9Myvt0Awk3KsGQt+b3iIjbm++LWGG3O8IVLYCMiMEwJ59dqZz71ZHVex56puahl
         h9/jWBz3tEiBAegrcYVQ+5+fxNodJdiELmh02WtCUACWdHkcB5syk09oRXk6ldaz94fu
         VLJJWWV+u7a9YsosFrBK4yCJ51pUA0mxcNYMC4+c9tXTdsRmx74rBClrY8mUsFNXOMav
         BfnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eL4Q/DniRhGPVEX39OxUWpITk9reYSD7n2NfjjFzzu0=;
        b=W312ib+1CMi6Klc41NqLVCJ7OmZAt4i2PRFN2BxCU2zaU9LYnzbJP8bJH6DqsPtxoZ
         f3ZUYsBpkMYaM2hOH5KPrZ1vS6TBep9YebchxNnC/FkFFcckjQul8BQTCd4ETFdt4AlB
         oFjLphAoMmrD9BI2Wl8mXONE8UvOWUT2aKTDRUnqnIOHy6Unx6RhA8yrPIqcxfb0paYL
         RL1Sac1C65QAS25KJrSXrGgHtf0ZTE69YOTilzJf1nxWahSM4H/8sWFAX3blJSDng1TV
         xte5RPz5ivGgl617QnvwIa0J4+hGr1XOhgYuMqYc5Dcs4iB43giX/7NnIeuv6MFFMGO/
         w25Q==
X-Gm-Message-State: AOAM530oPYP7b18lcX3C9S6Zjapg6t82O1kl9+O3JXFjwBXdJR4Qs6Xk
        dJK3lzT90QymBgUwAzy2Ws9Z4g==
X-Google-Smtp-Source: ABdhPJw3DckKa8yzfnVtOGS3ousFJJCchuizOjGnDP42qU6LT6PO3qjHHgxqJtkiIoPjAty5jITDmg==
X-Received: by 2002:ac8:409e:: with SMTP id p30mr4147174qtl.208.1599149893606;
        Thu, 03 Sep 2020 09:18:13 -0700 (PDT)
Received: from localhost ([190.190.138.51])
        by smtp.gmail.com with ESMTPSA id d9sm2500497qkj.83.2020.09.03.09.18.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2020 09:18:13 -0700 (PDT)
From:   Daniel Gutson <daniel.gutson@eclypsium.com>
To:     Daniel Gutson <daniel.gutson@eclypsium.com>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Richard Hughes <hughsient@gmail.com>,
        Alex Bazhaniuk <alex@eclypsium.com>
Subject: [PATCH] Platform integrity information in sysfs
Date:   Thu,  3 Sep 2020 13:18:04 -0300
Message-Id: <20200903161804.403299-1-daniel.gutson@eclypsium.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch exports information about the platform integrity
firmware configuration in the sysfs filesystem.
In this initial patch, I include some configuration attributes
for the system SPI chip.

This initial version exports the BIOS Write Enable (bioswe),
BIOS Lock Enable (ble), and the SMM BIOS Write Protect (SMM_BWP)
fields of the BIOS Control register. The idea is to keep adding more
flags, not only from the BC but also from other registers in following
versions.

The goal is that the attributes are avilable to fwupd when SecureBoot
is turned on.

The patch provides a new misc driver, as proposed in the previous patch,
that provides a registration function for HW Driver devices to register
class_attributes.
In this case, the intel SPI flash chip (intel-spi) registers three
class_attributes corresponding to the fields mentioned above.

This version of the patch provides a new API supporting regular
device attributes rather than custom attributes, and also avoids
a race condition when exporting the driver sysfs dir and the
attributes files inside it.
Also, this patch renames 'platform lockdown' by 'platform integrity'.

Signed-off-by: Daniel Gutson <daniel.gutson@eclypsium.com>
---
 .../ABI/stable/sysfs-class-platform-integrity | 23 +++++
 MAINTAINERS                                   |  7 ++
 drivers/misc/Kconfig                          | 11 +++
 drivers/misc/Makefile                         |  1 +
 drivers/misc/platform-integrity.c             | 61 +++++++++++++
 drivers/mtd/spi-nor/controllers/Kconfig       |  1 +
 .../mtd/spi-nor/controllers/intel-spi-pci.c   | 64 ++++++++++++-
 .../spi-nor/controllers/intel-spi-platform.c  |  2 +-
 drivers/mtd/spi-nor/controllers/intel-spi.c   | 89 ++++++++++++++++++-
 drivers/mtd/spi-nor/controllers/intel-spi.h   |  5 +-
 include/linux/platform-integrity.h            | 20 +++++
 11 files changed, 278 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/ABI/stable/sysfs-class-platform-integrity
 create mode 100644 drivers/misc/platform-integrity.c
 create mode 100644 include/linux/platform-integrity.h

diff --git a/Documentation/ABI/stable/sysfs-class-platform-integrity b/Documentation/ABI/stable/sysfs-class-platform-integrity
new file mode 100644
index 000000000000..b31ec051ca48
--- /dev/null
+++ b/Documentation/ABI/stable/sysfs-class-platform-integrity
@@ -0,0 +1,23 @@
+What:		/sys/class/platform-integrity/intel-spi/bioswe
+Date:		September 2020
+KernelVersion:	5.9.1
+Contact:	Daniel Gutson <daniel.gutson@eclypsium.com>
+Description:	If the system firmware set BIOS Write Enable.
+		0: writes disabled, 1: writes enabled.
+Users:		https://github.com/fwupd/fwupd
+
+What:		/sys/class/platform-integrity/intel-spi/ble
+Date:		September 2020
+KernelVersion:	5.9.1
+Contact:	Daniel Gutson <daniel.gutson@eclypsium.com>
+Description:	If the system firmware set BIOS Lock Enable.
+		0: SMM lock disabled, 1: SMM lock enabled.
+Users:		https://github.com/fwupd/fwupd
+
+What:		/sys/class/platform-integrity/intel-spi/smm_bwp
+Date:		September 2020
+KernelVersion:	5.9.1
+Contact:	Daniel Gutson <daniel.gutson@eclypsium.com>
+Description:	If the system firmware set SMM BIOS Write Protect.
+		0: writes disabled unless in SMM, 1: writes enabled.
+Users:		https://github.com/fwupd/fwupd
diff --git a/MAINTAINERS b/MAINTAINERS
index e4647c84c987..771eaf715427 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13744,6 +13744,13 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/iio/chemical/plantower,pms7003.yaml
 F:	drivers/iio/chemical/pms7003.c
 
+PLATFORM INTEGRITY DATA MODULE
+M:	Daniel Gutson <daniel.gutson@eclypsium.com>
+S:	Supported
+F:	Documentation/ABI/sysfs-class-platform-integrity
+F:	drivers/misc/platform-integrity.c
+F:	include/linux/platform-integrity.h
+
 PLDMFW LIBRARY
 M:	Jacob Keller <jacob.e.keller@intel.com>
 S:	Maintained
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index ce136d685d14..d5d0de5b5706 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -456,6 +456,17 @@ config PVPANIC
 	  a paravirtualized device provided by QEMU; it lets a virtual machine
 	  (guest) communicate panic events to the host.
 
+config PLATFORM_INTEGRITY_ATTRS
+	tristate "Platform integrity information in the sysfs"
+	depends on SYSFS
+	help
+	  This kernel module is a helper driver to provide information about
+	  platform integrity settings and configuration.
+	  This module is used by other device drivers -such as the intel-spi-
+	  to publish the information in /sys/class/platform-integrity which is
+	  consumed by software such as fwupd which can verify the platform
+	  has been configured in a secure way.
+
 source "drivers/misc/c2port/Kconfig"
 source "drivers/misc/eeprom/Kconfig"
 source "drivers/misc/cb710/Kconfig"
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index c7bd01ac6291..7224019bad51 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -57,3 +57,4 @@ obj-$(CONFIG_PVPANIC)   	+= pvpanic.o
 obj-$(CONFIG_HABANA_AI)		+= habanalabs/
 obj-$(CONFIG_UACCE)		+= uacce/
 obj-$(CONFIG_XILINX_SDFEC)	+= xilinx_sdfec.o
+obj-$(CONFIG_PLATFORM_INTEGRITY_ATTRS)	+= platform-integrity.o
diff --git a/drivers/misc/platform-integrity.c b/drivers/misc/platform-integrity.c
new file mode 100644
index 000000000000..c699c5dc02ed
--- /dev/null
+++ b/drivers/misc/platform-integrity.c
@@ -0,0 +1,61 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Platform integrity data kernel module
+ *
+ * Copyright (C) 2020 Daniel Gutson <daniel.gutson@eclypsium.com>
+ * Copyright (C) 2020 Eclypsium Inc.
+ */
+#include <linux/sysfs.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/kdev_t.h>
+#include <linux/platform-integrity.h>
+
+static struct class platform_integrity_class = {
+	.name = "platform-integrity",
+	.owner = THIS_MODULE,
+};
+
+struct device *create_platform_integrity_device(
+	struct device *parent,
+	const char *name,
+	const struct attribute_group **groups)
+{
+	return device_create_with_groups(&platform_integrity_class,
+					 parent,
+					 MKDEV(0, 0),
+					 groups,
+					 groups,
+					 "%s", name);
+}
+EXPORT_SYMBOL_GPL(create_platform_integrity_device);
+
+void destroy_platform_integrity_device(struct device *pi_device)
+{
+	device_remove_groups(pi_device,
+			    (const struct attribute_group **)dev_get_drvdata(
+				pi_device));
+	device_unregister(pi_device);
+}
+EXPORT_SYMBOL_GPL(destroy_platform_integrity_device);
+
+static int __init platform_integrity_init(void)
+{
+	int status;
+
+	status = class_register(&platform_integrity_class);
+	if (status < 0)
+		return status;
+
+	return 0;
+}
+
+static void __exit platform_integrity_exit(void)
+{
+	class_unregister(&platform_integrity_class);
+}
+
+module_init(platform_integrity_init);
+module_exit(platform_integrity_exit);
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Daniel Gutson <daniel.gutson@eclypsium.com>");
diff --git a/drivers/mtd/spi-nor/controllers/Kconfig b/drivers/mtd/spi-nor/controllers/Kconfig
index 5c0e0ec2e6d1..113e349a826b 100644
--- a/drivers/mtd/spi-nor/controllers/Kconfig
+++ b/drivers/mtd/spi-nor/controllers/Kconfig
@@ -29,6 +29,7 @@ config SPI_NXP_SPIFI
 
 config SPI_INTEL_SPI
 	tristate
+	select PLATFORM_INTEGRITY_ATTRS
 
 config SPI_INTEL_SPI_PCI
 	tristate "Intel PCH/PCU SPI flash PCI driver (DANGEROUS)"
diff --git a/drivers/mtd/spi-nor/controllers/intel-spi-pci.c b/drivers/mtd/spi-nor/controllers/intel-spi-pci.c
index c72aa1ab71ad..e1bca8aedf7c 100644
--- a/drivers/mtd/spi-nor/controllers/intel-spi-pci.c
+++ b/drivers/mtd/spi-nor/controllers/intel-spi-pci.c
@@ -10,11 +10,19 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/pci.h>
+#include <linux/platform-integrity.h>
 
 #include "intel-spi.h"
 
 #define BCR		0xdc
 #define BCR_WPD		BIT(0)
+#define BCR_BLE		BIT(1)
+#define BCR_SMM_BWP	BIT(5)
+
+struct cnl_spi_attr {
+	struct device_attribute dev_attr;
+	u32 mask;
+};
 
 static const struct intel_spi_boardinfo bxt_info = {
 	.type = INTEL_SPI_BXT,
@@ -24,6 +32,59 @@ static const struct intel_spi_boardinfo cnl_info = {
 	.type = INTEL_SPI_CNL,
 };
 
+static ssize_t cnl_spi_attr_show(struct device *dev,
+	struct device_attribute *attr, char *buf, u32 mask)
+{
+	u32 bcr;
+
+	if (dev->parent == NULL)
+		return -EIO;
+
+	if (pci_read_config_dword(container_of(dev->parent, struct pci_dev, dev),
+				BCR, &bcr) != PCIBIOS_SUCCESSFUL)
+		return -EIO;
+
+	return sprintf(buf, "%d\n", (int)!!(bcr & mask));
+}
+
+static ssize_t bioswe_show(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	return cnl_spi_attr_show(dev, attr, buf, BCR_WPD);
+}
+static DEVICE_ATTR_RO(bioswe);
+
+static ssize_t ble_show(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	return cnl_spi_attr_show(dev, attr, buf, BCR_BLE);
+}
+static DEVICE_ATTR_RO(ble);
+
+static ssize_t smm_bwp_show(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	return cnl_spi_attr_show(dev, attr, buf, BCR_SMM_BWP);
+}
+static DEVICE_ATTR_RO(smm_bwp);
+
+static struct attribute *cnl_attrs[] = {
+	&dev_attr_bioswe.attr,
+	&dev_attr_ble.attr,
+	&dev_attr_smm_bwp.attr,
+	NULL
+};
+ATTRIBUTE_GROUPS(cnl);
+
+static struct device *register_local_platform_integrity_device(
+	struct device *parent, enum intel_spi_type type)
+{
+	return create_platform_integrity_device(
+		parent,
+		"intel-spi",
+		cnl_groups);
+}
+
 static int intel_spi_pci_probe(struct pci_dev *pdev,
 			       const struct pci_device_id *id)
 {
@@ -50,7 +111,8 @@ static int intel_spi_pci_probe(struct pci_dev *pdev,
 	}
 	info->writeable = !!(bcr & BCR_WPD);
 
-	ispi = intel_spi_probe(&pdev->dev, &pdev->resource[0], info);
+	ispi = intel_spi_probe(&pdev->dev, &pdev->resource[0], info,
+		register_local_platform_integrity_device);
 	if (IS_ERR(ispi))
 		return PTR_ERR(ispi);
 
diff --git a/drivers/mtd/spi-nor/controllers/intel-spi-platform.c b/drivers/mtd/spi-nor/controllers/intel-spi-platform.c
index f80f1086f928..5b1a9989426a 100644
--- a/drivers/mtd/spi-nor/controllers/intel-spi-platform.c
+++ b/drivers/mtd/spi-nor/controllers/intel-spi-platform.c
@@ -23,7 +23,7 @@ static int intel_spi_platform_probe(struct platform_device *pdev)
 		return -EINVAL;
 
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	ispi = intel_spi_probe(&pdev->dev, mem, info);
+	ispi = intel_spi_probe(&pdev->dev, mem, info, NULL);
 	if (IS_ERR(ispi))
 		return PTR_ERR(ispi);
 
diff --git a/drivers/mtd/spi-nor/controllers/intel-spi.c b/drivers/mtd/spi-nor/controllers/intel-spi.c
index b54a56a68100..71f7b917d93a 100644
--- a/drivers/mtd/spi-nor/controllers/intel-spi.c
+++ b/drivers/mtd/spi-nor/controllers/intel-spi.c
@@ -16,6 +16,7 @@
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/spi-nor.h>
 #include <linux/platform_data/intel-spi.h>
+#include <linux/platform-integrity.h>
 
 #include "intel-spi.h"
 
@@ -95,6 +96,8 @@
 #define BYT_SSFSTS_CTL			0x90
 #define BYT_BCR				0xfc
 #define BYT_BCR_WPD			BIT(0)
+#define BYT_BCR_BLE			BIT(1)
+#define BYT_BCR_SMM_BWP			BIT(5)
 #define BYT_FREG_NUM			5
 #define BYT_PR_NUM			5
 
@@ -157,6 +160,7 @@ struct intel_spi {
 	bool erase_64k;
 	u8 atomic_preopcode;
 	u8 opcodes[8];
+	struct device *platform_integrity_device;
 };
 
 static bool writeable;
@@ -305,7 +309,68 @@ static int intel_spi_wait_sw_busy(struct intel_spi *ispi)
 				  INTEL_SPI_TIMEOUT * 1000);
 }
 
-static int intel_spi_init(struct intel_spi *ispi)
+static ssize_t byt_spi_attr_show(struct device *dev,
+	struct device_attribute *attr, char *buf, u32 mask)
+{
+	u32 bcr;
+	struct intel_spi *ispi;
+
+	if (dev->parent == NULL)
+		return -EIO;
+
+	ispi = dev_get_drvdata(dev->parent);
+
+	bcr = readl(ispi->base + BYT_BCR);
+	return sprintf(buf, "%d\n", (int)!!(bcr & mask));
+}
+
+static ssize_t bioswe_show(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	return byt_spi_attr_show(dev, attr, buf, BYT_BCR_WPD);
+}
+static DEVICE_ATTR_RO(bioswe);
+
+static ssize_t ble_show(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	return byt_spi_attr_show(dev, attr, buf, BYT_BCR_BLE);
+}
+static DEVICE_ATTR_RO(ble);
+
+static ssize_t smm_bwp_show(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	return byt_spi_attr_show(dev, attr, buf, BYT_BCR_SMM_BWP);
+}
+static DEVICE_ATTR_RO(smm_bwp);
+
+static struct attribute *byt_attrs[] = {
+	&dev_attr_bioswe.attr,
+	&dev_attr_ble.attr,
+	&dev_attr_smm_bwp.attr,
+	NULL
+};
+ATTRIBUTE_GROUPS(byt);
+
+static struct device *register_local_platform_integrity_device(
+	struct device *parent, enum intel_spi_type type)
+{
+	switch (type) {
+	case INTEL_SPI_BYT:
+		return create_platform_integrity_device(
+			parent,
+			"intel-spi",
+			byt_groups);
+
+	default:
+		return NULL;
+	}
+}
+
+static int intel_spi_init(struct intel_spi *ispi,
+	struct device *(*register_platform_integrity_cb)(struct device *parent,
+		enum intel_spi_type type))
 {
 	u32 opmenu0, opmenu1, lvscc, uvscc, val;
 	int i;
@@ -422,6 +487,15 @@ static int intel_spi_init(struct intel_spi *ispi)
 
 	intel_spi_dump_regs(ispi);
 
+	if (register_platform_integrity_cb == NULL)
+		register_platform_integrity_cb =
+		register_local_platform_integrity_device;
+	ispi->platform_integrity_device = register_platform_integrity_cb(
+		ispi->dev,
+		ispi->info->type);
+	if (IS_ERR(ispi->platform_integrity_device))
+		ispi->platform_integrity_device = NULL;
+
 	return 0;
 }
 
@@ -904,7 +978,9 @@ static const struct spi_nor_controller_ops intel_spi_controller_ops = {
 };
 
 struct intel_spi *intel_spi_probe(struct device *dev,
-	struct resource *mem, const struct intel_spi_boardinfo *info)
+	struct resource *mem, const struct intel_spi_boardinfo *info,
+	struct device *(*register_platform_integrity_cb)(struct device *parent,
+		enum intel_spi_type type))
 {
 	const struct spi_nor_hwcaps hwcaps = {
 		.mask = SNOR_HWCAPS_READ |
@@ -930,7 +1006,7 @@ struct intel_spi *intel_spi_probe(struct device *dev,
 	ispi->info = info;
 	ispi->writeable = info->writeable;
 
-	ret = intel_spi_init(ispi);
+	ret = intel_spi_init(ispi, register_platform_integrity_cb);
 	if (ret)
 		return ERR_PTR(ret);
 
@@ -960,6 +1036,13 @@ EXPORT_SYMBOL_GPL(intel_spi_probe);
 
 int intel_spi_remove(struct intel_spi *ispi)
 {
+	if (ispi->platform_integrity_device != NULL) {
+		destroy_platform_integrity_device(
+			ispi->platform_integrity_device);
+
+		ispi->platform_integrity_device = NULL;
+	}
+
 	return mtd_device_unregister(&ispi->nor.mtd);
 }
 EXPORT_SYMBOL_GPL(intel_spi_remove);
diff --git a/drivers/mtd/spi-nor/controllers/intel-spi.h b/drivers/mtd/spi-nor/controllers/intel-spi.h
index e2f41b8827bf..9ddf4a002e9e 100644
--- a/drivers/mtd/spi-nor/controllers/intel-spi.h
+++ b/drivers/mtd/spi-nor/controllers/intel-spi.h
@@ -15,7 +15,10 @@ struct intel_spi;
 struct resource;
 
 struct intel_spi *intel_spi_probe(struct device *dev,
-	struct resource *mem, const struct intel_spi_boardinfo *info);
+	struct resource *mem, const struct intel_spi_boardinfo *info,
+	struct device *(*register_platform_integrity_cb)(struct device *parent,
+		enum intel_spi_type type));
+
 int intel_spi_remove(struct intel_spi *ispi);
 
 #endif /* INTEL_SPI_H */
diff --git a/include/linux/platform-integrity.h b/include/linux/platform-integrity.h
new file mode 100644
index 000000000000..a16d0f902345
--- /dev/null
+++ b/include/linux/platform-integrity.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Platform integrity data kernel module
+ *
+ * Copyright (C) 2020 Daniel Gutson <daniel.gutson@eclypsium.com>
+ * Copyright (C) 2020 Eclypsium Inc.
+ */
+#ifndef PLATFORM_INTEGRITY_H
+#define PLATFORM_INTEGRITY_H
+
+#include <linux/device.h>
+
+extern struct device *create_platform_integrity_device(
+	struct device *parent,
+	const char *name,
+	const struct attribute_group **groups);
+
+extern void destroy_platform_integrity_device(struct device *pi_device);
+
+#endif /* PLATFORM_INTEGRITY_H */
-- 
2.25.1

