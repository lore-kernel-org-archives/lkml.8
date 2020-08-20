Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69BDFC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 14:51:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 319DC2075E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 14:51:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=eclypsium.com header.i=@eclypsium.com header.b="KGnFzaCJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbgHTOvh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 10:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbgHTOv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 10:51:27 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C23C061385
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 07:51:26 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id i20so1721124qkk.8
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 07:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EjJ01IjtmxevFQQ7zQg+vmwVtLzMJMtCRp/LYGMtBVs=;
        b=KGnFzaCJftujS+CaDsYegh4xUxuqAaY6doJZcy3jbF9cVBzg+tKa9W419XxClVPaRR
         frp4RjSY6Y+Y7svb9hDtK1PJybAMC1b8FbQC6Lb9+F1bF07ivXzL462UdckR1TQl/VQE
         X/QmGAieWso2O1MPspfZPESeA6t+6uTHnqlOfaO9k58ozeF9k1Y3+5jMQeRQc8HbQw+0
         wIyF3ockxBlRpWHG0Hhl8B1WMCCF27B3Kf7XFRYVpX3xiPLjlb2sW0019J1djr7d6Y0C
         vdqRB8NvFUykFg/yZGrjraSKaFmI1EPElYYrvXajAlxEVUcB+E/KcGSzTc01Tas3QuJG
         DPMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EjJ01IjtmxevFQQ7zQg+vmwVtLzMJMtCRp/LYGMtBVs=;
        b=YZYBoSzzjbrp6aIBaUdQPOA14VVIpgRkwE0Q1ZOMMbdPiMywOEB9z8sb+ykIuC1jJg
         xAsNSNwLk9JuloZjnFJBoPMsQC956TE6i1tM5FKtIJF+J8qm/JTLzwp/s3B6d60XE4b1
         LURxMR5iz/xjmBTSYvW8jh9unKsF0Gawv7j7UnxI9HYDCrqA40W7o1JVuBSntADMNJ+U
         rJsWn94RktZT9EZ/6cO/QubxAzmOOYNGseRPZmEbOgTE+7b/Z4o2x3q6ETCfg0ZRy1a7
         XXaKRzSWEonsAUKuBp3YdqQabrmsBXjLRFWT/y4dTaH10bQ7GS1c4mPL7EgEsHcHEQFF
         qffg==
X-Gm-Message-State: AOAM532PUF5vdh91TnIWBfI6iBWtt0UpQc25Cju1FrMYyuHxDZ9eTcb4
        BQKtp+d4YLod1c+F7hS+I9sLew==
X-Google-Smtp-Source: ABdhPJyDuw1z3XGe3ymadVCShbzpnZtibjy1loQ8oB8mt6Rt0PHX3s1EtQrdm37+EvP/CRp835ZoYA==
X-Received: by 2002:a37:54a:: with SMTP id 71mr2795707qkf.193.1597935085530;
        Thu, 20 Aug 2020 07:51:25 -0700 (PDT)
Received: from localhost ([190.190.138.51])
        by smtp.gmail.com with ESMTPSA id d20sm2401617qkk.84.2020.08.20.07.51.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2020 07:51:25 -0700 (PDT)
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
Subject: [PATCH] Platform lockdown information in sysfs (v2)
Date:   Thu, 20 Aug 2020 11:51:17 -0300
Message-Id: <20200820145117.8348-1-daniel.gutson@eclypsium.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch exports information about the platform lockdown
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

This version of the patch replaces class attributes by device
attributes.

