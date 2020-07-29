Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7B01C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 12:19:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF37620FC3
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 12:19:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbgG2MT4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 08:19:56 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:42632 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726385AbgG2MTy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 08:19:54 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 65131FB02;
        Wed, 29 Jul 2020 14:19:50 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 6Of1Xl1beATV; Wed, 29 Jul 2020 14:19:47 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 6CB2940382; Wed, 29 Jul 2020 14:19:45 +0200 (CEST)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Martin Kepplinger <martink@posteo.de>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        Anson Huang <Anson.Huang@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Li Jun <jun.li@nxp.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Li Yang <leoyang.li@nxp.com>, Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Walle <michael@walle.cc>,
        Olof Johansson <olof@lixom.net>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/3] arm64: dts: imx8mq: Add NWL MIPI DSI controller
Date:   Wed, 29 Jul 2020 14:19:43 +0200
Message-Id: <41adfe49c75d8bb261dc8d481e9bb537f6699cb4.1596025057.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1596025057.git.agx@sigxcpu.org>
References: <cover.1596025057.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a node for the Northwest Logic MIPI DSI IP core, "disabled" by
default. This also adds the necessary port to LCDIF.

Signed-off-by: Guido Günther <agx@sigxcpu.org>
---
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 49 +++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index f70435cf9ad5..e5fa77e1dfe7 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -523,6 +523,12 @@ lcdif: lcd-controller@30320000 {
 						  <&clk IMX8MQ_VIDEO_PLL1_OUT>;
 				assigned-clock-rates = <0>, <0>, <0>, <594000000>;
 				status = "disabled";
+
+				port@0 {
+					lcdif_mipi_dsi: endpoint {
+						remote-endpoint = <&mipi_dsi_lcdif_in>;
+					};
+				};
 			};
 
 			iomuxc: pinctrl@30330000 {
@@ -899,6 +905,49 @@ sec_jr2: jr@3000 {
 				};
 			};
 
+			mipi_dsi: mipi-dsi@30a00000 {
+				compatible = "fsl,imx8mq-nwl-dsi";
+				reg = <0x30a00000 0x300>;
+				clocks = <&clk IMX8MQ_CLK_DSI_CORE>,
+					 <&clk IMX8MQ_CLK_DSI_AHB>,
+					 <&clk IMX8MQ_CLK_DSI_IPG_DIV>,
+					 <&clk IMX8MQ_CLK_DSI_PHY_REF>,
+					 <&clk IMX8MQ_CLK_LCDIF_PIXEL>;
+				clock-names = "core", "rx_esc", "tx_esc", "phy_ref", "lcdif";
+				assigned-clocks = <&clk IMX8MQ_CLK_DSI_AHB>,
+						  <&clk IMX8MQ_CLK_DSI_CORE>,
+						  <&clk IMX8MQ_CLK_DSI_IPG_DIV>;
+				assigned-clock-parents = <&clk IMX8MQ_SYS1_PLL_80M>,
+							 <&clk IMX8MQ_SYS1_PLL_266M>;
+				assigned-clock-rates = <80000000>, <266000000>, <20000000>;
+				interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
+				mux-controls = <&mux 0>;
+				power-domains = <&pgc_mipi>;
+				phys = <&dphy>;
+				phy-names = "dphy";
+				resets = <&src IMX8MQ_RESET_MIPI_DSI_RESET_BYTE_N>,
+					 <&src IMX8MQ_RESET_MIPI_DSI_DPI_RESET_N>,
+					 <&src IMX8MQ_RESET_MIPI_DSI_ESC_RESET_N>,
+					 <&src IMX8MQ_RESET_MIPI_DSI_PCLK_RESET_N>;
+				reset-names = "byte", "dpi", "esc", "pclk";
+				status = "disabled";
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@0 {
+						reg = <0>;
+						#address-cells = <1>;
+						#size-cells = <0>;
+						mipi_dsi_lcdif_in: endpoint@0 {
+							reg = <0>;
+							remote-endpoint = <&lcdif_mipi_dsi>;
+						};
+					};
+				};
+			};
+
 			dphy: dphy@30a00300 {
 				compatible = "fsl,imx8mq-mipi-dphy";
 				reg = <0x30a00300 0x100>;
-- 
2.26.2

