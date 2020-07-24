Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CA57C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 12:07:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA84D2073E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 12:07:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=beagleboard-org.20150623.gappssmtp.com header.i=@beagleboard-org.20150623.gappssmtp.com header.b="1PeJpRXd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbgGXMHL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 08:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726258AbgGXMGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 08:06:49 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D209DC0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 05:06:47 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id z5so5116397pgb.6
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 05:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=WicFJKwYVApjY7WOQn3UlonDvzNx9m7OxKKDC/cUBfw=;
        b=1PeJpRXd57s08PnuJhEAxDwo7kgVRPqZibJ7u0AlodEv/A01Zyw3Babn+0j38EqPjz
         Ir+uSYQcDTB41cxIXoQ9D9Bejuq1g8vMcdXfpIriOuhIU6+wMUBp57o9KdcsdqfWT1Ns
         PeZjdSQr3F6mgq5ofu5CuRT5Z1hpC55iJ3MywlnJgkHnRpbJmBFI62II6KIobDbZSIXN
         goNb7rHPUfbBab32k10YYZyPkza5xIaQ5kPx0qmJtORiIrpz6/1ZvRQ2zFiN1gkq5xfN
         +SoFla+/iQkGqlR2TVjUiTvUpvtGXUgE1sgdZCPuuzMO1is6j7ftDz0b2HO9Ul695VWa
         wJHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=WicFJKwYVApjY7WOQn3UlonDvzNx9m7OxKKDC/cUBfw=;
        b=i/Dmhsw4OPPMQC8NKKmMtrd99MX7bvjX/zk2CUP6HVnkX8kJyKvvKT7LugItoy7Llv
         RCA7MXl2TaNc89Fn2/r/kSqThXn1Wdnk+lxekoDkRTLM6s2BH/VUHHAg1/RQV7TQSYH0
         UMyVVoPXZN7mWJ6lyydImGBrCkyHHXJVBbMaXpkJZhEJTin/bAEE5hjfOHxevz2I3jNm
         oeMzuKI0HR3E6vyXS/wGlMsGk3B6qkSx6ALN2W1RT2oHX4zIkRr4rBL5BL609OypUNXt
         0hnisvOE9KWZFi+8qcoaYVANscVyqhNCla0TobEPvLEMBfthz73SQkOICu8BF9OUmqW4
         d3PQ==
X-Gm-Message-State: AOAM533Mmk8JOipKnKJ6mdXYFoNcaWwT9GnEStUwHugkU+0f5j0uOGmH
        XGLW1MDW3flZJizOqcuEX2We
X-Google-Smtp-Source: ABdhPJxO0/+jaIOz9nEO3UHtgvHzRLM4PEfSwljL3MiGupnP55XkrMlaN55Wa8iBucWugZqBMV1n3A==
X-Received: by 2002:aa7:8096:: with SMTP id v22mr9027450pff.132.1595592406870;
        Fri, 24 Jul 2020 05:06:46 -0700 (PDT)
Received: from vaishnav-VirtualBox ([111.92.52.87])
        by smtp.gmail.com with ESMTPSA id n14sm6382758pgd.78.2020.07.24.05.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 05:06:46 -0700 (PDT)
Date:   Fri, 24 Jul 2020 17:36:37 +0530
From:   Vaishnav M A <vaishnav@beagleboard.org>
To:     greybus-dev@lists.linaro.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, arnd@arndb.de, johan@kernel.org,
        elder@kernel.org
Cc:     robh@kernel.org, mchehab+huawei@kernel.org, davem@davemloft.net,
        jkridner@beagleboard.org, drew@beagleboard.org,
        robertcnelson@beagleboard.org, rajkovic@mikroe.com,
        chrisfriedt@gmail.com, zoran.stojsavljevic@gmail.com,
        vaishnav@beagleboard.org
Subject: [PATCH] RFC : mikroBUS driver for add-on boards
Message-ID: <20200724120637.GA427284@vaishnav-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Attached is a patch for the mikroBUS driver which helps to
instantiate an add-on board device on a mikrobus port by fetching
the device identifier manifest binary from an EEPROM on-board
the device. mikroBUS is an add-on board socket standard by
MikroElektronika that can be freely used by anyone
following the guidelines, more details and discussions on
the status of the driver can be found here in this eLinux wiki:
https://elinux.org/Mikrobus

In the current state of the driver, more than 80 different
add-on boards have been tested on the BeagleBoard.org
PocketBeagle and the manifest binary is generated using the same
manifesto tool used to generate Greybus manifest binaries,
The pull request to manifesto to add new descriptors specific
to mikrobus is here : https://github.com/projectara/manifesto/pull/2
The utilization of Greybus manifest binaries here is not entirely
coincidental, We are evaluating ways to add mikroBUS sockets and
devices via Greybus expansion.

The mikroBUS standard includes SPI, I2C, UART, PWM, ADC, GPIO
and power (3.3V and 5V) connections to interface common embedded
peripherals, There are more than 750 add-on boards ranging from
wireless connectivity boards to human-machine interface sensors
which conform to the mikroBUS standard, out of which more than 140
boards already have support in the Linux kernel.Today, there is no
mainlinesolution for enabling mikroBUS add-on boards at run-time, the
most straight forward method for loading drivers is to provide
device-tree overlay fragments at boot time, this method suffers
from the need to maintain a large out-of-tree database for which there
is need to maintain an overlay for every mikroBUS add-on board for every
Linux system and for every mikroBUS socket on that system.

The mikroBUS driver tries to solve the problem by using extended version
of the greybus manifest to describe the add-on board device specific
information required by the device driver and uses it along with the fixed
port specific information to probe the specific device driver.The manifest
binary is now fetched from an I2C EEPROM over the I2C bus on the mikroBUS
port(subject to change in mikroBUS v3 specification) and enumerate drivers
for the add-on devices.There is also ongoing work to define a mikroBUS
v3 standard in which the addon board includes a non-volatile storage to
store the device identifier manifest binary, once the mikroBUS v3 standard
is released, the mikroBUS can be seen as a probeable bus such that the
kernel can discover the device on the bus at boot time.

The driver also has a few debug SysFS interfaces for testing on add-on
boards without an EEPROM, these can be used in the following manner:
(example for mikroBUS port 1 on BeagleBoard.org PocketBeagle):

printf "%b" '\x01\x00\x00\x59\x32\x17' > /sys/bus/mikrobus/add_port

The bytes in the byte array sequence are (in order):

	* i2c_adap_nr
	* spi_master_nr
	* serdev_ctlr_nr
	* rst_gpio_nr
	* pwm_gpio_nr
	* int_gpio_nr
* add_port sysFS entry is purely for debug and in the actual state
of the driver, port configuration will be loaded from a suitable
device tree overlay fragment.

echo 0 > /sys/bus/mikrobus/del_port (to delete the attached port)
echo 1 >  /sys/class/mikrobus-port/mikrobus-0/rescan (to rescan the EEPROM
contents on the I2C bus on the mikroBUS port).

cat board_manifest.mnfb >  /sys/class/mikrobus-port/mikrobus-0/new_device
* debug interface to pass the manifest binary in case an EEPROM is absent
echo 0 >  /sys/class/mikrobus-port/mikrobus-0/delete_device
* to unload the loaded board on the mikrobus port

These sysFS interfaces are only implemented for debug purposes and
in the actual implementation of the driver these will be removed and
the manifest binary will be fetched from the non volatile storage on-board
the device.