Signed-off-by: Daniel Gutson <daniel.gutson@eclypsium.com>
---
 .../ABI/stable/sysfs-class-platform-lockdown  |  23 ++++
 MAINTAINERS                                   |   7 +
 drivers/misc/Kconfig                          |   9 ++
 drivers/misc/Makefile                         |   1 +
 drivers/misc/platform-lockdown-attrs.c        | 123 ++++++++++++++++++
 drivers/mtd/spi-nor/controllers/Kconfig       |   1 +
 .../mtd/spi-nor/controllers/intel-spi-pci.c   |  73 +++++++++++
 drivers/mtd/spi-nor/controllers/intel-spi.c   |  87 +++++++++++++
 .../platform_data/platform-lockdown-attrs.h   |  42 ++++++
 9 files changed, 366 insertions(+)
 create mode 100644 Documentation/ABI/stable/sysfs-class-platform-lockdown
 create mode 100644 drivers/misc/platform-lockdown-attrs.c
 create mode 100644 include/linux/platform_data/platform-lockdown-attrs.h

diff --git a/Documentation/ABI/stable/sysfs-class-platform-lockdown b/Documentation/ABI/stable/sysfs-class-platform-lockdown
new file mode 100644
index 000000000000..3fe75d775a42
--- /dev/null
+++ b/Documentation/ABI/stable/sysfs-class-platform-lockdown
@@ -0,0 +1,23 @@
+What:		/sys/class/platform-lockdown/bioswe
+Date:		July 2020
+KernelVersion:	5.8.0
+Contact:	Daniel Gutson <daniel.gutson@eclypsium.com>
+Description:	If the system firmware set BIOS Write Enable.
+		0: writes disabled, 1: writes enabled.
+Users:		https://github.com/fwupd/fwupd
+
+What:		/sys/class/platform-lockdown/ble
+Date:		July 2020
+KernelVersion:	5.8.0
+Contact:	Daniel Gutson <daniel.gutson@eclypsium.com>
+Description:	If the system firmware set BIOS Lock Enable.
+		0: SMM lock disabled, 1: SMM lock enabled.
+Users:		https://github.com/fwupd/fwupd
+
+What:		/sys/class/platform-lockdown/smm_bwp
+Date:		July 2020
+KernelVersion:	5.8.0
+Contact:	Daniel Gutson <daniel.gutson@eclypsium.com>
+Description:	If the system firmware set SMM BIOS Write Protect.
+		0: writes disabled unless in SMM, 1: writes enabled.
+Users:		https://github.com/fwupd/fwupd
diff --git a/MAINTAINERS b/MAINTAINERS
index c8e8232c65da..2fa8128487d8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13664,6 +13664,13 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/iio/chemical/plantower,pms7003.yaml
 F:	drivers/iio/chemical/pms7003.c
 
+PLATFORM LOCKDOWN ATTRIBUTES MODULE
+M:	Daniel Gutson <daniel.gutson@eclypsium.com>
+S:	Supported
+F:	Documentation/ABI/sysfs-class-platform-lockdown
+F:	drivers/misc/platform-lockdown-attrs.c
+F:	include/linux/platform_data/platform-lockdown-attrs.h
+
 PLX DMA DRIVER
 M:	Logan Gunthorpe <logang@deltatee.com>
 S:	Maintained
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index e1b1ba5e2b92..6f44d896ef35 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -456,6 +456,15 @@ config PVPANIC
 	  a paravirtualized device provided by QEMU; it lets a virtual machine
 	  (guest) communicate panic events to the host.
 
+config PLATFORM_LOCKDOWN_ATTRS
+	tristate "Platform lockdown information in the sysfs"
+	depends on SYSFS
+	help
+	  This kernel module is a helper driver to provide information about
+	  platform lockdown settings and configuration.
+	  This module is used by other device drivers -such as the intel-spi-
+	  to publish the information in /sys/class/platform-lockdown.
+
 source "drivers/misc/c2port/Kconfig"
 source "drivers/misc/eeprom/Kconfig"
 source "drivers/misc/cb710/Kconfig"
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index c7bd01ac6291..e29b45c564f9 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -57,3 +57,4 @@ obj-$(CONFIG_PVPANIC)   	+= pvpanic.o
 obj-$(CONFIG_HABANA_AI)		+= habanalabs/
 obj-$(CONFIG_UACCE)		+= uacce/
 obj-$(CONFIG_XILINX_SDFEC)	+= xilinx_sdfec.o
