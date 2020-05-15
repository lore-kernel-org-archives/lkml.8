Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85F0EC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 13:12:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E7DA206D4
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 13:12:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbgEONMn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 09:12:43 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:53552 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726261AbgEONM2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 09:12:28 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 34B2AFB06;
        Fri, 15 May 2020 15:12:25 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 0-lLz--REorz; Fri, 15 May 2020 15:12:23 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 8E898445A9; Fri, 15 May 2020 15:12:15 +0200 (CEST)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Anson Huang <Anson.Huang@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Peng Fan <peng.fan@nxp.com>,
        Robert Chiras <robert.chiras@nxp.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH 5/6] arm64: dts: imx8mq: Add NWL dsi controller
Date:   Fri, 15 May 2020 15:12:14 +0200
Message-Id: <6f915d10ead271a1c155628efbc909d5eb9f4102.1589548223.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <cover.1589548223.git.agx@sigxcpu.org>
References: <cover.1589548223.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a node for the Northwestlogic MIPI DSI IP core, "disabled" by
default.

Signed-off-by: Guido Günther <agx@sigxcpu.org>
---
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 31 +++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index 0142f06ead12..6bbbf44e6be0 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -889,6 +889,37 @@ sec_jr2: jr@3000 {
 				};
 			};
 
+			mipi_dsi: mipi-dsi@30a00000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
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
+				assigned-clock-rates = <80000000>,
+						       <266000000>,
+						       <20000000>;
+				interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
+				resets = <&src IMX8MQ_RESET_MIPI_DSI_RESET_BYTE_N>,
+					 <&src IMX8MQ_RESET_MIPI_DSI_DPI_RESET_N>,
+					 <&src IMX8MQ_RESET_MIPI_DSI_ESC_RESET_N>,
+					 <&src IMX8MQ_RESET_MIPI_DSI_PCLK_RESET_N>;
+				reset-names = "byte", "dpi", "esc", "pclk";
+				phys = <&dphy>;
+				phy-names = "dphy";
+				power-domains = <&pgc_mipi>;
+				status = "disabled";
+			 };
+
 			dphy: dphy@30a00300 {
 				compatible = "fsl,imx8mq-mipi-dphy";
 				reg = <0x30a00300 0x100>;
-- 
2.26.1

