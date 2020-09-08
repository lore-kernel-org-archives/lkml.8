Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A729C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 10:32:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EF42206DB
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 10:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599561157;
	bh=Dqu3cQfTKUnYxga/9YnhROybDDJIT/TI9B7PHD2uFFc=;
	h=From:Cc:Subject:Date:In-Reply-To:References:To:List-ID:From;
	b=XR0DDcXkp3SJyBbBo2YXUYNLkblC3P0T4Jsb0dDzidO440HdO7AUpDaaJ1CSVA5rF
	 RWJeolPTtT/wB+8b0ZCKW1GJBSp5MR5y25ZXz6mB199K1i/ydYl8r086DIZrxyNo8e
	 xesC1PV/0wROvTUWd6nBrKPlZAg2l0YNxu9+8agA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729455AbgIHKbx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 06:31:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:38678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729971AbgIHK3K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 06:29:10 -0400
Received: from mail.kernel.org (ip5f5ad5ce.dynamic.kabel-deutschland.de [95.90.213.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4365C21D7A;
        Tue,  8 Sep 2020 10:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599560940;
        bh=Dqu3cQfTKUnYxga/9YnhROybDDJIT/TI9B7PHD2uFFc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MwbVWCLZt5R15dbs2vl3ceuDMENyF6OuZpXFIZXFdLbGTcADO42eLHmCsG7lvSU9c
         D1ZRr/v+BnavnTjJY7SqaFSvAyzJVpE17s4+LyWoLYcuGKg+xm/0Ac85t9i5qvWuVs
         B2mzGY4zmsKnihfbcjqUy+sfw7eNvoCUfwUvaQAE=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kFary-00B3yR-9G; Tue, 08 Sep 2020 12:28:58 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Yu Chen <chenyu56@huawei.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 08/10] misc: hisi_hikey_usb: Driver to support onboard USB gpio hub on Hikey960
Date:   Tue,  8 Sep 2020 12:28:42 +0200
Message-Id: <e364435c446c07183a2b3107916bb2eca3e96410.1599559318.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1599559318.git.mchehab+huawei@kernel.org>
References: <cover.1599559318.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Chen <chenyu56@huawei.com>

The HiKey960 has a fairly complex USB configuration due to it
needing to support a USB-C port for host/device mode and multiple
USB-A ports in host mode, all using a single USB controller.

See schematics here:
  https://github.com/96boards/documentation/raw/master/consumer/hikey/hikey960/hardware-docs/HiKey960_Schematics.pdf

This driver acts as a usb-role-switch intermediary, intercepting
the role switch notifications from the tcpm code, and passing
them on to the dwc3 core.

In doing so, it also controls the onboard hub and power gpios in
order to properly route the data lines between the USB-C port
and the onboard hub to the USB-A ports.

Signed-off-by: Yu Chen <chenyu56@huawei.com>
[jstultz: Major rework to make the driver a usb-role-switch
          intermediary]
Signed-off-by: John Stultz <john.stultz@linaro.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 MAINTAINERS                   |   7 ++
 drivers/misc/Kconfig          |   9 ++
 drivers/misc/Makefile         |   1 +
 drivers/misc/hisi_hikey_usb.c | 205 ++++++++++++++++++++++++++++++++++
 4 files changed, 222 insertions(+)
 create mode 100644 drivers/misc/hisi_hikey_usb.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 267ba0b7a52e..5ea805543b86 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7781,6 +7781,13 @@ W:	http://www.hisilicon.com
 F:	Documentation/devicetree/bindings/net/hisilicon*.txt
 F:	drivers/net/ethernet/hisilicon/
 
+HIKEY960 ONBOARD USB GPIO HUB DRIVER
+M:	John Stultz <john.stultz@linaro.org>
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+F:	drivers/misc/hisi_hikey_usb.c
+F:	Documentation/devicetree/bindings/misc/hisilicon-hikey-usb.yaml
+
 HISILICON PMU DRIVER
 M:	Shaokun Zhang <zhangshaokun@hisilicon.com>
 S:	Supported
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index e1b1ba5e2b92..fb15364f32d2 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -456,6 +456,15 @@ config PVPANIC
 	  a paravirtualized device provided by QEMU; it lets a virtual machine
 	  (guest) communicate panic events to the host.
 
+config HISI_HIKEY_USB
+	tristate "USB GPIO Hub on HiSilicon Hikey960 Platform"
+	depends on (OF && GPIOLIB) || COMPILE_TEST
+	help
+	  If you say yes here this adds support for the on-board USB GPIO hub
+	  found on the HiKey960, which is necessary to support switching
+	  between the dual-role USB-C port and the USB-A host ports using only
+	  one USB controller.
+
 source "drivers/misc/c2port/Kconfig"
 source "drivers/misc/eeprom/Kconfig"
 source "drivers/misc/cb710/Kconfig"
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index c7bd01ac6291..2521359e8ef7 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -57,3 +57,4 @@ obj-$(CONFIG_PVPANIC)   	+= pvpanic.o
 obj-$(CONFIG_HABANA_AI)		+= habanalabs/
 obj-$(CONFIG_UACCE)		+= uacce/
 obj-$(CONFIG_XILINX_SDFEC)	+= xilinx_sdfec.o
+obj-$(CONFIG_HISI_HIKEY_USB)	+= hisi_hikey_usb.o
diff --git a/drivers/misc/hisi_hikey_usb.c b/drivers/misc/hisi_hikey_usb.c
new file mode 100644
index 000000000000..3a98a890757c
--- /dev/null
+++ b/drivers/misc/hisi_hikey_usb.c
@@ -0,0 +1,205 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Support for usb functionality of Hikey series boards
+ * based on Hisilicon Kirin Soc.
+ *
+ * Copyright (C) 2017-2018 Hilisicon Electronics Co., Ltd.
+ *		http://www.huawei.com
+ *
+ * Authors: Yu Chen <chenyu56@huawei.com>
+ */
+
+#include <linux/gpio/consumer.h>
+#include <linux/kernel.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/notifier.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
+#include <linux/slab.h>
+#include <linux/usb/role.h>
+
+#define DEVICE_DRIVER_NAME "hisi_hikey_usb"
+
+#define HUB_VBUS_POWER_ON 1
+#define HUB_VBUS_POWER_OFF 0
+#define USB_SWITCH_TO_HUB 1
+#define USB_SWITCH_TO_TYPEC 0
+#define TYPEC_VBUS_POWER_ON 1
+#define TYPEC_VBUS_POWER_OFF 0
+
+struct hisi_hikey_usb {
+	struct gpio_desc *otg_switch;
+	struct gpio_desc *typec_vbus;
+	struct gpio_desc *hub_vbus;
+
+	struct usb_role_switch *hub_role_sw;
+
+	struct usb_role_switch *dev_role_sw;
+	enum usb_role role;
+
+	struct mutex lock;
+	struct work_struct work;
+
+	struct notifier_block nb;
+};
+
+static void hub_power_ctrl(struct hisi_hikey_usb *hisi_hikey_usb, int value)
+{
+	gpiod_set_value_cansleep(hisi_hikey_usb->hub_vbus, value);
+}
+
+static void usb_switch_ctrl(struct hisi_hikey_usb *hisi_hikey_usb,
+			    int switch_to)
+{
+	gpiod_set_value_cansleep(hisi_hikey_usb->otg_switch, switch_to);
+}
+
+static void usb_typec_power_ctrl(struct hisi_hikey_usb *hisi_hikey_usb,
+				 int value)
+{
+	gpiod_set_value_cansleep(hisi_hikey_usb->typec_vbus, value);
+}
+
+
+
+static void relay_set_role_switch(struct work_struct *work)
+{
+	struct hisi_hikey_usb *hisi_hikey_usb = container_of(work,
+							struct hisi_hikey_usb,
+							work);
+	struct usb_role_switch *sw;
+	enum usb_role role;
+
+	if (!hisi_hikey_usb || !hisi_hikey_usb->dev_role_sw)
+		return;
+
+	mutex_lock(&hisi_hikey_usb->lock);
+	switch (hisi_hikey_usb->role) {
+	case USB_ROLE_NONE:
+		usb_typec_power_ctrl(hisi_hikey_usb, TYPEC_VBUS_POWER_OFF);
+		usb_switch_ctrl(hisi_hikey_usb, USB_SWITCH_TO_HUB);
+		hub_power_ctrl(hisi_hikey_usb, HUB_VBUS_POWER_ON);
+		break;
+	case USB_ROLE_HOST:
+		hub_power_ctrl(hisi_hikey_usb, HUB_VBUS_POWER_OFF);
+		usb_switch_ctrl(hisi_hikey_usb, USB_SWITCH_TO_TYPEC);
+		usb_typec_power_ctrl(hisi_hikey_usb, TYPEC_VBUS_POWER_ON);
+		break;
+	case USB_ROLE_DEVICE:
+		hub_power_ctrl(hisi_hikey_usb, HUB_VBUS_POWER_OFF);
+		usb_typec_power_ctrl(hisi_hikey_usb, TYPEC_VBUS_POWER_OFF);
+		usb_switch_ctrl(hisi_hikey_usb, USB_SWITCH_TO_TYPEC);
+		break;
+	default:
+		break;
+	}
+	sw = hisi_hikey_usb->dev_role_sw;
+	role = hisi_hikey_usb->role;
+	mutex_unlock(&hisi_hikey_usb->lock);
+
+	usb_role_switch_set_role(sw, role);
+}
+
+static int hub_usb_role_switch_set(struct usb_role_switch *sw, enum usb_role role)
+{
+	struct hisi_hikey_usb *hisi_hikey_usb = usb_role_switch_get_drvdata(sw);
+
+	if (!hisi_hikey_usb || !hisi_hikey_usb->dev_role_sw)
+		return -EINVAL;
+
+	mutex_lock(&hisi_hikey_usb->lock);
+	hisi_hikey_usb->role = role;
+	mutex_unlock(&hisi_hikey_usb->lock);
+
+	schedule_work(&hisi_hikey_usb->work);
+
+	return 0;
+}
+
+static int hisi_hikey_usb_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct hisi_hikey_usb *hisi_hikey_usb;
+	struct usb_role_switch_desc hub_role_switch = {NULL};
+
+	hisi_hikey_usb = devm_kzalloc(dev, sizeof(*hisi_hikey_usb), GFP_KERNEL);
+	if (!hisi_hikey_usb)
+		return -ENOMEM;
+
+	hisi_hikey_usb->typec_vbus = devm_gpiod_get(dev, "typec-vbus",
+						    GPIOD_OUT_LOW);
+	if (IS_ERR(hisi_hikey_usb->typec_vbus))
+		return PTR_ERR(hisi_hikey_usb->typec_vbus);
+
+	hisi_hikey_usb->otg_switch = devm_gpiod_get(dev, "otg-switch",
+						    GPIOD_OUT_HIGH);
+	if (IS_ERR(hisi_hikey_usb->otg_switch))
+		return PTR_ERR(hisi_hikey_usb->otg_switch);
+
+	/* hub-vdd33-en is optional */
+	hisi_hikey_usb->hub_vbus = devm_gpiod_get_optional(dev, "hub-vdd33-en",
+							   GPIOD_OUT_HIGH);
+	if (IS_ERR(hisi_hikey_usb->hub_vbus))
+		return PTR_ERR(hisi_hikey_usb->hub_vbus);
+
+	hisi_hikey_usb->dev_role_sw = usb_role_switch_get(dev);
+	if (!hisi_hikey_usb->dev_role_sw)
+		return -EPROBE_DEFER;
+	if (IS_ERR(hisi_hikey_usb->dev_role_sw))
+		return PTR_ERR(hisi_hikey_usb->dev_role_sw);
+
+
+	INIT_WORK(&hisi_hikey_usb->work, relay_set_role_switch);
+	mutex_init(&hisi_hikey_usb->lock);
+
+	hub_role_switch.fwnode = dev_fwnode(dev);
+	hub_role_switch.set = hub_usb_role_switch_set;
+	hub_role_switch.driver_data = hisi_hikey_usb;
+
+	hisi_hikey_usb->hub_role_sw = usb_role_switch_register(dev,
+							&hub_role_switch);
+
+	if (IS_ERR(hisi_hikey_usb->hub_role_sw)) {
+		usb_role_switch_put(hisi_hikey_usb->dev_role_sw);
+		return PTR_ERR(hisi_hikey_usb->hub_role_sw);
+	}
+
+	platform_set_drvdata(pdev, hisi_hikey_usb);
+
+	return 0;
+}
+
+static int  hisi_hikey_usb_remove(struct platform_device *pdev)
+{
+	struct hisi_hikey_usb *hisi_hikey_usb = platform_get_drvdata(pdev);
+
+	if (hisi_hikey_usb->hub_role_sw)
+		usb_role_switch_unregister(hisi_hikey_usb->hub_role_sw);
+
+	if (hisi_hikey_usb->dev_role_sw)
+		usb_role_switch_put(hisi_hikey_usb->dev_role_sw);
+
+	return 0;
+}
+
+static const struct of_device_id id_table_hisi_hikey_usb[] = {
+	{.compatible = "hisilicon,gpio_hubv1"},
+	{}
+};
+MODULE_DEVICE_TABLE(of, id_table_hisi_hikey_usb);
+
+static struct platform_driver hisi_hikey_usb_driver = {
+	.probe = hisi_hikey_usb_probe,
+	.remove = hisi_hikey_usb_remove,
+	.driver = {
+		.name = DEVICE_DRIVER_NAME,
+		.of_match_table = id_table_hisi_hikey_usb,
+	},
+};
+
+module_platform_driver(hisi_hikey_usb_driver);
+
+MODULE_AUTHOR("Yu Chen <chenyu56@huawei.com>");
+MODULE_DESCRIPTION("Driver Support for USB functionality of Hikey");
+MODULE_LICENSE("GPL v2");
-- 
2.26.2

