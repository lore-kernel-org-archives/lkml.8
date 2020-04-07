Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38EB4C2BA16
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 08:30:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1DCE206C0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 08:30:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="c8zxkUo6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbgDGIam (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 04:30:42 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45159 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726637AbgDGIam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 04:30:42 -0400
Received: by mail-wr1-f65.google.com with SMTP id v5so2770658wrp.12
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 01:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1rLkkWBeHYVkUgXRLxwh4vhm1yAC8NAtadLpWozmeG4=;
        b=c8zxkUo6Df+hygxHgOjZtp2Dln/vY2cPgAyyx1mGzhn672X7z0ugiGi2UQ7caMPvge
         BatPAJbWke4rsggK/rulkMAIvCUa98Zx3+HGBb6s8rDtL841+/qjNeyGgwLnERqvZYey
         NiyjZF/HacUthhLuJg5zj4JKk5iwlFJ3k9oS0ErMB7omt5IP3OglLugcftto7c1+Qpho
         3lCsyMe1NJmUvOWxTdSqSTSuzcmZOE7/1RV1y4VSsXFCc7UhyJsAIyZBHieT/k6N2o02
         7N5BhWs1UOScjsAnOK60OlPmfyQXz9x/4JUEbOk0feXfN5WCLX3R7XA7ZLn86CdlwtZU
         cyFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1rLkkWBeHYVkUgXRLxwh4vhm1yAC8NAtadLpWozmeG4=;
        b=dR0/nD0ppd0XmzPaSSrXC0/RHIHJ39nyqYTcrfXjxOKotoK5VmZ22gKR8k0ZjJuxUw
         sV/DRe+VgI/7fKu4EN6qyDSvzVtBnQ4BRCOdHHVtzrJPxlD6etq/2miBku9Wub+Vwq80
         V36Ug4jiSUIwqt5FO6vo15LxWcRQ+kyUn4q2MCSSUuTLfNNPzJXO3eTd1vqvrQB4T71G
         5FfBlow1YVYGfFchcZebcrx6PJLys8tLBn9C3xd8YhDTjrrX5rWYADz5sE32SWPDJvTl
         mxiwIAAC2w2qP1jP/wAGTTUK2r87biTU1BrwmN7svZzNGyRfUA+/wxxItpRcNgft1U35
         INgA==
X-Gm-Message-State: AGi0Pua7f0k5QWIdZOWj0SXw+VzY76CtLNx8ieXECbgMDqYyuqPXXVyn
        C1wzE86kvb+SbCDX7Af08L3n5CvLXcTCxGsF
X-Google-Smtp-Source: APiQypJ6IrOou+wKZONpEtuM1AMe3pMhhBOldySSfaewts3glqvnbyGLNuefIRljWyrkUKriysAh2w==
X-Received: by 2002:adf:9d8a:: with SMTP id p10mr1406666wre.190.1586248238087;
        Tue, 07 Apr 2020 01:30:38 -0700 (PDT)
Received: from localhost.localdomain (ip-94-114-101-228.unity-media.net. [94.114.101.228])
        by smtp.gmail.com with ESMTPSA id t16sm31190743wra.17.2020.04.07.01.30.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 01:30:37 -0700 (PDT)
From:   patrick.rudolph@9elements.com
To:     linux-kernel@vger.kernel.org
Cc:     coreboot@coreboot.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Allison Randal <allison@lohutok.net>,
        Julius Werner <jwerner@chromium.org>,
        Samuel Holland <samuel@sholland.org>,
        Stephen Boyd <swboyd@chromium.org>
Subject: [PATCH v4 1/2] firmware: google: Expose CBMEM over sysfs
Date:   Tue,  7 Apr 2020 10:29:06 +0200
Message-Id: <20200407082923.2001556-2-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200407082923.2001556-1-patrick.rudolph@9elements.com>
References: <20200407082923.2001556-1-patrick.rudolph@9elements.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrick Rudolph <patrick.rudolph@9elements.com>

Make all CBMEM buffers available to userland. This is useful for tools
that are currently using /dev/mem.

Make the id, size and address available, as well as the raw table data.

Tools can easily scan the right CBMEM buffer by reading
/sys/bus/coreboot/drivers/cbmem/coreboot*/cbmem_attributes/id
or
/sys/bus/coreboot/devices/coreboot*/cbmem_attributes/id

The binary table data can then be read from
/sys/bus/coreboot/drivers/cbmem/coreboot*/cbmem_attributes/data
or
/sys/bus/coreboot/devices/coreboot*/cbmem_attributes/data

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
---
 -v2:
        - Add ABI documentation
        - Add 0x prefix on hex values
 -v3:
        - Use BIN_ATTR_RO
 -v4:
        - Use temporary memremap instead of persistent ioremap
        - Constify a struct
        - Get rid of unused headers
        - Use dev_{get|set}_drvdata
        - Use dev_groups to automatically handle attributes
        - Updated file description
        - Updated ABI documentation
