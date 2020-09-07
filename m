Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A447DC43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 16:03:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FFAE2080A
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 16:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599494616;
	bh=fBqDIBCosY6jOHB7XMMtIeL5J9D0ebJLl35D+xCMJOE=;
	h=From:Cc:Subject:Date:In-Reply-To:References:To:List-ID:From;
	b=ZbqlBcpLHqp0UPIQXCP93oJpGzbgsKagT5NA94N6VCoXAa7S7PNJc+QMAnHX4IyzR
	 NelyXA7/VwC3kfSNOZc5QSbTc3q8phNwgFKIGSuP+sRDLVb1UOHDDtDVBW16QjV0cn
	 9ocX9+mNTQBNwyD/Ziw5Vcq0VPHiCeThF8j9uv5Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729966AbgIGQDc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 12:03:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:56042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730237AbgIGP77 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 11:59:59 -0400
Received: from mail.kernel.org (ip5f5ad5cf.dynamic.kabel-deutschland.de [95.90.213.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5ADED21481;
        Mon,  7 Sep 2020 15:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599494379;
        bh=fBqDIBCosY6jOHB7XMMtIeL5J9D0ebJLl35D+xCMJOE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a/oYXJTJhz0MsqLus8zCoUN+HnefoimE743vPzF2wu5XV91iicyzMr2KY7nkU6rFQ
         Yx541b1z4ziyc6fDF+TtiEsZAG2UkEsiNxxS936cj445Di10fQaguv8wv4PjfqGw+6
         gfWdTv1hj4LNMtLdtoZckovaU9cvRr17bO1X59xQ=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kFJYP-00ATv2-EI; Mon, 07 Sep 2020 17:59:37 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Wei Xu <xuwei5@hisilicon.com>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 11/11] dts: hisilicon: add support for USB3 on Hikey 970
Date:   Mon,  7 Sep 2020 17:59:35 +0200
Message-Id: <3d67ad09724ea8ab39d17d083d971d404a26cf8b.1599493845.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1599493845.git.mchehab+huawei@kernel.org>
References: <cover.1599493845.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the USB3 bindings for Kirin 970 phy and Hikey 970 board.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../boot/dts/hisilicon/hi3670-hikey970.dts    | 102 ++++++++++++++++++
 arch/arm64/boot/dts/hisilicon/hi3670.dtsi     |  58 ++++++++++
 drivers/misc/hisi_hikey_usb.c                 |  29 ++---
 3 files changed, 167 insertions(+), 22 deletions(-)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts b/arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts
index f218acceec0b..744cdbb9867a 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts
+++ b/arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts
@@ -62,6 +62,29 @@ wlan_en: wlan-en-1-8v {
 		startup-delay-us = <70000>;
 		enable-active-high;
 	};
+	hikey_usbhub: hikey_usbhub {
+		compatible = "hisilicon,kirin970_hikey_usbhub";
+
+		typec-vbus-gpios = <&gpio26 1 0>;
+		otg-switch-gpios = <&gpio4 2 0>;
+		hub_reset_en_gpio = <&gpio0 3 0>;
+		hub-vdd-supply = <&ldo17>;
+		usb-role-switch;
+
+		port {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			hikey_usb_ep0: endpoint@0 {
+				reg = <0>;
+				remote-endpoint = <&dwc3_role_switch>;
+			};
+			hikey_usb_ep1: endpoint@1 {
+				reg = <1>;
+				remote-endpoint = <&rt1711h_ep>;
+			};
+		};
+	};
 };
 
 /*
@@ -440,6 +463,57 @@ &uart6 {
 	status = "okay";
 };
 
+&i2c1 {
+	status = "okay";
+
+	rt1711h: rt1711h@4e {
+		compatible = "richtek,rt1711h";
+		reg = <0x4e>;
+		status = "ok";
+		interrupt-parent = <&gpio27>;
+		interrupts = <5 IRQ_TYPE_LEVEL_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&usb_cfg_func>;
+
+		usb_con: connector {
+			compatible = "usb-c-connector";
+			label = "USB-C";
+			data-role = "dual";
+			power-role = "dual";
+			try-power-role = "sink";
+			source-pdos = <PDO_FIXED(5000, 500, PDO_FIXED_USB_COMM)>;
+			sink-pdos = <PDO_FIXED(5000, 500, PDO_FIXED_USB_COMM)
+				PDO_VAR(5000, 5000, 1000)>;
+			op-sink-microwatt = <10000000>;
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				port@1 {
+					reg = <1>;
+					usb_con_ss: endpoint {
+						remote-endpoint = <&dwc3_ss>;
+					};
+				};
+			};
+		};
+		port {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			rt1711h_ep: endpoint@0 {
+				reg = <0>;
+				remote-endpoint = <&hikey_usb_ep1>;
+			};
+		};
+	};
+};
+
+&i2c2 {
+	/* USB HUB is on this bus at address 0x44 */
+	status = "okay";
+};
+
 &i2c4 {
 	status = "okay";
 
@@ -469,3 +543,31 @@ adv7533_in: endpoint {
 		};
 	};
 };
