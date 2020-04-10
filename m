Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A08C2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 18:29:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0592B207FF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 18:29:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbgDJS3o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 14:29:44 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:46018 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726725AbgDJS3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 14:29:43 -0400
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 10 Apr 2020 11:29:40 -0700
Received: from sivaprak-linux.qualcomm.com ([10.201.3.202])
  by ironmsg03-sd.qualcomm.com with ESMTP; 10 Apr 2020 11:29:37 -0700
Received: by sivaprak-linux.qualcomm.com (Postfix, from userid 459349)
        id 625632168E; Fri, 10 Apr 2020 23:59:36 +0530 (IST)
From:   Sivaprakash Murugesan <sivaprak@codeaurora.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, kishon@ti.com,
        robh+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Sivaprakash Murugesan <sivaprak@codeaurora.org>,
        Balaji Prakash J <bjagadee@codeaurora.org>
Subject: [PATCH 3/3] arm64: dts: ipq8074: enable USB support
Date:   Fri, 10 Apr 2020 23:59:32 +0530
Message-Id: <1586543372-13969-4-git-send-email-sivaprak@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1586543372-13969-1-git-send-email-sivaprak@codeaurora.org>
References: <1586543372-13969-1-git-send-email-sivaprak@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IPQ8074 has two super speed usb ports, add phy and dwc3 nodes
to enable them.

Co-developed-by: Balaji Prakash J <bjagadee@codeaurora.org>
Signed-off-by: Balaji Prakash J <bjagadee@codeaurora.org>
Signed-off-by: Sivaprakash Murugesan <sivaprak@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/ipq8074-hk01.dts |  24 +++++
 arch/arm64/boot/dts/qcom/ipq8074.dtsi     | 168 ++++++++++++++++++++++++++++++
 2 files changed, 192 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq8074-hk01.dts b/arch/arm64/boot/dts/qcom/ipq8074-hk01.dts
index 70be3f9..dd27d84 100644
--- a/arch/arm64/boot/dts/qcom/ipq8074-hk01.dts
+++ b/arch/arm64/boot/dts/qcom/ipq8074-hk01.dts
@@ -26,6 +26,22 @@
 	};
 
 	soc {
+		ssphy@58000 {
+			status = "ok";
+		};
+
+		qusb@59000 {
+			status = "ok";
+		};
+
+		ssphy@78000 {
+			status = "ok";
+		};
+
+		qusb@79000 {
+			status = "ok";
+		};
+
 		serial@78b3000 {
 			status = "ok";
 		};
@@ -65,6 +81,14 @@
 			};
 		};
 
+		usb3@8A00000 {
+			status = "ok";
+		};
+
+		usb3@8C00000 {
+			status = "ok";
+		};
+
 		phy@86000 {
 			status = "ok";
 		};
diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
index 2b31823..47bb9ad 100644
--- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
@@ -16,6 +16,92 @@
 		ranges = <0 0 0 0xffffffff>;
 		compatible = "simple-bus";
 
+		ssphy_1: ssphy@58000 {
+			compatible = "qcom,ipq8074-qmp-usb3-phy";
+			reg = <0x00058000 0x1c4>;
+			status = "disabled";
+			#clock-cells = <1>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			clocks = <&gcc GCC_USB1_AUX_CLK>,
+				 <&gcc GCC_USB1_PHY_CFG_AHB_CLK>,
+				 <&xo>;
+			clock-names = "aux", "cfg_ahb", "ref";
+
+			resets =  <&gcc GCC_USB1_PHY_BCR>,
+				 <&gcc GCC_USB3PHY_1_PHY_BCR>;
+			reset-names = "phy","common";
+
+			usb1_ssphy: lane@58200 {
+				reg = <0x00058200 0x130>,	/* Tx */
+				      <0x00058400 0x200>,	/* Rx */
+				      <0x00058800 0x1F8>,	/* PCS  */
+				      <0x00058600 0x044>;	/* PCS misc */
+				#phy-cells = <0>;
+				clocks = <&gcc GCC_USB1_PIPE_CLK>;
+				clock-names = "pipe0";
+				clock-output-names = "gcc_usb1_pipe_clk_src";
+			};
+		};
+
+		qusb_phy_1: qusb@59000 {
+		    compatible = "qcom,msm8996-qusb2-phy";
+		    reg = <0x00059000 0x180>;
+		    status = "disabled";
+		    #phy-cells = <0>;
+
+		    clocks = <&gcc GCC_USB1_PHY_CFG_AHB_CLK>,
+			     <&xo>;
+		    clock-names = "cfg_ahb", "ref";
+
+		    resets = <&gcc GCC_QUSB2_1_PHY_BCR>;
+		};
+
+		ssphy_0: ssphy@78000 {
+			compatible = "qcom,ipq8074-qmp-usb3-phy";
+			reg = <0x00078000 0x1c4>;
+			status = "disabled";
+			#clock-cells = <1>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			clocks = <&gcc GCC_USB0_AUX_CLK>,
+				 <&gcc GCC_USB0_PHY_CFG_AHB_CLK>,
+				 <&xo>;
+			clock-names = "aux", "cfg_ahb", "ref";
+
+			resets =  <&gcc GCC_USB0_PHY_BCR>,
+				 <&gcc GCC_USB3PHY_0_PHY_BCR>;
+			reset-names = "phy","common";
+
+			usb0_ssphy: lane@78200 {
+				reg = <0x00078200 0x130>,	/* Tx */
+				      <0x00078400 0x200>,	/* Rx */
+				      <0x00078800 0x1F8>,	/* PCS  */
+				      <0x00078600 0x044>;	/* PCS misc */
+				#phy-cells = <0>;
+				clocks = <&gcc GCC_USB0_PIPE_CLK>;
+				clock-names = "pipe0";
+				clock-output-names = "gcc_usb0_pipe_clk_src";
+			};
+		};
+
+		qusb_phy_0: qusb@79000 {
+		    compatible = "qcom,msm8996-qusb2-phy";
+		    reg = <0x00079000 0x180>;
+		    status = "disabled";
+		    #phy-cells = <0>;
+
+		    clocks = <&gcc GCC_USB0_PHY_CFG_AHB_CLK>,
+			     <&xo>;
+		    clock-names = "cfg_ahb", "ref";
+
+		    resets = <&gcc GCC_QUSB2_0_PHY_BCR>;
+		};
+
 		tlmm: pinctrl@1000000 {
 			compatible = "qcom,ipq8074-pinctrl";
 			reg = <0x1000000 0x300000>;
@@ -272,6 +358,88 @@
 			status = "disabled";
 		};
 
