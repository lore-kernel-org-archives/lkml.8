Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF82EC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 10:29:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8ED63208C7
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 10:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599560996;
	bh=T9Np5+Wq5GROGNq6yzFhVzQLftW9JxUPIbL6eQLtnG4=;
	h=From:Cc:Subject:Date:In-Reply-To:References:To:List-ID:From;
	b=otIDWb/uOiwIg39VVj8zI88J6Fy6w+8GacHYWap0tw8yrbkjeRWMgVGrtvcnCYT9y
	 ZNQa4xNRvpeAZWXfnzwMB/pbg44guLUSC/HIAY1I8SyB8SwrKI93IufN0t3rOSHqzW
	 e/QlZp/DCPwi7DxhsfmaQdQgpRFue8cvtsTlMEu4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729663AbgIHK3y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 06:29:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:38672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729645AbgIHK3K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 06:29:10 -0400
Received: from mail.kernel.org (ip5f5ad5ce.dynamic.kabel-deutschland.de [95.90.213.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3846621D6C;
        Tue,  8 Sep 2020 10:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599560940;
        bh=T9Np5+Wq5GROGNq6yzFhVzQLftW9JxUPIbL6eQLtnG4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NbedKJY+MpJvSZbN+HayCqCrfMIbnFDUjpCv4pu2ww4PqFNhm+SsrdhoxTDS8+6C/
         621Rt8eRTGVU67ncSZbHBRuTghHUfUBXOUxNts6RXUOR4yR2Vo1EMQWVwCgj6DknX+
         JyO/VZULRPAaDY4P8In0OYXiqZXTXG/ss5Ftxrso=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kFary-00B3yT-AJ; Tue, 08 Sep 2020 12:28:58 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 09/10] misc: hisi_hikey_usb: add support for Hikey 970
Date:   Tue,  8 Sep 2020 12:28:43 +0200
Message-Id: <8367269eb31695db28bd88094b367904503cbd5e.1599559318.git.mchehab+huawei@kernel.org>
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

The HiKey 970 board is similar to Hikey 960 with regards
to its USB configutation: it also relies on a USB HUB
that is used when DWC3 is at host mode.

However, it requires a few extra DT settings, as it
uses a voltage regulator and GPIO reset pin.

Add support for them.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/misc/Kconfig          |  8 +--
 drivers/misc/hisi_hikey_usb.c | 99 +++++++++++++++++++++++++++++------
 2 files changed, 88 insertions(+), 19 deletions(-)

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index fb15364f32d2..e9c38dee2b90 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -457,13 +457,13 @@ config PVPANIC
 	  (guest) communicate panic events to the host.
 
 config HISI_HIKEY_USB
-	tristate "USB GPIO Hub on HiSilicon Hikey960 Platform"
+	tristate "USB GPIO Hub on HiSilicon Hikey 960/970 Platform"
 	depends on (OF && GPIOLIB) || COMPILE_TEST
 	help
 	  If you say yes here this adds support for the on-board USB GPIO hub
-	  found on the HiKey960, which is necessary to support switching
-	  between the dual-role USB-C port and the USB-A host ports using only
-	  one USB controller.
+	  found on HiKey 960/970 boards, which is necessary to support
+	  switching between the dual-role USB-C port and the USB-A host ports
+	  using only one USB controller.
 
 source "drivers/misc/c2port/Kconfig"
 source "drivers/misc/eeprom/Kconfig"
diff --git a/drivers/misc/hisi_hikey_usb.c b/drivers/misc/hisi_hikey_usb.c
index 3a98a890757c..2ddd4072788d 100644
--- a/drivers/misc/hisi_hikey_usb.c
+++ b/drivers/misc/hisi_hikey_usb.c
@@ -14,8 +14,10 @@
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/notifier.h>
+#include <linux/of_gpio.h>
 #include <linux/platform_device.h>
 #include <linux/property.h>
+#include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 #include <linux/usb/role.h>
 
@@ -29,9 +31,13 @@
 #define TYPEC_VBUS_POWER_OFF 0
 
 struct hisi_hikey_usb {
+	struct device *dev;
 	struct gpio_desc *otg_switch;
 	struct gpio_desc *typec_vbus;
 	struct gpio_desc *hub_vbus;
+	struct gpio_desc *reset;
+
+	struct regulator *regulator;
 
 	struct usb_role_switch *hub_role_sw;
 
@@ -46,23 +52,47 @@ struct hisi_hikey_usb {
 
 static void hub_power_ctrl(struct hisi_hikey_usb *hisi_hikey_usb, int value)
 {
-	gpiod_set_value_cansleep(hisi_hikey_usb->hub_vbus, value);
+	int ret, status;
+
+	if (hisi_hikey_usb->hub_vbus)
+		gpiod_set_value_cansleep(hisi_hikey_usb->hub_vbus, value);
+
+	if (!hisi_hikey_usb->regulator)
+		return;
+
+	status = regulator_is_enabled(hisi_hikey_usb->regulator);
+	if (status == !!value)
+		return;
+
+	if (value)
+		ret = regulator_enable(hisi_hikey_usb->regulator);
+	else
+		ret = regulator_disable(hisi_hikey_usb->regulator);
+
+	if (ret)
+		dev_err(hisi_hikey_usb->dev,
+			"Can't switch regulator state to %s\n",
+			value ? "enabled" : "disabled");
 }
 
 static void usb_switch_ctrl(struct hisi_hikey_usb *hisi_hikey_usb,
 			    int switch_to)
 {
+	if (!hisi_hikey_usb->otg_switch)
+		return;
+
 	gpiod_set_value_cansleep(hisi_hikey_usb->otg_switch, switch_to);
 }
 
 static void usb_typec_power_ctrl(struct hisi_hikey_usb *hisi_hikey_usb,
 				 int value)
 {
+	if (!hisi_hikey_usb->typec_vbus)
+		return;
+
 	gpiod_set_value_cansleep(hisi_hikey_usb->typec_vbus, value);
 }
 
-
-
 static void relay_set_role_switch(struct work_struct *work)
 {
 	struct hisi_hikey_usb *hisi_hikey_usb = container_of(work,
@@ -117,31 +147,70 @@ static int hub_usb_role_switch_set(struct usb_role_switch *sw, enum usb_role rol
 	return 0;
 }
 
+static int hisi_hikey_usb_parse_kirin970(struct platform_device *pdev,
+					 struct hisi_hikey_usb *hisi_hikey_usb)
+{
+	struct regulator *regulator;
+	int ret;
+
+	regulator = devm_regulator_get(&pdev->dev, "hub-vdd");
+	if (IS_ERR(regulator)) {
+		if (PTR_ERR(regulator) == -EPROBE_DEFER) {
+			dev_info(&pdev->dev,
+				 "waiting for hub-vdd-supply to be probed\n");
+			return PTR_ERR(regulator);
+		}
+		dev_err(&pdev->dev,
+			"get hub-vdd-supply failed with error %ld\n",
+			PTR_ERR(regulator));
+			return PTR_ERR(regulator);
+	}
+	hisi_hikey_usb->regulator = regulator;
+
+	hisi_hikey_usb->reset = devm_gpiod_get(&pdev->dev, "hub_reset_en_gpio",
+					       GPIOD_OUT_HIGH);
+	if (IS_ERR(hisi_hikey_usb->reset))
+		return PTR_ERR(hisi_hikey_usb->reset);
+
+	return ret;
+}
+
 static int hisi_hikey_usb_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct hisi_hikey_usb *hisi_hikey_usb;
 	struct usb_role_switch_desc hub_role_switch = {NULL};
+	int ret;
 
 	hisi_hikey_usb = devm_kzalloc(dev, sizeof(*hisi_hikey_usb), GFP_KERNEL);
 	if (!hisi_hikey_usb)
 		return -ENOMEM;
 
-	hisi_hikey_usb->typec_vbus = devm_gpiod_get(dev, "typec-vbus",
-						    GPIOD_OUT_LOW);
-	if (IS_ERR(hisi_hikey_usb->typec_vbus))
-		return PTR_ERR(hisi_hikey_usb->typec_vbus);
+	hisi_hikey_usb->dev = &pdev->dev;
 
 	hisi_hikey_usb->otg_switch = devm_gpiod_get(dev, "otg-switch",
 						    GPIOD_OUT_HIGH);
 	if (IS_ERR(hisi_hikey_usb->otg_switch))
 		return PTR_ERR(hisi_hikey_usb->otg_switch);
 
-	/* hub-vdd33-en is optional */
-	hisi_hikey_usb->hub_vbus = devm_gpiod_get_optional(dev, "hub-vdd33-en",
-							   GPIOD_OUT_HIGH);
-	if (IS_ERR(hisi_hikey_usb->hub_vbus))
-		return PTR_ERR(hisi_hikey_usb->hub_vbus);
+	hisi_hikey_usb->typec_vbus = devm_gpiod_get(dev, "typec-vbus",
+						    GPIOD_OUT_LOW);
+	if (IS_ERR(hisi_hikey_usb->typec_vbus))
+		return PTR_ERR(hisi_hikey_usb->typec_vbus);
+
+	/* Parse Kirin 970-specific OF data */
+	if (of_device_is_compatible(pdev->dev.of_node,
+				    "hisilicon,kirin970_hikey_usbhub")) {
+		ret = hisi_hikey_usb_parse_kirin970(pdev, hisi_hikey_usb);
+		if (ret)
+			return ret;
+	} else {
+		/* hub-vdd33-en is optional */
+		hisi_hikey_usb->hub_vbus = devm_gpiod_get_optional(dev, "hub-vdd33-en",
+								   GPIOD_OUT_HIGH);
+		if (IS_ERR(hisi_hikey_usb->hub_vbus))
+			return PTR_ERR(hisi_hikey_usb->hub_vbus);
+	}
 
 	hisi_hikey_usb->dev_role_sw = usb_role_switch_get(dev);
 	if (!hisi_hikey_usb->dev_role_sw)
@@ -149,7 +218,6 @@ static int hisi_hikey_usb_probe(struct platform_device *pdev)
 	if (IS_ERR(hisi_hikey_usb->dev_role_sw))
 		return PTR_ERR(hisi_hikey_usb->dev_role_sw);
 
-
 	INIT_WORK(&hisi_hikey_usb->work, relay_set_role_switch);
 	mutex_init(&hisi_hikey_usb->lock);
 
@@ -158,7 +226,7 @@ static int hisi_hikey_usb_probe(struct platform_device *pdev)
 	hub_role_switch.driver_data = hisi_hikey_usb;
 
 	hisi_hikey_usb->hub_role_sw = usb_role_switch_register(dev,
-							&hub_role_switch);
+							       &hub_role_switch);
 
 	if (IS_ERR(hisi_hikey_usb->hub_role_sw)) {
 		usb_role_switch_put(hisi_hikey_usb->dev_role_sw);
@@ -184,7 +252,8 @@ static int  hisi_hikey_usb_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id id_table_hisi_hikey_usb[] = {
-	{.compatible = "hisilicon,gpio_hubv1"},
+	{ .compatible = "hisilicon,gpio_hubv1" },
+	{ .compatible = "hisilicon,kirin970_hikey_usbhub" },
 	{}
 };
 MODULE_DEVICE_TABLE(of, id_table_hisi_hikey_usb);
-- 
2.26.2