---
 Documentation/ABI/stable/sysfs-bus-coreboot |  44 +++++++
 drivers/firmware/google/Kconfig             |   9 ++
 drivers/firmware/google/Makefile            |   1 +
 drivers/firmware/google/cbmem-coreboot.c    | 128 ++++++++++++++++++++
 drivers/firmware/google/coreboot_table.h    |  14 +++
 5 files changed, 196 insertions(+)
 create mode 100644 Documentation/ABI/stable/sysfs-bus-coreboot
 create mode 100644 drivers/firmware/google/cbmem-coreboot.c

diff --git a/Documentation/ABI/stable/sysfs-bus-coreboot b/Documentation/ABI/stable/sysfs-bus-coreboot
new file mode 100644
index 000000000000..6055906f41f2
--- /dev/null
+++ b/Documentation/ABI/stable/sysfs-bus-coreboot
@@ -0,0 +1,44 @@
+What:		/sys/bus/coreboot/devices/.../cbmem_attributes/id
+Date:		Apr 2020
+KernelVersion:	5.6
+Contact:	Patrick Rudolph <patrick.rudolph@9elements.com>
+Description:
+		coreboot device directory can contain a file named
+		cbmem_attributes/id if the device corresponds to a CBMEM
+		buffer.
+		The file holds an ASCII representation of the CBMEM ID in hex
+		(e.g. 0xdeadbeef).
+
+What:		/sys/bus/coreboot/devices/.../cbmem_attributes/size
+Date:		Apr 2020
+KernelVersion:	5.6
+Contact:	Patrick Rudolph <patrick.rudolph@9elements.com>
+Description:
+		coreboot device directory can contain a file named
+		cbmem_attributes/size if the device corresponds to a CBMEM
+		buffer.
+		The file holds an representation as decimal number of the
+		CBMEM buffer size (e.g. 64).
+
+What:		/sys/bus/coreboot/devices/.../cbmem_attributes/address
+Date:		Apr 2020
+KernelVersion:	5.6
+Contact:	Patrick Rudolph <patrick.rudolph@9elements.com>
+Description:
+		coreboot device directory can contain a file named
+		cbmem_attributes/address if the device corresponds to a CBMEM
+		buffer.
+		The file holds an ASCII representation of the physical address
+		of the CBMEM buffer in hex (e.g. 0x000000008000d000) and should
+		be used for debugging only.
+
+What:		/sys/bus/coreboot/devices/.../cbmem_attributes/data
+Date:		Apr 2020
+KernelVersion:	5.6
+Contact:	Patrick Rudolph <patrick.rudolph@9elements.com>
+Description:
+		coreboot device directory can contain a file named
+		cbmem_attributes/data if the device corresponds to a CBMEM
+		buffer.
+		The file holds a read-only binary representation of the CBMEM
+		buffer.
diff --git a/drivers/firmware/google/Kconfig b/drivers/firmware/google/Kconfig
index a3a6ca659ffa..11a67c397ab3 100644
--- a/drivers/firmware/google/Kconfig
+++ b/drivers/firmware/google/Kconfig
@@ -58,6 +58,15 @@ config GOOGLE_FRAMEBUFFER_COREBOOT
 	  This option enables the kernel to search for a framebuffer in
 	  the coreboot table.  If found, it is registered with simplefb.
 
+config GOOGLE_CBMEM_COREBOOT
+	tristate "Coreboot CBMEM access"
+	depends on GOOGLE_COREBOOT_TABLE
+	help
+	  This option exposes all available CBMEM buffers to userland.
+	  The CBMEM id, size and address as well as the raw table data
+	  are exported as sysfs attributes of the corresponding coreboot
+	  table.
+
 config GOOGLE_MEMCONSOLE_COREBOOT
 	tristate "Firmware Memory Console"
 	depends on GOOGLE_COREBOOT_TABLE
diff --git a/drivers/firmware/google/Makefile b/drivers/firmware/google/Makefile
index d17caded5d88..62053cd6d058 100644
--- a/drivers/firmware/google/Makefile
+++ b/drivers/firmware/google/Makefile
@@ -2,6 +2,7 @@
 
 obj-$(CONFIG_GOOGLE_SMI)		+= gsmi.o
 obj-$(CONFIG_GOOGLE_COREBOOT_TABLE)        += coreboot_table.o
+obj-$(CONFIG_GOOGLE_CBMEM_COREBOOT)        += cbmem-coreboot.o
 obj-$(CONFIG_GOOGLE_FRAMEBUFFER_COREBOOT)  += framebuffer-coreboot.o
 obj-$(CONFIG_GOOGLE_MEMCONSOLE)            += memconsole.o
 obj-$(CONFIG_GOOGLE_MEMCONSOLE_COREBOOT)   += memconsole-coreboot.o
