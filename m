Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E4D6C3F68F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 21:02:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3871424676
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 21:02:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730333AbgBNVCM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 16:02:12 -0500
Received: from lists.gateworks.com ([108.161.130.12]:38381 "EHLO
        lists.gateworks.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728173AbgBNVCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 16:02:12 -0500
Received: from 68-189-91-139.static.snlo.ca.charter.com ([68.189.91.139] helo=rjones.pdc.gateworks.com)
        by lists.gateworks.com with esmtp (Exim 4.82)
        (envelope-from <rjones@gateworks.com>)
        id 1j2i6p-0007Gv-LZ; Fri, 14 Feb 2020 21:02:47 +0000
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
Subject: [PATCH v2] ARM: dts: imx: ventana: add fxos8700 on gateworks boards
Date:   Fri, 14 Feb 2020 13:01:55 -0800
Message-Id: <20200214210155.32518-1-rjones@gateworks.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add fxos8700 iio imu entries for Gateworks ventana SBCs.

Signed-off-by: Robert Jones <rjones@gateworks.com>
---

Changes in v2:
 - Use generic node names

 arch/arm/boot/dts/imx6qdl-gw52xx.dtsi | 5 +++++
 arch/arm/boot/dts/imx6qdl-gw53xx.dtsi | 5 +++++
 arch/arm/boot/dts/imx6qdl-gw54xx.dtsi | 5 +++++
 3 files changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
index 1a9a9d98f284..60563ff0b7ce 100644
--- a/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
@@ -313,6 +313,11 @@ touchscreen: egalax_ts@4 {
 		interrupts = <12 2>;
 		wakeup-gpios = <&gpio7 12 GPIO_ACTIVE_LOW>;
 	};
+
+	accel@1e {
+		compatible = "nxp,fxos8700";
+		reg = <0x1e>;
+	};
 };
 
 &ldb {
diff --git a/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
index 54b2beadd7a2..8942bec65c5c 100644
--- a/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
@@ -304,6 +304,11 @@ touchscreen: egalax_ts@4 {
 		interrupts = <11 2>;
 		wakeup-gpios = <&gpio1 11 GPIO_ACTIVE_LOW>;
 	};
+
+	accel@1e {
+		compatible = "nxp,fxos8700";
+		reg = <0x1e>;
+	};
 };
 
 &ldb {
diff --git a/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
index 1b6c1331c220..c40583dbd96d 100644
--- a/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
@@ -361,6 +361,11 @@ touchscreen: egalax_ts@4 {
 		interrupts = <12 2>;
 		wakeup-gpios = <&gpio7 12 GPIO_ACTIVE_LOW>;
 	};
+
+	accel@1e {
+		compatible = "nxp,fxos8700";
+		reg = <0x1e>;
+	};
 };
 
 &ldb {
-- 
2.25.0

