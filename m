Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B4AC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 06:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B8A620663
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 06:15:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727894AbgFRGPO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 02:15:14 -0400
Received: from inva020.nxp.com ([92.121.34.13]:47118 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726950AbgFRGPE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 02:15:04 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id B50A71A0E59;
        Thu, 18 Jun 2020 08:15:01 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id E402D1A0E46;
        Thu, 18 Jun 2020 08:14:57 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id E320D4030E;
        Thu, 18 Jun 2020 14:14:52 +0800 (SGT)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/5] ARM: dts: imx6sx-sdb: Add MQS support
Date:   Thu, 18 Jun 2020 14:03:46 +0800
Message-Id: <c0c53e3adce6715086e3c04e3799675c6d760546.1592460381.git.shengjiu.wang@nxp.com>
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

Add MQS support. As the pin conflict with usdhc2, then need
to add a separate dts.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 arch/arm/boot/dts/Makefile           |  1 +
 arch/arm/boot/dts/imx6sx-sdb-mqs.dts | 48 ++++++++++++++++++++++++++++
 arch/arm/boot/dts/imx6sx-sdb.dtsi    |  7 ++++
 arch/arm/boot/dts/imx6sx.dtsi        |  6 ++++
 4 files changed, 62 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6sx-sdb-mqs.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index e6a1cac0bfc7..04f85d6a2af3 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -592,6 +592,7 @@ dtb-$(CONFIG_SOC_IMX6SX) += \
 	imx6sx-sdb-reva.dtb \
 	imx6sx-sdb-sai.dtb \
 	imx6sx-sdb.dtb \
+	imx6sx-sdb-mqs.dtb \
 	imx6sx-softing-vining-2000.dtb \
 	imx6sx-udoo-neo-basic.dtb \
 	imx6sx-udoo-neo-extended.dtb \
diff --git a/arch/arm/boot/dts/imx6sx-sdb-mqs.dts b/arch/arm/boot/dts/imx6sx-sdb-mqs.dts
new file mode 100644
index 000000000000..a4ab2d3e960c
--- /dev/null
+++ b/arch/arm/boot/dts/imx6sx-sdb-mqs.dts
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (C) 2014 Freescale Semiconductor, Inc.
+
+#include "imx6sx-sdb.dts"
+/ {
+
+	sound {
+		status = "disabled";
+	};
+
+	sound-mqs {
+		compatible = "fsl,imx6sx-sdb-mqs",
+			     "fsl,imx-audio-mqs";
+		model = "mqs-audio";
+		audio-cpu = <&sai1>;
+		audio-asrc = <&asrc>;
+		audio-codec = <&mqs>;
+	};
+};
+
+&usdhc2 {
+	/* pin conflict with mqs*/
+	status = "disabled";
+};
+
+&mqs {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_mqs>;
+	clocks = <&clks IMX6SX_CLK_SAI1>;
+	clock-names = "mclk";
+	status = "okay";
+};
+
+&sai1 {
+	pinctrl-0 = <>;
+	status = "okay";
+};
+
+&ssi2 {
+	status = "disabled";
+};
+
+&sdma {
+	gpr = <&gpr>;
+	/* SDMA event remap for SAI1 */
+	fsl,sdma-event-remap = <0 15 1>, <0 16 1>;
+};
diff --git a/arch/arm/boot/dts/imx6sx-sdb.dtsi b/arch/arm/boot/dts/imx6sx-sdb.dtsi
index 3e5fb72f21fc..69a502b369c5 100644
--- a/arch/arm/boot/dts/imx6sx-sdb.dtsi
+++ b/arch/arm/boot/dts/imx6sx-sdb.dtsi
@@ -450,6 +450,13 @@
 			>;
 		};
 
+		pinctrl_mqs: mqsgrp {
+			fsl,pins = <
+				MX6SX_PAD_SD2_CLK__MQS_RIGHT 0x120b0
+				MX6SX_PAD_SD2_CMD__MQS_LEFT  0x120b0
+			>;
+		};
+
 		pinctrl_i2c1: i2c1grp {
 			fsl,pins = <
 				MX6SX_PAD_GPIO1_IO01__I2C1_SDA		0x4001b8b1
diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index 7d4856ffd239..8dc412b3862b 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -134,6 +134,12 @@
 		clock-output-names = "anaclk2";
 	};
 
+	mqs: mqs {
+		compatible = "fsl,imx6sx-mqs";
+		gpr = <&gpr>;
+		status = "disabled";
+	};
+
 	tempmon: tempmon {
 		compatible = "fsl,imx6sx-tempmon", "fsl,imx6q-tempmon";
 		interrupt-parent = <&gpc>;
-- 
2.21.0

