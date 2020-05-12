Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1BE4C2D0FA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 21:00:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9925820740
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 21:00:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731277AbgELVAG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 17:00:06 -0400
Received: from lists.gateworks.com ([108.161.130.12]:51285 "EHLO
        lists.gateworks.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbgELVAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 17:00:04 -0400
Received: from 068-189-091-139.biz.spectrum.com ([68.189.91.139] helo=tharvey.pdc.gateworks.com)
        by lists.gateworks.com with esmtp (Exim 4.82)
        (envelope-from <tharvey@gateworks.com>)
        id 1jYc2u-0007As-IA; Tue, 12 May 2020 21:02:36 +0000
From:   Tim Harvey <tharvey@gateworks.com>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH] ARM: dts: imx6qdl-gw5904: add lsm9ds1 iio imu/magn support
Date:   Tue, 12 May 2020 13:59:56 -0700
Message-Id: <1589317196-8864-1-git-send-email-tharvey@gateworks.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add one node for the accel/gyro i2c device and another for the separate
magnetometer device in the lsm9ds1.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 arch/arm/boot/dts/imx6qdl-gw5904.dtsi | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-gw5904.dtsi b/arch/arm/boot/dts/imx6qdl-gw5904.dtsi
index 6d21cc6..76d6cf5 100644
--- a/arch/arm/boot/dts/imx6qdl-gw5904.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw5904.dtsi
@@ -248,6 +248,15 @@
 	pinctrl-0 = <&pinctrl_i2c2>;
 	status = "okay";
 
+	magn@1c {
+		compatible = "st,lsm9ds1-magn";
+		reg = <0x1c>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_mag>;
+		interrupt-parent = <&gpio5>;
+		interrupts = <17 IRQ_TYPE_EDGE_RISING>;
+	};
+
 	ltc3676: pmic@3c {
 		compatible = "lltc,ltc3676";
 		reg = <0x3c>;
@@ -320,6 +329,16 @@
 			};
 		};
 	};
+
+	imu@6a {
+		compatible = "st,lsm9ds1-imu";
+		reg = <0x6a>;
+		st,drdy-int-pin = <1>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_imu>;
+		interrupt-parent = <&gpio4>;
+		interrupts = <18 IRQ_TYPE_LEVEL_HIGH>;
+	};
 };
 
 &i2c3 {
@@ -501,6 +520,18 @@
 		>;
 	};
 
+	pinctrl_imu: imugrp {
+		fsl,pins = <
+			MX6QDL_PAD_DI0_PIN2__GPIO4_IO18		0x1b0b0
+		>;
+	};
+
+	pinctrl_mag: maggrp {
+		fsl,pins = <
+			MX6QDL_PAD_DISP0_DAT23__GPIO5_IO17	0x1b0b0
+		>;
+	};
+
 	pinctrl_pcie: pciegrp {
 		fsl,pins = <
 			MX6QDL_PAD_GPIO_0__GPIO1_IO00	0x1b0b0 /* PCIE RST */
-- 
2.7.4

