Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF9A8C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 03:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 960A62073E
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 03:58:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbgGAD6p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 23:58:45 -0400
Received: from inva020.nxp.com ([92.121.34.13]:54298 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725862AbgGAD6p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 23:58:45 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 517941A0607;
        Wed,  1 Jul 2020 05:58:43 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 7FDE01A053E;
        Wed,  1 Jul 2020 05:58:39 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 7DF09402DD;
        Wed,  1 Jul 2020 11:58:34 +0800 (SGT)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] ARM: dts: imx6ul: Add ASRC device node
Date:   Wed,  1 Jul 2020 11:46:56 +0800
Message-Id: <1593575216-19921-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ASRC device node.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 arch/arm/boot/dts/imx6ul.dtsi | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
index 5379a03391bd..d10d5eb55a88 100644
--- a/arch/arm/boot/dts/imx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul.dtsi
@@ -351,6 +351,31 @@
 					dma-names = "rx", "tx";
 					status = "disabled";
 				};
+
+				asrc: asrc@2034000 {
+					compatible = "fsl,imx6ul-asrc", "fsl,imx53-asrc";
+					reg = <0x2034000 0x4000>;
+					interrupts = <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
+					clocks = <&clks IMX6UL_CLK_ASRC_IPG>,
+						<&clks IMX6UL_CLK_ASRC_MEM>, <&clks 0>,
+						<&clks 0>, <&clks 0>, <&clks 0>, <&clks 0>,
+						<&clks 0>, <&clks 0>, <&clks 0>, <&clks 0>,
+						<&clks 0>, <&clks 0>, <&clks 0>, <&clks 0>,
+						<&clks IMX6UL_CLK_SPDIF>, <&clks 0>, <&clks 0>,
+						<&clks IMX6UL_CLK_SPBA>;
+					clock-names = "mem", "ipg", "asrck_0",
+						"asrck_1", "asrck_2", "asrck_3", "asrck_4",
+						"asrck_5", "asrck_6", "asrck_7", "asrck_8",
+						"asrck_9", "asrck_a", "asrck_b", "asrck_c",
+						"asrck_d", "asrck_e", "asrck_f", "spba";
+					dmas = <&sdma 17 23 1>, <&sdma 18 23 1>, <&sdma 19 23 1>,
+						<&sdma 20 23 1>, <&sdma 21 23 1>, <&sdma 22 23 1>;
+					dma-names = "rxa", "rxb", "rxc",
+						    "txa", "txb", "txc";
+					fsl,asrc-rate  = <48000>;
+					fsl,asrc-width = <16>;
+					status = "okay";
+				};
 			};
 
 			tsc: tsc@2040000 {
-- 
2.21.0

