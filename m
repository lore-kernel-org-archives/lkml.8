Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F6B8C55194
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 09:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DE0820700
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 09:13:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbgDXJN4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 05:13:56 -0400
Received: from inva020.nxp.com ([92.121.34.13]:58404 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726383AbgDXJN4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 05:13:56 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 3BDBE1A02C6;
        Fri, 24 Apr 2020 11:13:51 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 419AE1A02B4;
        Fri, 24 Apr 2020 11:13:46 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 4F466402C7;
        Fri, 24 Apr 2020 17:13:40 +0800 (SGT)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        shengjiu.wang@nxp.com, Anson.Huang@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: freescale: imx8mp: update input_val for AUDIOMIX_BIT_STREAM
Date:   Fri, 24 Apr 2020 17:05:15 +0800
Message-Id: <1587719115-28728-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update input_val for AUDIOMIX_BIT_STREAM according to latest RM.

Fixes: 6d9b8d20431f ("arm64: dts: freescale: Add i.MX8MP dtsi support")
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 .../arm64/boot/dts/freescale/imx8mp-pinfunc.h | 46 +++++++++----------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-pinfunc.h b/arch/arm64/boot/dts/freescale/imx8mp-pinfunc.h
index da78f89b6c98..319ab34cab3e 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-pinfunc.h
+++ b/arch/arm64/boot/dts/freescale/imx8mp-pinfunc.h
@@ -151,26 +151,26 @@
 #define MX8MP_IOMUXC_ENET_TXC__SIM_M_HADDR22                         0x070 0x2D0 0x000 0x7 0x0
 #define MX8MP_IOMUXC_ENET_RX_CTL__ENET_QOS_RGMII_RX_CTL              0x074 0x2D4 0x000 0x0 0x0
 #define MX8MP_IOMUXC_ENET_RX_CTL__AUDIOMIX_SAI7_TX_SYNC              0x074 0x2D4 0x540 0x2 0x0
-#define MX8MP_IOMUXC_ENET_RX_CTL__AUDIOMIX_BIT_STREAM03              0x074 0x2D4 0x4CC 0x3 0x0
+#define MX8MP_IOMUXC_ENET_RX_CTL__AUDIOMIX_BIT_STREAM03              0x074 0x2D4 0x4CC 0x3 0x1
 #define MX8MP_IOMUXC_ENET_RX_CTL__GPIO1_IO24                         0x074 0x2D4 0x000 0x5 0x0
 #define MX8MP_IOMUXC_ENET_RX_CTL__USDHC3_DATA2                       0x074 0x2D4 0x618 0x6 0x0
 #define MX8MP_IOMUXC_ENET_RX_CTL__SIM_M_HADDR23                      0x074 0x2D4 0x000 0x7 0x0
 #define MX8MP_IOMUXC_ENET_RXC__CCM_ENET_QOS_CLOCK_GENERATE_RX_CLK    0x078 0x2D8 0x000 0x0 0x0
 #define MX8MP_IOMUXC_ENET_RXC__ENET_QOS_RX_ER                        0x078 0x2D8 0x000 0x1 0x0
 #define MX8MP_IOMUXC_ENET_RXC__AUDIOMIX_SAI7_TX_BCLK                 0x078 0x2D8 0x53C 0x2 0x0
-#define MX8MP_IOMUXC_ENET_RXC__AUDIOMIX_BIT_STREAM02                 0x078 0x2D8 0x4C8 0x3 0x0
+#define MX8MP_IOMUXC_ENET_RXC__AUDIOMIX_BIT_STREAM02                 0x078 0x2D8 0x4C8 0x3 0x1
 #define MX8MP_IOMUXC_ENET_RXC__GPIO1_IO25                            0x078 0x2D8 0x000 0x5 0x0
 #define MX8MP_IOMUXC_ENET_RXC__USDHC3_DATA3                          0x078 0x2D8 0x61C 0x6 0x0
 #define MX8MP_IOMUXC_ENET_RXC__SIM_M_HADDR24                         0x078 0x2D8 0x000 0x7 0x0
 #define MX8MP_IOMUXC_ENET_RD0__ENET_QOS_RGMII_RD0                    0x07C 0x2DC 0x000 0x0 0x0
 #define MX8MP_IOMUXC_ENET_RD0__AUDIOMIX_SAI7_RX_DATA00               0x07C 0x2DC 0x534 0x2 0x0
-#define MX8MP_IOMUXC_ENET_RD0__AUDIOMIX_BIT_STREAM01                 0x07C 0x2DC 0x4C4 0x3 0x0
+#define MX8MP_IOMUXC_ENET_RD0__AUDIOMIX_BIT_STREAM01                 0x07C 0x2DC 0x4C4 0x3 0x1
 #define MX8MP_IOMUXC_ENET_RD0__GPIO1_IO26                            0x07C 0x2DC 0x000 0x5 0x0
 #define MX8MP_IOMUXC_ENET_RD0__USDHC3_DATA4                          0x07C 0x2DC 0x620 0x6 0x0
 #define MX8MP_IOMUXC_ENET_RD0__SIM_M_HADDR25                         0x07C 0x2DC 0x000 0x7 0x0
 #define MX8MP_IOMUXC_ENET_RD1__ENET_QOS_RGMII_RD1                    0x080 0x2E0 0x000 0x0 0x0
 #define MX8MP_IOMUXC_ENET_RD1__AUDIOMIX_SAI7_RX_SYNC                 0x080 0x2E0 0x538 0x2 0x0
-#define MX8MP_IOMUXC_ENET_RD1__AUDIOMIX_BIT_STREAM00                 0x080 0x2E0 0x4C0 0x3 0x0
+#define MX8MP_IOMUXC_ENET_RD1__AUDIOMIX_BIT_STREAM00                 0x080 0x2E0 0x4C0 0x3 0x1
 #define MX8MP_IOMUXC_ENET_RD1__GPIO1_IO27                            0x080 0x2E0 0x000 0x5 0x0
 #define MX8MP_IOMUXC_ENET_RD1__USDHC3_RESET_B                        0x080 0x2E0 0x000 0x6 0x0
 #define MX8MP_IOMUXC_ENET_RD1__SIM_M_HADDR26                         0x080 0x2E0 0x000 0x7 0x0
@@ -291,7 +291,7 @@
 #define MX8MP_IOMUXC_SD2_DATA0__I2C4_SDA                             0x0C8 0x328 0x5C0 0x2 0x1
 #define MX8MP_IOMUXC_SD2_DATA0__UART2_DCE_RX                         0x0C8 0x328 0x5F0 0x3 0x2
 #define MX8MP_IOMUXC_SD2_DATA0__UART2_DTE_TX                         0x0C8 0x328 0x000 0x3 0x0
-#define MX8MP_IOMUXC_SD2_DATA0__AUDIOMIX_BIT_STREAM00                0x0C8 0x328 0x4C0 0x4 0x1
+#define MX8MP_IOMUXC_SD2_DATA0__AUDIOMIX_BIT_STREAM00                0x0C8 0x328 0x4C0 0x4 0x2
 #define MX8MP_IOMUXC_SD2_DATA0__GPIO2_IO15                           0x0C8 0x328 0x000 0x5 0x0
 #define MX8MP_IOMUXC_SD2_DATA0__CCMSRCGPCMIX_OBSERVE2                0x0C8 0x328 0x000 0x6 0x0
 #define MX8MP_IOMUXC_SD2_DATA0__OBSERVE_MUX_OUT02                    0x0C8 0x328 0x000 0x7 0x0
@@ -313,7 +313,7 @@
 #define MX8MP_IOMUXC_SD2_DATA3__USDHC2_DATA3                         0x0D4 0x334 0x000 0x0 0x0
 #define MX8MP_IOMUXC_SD2_DATA3__ECSPI2_MISO                          0x0D4 0x334 0x56C 0x2 0x0
 #define MX8MP_IOMUXC_SD2_DATA3__AUDIOMIX_SPDIF_IN                    0x0D4 0x334 0x544 0x3 0x1
-#define MX8MP_IOMUXC_SD2_DATA3__AUDIOMIX_BIT_STREAM03                0x0D4 0x334 0x4CC 0x4 0x1
+#define MX8MP_IOMUXC_SD2_DATA3__AUDIOMIX_BIT_STREAM03                0x0D4 0x334 0x4CC 0x4 0x2
 #define MX8MP_IOMUXC_SD2_DATA3__GPIO2_IO18                           0x0D4 0x334 0x000 0x5 0x0
 #define MX8MP_IOMUXC_SD2_DATA3__CCMSRCGPCMIX_EARLY_RESET             0x0D4 0x334 0x000 0x6 0x0
 #define MX8MP_IOMUXC_SD2_RESET_B__USDHC2_RESET_B                     0x0D8 0x338 0x000 0x0 0x0
@@ -487,27 +487,27 @@
 #define MX8MP_IOMUXC_SAI5_RXD0__AUDIOMIX_SAI1_TX_DATA02              0x134 0x394 0x000 0x1 0x0
 #define MX8MP_IOMUXC_SAI5_RXD0__PWM2_OUT                             0x134 0x394 0x000 0x2 0x0
 #define MX8MP_IOMUXC_SAI5_RXD0__I2C5_SCL                             0x134 0x394 0x5C4 0x3 0x1
-#define MX8MP_IOMUXC_SAI5_RXD0__AUDIOMIX_BIT_STREAM00                0x134 0x394 0x4C0 0x4 0x2
+#define MX8MP_IOMUXC_SAI5_RXD0__AUDIOMIX_BIT_STREAM00                0x134 0x394 0x4C0 0x4 0x3
 #define MX8MP_IOMUXC_SAI5_RXD0__GPIO3_IO21                           0x134 0x394 0x000 0x5 0x0
 #define MX8MP_IOMUXC_SAI5_RXD1__AUDIOMIX_SAI5_RX_DATA01              0x138 0x398 0x4FC 0x0 0x0
 #define MX8MP_IOMUXC_SAI5_RXD1__AUDIOMIX_SAI1_TX_DATA03              0x138 0x398 0x000 0x1 0x0
 #define MX8MP_IOMUXC_SAI5_RXD1__AUDIOMIX_SAI1_TX_SYNC                0x138 0x398 0x4D8 0x2 0x0
 #define MX8MP_IOMUXC_SAI5_RXD1__AUDIOMIX_SAI5_TX_SYNC                0x138 0x398 0x510 0x3 0x0
-#define MX8MP_IOMUXC_SAI5_RXD1__AUDIOMIX_BIT_STREAM01                0x138 0x398 0x4C4 0x4 0x2
+#define MX8MP_IOMUXC_SAI5_RXD1__AUDIOMIX_BIT_STREAM01                0x138 0x398 0x4C4 0x4 0x3
 #define MX8MP_IOMUXC_SAI5_RXD1__GPIO3_IO22                           0x138 0x398 0x000 0x5 0x0
 #define MX8MP_IOMUXC_SAI5_RXD1__CAN1_TX                              0x138 0x398 0x000 0x6 0x0
 #define MX8MP_IOMUXC_SAI5_RXD2__AUDIOMIX_SAI5_RX_DATA02              0x13C 0x39C 0x500 0x0 0x0
 #define MX8MP_IOMUXC_SAI5_RXD2__AUDIOMIX_SAI1_TX_DATA04              0x13C 0x39C 0x000 0x1 0x0
 #define MX8MP_IOMUXC_SAI5_RXD2__AUDIOMIX_SAI1_TX_SYNC                0x13C 0x39C 0x4D8 0x2 0x1
 #define MX8MP_IOMUXC_SAI5_RXD2__AUDIOMIX_SAI5_TX_BCLK                0x13C 0x39C 0x50C 0x3 0x0
-#define MX8MP_IOMUXC_SAI5_RXD2__AUDIOMIX_BIT_STREAM02                0x13C 0x39C 0x4C8 0x4 0x2
+#define MX8MP_IOMUXC_SAI5_RXD2__AUDIOMIX_BIT_STREAM02                0x13C 0x39C 0x4C8 0x4 0x3
 #define MX8MP_IOMUXC_SAI5_RXD2__GPIO3_IO23                           0x13C 0x39C 0x000 0x5 0x0
 #define MX8MP_IOMUXC_SAI5_RXD2__CAN1_RX                              0x13C 0x39C 0x54C 0x6 0x0
 #define MX8MP_IOMUXC_SAI5_RXD3__AUDIOMIX_SAI5_RX_DATA03              0x140 0x3A0 0x504 0x0 0x0
 #define MX8MP_IOMUXC_SAI5_RXD3__AUDIOMIX_SAI1_TX_DATA05              0x140 0x3A0 0x000 0x1 0x0
 #define MX8MP_IOMUXC_SAI5_RXD3__AUDIOMIX_SAI1_TX_SYNC                0x140 0x3A0 0x4D8 0x2 0x2
 #define MX8MP_IOMUXC_SAI5_RXD3__AUDIOMIX_SAI5_TX_DATA00              0x140 0x3A0 0x000 0x3 0x0
-#define MX8MP_IOMUXC_SAI5_RXD3__AUDIOMIX_BIT_STREAM03                0x140 0x3A0 0x4CC 0x4 0x2
+#define MX8MP_IOMUXC_SAI5_RXD3__AUDIOMIX_BIT_STREAM03                0x140 0x3A0 0x4CC 0x4 0x3
 #define MX8MP_IOMUXC_SAI5_RXD3__GPIO3_IO24                           0x140 0x3A0 0x000 0x5 0x0
 #define MX8MP_IOMUXC_SAI5_RXD3__CAN2_TX                              0x140 0x3A0 0x000 0x6 0x0
 #define MX8MP_IOMUXC_SAI5_MCLK__AUDIOMIX_SAI5_MCLK                   0x144 0x3A4 0x4F0 0x0 0x0
@@ -528,22 +528,22 @@
 #define MX8MP_IOMUXC_SAI1_RXD0__AUDIOMIX_SAI1_RX_DATA00              0x150 0x3B0 0x000 0x0 0x0
 #define MX8MP_IOMUXC_SAI1_RXD0__AUDIOMIX_SAI5_RX_DATA00              0x150 0x3B0 0x4F8 0x1 0x1
 #define MX8MP_IOMUXC_SAI1_RXD0__AUDIOMIX_SAI1_TX_DATA01              0x150 0x3B0 0x000 0x2 0x0
-#define MX8MP_IOMUXC_SAI1_RXD0__AUDIOMIX_BIT_STREAM00                0x150 0x3B0 0x4C0 0x3 0x3
+#define MX8MP_IOMUXC_SAI1_RXD0__AUDIOMIX_BIT_STREAM00                0x150 0x3B0 0x4C0 0x3 0x4
 #define MX8MP_IOMUXC_SAI1_RXD0__ENET1_1588_EVENT1_IN                 0x150 0x3B0 0x000 0x4 0x0
 #define MX8MP_IOMUXC_SAI1_RXD0__GPIO4_IO02                           0x150 0x3B0 0x000 0x5 0x0
 #define MX8MP_IOMUXC_SAI1_RXD1__AUDIOMIX_SAI1_RX_DATA01              0x154 0x3B4 0x000 0x0 0x0
 #define MX8MP_IOMUXC_SAI1_RXD1__AUDIOMIX_SAI5_RX_DATA01              0x154 0x3B4 0x4FC 0x1 0x1
-#define MX8MP_IOMUXC_SAI1_RXD1__AUDIOMIX_BIT_STREAM01                0x154 0x3B4 0x4C4 0x3 0x3
+#define MX8MP_IOMUXC_SAI1_RXD1__AUDIOMIX_BIT_STREAM01                0x154 0x3B4 0x4C4 0x3 0x4
 #define MX8MP_IOMUXC_SAI1_RXD1__ENET1_1588_EVENT1_OUT                0x154 0x3B4 0x000 0x4 0x0
 #define MX8MP_IOMUXC_SAI1_RXD1__GPIO4_IO03                           0x154 0x3B4 0x000 0x5 0x0
 #define MX8MP_IOMUXC_SAI1_RXD2__AUDIOMIX_SAI1_RX_DATA02              0x158 0x3B8 0x000 0x0 0x0
 #define MX8MP_IOMUXC_SAI1_RXD2__AUDIOMIX_SAI5_RX_DATA02              0x158 0x3B8 0x500 0x1 0x1
-#define MX8MP_IOMUXC_SAI1_RXD2__AUDIOMIX_BIT_STREAM02                0x158 0x3B8 0x4C8 0x3 0x3
+#define MX8MP_IOMUXC_SAI1_RXD2__AUDIOMIX_BIT_STREAM02                0x158 0x3B8 0x4C8 0x3 0x4
 #define MX8MP_IOMUXC_SAI1_RXD2__ENET1_MDC                            0x158 0x3B8 0x000 0x4 0x0
 #define MX8MP_IOMUXC_SAI1_RXD2__GPIO4_IO04                           0x158 0x3B8 0x000 0x5 0x0
 #define MX8MP_IOMUXC_SAI1_RXD3__AUDIOMIX_SAI1_RX_DATA03              0x15C 0x3BC 0x000 0x0 0x0
 #define MX8MP_IOMUXC_SAI1_RXD3__AUDIOMIX_SAI5_RX_DATA03              0x15C 0x3BC 0x504 0x1 0x1
-#define MX8MP_IOMUXC_SAI1_RXD3__AUDIOMIX_BIT_STREAM03                0x15C 0x3BC 0x4CC 0x3 0x3
+#define MX8MP_IOMUXC_SAI1_RXD3__AUDIOMIX_BIT_STREAM03                0x15C 0x3BC 0x4CC 0x3 0x4
 #define MX8MP_IOMUXC_SAI1_RXD3__ENET1_MDIO                           0x15C 0x3BC 0x57C 0x4 0x1
 #define MX8MP_IOMUXC_SAI1_RXD3__GPIO4_IO05                           0x15C 0x3BC 0x000 0x5 0x0
 #define MX8MP_IOMUXC_SAI1_RXD4__AUDIOMIX_SAI1_RX_DATA04              0x160 0x3C0 0x000 0x0 0x0
@@ -624,7 +624,7 @@
 #define MX8MP_IOMUXC_SAI2_RXFS__UART1_DCE_TX                         0x19C 0x3FC 0x000 0x4 0x0
 #define MX8MP_IOMUXC_SAI2_RXFS__UART1_DTE_RX                         0x19C 0x3FC 0x5E8 0x4 0x2
 #define MX8MP_IOMUXC_SAI2_RXFS__GPIO4_IO21                           0x19C 0x3FC 0x000 0x5 0x0
-#define MX8MP_IOMUXC_SAI2_RXFS__AUDIOMIX_BIT_STREAM02                0x19C 0x3FC 0x4C8 0x6 0x4
+#define MX8MP_IOMUXC_SAI2_RXFS__AUDIOMIX_BIT_STREAM02                0x19C 0x3FC 0x4C8 0x6 0x5
 #define MX8MP_IOMUXC_SAI2_RXFS__SIM_M_HSIZE00                        0x19C 0x3FC 0x000 0x7 0x0
 #define MX8MP_IOMUXC_SAI2_RXC__AUDIOMIX_SAI2_RX_BCLK                 0x1A0 0x400 0x000 0x0 0x0
 #define MX8MP_IOMUXC_SAI2_RXC__AUDIOMIX_SAI5_TX_BCLK                 0x1A0 0x400 0x50C 0x1 0x2
@@ -632,7 +632,7 @@
 #define MX8MP_IOMUXC_SAI2_RXC__UART1_DCE_RX                          0x1A0 0x400 0x5E8 0x4 0x3
 #define MX8MP_IOMUXC_SAI2_RXC__UART1_DTE_TX                          0x1A0 0x400 0x000 0x4 0x0
 #define MX8MP_IOMUXC_SAI2_RXC__GPIO4_IO22                            0x1A0 0x400 0x000 0x5 0x0
-#define MX8MP_IOMUXC_SAI2_RXC__AUDIOMIX_BIT_STREAM01                 0x1A0 0x400 0x4C4 0x6 0x4
+#define MX8MP_IOMUXC_SAI2_RXC__AUDIOMIX_BIT_STREAM01                 0x1A0 0x400 0x4C4 0x6 0x5
 #define MX8MP_IOMUXC_SAI2_RXC__SIM_M_HSIZE01                         0x1A0 0x400 0x000 0x7 0x0
 #define MX8MP_IOMUXC_SAI2_RXD0__AUDIOMIX_SAI2_RX_DATA00              0x1A4 0x404 0x000 0x0 0x0
 #define MX8MP_IOMUXC_SAI2_RXD0__AUDIOMIX_SAI5_TX_DATA00              0x1A4 0x404 0x000 0x1 0x0
@@ -641,7 +641,7 @@
 #define MX8MP_IOMUXC_SAI2_RXD0__UART1_DCE_RTS                        0x1A4 0x404 0x5E4 0x4 0x2
 #define MX8MP_IOMUXC_SAI2_RXD0__UART1_DTE_CTS                        0x1A4 0x404 0x000 0x4 0x0
 #define MX8MP_IOMUXC_SAI2_RXD0__GPIO4_IO23                           0x1A4 0x404 0x000 0x5 0x0
-#define MX8MP_IOMUXC_SAI2_RXD0__AUDIOMIX_BIT_STREAM03                0x1A4 0x404 0x4CC 0x6 0x4
+#define MX8MP_IOMUXC_SAI2_RXD0__AUDIOMIX_BIT_STREAM03                0x1A4 0x404 0x4CC 0x6 0x5
 #define MX8MP_IOMUXC_SAI2_RXD0__SIM_M_HSIZE02                        0x1A4 0x404 0x000 0x7 0x0
 #define MX8MP_IOMUXC_SAI2_TXFS__AUDIOMIX_SAI2_TX_SYNC                0x1A8 0x408 0x000 0x0 0x0
 #define MX8MP_IOMUXC_SAI2_TXFS__AUDIOMIX_SAI5_TX_DATA01              0x1A8 0x408 0x000 0x1 0x0
@@ -650,13 +650,13 @@
 #define MX8MP_IOMUXC_SAI2_TXFS__UART1_DCE_CTS                        0x1A8 0x408 0x000 0x4 0x0
 #define MX8MP_IOMUXC_SAI2_TXFS__UART1_DTE_RTS                        0x1A8 0x408 0x5E4 0x4 0x3
 #define MX8MP_IOMUXC_SAI2_TXFS__GPIO4_IO24                           0x1A8 0x408 0x000 0x5 0x0
-#define MX8MP_IOMUXC_SAI2_TXFS__AUDIOMIX_BIT_STREAM02                0x1A8 0x408 0x4C8 0x6 0x5
+#define MX8MP_IOMUXC_SAI2_TXFS__AUDIOMIX_BIT_STREAM02                0x1A8 0x408 0x4C8 0x6 0x6
 #define MX8MP_IOMUXC_SAI2_TXFS__SIM_M_HWRITE                         0x1A8 0x408 0x000 0x7 0x0
 #define MX8MP_IOMUXC_SAI2_TXC__AUDIOMIX_SAI2_TX_BCLK                 0x1AC 0x40C 0x000 0x0 0x0
 #define MX8MP_IOMUXC_SAI2_TXC__AUDIOMIX_SAI5_TX_DATA02               0x1AC 0x40C 0x000 0x1 0x0
 #define MX8MP_IOMUXC_SAI2_TXC__CAN1_RX                               0x1AC 0x40C 0x54C 0x3 0x1
 #define MX8MP_IOMUXC_SAI2_TXC__GPIO4_IO25                            0x1AC 0x40C 0x000 0x5 0x0
-#define MX8MP_IOMUXC_SAI2_TXC__AUDIOMIX_BIT_STREAM01                 0x1AC 0x40C 0x4C4 0x6 0x5
+#define MX8MP_IOMUXC_SAI2_TXC__AUDIOMIX_BIT_STREAM01                 0x1AC 0x40C 0x4C4 0x6 0x6
 #define MX8MP_IOMUXC_SAI2_TXC__SIM_M_HREADYOUT                       0x1AC 0x40C 0x000 0x7 0x0
 #define MX8MP_IOMUXC_SAI2_TXD0__AUDIOMIX_SAI2_TX_DATA00              0x1B0 0x410 0x000 0x0 0x0
 #define MX8MP_IOMUXC_SAI2_TXD0__AUDIOMIX_SAI5_TX_DATA03              0x1B0 0x410 0x000 0x1 0x0
@@ -680,7 +680,7 @@
 #define MX8MP_IOMUXC_SAI3_RXFS__AUDIOMIX_SAI3_RX_DATA01              0x1B8 0x418 0x000 0x3 0x0
 #define MX8MP_IOMUXC_SAI3_RXFS__AUDIOMIX_SPDIF_IN                    0x1B8 0x418 0x544 0x4 0x2
 #define MX8MP_IOMUXC_SAI3_RXFS__GPIO4_IO28                           0x1B8 0x418 0x000 0x5 0x0
-#define MX8MP_IOMUXC_SAI3_RXFS__AUDIOMIX_BIT_STREAM00                0x1B8 0x418 0x4C0 0x6 0x4
+#define MX8MP_IOMUXC_SAI3_RXFS__AUDIOMIX_BIT_STREAM00                0x1B8 0x418 0x4C0 0x6 0x5
 #define MX8MP_IOMUXC_SAI3_RXFS__TPSMP_HTRANS00                       0x1B8 0x418 0x000 0x7 0x0
 #define MX8MP_IOMUXC_SAI3_RXC__AUDIOMIX_SAI3_RX_BCLK                 0x1BC 0x41C 0x000 0x0 0x0
 #define MX8MP_IOMUXC_SAI3_RXC__AUDIOMIX_SAI2_RX_DATA02               0x1BC 0x41C 0x000 0x1 0x0
@@ -697,7 +697,7 @@
 #define MX8MP_IOMUXC_SAI3_RXD__UART2_DCE_RTS                         0x1C0 0x420 0x5EC 0x4 0x3
 #define MX8MP_IOMUXC_SAI3_RXD__UART2_DTE_CTS                         0x1C0 0x420 0x000 0x4 0x0
 #define MX8MP_IOMUXC_SAI3_RXD__GPIO4_IO30                            0x1C0 0x420 0x000 0x5 0x0
-#define MX8MP_IOMUXC_SAI3_RXD__AUDIOMIX_BIT_STREAM01                 0x1C0 0x420 0x4C4 0x6 0x6
+#define MX8MP_IOMUXC_SAI3_RXD__AUDIOMIX_BIT_STREAM01                 0x1C0 0x420 0x4C4 0x6 0x7
 #define MX8MP_IOMUXC_SAI3_RXD__TPSMP_HDATA00                         0x1C0 0x420 0x000 0x7 0x0
 #define MX8MP_IOMUXC_SAI3_TXFS__AUDIOMIX_SAI3_TX_SYNC                0x1C4 0x424 0x4EC 0x0 0x1
 #define MX8MP_IOMUXC_SAI3_TXFS__AUDIOMIX_SAI2_TX_DATA01              0x1C4 0x424 0x000 0x1 0x0
@@ -706,7 +706,7 @@
 #define MX8MP_IOMUXC_SAI3_TXFS__UART2_DCE_RX                         0x1C4 0x424 0x5F0 0x4 0x4
 #define MX8MP_IOMUXC_SAI3_TXFS__UART2_DTE_TX                         0x1C4 0x424 0x000 0x4 0x0
 #define MX8MP_IOMUXC_SAI3_TXFS__GPIO4_IO31                           0x1C4 0x424 0x000 0x5 0x0
-#define MX8MP_IOMUXC_SAI3_TXFS__AUDIOMIX_BIT_STREAM03                0x1C4 0x424 0x4CC 0x6 0x5
+#define MX8MP_IOMUXC_SAI3_TXFS__AUDIOMIX_BIT_STREAM03                0x1C4 0x424 0x4CC 0x6 0x6
 #define MX8MP_IOMUXC_SAI3_TXFS__TPSMP_HDATA01                        0x1C4 0x424 0x000 0x7 0x0
 #define MX8MP_IOMUXC_SAI3_TXC__AUDIOMIX_SAI3_TX_BCLK                 0x1C8 0x428 0x4E8 0x0 0x1
 #define MX8MP_IOMUXC_SAI3_TXC__AUDIOMIX_SAI2_TX_DATA02               0x1C8 0x428 0x000 0x1 0x0
@@ -715,7 +715,7 @@
 #define MX8MP_IOMUXC_SAI3_TXC__UART2_DCE_TX                          0x1C8 0x428 0x000 0x4 0x0
 #define MX8MP_IOMUXC_SAI3_TXC__UART2_DTE_RX                          0x1C8 0x428 0x5F0 0x4 0x5
 #define MX8MP_IOMUXC_SAI3_TXC__GPIO5_IO00                            0x1C8 0x428 0x000 0x5 0x0
-#define MX8MP_IOMUXC_SAI3_TXC__AUDIOMIX_BIT_STREAM02                 0x1C8 0x428 0x4C8 0x6 0x6
+#define MX8MP_IOMUXC_SAI3_TXC__AUDIOMIX_BIT_STREAM02                 0x1C8 0x428 0x4C8 0x6 0x7
 #define MX8MP_IOMUXC_SAI3_TXC__TPSMP_HDATA02                         0x1C8 0x428 0x000 0x7 0x0
 #define MX8MP_IOMUXC_SAI3_TXD__AUDIOMIX_SAI3_TX_DATA00               0x1CC 0x42C 0x000 0x0 0x0
 #define MX8MP_IOMUXC_SAI3_TXD__AUDIOMIX_SAI2_TX_DATA03               0x1CC 0x42C 0x000 0x1 0x0
-- 
2.21.0

