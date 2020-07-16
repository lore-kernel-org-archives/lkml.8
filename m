Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51AD0C433E6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 23:10:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D1A22064B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 23:10:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=eclypsium.com header.i=@eclypsium.com header.b="ZuorW7k9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728253AbgGPXKe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 19:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727938AbgGPXJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 19:09:19 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 810BAC08C5DE
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 15:36:54 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id g13so6250184qtv.8
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 15:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qaKhQ3DHa+xGD/e6TlwDgy6U4E6KnIe+KuW4REObmhA=;
        b=ZuorW7k9PvVWzG3qF/8A9HbGlIHl9SdzSNdAqYkEVxAfKPxOmtvOgi+kUlBl2sIEPZ
         aLGY/K/N8e4/nSyd6exrJ+uf+7zJfMjq8cp+es9E7a+t1tvmrb9FuZXb+3HAtr73z+R4
         4oQi6Wk/HLlyOJ8wj3XaCMZpIS/USCsvgU9ZzdV9t1NQ4j/igy1bGBtT+fNVVJwK2gUY
         g65zvF8Dw4TimzgodozaaGDAHehPNEOvsLIh5cyHKYTholUXufYWbesxP4uJu5RTMsXk
         75S9vozResfBzjAczlTS0VhhF6k/ACEEZuLqP5HS5veLI/UT4fkL1TPEP+HwKAtoDjte
         NSNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qaKhQ3DHa+xGD/e6TlwDgy6U4E6KnIe+KuW4REObmhA=;
        b=UNzWSBWEUCy0CpnFtIOrPfs/Ykmkw7IIHxfOm4sElooEH4tOxMHGRUS2FKJDEXAFV8
         SN4q21nDMShv5YHRK7eljuChF10BaQiaoI9aXuheRBryPLfWu08Bf8tcnVzRv4pPTeX3
         92104SYp1btv8w4WF/CxpcdghXv1sn+AZWZ8mObc87+/Kjkd/FjCVXG5nmNMrws88YUP
         3ng6PebjvFCfClVfp1x125UPS5HKiVbK9ktpBJ+SCjOnmN2itxOjMyGg5iTU4xm/IC9j
         tjm5NJuvBypmz3+hieCkRuHTzeToSvn+wnwY+ckNVB5AejgMsgqba6+zwovB+FLiVL/f
         +bsg==
X-Gm-Message-State: AOAM5323F6g/MAiEv9iqbgfqC3hN2zxmZFqE2mz6deE3Ot+7fcqqLd/X
        p+eMv/2DG1EBO5eVV4M+xi6fUg==
X-Google-Smtp-Source: ABdhPJwiyxtbOZlkud3qcLuhw8NJMv6/1JXPLkyslfDve0CQaERhIDg5ObRZnZ+2qcjd4g/Ladm07g==
X-Received: by 2002:ac8:7c9:: with SMTP id m9mr7765411qth.166.1594939013219;
        Thu, 16 Jul 2020 15:36:53 -0700 (PDT)
Received: from localhost ([190.190.138.51])
        by smtp.gmail.com with ESMTPSA id x26sm8571075qtr.4.2020.07.16.15.36.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jul 2020 15:36:52 -0700 (PDT)
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
Subject: [PATCH] [PATCH] Firmware security information in SYSFS
Date:   Thu, 16 Jul 2020 19:36:27 -0300
Message-Id: <20200716223627.253936-1-daniel.gutson@eclypsium.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch exports security-related firmware configuration
in the sysfs filesystem. In this initial patch, I include
some configuration attributes for the system SPI chip.

This initial version exports the BIOS Write Enable (bioswe),
BIOS Lock Enable (ble), and the SMM Bios Write Protect (SMM_BWP)
fields of the Bios Control register. The idea is to keep adding more
flags, not only from the BC but also from other registers in following
versions.

The goal is that the attributes are avilable to fwupd when SecureBoot
is turned on.

The patch provides a new misc driver, as proposed in the previous patch,
that provides registration functions for HW Driver devices.
In this case, the intel SPI flash chip (intel-spi) registers functions
so it can export the three attributes mentioned above.

