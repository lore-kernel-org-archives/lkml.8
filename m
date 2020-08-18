Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CC1BC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 12:49:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA4F320706
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 12:49:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=beagleboard-org.20150623.gappssmtp.com header.i=@beagleboard-org.20150623.gappssmtp.com header.b="qbZoq8Q9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbgHRMtJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 08:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbgHRMst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 08:48:49 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 669CEC061342
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 05:48:49 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id f9so9177404pju.4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 05:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P8FUTcAkSzX0gwG+BzSomHVjTY5h0EVdky25ut42j9c=;
        b=qbZoq8Q9C6TFt7Bj8Tgct22QU2+1+gnGGephO8D0b/kruf+EmIZgSHkHbGSnobLMNe
         a6LhEHo/q5aQlffyBgPXFZJMmgq4BeyK/nNofAl0Bv5Tqwg0HfClqD9SGs+kelig5OZw
         H5J0GHNZyBcjxDyJ0VDy1mnjNLJLNoYik1c0Kh1bF/8gvoa9oRmHtKZBdUADqghyjMHa
         +m2T8y70BLNal80fIm+Gxddausou+R/emPsdjRbb9N1idemq03yuH84B7iTkAdEoBWcX
         SMicIGW4OVYJwuxj9IOAASKwmaBheeXoTQCsXlmBfK4shrzoAlfR+4LuE0jvR5lohcPH
         loRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P8FUTcAkSzX0gwG+BzSomHVjTY5h0EVdky25ut42j9c=;
        b=cgEgq0BGnrUqQBVUCQBKuzUHCEmQ9Xpvylvo6yZjOAKwxjeJJJG22s7NipmcMuxNyk
         O5LkeiqOxh4bhVM6uFgE9AIb1HyfPY/wEB2pwy46OkttY0D5RqJ/XArZCcOKjx+36fNd
         9M7oCZZEHiaGZuhNyhZBYrk8psuzh+ockQLfSyqkYNEjmqmkjrI6PsojsQwH6d/uRcSd
         H+ffe6PCbwIZk44us/4xF3EER73o5vFrfPq/QTLYszNGXbKwc99Obbn1Nptr7XQ5K9dy
         mtYe4jvT4Jk2hpinUijXwfIH8GFxrXpOzt5uCZE765oxQ3LAIo4HPuciGRs21CTbkRX/
         DohA==
X-Gm-Message-State: AOAM533FGZW/SAvem4v+jwitbY1AmqKMplO1pIpVlZtC77T4UID5CuFZ
        3ms17qdYT0kfBIOIsF1BB3gi
X-Google-Smtp-Source: ABdhPJx28n81y4GQXHaLcgVSaLHHQdziZMuoyZRDNvybtmWzQA1XQp9SLuYeKO8XqsrOrEa+MYoJNA==
X-Received: by 2002:a17:90a:ab96:: with SMTP id n22mr16462084pjq.52.1597754928522;
        Tue, 18 Aug 2020 05:48:48 -0700 (PDT)
Received: from localhost.localdomain ([116.68.79.111])
        by smtp.gmail.com with ESMTPSA id e4sm24264221pfd.204.2020.08.18.05.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 05:48:48 -0700 (PDT)
From:   Vaishnav M A <vaishnav@beagleboard.org>
To:     greybus-dev@lists.linaro.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, arnd@arndb.de, johan@kernel.org,
        elder@kernel.org
Cc:     Vaishnav M A <vaishnav@beagleboard.org>, robh@kernel.org,
        mchehab+huawei@kernel.org, davem@davemloft.net,
        jkridner@beagleboard.org, drew@beagleboard.org,
        robertcnelson@beagleboard.org, rajkovic@mikroe.com,
        chrisfriedt@gmail.com, zoran.stojsavljevic@gmail.com
Subject: [RFC PATCH v2 2/3] mikroBUS driver for add-on boards on mikrobus ports
Date:   Tue, 18 Aug 2020 18:18:14 +0530
Message-Id: <20200818124815.11029-3-vaishnav@beagleboard.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200818124815.11029-1-vaishnav@beagleboard.org>
References: <20200818124815.11029-1-vaishnav@beagleboard.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mikrobus driver is updated to add mikrobus ports from device-tree
overlays, the debug interfaces for adding mikrobus ports through sysFS
is removed, and the driver considers the extended usage of mikrobus
port pins from their standard purpose, for example an SHT15 add-on
board will need the I2C pins to be configured as GPIOs for the
corresponding driver(drivers/hwmon/sht15.c) to work correctly
to consider cases like these the mikrobus driver supports setting
the pinmux states and can consider each Pin of the mikrobus port
as GPIO if required.

 The manifests for supported 110 add-on boards are available here:
 https://github.com/vaishnav98/manifesto/tree/mikrobusv3

Signed-off-by: Vaishnav M A <vaishnav@beagleboard.org>
---
 MAINTAINERS                               |   6 +
 drivers/misc/Kconfig                      |   1 +
 drivers/misc/Makefile                     |   1 +
 drivers/misc/mikrobus/Kconfig             |  16 +
 drivers/misc/mikrobus/Makefile            |   7 +
 drivers/misc/mikrobus/mikrobus_core.c     | 692 ++++++++++++++++++++++
 drivers/misc/mikrobus/mikrobus_core.h     | 191 ++++++
 drivers/misc/mikrobus/mikrobus_manifest.c | 444 ++++++++++++++
 drivers/misc/mikrobus/mikrobus_manifest.h |  21 +
 drivers/misc/mikrobus/mikrobus_port.c     | 171 ++++++
 10 files changed, 1550 insertions(+)
 create mode 100644 drivers/misc/mikrobus/Kconfig
 create mode 100644 drivers/misc/mikrobus/Makefile
 create mode 100644 drivers/misc/mikrobus/mikrobus_core.c
 create mode 100644 drivers/misc/mikrobus/mikrobus_core.h
 create mode 100644 drivers/misc/mikrobus/mikrobus_manifest.c
 create mode 100644 drivers/misc/mikrobus/mikrobus_manifest.h
 create mode 100644 drivers/misc/mikrobus/mikrobus_port.c

