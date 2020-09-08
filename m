Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AB1EC43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 10:29:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B7EE20672
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 10:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599560978;
	bh=v986rMUujLtAYH4XtVN8kT1oQMpdWzEEsRt+9wPVsZ4=;
	h=From:Cc:Subject:Date:In-Reply-To:References:To:List-ID:From;
	b=2I+XAIoYX2E/V6nKuUBXEFIW1Vh6P6uuUbsFXB6xBRTEOjCwTCHIEFLfrqFtwtILV
	 8f0ESGJiRZRpAZd/FOfBudmnW/P+gcgPM1kj/s8BQTwOcIfVCKV9fnApx5IejHiAAN
	 vdjZPpEy8SP5e0ELrp64b74gSHt6H7pIiMHORKDQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730068AbgIHK3g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 06:29:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:38674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729967AbgIHK3K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 06:29:10 -0400
Received: from mail.kernel.org (ip5f5ad5ce.dynamic.kabel-deutschland.de [95.90.213.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3FD9720C09;
        Tue,  8 Sep 2020 10:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599560940;
        bh=v986rMUujLtAYH4XtVN8kT1oQMpdWzEEsRt+9wPVsZ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tH+fh1WOUj4NgOm7HE1yq5pQC4mMfpKXriI05uxcd11lB7pAcFjRaCFYi1j9yR2GA
         5OVeVYnRKr77TbMQ7OA7ljHMOedmsDQpRbQCNXrHvAmX7r0K7i3s3veSkFKKCnVt54
         ZTW5na0oj1nJaDyx09jgMcT9OzrPQ4/VEjboBdbU=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kFary-00B3yV-BQ; Tue, 08 Sep 2020 12:28:58 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Wei Xu <xuwei5@hisilicon.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 10/10] dts: hisilicon: add support for USB3 on Hikey 970
Date:   Tue,  8 Sep 2020 12:28:44 +0200
Message-Id: <80e2067c77dcd8188c65e1d079b1aee5245db194.1599559318.git.mchehab+huawei@kernel.org>
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

Add the USB3 bindings for Kirin 970 phy and Hikey 970 board.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../boot/dts/hisilicon/hi3670-hikey970.dts    | 102 ++++++++++++++++++
 arch/arm64/boot/dts/hisilicon/hi3670.dtsi     |  58 ++++++++++
 2 files changed, 160 insertions(+)

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
-- 
2.26.2

