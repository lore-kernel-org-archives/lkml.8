Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01FFEC433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 10:26:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C30CC2087C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 10:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599215161;
	bh=pey3giPbLXRnB0swkchdSd4oiTZHEN1wvZRMjYNNs+M=;
	h=From:Cc:Subject:Date:In-Reply-To:References:To:List-ID:From;
	b=n8I5XYsnFTJpPAoZ9bLv9UlGZSEeSndgZDBswRuZLFZLwMq+gDmnkI6Wd/ckqm0OJ
	 h0ei8i0li9HdZWMZAWZwAgSOvKXDi67suoOOkwr2ETES4tLSZFOqe1mONMTn/RqfT+
	 FZOzHhQNAQ5Sy++wrqTcdmf2AvjPgi6mIf6KCZh4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730192AbgIDKZ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 06:25:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:47814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730008AbgIDKXh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 06:23:37 -0400
Received: from mail.kernel.org (ip5f5ad59b.dynamic.kabel-deutschland.de [95.90.213.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2723C20DD4;
        Fri,  4 Sep 2020 10:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599215016;
        bh=pey3giPbLXRnB0swkchdSd4oiTZHEN1wvZRMjYNNs+M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MjrSeZi/HBpYcz0Kc2vpzD3YtJBGLJdy9Dq2raMSjxTkh4sm93KSCxjeFladzajy7
         KO9UEZQL6MBS+T4r5MyvcYSRzM5oA7fDQDqfSBt7xWn/oJvwuun19JKlgwFjXrlf1C
         v5+MMWAWaZfTlLaiQsQMx+IXpuINYYhZpnaKvp5w=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kE8sY-005SvQ-0O; Fri, 04 Sep 2020 12:23:34 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Wei Xu <xuwei5@hisilicon.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC 10/10] dts: hisilicon: add support for USB3 on Hikey 970
Date:   Fri,  4 Sep 2020 12:23:32 +0200
Message-Id: <d7243ff1fc200c948752da2577bcd5f606719d05.1599214329.git.mchehab+huawei@kernel.org>
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

Add the USB3 bindings for Kirin 970 phy and Hikey 970 board.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../boot/dts/hisilicon/hi3670-hikey970.dts    | 103 ++++++++++++++++++
 arch/arm64/boot/dts/hisilicon/hi3670.dtsi     |  49 +++++++++
 2 files changed, 152 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts b/arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts
index f218acceec0b..f1773e5ecaef 100644
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
 
@@ -469,3 +543,32 @@ adv7533_in: endpoint {
 		};
 	};
 };
+
+&dwc3 { /* USB */
+	dr_mode = "otg";
+	maximum-speed = "super-speed";
+	phy_type = "utmi";
+	snps,dis-del-phy-power-chg-quirk;
+	snps,lfps_filter_quirk;
+	snps,dis_u2_susphy_quirk;
+	snps,dis_u3_susphy_quirk;
+	snps,tx_de_emphasis_quirk;
+	snps,tx_de_emphasis = <1>;
+	snps,dis_enblslpm_quirk;
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
index e2b2e21295a7..bde3f5ece80c 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
@@ -8,6 +8,7 @@
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/clock/hi3670-clock.h>
+#include <dt-bindings/usb/pd.h>
 
 / {
 	compatible = "hisilicon,hi3670";
@@ -800,5 +801,53 @@ i2c4: i2c@fdf0d000 {
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
+			};
+		};
+
+		usb31_misc_rst: usb31_misc_rst_controller {
+			compatible = "hisilicon,hi3660-reset";
+			#reset-cells = <2>;
+			hisi,rst-syscon = <&usb3_otg_bc>;
+		};
+
+		dwc3: dwc3@ff100000 {
+			compatible = "snps,dwc3";
+			reg = <0x0 0xff100000 0x0 0x100000>;
+
+			clocks = <&crg_ctrl HI3670_CLK_GATE_ABB_USB>,
+				 <&crg_ctrl HI3670_HCLK_GATE_USB3OTG>,
+				 <&crg_ctrl HI3670_CLK_GATE_USB3OTG_REF>,
+				 <&crg_ctrl HI3670_ACLK_GATE_USB3DVFS>;
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
+			interrupts = <0 159 IRQ_TYPE_LEVEL_HIGH>,
+				     <0 161 IRQ_TYPE_LEVEL_HIGH>;
+
+			phys = <&usb_phy>;
+			phy-names = "usb3-phy";
+		};
 	};
 };
-- 
2.26.2

