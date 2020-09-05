Return-Path: <SRS0=flm+=CO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D9C6C433E2
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 13:07:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B57A20760
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 13:07:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura-hr.20150623.gappssmtp.com header.i=@sartura-hr.20150623.gappssmtp.com header.b="DQ/jMFJv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728655AbgIENHT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Sep 2020 09:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbgIENFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Sep 2020 09:05:49 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D72EC061247
        for <linux-kernel@vger.kernel.org>; Sat,  5 Sep 2020 06:05:49 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id q13so12044400ejo.9
        for <linux-kernel@vger.kernel.org>; Sat, 05 Sep 2020 06:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SF1qQ5y6zS+uuXI0X6117nR7jpHsJ8QwMXzF/nJxgiY=;
        b=DQ/jMFJvt+FCQjnz+50PJXFDwxKjYTQPxSIhBTijj220+HGAJfCJz6kCUgDRJltpLE
         TYREY+v3rW7rUGaSwrVhMLc706WQ52m4EgeqTWjCS147oCbtiJCLuNbVfkZCLk5zunKb
         MzHyf4v4YLQG/dw1Ej6nfzxFUlR/KS6POdin+WQ5EX+0vaZW/beF/sI5AQQfF2skrs2l
         yZ4Qd68H5HHYo1gP7dc27LyfUgMnPcw08tIyJZQWv2/wLsaIUkIY+vrf66/5oZC9Dch+
         cLPScIto6s5WfdK0AlB7OJCVnOhPBsHnYEOElLpdLQJMQQjRQnsDYpBSFvMk9XDppzj5
         gJ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SF1qQ5y6zS+uuXI0X6117nR7jpHsJ8QwMXzF/nJxgiY=;
        b=UqQLZZYvklBfHYqRXwMwrliQQLKwR261VgSma02BhhUpOKtIBB5XExSliASTgHFQR1
         WeFPL8/oYb+hIUaSMCwmHCgFSeeveifTd8Y9/uF6GCaqacZUIgsMWcCO8KRH8vfSImQr
         X9wpMqlYVHEAJ7EIfMnNKLSA2uRQFTR0Bs7rKsbeLHP+4V35O7+GixQIYP1tt4FL3YyW
         N3ag6j9VSt1YibtYSrbSZYwp6yTeZm8NPu6YLH6EefkaR8zFX8GysvFxcTG+Hrx+VKxr
         oy69qlEX38vX12l+1Ega0ak+UJ2RCve0k378P3uVnvFvggLzpouhecRrOcnA7rbIm9lm
         aLAg==
X-Gm-Message-State: AOAM531cLWdKsUn8T0dKa72wojO4h0SS4orucCo5AzIPpvsDNeq6GMXj
        oBD/orKTj4BkrSLy+o7Rk2OkxcOr8rWE046G8gDaWEWU47yzIZIB2a85D3FPTxrIFIulLVxi1kQ
        19Oco25A786LDilL6TXrvAG2S/ASWByashdcLDs29wRprviBWoKnyfoxHd2M5e0Lw0Gj/FSlrvd
        s4vyKDDOGzZQ==
X-Google-Smtp-Source: ABdhPJxoi1XmHpGnVJEd12p7iaAwu3SnVjIJokGuTJEIZy9ha0sakApo0hCSJzO95UQP1fWnVKfr2w==
X-Received: by 2002:a17:906:19c7:: with SMTP id h7mr12246865ejd.517.1599311147152;
        Sat, 05 Sep 2020 06:05:47 -0700 (PDT)
Received: from localhost.localdomain ([2a00:ee2:4b0d:3002:290:faff:fe54:449c])
        by smtp.gmail.com with ESMTPSA id s18sm9372655ejd.54.2020.09.05.06.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2020 06:05:46 -0700 (PDT)
From:   Luka Kovacic <luka.kovacic@sartura.hr>
To:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-leds@vger.kernel.org
Cc:     lee.jones@linaro.org, pavel@ucw.cz, dmurphy@ti.com,
        robh+dt@kernel.org, jdelvare@suse.com, linux@roeck-us.net,
        andrew@lunn.ch, jason@lakedaemon.net, gregory.clement@bootlin.com,
        luka.perkov@sartura.hr, Luka Kovacic <luka.kovacic@sartura.hr>
Subject: [PATCH 4/7] drivers: leds: Add the iEi WT61P803 PUZZLE LED driver
Date:   Sat,  5 Sep 2020 15:03:33 +0200
Message-Id: <20200905130336.967622-5-luka.kovacic@sartura.hr>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200905130336.967622-1-luka.kovacic@sartura.hr>
References: <20200905130336.967622-1-luka.kovacic@sartura.hr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the iEi WT61P803 PUZZLE LED driver.
Currently only the front panel power LED is supported.

