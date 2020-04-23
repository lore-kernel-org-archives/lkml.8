Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3807EC54FCB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 22:49:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1821920736
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 22:49:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbgDWWtg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 18:49:36 -0400
Received: from mga01.intel.com ([192.55.52.88]:25977 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726057AbgDWWtf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 18:49:35 -0400
IronPort-SDR: uMTGOpNBDsiR/Fl8k3HXpjP1qoDpSggjDxiEB6zzkqEGhq5aDTjnWzwKq+ilcTMLZTU0bqz/UE
 EFU0IC53bOxw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2020 15:49:35 -0700
IronPort-SDR: ggnH1/SDN4E3Bgmm9v+9Dzms83AOYXYayhxcEfpxclesVTTc7gAWAd8mK6Z0SG1GfszhZPk2IZ
 uW5eTaHbetIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,309,1583222400"; 
   d="scan'208";a="403090533"
Received: from coffy.sc.intel.com ([10.3.79.166])
  by orsmga004.jf.intel.com with ESMTP; 23 Apr 2020 15:49:34 -0700
From:   Jithu Joseph <jithu.joseph@intel.com>
To:     dvhart@infradead.org, andy@infradead.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        maurice.ma@intel.com, ravi.p.rangarajan@intel.com,
        sean.v.kelley@intel.com, kuo-lang.tseng@intel.com,
        Jithu Joseph <jithu.joseph@intel.com>
Subject: [PATCH v2 1/1] platform/x86: Add Slim Bootloader firmware update signaling driver
Date:   Thu, 23 Apr 2020 15:42:22 -0700
Message-Id: <20200423224222.29730-2-jithu.joseph@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200423224222.29730-1-jithu.joseph@intel.com>
References: <20200423224222.29730-1-jithu.joseph@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Slim Bootloader(SBL) is a small open-source boot firmware,
designed for running on certain Intel platforms. SBL can be
thought-of as fulfilling the role of a minimal BIOS
implementation, i.e initializing the hardware and booting
Operating System.

Since SBL is not UEFI compliant, firmware update cannot be triggered
using standard UEFI runtime services. Further considering performance
impact, SBL doesn't look for a firmware update image on every reset
and does so only when firmware update signal is asserted.

SBL exposes an ACPI-WMI device which comes up in sysfs as
/sys/bus/wmi/44FADEB1xxx and this driver adds a
"firmware_update_request" device attribute. This attribute normally
has a value of 0 and userspace can signal SBL to update firmware,
on next reboot, by writing a value of 1 like:

echo 1 > /sys/bus/wmi/devices/44FADEB1xxx/firmware_update_request

This driver only implements a signaling mechanism, the actual firmware
update process and various details like firmware update image format,
firmware image location etc are defined by SBL and are not in the
scope of this driver.

DocLink: https://slimbootloader.github.io/security/firmware-update.html

Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
---
 .../ABI/testing/sysfs-platform-sbl-fwu-wmi    |  12 ++
 MAINTAINERS                                   |   7 +
 drivers/platform/x86/Kconfig                  |  10 ++
 drivers/platform/x86/Makefile                 |   1 +
 drivers/platform/x86/sbl_fwu_wmi.c            | 144 ++++++++++++++++++
 5 files changed, 174 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-platform-sbl-fwu-wmi
 create mode 100644 drivers/platform/x86/sbl_fwu_wmi.c

diff --git a/Documentation/ABI/testing/sysfs-platform-sbl-fwu-wmi b/Documentation/ABI/testing/sysfs-platform-sbl-fwu-wmi
new file mode 100644
index 000000000000..5aa618987cad
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-platform-sbl-fwu-wmi
@@ -0,0 +1,12 @@
+What:		/sys/bus/wmi/devices/44FADEB1-B204-40F2-8581-394BBDC1B651/firmware_update_request
+Date:		April 2020
+KernelVersion:	5.7
+Contact:	"Jithu Joseph" <jithu.joseph@intel.com>
+Description:
+		Allow user space entities to trigger update of Slim
+		Bootloader (SBL). This attribute normally has a value
+		of 0 and userspace can signal SBL to update firmware,
+		on next reboot, by writing a value of 1.
+		There are two available states:
+		    * 0 -> Skip firmware update while rebooting
+		    * 1 -> Attempt firmware update on next reboot
diff --git a/MAINTAINERS b/MAINTAINERS
index b816a453b10e..fb613308dc4e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15454,6 +15454,13 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev
 F:	include/linux/srcu*.h
 F:	kernel/rcu/srcu*.c
 
+SLIM BOOTLOADER (SBL) FIRMWARE UPDATE WMI DRIVER
+M:	Jithu Joseph <jithu.joseph@intel.com>
+R:	Maurice Ma <maurice.ma@intel.com>
+S:	Maintained
+W:	https://slimbootloader.github.io/security/firmware-update.html
+F:	drivers/platform/x86/sbl_fwu_wmi.c
+
 SMACK SECURITY MODULE
 M:	Casey Schaufler <casey@schaufler-ca.com>
 L:	linux-security-module@vger.kernel.org
diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 0ad7ad8cf8e1..69cfc2904265 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -104,6 +104,16 @@ config PEAQ_WMI
 	help
 	 Say Y here if you want to support WMI-based hotkeys on PEAQ 2-in-1s.
 
+config SBL_FWU_WMI
+	tristate "WMI driver for Slim Bootloader firmware update signaling"
+	depends on ACPI_WMI
+	help
+	  Say Y here if you want to be able to use the WMI interface to signal
+	  Slim Bootloader to trigger update on next reboot.
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called sbl-fwu-wmi.
+
 config XIAOMI_WMI
 	tristate "Xiaomi WMI key driver"
 	depends on ACPI_WMI
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index 53408d965874..65455c2214c9 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -14,6 +14,7 @@ obj-$(CONFIG_HUAWEI_WMI)		+= huawei-wmi.o
 obj-$(CONFIG_INTEL_WMI_THUNDERBOLT)	+= intel-wmi-thunderbolt.o
 obj-$(CONFIG_MXM_WMI)			+= mxm-wmi.o
 obj-$(CONFIG_PEAQ_WMI)			+= peaq-wmi.o
+obj-$(CONFIG_SBL_FWU_WMI)		+= sbl_fwu_wmi.o
 obj-$(CONFIG_XIAOMI_WMI)		+= xiaomi-wmi.o
 
 # Acer
diff --git a/drivers/platform/x86/sbl_fwu_wmi.c b/drivers/platform/x86/sbl_fwu_wmi.c
new file mode 100644
index 000000000000..4563245d32bd
--- /dev/null
+++ b/drivers/platform/x86/sbl_fwu_wmi.c
@@ -0,0 +1,144 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Slim Bootloader(SBL) firmware update signaling driver
+ *
+ * Slim Bootloader is a small, open-source, non UEFI compliant, boot firmware
+ * optimized for running on certain Intel platforms.
+ *
+ * SBL exposes an ACPI-WMI device via /sys/bus/wmi/<SBL_FWU_WMI_GUID>.
+ * This driver further adds "firmware_update_request" device attribute.
+ * This attribute normally has a value of 0 and userspace can signal SBL
+ * to update firmware, on next reboot, by writing a value of 1.
+ *
+ * More details of SBL firmware update process is available at:
+ * https://slimbootloader.github.io/security/firmware-update.html
+ */
+
+#include <linux/acpi.h>
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/sysfs.h>
+#include <linux/wmi.h>
+
+#define SBL_FWU_WMI_GUID  "44FADEB1-B204-40F2-8581-394BBDC1B651"
+
+static int get_fwu_request(struct device *dev, u32 *out)
+{
+	struct acpi_buffer result = {ACPI_ALLOCATE_BUFFER, NULL};
+	union acpi_object *obj;
+	acpi_status status;
+
+	status = wmi_query_block(SBL_FWU_WMI_GUID, 0, &result);
+	if (ACPI_FAILURE(status)) {
+		dev_err(dev, "wmi_query_block failed\n");
+		return -ENODEV;
+	}
+
+	obj = (union acpi_object *)result.pointer;
+	if (!obj || obj->type != ACPI_TYPE_INTEGER) {
+		dev_warn(dev, "wmi_query_block returned invalid value\n");
+		kfree(obj);
+		return -EINVAL;
+	}
+
+	*out = obj->integer.value;
+	kfree(obj);
+
+	return 0;
+}
+
+static int set_fwu_request(struct device *dev, u32 in)
+{
+	struct acpi_buffer input;
+	acpi_status status;
+	u32 value;
+
+	value = in;
+	input.length = sizeof(u32);
+	input.pointer = &value;
+
+	status = wmi_set_block(SBL_FWU_WMI_GUID, 0, &input);
+	if (ACPI_FAILURE(status)) {
+		dev_err(dev, "wmi_set_block failed\n");
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static ssize_t firmware_update_request_show(struct device *dev,
+					    struct device_attribute *attr,
+					    char *buf)
+{
+	u32 val;
+	int ret;
+
+	ret = get_fwu_request(dev, &val);
+	if (ret)
+		return ret;
+
+	return sprintf(buf, "%d\n", val);
+}
+
+static ssize_t firmware_update_request_store(struct device *dev,
+					     struct device_attribute *attr,
+					     const char *buf, size_t count)
+{
+	unsigned int val;
+	int ret;
+
+	ret = kstrtouint(buf, 0, &val);
+	if (ret)
+		return ret;
+
+	/* May later be extended to support values other than 0 and 1 */
+	if (val > 1)
+		return -ERANGE;
+
+	ret = set_fwu_request(dev, val);
+	if (ret)
+		return ret;
+
+	return count;
+}
+static DEVICE_ATTR_RW(firmware_update_request);
+
+static struct attribute *firmware_update_attrs[] = {
+	&dev_attr_firmware_update_request.attr,
+	NULL
+};
+ATTRIBUTE_GROUPS(firmware_update);
+
+static int sbl_fwu_wmi_probe(struct wmi_device *wdev, const void *context)
+{
+	dev_info(&wdev->dev, "Slim Bootloader signaling driver attached\n");
+	return 0;
+}
+
+static int sbl_fwu_wmi_remove(struct wmi_device *wdev)
+{
+	dev_info(&wdev->dev, "Slim Bootloader signaling driver removed\n");
+	return 0;
+}
+
+static const struct wmi_device_id sbl_fwu_wmi_id_table[] = {
+	{ .guid_string = SBL_FWU_WMI_GUID },
+	{}
+};
+MODULE_DEVICE_TABLE(wmi, sbl_fwu_wmi_id_table);
+
+static struct wmi_driver sbl_fwu_wmi_driver = {
+	.driver = {
+		.name = "sbl-fwu-wmi",
+		.dev_groups = firmware_update_groups,
+	},
+	.probe = sbl_fwu_wmi_probe,
+	.remove = sbl_fwu_wmi_remove,
+	.id_table = sbl_fwu_wmi_id_table,
+};
+module_wmi_driver(sbl_fwu_wmi_driver);
+
+MODULE_AUTHOR("Jithu Joseph <jithu.joseph@intel.com>");
+MODULE_DESCRIPTION("Slim Bootloader firmware update signaling driver");
+MODULE_LICENSE("GPL v2");
-- 
2.17.1