Signed-off-by: Daniel Gutson <daniel.gutson@eclypsium.com>
---
 .../ABI/stable/sysfs-firmware-security        |  23 ++++
 MAINTAINERS                                   |   7 ++
 drivers/misc/Kconfig                          |   9 ++
 drivers/misc/Makefile                         |   1 +
 drivers/misc/firmware_security_data.c         | 103 ++++++++++++++++++
 drivers/mtd/spi-nor/controllers/Kconfig       |   1 +
 .../mtd/spi-nor/controllers/intel-spi-pci.c   |  45 +++++++-
 drivers/mtd/spi-nor/controllers/intel-spi.c   |  92 ++++++++++++----
 .../platform_data/firmware_security_data.h    |  17 +++
 9 files changed, 277 insertions(+), 21 deletions(-)
 create mode 100644 Documentation/ABI/stable/sysfs-firmware-security
 create mode 100644 drivers/misc/firmware_security_data.c
 create mode 100644 include/linux/platform_data/firmware_security_data.h

diff --git a/Documentation/ABI/stable/sysfs-firmware-security b/Documentation/ABI/stable/sysfs-firmware-security
new file mode 100644
index 000000000000..fdfcc40c3c09
--- /dev/null
+++ b/Documentation/ABI/stable/sysfs-firmware-security
@@ -0,0 +1,23 @@
+What:		/sys/kernel/firmware-security/bioswe
+Date:		July 2020
+KernelVersion:	5.8.0
+Contact:	Daniel Gutson <daniel.gutson@eclypsium.com>
+Description:	If the system firmware set BIOS Write Enable.
+		0: writes disabled, 1: writes enabled.
+Users:		https://github.com/fwupd/fwupd
+
+What:		/sys/kernel/firmware-security/ble
+Date:		July 2020
+KernelVersion:	5.8.0
+Contact:	Daniel Gutson <daniel.gutson@eclypsium.com>
+Description:	If the system firmware set Bios Lock Enable.
+		0: SMM lock disabled, 1: SMM lock enabled.
+Users:		https://github.com/fwupd/fwupd
+
+What:		/sys/kernel/firmware-security/smm_bwp
+Date:		July 2020
+KernelVersion:	5.8.0
+Contact:	Daniel Gutson <daniel.gutson@eclypsium.com>
+Description:	If the system firmware set SMM Bios Write Protect.
+		0: writes disabled unless in SMM, 1: writes enabled.
+Users:		https://github.com/fwupd/fwupd
diff --git a/MAINTAINERS b/MAINTAINERS
index b4a43a9e7fbc..152b3b9b802c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6699,6 +6699,13 @@ F:	Documentation/firmware_class/
 F:	drivers/base/firmware_loader/
 F:	include/linux/firmware.h
 
+FIRMWARE SECURITY DATA
+M:	Daniel Gutson <daniel.gutson@eclypsium.com>
+S:	Supported
+F:	Documentation/ABI/sysfs-firmware-security
+F:	drivers/misc/firmware_security_data.c
+F:	include/linux/platform_data/firmware_security_data.h
+
 FLASH ADAPTER DRIVER (IBM Flash Adapter 900GB Full Height PCI Flash Card)
 M:	Joshua Morris <josh.h.morris@us.ibm.com>
 M:	Philip Kelleher <pjk1939@linux.ibm.com>
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index e1b1ba5e2b92..72fafb63be58 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -456,6 +456,15 @@ config PVPANIC
 	  a paravirtualized device provided by QEMU; it lets a virtual machine
 	  (guest) communicate panic events to the host.
 
+config FIRMWARE_SECURITY_DATA
+	tristate "Firmware security information in the SYSFS"
+	depends on SYSFS
+	help
+	  This kernel module is a helper driver to provide information about
+	  firmware security settings and configuration.
+	  This module is used by other device drivers -such as the intel-spi-
+	  to publish the information in /sys/kernel/firmware_security.
+
 source "drivers/misc/c2port/Kconfig"
 source "drivers/misc/eeprom/Kconfig"
 source "drivers/misc/cb710/Kconfig"
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index c7bd01ac6291..f938abc2f733 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -57,3 +57,4 @@ obj-$(CONFIG_PVPANIC)   	+= pvpanic.o
 obj-$(CONFIG_HABANA_AI)		+= habanalabs/
 obj-$(CONFIG_UACCE)		+= uacce/
 obj-$(CONFIG_XILINX_SDFEC)	+= xilinx_sdfec.o
