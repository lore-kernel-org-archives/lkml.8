Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8120BC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 16:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AF9322CF7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 16:53:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728095AbgHEQw7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 12:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728014AbgHEQsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 12:48:38 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30BCEC0A8899;
        Wed,  5 Aug 2020 06:58:36 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id BDE0A296C3D
Received: by jupiter.universe (Postfix, from userid 1000)
        id AFE19480115; Wed,  5 Aug 2020 15:58:26 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCHv1] ARM: dts/imx6q-bx50v3: Add IRQ support for internal switch
Date:   Wed,  5 Aug 2020 15:58:17 +0200
Message-Id: <20200805135817.391409-1-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds missing interrupt support for the internal Marvell
switch, so that the kernel does not have to keep polling the
PHYs on the bit-banged MDIO bus all the time.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 arch/arm/boot/dts/imx6q-bx50v3.dtsi | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6q-bx50v3.dtsi b/arch/arm/boot/dts/imx6q-bx50v3.dtsi
index 1938b04199c4..1fb67cd2b2a1 100644
--- a/arch/arm/boot/dts/imx6q-bx50v3.dtsi
+++ b/arch/arm/boot/dts/imx6q-bx50v3.dtsi
@@ -102,10 +102,15 @@ mdio0: mdio-gpio {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		switch@0 {
+		switch: switch@0 {
 			compatible = "marvell,mv88e6085"; /* 88e6240*/
 			reg = <0>;
 
+			interrupt-parent = <&gpio2>;
+			interrupts = <2 IRQ_TYPE_LEVEL_LOW>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+
 			switch_ports: ports {
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -117,22 +122,32 @@ mdio {
 
 				switchphy0: switchphy@0 {
 					reg = <0>;
+					interrupt-parent = <&switch>;
+					interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
 				};
 
 				switchphy1: switchphy@1 {
 					reg = <1>;
+					interrupt-parent = <&switch>;
+					interrupts = <1 IRQ_TYPE_LEVEL_HIGH>;
 				};
 
 				switchphy2: switchphy@2 {
 					reg = <2>;
+					interrupt-parent = <&switch>;
+					interrupts = <2 IRQ_TYPE_LEVEL_HIGH>;
 				};
 
 				switchphy3: switchphy@3 {
 					reg = <3>;
+					interrupt-parent = <&switch>;
+					interrupts = <3 IRQ_TYPE_LEVEL_HIGH>;
 				};
 
 				switchphy4: switchphy@4 {
 					reg = <4>;
+					interrupt-parent = <&switch>;
+					interrupts = <4 IRQ_TYPE_LEVEL_HIGH>;
 				};
 			};
 		};
-- 
2.27.0

