Return-Path: <SRS0=ximN=CA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F6B6C433E3
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 04:42:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20F6620720
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 04:42:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbgHVEmR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Aug 2020 00:42:17 -0400
Received: from mga11.intel.com ([192.55.52.93]:62111 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726414AbgHVEmK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 00:42:10 -0400
IronPort-SDR: Bd5xfcJjOo1huN9NdWgzi+ipkyMgC1M45J5A4BHXPbFVukWJBWBcK1cB78kxjkz+Xv911SdWn4
 SGopv4DxGj1g==
X-IronPort-AV: E=McAfee;i="6000,8403,9720"; a="153275283"
X-IronPort-AV: E=Sophos;i="5.76,339,1592895600"; 
   d="scan'208";a="153275283"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2020 21:42:01 -0700
IronPort-SDR: 8i4hGeGeesJiGDSiCZhdtYrmz2gqvJ4jJAcmw6zUUM2qkDD8wA/cLpsxbnaCvXVmpeFryGgsYM
 ySOF44knnNHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,339,1592895600"; 
   d="scan'208";a="327943118"
Received: from glacier.sc.intel.com ([10.3.62.63])
  by orsmga008.jf.intel.com with ESMTP; 21 Aug 2020 21:42:00 -0700
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
Subject: [PATCH v2 1/3] platform/x86: Add Intel Input Output Manager (IOM) driver
Date:   Fri, 21 Aug 2020 21:05:06 -0700
Message-Id: <20200822040508.23510-2-rajmohan.mani@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200822040508.23510-1-rajmohan.mani@intel.com>
References: <20200822040508.23510-1-rajmohan.mani@intel.com>
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
 drivers/platform/x86/Kconfig                | 16 ++++
 drivers/platform/x86/Makefile               |  1 +
 drivers/platform/x86/intel_iom.c            | 95 +++++++++++++++++++++
 include/linux/platform_data/x86/intel_iom.h | 49 +++++++++++
 4 files changed, 161 insertions(+)
 create mode 100644 drivers/platform/x86/intel_iom.c
 create mode 100644 include/linux/platform_data/x86/intel_iom.h

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 40219bba6801..f09b4b525ea5 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -837,6 +837,22 @@ config INTEL_INT0002_VGPIO
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
index 5f823f7eff45..b44f706074c3 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -77,6 +77,7 @@ intel_cht_int33fe-objs			:= intel_cht_int33fe_common.o \
 					   intel_cht_int33fe_microb.o
 obj-$(CONFIG_INTEL_HID_EVENT)		+= intel-hid.o
 obj-$(CONFIG_INTEL_INT0002_VGPIO)	+= intel_int0002_vgpio.o
+obj-$(CONFIG_INTEL_IOM)			+= intel_iom.o
 obj-$(CONFIG_INTEL_MENLOW)		+= intel_menlow.o
 obj-$(CONFIG_INTEL_OAKTRAIL)		+= intel_oaktrail.o
 obj-$(CONFIG_INTEL_VBTN)		+= intel-vbtn.o
diff --git a/drivers/platform/x86/intel_iom.c b/drivers/platform/x86/intel_iom.c
new file mode 100644
index 000000000000..cda7716410c6
--- /dev/null
+++ b/drivers/platform/x86/intel_iom.c
@@ -0,0 +1,95 @@
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
+static struct intel_iom *iom;
+
+/**
+ * intel_iom_port_status() - Get status bits for the Type-C port
+ * @port: Type-C port number
+ * @status: pointer to receive the status bits
+ *
+ * Returns 0 on success, error otherwise.
+ */
+int intel_iom_port_status(u8 port, u32 *status)
+{
+	void __iomem *reg;
+
+	if (!iom || !iom->dev || !iom->regbar)
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
+	void __iomem *addr;
+
+	/* only one IOM device is supported */
+	if (iom)
+		return -EBUSY;
+
+	iom = devm_kzalloc(&pdev->dev, sizeof(*iom), GFP_KERNEL);
+	if (!iom)
+		return -ENOMEM;
+
+	addr = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(addr))
+		return PTR_ERR(addr);
+
+	iom->regbar = addr;
+	iom->dev = &pdev->dev;
+
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
index 000000000000..e4c9a305e7a9
--- /dev/null
+++ b/include/linux/platform_data/x86/intel_iom.h
@@ -0,0 +1,49 @@
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
+#ifdef CONFIG_ACPI
+
+int intel_iom_port_status(u8 port, u32 *status);
+
+#else
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