+obj-$(CONFIG_FIRMWARE_SECURITY_DATA)	+= firmware_security_data.o
diff --git a/drivers/misc/firmware_security_data.c b/drivers/misc/firmware_security_data.c
new file mode 100644
index 000000000000..cfb7f39a2cd9
--- /dev/null
+++ b/drivers/misc/firmware_security_data.c
@@ -0,0 +1,103 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Firmware security data kernel module
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
+#include <linux/platform_data/firmware_security_data.h>
+
+static DEFINE_MUTEX(entries_mutex);
+static LIST_HEAD(entries);
+static struct kobject *firmware_data_kobj;
+
+struct firmware_security_data {
+	struct kobj_attribute kobj_attr;
+	ssize_t (*callback)(char *buf, void *private_data);
+	void *private_data;
+	struct list_head list_node;
+};
+
+static ssize_t internal_callback(struct kobject *kobj,
+				 struct kobj_attribute *attr, char *buf)
+{
+	struct firmware_security_data *fwsd =
+		container_of(attr, struct firmware_security_data, kobj_attr);
+	return fwsd->callback(buf, fwsd->private_data);
+}
+
+int register_firmware_security_data_callback(
+	const char *name, ssize_t (*callback)(char *buf, void *private_data),
+	void *private_data)
+{
+	int retval;
+
+	struct firmware_security_data *new_data;
+
+	if (name == NULL || name[0] == 0)
+		return -EINVAL;
+
+	new_data = kmalloc(sizeof(struct firmware_security_data), GFP_KERNEL);
+	if (new_data == NULL)
+		return -ENOMEM;
+
+	/* initialize attributes: */
+	sysfs_attr_init(new_data->kobj_attr.attr);
+	new_data->kobj_attr.attr.name = name;
+	new_data->kobj_attr.attr.mode = 0664;
+	new_data->kobj_attr.show = internal_callback;
+	new_data->kobj_attr.store = NULL;
+
+	new_data->callback = callback;
+	new_data->private_data = private_data;
+
+	/* attempt to create the file: */
+	retval = sysfs_create_file(firmware_data_kobj,
+				   &new_data->kobj_attr.attr);
+	if (retval == 0) {
+		/* append to the list of entries: */
+		INIT_LIST_HEAD(&new_data->list_node);
+		mutex_lock(&entries_mutex);
+		list_add(&new_data->list_node, &entries);
+		mutex_unlock(&entries_mutex);
+	} else {
+		kfree(new_data);
+	}
+
+	return retval;
+}
+EXPORT_SYMBOL_GPL(register_firmware_security_data_callback);
+
+static int __init firmware_security_data_init(void)
+{
+	firmware_data_kobj =
+		kobject_create_and_add("firmware_security", kernel_kobj);
+	if (!firmware_data_kobj)
+		return -ENOMEM;
+
+	return 0;
+}
+static void __exit firmware_security_data_exit(void)
+{
+	struct list_head *entry = entries.next;
+
+	while (entry != &entries) {
+		struct list_head *next = entry->next;
+
+		kfree(list_entry(entry, struct firmware_security_data,
+				 list_node));
+		entry = next;
+	}
+
+	kobject_put(firmware_data_kobj);
+}
+module_init(firmware_security_data_init);
+module_exit(firmware_security_data_exit);
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Daniel Gutson <daniel.gutson@eclypsium.com>");
diff --git a/drivers/mtd/spi-nor/controllers/Kconfig b/drivers/mtd/spi-nor/controllers/Kconfig
index d89a5ea9446a..01d9c49f8e49 100644
--- a/drivers/mtd/spi-nor/controllers/Kconfig
+++ b/drivers/mtd/spi-nor/controllers/Kconfig
@@ -45,6 +45,7 @@ config SPI_INTEL_SPI_PCI
 	tristate "Intel PCH/PCU SPI flash PCI driver (DANGEROUS)"
 	depends on X86 && PCI
 	select SPI_INTEL_SPI
+	select FIRMWARE_SECURITY_DATA
 	help
 	  This enables PCI support for the Intel PCH/PCU SPI controller in
 	  master mode. This controller is present in modern Intel hardware
diff --git a/drivers/mtd/spi-nor/controllers/intel-spi-pci.c b/drivers/mtd/spi-nor/controllers/intel-spi-pci.c
index 81329f680bec..f919f09de1e4 100644
--- a/drivers/mtd/spi-nor/controllers/intel-spi-pci.c
+++ b/drivers/mtd/spi-nor/controllers/intel-spi-pci.c
@@ -10,11 +10,14 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/pci.h>
+#include <linux/platform_data/firmware_security_data.h>
 
 #include "intel-spi.h"
 
 #define BCR		0xdc
 #define BCR_WPD		BIT(0)
