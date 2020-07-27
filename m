Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0752BC433E5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 17:04:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7CC620719
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 17:04:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="r37eGibO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729814AbgG0REW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 13:04:22 -0400
Received: from crapouillou.net ([89.234.176.41]:50942 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728945AbgG0REV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 13:04:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1595869459; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=eT2jj7Ti6DrN9oXU7iVezLcMMoelbwTnKJJCcgsMRyA=;
        b=r37eGibOeuqtd+N5v/w3TcFBPfpIyU0J3ooSjYyHjhFZ55FavejAJqKmnq0Cmx7YZ+rwVh
        FaLPjh8DRrjApyks/NvKEjs5LvCKuQDTagG9JGsWkr/2iRXVdEy6yi5ohY/hvdrPGe5Oau
        0MT+YP7TZJ9mIDzxmKarnioOc4VmyRU=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     od@zcrc.me, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2] usb: common: usb-conn-gpio: Register charger
Date:   Mon, 27 Jul 2020 19:04:13 +0200
Message-Id: <20200727170413.23131-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Register a power supply charger, whose online state depends on whether
the USB role is set to device or not.

This is useful when the USB role is the only way to know if the device
is charging from USB. The API is the standard power supply charger API,
you get a /sys/class/power_supply/xxx/online node which tells you the
state of the charger.

The sole purpose of this is to give userspace applications a way to
know whether or not the charger is plugged.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---

Notes:
    v2: Don't make charger registration optional

 drivers/usb/common/Kconfig         |  1 +
 drivers/usb/common/usb-conn-gpio.c | 45 ++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/drivers/usb/common/Kconfig b/drivers/usb/common/Kconfig
index d611477aae41..5e8a04e3dd3c 100644
--- a/drivers/usb/common/Kconfig
+++ b/drivers/usb/common/Kconfig
@@ -40,6 +40,7 @@ config USB_CONN_GPIO
 	tristate "USB GPIO Based Connection Detection Driver"
 	depends on GPIOLIB
 	select USB_ROLE_SWITCH
+	select POWER_SUPPLY
 	help
 	  The driver supports USB role switch between host and device via GPIO
 	  based USB cable detection, used typically if an input GPIO is used
diff --git a/drivers/usb/common/usb-conn-gpio.c b/drivers/usb/common/usb-conn-gpio.c
index ed204cbb63ea..fb7d35b040b7 100644
--- a/drivers/usb/common/usb-conn-gpio.c
+++ b/drivers/usb/common/usb-conn-gpio.c
@@ -17,6 +17,7 @@
 #include <linux/of.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
+#include <linux/power_supply.h>
 #include <linux/regulator/consumer.h>
 #include <linux/usb/role.h>
 
@@ -38,6 +39,9 @@ struct usb_conn_info {
 	struct gpio_desc *vbus_gpiod;
 	int id_irq;
 	int vbus_irq;
+
+	struct power_supply_desc desc;
+	struct power_supply *charger;
 };
 
 /**
@@ -104,6 +108,8 @@ static void usb_conn_detect_cable(struct work_struct *work)
 
 	dev_dbg(info->dev, "vbus regulator is %s\n",
 		regulator_is_enabled(info->vbus) ? "enabled" : "disabled");
+
+	power_supply_changed(info->charger);
 }
 
 static void usb_conn_queue_dwork(struct usb_conn_info *info,
@@ -121,10 +127,35 @@ static irqreturn_t usb_conn_isr(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+static enum power_supply_property usb_charger_properties[] = {
+	POWER_SUPPLY_PROP_ONLINE,
+};
+
+static int usb_charger_get_property(struct power_supply *psy,
+				    enum power_supply_property psp,
+				    union power_supply_propval *val)
+{
+	struct usb_conn_info *info = power_supply_get_drvdata(psy);
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_ONLINE:
+		val->intval = info->last_role == USB_ROLE_DEVICE;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int usb_conn_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
+	struct power_supply_desc *desc;
 	struct usb_conn_info *info;
+	struct power_supply_config cfg = {
+		.of_node = dev->of_node,
+	};
 	int ret = 0;
 
 	info = devm_kzalloc(dev, sizeof(*info), GFP_KERNEL);
@@ -203,6 +234,20 @@ static int usb_conn_probe(struct platform_device *pdev)
 		}
 	}
 
+	desc = &info->desc;
+	desc->name = "usb-charger";
+	desc->properties = usb_charger_properties;
+	desc->num_properties = ARRAY_SIZE(usb_charger_properties);
+	desc->get_property = usb_charger_get_property;
+	desc->type = POWER_SUPPLY_TYPE_USB;
+	cfg.drv_data = info;
+
+	info->charger = devm_power_supply_register(dev, desc, &cfg);
+	if (IS_ERR(info->charger)) {
+		dev_err(dev, "Unable to register charger\n");
+		return PTR_ERR(info->charger);
+	}
+
 	platform_set_drvdata(pdev, info);
 
 	/* Perform initial detection */
-- 
2.27.0