The mikroBUS driver enable the mikroBUS to be a probeable bus such that
the kernel can discover the device and automatically load the drivers.
There are already several Linux platforms with mikroBUS sockets and the
mikroBUS driver helps to reduce the time to develop and debug
support for various mikroBUS add-on boards. Further, it opens up
the possibility for support under dynamically instantiated buses
such as with Greybus.

Please let know the feedback you have on this patch or the approach used.

Thanks,

Vaishnav M A

Signed-off-by: Vaishnav M A <vaishnav@beagleboard.org>
---
 MAINTAINERS                               |   6 +
 drivers/misc/Kconfig                      |   1 +
 drivers/misc/Makefile                     |   1 +
 drivers/misc/mikrobus/Kconfig             |  16 +
 drivers/misc/mikrobus/Makefile            |   5 +
 drivers/misc/mikrobus/mikrobus_core.c     | 649 ++++++++++++++++++++++
 drivers/misc/mikrobus/mikrobus_core.h     | 130 +++++
 drivers/misc/mikrobus/mikrobus_manifest.c | 390 +++++++++++++
 drivers/misc/mikrobus/mikrobus_manifest.h |  21 +
 include/linux/greybus/greybus_manifest.h  |  53 ++
 10 files changed, 1272 insertions(+)
 create mode 100644 drivers/misc/mikrobus/Kconfig
 create mode 100644 drivers/misc/mikrobus/Makefile
 create mode 100644 drivers/misc/mikrobus/mikrobus_core.c
 create mode 100644 drivers/misc/mikrobus/mikrobus_core.h
 create mode 100644 drivers/misc/mikrobus/mikrobus_manifest.c
 create mode 100644 drivers/misc/mikrobus/mikrobus_manifest.h

diff --git a/MAINTAINERS b/MAINTAINERS
index d53db30d1365..9a049746203f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11402,6 +11402,12 @@ M:	Oliver Neukum <oliver@neukum.org>
 S:	Maintained
 F:	drivers/usb/image/microtek.*
 
+MIKROBUS ADDON BOARD DRIVER
+M:	Vaishnav M A <vaishnav@beagleboard.org>
+S:	Maintained
+W:	https://elinux.org/Mikrobus
+F:	drivers/misc/mikrobus/
+
 MIPS
 M:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
 L:	linux-mips@vger.kernel.org
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index e1b1ba5e2b92..334f0c39d56b 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -472,4 +472,5 @@ source "drivers/misc/ocxl/Kconfig"
 source "drivers/misc/cardreader/Kconfig"
 source "drivers/misc/habanalabs/Kconfig"
 source "drivers/misc/uacce/Kconfig"
+source "drivers/misc/mikrobus/Kconfig"
 endmenu
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index c7bd01ac6291..45486dd77da5 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -40,6 +40,7 @@ obj-$(CONFIG_VMWARE_BALLOON)	+= vmw_balloon.o
 obj-$(CONFIG_PCH_PHUB)		+= pch_phub.o
 obj-y				+= ti-st/
 obj-y				+= lis3lv02d/
+obj-y				+= mikrobus/
 obj-$(CONFIG_ALTERA_STAPL)	+=altera-stapl/
 obj-$(CONFIG_INTEL_MEI)		+= mei/
 obj-$(CONFIG_VMWARE_VMCI)	+= vmw_vmci/