+
+&dwc3 { /* USB */
+	dr_mode = "otg";
+	maximum-speed = "super-speed";
+	phy_type = "utmi";
+	snps,dis-del-phy-power-chg-quirk;
+	snps,dis_u2_susphy_quirk;
+	snps,dis_u3_susphy_quirk;
+	snps,tx_de_emphasis_quirk;
+	snps,tx_de_emphasis = <1>;
+	snps,dis-split-quirk;
+	snps,gctl-reset-quirk;
+	usb-role-switch;
+	role-switch-default-mode = "host";
+	port {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		dwc3_role_switch: endpoint@0 {
+			reg = <0>;
+			remote-endpoint = <&hikey_usb_ep0>;
+		};
+
+		dwc3_ss: endpoint@1 {
+			reg = <1>;
+			remote-endpoint = <&usb_con_ss>;
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/hisilicon/hi3670.dtsi b/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
index e2b2e21295a7..bd88a67ec4a9 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
@@ -8,6 +8,7 @@
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/clock/hi3670-clock.h>
+#include <dt-bindings/usb/pd.h>
 
 / {
 	compatible = "hisilicon,hi3670";
@@ -800,5 +801,62 @@ i2c4: i2c@fdf0d000 {
 			pinctrl-0 = <&i2c4_pmx_func &i2c4_cfg_func>;
 			status = "disabled";
 		};
+
+		usb3_otg_bc: usb3_otg_bc@ff200000 {
+			compatible = "syscon", "simple-mfd";
+			reg = <0x0 0xff200000 0x0 0x1000>;
+
+			usb_phy: usbphy {
+				compatible = "hisilicon,hi3670-usb-phy";
+				#phy-cells = <0>;
+				hisilicon,pericrg-syscon = <&crg_ctrl>;
+				hisilicon,pctrl-syscon = <&pctrl>;
+				hisilicon,sctrl-syscon = <&sctrl>;
+				hisilicon,eye-diagram-param = <0xFDFEE4>;
+				hisilicon,tx-vboost-lvl = <0x5>;
+
+				phy-supply = <&ldo17>;
+			};
+		};
+
+		usb31_misc_rst: usb31_misc_rst_controller {
+			compatible = "hisilicon,hi3660-reset";
+			#reset-cells = <2>;
+			hisi,rst-syscon = <&usb3_otg_bc>;
+		};
+
+		usb3: hisi_dwc3 {
+			compatible = "hisilicon,hi3670-dwc3";
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+
+			clocks = <&crg_ctrl HI3670_CLK_GATE_ABB_USB>,
+				  <&crg_ctrl HI3670_HCLK_GATE_USB3OTG>,
+				  <&crg_ctrl HI3670_CLK_GATE_USB3OTG_REF>,
+				  <&crg_ctrl HI3670_ACLK_GATE_USB3DVFS>;
+			clock-names = "clk_gate_abb_usb",
+				      "hclk_gate_usb3otg",
+				      "clk_gate_usb3otg_ref",
+				      "aclk_gate_usb3dvfs";
+
+			assigned-clocks = <&crg_ctrl HI3670_ACLK_GATE_USB3DVFS>;
+			assigned-clock-rates = <238000000>;
+			resets = <&crg_rst 0x90 6>,
+				 <&crg_rst 0x90 7>,
+				 <&usb31_misc_rst 0xA0 8>,
+				 <&usb31_misc_rst 0xA0 9>;
+
+			dwc3: dwc3@ff100000 {
+				compatible = "snps,dwc3";
+				reg = <0x0 0xff100000 0x0 0x100000>;
+
+				interrupts = <0 159 IRQ_TYPE_LEVEL_HIGH>,
+					    <0 161 IRQ_TYPE_LEVEL_HIGH>;
+
+				phys = <&usb_phy>;
+				phy-names = "usb3-phy";
+			};
+		};
 	};
 };
diff --git a/drivers/misc/hisi_hikey_usb.c b/drivers/misc/hisi_hikey_usb.c
index b884680867a5..2ddd4072788d 100644
--- a/drivers/misc/hisi_hikey_usb.c
+++ b/drivers/misc/hisi_hikey_usb.c
@@ -35,6 +35,7 @@ struct hisi_hikey_usb {
 	struct gpio_desc *otg_switch;
 	struct gpio_desc *typec_vbus;
 	struct gpio_desc *hub_vbus;
+	struct gpio_desc *reset;
 
 	struct regulator *regulator;
 
@@ -53,10 +54,8 @@ static void hub_power_ctrl(struct hisi_hikey_usb *hisi_hikey_usb, int value)
 {
 	int ret, status;
 
-	if (!hisi_hikey_usb->hub_vbus)
-		return;
-
-	gpiod_set_value_cansleep(hisi_hikey_usb->hub_vbus, value);
+	if (hisi_hikey_usb->hub_vbus)
+		gpiod_set_value_cansleep(hisi_hikey_usb->hub_vbus, value);
 
 	if (!hisi_hikey_usb->regulator)
 		return;
@@ -152,7 +151,6 @@ static int hisi_hikey_usb_parse_kirin970(struct platform_device *pdev,
 					 struct hisi_hikey_usb *hisi_hikey_usb)
 {
 	struct regulator *regulator;
-	int hub_reset_en_gpio;
 	int ret;
 
 	regulator = devm_regulator_get(&pdev->dev, "hub-vdd");
@@ -169,23 +167,10 @@ static int hisi_hikey_usb_parse_kirin970(struct platform_device *pdev,
 	}
 	hisi_hikey_usb->regulator = regulator;
 
-	hub_reset_en_gpio = of_get_named_gpio(pdev->dev.of_node,
-					      "hub_reset_en_gpio", 0);
-	if (!gpio_is_valid(hub_reset_en_gpio)) {
-		dev_err(&pdev->dev, "Failed to get a valid reset gpio\n");
-		return -ENODEV;
-	}
-
-	ret = devm_gpio_request(&pdev->dev, hub_reset_en_gpio,
-				"hub_reset_en_gpio");
-	if (ret) {
-		dev_err(&pdev->dev, "Failed to request the reset gpio\n");
-		return ret;
-	}
-	ret = gpio_direction_output(hub_reset_en_gpio, 1);
-	if (ret)
-		dev_err(&pdev->dev,
-			"Failed to set the direction of the reset gpio\n");
+	hisi_hikey_usb->reset = devm_gpiod_get(&pdev->dev, "hub_reset_en_gpio",
+					       GPIOD_OUT_HIGH);
+	if (IS_ERR(hisi_hikey_usb->reset))
+		return PTR_ERR(hisi_hikey_usb->reset);
 
 	return ret;
 }
-- 
2.26.2