diff --git a/MAINTAINERS b/MAINTAINERS
index deaafb617361..ffd0eb688618 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11543,6 +11543,12 @@ M:	Oliver Neukum <oliver@neukum.org>
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
index ce136d685d14..cb1539f39b30 100644
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
index 000000000000..5f42bc4e9410
--- /dev/null
+++ b/drivers/misc/mikrobus/Kconfig
@@ -0,0 +1,16 @@
+menuconfig MIKROBUS
+	tristate "Module for instantiating devices on mikroBUS ports"
+	help
+	  This option enables the mikroBUS driver. mikroBUS is an add-on
+	  board socket standard that offers maximum expandability with
+	  the smallest number of pins. The mikroBUS driver instantiates
+	  devices on a mikroBUS port described by identifying data present
+	  in an add-on board resident EEPROM, more details on the mikroBUS
+	  driver support and discussion can be found in this eLinux wiki :
+	  elinux.org/Mikrobus
+
+
+	  Say Y here to enable support for this driver.
+
+	  To compile this code as a module, chose M here: the module
+	  will be called mikrobus.ko
diff --git a/drivers/misc/mikrobus/Makefile b/drivers/misc/mikrobus/Makefile
new file mode 100644
index 000000000000..af7256510310
--- /dev/null
+++ b/drivers/misc/mikrobus/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0
+# mikroBUS Core
+
+mikrobus-y :=	mikrobus_core.o	mikrobus_manifest.o
+mikrobus_port-y :=	mikrobus_port.o
+obj-$(CONFIG_MIKROBUS) += mikrobus.o
+obj-$(CONFIG_MIKROBUS) += mikrobus_port.o
\ No newline at end of file
diff --git a/drivers/misc/mikrobus/mikrobus_core.c b/drivers/misc/mikrobus/mikrobus_core.c
new file mode 100644
index 000000000000..312e2d0d634c
--- /dev/null
+++ b/drivers/misc/mikrobus/mikrobus_core.c
@@ -0,0 +1,692 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * mikroBUS driver for instantiating add-on
+ * board devices with an identifier EEPROM
+ *
+ * Copyright 2020 Vaishnav M A, BeagleBoard.org Foundation.
+ */
+
+#define pr_fmt(fmt) "mikrobus:%s: " fmt, __func__
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
+#include <linux/i2c.h>
+#include <linux/gpio.h>
+#include <linux/gpio/machine.h>
+#include <linux/nvmem-consumer.h>
+#include <linux/nvmem-provider.h>
+#include <linux/interrupt.h>
+#include <linux/spi/spi.h>
+#include <linux/serdev.h>
+#include <linux/property.h>
+#include <linux/platform_device.h>
+#include <linux/pinctrl/pinctrl.h>
+#include <linux/pinctrl/pinmux.h>
+#include <linux/pinctrl/consumer.h>
+#include <linux/greybus/greybus_manifest.h>
+
+#include "mikrobus_core.h"
+#include "mikrobus_manifest.h"
+
+static DEFINE_MUTEX(core_lock);
+static DEFINE_IDR(mikrobus_port_idr);
+static struct class_compat *mikrobus_port_compat_class;
+int	__mikrobus_first_dynamic_bus_num;
+static bool is_registered;
+
+const char *MIKROBUS_PINCTRL_STR[] = {"pwm", "uart", "i2c", "spi"};
+
+struct bus_type mikrobus_bus_type = {
+	.name = "mikrobus",
+};
+EXPORT_SYMBOL_GPL(mikrobus_bus_type);
+
+static int mikrobus_port_scan_eeprom(struct mikrobus_port *port)
+{
+	struct addon_board_info *board;
+	int manifest_size;
+	char header[12];
+	int retval;
+	char *buf;
+
+	retval = nvmem_device_read(port->eeprom, 0, 12, header);
+	if (retval != 12) {
+		dev_err(&port->dev, "failed to fetch manifest header %d\n",
+			retval);
+		return -EINVAL;
+	}
+	manifest_size = mikrobus_manifest_header_validate(header, 12);
+	if (manifest_size < 0) {
+		dev_err(&port->dev, "invalid manifest size %d\n",
+			manifest_size);
+		return -EINVAL;
+	}
+	buf = kzalloc(manifest_size, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+	retval = nvmem_device_read(port->eeprom, 0, manifest_size, buf);
+	if (retval != manifest_size) {
+		dev_err(&port->dev, "failed to fetch manifest %d\n", retval);
+		retval = -EINVAL;
+		goto err_free_buf;
+	}
+	board = kzalloc(sizeof(*board), GFP_KERNEL);
+	if (!board) {
+		retval = -ENOMEM;
+		goto err_free_buf;
+	}
+	INIT_LIST_HEAD(&board->manifest_descs);
+	INIT_LIST_HEAD(&board->devices);
+	retval = mikrobus_manifest_parse(board, buf, manifest_size);
+	if (retval) {
+		dev_err(&port->dev, "failed to parse manifest, size %d\n",
+			manifest_size);
+		goto err_free_board;
+	}
+	retval = mikrobus_board_register(port, board);
+	if (retval) {
+		dev_err(&port->dev, "failed to register board %s\n",
+			board->name);
+		goto err_free_board;
+	}
+	kfree(buf);
+	return 0;
+err_free_board:
+	kfree(board);
+err_free_buf:
+	kfree(buf);
+	return retval;
+}
+
+static ssize_t name_show(struct device *dev, struct device_attribute *attr,
+			 char *buf)
+{
+	return sprintf(buf, "%s\n", to_mikrobus_port(dev)->name);
+}
+static DEVICE_ATTR_RO(name);
+
+static ssize_t new_device_store(struct device *dev, struct device_attribute *attr,
+				const char *buf, size_t count)
+{
+	struct mikrobus_port *port = to_mikrobus_port(dev);
+	struct addon_board_info *board;
+	int retval;
+
+	if (port->board) {
+		dev_err(dev, "already has board registered\n");
+		return -EBUSY;
+	}
+
+	board = kzalloc(sizeof(*board), GFP_KERNEL);
+	if (!board)
+		return -ENOMEM;
+	INIT_LIST_HEAD(&board->manifest_descs);
+	INIT_LIST_HEAD(&board->devices);
+	retval = mikrobus_manifest_parse(board, (void *)buf, count);
+	if (retval) {
+		dev_err(dev, "failed to parse manifest\n");
+		goto err_free_board;
+	}
+	retval = mikrobus_board_register(port, board);
+	if (retval) {
+		dev_err(dev, "failed to register board %s\n", board->name);
+		goto err_free_board;
+	}
+	return count;
+err_free_board:
+	kfree(board);
+	return retval;
+}
+static DEVICE_ATTR_WO(new_device);
+
+static ssize_t rescan_store(struct device *dev, struct device_attribute *attr,
+			    const char *buf, size_t count)
+{
+	struct mikrobus_port *port = to_mikrobus_port(dev);
+	unsigned long id;
+	int retval;
+
+	if (kstrtoul(buf, 0, &id)) {
+		dev_err(dev, "cannot parse trigger\n");
+		return -EINVAL;
+	}
+	if (port->board) {
+		dev_err(dev, "already has board registered\n");
+		return -EBUSY;
+	}
+	retval = mikrobus_port_scan_eeprom(port);
+	if (retval) {
+		dev_err(dev, "board register from manifest failed\n");
+		return -EINVAL;
+	}
+	return count;
+}
+static DEVICE_ATTR_WO(rescan);
+
+static ssize_t delete_device_store(struct device *dev, struct device_attribute *attr,
+				   const char *buf, size_t count)
+{
+	struct mikrobus_port *port = to_mikrobus_port(dev);
+	unsigned long id;
+
+	if (kstrtoul(buf, 0, &id)) {
+		dev_err(dev, "cannot parse board id");
+		return -EINVAL;
+	}
+	if (!port->board) {
+		dev_err(dev, "does not have registered boards");
+		return -ENODEV;
+	}
+	mikrobus_board_unregister(port, port->board);
+	return count;
+}
+static DEVICE_ATTR_IGNORE_LOCKDEP(delete_device, 0200, NULL, delete_device_store);
+
+static struct attribute *mikrobus_port_attrs[] = {
+	&dev_attr_new_device.attr, &dev_attr_rescan.attr,
+	&dev_attr_delete_device.attr, &dev_attr_name.attr, NULL};
+ATTRIBUTE_GROUPS(mikrobus_port);
+
+static void mikrobus_port_release(struct device *dev)
+{
+	struct mikrobus_port *port = to_mikrobus_port(dev);
+
+	mutex_lock(&core_lock);
+	idr_remove(&mikrobus_port_idr, port->id);
+	mutex_unlock(&core_lock);
+	kfree(port);
+}
+
+struct device_type mikrobus_port_type = {
+	.groups = mikrobus_port_groups,
+	.release = mikrobus_port_release,
+};
+EXPORT_SYMBOL_GPL(mikrobus_port_type);
+
+int mikrobus_port_pinctrl_select(struct mikrobus_port *port)
+{
+	struct pinctrl_state *state;
+	int retval;
+	int i;
+
+	for (i = 0; i < MIKROBUS_NUM_PINCTRL_STATE; i++) {
+		state = pinctrl_lookup_state(port->pinctrl,
+					     port->pinctrl_selected[i]);
+		if (!IS_ERR(state)) {
+			retval = pinctrl_select_state(port->pinctrl, state);
+			pr_info("setting pinctrl %s\n",
+				port->pinctrl_selected[i]);
+			if (retval != 0) {
+				dev_err(&port->dev, "failed to select state %s\n",
+					port->pinctrl_selected[i]);
+				return retval;
+			}
+		} else {
+			dev_err(&port->dev, "failed to find state %s\n",
+				port->pinctrl_selected[i]);
+			return PTR_ERR(state);
+		}
+	}
+
+	return retval;
+}
+EXPORT_SYMBOL_GPL(mikrobus_port_pinctrl_select);
+
+static int mikrobus_port_pinctrl_setup(struct mikrobus_port *port, struct addon_board_info *board)
+{
+	int retval;
+	int i;
+
+	for (i = 0; i < MIKROBUS_NUM_PINCTRL_STATE; i++) {
+		switch (i) {
+		case MIKROBUS_PINCTRL_PWM:
+			if (board->pin_state[MIKROBUS_PIN_PWM] == MIKROBUS_STATE_PWM)
+				sprintf(port->pinctrl_selected[i], "%s_%s",
+					MIKROBUS_PINCTRL_STR[i], PINCTRL_STATE_DEFAULT);
+			else
+				sprintf(port->pinctrl_selected[i], "%s_%s",
+					MIKROBUS_PINCTRL_STR[i], MIKROBUS_PINCTRL_STATE_GPIO);
+			break;
+		case MIKROBUS_PINCTRL_UART:
+			if (board->pin_state[MIKROBUS_PIN_RX] == MIKROBUS_STATE_UART)
+				sprintf(port->pinctrl_selected[i], "%s_%s",
+					MIKROBUS_PINCTRL_STR[i], PINCTRL_STATE_DEFAULT);
+			else
+				sprintf(port->pinctrl_selected[i], "%s_%s",
+					MIKROBUS_PINCTRL_STR[i], MIKROBUS_PINCTRL_STATE_GPIO);
+			break;
+		case MIKROBUS_PINCTRL_I2C:
+			if (board->pin_state[MIKROBUS_PIN_SCL] == MIKROBUS_STATE_I2C)
+				sprintf(port->pinctrl_selected[i], "%s_%s",
+					MIKROBUS_PINCTRL_STR[i], PINCTRL_STATE_DEFAULT);
+			else
+				sprintf(port->pinctrl_selected[i], "%s_%s",
+					MIKROBUS_PINCTRL_STR[i], MIKROBUS_PINCTRL_STATE_GPIO);
+			break;
+		case MIKROBUS_PINCTRL_SPI:
+			if (board->pin_state[MIKROBUS_PIN_MOSI] == MIKROBUS_STATE_SPI)
+				sprintf(port->pinctrl_selected[i], "%s_%s",
+					MIKROBUS_PINCTRL_STR[i], PINCTRL_STATE_DEFAULT);
+			else
+				sprintf(port->pinctrl_selected[i], "%s_%s",
+					MIKROBUS_PINCTRL_STR[i], MIKROBUS_PINCTRL_STATE_GPIO);
+			break;
+		}
+	}
+
+	retval = mikrobus_port_pinctrl_select(port);
+	if (retval)
+		dev_err(&port->dev, "failed to select pinctrl states [%d]", retval);
+	return retval;
+}
+
+static int mikrobus_irq_get(struct mikrobus_port *port, int irqno,
+			    int irq_type)
+{
+	int irq;
+
+	if (irqno > port->gpios->ndescs - 1) {
+		dev_err(&port->dev, "GPIO %d does not exist", irqno);
+		return -ENODEV;
+	}
+
+	irq = gpiod_to_irq(port->gpios->desc[irqno]);
+	if (irq < 0) {
+		dev_err(&port->dev, "could not get irq %d", irqno);
+		return -EINVAL;
+	}
+	irq_set_irq_type(irq, irq_type);
+	return irq;
+}
+
+static int mikrobus_gpio_setup(struct gpio_desc *gpio, int gpio_state)
+{
+	int retval;
+
+	switch (gpio_state) {
+	case MIKROBUS_STATE_INPUT:
+		retval = gpiod_direction_input(gpio);
+		break;
+	case MIKROBUS_STATE_OUTPUT_HIGH:
+		retval = gpiod_direction_output(gpio, 1);
+		break;
+	case MIKROBUS_STATE_OUTPUT_LOW:
+		retval = gpiod_direction_output(gpio, 0);
+		break;
+	case MIKROBUS_STATE_PWM:
+	case MIKROBUS_STATE_SPI:
+	case MIKROBUS_STATE_I2C:
+	default:
+		return 0;
+	}
+	return retval;
+}
+
+static char *mikrobus_gpio_chip_name_get(struct mikrobus_port *port, int gpio)
+{
+	char *name;
+	struct gpio_chip *gpiochip;
+
+	if (gpio > port->gpios->ndescs - 1)
+		return NULL;
+
+	gpiochip = gpiod_to_chip(port->gpios->desc[gpio]);
+	name = kmemdup(gpiochip->label, MIKROBUS_NAME_SIZE, GFP_KERNEL);
+	return name;
+}
+
+static int mikrobus_gpio_hwnum_get(struct mikrobus_port *port, int gpio)
+{
+	int hwnum;
+	struct gpio_chip *gpiochip;
+
+	if (gpio > port->gpios->ndescs - 1)
+		return -ENODEV;
+
+	gpiochip = gpiod_to_chip(port->gpios->desc[gpio]);
+	hwnum = desc_to_gpio(port->gpios->desc[gpio]) - gpiochip->base;
+	return hwnum;
+}
+
+static void mikrobus_board_device_release_all(struct addon_board_info *info)
+{
+	struct board_device_info *dev;
+	struct board_device_info *next;
+
+	list_for_each_entry_safe(dev, next, &info->devices, links) {
+		list_del(&dev->links);
+		kfree(dev);
+	}
+}
+
+static int mikrobus_device_register(struct mikrobus_port *port,
+				    struct board_device_info *dev, char *board_name)
+{
+	struct i2c_board_info *i2c;
+	struct spi_board_info *spi;
+	struct platform_device *pdev;
+	struct gpiod_lookup_table *lookup;
+	char devname[MIKROBUS_NAME_SIZE];
+	int i;
+
+	dev_info(&port->dev, "registering device : %s", dev->drv_name);
+
+	if (dev->gpio_lookup) {
+		lookup = dev->gpio_lookup;
+		if (dev->protocol == GREYBUS_PROTOCOL_SPI) {
+			snprintf(devname, sizeof(devname), "%s.%u",
+				 dev_name(&port->spi_mstr->dev),
+				port->chip_select[dev->reg]);
+			lookup->dev_id = kmemdup(devname, MIKROBUS_NAME_SIZE, GFP_KERNEL);
+		} else if (dev->protocol == GREYBUS_PROTOCOL_RAW) {
+			snprintf(devname, sizeof(devname), "%s.%u",
+				 dev->drv_name, dev->reg);
+			lookup->dev_id = kmemdup(devname, MIKROBUS_NAME_SIZE, GFP_KERNEL);
+		} else {
+			lookup->dev_id = dev->drv_name;
+		}
+		dev_info(&port->dev, " adding lookup table : %s\n",
+			 lookup->dev_id);
+		for (i = 0; i < dev->num_gpio_resources; i++) {
+			lookup->table[i].key =
+			mikrobus_gpio_chip_name_get(port,
+						    lookup->table[i].chip_hwnum);
+			lookup->table[i].chip_hwnum =
+			mikrobus_gpio_hwnum_get(port,
+						lookup->table[i].chip_hwnum);
+			lookup->table[i].flags = GPIO_ACTIVE_HIGH;
+		}
+		gpiod_add_lookup_table(lookup);
+	}
+	switch (dev->protocol) {
+	case GREYBUS_PROTOCOL_SPI:
+		spi = kzalloc(sizeof(*spi), GFP_KERNEL);
+		if (!spi)
+			return -ENOMEM;
+		strncpy(spi->modalias, dev->drv_name, sizeof(spi->modalias) - 1);
+		if (dev->irq)
+			spi->irq = mikrobus_irq_get(port, dev->irq, dev->irq_type);
+		if (dev->properties)
+			spi->properties = dev->properties;
+		spi->chip_select = port->chip_select[dev->reg];
+		spi->max_speed_hz = dev->max_speed_hz;
+		spi->mode = dev->mode;
+		dev->dev_client = (void *)spi_new_device(port->spi_mstr, spi);
+		break;
+	case GREYBUS_PROTOCOL_I2C:
+		i2c = kzalloc(sizeof(*i2c), GFP_KERNEL);
+		if (!i2c)
+			return -ENOMEM;
+		strncpy(i2c->type, dev->drv_name, sizeof(i2c->type) - 1);
+		if (dev->irq)
+			i2c->irq = mikrobus_irq_get(port, dev->irq, dev->irq_type);
+		if (dev->properties)
+			i2c->properties = dev->properties;
+		i2c->addr = dev->reg;
+		dev->dev_client = (void *)i2c_new_client_device(port->i2c_adap, i2c);
+		break;
+	case GREYBUS_PROTOCOL_RAW:
+		pdev = platform_device_alloc(dev->drv_name, 0);
+		if (!pdev)
+			return -ENOMEM;
+		if (dev->properties)
+			platform_device_add_properties(pdev, dev->properties);
+		dev->dev_client = pdev;
+		platform_device_add(dev->dev_client);
+		break;
+	case GREYBUS_PROTOCOL_UART:
+		dev_info(&port->dev, "serdev devices support not yet added");
+	break;
+	default:
+	return -EINVAL;
+	}
+	return 0;
+}
+
+static void mikrobus_device_unregister(struct mikrobus_port *port,
+				       struct board_device_info *dev, char *board_name)
+{
+	dev_info(&port->dev, "removing device %s\n", dev->drv_name);
+	if (dev->gpio_lookup) {
+		gpiod_remove_lookup_table(dev->gpio_lookup);
+		kfree(dev->gpio_lookup);
+	}
+	kfree(dev->properties);
+	switch (dev->protocol) {
+	case GREYBUS_PROTOCOL_SPI:
+		spi_unregister_device((struct spi_device *)dev->dev_client);
+		break;
+	case GREYBUS_PROTOCOL_I2C:
+		i2c_unregister_device((struct i2c_client *)dev->dev_client);
+		break;
+	case GREYBUS_PROTOCOL_RAW:
+		platform_device_unregister((struct platform_device  *)dev->dev_client);
+		break;
+	case GREYBUS_PROTOCOL_UART:
+		dev_err(&port->dev, "serdev devices support not yet added");
+		break;
+	}
+}
+
+int mikrobus_board_register(struct mikrobus_port *port,	struct addon_board_info *board)
+{
+	struct board_device_info *devinfo;
+	struct board_device_info *next;
+	int retval;
+	int i;
+
+	if (WARN_ON(list_empty(&board->devices)))
+		return -ENODEV;
+	if (port->pinctrl) {
+		retval = mikrobus_port_pinctrl_setup(port, board);
+		if (retval)
+			dev_err(&port->dev, "failed to setup pinctrl state [%d]", retval);
+	}
+	if (port->gpios) {
+		for (i = 0; i < port->gpios->ndescs; i++) {
+			retval = mikrobus_gpio_setup(port->gpios->desc[i], board->pin_state[i]);
+			if (retval)
+				dev_err(&port->dev, "failed to setup gpio %d, state %d",
+					i, board->pin_state[i]);
+		}
+	}
+	list_for_each_entry_safe(devinfo, next, &board->devices, links)
+		mikrobus_device_register(port, devinfo, board->name);
+	port->board = board;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mikrobus_board_register);
+
+void mikrobus_board_unregister(struct mikrobus_port *port, struct addon_board_info *board)
+{
+	struct board_device_info *devinfo;
+	struct board_device_info *next;
+
+	if (WARN_ON(list_empty(&board->devices)))
+		return;
+	port->board = NULL;
+	list_for_each_entry_safe(devinfo, next, &board->devices, links)
+		mikrobus_device_unregister(port, devinfo, board->name);
+	mikrobus_board_device_release_all(board);
+	kfree(board);
+	port->board = NULL;
+}
+EXPORT_SYMBOL_GPL(mikrobus_board_unregister);
+
+/*
+ * temporary setup for Atmel AT24C32 I2C EEPROM on 0x57
+ * will be removed once the mikrobusv3 standard in finalized.
+ */
+static struct i2c_board_info mikrobus_eeprom_info = {
+	I2C_BOARD_INFO("24c32", 0x57),
+};
+
+static int mikrobus_port_eeprom_probe(struct mikrobus_port *port)
+{
+	struct i2c_client *eeprom_client;
+	struct nvmem_device *eeprom;
+	char dev_name[MIKROBUS_NAME_SIZE];
+
+	eeprom_client = i2c_new_client_device(port->i2c_adap, &mikrobus_eeprom_info);
+	if (!IS_ERR(eeprom_client)) {
+		pr_info(" mikrobus port %d default eeprom is probed at %02x\n", port->id,
+			eeprom_client->addr);
+		snprintf(dev_name, sizeof(dev_name), "%d-%04x0", port->i2c_adap->nr,
+			 eeprom_client->addr);
+		eeprom = nvmem_device_get(&eeprom_client->dev, dev_name);
+		if (IS_ERR(eeprom)) {
+			pr_err("mikrobus port %d eeprom nvmem device probe failed\n", port->id);
+			i2c_unregister_device(eeprom_client);
+			port->eeprom = NULL;
+			return 0;
+		}
+	} else {
+		pr_info("mikrobus port %d default eeprom probe failed\n", port->id);
+		return 0;
+	}
+	port->eeprom = eeprom;
+	port->eeprom_client = eeprom_client;
+	return 0;
+}
+
+int mikrobus_port_register(struct mikrobus_port *port)
+{
+	struct device *dev = &port->dev;
+	int retval;
+	int id;
+
+	if (WARN_ON(!is_registered))
+		return -EAGAIN;
+
+	if (dev->of_node) {
+		id = of_alias_get_id(dev->of_node, "mikrobus");
+		if (id >= 0) {
+			port->id = id;
+			mutex_lock(&core_lock);
+			id = idr_alloc(&mikrobus_port_idr, port, port->id, port->id + 1,
+				       GFP_KERNEL);
+			mutex_unlock(&core_lock);
+			if (WARN(id < 0, "couldn't get idr"))
+				return id == -ENOSPC ? -EBUSY : id;
+		}
+	} else {
+		mutex_lock(&core_lock);
+		id = idr_alloc(&mikrobus_port_idr, port, __mikrobus_first_dynamic_bus_num, 0,
+			       GFP_KERNEL);
+		mutex_unlock(&core_lock);
+		if (id < 0)
+			return id;
+		port->id = id;
+	}
+	port->dev.bus = &mikrobus_bus_type;
+	port->dev.type = &mikrobus_port_type;
+	strncpy(port->name, "mikrobus-port", sizeof(port->name) - 1);
+	dev_set_name(&port->dev, "mikrobus-%d", port->id);
+	pr_info("registering port mikrobus-%d ", port->id);
+	retval = device_register(&port->dev);
+	if (retval) {
+		pr_err("port '%d': can't register device (%d)", port->id, retval);
+		put_device(&port->dev);
+		return retval;
+	}
+	retval = class_compat_create_link(mikrobus_port_compat_class, &port->dev,
+					  port->dev.parent);
+	if (retval)
+		dev_warn(&port->dev, "failed to create compatibility class link\n");
+	if (!port->eeprom) {
+		dev_info(&port->dev, "mikrobus port %d eeprom empty probing default eeprom\n",
+			 port->id);
+		retval = mikrobus_port_eeprom_probe(port);
+	}
+	if (port->eeprom) {
+		retval = mikrobus_port_scan_eeprom(port);
+		if (retval) {
+			dev_warn(&port->dev, "failed to register board from manifest\n");
+			return 0;
+		}
+	}
+	return retval;
+}
+EXPORT_SYMBOL_GPL(mikrobus_port_register);
+
+void mikrobus_port_delete(struct mikrobus_port *port)
+{
+	struct mikrobus_port *found;
+
+	mutex_lock(&core_lock);
+	found = idr_find(&mikrobus_port_idr, port->id);
+	mutex_unlock(&core_lock);
+	if (found != port) {
+		pr_err("port [%s] not registered", port->name);
+		return;
+	}
+	if (port->board) {
+		dev_err(&port->dev, "attempting to delete port with registered boards, port [%s]\n",
+			port->name);
+		return;
+	}
+
+	if (port->eeprom) {
+		nvmem_device_put(port->eeprom);
+		i2c_unregister_device(port->eeprom_client);
+	}
+
+	class_compat_remove_link(mikrobus_port_compat_class, &port->dev,
+				 port->dev.parent);
+	device_unregister(&port->dev);
+	mutex_lock(&core_lock);
+	idr_remove(&mikrobus_port_idr, port->id);
+	mutex_unlock(&core_lock);
+	memset(&port->dev, 0, sizeof(port->dev));
+}
+EXPORT_SYMBOL_GPL(mikrobus_port_delete);
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
+	retval = of_alias_get_highest_id("mikrobus");
+	if (retval >= __mikrobus_first_dynamic_bus_num)
+		__mikrobus_first_dynamic_bus_num = retval + 1;
+
+	is_registered = true;
+	return 0;
+
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
index 000000000000..b5da4225bc6c
--- /dev/null
+++ b/drivers/misc/mikrobus/mikrobus_core.h
@@ -0,0 +1,191 @@
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
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/i2c.h>
+#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
+#include <linux/gpio/machine.h>
+#include <linux/spi/spi.h>
+#include <linux/serdev.h>
+#include <linux/property.h>
+#include <linux/pinctrl/pinctrl.h>
+#include <linux/pinctrl/pinmux.h>
+#include <linux/pinctrl/consumer.h>
+#include <linux/nvmem-consumer.h>
+#include <linux/nvmem-provider.h>
+
+#define MIKROBUS_VERSION_MAJOR 0x00
+#define MIKROBUS_VERSION_MINOR 0x03
+
+#define MIKROBUS_NAME_SIZE		40
+#define MIKROBUS_PINCTRL_NAME_SIZE	20
+
+#define MIKROBUS_NUM_PINCTRL_STATE	4
+#define MIKROBUS_NUM_CS			2
+
+#define MIKROBUS_PINCTRL_PWM		0
+#define MIKROBUS_PINCTRL_UART		1
+#define MIKROBUS_PINCTRL_I2C		2
+#define MIKROBUS_PINCTRL_SPI		3
+
+#define MIKROBUS_PINCTRL_STATE_GPIO	"gpio"
+
+extern struct bus_type mikrobus_bus_type;
+extern struct device_type mikrobus_port_type;
+extern const char *MIKROBUS_PINCTRL_STR[];
+
+enum mikrobus_property_type {
+	MIKROBUS_PROPERTY_TYPE_MIKROBUS = 0x00,
+	MIKROBUS_PROPERTY_TYPE_LINK	= 0x01,
+	MIKROBUS_PROPERTY_TYPE_GPIO	= 0x02,
+	MIKROBUS_PROPERTY_TYPE_U8	= 0x03,
+	MIKROBUS_PROPERTY_TYPE_U16	= 0x04,
+	MIKROBUS_PROPERTY_TYPE_U32	= 0x05,
+	MIKROBUS_PROPERTY_TYPE_U64	= 0x06,
+};
+
+enum mikrobus_pin {
+	MIKROBUS_PIN_PWM	= 0x00,
+	MIKROBUS_PIN_INT	= 0x01,
+	MIKROBUS_PIN_RX		= 0x02,
+	MIKROBUS_PIN_TX		= 0x03,
+	MIKROBUS_PIN_SCL	= 0x04,
+	MIKROBUS_PIN_SDA	= 0x05,
+	MIKROBUS_PIN_MOSI	= 0x06,
+	MIKROBUS_PIN_MISO	= 0x07,
+	MIKROBUS_PIN_SCK	= 0x08,
+	MIKROBUS_PIN_CS		= 0x09,
+	MIKROBUS_PIN_RST	= 0x0A,
+	MIKROBUS_PIN_AN		= 0x0B,
+	MIKROBUS_PORT_PIN_COUNT = 0x0C,
+};
+
+enum mikrobus_pin_state {
+	MIKROBUS_STATE_INPUT		= 0x01,
+	MIKROBUS_STATE_OUTPUT_HIGH	= 0x02,
+	MIKROBUS_STATE_OUTPUT_LOW	= 0x03,
+	MIKROBUS_STATE_PWM		= 0x04,
+	MIKROBUS_STATE_SPI		= 0x05,
+	MIKROBUS_STATE_I2C		= 0x06,
+	MIKROBUS_STATE_UART		= 0x07,
+};
+
+/*
+ * board_device_info describes a single device on a mikrobus add-on
+ * board, an add-on board can present one or more device to the host
+ *
+ * @gpio_lookup: used to provide the GPIO lookup table for
+ * passing the named GPIOs to device drivers.
+ * @properties: used to provide the property_entry to pass named
+ * properties to device drivers, applicable only when driver uses
+ * device_property_read_* calls to fetch the properties.
+ * @num_gpio_resources: number of named gpio resources for the device,
+ * used mainly for gpiod_lookup_table memory allocation.
+ * @num_properties: number of custom properties for the device,
+ * used mainly for property_entry memory allocation.
+ * @protocol: used to know the type of the device and it should
+ * contain one of the values defined under 'enum greybus_class_type'
+ * under linux/greybus/greybus_manifest.h
+ * @reg: I2C address for the device, for devices on the SPI bus
+ * this field is the chip select address relative to the mikrobus
+ * port:0->device chip select connected to CS pin on mikroBUS port
+ *	1->device chip select connected to RST Pin on mikroBUS port
+ * @mode: SPI mode
+ * @max_speed_hz: SPI max speed(Hz)
+ * @drv_name: device_id to match with the driver
+ * @irq_type: type of IRQ trigger , match with defines in linux/interrupt.h
+ * @irq: irq number relative to the mikrobus port should contain one of the
+ * values defined under 'enum mikrobus_pin'
+ * @id: device id starting from 1
+ */
+struct board_device_info {
+	struct gpiod_lookup_table *gpio_lookup;
+	struct property_entry *properties;
+	struct list_head links;
+	unsigned short num_gpio_resources;
+	unsigned short num_properties;
+	unsigned short protocol;
+	unsigned short reg;
+	unsigned int mode;
+	void *dev_client;
+	u32 max_speed_hz;
+	char *drv_name;
+	int irq_type;
+	int irq;
+	int id;
+};
+
+/*
+ * addon_board_info describes a mikrobus add-on device the add-on
+ * board, an add-on board can present one or more device to the host
+ *
+ * @manifest_descs: list of manifest descriptors
+ * @devices: list of devices on the board
+ * @pin_state: the state of each pin on the mikrobus port required
+ * for the add-on board should contain one of the values defined under
+ * 'enum mikrobus_pin_state' restrictions are as per mikrobus standard
+ * specifications.
+ * @name: add-on board name
+ */
+struct addon_board_info {
+	struct list_head manifest_descs;
+	struct list_head devices;
+	u8 pin_state[MIKROBUS_PORT_PIN_COUNT];
+	char *name;
+};
+
+/*
+ * mikrobus_port describes the peripherals mapped to a
+ * mikrobus port.
+ *
+ * @eeprom_client: i2c_client corresponding to the eeprom
+ * on the add-on board.
+ * @board: pointer to the attached add-on board.
+ * @i2c_adap: I2C adapter attached to the mikrobus port.
+ * @spi_mstr: SPI master attached to the mikrobus port.
+ * @eeprom: nvmem_device for the eeprom on the add-on board.
+ * @pwm: pwm_device attached to the mikrobus port PWM pin.
+ * @pinctrl_selected: current pinctrl_selected state.
+ * @chip_select: chip select number mapped to the SPI
+ * CS pin on the mikrobus port and the RST pin on the mikrobus
+ * port
+ * @id: port id starting from 1
+ */
+struct mikrobus_port {
+	struct i2c_client *eeprom_client;
+	struct addon_board_info *board;
+	struct i2c_adapter *i2c_adap;
+	struct spi_master *spi_mstr;
+	struct nvmem_device *eeprom;
+	struct gpio_descs *gpios;
+	struct pwm_device *pwm;
+	struct pinctrl *pinctrl;
+	struct module *owner;
+	struct device dev;
+	char name[MIKROBUS_NAME_SIZE];
+	char *pinctrl_selected[MIKROBUS_NUM_PINCTRL_STATE];
+	unsigned int chip_select[MIKROBUS_NUM_CS];
+	int id;
+};
+
+#define to_mikrobus_port(d) container_of(d, struct mikrobus_port, dev)
+
+void mikrobus_board_unregister(struct mikrobus_port *port,
+			       struct addon_board_info *board);
+int mikrobus_board_register(struct mikrobus_port *port,
+			    struct addon_board_info *board);
+int mikrobus_port_register(struct mikrobus_port *port);
+int mikrobus_port_pinctrl_select(struct mikrobus_port *port);
+void mikrobus_port_delete(struct mikrobus_port *port);
+
+#endif /* __MIKROBUS_H */
diff --git a/drivers/misc/mikrobus/mikrobus_manifest.c b/drivers/misc/mikrobus/mikrobus_manifest.c
new file mode 100644
index 000000000000..952a68c6d8d1
--- /dev/null
+++ b/drivers/misc/mikrobus/mikrobus_manifest.c
@@ -0,0 +1,444 @@
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
+#define pr_fmt(fmt) "mikrobus_manifest:%s: " fmt, __func__
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
+static void manifest_descriptor_release_all(struct addon_board_info *board)
+{
+	struct manifest_desc *descriptor;
+	struct manifest_desc *next;
+
+	list_for_each_entry_safe(descriptor, next, &board->manifest_descs,
+				 links) {
+		list_del(&descriptor->links);
+		kfree(descriptor);
+	}
+}
+
+static int board_descriptor_add(struct addon_board_info *board,
+				struct greybus_descriptor *desc, size_t size)
+{
+	struct greybus_descriptor_header *desc_header = &desc->header;
+	struct manifest_desc *descriptor;
+	size_t desc_size;
+	size_t expected_size;
+
+	if (size < sizeof(*desc_header)) {
+		pr_err("short descriptor (%zu < %zu)", size,
+		       sizeof(*desc_header));
+		return -EINVAL;
+	}
+	desc_size = le16_to_cpu(desc_header->size);
+	if (desc_size > size) {
+		pr_err("incorrect descriptor size (%zu != %zu)", size,
+		       desc_size);
+		return -EINVAL;
+	}
+	expected_size = sizeof(*desc_header);
+	switch (desc_header->type) {
+	case GREYBUS_TYPE_STRING:
+		expected_size += sizeof(struct greybus_descriptor_string);
+		expected_size += desc->string.length;
+		expected_size = ALIGN(expected_size, 4);
+		break;
+	case GREYBUS_TYPE_PROPERTY:
+		expected_size += sizeof(struct greybus_descriptor_property);
+		expected_size += desc->property.length;
+		expected_size = ALIGN(expected_size, 4);
+		break;
+	case GREYBUS_TYPE_DEVICE:
+		expected_size += sizeof(struct greybus_descriptor_device);
+		break;
+	case GREYBUS_TYPE_MIKROBUS:
+		expected_size += sizeof(struct greybus_descriptor_mikrobus);
+		break;
+	case GREYBUS_TYPE_INTERFACE:
+		expected_size += sizeof(struct greybus_descriptor_interface);
+		break;
+	case GREYBUS_TYPE_CPORT:
+		expected_size += sizeof(struct greybus_descriptor_cport);
+		break;
+	case GREYBUS_TYPE_BUNDLE:
+		expected_size += sizeof(struct greybus_descriptor_bundle);
+		break;
+	case GREYBUS_TYPE_INVALID:
+	default:
+		pr_err("invalid descriptor type %d", desc_header->type);
+		return -EINVAL;
+	}
+
+	descriptor = kzalloc(sizeof(*descriptor), GFP_KERNEL);
+	if (!descriptor)
+		return -ENOMEM;
+	descriptor->size = desc_size;
+	descriptor->data = (char *)desc + sizeof(*desc_header);
+	descriptor->type = desc_header->type;
+	list_add_tail(&descriptor->links, &board->manifest_descs);
+	return desc_size;
+}
+
+static char *mikrobus_string_get(struct addon_board_info *board, u8 string_id)
+{
+	struct greybus_descriptor_string *desc_string;
+	struct manifest_desc *descriptor;
+	bool found = false;
+	char *string;
+
+	if (!string_id)
+		return NULL;
+
+	list_for_each_entry(descriptor, &board->manifest_descs, links) {
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
+	string = kmemdup(&desc_string->string, desc_string->length + 1,
+			 GFP_KERNEL);
+	if (!string)
+		return ERR_PTR(-ENOMEM);
+	string[desc_string->length] = '\0';
+	return string;
+}
+
+static void mikrobus_state_get(struct addon_board_info *board)
+{
+	struct greybus_descriptor_mikrobus *mikrobus;
+	struct greybus_descriptor_interface *interface;
+	struct manifest_desc *descriptor;
+	bool found = false;
+	int i;
+
+	list_for_each_entry(descriptor, &board->manifest_descs, links) {
+		if (descriptor->type == GREYBUS_TYPE_MIKROBUS) {
+			mikrobus = descriptor->data;
+			found = true;
+			break;
+		}
+	}
+	if (!found) {
+		pr_err("mikrobus descriptor not found");
+		return;
+	}
+	for (i = 0; i < MIKROBUS_PORT_PIN_COUNT; i++)
+		board->pin_state[i] =  mikrobus->pin_state[i];
+
+	found = false;
+	list_for_each_entry(descriptor, &board->manifest_descs, links) {
+		if (descriptor->type == GREYBUS_TYPE_INTERFACE) {
+			interface = descriptor->data;
+			found = true;
+			break;
+		}
+	}
+	if (!found) {
+		pr_err("interface descriptor not found");
+		return;
+	}
+	board->name = mikrobus_string_get(board, interface->product_stringid);
+}
+
+static struct property_entry *
+mikrobus_property_entry_get(struct addon_board_info *board, u8 *prop_link,
+			    int num_properties)
+{
+	struct greybus_descriptor_property *desc_property;
+	struct manifest_desc *descriptor;
+	struct property_entry *properties;
+	bool found = false;
+	char *prop_name;
+	u64 *val_u64;
+	u32 *val_u32;
+	u16 *val_u16;
+	u8 *val_u8;
+	int i;
+
+	properties = kcalloc(num_properties, sizeof(*properties), GFP_KERNEL);
+	if (!properties)
+		return ERR_PTR(-ENOMEM);
+	for (i = 0; i < num_properties; i++) {
+		list_for_each_entry(descriptor, &board->manifest_descs, links) {
+			if (descriptor->type != GREYBUS_TYPE_PROPERTY)
+				continue;
+			desc_property = descriptor->data;
+			if (desc_property->id == prop_link[i]) {
+				found = true;
+				break;
+			}
+		}
+		if (!found) {
+			kfree(properties);
+			return ERR_PTR(-ENOENT);
+		}
+		prop_name = mikrobus_string_get(board,
+						desc_property->propname_stringid);
+		if (!prop_name) {
+			kfree(properties);
+			return ERR_PTR(-ENOENT);
+		}
+		switch (desc_property->type) {
+		case MIKROBUS_PROPERTY_TYPE_U8:
+			val_u8 = kmemdup(&desc_property->value,
+					 (desc_property->length) * sizeof(u8), GFP_KERNEL);
+			if (desc_property->length == 1)
+				properties[i] = PROPERTY_ENTRY_U8(prop_name, *val_u8);
+			else
+				properties[i] = PROPERTY_ENTRY_U8_ARRAY_LEN(prop_name,
+					(void *)desc_property->value, desc_property->length);
+			break;
+		case MIKROBUS_PROPERTY_TYPE_U16:
+			val_u16 = kmemdup(&desc_property->value,
+					  (desc_property->length) * sizeof(u16), GFP_KERNEL);
+			if (desc_property->length == 1)
+				properties[i] = PROPERTY_ENTRY_U16(prop_name, *val_u16);
+			else
+				properties[i] = PROPERTY_ENTRY_U16_ARRAY_LEN(prop_name,
+					(void *)desc_property->value, desc_property->length);
+			break;
+		case MIKROBUS_PROPERTY_TYPE_U32:
+			val_u32 = kmemdup(&desc_property->value,
+					  (desc_property->length) * sizeof(u32), GFP_KERNEL);
+			if (desc_property->length == 1)
+				properties[i] = PROPERTY_ENTRY_U32(prop_name, *val_u32);
+			else
+				properties[i] = PROPERTY_ENTRY_U32_ARRAY_LEN(prop_name,
+					(void *)desc_property->value, desc_property->length);
+			break;
+		case MIKROBUS_PROPERTY_TYPE_U64:
+			val_u64 = kmemdup(&desc_property->value,
+					  (desc_property->length) * sizeof(u64), GFP_KERNEL);
+			if (desc_property->length == 1)
+				properties[i] = PROPERTY_ENTRY_U64(prop_name, *val_u64);
+			else
+				properties[i] = PROPERTY_ENTRY_U64_ARRAY_LEN(prop_name,
+					(void *)desc_property->value, desc_property->length);
+			break;
+		default:
+			kfree(properties);
+			return ERR_PTR(-EINVAL);
+		}
+	}
+	return properties;
+}
+
+static u8 *mikrobus_property_link_get(struct addon_board_info *board, u8 prop_id,
+				      struct board_device_info *board_dev,  u8 prop_type)
+{
+	struct greybus_descriptor_property *desc_property;
+	struct manifest_desc *descriptor;
+	bool found = false;
+	u8 *val_u8;
+
+	if (!prop_id)
+		return NULL;
+	list_for_each_entry(descriptor, &board->manifest_descs, links) {
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
+	if (prop_type == MIKROBUS_PROPERTY_TYPE_GPIO)
+		board_dev->num_gpio_resources = desc_property->length;
+	else if (prop_type == MIKROBUS_PROPERTY_TYPE_LINK)
+		board_dev->num_properties = desc_property->length;
+	return val_u8;
+}
+
+static int mikrobus_manifest_attach_device(struct addon_board_info *board,
+					   struct greybus_descriptor_device *dev_desc)
+{
+	struct board_device_info *board_dev;
+	struct gpiod_lookup_table *lookup;
+	struct greybus_descriptor_property *desc_property;
+	struct manifest_desc *descriptor;
+	u8 *gpio_desc_link;
+	u8 *prop_link;
+	int retval;
+	int i;
+
+	board_dev = kzalloc(sizeof(*board_dev), GFP_KERNEL);
+	if (!board_dev)
+		return -ENOMEM;
+	board_dev->id = dev_desc->id;
+	board_dev->drv_name = mikrobus_string_get(board, dev_desc->driver_stringid);
+	if (!board_dev->drv_name) {
+		retval = -ENOENT;
+		goto err_free_board_dev;
+	}
+	board_dev->protocol = dev_desc->protocol;
+	board_dev->reg = dev_desc->reg;
+	board_dev->irq = dev_desc->irq;
+	board_dev->irq_type = dev_desc->irq_type;
+	board_dev->max_speed_hz = le32_to_cpu(dev_desc->max_speed_hz);
+	board_dev->mode = dev_desc->mode;
+	pr_info("parsed device %d, driver=%s", board_dev->id, board_dev->drv_name);
+
+	if (dev_desc->prop_link > 0) {
+		prop_link = mikrobus_property_link_get(board, dev_desc->prop_link,
+						       board_dev, MIKROBUS_PROPERTY_TYPE_LINK);
+		if (!prop_link) {
+			retval = -ENOENT;
+			goto err_free_board_dev;
+		}
+		pr_info("device %d, number of properties=%d", board_dev->id,
+			board_dev->num_properties);
+		board_dev->properties = mikrobus_property_entry_get(board, prop_link,
+								    board_dev->num_properties);
+	}
+
+	if (dev_desc->gpio_link > 0) {
+		gpio_desc_link = mikrobus_property_link_get(board, dev_desc->gpio_link, board_dev,
+							    MIKROBUS_PROPERTY_TYPE_GPIO);
+		if (!gpio_desc_link) {
+			retval = -ENOENT;
+			goto err_free_board_dev;
+		}
+		pr_info("device %d, number of gpio resource=%d", board_dev->id,
+			board_dev->num_gpio_resources);
+		lookup = kzalloc(struct_size(lookup, table, board_dev->num_gpio_resources),
+				 GFP_KERNEL);
+		if (!lookup) {
+			retval = -ENOMEM;
+			goto err_free_board_dev;
+		}
+		for (i = 0; i < board_dev->num_gpio_resources; i++) {
+			list_for_each_entry(descriptor, &board->manifest_descs, links) {
+				if (descriptor->type != GREYBUS_TYPE_PROPERTY)
+					continue;
+				desc_property = descriptor->data;
+				if (desc_property->id == gpio_desc_link[i]) {
+					lookup->table[i].chip_hwnum = *desc_property->value;
+					lookup->table[i].con_id =
+					mikrobus_string_get(board,
+							    desc_property->propname_stringid);
+					break;
+				}
+			}
+		}
+		board_dev->gpio_lookup = lookup;
+	}
+	list_add_tail(&board_dev->links, &board->devices);
+	return 0;
+err_free_board_dev:
+	kfree(board_dev);
+	return retval;
+}
+
+static int mikrobus_manifest_parse_devices(struct addon_board_info *board)
+{
+	struct greybus_descriptor_device *desc_device;
+	struct manifest_desc *desc, *next;
+	int retval;
+	int devcount = 0;
+
+	list_for_each_entry_safe(desc, next, &board->manifest_descs, links) {
+		if (desc->type != GREYBUS_TYPE_DEVICE)
+			continue;
+		desc_device = desc->data;
+		retval = mikrobus_manifest_attach_device(board, desc_device);
+		devcount++;
+	}
+	return devcount;
+}
+
+int mikrobus_manifest_parse(struct addon_board_info *board, void *data,
+			    size_t size)
+{
+	struct greybus_manifest_header *header;
+	struct greybus_manifest *manifest;
+	struct greybus_descriptor *desc;
+	u16 manifest_size;
+	int dev_count;
+	int desc_size;
+
+	if (size < sizeof(*header)) {
+		pr_err("short manifest (%zu < %zu)", size, sizeof(*header));
+		return -EINVAL;
+	}
+
+	manifest = data;
+	header = &manifest->header;
+	manifest_size = le16_to_cpu(header->size);
+
+	if (manifest_size != size) {
+		pr_err("invalid manifest size(%zu < %zu)", size, manifest_size);
+		return -EINVAL;
+	}
+
+	if (header->version_major > MIKROBUS_VERSION_MAJOR) {
+		pr_err("manifest version too new (%u.%u > %u.%u)",
+		       header->version_major, header->version_minor,
+		       MIKROBUS_VERSION_MAJOR, MIKROBUS_VERSION_MINOR);
+		return -EINVAL;
+	}
+
+	desc = manifest->descriptors;
+	size -= sizeof(*header);
+	while (size) {
+		desc_size = board_descriptor_add(board, desc, size);
+		if (desc_size < 0) {
+			pr_err("invalid manifest descriptor, size: %zu", desc_size);
+			return -EINVAL;
+		}
+		desc = (void *)desc + desc_size;
+		size -= desc_size;
+	}
+	mikrobus_state_get(board);
+	dev_count = mikrobus_manifest_parse_devices(board);
+	pr_info(" %s manifest parsed with %d devices", board->name, dev_count);
+	manifest_descriptor_release_all(board);
+	return 0;
+}
+
+size_t mikrobus_manifest_header_validate(void *data, size_t size)
+{
+	struct greybus_manifest_header *header;
+	u16 manifest_size;
+
+	if (size < sizeof(*header)) {
+		pr_err("short manifest (%zu < %zu)", size, sizeof(*header));
+		return -EINVAL;
+	}
+	header = data;
+	manifest_size = le16_to_cpu(header->size);
+	if (header->version_major > MIKROBUS_VERSION_MAJOR) {
+		pr_err("manifest version too new (%u.%u > %u.%u)",
+		       header->version_major, header->version_minor,
+		       MIKROBUS_VERSION_MAJOR, MIKROBUS_VERSION_MINOR);
+		return -EINVAL;
+	}
+	return manifest_size;
+}
+
diff --git a/drivers/misc/mikrobus/mikrobus_manifest.h b/drivers/misc/mikrobus/mikrobus_manifest.h
new file mode 100644
index 000000000000..20cbc6465927
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
+int mikrobus_manifest_parse(struct addon_board_info *info, void *data,
+			    size_t size);
+size_t mikrobus_manifest_header_validate(void *data, size_t size);
+
+#endif /* __MIKROBUS_MANIFEST_H */
diff --git a/drivers/misc/mikrobus/mikrobus_port.c b/drivers/misc/mikrobus/mikrobus_port.c
new file mode 100644
index 000000000000..a5a1cbc04f30
--- /dev/null
+++ b/drivers/misc/mikrobus/mikrobus_port.c
@@ -0,0 +1,171 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * mikroBUS driver for adding mikrobus port from device tree
+ *
+ * Copyright 2020 Vaishnav M A, BeagleBoard.org Foundation.
+ */
+#define pr_fmt(fmt) "mikrobus_port:%s: " fmt, __func__
+
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <linux/jump_label.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/of_gpio.h>
+#include <linux/i2c.h>
+#include <linux/gpio.h>
+#include <linux/pwm.h>
+#include <linux/spi/spi.h>
+#include <linux/serdev.h>
+#include <linux/pinctrl/pinctrl.h>
+#include <linux/pinctrl/pinmux.h>
+#include <linux/pinctrl/consumer.h>
+
+#include "mikrobus_core.h"
+
+static int mikrobus_port_probe_pinctrl_setup(struct mikrobus_port *port)
+{
+	struct pinctrl_state *state;
+	struct device *dev = port->dev.parent;
+	int retval, i;
+
+	state = pinctrl_lookup_state(port->pinctrl, PINCTRL_STATE_DEFAULT);
+	if (!IS_ERR(state)) {
+		retval = pinctrl_select_state(port->pinctrl, state);
+		if (retval != 0) {
+			dev_err(dev, "Failed to select state %s\n",
+				PINCTRL_STATE_DEFAULT);
+			return retval;
+		}
+	} else {
+		dev_err(dev, "failed to find state %s\n",
+			PINCTRL_STATE_DEFAULT);
+		return PTR_ERR(state);
+	}
+
+	for (i = 0; i < MIKROBUS_NUM_PINCTRL_STATE; i++) {
+		port->pinctrl_selected[i] =
+				kmalloc(MIKROBUS_PINCTRL_NAME_SIZE, GFP_KERNEL);
+		sprintf(port->pinctrl_selected[i], "%s_%s",
+			MIKROBUS_PINCTRL_STR[i], PINCTRL_STATE_DEFAULT);
+	}
+
+	retval = mikrobus_port_pinctrl_select(port);
+	if (retval)
+		dev_err(dev, "failed to select pinctrl states [%d]", retval);
+	return retval;
+}
+
+static int mikrobus_port_probe(struct platform_device *pdev)
+{
+	struct mikrobus_port *port;
+	struct device *dev = &pdev->dev;
+	struct device_node *i2c_adap_np;
+	int retval;
+	u32 val;
+
+	port = kzalloc(sizeof(*port), GFP_KERNEL);
+	if (!port)
+		return -ENOMEM;
+
+	i2c_adap_np = of_parse_phandle(dev->of_node, "i2c-adapter", 0);
+	if (!i2c_adap_np) {
+		dev_err(dev, "cannot parse i2c-adapter\n");
+		retval = -ENODEV;
+		goto err_port;
+	}
+	port->i2c_adap = of_find_i2c_adapter_by_node(i2c_adap_np);
+	of_node_put(i2c_adap_np);
+	retval = device_property_read_u32(dev, "spi-master", &val);
+	if (retval) {
+		dev_err(dev, "failed to get spi-master [%d]\n", retval);
+		goto err_port;
+	}
+	port->spi_mstr = spi_busnum_to_master(val);
+	retval = device_property_read_u32_array(dev, "spi-cs",
+						port->chip_select, 2);
+	if (retval) {
+		dev_err(dev, "failed to get spi-cs [%d]\n", retval);
+		goto err_port;
+	}
+	port->gpios = gpiod_get_array(dev, "mikrobus", GPIOD_OUT_LOW);
+	if (IS_ERR(port->gpios)) {
+		retval = PTR_ERR(port->gpios);
+		dev_err(dev, "failed to get gpio array [%d]\n", retval);
+		goto err_port;
+	}
+	port->pinctrl = devm_pinctrl_get(dev);
+	if (IS_ERR(port->pinctrl)) {
+		retval = PTR_ERR(port->pinctrl);
+		dev_err(dev, "failed to get pinctrl [%d]\n", retval);
+		goto err_port;
+	}
+	port->dev.parent = dev;
+	port->dev.of_node = pdev->dev.of_node;
+
+	retval = mikrobus_port_probe_pinctrl_setup(port);
+	if (retval) {
+		dev_err(dev, "failed to setup pinctrl [%d]\n", retval);
+		goto err_port;
+	}
+
+	retval = mikrobus_port_register(port);
+	if (retval) {
+		pr_err("port : can't register port [%d]\n", retval);
+		goto err_port;
+	}
+	platform_set_drvdata(pdev, port);
+	return 0;
+err_port:
+	kfree(port);
+	return retval;
+}
+
+static int mikrobus_port_remove(struct platform_device *pdev)
+{
+	struct mikrobus_port	*port = platform_get_drvdata(pdev);
+
+	mikrobus_port_delete(port);
+	return 0;
+}
+
+static const struct of_device_id mikrobus_port_of_match[] = {
+	{.compatible = "linux,mikrobus"},
+	{},
+};
+MODULE_DEVICE_TABLE(of, mikrobus_port_of_match);
+
+static struct platform_driver mikrobus_port_driver = {
+	.probe = mikrobus_port_probe,
+	.remove = mikrobus_port_remove,
+	.driver = {
+		.name = "mikrobus",
+		.of_match_table = of_match_ptr(mikrobus_port_of_match),
+	},
+};
+
+static int __init
+mikrobus_port_init_driver(void)
+{
+	int retval;
+
+	retval = platform_driver_register(&mikrobus_port_driver);
+	if (retval)
+		pr_err("driver register failed [%d]\n", retval);
+	return retval;
+}
+subsys_initcall(mikrobus_port_init_driver);
+
+static void __exit mikrobus_port_exit_driver(void)
+{
+	platform_driver_unregister(&mikrobus_port_driver);
+}
+module_exit(mikrobus_port_exit_driver);
+
+MODULE_AUTHOR("Vaishnav M A <vaishnav@beagleboard.org>");
+MODULE_DESCRIPTION("mikroBUS port module");
+MODULE_LICENSE("GPL");
-- 
2.25.1

