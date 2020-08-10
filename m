Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69891C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 16:35:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C28C207DE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 16:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597077313;
	bh=6XZCNzTvPDPpAJipzV4KMM4oXZn8UErU3tUeLjJnPCk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=GGC4c0hVZw2uvEd9L2QZYNyEpswuh0rCOHdlru3U1lur6SOAwhEwP1/QdruDhVH/7
	 VJLAGtLxurZnqvWCYUQRRjo6cBnIXnK2//u98BTUO+NOAhSF83ePkKoXfAfzIZfI1j
	 YV5/UPKdU1gavEMIRlpB7gAko3ici7UgvlTO+PHE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbgHJQfM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 12:35:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:33438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725873AbgHJQfL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 12:35:11 -0400
Received: from coco.lan (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BAAF52076B;
        Mon, 10 Aug 2020 16:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597077310;
        bh=6XZCNzTvPDPpAJipzV4KMM4oXZn8UErU3tUeLjJnPCk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=zpYCuMyjNm7ScaxBAs25N/CLxoq1R0aZYc8lhma9LfjkEOo9r1Gyzj5PvFJTv8lPm
         q1z+PvbVM5lydCLNJrwkyolBlLqz183vQ6vTcg9sgBJ/UoISGsXAQNwXgemNBVSjTq
         BNpBRXVMrWpcxsk8oVaVLFw8Nq22ya/EA1Ubr5Vc=
Date:   Mon, 10 Aug 2020 18:35:03 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>, Yu Chen <chenyu56@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        ShuFan Lee <shufan_lee@richtek.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Felipe Balbi <balbi@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jun Li <lijun.kernel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Jack Pham <jackp@codeaurora.org>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [RFC][PATCH v3 11/11] misc: hisi_hikey_usb: Driver to support
 usb functionality of Hikey960
Message-ID: <20200810183503.3e8bae80@coco.lan>
In-Reply-To: <20191016033340.1288-12-john.stultz@linaro.org>
References: <20191016033340.1288-1-john.stultz@linaro.org>
        <20191016033340.1288-12-john.stultz@linaro.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

Em Wed, 16 Oct 2019 03:33:40 +0000
John Stultz <john.stultz@linaro.org> escreveu:

> From: Yu Chen <chenyu56@huawei.com>
> 
> The HiKey960 has a fairly complex USB configuration due to it
> needing to support a USB-C port for host/device mode and multiple
> USB-A ports in host mode using a single USB controller.
> 
> See schematics here:
>   https://github.com/96boards/documentation/raw/master/consumer/hikey/hikey960/hardware-docs/HiKey960_Schematics.pdf
> 
> This driver acts as a usb-role-switch intermediary, intercepting
> the role switch notifications from the tcpm code, and passing
> them on to the dwc3 core.
> 
> In doing so, it also controls the onboard hub and power gpios in
> order to properly route the data lines between the USB-C port
> and the onboard hub to the USB-A ports.
> 
> NOTE: It was noted that controlling the TYPEC_VBUS_POWER_OFF and
> TYPEC_VBUS_POWER_ON values here is not reccomended. I'm looking
> for a way to remove that bit from the logic here, but wanted to
> still get feedback on this approach.

Let me somewhat hijack this thread. I'm trying to add support here
for the Hikey 970 driver. Maybe you might help me finding the remaing
issues over there ;-)

The Hikey 970 has lots of things in common with Hikey 960, but
the USB hub uses a somewhat different approach (based on what I
saw at the Linaro's 4.9 official Hikey kernel tree).

Basically, with the enclosed patch applied, the USB hub needs these
at the DT file:

		hikey_usbhub: hikey_usbhub {
			compatible = "hisilicon,kirin970_hikey_usbhub";

			typec-vbus-gpios = <&gpio26 1 0>;
			otg-switch-gpios = <&gpio4 2 0>;
			hub_reset_en_gpio = <&gpio0 3 0>;
			hub-vdd-supply = <&ldo17>;
			usb-role-switch;
...
		}

E.g. when compared with Hikey 960, the USB hub:

- Hikey 970 uses a regulator instead of GPIO for powering on;
- Hikey 970 has a reset pin controlled via GPIO.

It should be simple to add support for it, as done by the
enclosed patch. With this, the phy driver for Hikey 970 and a new
small driver to properly set clocks and reset lines at dwg3[1],
I can now see the hub on my Hikey970:

	$ lsusb
	Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
	Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub

Still, I'm missing something to make it work, as, besides the hub,
right now, it doesn't detect the keyboard/mouse, which are
attached at the USB hub.

Do you have any ideas?

-

[1] Right now, this is needed:
	https://github.com/96boards-hikey/linux/blob/hikey970-v4.9/drivers/usb/dwc3/dwc3-hisi.c

    Placing dwc3 directly under soc at DT causes some weird NMI, with
    either produce an OOPS or hangs the machine at boot time.

Thanks,
Mauro

[PATCH] misc: hisi_hikey_usb: add support for Hikey 970

The HiKey 970 board uses a voltage regulator and GPIO reset pin.

Add support for them.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

diff --git a/drivers/misc/hisi_hikey_usb.c b/drivers/misc/hisi_hikey_usb.c
index 3a98a890757c..76eb38fc6169 100644
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
 
@@ -46,18 +48,27 @@ struct hisi_hikey_usb {
 
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
 
@@ -117,31 +128,89 @@ static int hub_usb_role_switch_set(struct usb_role_switch *sw, enum usb_role rol
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
+				"waiting for hub-vdd-supply to be probed\n");
+			return PTR_ERR(regulator);
+		} else {
+			/* let it fall back to regulator dummy */
+			regulator = devm_regulator_get(&pdev->dev, "hub-vdd");
+			if (IS_ERR(regulator)) {
+				dev_err(&pdev->dev,
+					"get hub-vdd-supply failed with error %ld\n",
+					PTR_ERR(regulator));
+				return PTR_ERR(regulator);
+			}
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
+	/* Parse Kirin 970-specific OF data */
+	if (of_device_is_compatible(pdev->dev.of_node,
+				    "hisilicon,kirin970_hikey_usbhub")) {
+		ret = hisi_hikey_usb_parse_kirin970(pdev);
+		if (ret)
+			return ret;
+	} else {
+		hisi_hikey_usb->typec_vbus = devm_gpiod_get(dev, "typec-vbus",
+							    GPIOD_OUT_LOW);
+		if (IS_ERR(hisi_hikey_usb->typec_vbus))
+			return PTR_ERR(hisi_hikey_usb->typec_vbus);
+
+		/* hub-vdd33-en is optional */
+		hisi_hikey_usb->hub_vbus = devm_gpiod_get_optional(dev, "hub-vdd33-en",
+								GPIOD_OUT_HIGH);
+		if (IS_ERR(hisi_hikey_usb->hub_vbus))
+			return PTR_ERR(hisi_hikey_usb->hub_vbus);
+	}
 
 	hisi_hikey_usb->dev_role_sw = usb_role_switch_get(dev);
 	if (!hisi_hikey_usb->dev_role_sw)
@@ -185,6 +254,7 @@ static int  hisi_hikey_usb_remove(struct platform_device *pdev)
 
 static const struct of_device_id id_table_hisi_hikey_usb[] = {
 	{.compatible = "hisilicon,gpio_hubv1"},
+	{.compatible = "hisilicon,kirin970_hikey_usbhub"},
 	{}
 };
 MODULE_DEVICE_TABLE(of, id_table_hisi_hikey_usb);


