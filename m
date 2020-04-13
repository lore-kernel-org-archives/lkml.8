Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7670CC2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 12:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 478F120753
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 12:33:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="rZ9lCh/h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729481AbgDMMZu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 08:25:50 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:32964 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728403AbgDMMZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 08:25:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1586780747; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=mLRmosBI8CuefMRZNus/Lb9ooLpVGI3OSjNhF8HppVk=;
        b=rZ9lCh/hEOOxviWU7xslU2HuZsy2d4rEbZjhNDk0e9RWHVQSYryqoEj9k/g24LmK2d25xR
        w2l04mgalFOO59/SxzHJW5/teuk2xecE5zIH3oXuulEcxuQ43YwCw7cJzWs371SNdcrhOC
        3MFCkqhSkjybtazn4vgUZZP+44cEpiw=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Chunfeng Yun <chunfeng.yun@mediatek.com>, od@zcrc.me,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH] usb: common: usb-conn-gpio: Register optional charger
Date:   Mon, 13 Apr 2020 14:25:43 +0200
Message-Id: <20200413122543.73846-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Register a power supply charger, if the Kconfig option
USB_CONN_GPIO_CHARGER is set, whose online state depends on whether
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
    v2: - improve commit message... explain why we want a charger
        - compile charger code only if CONFIG_USB_CONN_GPIO_CHARGER
    	  is set

 drivers/usb/common/Kconfig         | 11 +++++++
 drivers/usb/common/usb-conn-gpio.c | 47 ++++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+)

diff --git a/drivers/usb/common/Kconfig b/drivers/usb/common/Kconfig
index d611477aae41..5405ae96c68f 100644
--- a/drivers/usb/common/Kconfig
+++ b/drivers/usb/common/Kconfig
@@ -49,3 +49,14 @@ config USB_CONN_GPIO
 
 	  To compile the driver as a module, choose M here: the module will
 	  be called usb-conn-gpio.ko
+
+if USB_CONN_GPIO
+
+config USB_CONN_GPIO_CHARGER
+	bool "USB charger support"
+	select POWER_SUPPLY
+	help
+	  Register a charger with the power supply subsystem. This will allow
+	  userspace to know whether or not the device is charging from USB.
+
+endif
diff --git a/drivers/usb/common/usb-conn-gpio.c b/drivers/usb/common/usb-conn-gpio.c
index ed204cbb63ea..129d48db280b 100644
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
@@ -98,6 +102,8 @@ static void usb_conn_detect_cable(struct work_struct *work)
 		ret = regulator_enable(info->vbus);
 		if (ret)
 			dev_err(info->dev, "enable vbus regulator failed\n");
+	} else if (IS_ENABLED(CONFIG_USB_CONN_GPIO_CHARGER)) {
+		power_supply_changed(info->charger);
 	}
 
 	info->last_role = role;
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
@@ -203,6 +234,22 @@ static int usb_conn_probe(struct platform_device *pdev)
 		}
 	}
 
+	if (IS_ENABLED(CONFIG_USB_CONN_GPIO_CHARGER)) {
+		desc = &info->desc;
+		desc->name = "usb-charger";
+		desc->properties = usb_charger_properties;
+		desc->num_properties = ARRAY_SIZE(usb_charger_properties);
+		desc->get_property = usb_charger_get_property;
+		desc->type = POWER_SUPPLY_TYPE_USB;
+		cfg.drv_data = info;
+
+		info->charger = devm_power_supply_register(dev, desc, &cfg);
+		if (IS_ERR(info->charger)) {
+			dev_err(dev, "Unable to register charger\n");
+			return PTR_ERR(info->charger);
+		}
+	}
+
 	platform_set_drvdata(pdev, info);
 
 	/* Perform initial detection */
-- 
2.25.1

