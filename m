Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7A24C43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 10:24:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8495E2084D
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 10:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599215054;
	bh=6IXWhPGvu8yRQir4Z/5ykOTtGV9+rK9G9jeSLNPy89g=;
	h=From:Cc:Subject:Date:In-Reply-To:References:To:List-ID:From;
	b=bBUbKr8eBD9aOXwnYvuDY0pU4eDHaUUx+oaeisbik+f1b5ZgklD7bkdVPQQiJR+kV
	 +UdRxXMCRaMUCSEvciulAnCIKtPYdNiI/XVGQ3RsPl45h9pXvHRSDZdXhjle7iMjQj
	 pOnKhJsUbq8zOLpQyZkkOUoJeiV38BPfgO6/YJFI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730089AbgIDKYM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 06:24:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:47812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730006AbgIDKXh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 06:23:37 -0400
Received: from mail.kernel.org (ip5f5ad59b.dynamic.kabel-deutschland.de [95.90.213.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20A982098B;
        Fri,  4 Sep 2020 10:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599215016;
        bh=6IXWhPGvu8yRQir4Z/5ykOTtGV9+rK9G9jeSLNPy89g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VeP+xObZD7hTQtn9C1a9CFlGCnCEc+p2bOhTuWC04UVrGpeafwd1YHvlM4MZaDkq+
         HBwRqWJbC+kqU3FqcJM9rO0P/XoNhwmFBOqb3hsebeoL/YM743mMakyJD/SFm92NfF
         YWhNLgNArwo1oEOX0CUfrO4cPyab4XztTOAiaGxo=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kE8sX-005SvO-Uz; Fri, 04 Sep 2020 12:23:33 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: [RFC 09/10] misc: hisi_hikey_usb: add support for Hikey 970
Date:   Fri,  4 Sep 2020 12:23:31 +0200
Message-Id: <f45f7663b694b16214604b55527f38eb9232f95b.1599214329.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1599214329.git.mchehab+huawei@kernel.org>
References: <cover.1599214329.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The HiKey 970 board uses a voltage regulator and GPIO reset pin.

Add support for them.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/misc/hisi_hikey_usb.c | 97 +++++++++++++++++++++++++++++------
 1 file changed, 82 insertions(+), 15 deletions(-)

diff --git a/drivers/misc/hisi_hikey_usb.c b/drivers/misc/hisi_hikey_usb.c
index 3a98a890757c..3b08ca880151 100644
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
 
@@ -46,23 +48,30 @@ struct hisi_hikey_usb {
 
 static void hub_power_ctrl(struct hisi_hikey_usb *hisi_hikey_usb, int value)
 {
+	if (!hisi_hikey_usb->hub_vbus)
+		return;
+
 	gpiod_set_value_cansleep(hisi_hikey_usb->hub_vbus, value);
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
@@ -117,31 +126,89 @@ static int hub_usb_role_switch_set(struct usb_role_switch *sw, enum usb_role rol
 	return 0;
 }
 
+static int hisi_hikey_usb_parse_kirin970(struct platform_device *pdev)
+{
+	struct regulator *regulator;
+	int hub_reset_en_gpio;
+	int ret;
+
+	regulator = devm_regulator_get_optional(&pdev->dev, "hub-vdd");
+	if (IS_ERR(regulator)) {
+		if (PTR_ERR(regulator) == -EPROBE_DEFER) {
+			dev_info(&pdev->dev,
+				 "waiting for hub-vdd-supply to be probed\n");
+			return PTR_ERR(regulator);
+		}
+
+		/* let it fall back to regulator dummy */
+		regulator = devm_regulator_get(&pdev->dev, "hub-vdd");
+		if (IS_ERR(regulator)) {
+			dev_err(&pdev->dev,
+				"get hub-vdd-supply failed with error %ld\n",
+				PTR_ERR(regulator));
+			return PTR_ERR(regulator);
+		}
+	}
+
+	ret = regulator_set_voltage(regulator, 3300000, 3300000);
+	if (ret)
+		dev_err(&pdev->dev, "set hub-vdd-supply voltage failed\n");
+
+	hub_reset_en_gpio = of_get_named_gpio(pdev->dev.of_node,
+					      "hub_reset_en_gpio", 0);
+	if (!gpio_is_valid(hub_reset_en_gpio)) {
+		dev_err(&pdev->dev, "Failed to get a valid reset gpio\n");
+		return -ENODEV;
+	}
+
+	ret = devm_gpio_request(&pdev->dev, hub_reset_en_gpio,
+				"hub_reset_en_gpio");
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to request the reset gpio\n");
+		return ret;
+	}
+	ret = gpio_direction_output(hub_reset_en_gpio, 1);
+	if (ret)
+		dev_err(&pdev->dev,
+			"Failed to set the direction of the reset gpio\n");
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
-
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
+		ret = hisi_hikey_usb_parse_kirin970(pdev);
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
@@ -149,7 +216,6 @@ static int hisi_hikey_usb_probe(struct platform_device *pdev)
 	if (IS_ERR(hisi_hikey_usb->dev_role_sw))
 		return PTR_ERR(hisi_hikey_usb->dev_role_sw);
 
-
 	INIT_WORK(&hisi_hikey_usb->work, relay_set_role_switch);
 	mutex_init(&hisi_hikey_usb->lock);
 
@@ -158,7 +224,7 @@ static int hisi_hikey_usb_probe(struct platform_device *pdev)
 	hub_role_switch.driver_data = hisi_hikey_usb;
 
 	hisi_hikey_usb->hub_role_sw = usb_role_switch_register(dev,
-							&hub_role_switch);
+							       &hub_role_switch);
 
 	if (IS_ERR(hisi_hikey_usb->hub_role_sw)) {
 		usb_role_switch_put(hisi_hikey_usb->dev_role_sw);
@@ -184,7 +250,8 @@ static int  hisi_hikey_usb_remove(struct platform_device *pdev)
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

