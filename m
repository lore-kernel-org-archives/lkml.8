Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99677C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 16:57:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1EDF23134
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 16:57:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729849AbgHFQ5F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 12:57:05 -0400
Received: from inva021.nxp.com ([92.121.34.21]:36064 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728903AbgHFQkn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 12:40:43 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id DAB18200873;
        Thu,  6 Aug 2020 13:55:00 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 0B7ED200869;
        Thu,  6 Aug 2020 13:54:57 +0200 (CEST)
Received: from 10.192.242.69 (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id E7BAC40252;
        Thu,  6 Aug 2020 13:54:51 +0200 (CEST)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] ARM: dts: imx6sx-sdb: Add headphone detection for sound card
Date:   Thu,  6 Aug 2020 19:50:17 +0800
Message-Id: <1596714617-16387-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Headphone detection is triggered by GPIO, then driver can
switch between speaker and headphone.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 arch/arm/boot/dts/imx6sx-sdb.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/imx6sx-sdb.dtsi b/arch/arm/boot/dts/imx6sx-sdb.dtsi
index 3e5fb72f21fc..15f486a15f24 100644
--- a/arch/arm/boot/dts/imx6sx-sdb.dtsi
+++ b/arch/arm/boot/dts/imx6sx-sdb.dtsi
@@ -165,6 +165,7 @@ sound {
 			"IN3R", "AMIC";
 		mux-int-port = <2>;
 		mux-ext-port = <6>;
+		hp-det-gpio = <&gpio1 17 GPIO_ACTIVE_LOW>;
 	};
 
 	panel {
@@ -374,6 +375,9 @@ &wdog1 {
 
 &iomuxc {
 	imx6x-sdb {
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_hog>;
+
 		pinctrl_audmux: audmuxgrp {
 			fsl,pins = <
 				MX6SX_PAD_CSI_DATA00__AUDMUX_AUD6_TXC	0x130b0
@@ -450,6 +454,12 @@ MX6SX_PAD_CSI_DATA05__GPIO1_IO_19 0x17059
 			>;
 		};
 
+		pinctrl_hog: hoggrp {
+			fsl,pins = <
+				MX6SX_PAD_CSI_DATA03__GPIO1_IO_17 0x17059
+			>;
+		};
+
 		pinctrl_i2c1: i2c1grp {
 			fsl,pins = <
 				MX6SX_PAD_GPIO1_IO01__I2C1_SDA		0x4001b8b1
-- 
2.27.0

