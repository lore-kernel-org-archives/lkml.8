Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EC1AC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 21:41:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FF4F20809
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 21:41:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=eclypsium.com header.i=@eclypsium.com header.b="KLFv6buT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730594AbgG3Vlx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 17:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbgG3Vlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 17:41:52 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB91AC061574
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 14:41:52 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id h21so15150581qtp.11
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 14:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BUnyyHDer9+4N913cUoXPqQxlzNZubnsYR+mL9ZVshg=;
        b=KLFv6buTYODyO28otKTbbtWoqv1ndz0wl+5HtC/RM22tWVnj2XtX9OhWOllTivK0Fg
         QuXbLTIWjGpBqqZFraCgNRNQ0M8IPbdzfhzQFMkYxaqKkD3eE9PiQaA29dpwANd0BFme
         SSKEBdePM6CwDDCPNmecQjdOX07DTl8ReZmVyiU2e2JahaMkosAKKT6UKI8/atclxAaa
         ilPi9EYtW/ltd+IJ5ZO8sGMcE+rBfCBI8lAxEFJk0KVlXtY/I1svzL3lC1/y/TW/7KVR
         PGxqgMU9HXjewLJO+XgJSC4Zfghm2CuhnuT2YijAnjVDhPjz02rC/kFbtZJnRzByFId9
         bYQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BUnyyHDer9+4N913cUoXPqQxlzNZubnsYR+mL9ZVshg=;
        b=fxw9VlYRXPMrFtSs1VzYFQ0vJ7VGvnM+zcrP1NroJAqOgWregre7ZyL2WRfcsY7Fyu
         Rya945xhuBcGBhduJKeMqSaTkofzGpMY/0UFMb0MfcpAuglNxxeRAcCMSJzbx3W452d1
         ZeIXQtsgsh+sUZZBQfR1hXWfo0qchkYhV2D4gkBrx0u4vcSxoLfPdFrNNB1gIE2HB07c
         jqQGB+rnT+OKUkII4EUHdlH83QgPb1ErC7PQYiRECR9ltEYZHPZxEAcAB3C+0u3GPvNR
         ov6o4SXy2mKG/XvbrjTCAt9Pf4uDXXIlvDoIguqz8p/TMyX5mtWjEWu22KAIJox95+P9
         +tBQ==
X-Gm-Message-State: AOAM531jmD5jnyt9NwpOfgp1ch+P6hWvQPmjw4nTj9au69XFSqszYjRs
        biDy/0cQXuVhFPoX2YFg7kF/1A==
X-Google-Smtp-Source: ABdhPJypG+vxImZhYsvy2oA274KVMaphGnbmPd32kCF9mCMPZ9hTHM7NOH32Wj8sf1CO7sAuiPFyyQ==
X-Received: by 2002:aed:3b7a:: with SMTP id q55mr765680qte.78.1596145311415;
        Thu, 30 Jul 2020 14:41:51 -0700 (PDT)
Received: from localhost ([190.190.138.51])
        by smtp.gmail.com with ESMTPSA id c7sm6313789qta.95.2020.07.30.14.41.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2020 14:41:50 -0700 (PDT)
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
Subject: [PATCH] Platform lockdown information in SYSFS
Date:   Thu, 30 Jul 2020 18:41:36 -0300
Message-Id: <20200730214136.5534-1-daniel.gutson@eclypsium.com>
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
BIOS Lock Enable (ble), and the SMM Bios Write Protect (SMM_BWP)
fields of the Bios Control register. The idea is to keep adding more
flags, not only from the BC but also from other registers in following
versions.

The goal is that the attributes are avilable to fwupd when SecureBoot
is turned on.

The patch provides a new misc driver, as proposed in the previous patch,
that provides a registration function for HW Driver devices to register
class_attributes.
In this case, the intel SPI flash chip (intel-spi) registers three
class_attributes corresponding to the fields mentioned above.