+#define BCR_BLE		BIT(1)
+#define BCR_SMM_BWP	BIT(5)
 
 static const struct intel_spi_boardinfo bxt_info = {
 	.type = INTEL_SPI_BXT,
@@ -24,6 +27,44 @@ static const struct intel_spi_boardinfo cnl_info = {
 	.type = INTEL_SPI_CNL,
 };
 
+static ssize_t cnl_read_field(char *buf, struct pci_dev *pdev, u32 mask)
+{
+	u32 bcr;
+
+	if (pci_read_config_dword(pdev, BCR, &bcr) != PCIBIOS_SUCCESSFUL)
+		return -EIO;
+
+	return sprintf(buf, "%d\n", (int)!!(bcr & mask));
+}
+
+static ssize_t cnl_wpd_firmware_security_callbacks(char *buf,
+						   void *private_data)
+{
+	return cnl_read_field(buf, (struct pci_dev *)private_data, BCR_WPD);
+}
+
+static ssize_t cnl_ble_firmware_security_callbacks(char *buf,
+						   void *private_data)
+{
+	return cnl_read_field(buf, (struct pci_dev *)private_data, BCR_BLE);
+}
+
+static ssize_t cnl_smm_bwp_firmware_security_callbacks(char *buf,
+						       void *private_data)
+{
+	return cnl_read_field(buf, (struct pci_dev *)private_data, BCR_SMM_BWP);
+}
+
+static void register_firmware_security_data_callbacks(struct pci_dev *pdev)
+{
+	register_firmware_security_data_callback(
+		"bioswe", &cnl_wpd_firmware_security_callbacks, pdev);
+	register_firmware_security_data_callback(
+		"ble", &cnl_ble_firmware_security_callbacks, pdev);
+	register_firmware_security_data_callback(
+		"smm_bwp", &cnl_smm_bwp_firmware_security_callbacks, pdev);
+}
+
 static int intel_spi_pci_probe(struct pci_dev *pdev,
 			       const struct pci_device_id *id)
 {
@@ -50,6 +91,8 @@ static int intel_spi_pci_probe(struct pci_dev *pdev,
 	}
 	info->writeable = !!(bcr & BCR_WPD);
 
+	register_firmware_security_data_callbacks(pdev);
+
 	ispi = intel_spi_probe(&pdev->dev, &pdev->resource[0], info);
 	if (IS_ERR(ispi))
 		return PTR_ERR(ispi);
@@ -76,7 +119,7 @@ static const struct pci_device_id intel_spi_pci_ids[] = {
 	{ PCI_VDEVICE(INTEL, 0xa224), (unsigned long)&bxt_info },
 	{ PCI_VDEVICE(INTEL, 0xa324), (unsigned long)&cnl_info },
 	{ PCI_VDEVICE(INTEL, 0xa3a4), (unsigned long)&bxt_info },
-	{ },
+	{},
 };
 MODULE_DEVICE_TABLE(pci, intel_spi_pci_ids);
 
diff --git a/drivers/mtd/spi-nor/controllers/intel-spi.c b/drivers/mtd/spi-nor/controllers/intel-spi.c
index 61d2a0ad2131..939259541e75 100644
--- a/drivers/mtd/spi-nor/controllers/intel-spi.c
+++ b/drivers/mtd/spi-nor/controllers/intel-spi.c
@@ -16,6 +16,7 @@
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/spi-nor.h>
 #include <linux/platform_data/intel-spi.h>
+#include <linux/platform_data/firmware_security_data.h>
 
 #include "intel-spi.h"
 
@@ -48,17 +49,17 @@
 
 #define FADDR				0x08
 #define DLOCK				0x0c
-#define FDATA(n)			(0x10 + ((n) * 4))
+#define FDATA(n)			(0x10 + ((n)*4))
 
 #define FRACC				0x50
 
-#define FREG(n)				(0x54 + ((n) * 4))
+#define FREG(n)				(0x54 + ((n)*4))
 #define FREG_BASE_MASK			0x3fff
 #define FREG_LIMIT_SHIFT		16
 #define FREG_LIMIT_MASK			(0x03fff << FREG_LIMIT_SHIFT)
 
 /* Offset is from @ispi->pregs */
-#define PR(n)				((n) * 4)
+#define PR(n)				((n)*4)
 #define PR_WPE				BIT(31)
 #define PR_LIMIT_SHIFT			16
 #define PR_LIMIT_MASK			(0x3fff << PR_LIMIT_SHIFT)
@@ -95,6 +96,8 @@
 #define BYT_SSFSTS_CTL			0x90
 #define BYT_BCR				0xfc
 #define BYT_BCR_WPD			BIT(0)
+#define BYT_BCR_BLE			BIT(1)
+#define BYT_BCR_SMM_BWP			BIT(5)
 #define BYT_FREG_NUM			5
 #define BYT_PR_NUM			5
 
@@ -161,7 +164,8 @@ struct intel_spi {
 
 static bool writeable;
 module_param(writeable, bool, 0);
-MODULE_PARM_DESC(writeable, "Enable write access to SPI flash chip (default=0)");
+MODULE_PARM_DESC(writeable,
+		 "Enable write access to SPI flash chip (default=0)");
 
 static void intel_spi_dump_regs(struct intel_spi *ispi)
 {
@@ -179,8 +183,8 @@ static void intel_spi_dump_regs(struct intel_spi *ispi)
 	dev_dbg(ispi->dev, "DLOCK=0x%08x\n", readl(ispi->base + DLOCK));
 
 	for (i = 0; i < 16; i++)
-		dev_dbg(ispi->dev, "FDATA(%d)=0x%08x\n",
-			i, readl(ispi->base + FDATA(i)));
+		dev_dbg(ispi->dev, "FDATA(%d)=0x%08x\n", i,
+			readl(ispi->base + FDATA(i)));
 
 	dev_dbg(ispi->dev, "FRACC=0x%08x\n", readl(ispi->base + FRACC));
 
@@ -220,9 +224,8 @@ static void intel_spi_dump_regs(struct intel_spi *ispi)
 		base = value & PR_BASE_MASK;
 
 		dev_dbg(ispi->dev, " %02d base: 0x%08x limit: 0x%08x [%c%c]\n",
-			 i, base << 12, (limit << 12) | 0xfff,
-			 value & PR_WPE ? 'W' : '.',
-			 value & PR_RPE ? 'R' : '.');
+			i, base << 12, (limit << 12) | 0xfff,
+			value & PR_WPE ? 'W' : '.', value & PR_RPE ? 'R' : '.');
 	}
 
 	dev_dbg(ispi->dev, "Flash regions:\n");
@@ -237,7 +240,7 @@ static void intel_spi_dump_regs(struct intel_spi *ispi)
 			dev_dbg(ispi->dev, " %02d disabled\n", i);
 		else
 			dev_dbg(ispi->dev, " %02d base: 0x%08x limit: 0x%08x\n",
-				 i, base << 12, (limit << 12) | 0xfff);
+				i, base << 12, (limit << 12) | 0xfff);
 	}
 
 	dev_dbg(ispi->dev, "Using %cW sequencer for register access\n",
@@ -305,6 +308,52 @@ static int intel_spi_wait_sw_busy(struct intel_spi *ispi)
 				  INTEL_SPI_TIMEOUT * 1000);
 }
 