+obj-$(CONFIG_PLATFORM_LOCKDOWN_ATTRS)	+= platform-lockdown-attrs.o
diff --git a/drivers/misc/platform-lockdown-attrs.c b/drivers/misc/platform-lockdown-attrs.c
new file mode 100644
index 000000000000..68656680cadd
--- /dev/null
+++ b/drivers/misc/platform-lockdown-attrs.c
@@ -0,0 +1,123 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Platform lockdown attributes kernel module
+ *
+ * Copyright (C) 2020 Daniel Gutson <daniel.gutson@eclypsium.com>
+ * Copyright (C) 2020 Eclypsium Inc.
+ */
+#include <linux/sysfs.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/kdev_t.h>
+#include <linux/platform_data/platform-lockdown-attrs.h>
+
+static struct class platform_lockdown_class = {
+	.name = "platform-lockdown",
+	.owner = THIS_MODULE,
+};
+
+struct device *register_platform_lockdown_data_device(struct device *parent,
+						      const char *name)
+{
+	return device_create(&platform_lockdown_class, parent, MKDEV(0, 0),
+			     NULL, name);
+}
+EXPORT_SYMBOL_GPL(register_platform_lockdown_data_device);
+
+void unregister_platform_lockdown_data_device(struct device *dev)
+{
+	device_unregister(dev);
+}
+EXPORT_SYMBOL_GPL(unregister_platform_lockdown_data_device);
+
+int register_platform_lockdown_attribute(struct device *dev,
+					 struct device_attribute *dev_attr)
+{
+	return device_create_file(dev, dev_attr);
+}
+EXPORT_SYMBOL_GPL(register_platform_lockdown_attribute);
+
+void register_platform_lockdown_attributes(struct device *dev,
+					   struct device_attribute dev_attrs[])
+{
+	u32 idx = 0;
+
+	while (dev_attrs[idx].attr.name != NULL) {
+		register_platform_lockdown_attribute(dev, &dev_attrs[idx]);
+		idx++;
+	}
+}
+EXPORT_SYMBOL_GPL(register_platform_lockdown_attributes);
+
+void register_platform_lockdown_custom_attributes(struct device *dev,
+						  void *custom_attrs,
+						  size_t dev_attr_offset,
+						  size_t custom_attr_size)
+{
+	char *raw_position = custom_attrs;
+
+	raw_position += dev_attr_offset;
+
+	while (((struct device_attribute *)raw_position)->attr.name != NULL) {
+		register_platform_lockdown_attribute(
+			dev, (struct device_attribute *)raw_position);
+		raw_position += custom_attr_size;
+	}
+}
+EXPORT_SYMBOL_GPL(register_platform_lockdown_custom_attributes);
+
+void unregister_platform_lockdown_attribute(struct device *dev,
+					    struct device_attribute *dev_attr)
+{
+	device_remove_file(dev, dev_attr);
+}
+EXPORT_SYMBOL_GPL(unregister_platform_lockdown_attribute);
+
+void unregister_platform_lockdown_attributes(
+	struct device *dev, struct device_attribute dev_attrs[])
+{
+	u32 idx = 0;
+
+	while (dev_attrs[idx].attr.name != NULL) {
+		unregister_platform_lockdown_attribute(dev, &dev_attrs[idx]);
+		idx++;
+	}
+}
+EXPORT_SYMBOL_GPL(unregister_platform_lockdown_attributes);
+
+void unregister_platform_lockdown_custom_attributes(struct device *dev,
+						    void *custom_attrs,
+						    size_t dev_attr_offset,
+						    size_t custom_attr_size)
+{
+	char *raw_position = custom_attrs;
+
+	raw_position += dev_attr_offset;
+	while (((struct device_attribute *)raw_position)->attr.name != NULL) {
+		unregister_platform_lockdown_attribute(
+			dev, (struct device_attribute *)raw_position);
+		raw_position += custom_attr_size;
+	}
+}
+EXPORT_SYMBOL_GPL(unregister_platform_lockdown_custom_attributes);
+
+static int __init platform_lockdown_attrs_init(void)
+{
+	int status;
+
+	status = class_register(&platform_lockdown_class);
+	if (status < 0)
+		return status;
+
+	return 0;
+}
+
+static void __exit platform_lockdown_attrs_exit(void)
+{
+	class_unregister(&platform_lockdown_class);
+}
+
+module_init(platform_lockdown_attrs_init);
+module_exit(platform_lockdown_attrs_exit);
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Daniel Gutson <daniel.gutson@eclypsium.com>");
diff --git a/drivers/mtd/spi-nor/controllers/Kconfig b/drivers/mtd/spi-nor/controllers/Kconfig
index 5c0e0ec2e6d1..c092d784c554 100644
--- a/drivers/mtd/spi-nor/controllers/Kconfig
+++ b/drivers/mtd/spi-nor/controllers/Kconfig
@@ -29,6 +29,7 @@ config SPI_NXP_SPIFI
 
 config SPI_INTEL_SPI
 	tristate
