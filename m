Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 882BAC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 12:00:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6320122BF3
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 12:00:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="OvOJK3nM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732977AbgGaMAl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 08:00:41 -0400
Received: from uho.ysoft.cz ([81.19.3.130]:47922 "EHLO uho.ysoft.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732771AbgGaMAf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 08:00:35 -0400
Received: from iota-build.ysoft.local (unknown [10.1.5.151])
        by uho.ysoft.cz (Postfix) with ESMTP id B87AAA3721;
        Fri, 31 Jul 2020 14:00:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
        s=20160406-ysoft-com; t=1596196832;
        bh=C3An1wwqG0nWOOSDbQp59NJiranQJz7PFMVstRqtbGE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OvOJK3nMlvhylcphoj8ekMTMUACveJCOSH3mOEmJEu5S1AhPkXeBpz320EmnNRZHI
         Mmq2jzLeZa1cvMAA+qZ9Ts0KbaJJF47oBMj11RcuVgwt+WnLeIp/pCfX4P84dpGDqs
         tw31KaGY7qZuLSjpHy/8JSCpMBZyr8B2zDb360xs=
From:   =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
Subject: [PATCH 3/3] ARM: dts: imx6dl-yapp4: Add support for OLED based on different controller
Date:   Fri, 31 Jul 2020 14:00:08 +0200
Message-Id: <1596196808-5067-3-git-send-email-michal.vokac@ysoft.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1596196808-5067-1-git-send-email-michal.vokac@ysoft.com>
References: <1596196808-5067-1-git-send-email-michal.vokac@ysoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

OLED display consist of an OLED panel and a display controller.
The displays that were used on yapp4 platform were based on a SSD1305
controller. These displays are now discontinued and we need to add
support for a replacement.

The new display is based on SSD1309 controller and requires slightly
different configuration (mirror + segment offset).  We want to support
both display types so it does no matter which one was used on the assembly
line. Hence the displays are placed at different I2C addresses.

Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
---
 arch/arm/boot/dts/imx6dl-yapp4-common.dtsi | 15 ++++++++++++++-
 arch/arm/boot/dts/imx6dl-yapp4-hydra.dts   |  6 +++++-
 arch/arm/boot/dts/imx6dl-yapp4-orion.dts   |  6 +++++-
 3 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi b/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi
index c4a235d212b6..e626bef768bf 100644
--- a/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi
+++ b/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi
@@ -311,7 +311,20 @@
 	pinctrl-0 = <&pinctrl_i2c3>;
 	status = "okay";
 
-	oled: oled@3d {
+	oled_1309: oled@3c {
+		compatible = "solomon,ssd1309fb-i2c";
+		reg = <0x3c>;
+		solomon,height = <64>;
+		solomon,width = <128>;
+		solomon,page-offset = <0>;
+		solomon,segment-no-remap;
+		solomon,prechargep2 = <15>;
+		reset-gpios = <&gpio_oled 1 GPIO_ACTIVE_LOW>;
+		vbat-supply = <&sw2_reg>;
+		status = "disabled";
+	};
+
+	oled_1305: oled@3d {
 		compatible = "solomon,ssd1305fb-i2c";
 		reg = <0x3d>;
 		solomon,height = <64>;
diff --git a/arch/arm/boot/dts/imx6dl-yapp4-hydra.dts b/arch/arm/boot/dts/imx6dl-yapp4-hydra.dts
index 6010d3d872ab..a19609c7c7c0 100644
--- a/arch/arm/boot/dts/imx6dl-yapp4-hydra.dts
+++ b/arch/arm/boot/dts/imx6dl-yapp4-hydra.dts
@@ -29,7 +29,11 @@
 	status = "okay";
 };
 
-&oled {
+&oled_1305 {
+	status = "okay";
+};
+
+&oled_1309 {
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/imx6dl-yapp4-orion.dts b/arch/arm/boot/dts/imx6dl-yapp4-orion.dts
index 0428720417ef..884b236746bb 100644
--- a/arch/arm/boot/dts/imx6dl-yapp4-orion.dts
+++ b/arch/arm/boot/dts/imx6dl-yapp4-orion.dts
@@ -25,7 +25,11 @@
 	status = "okay";
 };
 
-&oled {
+&oled_1305 {
+	status = "okay";
+};
+
+&oled_1309 {
 	status = "okay";
 };
 
-- 
2.1.4