diff --git a/drivers/firmware/google/cbmem-coreboot.c b/drivers/firmware/google/cbmem-coreboot.c
new file mode 100644
index 000000000000..f76704a6eec7
--- /dev/null
+++ b/drivers/firmware/google/cbmem-coreboot.c
@@ -0,0 +1,128 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * cbmem-coreboot.c
+ *
+ * Exports CBMEM as attributes in sysfs.
+ *
+ * Copyright 2012-2013 David Herrmann <dh.herrmann@gmail.com>
+ * Copyright 2017 Google Inc.
+ * Copyright 2019 9elements Agency GmbH
+ */
+
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include <linux/module.h>
+#include <linux/io.h>
+
+#include "coreboot_table.h"
+
+#define CB_TAG_CBMEM_ENTRY 0x31
+
+struct cb_priv {
+	struct lb_cbmem_entry entry;
+};
+
+static ssize_t id_show(struct device *dev,
+		       struct device_attribute *attr, char *buffer)
+{
+	const struct cb_priv *priv = dev_get_drvdata(dev);
+
+	return sprintf(buffer, "%#08x\n", priv->entry.id);
+}
+
+static ssize_t size_show(struct device *dev,
+			 struct device_attribute *attr, char *buffer)
+{
+	const struct cb_priv *priv = dev_get_drvdata(dev);
+
+	return sprintf(buffer, "%u\n", priv->entry.entry_size);
+}
+
+static ssize_t address_show(struct device *dev,
+			    struct device_attribute *attr, char *buffer)
+{
+	const struct cb_priv *priv = dev_get_drvdata(dev);
+
+	return sprintf(buffer, "%#016llx\n", priv->entry.address);
+}
+
+static DEVICE_ATTR_RO(id);
+static DEVICE_ATTR_RO(size);
+static DEVICE_ATTR_RO(address);
+
+static struct attribute *cb_mem_attrs[] = {
+	&dev_attr_address.attr,
+	&dev_attr_id.attr,
+	&dev_attr_size.attr,
+	NULL
+};
+
+static ssize_t data_read(struct file *filp, struct kobject *kobj,
+			 struct bin_attribute *bin_attr,
+			 char *buffer, loff_t offset, size_t count)
+{
+	const struct device *dev = kobj_to_dev(kobj);
+	const struct cb_priv *priv = dev_get_drvdata(dev);
+	void *ptr;
+
+	/* CBMEM is always RAM with unknown caching attributes. */
+	ptr = memremap(priv->entry.address, priv->entry.entry_size,
+		       MEMREMAP_WB | MEMREMAP_WT);
+	if (!ptr)
+		return -ENOMEM;
+
+	count = memory_read_from_buffer(buffer, count, &offset, ptr,
+					priv->entry.entry_size);
+	memunmap(ptr);
+
+	return count;
+}
+
+static BIN_ATTR_RO(data, 0);
+
+static struct bin_attribute *cb_mem_bin_attrs[] = {
+	&bin_attr_data,
+	NULL
+};
+
+static const struct attribute_group cb_mem_attr_group = {
+	.name = "cbmem_attributes",
+	.attrs = cb_mem_attrs,
+	.bin_attrs = cb_mem_bin_attrs,
+};
+
+static const struct attribute_group *attribute_groups[] = {
+	&cb_mem_attr_group,
+	NULL,
+};
+
+static int cbmem_probe(struct coreboot_device *cdev)
+{
+	struct device *dev = &cdev->dev;
+	struct cb_priv *priv;
+
+	priv = devm_kmalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	memcpy(&priv->entry, &cdev->cbmem_entry, sizeof(priv->entry));
+
+	dev_set_drvdata(dev, priv);
+
+	return 0;
+}
+
+static struct coreboot_driver cbmem_driver = {
+	.probe = cbmem_probe,
+	.drv = {
+		.name = "cbmem",
+		.dev_groups = attribute_groups,
+	},
+	.tag = CB_TAG_CBMEM_ENTRY,
+};
+
+module_coreboot_driver(cbmem_driver);
+
+MODULE_AUTHOR("9elements Agency GmbH");
+MODULE_LICENSE("GPL");
diff --git a/drivers/firmware/google/coreboot_table.h b/drivers/firmware/google/coreboot_table.h
index 7b7b4a6eedda..fc20b8649882 100644
--- a/drivers/firmware/google/coreboot_table.h
+++ b/drivers/firmware/google/coreboot_table.h
@@ -59,6 +59,19 @@ struct lb_framebuffer {
 	u8  reserved_mask_size;
 };
 
+/*
+ * There can be more than one of these records as there is one per cbmem entry.
+ * Describes a buffer in memory containing runtime data.
+ */
+struct lb_cbmem_entry {
+	u32 tag;
+	u32 size;
+
+	u64 address;
+	u32 entry_size;
+	u32 id;
+};
+
 /* A device, additionally with information from coreboot. */
 struct coreboot_device {
 	struct device dev;
@@ -66,6 +79,7 @@ struct coreboot_device {
 		struct coreboot_table_entry entry;
 		struct lb_cbmem_ref cbmem_ref;
 		struct lb_framebuffer framebuffer;
+		struct lb_cbmem_entry cbmem_entry;
 	};
 };
 
-- 
2.24.1

