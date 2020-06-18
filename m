Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 965E7C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 06:15:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7967C217A0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 06:15:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbgFRGPG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 02:15:06 -0400
Received: from inva021.nxp.com ([92.121.34.21]:53278 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727812AbgFRGPD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 02:15:03 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 67F3E200C1E;
        Thu, 18 Jun 2020 08:15:01 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 97C66200068;
        Thu, 18 Jun 2020 08:14:57 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id F302440302;
        Thu, 18 Jun 2020 14:14:51 +0800 (SGT)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/5] ARM: dts: imx6sx: Enable ASRC device
Date:   Thu, 18 Jun 2020 14:03:45 +0800
Message-Id: <b3935b4ab4590be4880f4f16fdcfaf0d7e0bbdd9.1592460381.git.shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1592460381.git.shengjiu.wang@nxp.com>
References: <cover.1592460381.git.shengjiu.wang@nxp.com>
In-Reply-To: <cover.1592460381.git.shengjiu.wang@nxp.com>
References: <cover.1592460381.git.shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible string, update the clock table,
add fsl,asrc-rate and fsl,asrc-width property.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 arch/arm/boot/dts/imx6sx.dtsi | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index 94e3df47d1ad..7d4856ffd239 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -390,18 +390,28 @@
 				};
 
 				asrc: asrc@2034000 {
+					compatible = "fsl,imx6sx-asrc", "fsl,imx53-asrc";
 					reg = <0x02034000 0x4000>;
 					interrupts = <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
-					clocks = <&clks IMX6SX_CLK_ASRC_MEM>,
-						 <&clks IMX6SX_CLK_ASRC_IPG>,
-						 <&clks IMX6SX_CLK_SPDIF>,
-						 <&clks IMX6SX_CLK_SPBA>;
-					clock-names = "mem", "ipg", "asrck", "spba";
-					dmas = <&sdma 17 20 1>, <&sdma 18 20 1>,
-					       <&sdma 19 20 1>, <&sdma 20 20 1>,
-					       <&sdma 21 20 1>, <&sdma 22 20 1>;
+					clocks = <&clks IMX6SX_CLK_ASRC_IPG>,
+						<&clks IMX6SX_CLK_ASRC_MEM>, <&clks 0>,
+						<&clks 0>, <&clks 0>, <&clks 0>, <&clks 0>,
+						<&clks 0>, <&clks 0>, <&clks 0>, <&clks 0>,
+						<&clks 0>, <&clks 0>, <&clks 0>, <&clks 0>,
+						<&clks IMX6SX_CLK_SPDIF>, <&clks 0>, <&clks 0>,
+						<&clks IMX6SX_CLK_SPBA>;
+					clock-names = "mem", "ipg", "asrck_0",
+						"asrck_1", "asrck_2", "asrck_3", "asrck_4",
+						"asrck_5", "asrck_6", "asrck_7", "asrck_8",
+						"asrck_9", "asrck_a", "asrck_b", "asrck_c",
+						"asrck_d", "asrck_e", "asrck_f", "spba";
+					dmas = <&sdma 17 23 1>, <&sdma 18 23 1>,
+					       <&sdma 19 23 1>, <&sdma 20 23 1>,
+					       <&sdma 21 23 1>, <&sdma 22 23 1>;
 					dma-names = "rxa", "rxb", "rxc",
 						    "txa", "txb", "txc";
+					fsl,asrc-rate  = <48000>;
+					fsl,asrc-width = <16>;
 					status = "okay";
 				};
 			};
-- 
2.21.0

