Return-Path: <SRS0=B91b=AB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E286BC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 12:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B848A23B44
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 12:37:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hL2+O+9o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728116AbgFTMhO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jun 2020 08:37:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33787 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728064AbgFTMhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jun 2020 08:37:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592656631;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=0RorBc5ECZc8+1+a5B1yD6cCotC1YvdgMnIN6XU4Cgs=;
        b=hL2+O+9oQvG2FYAwmpJVEMp3IbfAKU8qsUcXBOT8EVvq8uwcn8acWkFk0e8iiyzaxc8P/9
        TYcQ9nLmXHQz+6QOwP9TlNGgA2PgLtxAQcrpycjbdMLXVAlV8+HjVvuObahKIzRFFqIURJ
        WF7BoJyALlZDX5Hm/W2zuFyggoVcUko=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-133-Mi6Z89G7OGSHtQjHy7reew-1; Sat, 20 Jun 2020 08:37:09 -0400
X-MC-Unique: Mi6Z89G7OGSHtQjHy7reew-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DFA25107ACF4;
        Sat, 20 Jun 2020 12:37:07 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-112-42.ams2.redhat.com [10.36.112.42])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C520D7C1E0;
        Sat, 20 Jun 2020 12:37:06 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] platform/x86: Add new intel_atomisp2_led driver
Date:   Sat, 20 Jun 2020 14:37:05 +0200
Message-Id: <20200620123705.72625-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Many Bay Trail and Cherry Trail devices come with a camera attached to
Intel's Image Signal Processor. Linux currently does not have a driver for
these, so they do not work as a camera.

Some of these camera's have a status LED which is controlled through a GPIO
in some cases, e.g. on the Asus T100TA and Asus T200TA, there is a firmware
issue where the LED gets turned on at boot.

This commit adds a Linux LED driver for the camera LED on these devices.
This driver will turn the LED off at boot and also allows controlling the
LED (so the user can repurpose it) through the sysfs LED interface.

Which GPIO is attached to the LED is usually not described in the ACPI
tables, so this driver contains per-system info about the GPIO inside the
driver. This means that this driver only works on systems the driver knows
about.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
- Rebase on top of v5.8-rc1
- Use PTR_ERR_OR_ZERO
---
 MAINTAINERS                               |   6 ++
 drivers/platform/x86/Kconfig              |  21 ++++
 drivers/platform/x86/Makefile             |   1 +
 drivers/platform/x86/intel_atomisp2_led.c | 116 ++++++++++++++++++++++
 4 files changed, 144 insertions(+)
 create mode 100644 drivers/platform/x86/intel_atomisp2_led.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 301330e02bca..5535761f2b54 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8600,6 +8600,12 @@ L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
 F:	drivers/platform/x86/intel_atomisp2_pm.c
 
+INTEL ATOMISP2 LED DRIVER
+M:	Hans de Goede <hdegoede@redhat.com>
+L:	platform-driver-x86@vger.kernel.org
+S:	Maintained
+F:	drivers/platform/x86/intel_atomisp2_led.c
+
 INTEL BROXTON PMC DRIVER
 M:	Mika Westerberg <mika.westerberg@linux.intel.com>
 M:	Zha Qipeng <qipeng.zha@intel.com>
diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 0581a54cf562..318e083f38b3 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -761,6 +761,27 @@ config INTEL_ATOMISP2_PM
 	  To compile this driver as a module, choose M here: the module
 	  will be called intel_atomisp2_pm.
 
+config INTEL_ATOMISP2_LED
+	tristate "Intel AtomISP2 camera LED driver"
+	depends on GPIOLIB && LEDS_GPIO
+	help
+	  Many Bay Trail and Cherry Trail devices come with a camera attached
+	  to Intel's Image Signal Processor. Linux currently does not have a
+	  driver for these, so they do not work as a camera. Some of these
+	  camera's have a LED which is controlled through a GPIO.
+
+	  Some of these devices have a firmware issue where the LED gets turned
+	  on at boot. This driver will turn the LED off at boot and also allows
+	  controlling the LED (repurposing it) through the sysfs LED interface.
+
+	  Which GPIO is attached to the LED is usually not described in the
+	  ACPI tables, so this driver contains per-system info about the GPIO
+	  inside the driver, this means that this driver only works on systems
+	  the driver knows about.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called intel_atomisp2_led.
+
 config INTEL_CHT_INT33FE
 	tristate "Intel Cherry Trail ACPI INT33FE Driver"
 	depends on X86 && ACPI && I2C && REGULATOR
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index 2b85852a1a87..7a78cc0bb249 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -70,6 +70,7 @@ obj-$(CONFIG_THINKPAD_ACPI)	+= thinkpad_acpi.o
 
 # Intel
 obj-$(CONFIG_INTEL_ATOMISP2_PM)		+= intel_atomisp2_pm.o
