Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2DECC433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 07:56:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D784206F0
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 07:56:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbgHXH4Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 03:56:24 -0400
Received: from inva020.nxp.com ([92.121.34.13]:39186 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726241AbgHXH4U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 03:56:20 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id B34051A11C6;
        Mon, 24 Aug 2020 09:56:18 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 079B71A0313;
        Mon, 24 Aug 2020 09:56:15 +0200 (CEST)
Received: from 10.192.242.69 (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 11B59402E2;
        Mon, 24 Aug 2020 09:56:10 +0200 (CEST)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 1/3] ARM: dts: imx6sx-sdb: Add headphone detection for sound card
Date:   Mon, 24 Aug 2020 15:50:37 +0800
Message-Id: <1598255439-1193-2-git-send-email-shengjiu.wang@nxp.com>
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
 arch/arm/boot/dts/imx6sx-sdb.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/imx6sx-sdb.dtsi b/arch/arm/boot/dts/imx6sx-sdb.dtsi
index b8c23eba9dc7..1351d7f70a54 100644
--- a/arch/arm/boot/dts/imx6sx-sdb.dtsi
+++ b/arch/arm/boot/dts/imx6sx-sdb.dtsi
@@ -153,6 +153,8 @@ reg_can_stby: regulator-can-stby {
 
 	sound {
 		compatible = "fsl,imx6sx-sdb-wm8962", "fsl,imx-audio-wm8962";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_hp>;
 		model = "wm8962-audio";
 		ssi-controller = <&ssi2>;
 		audio-codec = <&codec>;
@@ -165,6 +167,7 @@ sound {
 			"IN3R", "AMIC";
 		mux-int-port = <2>;
 		mux-ext-port = <6>;
+		hp-det-gpio = <&gpio1 17 GPIO_ACTIVE_LOW>;
 	};
 
 	panel {
@@ -468,6 +471,12 @@ MX6SX_PAD_CSI_DATA05__GPIO1_IO_19 0x17059
 			>;
 		};
 
+		pinctrl_hp: hpgrp {
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

