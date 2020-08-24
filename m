Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F47C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 07:56:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2B0A206F0
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 07:56:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgHXH40 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 03:56:26 -0400
Received: from inva020.nxp.com ([92.121.34.13]:39318 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726024AbgHXH4V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 03:56:21 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id C13D21A17BD;
        Mon, 24 Aug 2020 09:56:19 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 02BC71A0309;
        Mon, 24 Aug 2020 09:56:16 +0200 (CEST)
Received: from 10.192.242.69 (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 0B469402E5;
        Mon, 24 Aug 2020 09:56:10 +0200 (CEST)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 2/3] ARM: dts: imx6sl-evk: Add headphone detection for sound card
Date:   Mon, 24 Aug 2020 15:50:38 +0800
Message-Id: <1598255439-1193-3-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1598255439-1193-1-git-send-email-shengjiu.wang@nxp.com>
References: <1598255439-1193-1-git-send-email-shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Headphone detection is triggered by GPIO, then driver can
switch between speaker and headphone.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 arch/arm/boot/dts/imx6sl-evk.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/imx6sl-evk.dts b/arch/arm/boot/dts/imx6sl-evk.dts
index b1b069e723d2..ee6e477bfe82 100644
--- a/arch/arm/boot/dts/imx6sl-evk.dts
+++ b/arch/arm/boot/dts/imx6sl-evk.dts
@@ -94,6 +94,8 @@ reg_lcd_5v: regulator-lcd-5v {
 
 	sound {
 		compatible = "fsl,imx6sl-evk-wm8962", "fsl,imx-audio-wm8962";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_hp>;
 		model = "wm8962-audio";
 		ssi-controller = <&ssi2>;
 		audio-codec = <&codec>;
@@ -106,6 +108,7 @@ sound {
 			"IN3R", "AMIC";
 		mux-int-port = <2>;
 		mux-ext-port = <3>;
+		hp-det-gpio = <&gpio4 19 GPIO_ACTIVE_LOW>;
 	};
 
 	panel {
@@ -343,6 +346,12 @@ MX6SL_PAD_FEC_REF_CLK__GPIO4_IO26  0x3080
 			>;
 		};
 
+		pinctrl_hp: hpgrp {
+			fsl,pins = <
+				MX6SL_PAD_FEC_RX_ER__GPIO4_IO19	  0x1b0b0
+			>;
+		};
+
 		pinctrl_i2c1: i2c1grp {
 			fsl,pins = <
 				MX6SL_PAD_I2C1_SCL__I2C1_SCL	0x4001b8b1
-- 
2.27.0

