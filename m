Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CFFEC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 08:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D83BB22B43
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 08:51:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbgHTIv5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 04:51:57 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:58914 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726885AbgHTIvG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 04:51:06 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id CA300FB02;
        Thu, 20 Aug 2020 10:51:02 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id jylzmjecNnoq; Thu, 20 Aug 2020 10:51:00 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 9254445678; Thu, 20 Aug 2020 10:50:59 +0200 (CEST)
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
Subject: [PATCH v2 1/4] arm64: dts: imx8mq: Add NWL MIPI DSI controller
Date:   Thu, 20 Aug 2020 10:50:56 +0200
Message-Id: <138346192af1adb1277269a3cbd542dff00ba4a3.1597913263.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1597913263.git.agx@sigxcpu.org>
References: <cover.1597913263.git.agx@sigxcpu.org>
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
Reviewed-by: Fabio Estevam <festevam@gmail.com>
---
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 49 +++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index f70435cf9ad57..e5fa77e1dfe71 100644
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

