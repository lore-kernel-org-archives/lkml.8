Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BF3CC3567B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 06:30:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 699AE20661
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 06:30:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbgBXGaw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 01:30:52 -0500
Received: from comms.puri.sm ([159.203.221.185]:46824 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726060AbgBXGaw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 01:30:52 -0500
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 01DB5E03AF;
        Sun, 23 Feb 2020 22:30:52 -0800 (PST)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id QO5qkPPxzVBj; Sun, 23 Feb 2020 22:30:51 -0800 (PST)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     robh@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de
Cc:     linux-imx@nxp.com, Anson.Huang@nxp.com, devicetree@vger.kernel.org,
        kernel@puri.sm, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH v3 1/8] arm64: dts: librem5-devkit: enable sai2 and sai6 audio interface
Date:   Mon, 24 Feb 2020 07:29:10 +0100
Message-Id: <20200224062917.4895-2-martin.kepplinger@puri.sm>
In-Reply-To: <20200224062917.4895-1-martin.kepplinger@puri.sm>
References: <20200224062917.4895-1-martin.kepplinger@puri.sm>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Angus Ainslie (Purism)" <angus@akkea.ca>

Add missing sai2 and sai6 audio interface and pinctrl definitions for the
Librem 5 devkit.

Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
---
 .../dts/freescale/imx8mq-librem5-devkit.dts   | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
index 007c14eec676..25135b08d4f8 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
@@ -567,6 +567,25 @@
 		>;
 	};
 
+	pinctrl_sai2: sai2grp {
+		fsl,pins = <
+			MX8MQ_IOMUXC_SAI2_TXFS_SAI2_TX_SYNC	0xd6
+			MX8MQ_IOMUXC_SAI2_TXC_SAI2_TX_BCLK	0xd6
+			MX8MQ_IOMUXC_SAI2_TXD0_SAI2_TX_DATA0	0xd6
+			MX8MQ_IOMUXC_SAI2_RXD0_SAI2_RX_DATA0	0xd6
+			MX8MQ_IOMUXC_SAI2_MCLK_SAI2_MCLK	0xd6
+		>;
+	};
+
+	pinctrl_sai6: sai6grp {
+		fsl,pins = <
+			MX8MQ_IOMUXC_SAI1_RXD5_SAI6_RX_DATA0	0xd6
+			MX8MQ_IOMUXC_SAI1_RXD6_SAI6_RX_SYNC	0xd6
+			MX8MQ_IOMUXC_SAI1_TXD4_SAI6_RX_BCLK     0xd6
+			MX8MQ_IOMUXC_SAI1_TXD5_SAI6_TX_DATA0	0xd6
+		>;
+	};
+
 	pinctrl_typec: typecgrp {
 		fsl,pins = <
 			MX8MQ_IOMUXC_NAND_DATA06_GPIO3_IO12		0x16
@@ -742,6 +761,25 @@
 	status = "okay";
 };
 
+&sai2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sai2>;
+	assigned-clocks = <&clk IMX8MQ_CLK_SAI2>;
+	assigned-clock-parents = <&clk IMX8MQ_AUDIO_PLL1_OUT>;
+	assigned-clock-rates = <24576000>;
+	status = "okay";
+};
+
+&sai6 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sai6>;
+	assigned-clocks = <&clk IMX8MQ_CLK_SAI6>;
+	assigned-clock-parents = <&clk IMX8MQ_AUDIO_PLL1_OUT>;
+	assigned-clock-rates = <24576000>;
+	fsl,sai-synchronous-rx;
+	status = "okay";
+};
+
 &uart1 { /* console */
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart1>;
-- 
2.20.1