This driver depends on the iEi WT61P803 PUZZLE MFD driver.

Signed-off-by: Luka Kovacic <luka.kovacic@sartura.hr>
Cc: Luka Perkov <luka.perkov@sartura.hr>
---
 drivers/leds/Kconfig                    |   8 ++
 drivers/leds/Makefile                   |   1 +
 drivers/leds/leds-iei-wt61p803-puzzle.c | 184 ++++++++++++++++++++++++
 3 files changed, 193 insertions(+)
 create mode 100644 drivers/leds/leds-iei-wt61p803-puzzle.c

diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index 1c181df24eae..8a25fb753dec 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -332,6 +332,14 @@ config LEDS_IPAQ_MICRO
 	  Choose this option if you want to use the notification LED on
 	  Compaq/HP iPAQ h3100 and h3600.
 
+config LEDS_IEI_WT61P803_PUZZLE
+	tristate "LED Support for the iEi WT61P803 PUZZLE MCU"
+	depends on LEDS_CLASS
+	depends on MFD_IEI_WT61P803_PUZZLE
+	help
+	  This option enables support for LEDs controlled by the iEi WT61P803
+	  M801 MCU.
+
 config LEDS_HP6XX
 	tristate "LED Support for the HP Jornada 6xx"
 	depends on LEDS_CLASS
diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
index c2c7d7ade0d0..cd362437fefd 100644
--- a/drivers/leds/Makefile
+++ b/drivers/leds/Makefile
@@ -34,6 +34,7 @@ obj-$(CONFIG_LEDS_HP6XX)		+= leds-hp6xx.o
 obj-$(CONFIG_LEDS_INTEL_SS4200)		+= leds-ss4200.o
 obj-$(CONFIG_LEDS_IP30)			+= leds-ip30.o
 obj-$(CONFIG_LEDS_IPAQ_MICRO)		+= leds-ipaq-micro.o
+obj-$(CONFIG_LEDS_IEI_WT61P803_PUZZLE)	+= leds-iei-wt61p803-puzzle.o
 obj-$(CONFIG_LEDS_IS31FL319X)		+= leds-is31fl319x.o
 obj-$(CONFIG_LEDS_IS31FL32XX)		+= leds-is31fl32xx.o
 obj-$(CONFIG_LEDS_KTD2692)		+= leds-ktd2692.o