+static ssize_t byt_read_field(char *buf, const struct intel_spi *ispi, u32 mask)
+{
+	u32 val;
+
+	val = readl(ispi->base + BYT_BCR);
+	return sprintf(buf, "%d\n", (int)!!(val & mask));
+}
+
+static ssize_t byt_wpd_firmware_security_callbacks(char *buf,
+						   void *private_data)
+{
+	return byt_read_field(buf, (struct intel_spi *)private_data,
+			      BYT_BCR_WPD);
+}
+
+static ssize_t byt_ble_firmware_security_callbacks(char *buf,
+						   void *private_data)
+{
+	return byt_read_field(buf, (struct intel_spi *)private_data,
+			      BYT_BCR_BLE);
+}
+
+static ssize_t byt_smm_bwp_firmware_security_callbacks(char *buf,
+						       void *private_data)
+{
+	return byt_read_field(buf, (struct intel_spi *)private_data,
+			      BYT_BCR_SMM_BWP);
+}
+
+static void register_firmware_security_data_callbacks(struct intel_spi *ispi)
+{
+	switch (ispi->info->type) {
+	case INTEL_SPI_BYT:
+		register_firmware_security_data_callback(
+			"bioswe", &byt_wpd_firmware_security_callbacks, ispi);
+		register_firmware_security_data_callback(
+			"ble", &byt_ble_firmware_security_callbacks, ispi);
+		register_firmware_security_data_callback(
+			"smm_bwp", &byt_smm_bwp_firmware_security_callbacks,
+			ispi);
+		break;
+	default:
+		break; /* TODO. not yet implemented. */
+	}
+}
+
 static int intel_spi_init(struct intel_spi *ispi)
 {
 	u32 opmenu0, opmenu1, lvscc, uvscc, val;
@@ -383,7 +432,8 @@ static int intel_spi_init(struct intel_spi *ispi)
 			ispi->erase_64k = false;
 
 	if (ispi->sregs == NULL && (ispi->swseq_reg || ispi->swseq_erase)) {
-		dev_err(ispi->dev, "software sequencer not supported, but required\n");
+		dev_err(ispi->dev,
+			"software sequencer not supported, but required\n");
 		return -EINVAL;
 	}
 
@@ -422,6 +472,8 @@ static int intel_spi_init(struct intel_spi *ispi)
 
 	intel_spi_dump_regs(ispi);
 
+	register_firmware_security_data_callbacks(ispi);
+
 	return 0;
 }
 