+	select PLATFORM_LOCKDOWN_ATTRS
 
 config SPI_INTEL_SPI_PCI
 	tristate "Intel PCH/PCU SPI flash PCI driver (DANGEROUS)"
diff --git a/drivers/mtd/spi-nor/controllers/intel-spi-pci.c b/drivers/mtd/spi-nor/controllers/intel-spi-pci.c
index 81329f680bec..50a98fb0a244 100644
--- a/drivers/mtd/spi-nor/controllers/intel-spi-pci.c
+++ b/drivers/mtd/spi-nor/controllers/intel-spi-pci.c
@@ -10,11 +10,19 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/pci.h>
+#include <linux/platform_data/platform-lockdown-attrs.h>
 
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
@@ -24,6 +32,58 @@ static const struct intel_spi_boardinfo cnl_info = {
 	.type = INTEL_SPI_CNL,
 };
 
+static struct device *class_child_device;
+
+static ssize_t cnl_spi_attr_show(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	u32 bcr;
+	struct cnl_spi_attr *cnl_spi_attr = container_of(attr,
+		struct cnl_spi_attr, dev_attr);
+
+	if (class_child_device != dev)
+		return -EIO;
+
+	if (dev->parent == NULL)
+		return -EIO;
+
+	if (pci_read_config_dword(container_of(dev->parent, struct pci_dev, dev),
+				BCR, &bcr) != PCIBIOS_SUCCESSFUL)
+		return -EIO;
+
+	return sprintf(buf, "%d\n", (int)!!(bcr & cnl_spi_attr->mask));
+}
+
+#define CNL_SPI_ATTR(_name, _mask)					\
+{									\
+	.dev_attr = __ATTR(_name, 0444, cnl_spi_attr_show, NULL),	\
+	.mask = _mask							\
+}
+
+static struct cnl_spi_attr cnl_spi_attrs[] = {
+	CNL_SPI_ATTR(bioswe, BCR_WPD),
+	CNL_SPI_ATTR(ble, BCR_BLE),
+	CNL_SPI_ATTR(smm_bwp, BCR_SMM_BWP),
+	{ }
+};
+
+static void register_local_platform_lockdown_attributes(struct pci_dev *pdev)
+{
+	if (class_child_device == NULL) {
+		class_child_device = register_platform_lockdown_data_device(
+			&pdev->dev, "intel-spi-pci");
+
+		if (IS_ERR_OR_NULL(class_child_device))
+			return;
+
+		register_platform_lockdown_custom_attributes(
+			class_child_device,
+			cnl_spi_attrs,
+			offsetof(struct cnl_spi_attr, dev_attr),
+			sizeof(struct cnl_spi_attr));
+	}
+}
+
 static int intel_spi_pci_probe(struct pci_dev *pdev,
 			       const struct pci_device_id *id)
 {
@@ -50,6 +110,8 @@ static int intel_spi_pci_probe(struct pci_dev *pdev,
 	}
 	info->writeable = !!(bcr & BCR_WPD);
 
+	register_local_platform_lockdown_attributes(pdev);
+
 	ispi = intel_spi_probe(&pdev->dev, &pdev->resource[0], info);
 	if (IS_ERR(ispi))
 		return PTR_ERR(ispi);
@@ -60,6 +122,17 @@ static int intel_spi_pci_probe(struct pci_dev *pdev,
 
 static void intel_spi_pci_remove(struct pci_dev *pdev)
 {
+	if (class_child_device != NULL) {
+		unregister_platform_lockdown_custom_attributes(
+			class_child_device,
+			cnl_spi_attrs,
+			offsetof(struct cnl_spi_attr, dev_attr),
+			sizeof(struct cnl_spi_attr));
+
+		unregister_platform_lockdown_data_device(class_child_device);
+		class_child_device = NULL;
+	}
+
 	intel_spi_remove(pci_get_drvdata(pdev));
 }
 
diff --git a/drivers/mtd/spi-nor/controllers/intel-spi.c b/drivers/mtd/spi-nor/controllers/intel-spi.c
index 61d2a0ad2131..f243e7996917 100644
--- a/drivers/mtd/spi-nor/controllers/intel-spi.c
+++ b/drivers/mtd/spi-nor/controllers/intel-spi.c
@@ -16,6 +16,7 @@
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/spi-nor.h>
 #include <linux/platform_data/intel-spi.h>
+#include <linux/platform_data/platform-lockdown-attrs.h>
 
 #include "intel-spi.h"
 
@@ -95,6 +96,8 @@
 #define BYT_SSFSTS_CTL			0x90
 #define BYT_BCR				0xfc
 #define BYT_BCR_WPD			BIT(0)
+#define BYT_BCR_BLE			BIT(1)
+#define BYT_BCR_SMM_BWP			BIT(5)
 #define BYT_FREG_NUM			5
 #define BYT_PR_NUM			5
 
@@ -159,10 +162,17 @@ struct intel_spi {
 	u8 opcodes[8];
 };
 
+struct byt_spi_attr {
+	struct device_attribute dev_attr;
+	u32 mask;
+};
+
 static bool writeable;
 module_param(writeable, bool, 0);
 MODULE_PARM_DESC(writeable, "Enable write access to SPI flash chip (default=0)");
 
+static struct device *class_child_device;
+
 static void intel_spi_dump_regs(struct intel_spi *ispi)
 {
 	u32 value;
@@ -305,6 +315,80 @@ static int intel_spi_wait_sw_busy(struct intel_spi *ispi)
 				  INTEL_SPI_TIMEOUT * 1000);
 }
 
+static ssize_t byt_spi_attr_show(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	u32 bcr;
+	struct byt_spi_attr *byt_spi_attr = container_of(attr,
+		struct byt_spi_attr, dev_attr);
+	struct intel_spi *ispi = dev_get_drvdata(dev);
+
+	if (class_child_device != dev->parent)
+		return -EIO;
+
+	bcr = readl(ispi->base + BYT_BCR);
+	return sprintf(buf, "%d\n", (int)!!(bcr & byt_spi_attr->mask));
+}
+
+#define BYT_SPI_ATTR(_name, _mask)					\
+{									\
+	.dev_attr = __ATTR(_name, 0444, byt_spi_attr_show, NULL),	\
+	.mask = _mask							\
+}
+
+static struct byt_spi_attr byt_spi_attrs[] = {
+	BYT_SPI_ATTR(bioswe, BYT_BCR_WPD),
+	BYT_SPI_ATTR(ble, BYT_BCR_BLE),
+	BYT_SPI_ATTR(smm_bwp, BYT_BCR_SMM_BWP),
+	{ }
+};
+
+static void register_local_platform_lockdown_attributes(struct intel_spi *ispi)
+{
+	if (class_child_device == NULL) {
+		switch (ispi->info->type) {
+		case INTEL_SPI_BYT:
+			class_child_device =
+				register_platform_lockdown_data_device(
+					ispi->dev, "intel-spi");
+
+			if (IS_ERR_OR_NULL(class_child_device))
+				return;
+
+			dev_set_drvdata(class_child_device, ispi);
+
+			register_platform_lockdown_custom_attributes(
+				class_child_device,
+				byt_spi_attrs,
+				offsetof(struct byt_spi_attr, dev_attr),
+				sizeof(struct byt_spi_attr));
+			break;
+		default:
+			break; /* TODO. not yet implemented. */
+		}
+	}
+}
+
+static void unregister_local_platform_lockdown_attributes(struct intel_spi *ispi)
+{
+	if (class_child_device != NULL) {
+		switch (ispi->info->type) {
+		case INTEL_SPI_BYT:
+			unregister_platform_lockdown_custom_attributes(
+				class_child_device,
+				byt_spi_attrs,
+				offsetof(struct byt_spi_attr, dev_attr),
+				sizeof(struct byt_spi_attr));
+			break;
+		default:
+			break; /* TODO. not yet implemented. */
+		}
+
+		unregister_platform_lockdown_data_device(class_child_device);
+		class_child_device = NULL;
+	}
+}
+
 static int intel_spi_init(struct intel_spi *ispi)
 {
 	u32 opmenu0, opmenu1, lvscc, uvscc, val;
@@ -422,6 +506,8 @@ static int intel_spi_init(struct intel_spi *ispi)
 
 	intel_spi_dump_regs(ispi);
 
+	register_local_platform_lockdown_attributes(ispi);
+
 	return 0;
 }
 
@@ -951,6 +1037,7 @@ EXPORT_SYMBOL_GPL(intel_spi_probe);
 
 int intel_spi_remove(struct intel_spi *ispi)
 {
+	unregister_local_platform_lockdown_attributes(ispi);
 	return mtd_device_unregister(&ispi->nor.mtd);
 }
 EXPORT_SYMBOL_GPL(intel_spi_remove);
diff --git a/include/linux/platform_data/platform-lockdown-attrs.h b/include/linux/platform_data/platform-lockdown-attrs.h
new file mode 100644
index 000000000000..e538e9e612b0
--- /dev/null
+++ b/include/linux/platform_data/platform-lockdown-attrs.h
@@ -0,0 +1,42 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Platform lockdown attributes kernel module
+ *
+ * Copyright (C) 2020 Daniel Gutson <daniel.gutson@eclypsium.com>
+ * Copyright (C) 2020 Eclypsium Inc.
+ */
+#ifndef PLATFORM_LOCKDOWN_ATTRS_H
+#define PLATFORM_LOCKDOWN_ATTRS_H
+
+#include <linux/device.h>
+
+extern struct device *
+register_platform_lockdown_data_device(struct device *parent, const char *name);
+
+extern void unregister_platform_lockdown_data_device(struct device *dev);
+
+extern int
+register_platform_lockdown_attribute(struct device *dev,
+				     struct device_attribute *dev_attr);
+
+extern void
+register_platform_lockdown_attributes(struct device *dev,
+				      struct device_attribute dev_attrs[]);
+
+extern void register_platform_lockdown_custom_attributes(
+	struct device *dev, void *custom_attrs, size_t dev_attr_offset,
+	size_t custom_attr_size);
+
+extern void
+unregister_platform_lockdown_attribute(struct device *dev,
+				       struct device_attribute *dev_attr);
+
+extern void
+unregister_platform_lockdown_attributes(struct device *dev,
+					struct device_attribute dev_attrs[]);
+
+extern void unregister_platform_lockdown_custom_attributes(
+	struct device *dev, void *custom_attrs, size_t dev_attr_offset,
+	size_t custom_attr_size);
+
+#endif /* PLATFORM_LOCKDOWN_ATTRS_H */
-- 
2.25.1