+		usb3_0: usb3@8A00000 {
+			compatible = "qcom,dwc3";
+			reg = <0x08af8800 0x400>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			clocks = <&gcc GCC_SYS_NOC_USB0_AXI_CLK>,
+				<&gcc GCC_USB0_MASTER_CLK>,
+				<&gcc GCC_USB0_SLEEP_CLK>,
+				<&gcc GCC_USB0_MOCK_UTMI_CLK>;
+			clock-names = "sys_noc_axi",
+				"master",
+				"sleep",
+				"mock_utmi";
+
+			assigned-clocks = <&gcc GCC_SYS_NOC_USB0_AXI_CLK>,
+					  <&gcc GCC_USB0_MASTER_CLK>,
+					  <&gcc GCC_USB0_MOCK_UTMI_CLK>;
+			assigned-clock-rates = <133330000>,
+					       <133330000>,
+					       <19200000>;
+
+			resets = <&gcc GCC_USB0_BCR>;
+			status = "disabled";
+
+			dwc_0: dwc3@8A00000 {
+				compatible = "snps,dwc3";
+				reg = <0x8A00000 0xcd00>;
+				interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
+				phys = <&qusb_phy_0>, <&usb0_ssphy>;
+				phy-names = "usb2-phy", "usb3-phy";
+				tx-fifo-resize;
+				snps,is-utmi-l1-suspend;
+				snps,hird-threshold = /bits/ 8 <0x0>;
+				snps,dis_u2_susphy_quirk;
+				snps,dis_u3_susphy_quirk;
+				dr_mode = "host";
+			};
+		};
+
+		usb3_1: usb3@8C00000 {
+			compatible = "qcom,dwc3";
+			reg = <0x08cf8800 0x400>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			clocks = <&gcc GCC_SYS_NOC_USB1_AXI_CLK>,
+				<&gcc GCC_USB1_MASTER_CLK>,
+				<&gcc GCC_USB1_SLEEP_CLK>,
+				<&gcc GCC_USB1_MOCK_UTMI_CLK>;
+			clock-names = "sys_noc_axi",
+				"master",
+				"sleep",
+				"mock_utmi";
+
+			assigned-clocks = <&gcc GCC_SYS_NOC_USB1_AXI_CLK>,
+					  <&gcc GCC_USB1_MASTER_CLK>,
+					  <&gcc GCC_USB1_MOCK_UTMI_CLK>;
+			assigned-clock-rates = <133330000>,
+					       <133330000>,
+					       <19200000>;
+
+			resets = <&gcc GCC_USB1_BCR>;
+			status = "disabled";
+
+			dwc_1: dwc3@8C00000 {
+				compatible = "snps,dwc3";
+				reg = <0x8C00000 0xcd00>;
+				interrupts = <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>;
+				phys = <&qusb_phy_1>, <&usb1_ssphy>;
+				phy-names = "usb2-phy", "usb3-phy";
+				tx-fifo-resize;
+				snps,is-utmi-l1-suspend;
+				snps,hird-threshold = /bits/ 8 <0x0>;
+				snps,dis_u2_susphy_quirk;
+				snps,dis_u3_susphy_quirk;
+				dr_mode = "host";
+			};
+		};
+
 		pcie_phy0: phy@86000 {
 			compatible = "qcom,ipq8074-qmp-pcie-phy";
 			reg = <0x86000 0x1000>;
-- 
2.7.4