diff --git a/drivers/misc/mikrobus/Kconfig b/drivers/misc/mikrobus/Kconfig
new file mode 100644
index 000000000000..c3b93e12daad
--- /dev/null
+++ b/drivers/misc/mikrobus/Kconfig
@@ -0,0 +1,16 @@
+menuconfig MIKROBUS
+	tristate "Module for instantiating devices on mikroBUS ports"
+	help
+	  This option enables the mikroBUS driver. mikroBUS is an add-on
+	  board socket standard that offers maximum expandability with
+	  the smallest number of pins. The mikroBUS driver helps in
+	  instantiating devices on the mikroBUS port with identifier
+	  data fetched from an EEPROM on the device, more details on
+	  the mikroBUS driver support and discussion can be found in
+	  this eLinux wiki : elinux.org/Mikrobus
+
+
+	  Say Y here to enable support for this driver.
+
+	  To compile this code as a module, chose M here: the module
+	  will be called mikrobus.ko
diff --git a/drivers/misc/mikrobus/Makefile b/drivers/misc/mikrobus/Makefile
new file mode 100644
index 000000000000..1f80ed4064d8
--- /dev/null
+++ b/drivers/misc/mikrobus/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0
+# mikroBUS Core
+
+mikrobus-y :=	mikrobus_core.o	mikrobus_manifest.o
+obj-$(CONFIG_MIKROBUS) += mikrobus.o
\ No newline at end of file
diff --git a/drivers/misc/mikrobus/mikrobus_core.c b/drivers/misc/mikrobus/mikrobus_core.c
new file mode 100644
index 000000000000..78c96c637632
--- /dev/null
+++ b/drivers/misc/mikrobus/mikrobus_core.c
@@ -0,0 +1,649 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * mikroBUS driver for instantiating add-on
+ * board devices with an identifier EEPROM
+ *
+ * Copyright 2020 Vaishnav M A, BeagleBoard.org Foundation.
+ */
+
+#define pr_fmt(fmt) "mikrobus: " fmt
+
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/idr.h>
+#include <linux/init.h>
+#include <linux/jump_label.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/gpio/consumer.h>
+#include <linux/mutex.h>
+#include <linux/device.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/i2c.h>
+#include <linux/gpio.h>
+#include <linux/gpio/machine.h>
+#include <linux/nvmem-consumer.h>
+#include <linux/nvmem-provider.h>
+#include <linux/interrupt.h>
+#include <linux/spi/spi.h>
+#include <linux/serdev.h>
+#include <linux/property.h>
+#include <linux/slab.h>
+
+#include "mikrobus_core.h"
+#include "mikrobus_manifest.h"
+
+#define ATMEL_24C32_I2C_ADDR 0x57
+
+static DEFINE_IDR(mikrobus_port_idr);
+static struct class_compat *mikrobus_port_compat_class;
+static bool is_registered;
+
+static ssize_t add_port_store(struct bus_type *bt, const char *buf,
+			      size_t count)
+{
+	struct mikrobus_port_config *cfg;
+
+	if (count < sizeof(*cfg)) {
+		pr_err("add_port: incorrect config data received: %s\n", buf);
+		return -EINVAL;
+	}
+	mikrobus_register_port_config((void *)buf);
+	return count;
+}
+BUS_ATTR_WO(add_port);
+
+static ssize_t del_port_store(struct bus_type *bt, const char *buf,
+							  size_t count)
+{
+	int id;
+	char end;
+	int res;
+
+	res = sscanf(buf, "%d%c", &id, &end);
+	if (res < 1) {
+		pr_err("delete_port: cannot parse mikrobus port ID\n");
+		return -EINVAL;
+	}
+	if (!idr_find(&mikrobus_port_idr, id)) {
+		pr_err("attempting to delete unregistered port [%d]\n", id);
+		return -EINVAL;
+	}
+	mikrobus_del_port(idr_find(&mikrobus_port_idr, id));
+	return count;
+}
+BUS_ATTR_WO(del_port);
+
+static struct attribute *mikrobus_attrs[] = {
+	&bus_attr_add_port.attr,
+	&bus_attr_del_port.attr,
+	 NULL
+};
+ATTRIBUTE_GROUPS(mikrobus);
+
+struct bus_type mikrobus_bus_type = {
+	.name = "mikrobus",
+	.bus_groups = mikrobus_groups,
+};
+EXPORT_SYMBOL_GPL(mikrobus_bus_type);
+
+static int mikrobus_port_scan_eeprom(struct mikrobus_port *port)
+{
+	char header[12];
+	struct addon_board_info *board;
+	int manifest_size;
+	int retval;
+	char *buf;
+
+	nvmem_device_read(port->eeprom, 0, 12, header);
+	manifest_size = mikrobus_manifest_header_validate(header, 12);
+	if (manifest_size > 0) {
+		buf = kzalloc(manifest_size, GFP_KERNEL);
+		nvmem_device_read(port->eeprom, 0, manifest_size, buf);
+		board = kzalloc(sizeof(*board), GFP_KERNEL);
+		if (!board)
+			return -ENOMEM;
+		INIT_LIST_HEAD(&board->manifest_descs);
+		INIT_LIST_HEAD(&board->devices);
+		retval = mikrobus_manifest_parse(board, (void *)buf, manifest_size);
+		if (!retval) {
+			pr_err("failed to parse manifest, size: %d", manifest_size);
+			return -EINVAL;
+		}
+		retval = mikrobus_register_board(port, board);
+		if (retval) {
+			pr_err("failed to register board: %s", board->name);
+			return -EINVAL;
+		}
+		kfree(buf);
+	} else {
+		pr_err("inavlide manifest port %d", port->id);
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static ssize_t name_show(struct device *dev, struct device_attribute *attr,
+						 char *buf)
+{
+	return sprintf(buf, "%s\n", to_mikrobus_port(dev)->name);
+}
+static DEVICE_ATTR_RO(name);
+
+static ssize_t new_device_store(struct device *dev, struct device_attribute *attr,
+					 const char *buf, size_t count)
+{
+	struct mikrobus_port *port = to_mikrobus_port(dev);
+	struct addon_board_info *board;
+	int retval;
+
+	if (port->board == NULL) {
+		board = kzalloc(sizeof(*board), GFP_KERNEL);
+		if (!board)
+			return -EINVAL;
+		INIT_LIST_HEAD(&board->manifest_descs);
+		INIT_LIST_HEAD(&board->devices);
+	} else {
+		pr_err("port %d already has board registered", port->id);
+		return -EINVAL;
+	}
+	retval = mikrobus_manifest_parse(board, (void *)buf, count);
+	if (!retval) {
+		pr_err("failed to parse manifest");
+		return -EINVAL;
+	}
+	retval = mikrobus_register_board(port, board);
+	if (retval) {
+		pr_err("failed to register board: %s", board->name);
+		return -EINVAL;
+	}
+	return count;
+}
+static DEVICE_ATTR_WO(new_device);
+
+static ssize_t rescan_store(struct device *dev, struct device_attribute *attr,
+							const char *buf, size_t count)
+{
+	struct mikrobus_port *port = to_mikrobus_port(dev);
+	int id;
+	char end;
+	int res;
+	int retval;
+
+	res = sscanf(buf, "%d%c", &id, &end);
+	if (res < 1) {
+		pr_err("rescan: Can't parse trigger\n");
+		return -EINVAL;
+	}
+	if (port->board != NULL) {
+		pr_err("port %d already has board registered", port->id);
+		return -EINVAL;
+	}
+	retval = mikrobus_port_scan_eeprom(port);
+	if (retval) {
+		pr_err("port %d board register from manifest failed", port->id);
+		return -EINVAL;
+	}
+	return count;
+}
+static DEVICE_ATTR_WO(rescan);
+
+static ssize_t delete_device_store(struct device *dev, struct device_attribute *attr,
+							const char *buf, size_t count)
+{
+	int id;
+	char end;
+	int res;
+	struct mikrobus_port *port = to_mikrobus_port(dev);
+
+	res = sscanf(buf, "%d%c", &id, &end);
+	if (res < 1) {
+		pr_err("delete_board: Can't parse board ID\n");
+		return -EINVAL;
+	}
+	if (port->board == NULL) {
+		pr_err("delete_board: port does not have any boards registered\n");
+		return -EINVAL;
+	}
+	mikrobus_unregister_board(port, port->board);
+	return count;
+}
+static DEVICE_ATTR_IGNORE_LOCKDEP(delete_device, 0200, NULL, delete_device_store);
+
+static struct attribute *mikrobus_port_attrs[] = {
+	&dev_attr_new_device.attr, &dev_attr_rescan.attr,
+	&dev_attr_delete_device.attr, &dev_attr_name.attr, NULL};
+ATTRIBUTE_GROUPS(mikrobus_port);
+
+static void mikrobus_dev_release(struct device *dev)
+{
+	struct mikrobus_port *port = to_mikrobus_port(dev);
+
+	idr_remove(&mikrobus_port_idr, port->id);
+	kfree(port);
+}
+
+struct device_type mikrobus_port_type = {
+	.groups = mikrobus_port_groups,
+	.release = mikrobus_dev_release,
+};
+EXPORT_SYMBOL_GPL(mikrobus_port_type);
+
+static int mikrobus_get_irq(struct mikrobus_port *port, int irqno,
+							int irq_type)
+{
+	int irq;
+
+	switch (irqno) {
+	case MIKROBUS_GPIO_INT:
+	irq = gpiod_to_irq(port->int_gpio);
+	break;
+	case MIKROBUS_GPIO_RST:
+	irq = gpiod_to_irq(port->rst_gpio);
+	break;
+	case MIKROBUS_GPIO_PWM:
+	irq = gpiod_to_irq(port->pwm_gpio);
+	break;
+	default:
+	return -EINVAL;
+	}
+	if (irq < 0) {
+		pr_err("Could not get irq for irq type: %d", irqno);
+		return -EINVAL;
+	}
+	irq_set_irq_type(irq, irq_type);
+	return irq;
+}
+
+static int mikrobus_setup_gpio(struct gpio_desc *gpio, int gpio_state)
+{
+	int retval;
+
+	if (gpio_state == MIKROBUS_GPIO_UNUSED)
+		return 0;
+	switch (gpio_state) {
+	case MIKROBUS_GPIO_INPUT:
+	retval = gpiod_direction_input(gpio);
+	break;
+	case MIKROBUS_GPIO_OUTPUT_HIGH:
+	retval = gpiod_direction_output(gpio, 1);
+	gpiod_set_value_cansleep(gpio, 1);
+	break;
+	case MIKROBUS_GPIO_OUTPUT_LOW:
+	retval = gpiod_direction_output(gpio, 0);
+	gpiod_set_value_cansleep(gpio, 0);
+	break;
+	default:
+	return -EINVAL;
+	}
+	return retval;
+}
+
+static void mikrobus_spi_device_delete(struct spi_master *master, unsigned int cs)
+{
+	struct device *dev;
+	char str[32];
+
+	snprintf(str, sizeof(str), "%s.%u", dev_name(&master->dev), cs);
+	dev = bus_find_device_by_name(&spi_bus_type, NULL, str);
+	if (dev != NULL) {
+		spi_unregister_device(to_spi_device(dev));
+		put_device(dev);
+	}
+}
+
+static char *mikrobus_get_gpio_chip_name(struct mikrobus_port *port, int gpio)
+{
+	char *name;
+	struct gpio_chip *gpiochip;
+
+	switch (gpio) {
+	case MIKROBUS_GPIO_INT:
+	gpiochip = gpiod_to_chip(port->int_gpio);
+	name = kmemdup(gpiochip->label, 40, GFP_KERNEL);
+	break;
+	case MIKROBUS_GPIO_RST:
+	gpiochip = gpiod_to_chip(port->rst_gpio);
+	name = kmemdup(gpiochip->label, 40, GFP_KERNEL);
+	break;
+	case MIKROBUS_GPIO_PWM:
+	gpiochip = gpiod_to_chip(port->pwm_gpio);
+	name = kmemdup(gpiochip->label, 40, GFP_KERNEL);
+	break;
+	}
+	return name;
+}
+
+static int mikrobus_get_gpio_hwnum(struct mikrobus_port *port, int gpio)
+{
+	int hwnum;
+	struct gpio_chip *gpiochip;
+
+	switch (gpio) {
+	case MIKROBUS_GPIO_INT:
+	gpiochip = gpiod_to_chip(port->int_gpio);
+	hwnum = desc_to_gpio(port->int_gpio) - gpiochip->base;
+	break;
+	case MIKROBUS_GPIO_RST:
+	gpiochip = gpiod_to_chip(port->rst_gpio);
+	hwnum = desc_to_gpio(port->rst_gpio) - gpiochip->base;
+	break;
+	case MIKROBUS_GPIO_PWM:
+	gpiochip = gpiod_to_chip(port->pwm_gpio);
+	hwnum = desc_to_gpio(port->pwm_gpio) - gpiochip->base;
+	break;
+	}
+	return hwnum;
+}
+
+static void release_mikrobus_device(struct board_device_info *dev)
+{
+	list_del(&dev->links);
+	kfree(dev);
+}
+
+static void release_board_devices(struct addon_board_info *info)
+{
+	struct board_device_info *dev;
+	struct board_device_info *next;
+
+	list_for_each_entry_safe(dev, next, &info->devices, links)
+		release_mikrobus_device(dev);
+}
+
+static int mikrobus_register_device(struct mikrobus_port *port,
+					struct board_device_info *dev, char *board_name)
+{
+	struct i2c_board_info *i2c;
+	struct spi_board_info *spi;
+	struct gpiod_lookup_table *lookup;
+	char devname[40];
+	int i;
+
+	pr_info(" registering device : %s\n", dev->drv_name);
+
+	if (dev->gpio_lookup != NULL) {
+		lookup = dev->gpio_lookup;
+		if (dev->protocol == MIKROBUS_PROTOCOL_SPI) {
+			snprintf(devname, sizeof(devname), "%s.%u",
+				dev_name(&port->spi_mstr->dev), dev->reg);
+			lookup->dev_id = kmemdup(devname, 40, GFP_KERNEL);
+		} else if (dev->protocol == MIKROBUS_PROTOCOL_I2C)
+			lookup->dev_id = dev->drv_name;
+		pr_info(" adding lookup table : %s\n", lookup->dev_id);
+		for (i = 0; i < dev->num_gpio_resources; i++) {
+			lookup->table[i].key =
+			mikrobus_get_gpio_chip_name(port, lookup->table[i].chip_hwnum);
+			lookup->table[i].chip_hwnum =
+			mikrobus_get_gpio_hwnum(port, lookup->table[i].chip_hwnum);
+			lookup->table[i].flags = GPIO_ACTIVE_HIGH;
+		}
+		gpiod_add_lookup_table(lookup);
+	}
+	switch (dev->protocol) {
+	case MIKROBUS_PROTOCOL_SPI:
+	spi = kzalloc(sizeof(*spi), GFP_KERNEL);
+	if (!spi)
+		return -ENOMEM;
+	strncpy(spi->modalias, dev->drv_name, sizeof(spi->modalias) - 1);
+	if (dev->irq)
+		spi->irq = mikrobus_get_irq(port, dev->irq, dev->irq_type);
+	if (dev->properties)
+		spi->properties = dev->properties;
+	spi->chip_select = dev->reg;
+	spi->max_speed_hz = dev->max_speed_hz;
+	spi->mode = dev->mode;
+	mikrobus_spi_device_delete(port->spi_mstr, dev->reg);
+	dev->dev_client = (void *)spi_new_device(port->spi_mstr, spi);
+	break;
+	case MIKROBUS_PROTOCOL_I2C:
+	i2c = kzalloc(sizeof(*i2c), GFP_KERNEL);
+	if (!i2c)
+		return -ENOMEM;
+	strncpy(i2c->type, dev->drv_name, sizeof(i2c->type) - 1);
+	if (dev->irq)
+		i2c->irq = mikrobus_get_irq(port, dev->irq, dev->irq_type);
+	if (dev->properties)
+		i2c->properties = dev->properties;
+	i2c->addr = dev->reg;
+	dev->dev_client = (void *)i2c_new_client_device(port->i2c_adap, i2c);
+	break;
+	case MIKROBUS_PROTOCOL_UART:
+	pr_info("SERDEV devices support not yet added");
+	break;
+	default:
+	return -EINVAL;
+	}
+	return 0;
+}
+
+static void mikrobus_unregister_device(struct mikrobus_port *port, struct board_device_info *dev,
+										char *board_name)
+{
+	pr_info(" removing device : %s\n", dev->drv_name);
+	if (dev->gpio_lookup != NULL) {
+		gpiod_remove_lookup_table(dev->gpio_lookup);
+		kfree(dev->gpio_lookup);
+	}
+	if (dev->properties != NULL)
+		kfree(dev->properties);
+	switch (dev->protocol) {
+	case MIKROBUS_PROTOCOL_SPI:
+	spi_unregister_device((struct spi_device *)dev->dev_client);
+	break;
+	case MIKROBUS_PROTOCOL_I2C:
+	i2c_unregister_device((struct i2c_client *)dev->dev_client);
+	break;
+	case MIKROBUS_PROTOCOL_UART:
+	pr_err("SERDEV devices support not yet added");
+	break;
+	}
+}
+
+int mikrobus_register_board(struct mikrobus_port *port,	struct addon_board_info *board)
+{
+	struct board_device_info *devinfo;
+	struct board_device_info *next;
+	int retval;
+
+	if (WARN_ON(list_empty(&board->devices)))
+		return false;
+
+	retval = mikrobus_setup_gpio(port->pwm_gpio, board->pwm_gpio_state);
+	if (retval) {
+		pr_err("mikrobus_setup_gpio : can't setup pwm gpio state: (%d)\n", retval);
+		return retval;
+	}
+	retval = mikrobus_setup_gpio(port->int_gpio, board->int_gpio_state);
+	if (retval) {
+		pr_err("mikrobus_setup_gpio : can't setup int gpio state: (%d)\n", retval);
+		return retval;
+	}
+	retval = mikrobus_setup_gpio(port->rst_gpio, board->rst_gpio_state);
+	if (retval) {
+		pr_err("mikrobus_setup_gpio : can't setup rst gpio state: (%d)\n", retval);
+		return retval;
+	}
+	list_for_each_entry_safe(devinfo, next, &board->devices, links)
+		mikrobus_register_device(port, devinfo, board->name);
+	port->board = board;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mikrobus_register_board);
+
+void mikrobus_unregister_board(struct mikrobus_port *port, struct addon_board_info *board)
+{
+	struct board_device_info *devinfo;
+	struct board_device_info *next;
+
+	if (WARN_ON(list_empty(&board->devices)))
+		return;
+	port->board = NULL;
+	list_for_each_entry_safe(devinfo, next, &board->devices, links)
+		mikrobus_unregister_device(port, devinfo, board->name);
+	release_board_devices(board);
+	kfree(board);
+	port->board = NULL;
+}
+EXPORT_SYMBOL_GPL(mikrobus_unregister_board);
+
+int mikrobus_register_port_config(struct mikrobus_port_config *cfg)
+{
+	struct mikrobus_port *port;
+	int retval;
+
+	if (WARN_ON(!is_registered))
+		return -EAGAIN;
+	port = kzalloc(sizeof(*port), GFP_KERNEL);
+	if (!port)
+		return -ENOMEM;
+	port->pwm_gpio = gpio_to_desc(cfg->pwm_gpio_nr);
+	port->int_gpio = gpio_to_desc(cfg->int_gpio_nr);
+	port->rst_gpio = gpio_to_desc(cfg->rst_gpio_nr);
+	port->spi_mstr = spi_busnum_to_master(cfg->spi_master_nr);
+	port->i2c_adap = i2c_get_adapter(cfg->i2c_adap_nr);
+	retval = mikrobus_register_port(port);
+	if (retval) {
+		pr_err("port : can't register port from config (%d)\n", retval);
+		return retval;
+	}
+	return retval;
+}
+EXPORT_SYMBOL_GPL(mikrobus_register_port_config);
+
+static struct i2c_board_info mikrobus_eeprom_info = {
+	I2C_BOARD_INFO("24c32", ATMEL_24C32_I2C_ADDR),
+};
+
+static int mikrobus_port_probe_eeprom(struct mikrobus_port *port)
+{
+	struct i2c_client *eeprom_client;
+	struct nvmem_device *eeprom;
+	char dev_name[40];
+
+	eeprom_client = i2c_new_client_device(port->i2c_adap, &mikrobus_eeprom_info);
+	if (!IS_ERR(eeprom_client)) {
+		pr_info(" mikrobus port %d default eeprom is probed at %02x\n", port->id,
+									eeprom_client->addr);
+		snprintf(dev_name, sizeof(dev_name), "%d-%04x0", port->i2c_adap->nr,
+				 eeprom_client->addr);
+		eeprom = nvmem_device_get(&eeprom_client->dev, dev_name);
+		if (IS_ERR(eeprom)) {
+			pr_err(" mikrobus port %d eeprom nvmem device probe failed\n", port->id);
+			i2c_unregister_device(eeprom_client);
+			port->eeprom = NULL;
+			return 0;
+		}
+	} else {
+		pr_info(" mikrobus port %d default eeprom probe failed\n", port->id);
+		return 0;
+	}
+	port->eeprom = eeprom;
+	port->eeprom_client = eeprom_client;
+	return 0;
+}
+
+int mikrobus_register_port(struct mikrobus_port *port)
+{
+	int retval;
+	int id;
+
+	if (WARN_ON(!is_registered))
+		return -EAGAIN;
+	id = idr_alloc(&mikrobus_port_idr, port, 0, 0, GFP_KERNEL);
+	if (id < 0)
+		return id;
+	port->id = id;
+	port->dev.bus = &mikrobus_bus_type;
+	port->dev.type = &mikrobus_port_type;
+	strncpy(port->name, "mikrobus-port", sizeof(port->name) - 1);
+	dev_set_name(&port->dev, "mikrobus-%d", port->id);
+	pr_info("registering port mikrobus-%d\n ", port->id);
+	retval = device_register(&port->dev);
+	if (retval) {
+		pr_err("port '%d': can't register device (%d)\n", port->id, retval);
+		put_device(&port->dev);
+		return retval;
+	}
+	retval = class_compat_create_link(mikrobus_port_compat_class, &port->dev,
+								port->dev.parent);
+	if (retval)
+		dev_warn(&port->dev, "failed to create compatibility class link\n");
+	if (!port->eeprom) {
+		pr_info("mikrobus port %d eeprom empty probing default eeprom\n", port->id);
+		retval = mikrobus_port_probe_eeprom(port);
+	}
+	if (port->eeprom) {
+		retval = mikrobus_port_scan_eeprom(port);
+		if (retval)
+			dev_warn(&port->dev, "failed to register board from manifest\n");
+	}
+	return retval;
+}
+EXPORT_SYMBOL_GPL(mikrobus_register_port);
+
+void mikrobus_del_port(struct mikrobus_port *port)
+{
+	struct mikrobus_port *found;
+
+	found = idr_find(&mikrobus_port_idr, port->id);
+	if (found != port) {
+		pr_err("attempting to delete unregistered port [%s]\n", port->name);
+		return;
+	}
+	if (port->board != NULL) {
+		pr_err("attempting to delete port with registered boards, port [%s]\n",
+									port->name);
+		return;
+	}
+
+	if (port->eeprom) {
+		nvmem_device_put(port->eeprom);
+		i2c_unregister_device(port->eeprom_client);
+	}
+
+	class_compat_remove_link(mikrobus_port_compat_class, &port->dev,
+							port->dev.parent);
+	device_unregister(&port->dev);
+	idr_remove(&mikrobus_port_idr, port->id);
+	memset(&port->dev, 0, sizeof(port->dev));
+}
+EXPORT_SYMBOL_GPL(mikrobus_del_port);
+
+static int __init mikrobus_init(void)
+{
+	int retval;
+
+	retval = bus_register(&mikrobus_bus_type);
+	if (retval) {
+		pr_err("bus_register failed (%d)\n", retval);
+		return retval;
+	}
+	mikrobus_port_compat_class = class_compat_register("mikrobus-port");
+	if (!mikrobus_port_compat_class) {
+		pr_err("class_compat register failed (%d)\n", retval);
+		retval = -ENOMEM;
+		goto class_err;
+	}
+	is_registered = true;
+	return 0;
+class_err:
+	bus_unregister(&mikrobus_bus_type);
+	idr_destroy(&mikrobus_port_idr);
+	is_registered = false;
+	return retval;
+}
+subsys_initcall(mikrobus_init);
+
+static void __exit mikrobus_exit(void)
+{
+	bus_unregister(&mikrobus_bus_type);
+	class_compat_unregister(mikrobus_port_compat_class);
+	idr_destroy(&mikrobus_port_idr);
+}
+module_exit(mikrobus_exit);
+
+MODULE_AUTHOR("Vaishnav M A <vaishnav@beagleboard.org>");
+MODULE_DESCRIPTION("mikroBUS main module");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/misc/mikrobus/mikrobus_core.h b/drivers/misc/mikrobus/mikrobus_core.h
new file mode 100644
index 000000000000..9684d315f564
--- /dev/null
+++ b/drivers/misc/mikrobus/mikrobus_core.h
@@ -0,0 +1,130 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * mikroBUS Driver for instantiating add-on
+ * board devices with an identifier EEPROM
+ *
+ * Copyright 2020 Vaishnav M A, BeagleBoard.org Foundation.
+ */
+
+#ifndef __MIKROBUS_H
+#define __MIKROBUS_H
+
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/i2c.h>
+#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
+#include <linux/gpio/machine.h>
+#include <linux/spi/spi.h>
+#include <linux/idr.h>
+#include <linux/init.h>
+#include <linux/jump_label.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/device.h>
+#include <linux/of_device.h>
+#include <linux/serdev.h>
+#include <linux/of.h>
+#include <linux/property.h>
+#include <linux/slab.h>
+
+#define MIKROBUS_VERSION_MAJOR 0x00
+#define MIKROBUS_VERSION_MINOR 0x02
+
+extern struct bus_type mikrobus_bus_type;
+extern struct device_type mikrobus_port_type;
+
+enum mikrobus_property_type {
+	MIKROBUS_PROPERTY_TYPE_LINK = 0x00,
+	MIKROBUS_PROPERTY_TYPE_GPIO = 0x01,
+	MIKROBUS_PROPERTY_TYPE_U8 = 0x02,
+	MIKROBUS_PROPERTY_TYPE_U16 = 0x03,
+	MIKROBUS_PROPERTY_TYPE_U32 = 0x04,
+	MIKROBUS_PROPERTY_TYPE_U64 = 0x05,
+};
+
+enum mikrobus_gpio_pin {
+	MIKROBUS_GPIO_INVALID = 0x00,
+	MIKROBUS_GPIO_INT = 0x01,
+	MIKROBUS_GPIO_RST = 0x02,
+	MIKROBUS_GPIO_PWM = 0x03,
+};
+
+enum mikrobus_protocol {
+	MIKROBUS_PROTOCOL_SPI = 0x01,
+	MIKROBUS_PROTOCOL_I2C = 0x02,
+	MIKROBUS_PROTOCOL_UART = 0x03,
+	MIKROBUS_PROTOCOL_SPI_GPIOCS = 0x04,
+	MIKROBUS_PROTOCOL_I2C_MUX = 0x05
+};
+
+enum mikrobus_gpio_state {
+	MIKROBUS_GPIO_UNUSED = 0x00,
+	MIKROBUS_GPIO_INPUT = 0x01,
+	MIKROBUS_GPIO_OUTPUT_HIGH = 0x02,
+	MIKROBUS_GPIO_OUTPUT_LOW = 0x03,
+};
+
+struct mikrobus_port_config {
+	__u8 i2c_adap_nr;
+	__u8 spi_master_nr;
+	__u8 serdev_ctlr_nr;
+	__u8 rst_gpio_nr;
+	__u8 pwm_gpio_nr;
+	__u8 int_gpio_nr;
+} __packed;
+
+struct board_device_info {
+	struct list_head links;
+	int id;
+	char *drv_name;
+	unsigned short protocol;
+	unsigned short reg;
+	u32 max_speed_hz;
+	unsigned int mode;
+	int irq;
+	int irq_type;
+	int cs_gpio;
+	unsigned short num_gpio_resources;
+	unsigned short num_properties;
+	struct property_entry *properties;
+	struct gpiod_lookup_table *gpio_lookup;
+	void *dev_client;
+};
+
+struct addon_board_info {
+	char *name;
+	unsigned short num_devices;
+	unsigned short rst_gpio_state;
+	unsigned short pwm_gpio_state;
+	unsigned short int_gpio_state;
+	struct list_head manifest_descs;
+	struct list_head devices;
+};
+
+struct mikrobus_port {
+	char name[48];
+	struct module *owner;
+	struct device dev;
+	int id;
+	struct gpio_desc *pwm_gpio;
+	struct gpio_desc *int_gpio;
+	struct gpio_desc *rst_gpio;
+	struct spi_master *spi_mstr;
+	struct i2c_adapter *i2c_adap;
+	struct addon_board_info *board;
+	struct i2c_client *eeprom_client;
+	struct nvmem_device *eeprom;
+};
+#define to_mikrobus_port(d) container_of(d, struct mikrobus_port, dev)
+
+int mikrobus_register_board(struct mikrobus_port *port,
+							struct addon_board_info *board);
+void mikrobus_unregister_board(struct mikrobus_port *port,
+							   struct addon_board_info *board);
+int mikrobus_register_port_config(struct mikrobus_port_config *cfg);
+int mikrobus_register_port(struct mikrobus_port *port);
+void mikrobus_del_port(struct mikrobus_port *port);
+
+#endif /* __MIKROBUS_H */
diff --git a/drivers/misc/mikrobus/mikrobus_manifest.c b/drivers/misc/mikrobus/mikrobus_manifest.c
new file mode 100644
index 000000000000..60ebca560f0d
--- /dev/null
+++ b/drivers/misc/mikrobus/mikrobus_manifest.c
@@ -0,0 +1,390 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * mikroBUS manifest parsing, an
+ * extension to Greybus Manifest Parsing
+ * under drivers/greybus/manifest.c
+ *
+ * Copyright 2014-2015 Google Inc.
+ * Copyright 2014-2015 Linaro Ltd.
+ */
+
+#define pr_fmt(fmt) "mikrobus_manifest: " fmt
+
+#include <linux/bits.h>
+#include <linux/types.h>
+#include <linux/property.h>
+#include <linux/greybus/greybus_manifest.h>
+
+#include "mikrobus_manifest.h"
+
+struct manifest_desc {
+	struct list_head links;
+	size_t size;
+	void *data;
+	enum greybus_descriptor_type type;
+};
+
+static void release_manifest_descriptor(struct manifest_desc *descriptor)
+{
+	list_del(&descriptor->links);
+	kfree(descriptor);
+}
+
+static void release_manifest_descriptors(struct addon_board_info *info)
+{
+	struct manifest_desc *descriptor;
+	struct manifest_desc *next;
+
+	list_for_each_entry_safe(descriptor, next, &info->manifest_descs, links)
+		release_manifest_descriptor(descriptor);
+}
+
+static int identify_descriptor(struct addon_board_info *info, struct greybus_descriptor *desc,
+										 size_t size)
+{
+	struct greybus_descriptor_header *desc_header = &desc->header;
+	struct manifest_desc *descriptor;
+	size_t desc_size;
+	size_t expected_size;
+
+	if (size < sizeof(*desc_header))
+		return -EINVAL;
+	desc_size = le16_to_cpu(desc_header->size);
+	if (desc_size > size)
+		return -EINVAL;
+	expected_size = sizeof(*desc_header);
+	switch (desc_header->type) {
+	case GREYBUS_TYPE_STRING:
+	expected_size += sizeof(struct greybus_descriptor_string);
+	expected_size += desc->string.length;
+	expected_size = ALIGN(expected_size, 4);
+	break;
+	case GREYBUS_TYPE_PROPERTY:
+	expected_size += sizeof(struct greybus_descriptor_property);
+	expected_size += desc->property.length;
+	expected_size = ALIGN(expected_size, 4);
+	break;
+	case GREYBUS_TYPE_DEVICE:
+	expected_size += sizeof(struct greybus_descriptor_device);
+	break;
+	case GREYBUS_TYPE_MIKROBUS:
+	expected_size += sizeof(struct greybus_descriptor_mikrobus);
+	break;
+	case GREYBUS_TYPE_INTERFACE:
+	expected_size += sizeof(struct greybus_descriptor_interface);
+	break;
+	case GREYBUS_TYPE_CPORT:
+	expected_size += sizeof(struct greybus_descriptor_cport);
+	break;
+	case GREYBUS_TYPE_BUNDLE:
+	expected_size += sizeof(struct greybus_descriptor_bundle);
+	break;
+	case GREYBUS_TYPE_INVALID:
+	default:
+	return -EINVAL;
+	}
+
+	descriptor = kzalloc(sizeof(*descriptor), GFP_KERNEL);
+	if (!descriptor)
+		return -ENOMEM;
+	descriptor->size = desc_size;
+	descriptor->data = (char *)desc + sizeof(*desc_header);
+	descriptor->type = desc_header->type;
+	list_add_tail(&descriptor->links, &info->manifest_descs);
+	return desc_size;
+}
+
+static char *mikrobus_string_get(struct addon_board_info *info, u8 string_id)
+{
+	struct greybus_descriptor_string *desc_string;
+	struct manifest_desc *descriptor;
+	bool found = false;
+	char *string;
+
+	if (!string_id)
+		return NULL;
+
+	list_for_each_entry(descriptor, &info->manifest_descs, links) {
+		if (descriptor->type != GREYBUS_TYPE_STRING)
+			continue;
+		desc_string = descriptor->data;
+		if (desc_string->id == string_id) {
+			found = true;
+			break;
+		}
+	}
+	if (!found)
+		return ERR_PTR(-ENOENT);
+	string = kmemdup(&desc_string->string, desc_string->length + 1, GFP_KERNEL);
+	if (!string)
+		return ERR_PTR(-ENOMEM);
+	string[desc_string->length] = '\0';
+	return string;
+}
+
+static void mikrobus_state_get(struct addon_board_info *info)
+{
+	struct greybus_descriptor_mikrobus *mikrobus;
+	struct greybus_descriptor_interface *interface;
+	struct manifest_desc *descriptor;
+	bool found = false;
+
+	list_for_each_entry(descriptor, &info->manifest_descs, links) {
+		if (descriptor->type == GREYBUS_TYPE_MIKROBUS) {
+			mikrobus = descriptor->data;
+			found = true;
+			break;
+		}
+	}
+
+	if (found) {
+		info->num_devices = mikrobus->num_devices;
+		info->rst_gpio_state = mikrobus->rst_gpio_state;
+		info->pwm_gpio_state = mikrobus->pwm_gpio_state;
+		info->int_gpio_state = mikrobus->int_gpio_state;
+	} else {
+		info->num_devices = 1;
+		info->rst_gpio_state = MIKROBUS_GPIO_UNUSED;
+		info->pwm_gpio_state = MIKROBUS_GPIO_UNUSED;
+		info->int_gpio_state = MIKROBUS_GPIO_UNUSED;
+	}
+
+	list_for_each_entry(descriptor, &info->manifest_descs, links) {
+		if (descriptor->type == GREYBUS_TYPE_INTERFACE) {
+			interface = descriptor->data;
+			break;
+		}
+	}
+	info->name = mikrobus_string_get(info, interface->product_stringid);
+}
+
+static struct property_entry *
+mikrobus_property_entry_get(struct addon_board_info *info, u8 *prop_link,
+							int num_properties)
+{
+	struct greybus_descriptor_property *desc_property;
+	struct manifest_desc *descriptor;
+	struct property_entry *properties;
+	int i;
+	char *prop_name;
+	bool found = false;
+	u8 *val_u8;
+	u16 *val_u16;
+	u32 *val_u32;
+	u64 *val_u64;
+
+	properties = kcalloc(num_properties, sizeof(*properties), GFP_KERNEL);
+	if (!properties)
+		return ERR_PTR(-ENOMEM);
+	for (i = 0; i < num_properties; i++) {
+		list_for_each_entry(descriptor, &info->manifest_descs, links) {
+			if (descriptor->type != GREYBUS_TYPE_PROPERTY)
+				continue;
+			desc_property = descriptor->data;
+			if (desc_property->id == prop_link[i]) {
+				found = true;
+				break;
+			}
+		}
+		if (!found)
+			return ERR_PTR(-ENOENT);
+		prop_name = mikrobus_string_get(info, desc_property->propname_stringid);
+		switch (desc_property->type) {
+		case MIKROBUS_PROPERTY_TYPE_U8:
+		val_u8 = kmemdup(&desc_property->value,
+				(desc_property->length) * sizeof(u8), GFP_KERNEL);
+		if (desc_property->length == 1)
+			properties[i] = PROPERTY_ENTRY_U8(prop_name, *val_u8);
+		else
+			properties[i] = PROPERTY_ENTRY_U8_ARRAY_LEN(
+				prop_name, (void *)desc_property->value, desc_property->length);
+		break;
+		case MIKROBUS_PROPERTY_TYPE_U16:
+		val_u16 = kmemdup(&desc_property->value,
+					(desc_property->length) * sizeof(u16), GFP_KERNEL);
+		if (desc_property->length == 1)
+			properties[i] = PROPERTY_ENTRY_U16(prop_name, *val_u16);
+		else
+			properties[i] = PROPERTY_ENTRY_U16_ARRAY_LEN(
+				prop_name, (void *)desc_property->value, desc_property->length);
+		break;
+		case MIKROBUS_PROPERTY_TYPE_U32:
+		val_u32 = kmemdup(&desc_property->value,
+					(desc_property->length) * sizeof(u32), GFP_KERNEL);
+		if (desc_property->length == 1)
+			properties[i] = PROPERTY_ENTRY_U32(prop_name, *val_u32);
+		else
+			properties[i] = PROPERTY_ENTRY_U32_ARRAY_LEN(
+			prop_name, (void *)desc_property->value, desc_property->length);
+		break;
+		case MIKROBUS_PROPERTY_TYPE_U64:
+		val_u64 = kmemdup(&desc_property->value,
+						(desc_property->length) * sizeof(u64), GFP_KERNEL);
+		if (desc_property->length == 1)
+			properties[i] = PROPERTY_ENTRY_U64(prop_name, *val_u64);
+		else
+			properties[i] = PROPERTY_ENTRY_U64_ARRAY_LEN(
+				prop_name, (void *)desc_property->value, desc_property->length);
+		break;
+		default:
+		return ERR_PTR(-EINVAL);
+		}
+	}
+	return properties;
+}
+
+static u8 *mikrobus_property_link_get(struct addon_board_info *info, u8 prop_id,
+									  u8 prop_type)
+{
+	struct greybus_descriptor_property *desc_property;
+	struct manifest_desc *descriptor;
+	bool found = false;
+	u8 *val_u8;
+
+	if (!prop_id)
+		return NULL;
+	list_for_each_entry(descriptor, &info->manifest_descs, links) {
+		if (descriptor->type != GREYBUS_TYPE_PROPERTY)
+			continue;
+		desc_property = descriptor->data;
+		if (desc_property->id == prop_id && desc_property->type == prop_type) {
+			found = true;
+			break;
+		}
+	}
+	if (!found)
+		return ERR_PTR(-ENOENT);
+	val_u8 = kmemdup(&desc_property->value, desc_property->length, GFP_KERNEL);
+	return val_u8;
+}
+
+static int mikrobus_manifest_attach_device(struct addon_board_info *info,
+						struct greybus_descriptor_device *dev_desc)
+{
+	struct board_device_info *dev;
+	struct gpiod_lookup_table *lookup;
+	struct greybus_descriptor_property *desc_property;
+	struct manifest_desc *descriptor;
+	int i;
+	u8 *prop_link;
+	u8 *gpio_desc_link;
+
+	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
+	if (!dev)
+		return -ENOMEM;
+	dev->id = dev_desc->id;
+	dev->drv_name = mikrobus_string_get(info, dev_desc->driver_stringid);
+	dev->protocol = dev_desc->protocol;
+	dev->reg = dev_desc->reg;
+	dev->irq = dev_desc->irq;
+	dev->irq_type = dev_desc->irq_type;
+	dev->max_speed_hz = le32_to_cpu(dev_desc->max_speed_hz);
+	dev->mode = dev_desc->mode;
+	dev->cs_gpio = dev_desc->cs_gpio;
+	dev->num_gpio_resources = dev_desc->num_gpio_resources;
+	dev->num_properties = dev_desc->num_properties;
+	pr_info("device %d , number of properties=%d , number of gpio resources=%d\n",
+	dev->id, dev->num_properties, dev->num_gpio_resources);
+	if (dev->num_properties > 0) {
+		prop_link = mikrobus_property_link_get(info, dev_desc->prop_link,
+								MIKROBUS_PROPERTY_TYPE_LINK);
+		dev->properties = mikrobus_property_entry_get(info, prop_link, dev->num_properties);
+	}
+	if (dev->num_gpio_resources > 0) {
+		lookup = kzalloc(struct_size(lookup, table, dev->num_gpio_resources),
+					GFP_KERNEL);
+	if (!lookup)
+		return -ENOMEM;
+	gpio_desc_link = mikrobus_property_link_get(info, dev_desc->gpio_link,
+						MIKROBUS_PROPERTY_TYPE_GPIO);
+	for (i = 0; i < dev->num_gpio_resources; i++) {
+		list_for_each_entry(descriptor, &info->manifest_descs, links) {
+			if (descriptor->type != GREYBUS_TYPE_PROPERTY)
+				continue;
+			desc_property = descriptor->data;
+			if (desc_property->id == gpio_desc_link[i]) {
+				lookup->table[i].chip_hwnum = *desc_property->value;
+				lookup->table[i].con_id =
+				mikrobus_string_get(info, desc_property->propname_stringid);
+				break;
+				}
+		}
+	}
+	dev->gpio_lookup = lookup;
+	}
+	list_add_tail(&dev->links, &info->devices);
+	return 0;
+}
+
+static int mikrobus_manifest_parse_devices(struct addon_board_info *info)
+{
+	struct greybus_descriptor_device *desc_device;
+	struct manifest_desc *desc, *next;
+	int devcount = 0;
+
+	if (WARN_ON(!list_empty(&info->devices)))
+		return false;
+	list_for_each_entry_safe(desc, next, &info->manifest_descs, links) {
+		if (desc->type != GREYBUS_TYPE_DEVICE)
+			continue;
+		desc_device = desc->data;
+		mikrobus_manifest_attach_device(info, desc_device);
+		devcount++;
+	}
+	return devcount;
+}
+
+bool mikrobus_manifest_parse(struct addon_board_info *info, void *data,
+							 size_t size)
+{
+	struct greybus_manifest *manifest;
+	struct greybus_manifest_header *header;
+	struct greybus_descriptor *desc;
+	u16 manifest_size;
+	int dev_count;
+	int desc_size;
+
+	if (WARN_ON(!list_empty(&info->manifest_descs)))
+		return false;
+	if (size < sizeof(*header))
+		return false;
+	manifest = data;
+	header = &manifest->header;
+	manifest_size = le16_to_cpu(header->size);
+	if (manifest_size != size)
+		return false;
+	if (header->version_major > MIKROBUS_VERSION_MAJOR)
+		return false;
+	desc = manifest->descriptors;
+	size -= sizeof(*header);
+	while (size) {
+		desc_size = identify_descriptor(info, desc, size);
+		if (desc_size < 0) {
+			pr_err("invalid manifest descriptor");
+		return -EINVAL;
+		}
+		desc = (struct greybus_descriptor *)((char *)desc + desc_size);
+		size -= desc_size;
+	}
+	mikrobus_state_get(info);
+	dev_count = mikrobus_manifest_parse_devices(info);
+	pr_info(" %s manifest parsed with %d device(s)\n", info->name,
+		info->num_devices);
+	release_manifest_descriptors(info);
+	return true;
+}
+
+size_t mikrobus_manifest_header_validate(void *data, size_t size)
+{
+	struct greybus_manifest_header *header;
+	u16 manifest_size;
+
+	if (size < sizeof(*header))
+		return 0;
+
+	header = data;
+	manifest_size = le16_to_cpu(header->size);
+	if (header->version_major > MIKROBUS_VERSION_MAJOR)
+		return 0;
+	return manifest_size;
+}
diff --git a/drivers/misc/mikrobus/mikrobus_manifest.h b/drivers/misc/mikrobus/mikrobus_manifest.h
new file mode 100644
index 000000000000..a195d1c26493
--- /dev/null
+++ b/drivers/misc/mikrobus/mikrobus_manifest.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * mikroBUS manifest definition
+ * extension to Greybus Manifest Definition
+ *
+ * Copyright 2014-2015 Google Inc.
+ * Copyright 2014-2015 Linaro Ltd.
+ *
+ * Released under the GPLv2 and BSD licenses.
+ */
+
+#ifndef __MIKROBUS_MANIFEST_H
+#define __MIKROBUS_MANIFEST_H
+
+#include "mikrobus_core.h"
+
+bool mikrobus_manifest_parse(struct addon_board_info *info, void *data,
+							 size_t size);
+size_t mikrobus_manifest_header_validate(void *data, size_t size);
+
+#endif /* __MIKROBUS_MANIFEST_H */
diff --git a/include/linux/greybus/greybus_manifest.h b/include/linux/greybus/greybus_manifest.h
index 6e62fe478712..79c8cab9ef96 100644
--- a/include/linux/greybus/greybus_manifest.h
+++ b/include/linux/greybus/greybus_manifest.h
@@ -23,6 +23,9 @@ enum greybus_descriptor_type {
 	GREYBUS_TYPE_STRING		= 0x02,
 	GREYBUS_TYPE_BUNDLE		= 0x03,
 	GREYBUS_TYPE_CPORT		= 0x04,
+	GREYBUS_TYPE_MIKROBUS	= 0x05,
+	GREYBUS_TYPE_PROPERTY	= 0x06,
+	GREYBUS_TYPE_DEVICE	= 0x07,
 };
 
 enum greybus_protocol {
@@ -151,6 +154,53 @@ struct greybus_descriptor_cport {
 	__u8	protocol_id;	/* enum greybus_protocol */
 } __packed;
 
+/*
+ * A mikrobus descriptor is used to describe the details
+ * about the add-on board connected to the mikrobus port.
+ * It describes the number of indivdual devices on the
+ * add-on board and the default states of the GPIOs
+ */
+struct greybus_descriptor_mikrobus {
+	__u8 num_devices;
+	__u8 rst_gpio_state;
+	__u8 pwm_gpio_state;
+	__u8 int_gpio_state;
+} __packed;
+
+/*
+ * A property descriptor is used to pass named properties
+ * to device drivers through the unified device properties
+ * interface under linux/property.h
+ */
+struct greybus_descriptor_property {
+	__u8 length;
+	__u8 id;
+	__u8 propname_stringid;
+	__u8 type;
+	__u8 value[0];
+} __packed;
+
+/*
+ * A device descriptor is used to describe the
+ * details required by a add-on board device
+ * driver.
+ */
+struct greybus_descriptor_device {
+	__u8 id;
+	__u8 driver_stringid;
+	__u8 num_properties;
+	__u8 protocol;
+	__le32 max_speed_hz;
+	__u8 reg;
+	__u8 mode;
+	__u8 num_gpio_resources;
+	__u8 cs_gpio;
+	__u8 irq;
+	__u8 irq_type;
+	__u8 prop_link;
+	__u8 gpio_link;
+} __packed;
+
 struct greybus_descriptor_header {
 	__le16	size;
 	__u8	type;		/* enum greybus_descriptor_type */
@@ -164,6 +214,9 @@ struct greybus_descriptor {
 		struct greybus_descriptor_interface	interface;
 		struct greybus_descriptor_bundle	bundle;
 		struct greybus_descriptor_cport		cport;
+		struct greybus_descriptor_mikrobus	mikrobus;
+		struct greybus_descriptor_property	property;
+		struct greybus_descriptor_device	device;
 	};
 } __packed;
 
-- 
2.25.1