Signed-off-by: Daniel Gutson <daniel.gutson@eclypsium.com>
---
 .../ABI/stable/sysfs-class-platform-lockdown  | 23 +++++++
 MAINTAINERS                                   |  7 +++
 drivers/misc/Kconfig                          |  9 +++
 drivers/misc/Makefile                         |  1 +
 drivers/misc/platform-lockdown-attrs.c        | 57 +++++++++++++++++
 drivers/mtd/spi-nor/controllers/Kconfig       |  1 +
 .../mtd/spi-nor/controllers/intel-spi-pci.c   | 49 +++++++++++++++
 drivers/mtd/spi-nor/controllers/intel-spi.c   | 62 +++++++++++++++++++
 .../platform_data/platform-lockdown-attrs.h   | 19 ++++++
 9 files changed, 228 insertions(+)
 create mode 100644 Documentation/ABI/stable/sysfs-class-platform-lockdown
 create mode 100644 drivers/misc/platform-lockdown-attrs.c
 create mode 100644 include/linux/platform_data/platform-lockdown-attrs.h

diff --git a/Documentation/ABI/stable/sysfs-class-platform-lockdown b/Documentation/ABI/stable/sysfs-class-platform-lockdown
new file mode 100644
index 000000000000..6034d6cbefac
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
+Description:	If the system firmware set Bios Lock Enable.
+		0: SMM lock disabled, 1: SMM lock enabled.
+Users:		https://github.com/fwupd/fwupd
+
+What:		/sys/class/platform-lockdown/smm_bwp
+Date:		July 2020
+KernelVersion:	5.8.0
+Contact:	Daniel Gutson <daniel.gutson@eclypsium.com>
+Description:	If the system firmware set SMM Bios Write Protect.
+		0: writes disabled unless in SMM, 1: writes enabled.
+Users:		https://github.com/fwupd/fwupd
diff --git a/MAINTAINERS b/MAINTAINERS
index f0569cf304ca..771ed1693d28 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13608,6 +13608,13 @@ S:	Maintained
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
index e1b1ba5e2b92..058d4ba3cefd 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -456,6 +456,15 @@ config PVPANIC
 	  a paravirtualized device provided by QEMU; it lets a virtual machine
 	  (guest) communicate panic events to the host.
 
+config PLATFORM_LOCKDOWN_ATTRS
+	tristate "Platform lockdown information in the SYSFS"
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
index 000000000000..d08b3d895064
--- /dev/null
+++ b/drivers/misc/platform-lockdown-attrs.c
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Platform lockdown attributes kernel module
+ *
+ * Copyright (C) 2020 Daniel Gutson <daniel.gutson@eclypsium.com>
+ * Copyright (C) 2020 Eclypsium Inc.
+ */
+#include <linux/kobject.h>
+#include <linux/sysfs.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/list.h>
+#include <linux/slab.h>
+#include <linux/platform_data/platform-lockdown-attrs.h>
+
+static struct class platform_lockdown_class = {
+	.name	= "platform-lockdown",
+	.owner	= THIS_MODULE,
+};
+
+int register_platform_lockdown_attribute(
+	struct class_attribute *lockdown_attribute)
+{
+	/* attempt to create the file: */
+	return class_create_file(&platform_lockdown_class,
+				   lockdown_attribute);
+}
+EXPORT_SYMBOL_GPL(register_platform_lockdown_attribute);
+
+void unregister_platform_lockdown_attribute(
+	struct class_attribute *lockdown_attribute)
+{
+	class_remove_file(&platform_lockdown_class,
+				   lockdown_attribute);
+}
+EXPORT_SYMBOL_GPL(unregister_platform_lockdown_attribute);
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
index d89a5ea9446a..3c03188cc30b 100644
--- a/drivers/mtd/spi-nor/controllers/Kconfig
+++ b/drivers/mtd/spi-nor/controllers/Kconfig
@@ -40,6 +40,7 @@ config SPI_NXP_SPIFI
 
 config SPI_INTEL_SPI
 	tristate
+	select PLATFORM_LOCKDOWN_ATTRS
 
 config SPI_INTEL_SPI_PCI
 	tristate "Intel PCH/PCU SPI flash PCI driver (DANGEROUS)"
