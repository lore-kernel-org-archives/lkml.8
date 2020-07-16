Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA81C433E6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 00:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 080C720658
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 00:50:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbgGPAuK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 20:50:10 -0400
Received: from mga14.intel.com ([192.55.52.115]:57225 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727857AbgGPAuJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 20:50:09 -0400
IronPort-SDR: /TcGid7WKYd1No3DQZqnLY8jkgxk0ncDjixICXeobzbbUS3c7eH72s2EZSInVMHmzXkB346wf2
 9nrYVut8ZfQA==
X-IronPort-AV: E=McAfee;i="6000,8403,9683"; a="148445958"
X-IronPort-AV: E=Sophos;i="5.75,357,1589266800"; 
   d="scan'208";a="148445958"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2020 17:50:05 -0700
IronPort-SDR: IYWJhrdlqZ7BKm355OKZd9/vmfwHyYzmcN7BAsNkGszMEUICA8XyuUt96hLTTwteUApj+qBPip
 DkzUB17oKdBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,357,1589266800"; 
   d="scan'208";a="316874128"
Received: from glacier.sc.intel.com ([10.3.62.63])
  by orsmga008.jf.intel.com with ESMTP; 15 Jul 2020 17:50:05 -0700
From:   Rajmohan Mani <rajmohan.mani@intel.com>
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Ayman Bagabas <ayman.bagabas@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Jithu Joseph <jithu.joseph@intel.com>,
        =?UTF-8?q?Bla=C5=BE=20Hrastnik?= <blaz@mxxn.io>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Cc:     pmalani@chromium.org, bleung@chromium.org,
        Rajmohan Mani <rajmohan.mani@intel.com>
Subject: [PATCH 1/2] platform/x86: Add Intel Input Output Manager (IOM) driver
Date:   Wed, 15 Jul 2020 17:33:09 -0700
Message-Id: <20200716003310.26125-2-rajmohan.mani@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200716003310.26125-1-rajmohan.mani@intel.com>
References: <20200716003310.26125-1-rajmohan.mani@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Input Output Manager (IOM) is part of the Tiger Lake SoC that
configures the Type-C Sub System (TCSS). IOM is a micro controller
that handles Type-C topology, configuration and PM functions of
various Type-C devices connected on the platform.

This driver helps read relevant information such as Type-C port
status (whether a device is connected to a Type-C port or not) and
the activity type on the Type-C ports (such as USB, Display Port,
Thunderbolt), for consumption by other drivers.

Currently intel_iom_port_status() API is exported by this driver,
that has information about the Type-C port status and port activity
type.

Signed-off-by: Rajmohan Mani <rajmohan.mani@intel.com>
---
 drivers/platform/x86/Kconfig                |  16 +++
 drivers/platform/x86/Makefile               |   1 +
 drivers/platform/x86/intel_iom.c            | 133 ++++++++++++++++++++
 include/linux/platform_data/x86/intel_iom.h |  62 +++++++++
 4 files changed, 212 insertions(+)
 create mode 100644 drivers/platform/x86/intel_iom.c
 create mode 100644 include/linux/platform_data/x86/intel_iom.h

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 0581a54cf562..271feddb20ef 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -816,6 +816,22 @@ config INTEL_INT0002_VGPIO
 	  To compile this driver as a module, choose M here: the module will
 	  be called intel_int0002_vgpio.
 
+config INTEL_IOM
+	tristate "Intel Input Output Manager (IOM) driver"
+	depends on ACPI && PCI
+	help
+	  This driver helps read relevant information such as Type-C port
+	  status (whether a device is connected to a Type-C port or not)
+	  and the activity type on the Type-C ports (such as USB, Display
+	  Port, Thunderbolt), for consumption by other drivers.
+
+	  Currently intel_iom_port_status() API is exported by this driver,
+	  that has information about the Type-C port status and port activity
+	  type.
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called intel_iom.
+
 config INTEL_MENLOW
 	tristate "Thermal Management driver for Intel menlow platform"
 	depends on ACPI_THERMAL
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index 2b85852a1a87..d71e4620a7c6 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -76,6 +76,7 @@ intel_cht_int33fe-objs			:= intel_cht_int33fe_common.o \
 					   intel_cht_int33fe_microb.o
 obj-$(CONFIG_INTEL_HID_EVENT)		+= intel-hid.o
 obj-$(CONFIG_INTEL_INT0002_VGPIO)	+= intel_int0002_vgpio.o
+obj-$(CONFIG_INTEL_IOM)			+= intel_iom.o
 obj-$(CONFIG_INTEL_MENLOW)		+= intel_menlow.o
 obj-$(CONFIG_INTEL_OAKTRAIL)		+= intel_oaktrail.o
 obj-$(CONFIG_INTEL_VBTN)		+= intel-vbtn.o
diff --git a/drivers/platform/x86/intel_iom.c b/drivers/platform/x86/intel_iom.c
new file mode 100644
index 000000000000..ece0fe720b2d
--- /dev/null
+++ b/drivers/platform/x86/intel_iom.c
@@ -0,0 +1,133 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Intel Core SoC Input Output Manager (IOM) driver.
+ *
+ * This driver provides access to the Input Output Manager (IOM) (that
+ * is part of Tiger Lake SoC) registers that can be used to know about
+ * Type-C Sub System related information (such as Type-C port status,
+ * activity type on Type-C ports).
+ *
+ * Copyright (C) 2020, Intel Corporation
+ * Author: Rajmohan Mani <rajmohan.mani@intel.com>
+ */
+
+#include <linux/io.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/platform_data/x86/intel_iom.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+#define IOM_PORT_STATUS_OFFSET				0x560
+
+struct intel_iom {
+	struct device *dev;
+	void __iomem *regbar;
+};
+
+static struct intel_iom iom_dev;
+
+/**
+ * intel_iom_get() - Get IOM device instance
+ *
+ * This function returns the IOM device instance. This also ensures that
+ * this driver cannot be unloaded while the caller has the instance.
+ *
+ * Call intel_iom_put() to release the instance.
+ *
+ * Returns IOM device instance on success or error pointer otherwise.
+ */
+struct intel_iom *intel_iom_get(void)
+{
+	struct device *dev = get_device(iom_dev.dev);
+
+	/* Prevent this driver from being unloaded while in use */
+	if (!try_module_get(dev->driver->owner)) {
+		put_device(iom_dev.dev);
+		return ERR_PTR(-EBUSY);
+	}
+
+	return &iom_dev;
+}
+EXPORT_SYMBOL_GPL(intel_iom_get);
+
+/**
+ * intel_iom_put() - Put IOM device instance
+ * @iom: IOM device instance
+ *
+ * This function releases the IOM device instance created using
+ * intel_iom_get() and allows the driver to be unloaded.
+ *
+ * Call intel_iom_put() to release the instance.
+ */
+void intel_iom_put(struct intel_iom *iom)
+{
+	if (!iom)
+		return;
+
+	module_put(iom->dev->driver->owner);
+	put_device(iom->dev);
+}
+EXPORT_SYMBOL_GPL(intel_iom_put);
+
+/**
+ * intel_iom_port_status() - Get status bits for the Type-C port
+ * @iom: IOM device instance
+ * @port: Type-C port number
+ * @status: pointer to receive the status bits
+ *
+ * Returns 0 on success, error otherwise.
+ */
+int intel_iom_port_status(struct intel_iom *iom, u8 port, u32 *status)
+{
+	void __iomem *reg;
+
+	if (!iom)
+		return -ENODEV;
+
+	if (!status || (port > IOM_MAX_PORTS - 1))
+		return -EINVAL;
+
+	reg = iom->regbar + IOM_PORT_STATUS_OFFSET + IOM_REG_LEN * port;
+
+	*status = ioread32(reg);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(intel_iom_port_status);
+
+static int intel_iom_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	void __iomem *addr;
+
+	addr = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(addr))
+		return PTR_ERR(addr);
+
+	iom_dev.regbar = addr;
+
+	iom_dev.dev = dev;
+	dev_set_drvdata(dev, &iom_dev);
+	return 0;
+}
+
+static const struct acpi_device_id intel_iom_acpi_ids[] = {
+	{ "INTC1072" },
+	{}
+};
+MODULE_DEVICE_TABLE(acpi, intel_iom_acpi_ids);
+
+static struct platform_driver intel_iom_driver = {
+	.probe = intel_iom_probe,
+	.driver = {
+		.name = "intel_iom",
+		.acpi_match_table = intel_iom_acpi_ids,
+	},
+};
+
+module_platform_driver_probe(intel_iom_driver, intel_iom_probe);
+
+MODULE_AUTHOR("Rajmohan Mani <rajmohan.mani@intel.com>");
+MODULE_DESCRIPTION("Intel IOM driver");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/platform_data/x86/intel_iom.h b/include/linux/platform_data/x86/intel_iom.h
new file mode 100644
index 000000000000..d86c60b25a44
--- /dev/null
+++ b/include/linux/platform_data/x86/intel_iom.h
@@ -0,0 +1,62 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _PLATFORM_DATA_X86_INTEL_IOM_H_
+#define _PLATFORM_DATA_X86_INTEL_IOM_H_
+
+#include <linux/bits.h>
+#include <linux/types.h>
+
+/* Input Output Manager (IOM) PORT STATUS */
+#define IOM_PORT_STATUS_ACTIVITY_TYPE_MASK		GENMASK(9, 6)
+#define IOM_PORT_STATUS_ACTIVITY_TYPE_SHIFT		0x06
+#define IOM_PORT_STATUS_ACTIVITY_TYPE_USB		0x03
+/* activity type: Safe Mode */
+#define IOM_PORT_STATUS_ACTIVITY_TYPE_SAFE_MODE		0x04
+/* activity type: Display Port */
+#define IOM_PORT_STATUS_ACTIVITY_TYPE_DP		0x05
+/* activity type: Display Port Multi Function Device */
+#define IOM_PORT_STATUS_ACTIVITY_TYPE_DP_MFD		0x06
+/* activity type: Thunderbolt */
+#define IOM_PORT_STATUS_ACTIVITY_TYPE_TBT		0x07
+#define IOM_PORT_STATUS_ACTIVITY_TYPE_ALT_MODE_USB	0x0c
+#define IOM_PORT_STATUS_ACTIVITY_TYPE_ALT_MODE_TBT_USB	0x0d
+/* Upstream Facing Port Information */
+#define IOM_PORT_STATUS_UFP				BIT(10)
+/* Display Port Hot Plug Detect status */
+#define IOM_PORT_STATUS_DHPD_HPD_STATUS_MASK		GENMASK(13, 12)
+#define IOM_PORT_STATUS_DHPD_HPD_STATUS_SHIFT		0x0c
+#define IOM_PORT_STATUS_DHPD_HPD_STATUS_ASSERT		0x01
+#define IOM_PORT_STATUS_DHPD_HPD_SOURCE_TBT		BIT(14)
+#define IOM_PORT_STATUS_CONNECTED			BIT(31)
+
+#define IOM_MAX_PORTS					4
+/* Register length in bytes */
+#define IOM_REG_LEN					4
+
+struct intel_iom;
+
+#ifdef CONFIG_ACPI
+
+struct intel_iom *intel_iom_get(void);
+void intel_iom_put(struct intel_iom *iom);
+int intel_iom_port_status(struct intel_iom *iom, u8 port, u32 *status);
+
+#else
+
+struct intel_iom *intel_iom_get(void)
+{
+	return NULL;
+}
+
+void intel_iom_put(struct intel_iom *iom)
+{
+}
+
+int intel_iom_port_status(struct intel_iom *iom, u8 port, u32 *status)
+{
+	return 0;
+}
+
+#endif
+
+#endif /* _PLATFORM_DATA_X86_INTEL_IOM_H_ */
-- 
2.20.1