+obj-$(CONFIG_INTEL_ATOMISP2_LED)	+= intel_atomisp2_led.o
 obj-$(CONFIG_INTEL_CHT_INT33FE)		+= intel_cht_int33fe.o
 intel_cht_int33fe-objs			:= intel_cht_int33fe_common.o \
 					   intel_cht_int33fe_typec.o \
diff --git a/drivers/platform/x86/intel_atomisp2_led.c b/drivers/platform/x86/intel_atomisp2_led.c
new file mode 100644
index 000000000000..5935dfca166f
--- /dev/null
+++ b/drivers/platform/x86/intel_atomisp2_led.c
@@ -0,0 +1,116 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Driver for controlling LEDs for cameras connected to the Intel atomisp2
+ * The main purpose of this driver is to turn off LEDs which are on at boot.
+ *
+ * Copyright (C) 2020 Hans de Goede <hdegoede@redhat.com>
+ */
+
+#include <linux/dmi.h>
+#include <linux/gpio/consumer.h>
+#include <linux/gpio/machine.h>
+#include <linux/leds.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/platform_device.h>
+#include <linux/workqueue.h>
+
+/* This must be leds-gpio as the leds-gpio driver binds to the name */
+#define DEV_NAME		"leds-gpio"
+
+static const struct gpio_led atomisp2_leds[] = {
+	{
+		.name = "atomisp2::camera",
+		.default_state  = LEDS_GPIO_DEFSTATE_OFF,
+	},
+};
+
+static const struct gpio_led_platform_data atomisp2_leds_pdata = {
+	.num_leds	= ARRAY_SIZE(atomisp2_leds),
+	.leds		= atomisp2_leds,
+};
+
+static struct gpiod_lookup_table asus_t100ta_lookup = {
+	.dev_id = DEV_NAME,
+	.table = {
+		GPIO_LOOKUP_IDX("INT33FC:02", 8, NULL, 0, GPIO_ACTIVE_HIGH),
+		{ }
+	}
+};
+
+static struct gpiod_lookup_table asus_t100chi_lookup = {
+	.dev_id = DEV_NAME,
+	.table = {
+		GPIO_LOOKUP_IDX("INT33FC:01", 24, NULL, 0, GPIO_ACTIVE_HIGH),
+		{ }
+	}
+};
+
+static const struct dmi_system_id atomisp2_led_systems[] __initconst = {
+	{
+		.matches = {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "T100TA"),
+		},
+		.driver_data = &asus_t100ta_lookup,
+	},
+	{
+		.matches = {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "T200TA"),
+		},
+		.driver_data = &asus_t100ta_lookup,
+	},
+	{
+		.matches = {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "T100CHI"),
+		},
+		.driver_data = &asus_t100chi_lookup,
+	},
+	{} /* Terminating entry */
+};
+MODULE_DEVICE_TABLE(dmi, atomisp2_led_systems);
+
+static struct gpiod_lookup_table *gpio_lookup;
+static struct platform_device *pdev;
+
+static int __init atomisp2_led_init(void)
+{
+	const struct dmi_system_id *system;
+
+	system = dmi_first_match(atomisp2_led_systems);
+	if (!system)
+		return -ENODEV;
+
+	gpio_lookup = system->driver_data;
+	gpiod_add_lookup_table(gpio_lookup);
+
+	pdev = platform_device_register_resndata(NULL,
+						 DEV_NAME, PLATFORM_DEVID_NONE,
+						 NULL, 0, &atomisp2_leds_pdata,
+						 sizeof(atomisp2_leds_pdata));
+	if (IS_ERR(pdev))
+		gpiod_remove_lookup_table(gpio_lookup);
+
+	return PTR_ERR_OR_ZERO(pdev);
+}
+
+static void __exit atomisp2_led_cleanup(void)
+{
+	platform_device_unregister(pdev);
+	gpiod_remove_lookup_table(gpio_lookup);
+}
+
+module_init(atomisp2_led_init);
+module_exit(atomisp2_led_cleanup);
+
+/*
+ * The ACPI INIT method from Asus WMI's code on the T100TA and T200TA turns the
+ * LED on (without the WMI interface allowing further control over the LED).
+ * Ensure we are loaded after asus-nb-wmi so that we turn the LED off again.
+ */
+MODULE_SOFTDEP("pre: asus_nb_wmi");
+MODULE_AUTHOR("Hans de Goede <hdegoede@redhat.com");
+MODULE_DESCRIPTION("Intel atomisp2 camera LED driver");
+MODULE_LICENSE("GPL");
-- 
2.26.2

