Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 289F3C433E6
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 19:13:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDE3F20781
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 19:13:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732715AbgGVTNi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 15:13:38 -0400
Received: from mailout08.rmx.de ([94.199.90.85]:57504 "EHLO mailout08.rmx.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728821AbgGVTNg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 15:13:36 -0400
Received: from kdin01.retarus.com (kdin01.dmz1.retloc [172.19.17.48])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mailout08.rmx.de (Postfix) with ESMTPS id 4BBknc153rzMnT5;
        Wed, 22 Jul 2020 20:41:24 +0200 (CEST)
Received: from mta.arri.de (unknown [217.111.95.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by kdin01.retarus.com (Postfix) with ESMTPS id 4BBkn32Wkqz2xCK;
        Wed, 22 Jul 2020 20:40:55 +0200 (CEST)
Received: from N95HX1G2.wgnetz.xx (192.168.54.68) by mta.arri.de
 (192.168.100.104) with Microsoft SMTP Server (TLS) id 14.3.408.0; Wed, 22 Jul
 2020 20:40:55 +0200
From:   Christian Eggers <ceggers@arri.de>
To:     <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Richard Leitner <richard.leitner@skidata.com>,
        <linux-kernel@vger.kernel.org>, Christian Eggers <ceggers@arri.de>
Subject: [PATCH 4/4] usb: misc: Add USB49xx/xi Hi-Speed Hub Controller Driver
Date:   Wed, 22 Jul 2020 20:38:59 +0200
Message-ID: <20200722183859.24470-5-ceggers@arri.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200722183859.24470-1-ceggers@arri.de>
References: <20200722183859.24470-1-ceggers@arri.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.54.68]
X-RMX-ID: 20200722-204055-4BBkn32Wkqz2xCK-0@kdin01
X-RMX-SOURCE: 217.111.95.66
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a driver for configuration of the Microchip USB49xx/xi
USB 2.0 hub controller series with USB 2.0 upstream connectivity, SMBus
configuration interface and two to four USB 2.0 downstream ports.

Furthermore add myself as a maintainer for this driver.

The datasheet can be found at the manufacturers website, see [1]. All
device-tree exposed configuration features have been tested on a i.MX6
platform with a USB4916 hub.

[1] http://ww1.microchip.com/downloads/en/Appnotes/AN2651-Configuration-of-Microchip-USB47xx-USB49xx-Application-Note-00002651B.pdf

Signed-off-by: Christian Eggers <ceggers@arri.de>
---
 MAINTAINERS                |   7 +
 drivers/usb/misc/Kconfig   |  10 +
 drivers/usb/misc/Makefile  |   1 +
 drivers/usb/misc/usb49xx.c | 825 +++++++++++++++++++++++++++++++++++++
 4 files changed, 843 insertions(+)
 create mode 100644 drivers/usb/misc/usb49xx.c

diff --git a/MAINTAINERS b/MAINTAINERS
index fe1108ba6ce7..068d6e94122b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11363,6 +11363,13 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/usb/usb253x.yaml
 F:	drivers/usb/misc/usb253x.c
 
+MICROCHIP USB49XX DRIVER
+M:	Christian Eggers <ceggers@arri.de>
+L:	linux-usb@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/usb/usb49xx.yaml
+F:	drivers/usb/misc/usb49xx.c
+
 MICROCHIP USBA UDC DRIVER
 M:	Cristian Birsan <cristian.birsan@microchip.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
diff --git a/drivers/usb/misc/Kconfig b/drivers/usb/misc/Kconfig
index 7a7b854e803a..14bea87c0f81 100644
--- a/drivers/usb/misc/Kconfig
+++ b/drivers/usb/misc/Kconfig
@@ -252,6 +252,16 @@ config USB_HUB_USB253X
 	  Configuration parameters may be set in devicetree or platform data.
 	  Say Y or M here if you need to configure such a device via I2C.
 
+config USB_HUB_USB49XX
+	tristate "USB47XX/USB49XX Hub Controller Configuration Driver"
+	depends on I2C
+	select REGMAP
+	help
+	  This option enables support for configuration via I2C bus of the
+	  Microchip USB47xx/49xx USB 2.0 Hub Controller series.
+	  Configuration parameters may be set in devicetree or platform data.
+	  Say Y or M here if you need to configure such a device via I2C.
+
 config USB_HSIC_USB3503
 	tristate "USB3503 HSIC to USB20 Driver"
 	depends on I2C
diff --git a/drivers/usb/misc/Makefile b/drivers/usb/misc/Makefile
index 6fd8c53841e4..3832858aba1e 100644
--- a/drivers/usb/misc/Makefile
+++ b/drivers/usb/misc/Makefile
@@ -26,6 +26,7 @@ obj-$(CONFIG_USB_SEVSEG)		+= usbsevseg.o
 obj-$(CONFIG_USB_YUREX)			+= yurex.o
 obj-$(CONFIG_USB_HUB_USB251XB)		+= usb251xb.o
 obj-$(CONFIG_USB_HUB_USB253X)		+= usb253x.o
+obj-$(CONFIG_USB_HUB_USB49XX)		+= usb49xx.o
 obj-$(CONFIG_USB_HSIC_USB3503)		+= usb3503.o
 obj-$(CONFIG_USB_HSIC_USB4604)		+= usb4604.o
 obj-$(CONFIG_USB_CHAOSKEY)		+= chaoskey.o
diff --git a/drivers/usb/misc/usb49xx.c b/drivers/usb/misc/usb49xx.c
new file mode 100644
index 000000000000..b713ef4557c2
--- /dev/null
+++ b/drivers/usb/misc/usb49xx.c
@@ -0,0 +1,825 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Driver for Microchip USB47xx and USB49xx USB 2.0 Hi-Speed Hub Controller
+ * Configuration via I2C.
+ *
+ * Copyright (c) 2020 ARRI Lighting
+ *
+ * This work is based on the USB251xb driver by Richard Leitner.
+ *
+ */
+
+#include <linux/delay.h>
+#include <linux/gpio/consumer.h>
+#include <linux/gpio/driver.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/nls.h>
+#include <linux/of_device.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <linux/slab.h>
+
+/* Internal Register Set Addresses acc. to DS00002651B */
+#define USB49XX_ADDR_VENDOR_ID                0xBF803000
+#define USB49XX_ADDR_PRODUCT_ID               0xBF803002
+#define USB49XX_ADDR_DEVICE_ID                0xBF803004
+#define USB49XX_ADDR_HUB_CFG                  0xBF803006
+#define USB49XX_HUB_CFG3_PRTMAP_EN            BIT(3)
+#define USB49XX_HUB_CFG3_STRING_EN            BIT(0)
+#define USB49XX_ADDR_NON_REMOVABLE_DEVICES    0xBF803009
+#define USB49XX_ADDR_PORT_DISABLE_SELF        0xBF80300A
+#define USB49XX_ADDR_PORT_DISABLE_BUS         0xBF80300B
+#define USB49XX_ADDR_POWER_ON_TIME            0xBF803010
+#define USB49XX_ADDR_OCS_MIN_WIDTH            0xBF8030EA
+#define USB49XX_ADDR_LANGUAGE_ID              0xBF803202
+#define USB49XX_STRING_BUFSIZE                62
+#define USB49XX_ADDR_MANUFACTURER_STRING_DESC 0xBFD23204
+#define USB49XX_ADDR_PRODUCT_STRING_DESC      0xBFD23244
+#define USB49XX_ADDR_MANUFACTURER_STRING_LEN  0xBFD2346A
+#define USB49XX_ADDR_PRODUCT_STRING_LEN       0xBFD23472
+#define USB49XX_ADDR_USB2_HUB_CTRL            0xBF803104
+#define USB49XX_USB2_HUB_CTRL_LPM_DISABLE     BIT(1)
+
+#define DRIVER_NAME "usb49xx"
+
+
+struct usb49xx {
+	struct device *dev;
+	struct i2c_client *i2c;
+	struct regulator *vdd;
+	struct regmap *regmap;
+	u8 skip_config;
+	struct gpio_desc *gpio_reset;
+};
+
+#ifdef CONFIG_GPIOLIB
+static int usb49xx_check_dev_children(struct device *dev, void *child)
+{
+	if (dev->type == &i2c_adapter_type) {
+		return device_for_each_child(dev, child,
+					     usb49xx_check_dev_children);
+	}
+
+	return (dev == child);
+}
+
+static int usb49xx_check_gpio_chip(struct usb49xx *hub)
+{
+	struct gpio_chip *gc = gpiod_to_chip(hub->gpio_reset);
+	struct i2c_adapter *adap = hub->i2c->adapter;
+	int ret;
+
+	if (!hub->gpio_reset)
+		return 0;
+
+	if (!gc)
+		return -EINVAL;
+
+	ret = usb49xx_check_dev_children(&adap->dev, gc->parent);
+	if (ret) {
+		dev_err(hub->dev, "Reset GPIO chip is at the same i2c-bus\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+#else
+static int usb49xx_check_gpio_chip(struct usb49xx *hub)
+{
+	return 0;
+}
+#endif
+
+static void usb49xx_reset(struct usb49xx *hub, int state)
+{
+	if (state) {
+		/* During rising edge of reset, there must be no traffic on the i2c bus */
+		i2c_lock_bus(hub->i2c->adapter, I2C_LOCK_SEGMENT);
+		gpiod_set_value_cansleep(hub->gpio_reset, 1);
+		/* Wait for i2c logic to come up (hub seems to require ~10 ms)*/
+		msleep(20);
+		i2c_unlock_bus(hub->i2c->adapter, I2C_LOCK_SEGMENT);
+	} else {
+		gpiod_set_value_cansleep(hub->gpio_reset, 0);
+		/* minimum reset pulse width is 5 us */
+		usleep_range(5, 10);
+	}
+}
+
+struct usb49xx_string_desc {
+	u8 length;   /* length of string in bytes + 2 */
+	u8 type;     /* always 0x03 */
+	wchar_t string[USB49XX_STRING_BUFSIZE/sizeof(wchar_t)];
+};
+
+static void usb49xx_get_ports_field(struct usb49xx *hub,
+				    const char *prop_name, u8 port_cnt,
+				    u8 *fld)
+{
+	struct device *dev = hub->dev;
+	struct property *prop;
+	const __be32 *p;
+	u32 port;
+
+	of_property_for_each_u32(dev->of_node, prop_name, prop, p, port) {
+		if ((port >= 1) && (port <= port_cnt))
+			*fld |= BIT(port);
+		else
+			dev_warn(dev, "port %u doesn't exist\n", port);
+	}
+}
+
+static int usb49xx_connect(struct usb49xx *hub)
+{
+	struct device *dev = hub->dev;
+	struct device_node *np = dev->of_node;
+	int err;
+	char attach_buffer[3];
+
+	usb49xx_reset(hub, 1);
+
+	if (hub->skip_config) {
+		dev_info(dev, "Skip hub configuration, only attach.\n");
+	} else {
+		u16 vendor_id, product_id, device_id, lang_id;
+		u8 hub_cfg[3];
+		u32 property_u32;
+		char const *manufacturer;
+		char const *product;
+		u8 non_rem_dev = 0;
+		u8 port_disable_sp = 0;
+		u8 port_disable_bp = 0;
+
+		if (!of_property_read_u16_array(np, "vendor-id", &vendor_id, 1)) {
+			char buffer[] = { vendor_id >> 8, vendor_id };
+
+			err = regmap_bulk_write(hub->regmap, USB49XX_ADDR_VENDOR_ID,
+					buffer, ARRAY_SIZE(buffer));
+			if (err) {
+				dev_err(dev, "Setting vendor id failed: %d\n", err);
+				return err;
+			}
+		}
+
+		if (!of_property_read_u16_array(np, "product-id", &product_id, 1)) {
+			char buffer[] = { product_id >> 8, product_id };
+
+			err = regmap_bulk_write(hub->regmap, USB49XX_ADDR_PRODUCT_ID,
+					buffer, ARRAY_SIZE(buffer));
+			if (err) {
+				dev_err(dev, "Setting product id failed: %d\n", err);
+				return err;
+			}
+		}
+
+		if (!of_property_read_u16_array(np, "device-id", &device_id, 1)) {
+			char buffer[] = { device_id >> 8, device_id };
+
+			err = regmap_bulk_write(hub->regmap, USB49XX_ADDR_DEVICE_ID,
+					buffer, ARRAY_SIZE(buffer));
+			if (err) {
+				dev_err(dev, "Setting device id failed: %d\n", err);
+				return err;
+			}
+		}
+
+		err = regmap_bulk_read(hub->regmap, USB49XX_ADDR_HUB_CFG,
+				hub_cfg, ARRAY_SIZE(hub_cfg));
+		if (err) {
+			dev_err(dev, "Reading hub cfg failed: %d\n", err);
+			return err;
+		}
+
+		if (of_get_property(np, "self-powered", NULL)) {
+			hub_cfg[0] |= BIT(7);
+
+			/* Configure Over-Current sens when self-powered */
+			hub_cfg[0] &= ~BIT(2);
+			if (of_get_property(np, "ganged-sensing", NULL))
+				hub_cfg[0] &= ~BIT(1);
+			else if (of_get_property(np, "individual-sensing", NULL))
+				hub_cfg[0] |= BIT(1);
+		} else if (of_get_property(np, "bus-powered", NULL)) {
+			hub_cfg[0] &= ~BIT(7);
+
+			/* Disable Over-Current sense when bus-powered */
+			hub_cfg[0] |= BIT(2);
+		}
+
+		if (of_get_property(np, "disable-hi-speed", NULL))
+			hub_cfg[0] |= BIT(5);
+
+		if (of_get_property(np, "multi-tt", NULL))
+			hub_cfg[0] |= BIT(4);
+		else if (of_get_property(np, "single-tt", NULL))
+			hub_cfg[0] &= ~BIT(4);
+
+		if (of_get_property(np, "disable-eop", NULL))
+			hub_cfg[0] |= BIT(3);
+
+		if (of_get_property(np, "individual-port-switching", NULL))
+			hub_cfg[0] |= BIT(0);
+		else if (of_get_property(np, "ganged-port-switching", NULL))
+			hub_cfg[0] &= ~BIT(0);
+
+		if (of_get_property(np, "dynamic-power-switching", NULL))
+			hub_cfg[1] |= BIT(7);
+
+		if (!of_property_read_u32(np, "oc-delay-ns", &property_u32)) {
+			if (property_u32 == 50) {
+				/* 50 ns*/
+				hub_cfg[1] &= ~BIT(5);
+				hub_cfg[1] &= ~BIT(4);
+			} else if (property_u32 == 100) {
+				/* 100 ns */
+				hub_cfg[1] &= ~BIT(5);
+				hub_cfg[1] |= BIT(4);
+			} else if (property_u32 == 200) {
+				/* 400 ns */
+				hub_cfg[1] |= BIT(5);
+				hub_cfg[1] |= BIT(4);
+			} else {
+				/* 200 ns (DEFAULT) */
+				hub_cfg[1] |= BIT(5);
+				hub_cfg[1] &= ~BIT(4);
+			}
+		}
+
+		if (of_get_property(np, "compound-device", NULL))
+			hub_cfg[1] |= BIT(3);
+
+		if (of_get_property(np, "port-mapping-mode", NULL))
+			hub_cfg[2] |= USB49XX_HUB_CFG3_PRTMAP_EN;
+
+		/* port mapping requires that Link Power Management is disabled */
+		if (hub_cfg[2] & USB49XX_HUB_CFG3_PRTMAP_EN) {
+			unsigned int usb2_hub_ctrl;
+
+			/* Disable Link Power Management */
+			err = regmap_read(hub->regmap, USB49XX_ADDR_USB2_HUB_CTRL,
+					&usb2_hub_ctrl);
+			if (err) {
+				dev_err(dev, "Reading USB2 Hub Control failed: %d\n", err);
+				return err;
+			}
+
+			usb2_hub_ctrl |= USB49XX_USB2_HUB_CTRL_LPM_DISABLE;
+
+			err = regmap_write(hub->regmap, USB49XX_ADDR_USB2_HUB_CTRL,
+					usb2_hub_ctrl);
+			if (err) {
+				dev_err(dev, "Writing USB2 Hub Control failed: %d\n", err);
+				return err;
+			}
+		}
+
+		manufacturer = of_get_property(np, "manufacturer", NULL);
+		product = of_get_property(np, "product", NULL);
+
+		if (manufacturer || product)
+			hub_cfg[2] |= USB49XX_HUB_CFG3_STRING_EN;
+
+		err = regmap_bulk_write(hub->regmap, USB49XX_ADDR_HUB_CFG,
+				hub_cfg, ARRAY_SIZE(hub_cfg));
+		if (err) {
+			dev_err(dev, "Setting hub cfg failed: %d\n", err);
+			return err;
+		}
+
+		usb49xx_get_ports_field(hub, "non-removable-ports", 5, &non_rem_dev);
+		err = regmap_write(hub->regmap, USB49XX_ADDR_NON_REMOVABLE_DEVICES,
+				non_rem_dev);
+		if (err) {
+			dev_err(dev, "Setting non removable devices failed: %d\n", err);
+			return err;
+		}
+
+		usb49xx_get_ports_field(hub, "sp-disabled-ports", 7, &port_disable_sp);
+		err = regmap_write(hub->regmap, USB49XX_ADDR_PORT_DISABLE_SELF,
+				port_disable_sp);
+		if (err) {
+			dev_err(dev, "Setting port disable self powered failed: %d\n", err);
+			return err;
+		}
+
+		usb49xx_get_ports_field(hub, "bp-disabled-ports", 7, &port_disable_bp);
+		err = regmap_write(hub->regmap, USB49XX_ADDR_PORT_DISABLE_BUS,
+				port_disable_bp);
+		if (err) {
+			dev_err(dev, "Setting port disable powered powered failed: %d\n", err);
+			return err;
+		}
+
+		if (!of_property_read_u32(np, "power-on-time-ms", &property_u32)) {
+			u8 power_on_time = min_t(u8, property_u32 / 2, 255);
+
+			err = regmap_write(hub->regmap, USB49XX_ADDR_POWER_ON_TIME,
+					power_on_time);
+			if (err) {
+				dev_err(dev, "Setting power on time failed: %d\n", err);
+				return err;
+			}
+		}
+
+		if (!of_property_read_u32(np, "ocs-min-width-ms", &property_u32)) {
+			u8 ocs_min_width = min_t(u8, property_u32, 5);
+
+			err = regmap_write(hub->regmap, USB49XX_ADDR_OCS_MIN_WIDTH,
+					ocs_min_width);
+			if (err) {
+				dev_err(dev, "Setting ocs min width failed: %d\n", err);
+				return err;
+			}
+		}
+
+		if (!of_property_read_u16_array(np, "language-id", &lang_id, 1)) {
+			char buffer[] = { lang_id >> 8, lang_id };
+
+			err = regmap_bulk_write(hub->regmap, USB49XX_ADDR_LANGUAGE_ID,
+					buffer, ARRAY_SIZE(buffer));
+			if (err) {
+				dev_err(dev, "Setting language id failed: %d\n", err);
+				return err;
+			}
+		}
+
+		if (manufacturer) {
+			struct usb49xx_string_desc manufacturer_desc;
+
+			memset(&manufacturer_desc, 0, sizeof(manufacturer_desc));
+			manufacturer_desc.type = 0x3;
+			manufacturer_desc.length =
+					utf8s_to_utf16s(manufacturer, strlen(manufacturer),
+					UTF16_LITTLE_ENDIAN,
+					manufacturer_desc.string, USB49XX_STRING_BUFSIZE)
+					* sizeof(wchar_t) + 2;
+
+			err = regmap_bulk_write(hub->regmap,
+					USB49XX_ADDR_MANUFACTURER_STRING_DESC,
+					&manufacturer_desc, sizeof(manufacturer_desc));
+			if (err) {
+				dev_err(dev, "Setting manufacturer string descriptor failed: %d\n",
+						err);
+				return err;
+			}
+
+			err = regmap_write(hub->regmap, USB49XX_ADDR_MANUFACTURER_STRING_LEN,
+					manufacturer_desc.length);
+			if (err) {
+				dev_err(dev, "Setting manufacturer string length failed: %d\n",
+						err);
+				return err;
+			}
+		}
+
+		if (product) {
+			struct usb49xx_string_desc product_desc;
+
+			memset(&product_desc, 0, sizeof(product_desc));
+			product_desc.type = 0x3;
+			product_desc.length = utf8s_to_utf16s(product, strlen(product),
+					UTF16_LITTLE_ENDIAN,
+					product_desc.string, USB49XX_STRING_BUFSIZE)
+					* sizeof(wchar_t) + 2;
+
+			err = regmap_bulk_write(hub->regmap,
+					USB49XX_ADDR_PRODUCT_STRING_DESC,
+					&product_desc, sizeof(product_desc));
+			if (err) {
+				dev_err(dev, "Setting product string descriptor failed: %d\n", err);
+				return err;
+			}
+
+			err = regmap_write(hub->regmap, USB49XX_ADDR_PRODUCT_STRING_LEN,
+					product_desc.length);
+			if (err) {
+				dev_err(dev, "SSetting product string length failed: %d\n", err);
+				return err;
+			}
+		}
+	}
+
+#ifdef DEBUG
+	{
+		char *buffer = kzalloc(0x5000, GFP_KERNEL);
+
+		err = regmap_bulk_read(hub->regmap, 0xBF800000, buffer, 0x4);
+		print_hex_dump_bytes("", DUMP_PREFIX_OFFSET, buffer, 0x4);
+		err = regmap_bulk_read(hub->regmap, 0xBF803000, buffer, 0x200);
+		print_hex_dump_bytes("", DUMP_PREFIX_OFFSET, buffer, 0x200);
+		err = regmap_bulk_read(hub->regmap, 0xBFD23200, buffer, 0x200);
+		print_hex_dump_bytes("", DUMP_PREFIX_OFFSET, buffer, 0x200);
+		kfree(buffer);
+	}
+#endif
+
+	/*
+	 *  attach
+	 */
+	/* n.b. Could also use 0xAA56 (attach with SMBus runtime access) */
+	attach_buffer[0] = 0xAA;   /* USB attach (high byte) */
+	attach_buffer[1] = 0x56;   /* USB attach (low byte) */
+	attach_buffer[2] = 0x00;   /* terminator */
+
+	err = i2c_master_send(hub->i2c, attach_buffer, 3);
+	if (err != 3) {
+		dev_err(dev, "attaching hub failed: %d\n", err);
+		return err;
+	}
+
+	dev_info(dev, "Hub configuration was successful.\n");
+	return 0;
+
+}
+
+#ifdef CONFIG_OF
+static int usb49xx_get_ofdata(struct usb49xx *hub)
+{
+	struct device *dev = hub->dev;
+	struct device_node *np = dev->of_node;
+
+	if (!np) {
+		dev_err(dev, "failed to get ofdata\n");
+		return -ENODEV;
+	}
+
+	if (of_get_property(np, "skip-config", NULL))
+		hub->skip_config = 1;
+	else
+		hub->skip_config = 0;
+
+	hub->gpio_reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
+	if (IS_ERR(hub->gpio_reset))
+		return PTR_ERR(hub->gpio_reset);
+
+	return 0;
+}
+
+static const struct of_device_id usb49xx_of_match[] = {
+	{ .compatible = "microchip,usb4712",  },
+	{ .compatible = "microchip,usb4712i", },
+	{ .compatible = "microchip,usb4715",  },
+	{ .compatible = "microchip,usb4715i", },
+	{ .compatible = "microchip,usb4912",  },
+	{ .compatible = "microchip,usb4912i", },
+	{ .compatible = "microchip,usb4914",  },
+	{ .compatible = "microchip,usb4914i", },
+	{ .compatible = "microchip,usb4916",  },
+	{ .compatible = "microchip,usb4916i", },
+	{ .compatible = "microchip,usb4925",  },
+	{ .compatible = "microchip,usb4925i", },
+	{ .compatible = "microchip,usb4927",  },
+	{ .compatible = "microchip,usb4927i", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, usb49xx_of_match);
+#else /* CONFIG_OF */
+static int usb49xx_get_ofdata(struct usb49xx *hub)
+{
+	return 0;
+}
+#endif /* CONFIG_OF */
+
+static void usb49xx_regulator_disable_action(void *data)
+{
+	struct usb49xx *hub = data;
+
+	regulator_disable(hub->vdd);
+}
+
+static int usb49xx_probe(struct usb49xx *hub)
+{
+	struct device *dev = hub->dev;
+	struct device_node *np = dev->of_node;
+	int err;
+
+	if (np) {
+		err = usb49xx_get_ofdata(hub);
+		if (err) {
+			dev_err(dev, "failed to get ofdata: %d\n", err);
+			return err;
+		}
+	}
+
+	/*
+	 * The usb49xx performs a check on the SMBus during the SMBUS_CHECK state.
+	 * In order to successful, SCL and SDA must be stable at this moment.
+	 * Normally we could just lock the SMBus-segment the
+	 * hub i2c-interface resides for the device-specific reset timing. But
+	 * the GPIO controller, which is used to handle the hub reset, might be
+	 * placed at the same i2c-bus segment. In this case an error should be
+	 * returned since we can't safely use the GPIO controller to clear the
+	 * reset state (it may affect the hub configuration) and we can't lock
+	 * the i2c-bus segment (it will cause a deadlock).
+	 */
+	err = usb49xx_check_gpio_chip(hub);
+	if (err)
+		return err;
+
+	hub->vdd = devm_regulator_get(dev, "vdd");
+	if (IS_ERR(hub->vdd))
+		return PTR_ERR(hub->vdd);
+
+	err = regulator_enable(hub->vdd);
+	if (err)
+		return err;
+
+	err = devm_add_action_or_reset(dev,
+				       usb49xx_regulator_disable_action, hub);
+	if (err)
+		return err;
+
+	err = usb49xx_connect(hub);
+	if (err) {
+		dev_err(dev, "Failed to connect hub (%d)\n", err);
+		return err;
+	}
+
+	dev_info(dev, "Hub probed successfully\n");
+
+	return 0;
+}
+
+static int usb49xx_i2c_gather_write(void *context,
+		const void *reg, size_t reg_len,
+		const void *val, size_t val_len)
+{
+	struct i2c_client *i2c = (struct i2c_client *)context;
+	size_t frame_len = val_len + 9;
+	char *buffer;
+	int err;
+
+	if (WARN_ON(reg_len != 4))
+		return -EINVAL;
+
+	buffer = kmalloc(frame_len, GFP_KERNEL);
+	if (!buffer)
+		return -ENOMEM;
+
+	buffer[0] = 0x00;                 /* Memory address (high byte) */
+	buffer[1] = 0x00;                 /* Memory address (low byte) */
+	buffer[2] = val_len + 6;          /* Number of bytes to write to memory */
+	buffer[3] = 0x00;                 /* Register Write */
+	buffer[4] = val_len;              /* Write val_len data bytes */
+	buffer[5] = *((const char *)reg + 0);   /* Register address (MSB) */
+	buffer[6] = *((const char *)reg + 1);   /* Register address */
+	buffer[7] = *((const char *)reg + 2);   /* Register address */
+	buffer[8] = *((const char *)reg + 3);   /* Register address (LSB) */
+	memcpy(&buffer[9], val, val_len);
+
+	err = i2c_master_send(i2c, buffer, frame_len);
+	if (err != (int)frame_len) {
+		dev_err(&i2c->dev, "Writing to hub memory failed: %d\n", err);
+		goto error_kfree;
+	}
+
+	buffer[0] = 0x99;   /* Command (high byte) */
+	buffer[1] = 0x37;   /* Command (low byte) */
+	buffer[2] = 0x00;   /* Termination */
+	frame_len = 3;
+
+	err = i2c_master_send(i2c, buffer, frame_len);
+	if (err != (int)frame_len) {
+		dev_err(&i2c->dev, "Accessing configuration data failed: %d\n", err);
+		goto error_kfree;
+	}
+
+	err = 0;
+
+error_kfree:
+	kfree(buffer);
+	return err;
+}
+
+/* regmap puts address into data[0] .. data[3]; value is in data[4] */
+static int usb49xx_i2c_write(void *context, const void *data, size_t count)
+{
+	if (WARN_ON(count != 5))
+		return -EINVAL;
+
+	return usb49xx_i2c_gather_write(context, data, 4, data + 4, 1);
+}
+
+static int usb49xx_i2c_read(void *context, const void *reg_buf, size_t reg_size,
+		void *val_buf, size_t val_size)
+{
+	struct i2c_client *i2c = (struct i2c_client *)context;
+	char *tx, *rx;
+	int err;
+
+	if (WARN_ON(reg_size != 4)) {
+		err =  -EINVAL;
+		goto error_return;
+	}
+
+	tx = kmalloc(9, GFP_KERNEL);
+	if (!tx) {
+		err = -ENOMEM;
+		goto error_return;
+	}
+
+	rx = kmalloc(1 + val_size, GFP_KERNEL);
+	if (!rx) {
+		err = -ENOMEM;
+		goto error_free_tx;
+	}
+
+	tx[0] = 0x00;                 /* Memory address (high byte) */
+	tx[1] = 0x00;                 /* Memory address (low byte) */
+	tx[2] = 6;                    /* Number of bytes to write to memory */
+	tx[3] = 0x01;                 /* Register Read */
+	tx[4] = val_size;             /* Read val_size data bytes */
+	tx[5] = *((const char *)reg_buf + 0);   /* Register address (MSB) */
+	tx[6] = *((const char *)reg_buf + 1);   /* Register address */
+	tx[7] = *((const char *)reg_buf + 2);   /* Register address */
+	tx[8] = *((const char *)reg_buf + 3);   /* Register address (LSB) */
+
+	err = i2c_master_send(i2c, tx, 9);
+	if (err != 9) {
+		dev_err(&i2c->dev, "Writing to hub memory failed: %d\n", err);
+		goto error_free_rx;
+	}
+
+	tx[0] = 0x99;   /* Command (high byte) */
+	tx[1] = 0x37;   /* Command (low byte) */
+	tx[2] = 0x00;   /* Termination */
+
+	err = i2c_master_send(i2c, tx, 3);
+	if (err != 3) {
+		dev_err(&i2c->dev, "Accessing configuration data failed: %d\n", err);
+		goto error_free_rx;
+	}
+
+	/* Read from hub memory address 6 (according to application note) */
+	tx[0] = 0x00;    /* Memory address (high byte) */
+	tx[1] = 0x06;    /* Memory address (low byte) */
+
+	{
+		struct i2c_msg msgs[] = {
+			{
+				.addr = i2c->addr, .flags = 0,
+				.len  =         2, .buf = tx
+			},
+			{
+				.addr = i2c->addr, .flags = I2C_M_RD,
+				.len = 1 + val_size, .buf = rx
+			},
+		};
+
+		err = i2c_transfer(i2c->adapter, msgs, ARRAY_SIZE(msgs));
+		if (err < 0) {
+			dev_err(&i2c->dev, "Reading from hub memory failed: %d\n", err);
+			goto error_free_rx;
+		}
+	}
+
+	WARN_ON(rx[0] < val_size);
+
+	memcpy(val_buf, &rx[1], val_size);
+
+	err = 0;
+
+error_free_rx:
+	kfree(rx);
+error_free_tx:
+	kfree(tx);
+error_return:
+	return err;
+}
+
+/*
+ * The reason we need this custom regmap_bus instead of using regmap_init_i2c()
+ * is that accesses to the USB49xx configuration memory have to be wrapped into
+ * a special protocol.
+ */
+static const struct regmap_bus usb49xx_i2c_regmap = {
+	.write         = usb49xx_i2c_write,
+	.gather_write  = usb49xx_i2c_gather_write,
+	.read          = usb49xx_i2c_read,
+	.max_raw_read  = 8,
+	.max_raw_write = 128,
+};
+
+/* Avoid reading bigger dead ranges inside hubs memory. Same table for
+ * read and write.
+ */
+static const struct regmap_range usb49xx_regmap_yes_ranges[] = {
+	{ .range_min = 0xBF800000, .range_max = 0xBF800003 },
+	{ .range_min = 0xBF800900, .range_max = 0xBF8009FF },
+	{ .range_min = 0xBF803000, .range_max = 0xBF803015 },
+	{ .range_min = 0xBF8030D0, .range_max = 0xBF803197 },
+	{ .range_min = 0xBF80398C, .range_max = 0xBF80398D },
+	{ .range_min = 0xBF803C00, .range_max = 0xBF803C3C },
+	{ .range_min = 0xBF8060CA, .range_max = 0xBF8060CC },
+	{ .range_min = 0xBF8064CA, .range_max = 0xBF8064CC },
+	{ .range_min = 0xBF8068CA, .range_max = 0xBF8068CC },
+	{ .range_min = 0xBF806CCA, .range_max = 0xBF806CCC },
+	{ .range_min = 0xBF8070CA, .range_max = 0xBF8070CC },
+	{ .range_min = 0xBF8074CA, .range_max = 0xBF8074CC },
+	{ .range_min = 0xBF8078CA, .range_max = 0xBF8078CC },
+
+	{ .range_min = 0xBFD22856, .range_max = 0xBFD22857 },
+	{ .range_min = 0xBFD23202, .range_max = 0xBFD23472 },
+};
+
+static const struct regmap_access_table usb49xx_regmap_access_table = {
+	.yes_ranges   = usb49xx_regmap_yes_ranges,
+	.n_yes_ranges = ARRAY_SIZE(usb49xx_regmap_yes_ranges),
+};
+
+static int usb49xx_i2c_probe(struct i2c_client *i2c,
+			      const struct i2c_device_id *id __always_unused)
+{
+	struct usb49xx *hub;
+	struct regmap_config regmap_cfg = {
+		.name            = "usb49xx_config_mem",
+		.reg_bits        = 32,
+		.val_bits        = 8,
+		.wr_table        = &usb49xx_regmap_access_table,
+		.rd_table        = &usb49xx_regmap_access_table,
+		.can_multi_write = 1,
+	};
+
+	hub = devm_kzalloc(&i2c->dev, sizeof(struct usb49xx), GFP_KERNEL);
+	if (!hub)
+		return -ENOMEM;
+
+	i2c_set_clientdata(i2c, hub);
+	hub->dev = &i2c->dev;
+	hub->i2c = i2c;
+	hub->regmap = devm_regmap_init(&i2c->dev, &usb49xx_i2c_regmap, i2c,
+			&regmap_cfg);
+	if (IS_ERR(hub->regmap))
+		return PTR_ERR(hub->regmap);
+
+	return usb49xx_probe(hub);
+}
+
+static int usb49xx_i2c_remove(struct i2c_client *i2c)
+{
+	struct usb49xx *hub = i2c_get_clientdata(i2c);
+
+	usb49xx_reset(hub, 0);
+
+	return 0;
+};
+
+static int __maybe_unused usb49xx_suspend(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct usb49xx *hub = i2c_get_clientdata(client);
+
+	return regulator_disable(hub->vdd);
+}
+
+static int __maybe_unused usb49xx_resume(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct usb49xx *hub = i2c_get_clientdata(client);
+	int err;
+
+	err = regulator_enable(hub->vdd);
+	if (err)
+		return err;
+
+	return usb49xx_connect(hub);
+}
+
+static SIMPLE_DEV_PM_OPS(usb49xx_pm_ops, usb49xx_suspend, usb49xx_resume);
+
+static const struct i2c_device_id usb49xx_id[] = {
+	{ "usb4712", 0 },
+	{ "usb4712i", 0 },
+	{ "usb4715", 0 },
+	{ "usb4715i", 0 },
+	{ "usb4912", 0 },
+	{ "usb4912i", 0 },
+	{ "usb4914", 0 },
+	{ "usb4914i", 0 },
+	{ "usb4916", 0 },
+	{ "usb4916	i", 0 },
+	{ "usb4925", 0 },
+	{ "usb4925i", 0 },
+	{ "usb4927", 0 },
+	{ "usb4927i", 0 },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(i2c, usb49xx_id);
+
+static struct i2c_driver usb49xx_i2c_driver = {
+	.driver = {
+		.name = DRIVER_NAME,
+		.of_match_table = of_match_ptr(usb49xx_of_match),
+		.pm = &usb49xx_pm_ops,
+	},
+	.probe    = usb49xx_i2c_probe,
+	.remove   = usb49xx_i2c_remove,
+	.id_table = usb49xx_id,
+};
+
+module_i2c_driver(usb49xx_i2c_driver);
+
+MODULE_AUTHOR("Christian Eggers <ceggers@arri.de>");
+MODULE_DESCRIPTION("USB47xx/USB49xx USB 2.0 Hub Controller Driver");
+MODULE_LICENSE("GPL");
-- 
Christian Eggers
Embedded software developer

Arnold & Richter Cine Technik GmbH & Co. Betriebs KG
Sitz: Muenchen - Registergericht: Amtsgericht Muenchen - Handelsregisternummer: HRA 57918
Persoenlich haftender Gesellschafter: Arnold & Richter Cine Technik GmbH
Sitz: Muenchen - Registergericht: Amtsgericht Muenchen - Handelsregisternummer: HRB 54477
Geschaeftsfuehrer: Dr. Michael Neuhaeuser; Stephan Schenk; Walter Trauninger; Markus Zeiler