diff --git a/drivers/leds/leds-iei-wt61p803-puzzle.c b/drivers/leds/leds-iei-wt61p803-puzzle.c
new file mode 100644
index 000000000000..50d1e4e81571
--- /dev/null
+++ b/drivers/leds/leds-iei-wt61p803-puzzle.c
@@ -0,0 +1,184 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/* iEi WT61P803 PUZZLE MCU LED Driver
+ *
+ * Copyright (C) 2020 Sartura Ltd.
+ * Author: Luka Kovacic <luka.kovacic@sartura.hr>
+ */
+
+#include <linux/module.h>
+#include <linux/mfd/iei-wt61p803-puzzle.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+#include <linux/leds.h>
+
+#define CMD_CHAR(x) (char)(x)
+
+/**
+ * enum iei_wt61p803_puzzle_led_state - LED state values
+ *
+ * @IEI_LED_OFF: The LED is turned off
+ * @IEI_LED_ON: The LED is turned on
+ * @IEI_LED_BLINK_5HZ: The LED will blink with a freq of 5 Hz
+ * @IEI_LED_BLINK_1HZ: The LED will blink with a freq of 1 Hz
+ */
+enum iei_wt61p803_puzzle_led_state {
+	IEI_LED_OFF = 0x30,
+	IEI_LED_ON = 0x31,
+	IEI_LED_BLINK_5HZ = 0x32,
+	IEI_LED_BLINK_1HZ = 0x33
+};
+
+/**
+ * struct iei_wt61p803_puzzle_led - MCU LED Driver
+ *
+ * @mcu: MCU struct pointer
+ * @lock: General mutex lock for LED operations
+ * @led_power_state: State of the front panel power LED
+ */
+struct iei_wt61p803_puzzle_led {
+	struct iei_wt61p803_puzzle *mcu;
+	struct mutex lock;
+
+	int led_power_state;
+};
+
+static inline struct iei_wt61p803_puzzle_led *
+		cdev_to_iei_wt61p803_puzzle_led(struct led_classdev *led_cdev)
+{
+	return dev_get_drvdata(led_cdev->dev->parent);
+}
+
+static int iei_wt61p803_puzzle_led_brightness_set_blocking
+	(struct led_classdev *cdev, enum led_brightness brightness)
+{
+	struct iei_wt61p803_puzzle_led *mcu_led =
+		cdev_to_iei_wt61p803_puzzle_led(cdev);
+	unsigned char led_power_cmd[5] = { '@', 'R', '1',
+		CMD_CHAR(IEI_LED_OFF) };
+
+	int ret;
+
+	size_t reply_size = 0;
+	unsigned char *resp_buf = kmalloc(IEI_WT61P803_PUZZLE_BUF_SIZE, GFP_KERNEL);
+
+	mutex_lock(&mcu_led->lock);
+
+	if (brightness == LED_OFF) {
+		led_power_cmd[3] = CMD_CHAR(IEI_LED_OFF);
+		mcu_led->led_power_state = LED_OFF;
+	} else {
+		led_power_cmd[3] = CMD_CHAR(IEI_LED_ON);
+		mcu_led->led_power_state = LED_ON;
+	}
+
+	mutex_unlock(&mcu_led->lock);
+
+	ret = iei_wt61p803_puzzle_write_command(mcu_led->mcu, led_power_cmd,
+			sizeof(led_power_cmd), resp_buf, &reply_size);
+
+	kfree(resp_buf);
+
+	return ret;
+}
+
+static enum led_brightness
+iei_wt61p803_puzzle_led_brightness_get(struct led_classdev *cdev)
+{
+	struct iei_wt61p803_puzzle_led *mcu_led =
+		cdev_to_iei_wt61p803_puzzle_led(cdev);
+
+	int led_state;
+
+	mutex_lock(&mcu_led->lock);
+	led_state = mcu_led->led_power_state;
+	mutex_unlock(&mcu_led->lock);
+
+	return led_state;
+}
+
+static int iei_wt61p803_puzzle_led_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct iei_wt61p803_puzzle *mcu = dev_get_drvdata(dev->parent);
+	struct device_node *np = dev->of_node;
+
+	struct iei_wt61p803_puzzle_led *mcu_led;
+	struct device_node *child;
+
+	int ret;
+
+	mcu_led = devm_kzalloc(dev, sizeof(*mcu_led), GFP_KERNEL);
+	if (!mcu_led)
+		return -ENOMEM;
+
+	mcu_led->mcu = mcu;
+
+	/* The default LED power state is 1 */
+	mcu_led->led_power_state = 1;
+
+	/* Init the mutex lock */
+	mutex_init(&mcu_led->lock);
+
+	dev_set_drvdata(dev, mcu_led);
+
+	for_each_child_of_node(np, child) {
+		struct led_classdev *led;
+		u32 reg;
+
+		led = devm_kzalloc(dev, sizeof(*led), GFP_KERNEL);
+		if (!led)
+			return -ENOMEM;
+
+		ret = of_property_read_u32(child, "reg", &reg);
+		if (ret || reg > 1) {
+			dev_err(dev, "Could not register 'reg' of %s\n",
+				child->name);
+			continue;
+		}
+
+		if (of_property_read_string(child, "label", &led->name))
+			led->name = child->name;
+
+		of_property_read_string(child, "linux,default-trigger",
+				&led->default_trigger);
+
+		led->brightness_set_blocking =
+			iei_wt61p803_puzzle_led_brightness_set_blocking;
+		led->brightness_get = iei_wt61p803_puzzle_led_brightness_get;
+
+		led->max_brightness = 1;
+
+		ret = devm_led_classdev_register(dev, led);
+		if (ret) {
+			dev_err(dev, "Could not register %s\n", led->name);
+			return ret;
+		}
+	}
+
+	return 0;
+
+}
+
+static const struct of_device_id iei_wt61p803_puzzle_led_of_match[] = {
+	{ .compatible = "iei,wt61p803-puzzle-leds" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, iei_wt61p803_puzzle_led_of_match);
+
+static struct platform_driver iei_wt61p803_puzzle_led_driver = {
+	.driver = {
+		.name = "iei-wt61p803-puzzle-led",
+		.of_match_table = iei_wt61p803_puzzle_led_of_match,
+	},
+	.probe = iei_wt61p803_puzzle_led_probe,
+};
+module_platform_driver(iei_wt61p803_puzzle_led_driver);
+
+MODULE_DESCRIPTION("iEi WT61P803 PUZZLE front panel LED driver");
+MODULE_AUTHOR("Luka Kovacic <luka.kovacic@sartura.hr>");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:leds-iei-wt61p803-puzzle");
-- 
2.20.1