diff --git a/drivers/mtd/spi-nor/controllers/intel-spi-pci.c b/drivers/mtd/spi-nor/controllers/intel-spi-pci.c
index 81329f680bec..d99b0b6fe432 100644
--- a/drivers/mtd/spi-nor/controllers/intel-spi-pci.c
+++ b/drivers/mtd/spi-nor/controllers/intel-spi-pci.c
@@ -10,11 +10,20 @@
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
+	struct class_attribute class_attr;
+	struct pci_dev *pdev;
+	u32 mask;
+};
 
 static const struct intel_spi_boardinfo bxt_info = {
 	.type = INTEL_SPI_BXT,
@@ -24,6 +33,40 @@ static const struct intel_spi_boardinfo cnl_info = {
 	.type = INTEL_SPI_CNL,
 };
 
+static ssize_t cnl_spi_attr_show(struct class *class,
+	struct class_attribute *attr, char *buf)
+{
+	u32 bcr;
+	struct cnl_spi_attr *cnl_spi_attr = container_of(attr,
+		struct cnl_spi_attr, class_attr);
+
+	if (pci_read_config_dword(cnl_spi_attr->pdev,
+		BCR, &bcr) != PCIBIOS_SUCCESSFUL)
+		return -EIO;
+
+	return sprintf(buf, "%d\n", (int)!!(bcr & cnl_spi_attr->mask));
+}
+
+#define CNL_SPI_ATTR(_name, _mask)					\
+static struct cnl_spi_attr cnl_##_name##_attr = {			\
+	.class_attr = __ATTR(_name, 0444, cnl_spi_attr_show, NULL),	\
+	.mask = _mask							\
+}
+
+CNL_SPI_ATTR(bioswe, BCR_WPD);
+CNL_SPI_ATTR(ble, BCR_BLE);
+CNL_SPI_ATTR(smm_bwp, BCR_SMM_BWP);
+
+static void register_platform_lockdown_attributes(struct pci_dev *pdev)
+{
+	cnl_bioswe_attr.pdev = pdev;
+	cnl_ble_attr.pdev = pdev;
+	cnl_smm_bwp_attr.pdev = pdev;
+	register_platform_lockdown_attribute(&cnl_bioswe_attr.class_attr);
+	register_platform_lockdown_attribute(&cnl_ble_attr.class_attr);
+	register_platform_lockdown_attribute(&cnl_smm_bwp_attr.class_attr);
+}
+
 static int intel_spi_pci_probe(struct pci_dev *pdev,
 			       const struct pci_device_id *id)
 {
@@ -50,6 +93,8 @@ static int intel_spi_pci_probe(struct pci_dev *pdev,
 	}
 	info->writeable = !!(bcr & BCR_WPD);
 
+	register_platform_lockdown_attributes(pdev);
+
 	ispi = intel_spi_probe(&pdev->dev, &pdev->resource[0], info);
 	if (IS_ERR(ispi))
 		return PTR_ERR(ispi);
@@ -60,6 +105,10 @@ static int intel_spi_pci_probe(struct pci_dev *pdev,
 
 static void intel_spi_pci_remove(struct pci_dev *pdev)
 {
+	unregister_platform_lockdown_attribute(&cnl_bioswe_attr.class_attr);
+	unregister_platform_lockdown_attribute(&cnl_ble_attr.class_attr);
+	unregister_platform_lockdown_attribute(&cnl_smm_bwp_attr.class_attr);
+
 	intel_spi_remove(pci_get_drvdata(pdev));
 }
 
diff --git a/drivers/mtd/spi-nor/controllers/intel-spi.c b/drivers/mtd/spi-nor/controllers/intel-spi.c
index 61d2a0ad2131..13397dd9f89f 100644
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
 
@@ -159,6 +162,12 @@ struct intel_spi {
 	u8 opcodes[8];
 };
 
+struct byt_spi_attr {
+	struct class_attribute class_attr;
+	struct intel_spi *ispi;
+	u32 mask;
+};
+
 static bool writeable;
 module_param(writeable, bool, 0);
 MODULE_PARM_DESC(writeable, "Enable write access to SPI flash chip (default=0)");
@@ -305,6 +314,56 @@ static int intel_spi_wait_sw_busy(struct intel_spi *ispi)
 				  INTEL_SPI_TIMEOUT * 1000);
 }
 
