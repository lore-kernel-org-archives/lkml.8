Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2DFFC3F68F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 21:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B04E0206CC
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 21:02:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388231AbgBNVCx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 16:02:53 -0500
Received: from lists.gateworks.com ([108.161.130.12]:38389 "EHLO
        lists.gateworks.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728173AbgBNVCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 16:02:52 -0500
Received: from 68-189-91-139.static.snlo.ca.charter.com ([68.189.91.139] helo=rjones.pdc.gateworks.com)
        by lists.gateworks.com with esmtp (Exim 4.82)
        (envelope-from <rjones@gateworks.com>)
        id 1j2i7Y-0007HC-Tm; Fri, 14 Feb 2020 21:03:33 +0000
From:   Robert Jones <rjones@gateworks.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Robert Jones <rjones@gateworks.com>
Subject: [PATCH v2] ARM: dts: imx6qdl-gw553x.dtsi: add lsm9ds1 iio imu/magn support
Date:   Fri, 14 Feb 2020 13:02:41 -0800
Message-Id: <20200214210241.32611-1-rjones@gateworks.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add one node for the accel/gyro i2c device and another for the separate
magnetometer device in the lsm9ds1.

Signed-off-by: Robert Jones <rjones@gateworks.com>
---

Changes in v2:
 - Use generic node names
 - alphabetize pinctrl entries
 - shorten patch title prefix

 arch/arm/boot/dts/imx6qdl-gw553x.dtsi | 31 +++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-gw553x.dtsi b/arch/arm/boot/dts/imx6qdl-gw553x.dtsi
index a1066897be18..ee85031c3916 100644
--- a/arch/arm/boot/dts/imx6qdl-gw553x.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw553x.dtsi
@@ -173,6 +173,25 @@ &i2c2 {
 	pinctrl-0 = <&pinctrl_i2c2>;
 	status = "okay";
 
+	magn@1c {
+		compatible = "st,lsm9ds1-magn";
+		reg = <0x1c>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_mag>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <2 IRQ_TYPE_EDGE_RISING>;
+	};
+
+	imu@6a {
+		compatible = "st,lsm9ds1-imu";
+		reg = <0x6a>;
+		st,drdy-int-pin = <1>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_imu>;
+		interrupt-parent = <&gpio7>;
+		interrupts = <13 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
 	ltc3676: pmic@3c {
 		compatible = "lltc,ltc3676";
 		reg = <0x3c>;
@@ -426,6 +445,12 @@ MX6QDL_PAD_GPIO_6__I2C3_SDA		0x4001b8b1
 		>;
 	};
 
+	pinctrl_imu: imugrp {
+		fsl,pins = <
+			MX6QDL_PAD_GPIO_18__GPIO7_IO13		0x1b0b0
+		>;
+	};
+
 	pinctrl_ipu1_csi0: ipu1csi0grp {
 		fsl,pins = <
 			MX6QDL_PAD_CSI0_DAT12__IPU1_CSI0_DATA12    0x1b0b0
@@ -449,6 +474,12 @@ MX6QDL_PAD_KEY_ROW2__GPIO4_IO11		0x1b0b0
 		>;
 	};
 
+	pinctrl_mag: maggrp {
+		fsl,pins = <
+			MX6QDL_PAD_GPIO_2__GPIO1_IO02		0x1b0b0
+		>;
+	};
+
 	pinctrl_pcie: pciegrp {
 		fsl,pins = <
 			MX6QDL_PAD_GPIO_0__GPIO1_IO00		0x1b0b0
-- 
2.25.0