@@ -538,7 +590,6 @@ static int intel_spi_sw_cycle(struct intel_spi *ispi, u8 opcode, size_t len,
 		default:
 			return -EINVAL;
 		}
-
 	}
 	writel(val, ispi->sregs + SSFSTS_CTL);
 
@@ -655,7 +706,8 @@ static ssize_t intel_spi_read(struct spi_nor *nor, loff_t from, size_t len,
 
 		/* Read cannot cross 4K boundary */
 		block_size = min_t(loff_t, from + block_size,
-				   round_up(from + 1, SZ_4K)) - from;
+				   round_up(from + 1, SZ_4K)) -
+			     from;
 
 		writel(from, ispi->base + FADDR);
 
@@ -712,7 +764,8 @@ static ssize_t intel_spi_write(struct spi_nor *nor, loff_t to, size_t len,
 
 		/* Write cannot cross 4K boundary */
 		block_size = min_t(loff_t, to + block_size,
-				   round_up(to + 1, SZ_4K)) - to;
+				   round_up(to + 1, SZ_4K)) -
+			     to;
 
 		writel(to, ispi->base + FADDR);
 
@@ -779,8 +832,8 @@ static int intel_spi_erase(struct spi_nor *nor, loff_t offs)
 		while (len > 0) {
 			writel(offs, ispi->base + FADDR);
 
-			ret = intel_spi_sw_cycle(ispi, nor->erase_opcode,
-						 0, OPTYPE_WRITE_WITH_ADDR);
+			ret = intel_spi_sw_cycle(ispi, nor->erase_opcode, 0,
+						 OPTYPE_WRITE_WITH_ADDR);
 			if (ret)
 				return ret;
 
@@ -894,12 +947,11 @@ static const struct spi_nor_controller_ops intel_spi_controller_ops = {
 	.erase = intel_spi_erase,
 };
 
-struct intel_spi *intel_spi_probe(struct device *dev,
-	struct resource *mem, const struct intel_spi_boardinfo *info)
+struct intel_spi *intel_spi_probe(struct device *dev, struct resource *mem,
+				  const struct intel_spi_boardinfo *info)
 {
 	const struct spi_nor_hwcaps hwcaps = {
-		.mask = SNOR_HWCAPS_READ |
-			SNOR_HWCAPS_READ_FAST |
+		.mask = SNOR_HWCAPS_READ | SNOR_HWCAPS_READ_FAST |
 			SNOR_HWCAPS_PP,
 	};
 	struct mtd_partition part;
diff --git a/include/linux/platform_data/firmware_security_data.h b/include/linux/platform_data/firmware_security_data.h
new file mode 100644
index 000000000000..a73b286644d0
--- /dev/null
+++ b/include/linux/platform_data/firmware_security_data.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Firmware security data kernel module
+ *
+ * Copyright (C) 2020 Daniel Gutson <daniel.gutson@eclypsium.com>
+ * Copyright (C) 2020 Eclypsium Inc.
+ */
+#ifndef FIRMWARE_SECURITY_DATA_H
+#define FIRMWARE_SECURITY_DATA_H
+
+#include <linux/types.h>
+
+extern int register_firmware_security_data_callback(
+	const char *name, ssize_t (*callback)(char *buf, void *private_data),
+	void *private_data);
+
+#endif /* FIRMWARE_SECURITY_DATA_H */
-- 
2.25.1