+static ssize_t byt_spi_attr_show(struct class *class,
+	struct class_attribute *class_attr, char *buf)
+{
+	u32 bcr;
+	struct byt_spi_attr *byt_spi_attr = container_of(class_attr,
+		struct byt_spi_attr, class_attr);
+
+	bcr = readl(byt_spi_attr->ispi->base + BYT_BCR);
+	return sprintf(buf, "%d\n", (int)!!(bcr & byt_spi_attr->mask));
+}
+
+#define BYT_SPI_ATTR(_name, _mask)					\
+static struct byt_spi_attr byt_##_name##_attr = {			\
+	.class_attr = __ATTR(_name, 0444, byt_spi_attr_show, NULL),	\
+	.mask = _mask							\
+}
+
+BYT_SPI_ATTR(bioswe, BYT_BCR_WPD);
+BYT_SPI_ATTR(ble, BYT_BCR_BLE);
+BYT_SPI_ATTR(smm_bwp, BYT_BCR_SMM_BWP);
+
+static void register_platform_lockdown_attributes(struct intel_spi *ispi)
+{
+	switch (ispi->info->type) {
+	case INTEL_SPI_BYT:
+		byt_bioswe_attr.ispi = ispi;
+		byt_ble_attr.ispi = ispi;
+		byt_smm_bwp_attr.ispi = ispi;
+		register_platform_lockdown_attribute(&byt_bioswe_attr.class_attr);
+		register_platform_lockdown_attribute(&byt_ble_attr.class_attr);
+		register_platform_lockdown_attribute(&byt_smm_bwp_attr.class_attr);
+		break;
+	default:
+		break; /* TODO. not yet implemented. */
+	}
+}
+
+static void unregister_platform_lockdown_attributes(struct intel_spi *ispi)
+{
+	switch (ispi->info->type) {
+	case INTEL_SPI_BYT:
+		unregister_platform_lockdown_attribute(&byt_bioswe_attr.class_attr);
+		unregister_platform_lockdown_attribute(&byt_ble_attr.class_attr);
+		unregister_platform_lockdown_attribute(&byt_smm_bwp_attr.class_attr);
+		break;
+	default:
+		break; /* TODO. not yet implemented. */
+	}
+}
+
 static int intel_spi_init(struct intel_spi *ispi)
 {
 	u32 opmenu0, opmenu1, lvscc, uvscc, val;
@@ -422,6 +481,8 @@ static int intel_spi_init(struct intel_spi *ispi)
 
 	intel_spi_dump_regs(ispi);
 
+	register_platform_lockdown_attributes(ispi);
+
 	return 0;
 }
 
@@ -951,6 +1012,7 @@ EXPORT_SYMBOL_GPL(intel_spi_probe);
 
 int intel_spi_remove(struct intel_spi *ispi)
 {
+	unregister_platform_lockdown_attributes(ispi);
 	return mtd_device_unregister(&ispi->nor.mtd);
 }
 EXPORT_SYMBOL_GPL(intel_spi_remove);
diff --git a/include/linux/platform_data/platform-lockdown-attrs.h b/include/linux/platform_data/platform-lockdown-attrs.h
new file mode 100644
index 000000000000..f8ef7f3fd5b3
--- /dev/null
+++ b/include/linux/platform_data/platform-lockdown-attrs.h
@@ -0,0 +1,19 @@
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
+extern int register_platform_lockdown_attribute(
+	struct class_attribute *lockdown_attribute);
+
+extern void unregister_platform_lockdown_attribute(
+	struct class_attribute *lockdown_attribute);
+
+#endif /* PLATFORM_LOCKDOWN_ATTRS_H */
-- 
2.25.1

