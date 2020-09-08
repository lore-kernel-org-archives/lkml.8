Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24156C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:28:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B591020936
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599586103;
	bh=vz/rJ82lQGFmeFstvC9WgMiNuCiMsme+wQgrAQY1Ok0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hUTiiaoeeURKGiUfaXQuriKuv921yJzCPncQRM2sJDAC07oquok4CZA1hEeaBrLzr
	 Zz8hu8F9cAgEymiOsd+SJ0JxWZiL5uz+OWu16ce5nDKV6xAYkiH0y4oDMxvIsarO5b
	 RkjlRSGFkUlVW7g0G3mk6+8ryGaGL7Q6CyhuYfYw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731762AbgIHR1o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 13:27:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:57574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731724AbgIHQQb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:16:31 -0400
Received: from localhost.localdomain (unknown [194.230.155.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 685AD23C2F;
        Tue,  8 Sep 2020 15:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599577419;
        bh=vz/rJ82lQGFmeFstvC9WgMiNuCiMsme+wQgrAQY1Ok0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f83qnPfcbf2pWlWdEcVcmx6CZMFj90HQ1l+Hf2E1oKZvkzJjMGNSAFzhelsuw+UDN
         lAaZerPbUxMmyAhJ1V4B5nhswe+6q96BWrGXQEh7hFtACQ67yCIirUZECc9WnV7jL2
         m3y3kFPwAeZFwowJpLMjvBdBOHODdsCQCWw8n074=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Michal Simek <michal.simek@xilinx.com>,
        Adam Ford <aford173@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Robin Gong <yibin.gong@nxp.com>,
        Alifer Moraes <alifer.wsdm@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Vitor Massaru Iha <vitor@massaru.org>,
        Kever Yang <kever.yang@rock-chips.com>,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 5/8] arm64: dts: imx8mq: Correct interrupt flags in examples
Date:   Tue,  8 Sep 2020 17:02:38 +0200
Message-Id: <20200908150241.5771-5-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200908150241.5771-1-krzk@kernel.org>
References: <20200908150241.5771-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GPIO_ACTIVE_x flags are not correct in the context of interrupt flags.
These are simple defines so they could be used in DTS but they will not
have the same meaning:
1. GPIO_ACTIVE_HIGH = 0 = IRQ_TYPE_NONE
2. GPIO_ACTIVE_LOW  = 1 = IRQ_TYPE_EDGE_RISING

Correct the interrupt flags, assuming the author of the code wanted some
logical behavior behind the name "ACTIVE_xxx", this is:
  ACTIVE_LOW  => IRQ_TYPE_LEVEL_LOW

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Not tested on HW.
---
 arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts | 5 +++--
 arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi       | 3 ++-
 arch/arm64/boot/dts/freescale/imx8mq-phanbell.dts       | 3 ++-
 arch/arm64/boot/dts/freescale/imx8mq-pico-pi.dts        | 3 ++-
 4 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
index a80e53428c2f..7f728dea32ca 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
@@ -6,6 +6,7 @@
 /dts-v1/;
 
 #include "dt-bindings/input/input.h"
+#include <dt-bindings/interrupt-controller/irq.h>
 #include "dt-bindings/pwm/pwm.h"
 #include "dt-bindings/usb/pd.h"
 #include "imx8mq.dtsi"
@@ -60,7 +61,7 @@
 			label = "WWAN_WAKE";
 			gpios = <&gpio3 8 GPIO_ACTIVE_LOW>;
 			interrupt-parent = <&gpio3>;
-			interrupts = <8 GPIO_ACTIVE_LOW>;
+			interrupts = <8 IRQ_TYPE_LEVEL_LOW>;
 			wakeup-source;
 			linux,code = <KEY_PHONE>;
 		};
@@ -288,7 +289,7 @@
 		#clock-cells = <0>;
 		clock-output-names = "pmic_clk";
 		interrupt-parent = <&gpio1>;
-		interrupts = <3 GPIO_ACTIVE_LOW>;
+		interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
 		interrupt-names = "irq";
 		rohm,reset-snvs-powered;
 
diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
index c3e290703fe8..3c389c7ffb2c 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
@@ -6,6 +6,7 @@
 /dts-v1/;
 
 #include "dt-bindings/input/input.h"
+#include <dt-bindings/interrupt-controller/irq.h>
 #include "dt-bindings/pwm/pwm.h"
 #include "dt-bindings/usb/pd.h"
 #include "imx8mq.dtsi"
@@ -639,7 +640,7 @@
 		clock-names = "osc";
 		clock-output-names = "pmic_clk";
 		interrupt-parent = <&gpio1>;
-		interrupts = <7 GPIO_ACTIVE_LOW>;
+		interrupts = <7 IRQ_TYPE_LEVEL_LOW>;
 		interrupt-names = "irq";
 		rohm,reset-snvs-powered;
 
diff --git a/arch/arm64/boot/dts/freescale/imx8mq-phanbell.dts b/arch/arm64/boot/dts/freescale/imx8mq-phanbell.dts
index 3f541ddf0768..05fcea2fb402 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-phanbell.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-phanbell.dts
@@ -6,6 +6,7 @@
 /dts-v1/;
 
 #include "imx8mq.dtsi"
+#include <dt-bindings/interrupt-controller/irq.h>
 
 / {
 	model = "Google i.MX8MQ Phanbell";
@@ -125,7 +126,7 @@
 		clocks = <&pmic_osc>;
 		clock-output-names = "pmic_clk";
 		interrupt-parent = <&gpio1>;
-		interrupts = <3 GPIO_ACTIVE_LOW>;
+		interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
 
 		regulators {
 			buck1: BUCK1 {
diff --git a/arch/arm64/boot/dts/freescale/imx8mq-pico-pi.dts b/arch/arm64/boot/dts/freescale/imx8mq-pico-pi.dts
index 59da96b7143f..84c3a143d87b 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-pico-pi.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-pico-pi.dts
@@ -9,6 +9,7 @@
 /dts-v1/;
 
 #include "imx8mq.dtsi"
+#include <dt-bindings/interrupt-controller/irq.h>
 
 / {
 	model = "TechNexion PICO-PI-8M";
@@ -70,7 +71,7 @@
 		clock-names = "osc";
 		clock-output-names = "pmic_clk";
 		interrupt-parent = <&gpio1>;
-		interrupts = <3 GPIO_ACTIVE_LOW>;
+		interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
 		interrupt-names = "irq";
 
 		regulators {
-- 
2.17.1

