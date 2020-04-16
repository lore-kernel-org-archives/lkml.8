Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C692C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 16:44:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14B48206B9
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 16:44:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728531AbgDPQoJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 12:44:09 -0400
Received: from mx-relay75-hz1.antispameurope.com ([94.100.132.238]:32796 "EHLO
        mx-relay75-hz1.antispameurope.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725833AbgDPQoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 12:44:06 -0400
X-Greylist: delayed 320 seconds by postgrey-1.27 at vger.kernel.org; Thu, 16 Apr 2020 12:44:04 EDT
Received: from mailgw1.iis.fraunhofer.de ([153.96.172.4]) by mx-relay75-hz1.antispameurope.com;
 Thu, 16 Apr 2020 18:38:41 +0200
Received: from mail.iis.fraunhofer.de (mail01.iis.fhg.de [153.96.171.211])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailgw1.iis.fraunhofer.de (Postfix) with ESMTPS id 6B8D22400081;
        Thu, 16 Apr 2020 18:38:36 +0200 (CEST)
Received: from mail01.iis.fhg.de (2001:638:a0a:1111:fd91:8c2a:e4a5:e74e) by
 mail01.iis.fhg.de (2001:638:a0a:1111:fd91:8c2a:e4a5:e74e) with Microsoft SMTP
 Server (TLS) id 15.0.1395.4; Thu, 16 Apr 2020 18:38:36 +0200
Received: from un1028x.fritz.box (153.96.171.210) by mail01.iis.fhg.de
 (153.96.171.211) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 16 Apr 2020 18:38:36 +0200
From:   Manuel Stahl <manuel.stahl@iis-extern.fraunhofer.de>
To:     <linux-kernel@vger.kernel.org>
CC:     "hjk @ linutronix . de" <hjk@linutronix.de>,
        "devel @ driverdev . osuosl . org" <devel@driverdev.osuosl.org>,
        "gregkh @ linuxfoundation . org" <gregkh@linuxfoundation.org>,
        "sojkam1 @ fel . cvut . cz" <sojkam1@fel.cvut.cz>,
        Manuel Stahl <manuel.stahl@iis-extern.fraunhofer.de>,
        Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
Subject: [PATCH v4] Add new uio device for PCI with dynamic memory allocation
Date:   Thu, 16 Apr 2020 18:38:30 +0200
Message-ID: <20200416163830.30623-1-manuel.stahl@iis-extern.fraunhofer.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <1507296707.2915.14.camel@iis-extern.fraunhofer.de>
References: <1507296707.2915.14.camel@iis-extern.fraunhofer.de>
MIME-Version: 1.0
Content-Type: text/plain
X-cloud-security-sender: manuel.stahl@iis-extern.fraunhofer.de
X-cloud-security-recipient: linux-kernel@vger.kernel.org
X-cloud-security-crypt: load encryption module
X-cloud-security-Virusscan: CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay75-hz1.antispameurope.com with 8F42912C0400
X-cloud-security-connect: mailgw1.iis.fraunhofer.de[153.96.172.4], TLS=1, IP=153.96.172.4
X-cloud-security: scantime:.3268
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This device combines the uio_pci_generic driver and the uio_dmem_genirq
driver since PCI uses a slightly different API for interrupts.
A fixed number of DMA capable memory regions can be defined using the
module parameter "dmem_sizes". The memory is not allocated until the uio
device file is opened for the first time. When the device file is closed,
the allocated memory block is freed. Physical (DMA) addresses for the
dynamic regions are provided to the userspace via
/sys/class/uio/uioX/maps/mapY/addr
When no processes are holding the device file open, the address returned
to userspace is DMA_ERROR_CODE.

Signed-off-by: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
---
 MAINTAINERS                       |   6 +
 drivers/uio/Kconfig               |   9 +
 drivers/uio/Makefile              |   1 +
 drivers/uio/uio_pci_dmem_genirq.c | 351 ++++++++++++++++++++++++++++++
 4 files changed, 367 insertions(+)
 create mode 100644 drivers/uio/uio_pci_dmem_genirq.c

diff --git a/MAINTAINERS b/MAINTAINERS
index e64e5db31497..446931530dbc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7149,6 +7149,12 @@ L:	kvm@vger.kernel.org
 S:	Supported
 F:	drivers/uio/uio_pci_generic.c
 
+GENERIC UIO DRIVER FOR PCI DEVICES WITH DMA
+M:	"Manuel Stahl" <manuel.stahl@iis.fraunhofer.de>
+L:	kvm@vger.kernel.org
+S:	Supported
+F:	drivers/uio/uio_pci_dmem_genirq.c
+
 GENERIC VDSO LIBRARY
 M:	Andy Lutomirski <luto@kernel.org>
 M:	Thomas Gleixner <tglx@linutronix.de>
diff --git a/drivers/uio/Kconfig b/drivers/uio/Kconfig
index 202ee81cfc2b..0d3f8a01ec74 100644
--- a/drivers/uio/Kconfig
+++ b/drivers/uio/Kconfig
@@ -94,6 +94,15 @@ config UIO_PCI_GENERIC
 	  primarily, for virtualization scenarios.
 	  If you compile this as a module, it will be called uio_pci_generic.
 
+config UIO_PCI_DMEM_GENIRQ
+	tristate "Generic driver for PCI 2.3 and PCI Express cards with DMA"
+	depends on PCI
+	help
+	  Generic driver that you can bind, dynamically, to any
+	  PCI 2.3 compliant and PCI Express card. It is useful
+	  for FPGAs with DMA capability connected via PCI.
+	  If you compile this as a module, it will be called uio_pci_dmem_genirq.
+
 config UIO_NETX
 	tristate "Hilscher NetX Card driver"
 	depends on PCI
diff --git a/drivers/uio/Makefile b/drivers/uio/Makefile
index c285dd2a4539..202d6bfdd5aa 100644
--- a/drivers/uio/Makefile
+++ b/drivers/uio/Makefile
@@ -6,6 +6,7 @@ obj-$(CONFIG_UIO_DMEM_GENIRQ)	+= uio_dmem_genirq.o
 obj-$(CONFIG_UIO_AEC)	+= uio_aec.o
 obj-$(CONFIG_UIO_SERCOS3)	+= uio_sercos3.o
 obj-$(CONFIG_UIO_PCI_GENERIC)	+= uio_pci_generic.o
+obj-$(CONFIG_UIO_PCI_DMEM_GENIRQ)	+= uio_pci_dmem_genirq.o
 obj-$(CONFIG_UIO_NETX)	+= uio_netx.o
 obj-$(CONFIG_UIO_PRUSS)         += uio_pruss.o
 obj-$(CONFIG_UIO_MF624)         += uio_mf624.o
diff --git a/drivers/uio/uio_pci_dmem_genirq.c b/drivers/uio/uio_pci_dmem_genirq.c
new file mode 100644
index 000000000000..be1bdcc552fe
--- /dev/null
+++ b/drivers/uio/uio_pci_dmem_genirq.c
@@ -0,0 +1,351 @@
+// SPDX-License-Identifier: GPL-2.0
+/* uio_pci_generic - generic UIO driver for PCI 2.3 devices with DMA memory
+ *
+ * Copyright (C) 2016 Fraunhofer IIS
+ * Author: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
+ *
+ * Based on uio_pci_generic.c by Michael S. Tsirkin
+ * and uio_dmem_genirq.c by Damian Hobson-Garcia.
+ *
+ * Since the driver does not declare any device ids, you must allocate
+ * id and bind the device to the driver yourself.  For example:
+ *
+ * # echo "8086 10f5" > /sys/bus/pci/drivers/uio_pci_dmem_genirq/new_id
+ * # echo -n 0000:00:19.0 > /sys/bus/pci/drivers/e1000e/unbind
+ * # echo -n 0000:00:19.0 > /sys/bus/pci/drivers/uio_pci_dmem_genirq/bind
+ * # ls -l /sys/bus/pci/devices/0000:00:19.0/driver
+ * .../0000:00:19.0/driver -> ../../../bus/pci/drivers/uio_pci_dmem_genirq
+ *
+ * Or use a modprobe alias:
+ * # alias pci:v000010EEd00001000sv*sd*sc*i* uio_pci_dmem_genirq
+ *
+ * Driver won't bind to devices which do not support the Interrupt Disable Bit
+ * in the command register. All devices compliant to PCI 2.3 (circa 2002) and
+ * all compliant PCI Express devices should support this bit.
+ *
+ * The DMA mask bits and sizes of dynamic regions are derived from module
+ * parameters.
+ *
+ * The format for specifying dynamic region sizes in module parameters
+ * is as follows:
+ *
+ * uio_pci_dmem_genirq.dmem_sizes := <uio_dmem_sizes_def>[;<uio_dmem_sizes_def>]
+ * <uio_dmem_sizes_def>           := <pci_id>:<size>[,<size>]
+ * <pci_id>                       := <vendor>:<device>
+ * <size>                         := standard linux memsize
+ *
+ * Examples:
+ *
+ * 1) UIO dmem device with 3 dynamic regions:
+ * uio_pci_dmem_genirq.dmem_sizes=8086:10f5:4K,16K,4M
+ *
+ * 2) Two UIO dmem devices with different number of dynamic regions:
+ * uio_pci_dmem_genirq.dmem_sizes=8086:10f5:4K,16K,4M;1234:0001:8K
+ */
+
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/slab.h>
+#include <linux/uio_driver.h>
+#include <linux/bitops.h>
+#include <linux/interrupt.h>
+#include <linux/stringify.h>
+#include <linux/dma-mapping.h>
+
+#define DRIVER_VERSION  "0.01.0"
+#define DRIVER_AUTHOR   "Manuel Stahl <manuel.stahl@iis.fraunhofer.de>"
+#define DRIVER_DESC "Generic UIO driver for PCI 2.3 devices with DMA memory"
+#define DRIVER_NAME "uio_pci_dmem_genirq"
+#define DMEM_MAP_ERROR (~0)
+
+struct uio_pci_dmem_dev {
+	struct uio_info info;
+	struct pci_dev *pdev;
+	void *dmem_region_vaddr[MAX_UIO_MAPS];
+	unsigned int refcnt;
+	struct mutex alloc_lock; /* mutex for dmem_region_vaddr and refcnt */
+};
+
+static inline struct uio_pci_dmem_dev *
+to_uio_pci_dmem_dev(struct uio_info *info)
+{
+	return container_of(info, struct uio_pci_dmem_dev, info);
+}
+
+static int open(struct uio_info *info, struct inode *inode)
+{
+	struct uio_pci_dmem_dev *priv = to_uio_pci_dmem_dev(info);
+	struct uio_mem *uiomem;
+	int dmem_region = 0;
+
+	uiomem = &priv->info.mem[dmem_region];
+
+	mutex_lock(&priv->alloc_lock);
+	while (!priv->refcnt && uiomem < &priv->info.mem[MAX_UIO_MAPS]) {
+		void *addr;
+
+		if (!uiomem->size)
+			break;
+
+		addr = dma_alloc_coherent(&priv->pdev->dev, uiomem->size,
+					  (dma_addr_t *)&uiomem->addr,
+					  GFP_KERNEL);
+		if (!addr)
+			uiomem->addr = DMEM_MAP_ERROR;
+
+		priv->dmem_region_vaddr[dmem_region++] = addr;
+		++uiomem;
+	}
+	if (pci_check_and_mask_intx(priv->pdev))
+		dev_info(&priv->pdev->dev, "Found pending interrupt");
+
+	if (!priv->refcnt)
+		pci_set_master(priv->pdev);
+
+	priv->refcnt++;
+
+	mutex_unlock(&priv->alloc_lock);
+
+	return 0;
+}
+
+static int release(struct uio_info *info, struct inode *inode)
+{
+	struct uio_pci_dmem_dev *priv = to_uio_pci_dmem_dev(info);
+	struct uio_mem *uiomem;
+	int dmem_region = 0;
+
+	uiomem = &priv->info.mem[dmem_region];
+
+	mutex_lock(&priv->alloc_lock);
+
+	priv->refcnt--;
+	while (!priv->refcnt && uiomem < &priv->info.mem[MAX_UIO_MAPS]) {
+		if (!uiomem->size)
+			break;
+		if (priv->dmem_region_vaddr[dmem_region]) {
+			dma_free_coherent(&priv->pdev->dev, uiomem->size,
+					  priv->dmem_region_vaddr[dmem_region],
+					  uiomem->addr);
+		}
+		uiomem->addr = DMEM_MAP_ERROR;
+		++dmem_region;
+		++uiomem;
+	}
+	if (pci_check_and_mask_intx(priv->pdev))
+		dev_info(&priv->pdev->dev, "Found pending interrupt");
+
+	if (!priv->refcnt)
+		pci_clear_master(priv->pdev);
+
+	mutex_unlock(&priv->alloc_lock);
+	return 0;
+}
+
+static int dmem_mmap(struct uio_info *info, struct vm_area_struct *vma)
+{
+	struct uio_pci_dmem_dev *gdev = to_uio_pci_dmem_dev(info->priv);
+	struct uio_mem *uiomem;
+	int mi = vma->vm_pgoff;
+
+	if (mi >= MAX_UIO_MAPS)
+		return -EINVAL;
+
+	uiomem = &info->mem[mi];
+	if (uiomem->memtype != UIO_MEM_PHYS)
+		return -EINVAL;
+	if (!uiomem->size)
+		return -EINVAL;
+
+	/* DMA address */
+	vma->vm_pgoff = 0;
+	return dma_mmap_coherent(&gdev->pdev->dev, vma,
+				 gdev->dmem_region_vaddr[mi],
+				 uiomem->addr, uiomem->size);
+}
+
+/* Interrupt handler. Read/modify/write the command register to disable the
+ * interrupt.
+ */
+static irqreturn_t irqhandler(int irq, struct uio_info *info)
+{
+	struct uio_pci_dmem_dev *gdev = to_uio_pci_dmem_dev(info);
+
+	if (!pci_check_and_mask_intx(gdev->pdev))
+		return IRQ_NONE;
+
+	/* UIO core will signal the user process. */
+	return IRQ_HANDLED;
+}
+
+static unsigned int uio_dmem_dma_bits = 32;
+static char uio_dmem_sizes[256];
+
+static int parse_dmem_entries(struct pci_dev *pdev,
+			      const struct pci_device_id *id,
+			      struct uio_pci_dmem_dev *gdev)
+{
+	int ret;
+	u32 regions = 0;
+	u32 vendor, device;
+	char *s, *tok, *sizes = NULL;
+	unsigned long long size;
+	struct uio_mem *uiomem;
+	char * const buf = kstrdup(uio_dmem_sizes, GFP_KERNEL);
+
+	if (!buf)
+		return -ENOMEM;
+
+	/* Find-out start and end of sizes list */
+	s = buf;
+	while (*s != '\0') {
+		sizes = NULL;
+		tok = strsep(&s, ":");
+		if (!tok)
+			break;
+		ret = kstrtou32(tok, 16, &vendor);
+		if (ret)
+			break;
+		tok = strsep(&s, ":");
+		if (!tok)
+			break;
+		ret = kstrtou32(tok, 16, &device);
+		if (ret)
+			break;
+		sizes = strsep(&s, ";");
+		if (vendor == id->vendor && device == id->device)
+			break;
+	}
+
+	memset(gdev->info.mem, 0, sizeof(gdev->info.mem));
+	if (sizes) {
+		dev_info(&pdev->dev, "Regions: %s\n", sizes);
+
+		/* Parse dynamic regions from sizes list */
+		regions = 0;
+		size = 0;
+		s = sizes;
+		while (s && (regions < MAX_UIO_MAPS)) {
+			tok = strsep(&s, ",");
+			if (!tok)
+				break;
+
+			size = memparse(tok, NULL);
+			if (size) {
+				uiomem = &gdev->info.mem[regions];
+				uiomem->memtype = UIO_MEM_PHYS;
+				/* Will be allocated in open() call */
+				uiomem->addr = DMEM_MAP_ERROR;
+				uiomem->size = size;
+				regions++;
+			}
+		}
+		if (s)
+			dev_warn(&pdev->dev, "device has more than "
+					__stringify(MAX_UIO_MAPS)
+					" dynamic memory regions.\n");
+	}
+	dev_info(&pdev->dev, "Found %d regions\n", regions);
+
+	kfree(buf);
+	return ret;
+}
+
+static int probe(struct pci_dev *pdev, const struct pci_device_id *id)
+{
+	struct uio_pci_dmem_dev *gdev;
+	int err;
+
+	dev_info(&pdev->dev, "Probe %s for %04x:%04x\n", DRIVER_NAME,
+		 id->vendor, id->device);
+
+	err = pci_enable_device(pdev);
+	if (err) {
+		dev_err(&pdev->dev, "%s: pci_enable_device failed: %d\n",
+			__func__, err);
+		return err;
+	}
+	pci_set_master(pdev);
+
+	dev_info(&pdev->dev, "Legacy IRQ: %i", pdev->irq);
+	if (pdev->irq && !pci_intx_mask_supported(pdev)) {
+		err = -ENODEV;
+		goto err_disable_pci;
+	}
+
+	gdev = kzalloc(sizeof(*gdev), GFP_KERNEL);
+	if (!gdev) {
+		err = -ENOMEM;
+		goto err_disable_pci;
+	}
+
+	gdev->info.name = DRIVER_NAME;
+	gdev->info.version = DRIVER_VERSION;
+	gdev->info.irq = pdev->irq;
+	gdev->info.irq_flags = IRQF_SHARED;
+	gdev->info.handler = irqhandler;
+	gdev->info.open = open;
+	gdev->info.release = release;
+	gdev->info.mmap = dmem_mmap;
+	gdev->info.priv = gdev;
+	gdev->pdev = pdev;
+
+	/* Set DMA coherent mask */
+	if (uio_dmem_dma_bits > 64)
+		uio_dmem_dma_bits = 64;
+	err = dma_set_coherent_mask(&pdev->dev,
+				    DMA_BIT_MASK(uio_dmem_dma_bits));
+	if (err) {
+		dev_err(&pdev->dev, "Unable to dma_set_coherent_mask\n");
+		goto err_free_gdev;
+	}
+
+	err = parse_dmem_entries(pdev, id, gdev);
+	if (err)
+		goto err_free_gdev;
+
+	mutex_init(&gdev->alloc_lock);
+
+	err = uio_register_device(&pdev->dev, &gdev->info);
+	if (err)
+		goto err_free_gdev;
+	pci_set_drvdata(pdev, gdev);
+
+	return 0;
+err_free_gdev:
+	kfree(gdev);
+err_disable_pci:
+	pci_clear_master(pdev);
+	pci_disable_device(pdev);
+	return err;
+}
+
+static void remove(struct pci_dev *pdev)
+{
+	struct uio_pci_dmem_dev *gdev = pci_get_drvdata(pdev);
+
+	uio_unregister_device(&gdev->info);
+	pci_clear_master(pdev);
+	pci_disable_device(pdev);
+	kfree(gdev);
+}
+
+static struct pci_driver uio_pci_driver = {
+	.name = DRIVER_NAME,
+	.id_table = NULL, /* only dynamic id's */
+	.probe = probe,
+	.remove = remove,
+};
+
+module_pci_driver(uio_pci_driver);
+
+module_param_named(dmem_dma_bits, uio_dmem_dma_bits, uint, 0444);
+MODULE_PARM_DESC(dmem_dma_bits, "Number of bits in DMA mask");
+module_param_string(dmem_sizes, uio_dmem_sizes, 256, 0444);
+MODULE_PARM_DESC(dmem_sizes, "Comma separated dynamic region sizes; e.g. 8086:10f5:4K,16K,4M;1234:0001:8K");
+
+MODULE_VERSION(DRIVER_VERSION);
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR(DRIVER_AUTHOR);
+MODULE_DESCRIPTION(DRIVER_DESC);
-- 
2.17.1

