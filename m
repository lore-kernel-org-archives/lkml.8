Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CA40C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 20:12:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 618F52145D
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 20:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599595971;
	bh=XhJc815Bg0CO+ITUVSodHOkWltvX4tp7oPl6ugqezx0=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=N93z8DMsqSvV7UBBs/PbxJi0D0LNtTDLp0UuLR/955MzZSxMXUjvdHGmM7PDbPKky
	 xmBGHZG+mAXakuzrL8RLYJhEsCmnkV5QK1Z5RTzmAdmFY+UXdZuU+0ZsKnAv7tnwp3
	 1uldnfrE949iWhJNOVJzHdDo4SHkRyfz+sknZIgg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbgIHUMU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 16:12:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:51648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729799AbgIHPLS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 11:11:18 -0400
Received: from localhost.localdomain (unknown [194.230.155.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2EE2E224D3;
        Tue,  8 Sep 2020 15:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599577397;
        bh=XhJc815Bg0CO+ITUVSodHOkWltvX4tp7oPl6ugqezx0=;
        h=From:To:Cc:Subject:Date:From;
        b=Np61KF7ATRh8jk50to0cyRJlzlKGFaLFPeR0tO6uWVCYjWNkjwo5gBJVS9yamWiD1
         cZxuLu1BPbjt5CNTiH/7q/vpwYyXKRoJd5XkKQKJbfibDsj5Ow3qAruNjN1vmaq5dn
         jSUw8nX/v8n6m4vTozEKTZY3RMp1BC/mkiEtcCjE=
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
Subject: [PATCH 1/8] ARM: dts: imx6qdl: Correct interrupt flags in examples
Date:   Tue,  8 Sep 2020 17:02:34 +0200
Message-Id: <20200908150241.5771-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
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
 arch/arm/boot/dts/imx6qdl-gw51xx.dtsi | 3 ++-
 arch/arm/boot/dts/imx6qdl-gw52xx.dtsi | 3 ++-
 arch/arm/boot/dts/imx6qdl-gw53xx.dtsi | 3 ++-
 arch/arm/boot/dts/imx6qdl-gw54xx.dtsi | 3 ++-
 arch/arm/boot/dts/imx6qdl-gw551x.dtsi | 3 ++-
 arch/arm/boot/dts/imx6qdl-gw552x.dtsi | 3 ++-
 arch/arm/boot/dts/imx6qdl-gw553x.dtsi | 3 ++-
 arch/arm/boot/dts/imx6qdl-gw560x.dtsi | 3 ++-
 arch/arm/boot/dts/imx6qdl-gw5903.dtsi | 3 ++-
 arch/arm/boot/dts/imx6qdl-gw5904.dtsi | 3 ++-
 arch/arm/boot/dts/imx6qdl-gw5907.dtsi | 3 ++-
 arch/arm/boot/dts/imx6qdl-gw5910.dtsi | 3 ++-
 arch/arm/boot/dts/imx6qdl-gw5912.dtsi | 3 ++-
 arch/arm/boot/dts/imx6qdl-gw5913.dtsi | 3 ++-
 14 files changed, 28 insertions(+), 14 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-gw51xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw51xx.dtsi
index 4d01c3300b97..3c04b5a4f3cb 100644
--- a/arch/arm/boot/dts/imx6qdl-gw51xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw51xx.dtsi
@@ -5,6 +5,7 @@
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/linux-event-codes.h>
+#include <dt-bindings/interrupt-controller/irq.h>
 
 / {
 	/* these are used by bootloader for disabling nodes */
@@ -152,7 +153,7 @@
 		compatible = "gw,gsc";
 		reg = <0x20>;
 		interrupt-parent = <&gpio1>;
-		interrupts = <4 GPIO_ACTIVE_LOW>;
+		interrupts = <4 IRQ_TYPE_LEVEL_LOW>;
 		interrupt-controller;
 		#interrupt-cells = <1>;
 		#size-cells = <0>;
diff --git a/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
index f6182a9d201c..736074f1c3ef 100644
--- a/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
@@ -5,6 +5,7 @@
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/linux-event-codes.h>
+#include <dt-bindings/interrupt-controller/irq.h>
 
 / {
 	/* these are used by bootloader for disabling nodes */
@@ -217,7 +218,7 @@
 		compatible = "gw,gsc";
 		reg = <0x20>;
 		interrupt-parent = <&gpio1>;
-		interrupts = <4 GPIO_ACTIVE_LOW>;
+		interrupts = <4 IRQ_TYPE_LEVEL_LOW>;
 		interrupt-controller;
 		#interrupt-cells = <1>;
 		#size-cells = <0>;
diff --git a/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
index a28e79463d0c..8072ed47c6bb 100644
--- a/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
@@ -5,6 +5,7 @@
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/linux-event-codes.h>
+#include <dt-bindings/interrupt-controller/irq.h>
 
 / {
 	/* these are used by bootloader for disabling nodes */
@@ -210,7 +211,7 @@
 		compatible = "gw,gsc";
 		reg = <0x20>;
 		interrupt-parent = <&gpio1>;
-		interrupts = <4 GPIO_ACTIVE_LOW>;
+		interrupts = <4 IRQ_TYPE_LEVEL_LOW>;
 		interrupt-controller;
 		#interrupt-cells = <1>;
 		#size-cells = <0>;
diff --git a/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
index 55f368e192c0..8c9bcdd39830 100644
--- a/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
@@ -5,6 +5,7 @@
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/linux-event-codes.h>
+#include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/sound/fsl-imx-audmux.h>
 
 / {
@@ -247,7 +248,7 @@
 		compatible = "gw,gsc";
 		reg = <0x20>;
 		interrupt-parent = <&gpio1>;
-		interrupts = <4 GPIO_ACTIVE_LOW>;
+		interrupts = <4 IRQ_TYPE_LEVEL_LOW>;
 		interrupt-controller;
 		#interrupt-cells = <1>;
 		#address-cells = <1>;
diff --git a/arch/arm/boot/dts/imx6qdl-gw551x.dtsi b/arch/arm/boot/dts/imx6qdl-gw551x.dtsi
index 1516e2b0bcde..e5d803d023c8 100644
--- a/arch/arm/boot/dts/imx6qdl-gw551x.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw551x.dtsi
@@ -48,6 +48,7 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/media/tda1997x.h>
 #include <dt-bindings/input/linux-event-codes.h>
+#include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/sound/fsl-imx-audmux.h>
 
 / {
@@ -219,7 +220,7 @@
 		compatible = "gw,gsc";
 		reg = <0x20>;
 		interrupt-parent = <&gpio1>;
-		interrupts = <4 GPIO_ACTIVE_LOW>;
+		interrupts = <4 IRQ_TYPE_LEVEL_LOW>;
 		interrupt-controller;
 		#interrupt-cells = <1>;
 		#size-cells = <0>;
diff --git a/arch/arm/boot/dts/imx6qdl-gw552x.dtsi b/arch/arm/boot/dts/imx6qdl-gw552x.dtsi
index 0da6e6f7482b..290a607fede9 100644
--- a/arch/arm/boot/dts/imx6qdl-gw552x.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw552x.dtsi
@@ -5,6 +5,7 @@
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/linux-event-codes.h>
+#include <dt-bindings/interrupt-controller/irq.h>
 
 / {
 	/* these are used by bootloader for disabling nodes */
@@ -144,7 +145,7 @@
 		compatible = "gw,gsc";
 		reg = <0x20>;
 		interrupt-parent = <&gpio1>;
-		interrupts = <4 GPIO_ACTIVE_LOW>;
+		interrupts = <4 IRQ_TYPE_LEVEL_LOW>;
 		interrupt-controller;
 		#interrupt-cells = <1>;
 		#size-cells = <0>;
diff --git a/arch/arm/boot/dts/imx6qdl-gw553x.dtsi b/arch/arm/boot/dts/imx6qdl-gw553x.dtsi
index faf9a3ba61b2..c15b9cc63bf8 100644
--- a/arch/arm/boot/dts/imx6qdl-gw553x.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw553x.dtsi
@@ -47,6 +47,7 @@
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/linux-event-codes.h>
+#include <dt-bindings/interrupt-controller/irq.h>
 
 / {
 	/* these are used by bootloader for disabling nodes */
@@ -180,7 +181,7 @@
 		compatible = "gw,gsc";
 		reg = <0x20>;
 		interrupt-parent = <&gpio1>;
-		interrupts = <4 GPIO_ACTIVE_LOW>;
+		interrupts = <4 IRQ_TYPE_LEVEL_LOW>;
 		interrupt-controller;
 		#interrupt-cells = <1>;
 		#size-cells = <0>;
diff --git a/arch/arm/boot/dts/imx6qdl-gw560x.dtsi b/arch/arm/boot/dts/imx6qdl-gw560x.dtsi
index f68f9dada5b0..093a219a77ae 100644
--- a/arch/arm/boot/dts/imx6qdl-gw560x.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw560x.dtsi
@@ -47,6 +47,7 @@
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
+#include <dt-bindings/interrupt-controller/irq.h>
 
 / {
 	/* these are used by bootloader for disabling nodes */
@@ -294,7 +295,7 @@
 		compatible = "gw,gsc";
 		reg = <0x20>;
 		interrupt-parent = <&gpio1>;
-		interrupts = <4 GPIO_ACTIVE_LOW>;
+		interrupts = <4 IRQ_TYPE_LEVEL_LOW>;
 		interrupt-controller;
 		#interrupt-cells = <1>;
 		#size-cells = <0>;
diff --git a/arch/arm/boot/dts/imx6qdl-gw5903.dtsi b/arch/arm/boot/dts/imx6qdl-gw5903.dtsi
index fbe6c32bd756..e1c8dd233cab 100644
--- a/arch/arm/boot/dts/imx6qdl-gw5903.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw5903.dtsi
@@ -47,6 +47,7 @@
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/linux-event-codes.h>
+#include <dt-bindings/interrupt-controller/irq.h>
 
 / {
 	chosen {
@@ -235,7 +236,7 @@
 		compatible = "gw,gsc";
 		reg = <0x20>;
 		interrupt-parent = <&gpio1>;
-		interrupts = <4 GPIO_ACTIVE_LOW>;
+		interrupts = <4 IRQ_TYPE_LEVEL_LOW>;
 		interrupt-controller;
 		#interrupt-cells = <1>;
 		#size-cells = <0>;
diff --git a/arch/arm/boot/dts/imx6qdl-gw5904.dtsi b/arch/arm/boot/dts/imx6qdl-gw5904.dtsi
index 23c6e4047621..3cd2e717c1da 100644
--- a/arch/arm/boot/dts/imx6qdl-gw5904.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw5904.dtsi
@@ -47,6 +47,7 @@
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/linux-event-codes.h>
+#include <dt-bindings/interrupt-controller/irq.h>
 
 / {
 	/* these are used by bootloader for disabling nodes */
@@ -257,7 +258,7 @@
 		compatible = "gw,gsc";
 		reg = <0x20>;
 		interrupt-parent = <&gpio1>;
-		interrupts = <4 GPIO_ACTIVE_LOW>;
+		interrupts = <4 IRQ_TYPE_LEVEL_LOW>;
 		interrupt-controller;
 		#interrupt-cells = <1>;
 		#size-cells = <0>;
diff --git a/arch/arm/boot/dts/imx6qdl-gw5907.dtsi b/arch/arm/boot/dts/imx6qdl-gw5907.dtsi
index b1ff7c859c4d..21c68a55bcb9 100644
--- a/arch/arm/boot/dts/imx6qdl-gw5907.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw5907.dtsi
@@ -5,6 +5,7 @@
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/linux-event-codes.h>
+#include <dt-bindings/interrupt-controller/irq.h>
 
 / {
 	/* these are used by bootloader for disabling nodes */
@@ -154,7 +155,7 @@
 		compatible = "gw,gsc";
 		reg = <0x20>;
 		interrupt-parent = <&gpio1>;
-		interrupts = <4 GPIO_ACTIVE_LOW>;
+		interrupts = <4 IRQ_TYPE_LEVEL_LOW>;
 		interrupt-controller;
 		#interrupt-cells = <1>;
 		#size-cells = <0>;
diff --git a/arch/arm/boot/dts/imx6qdl-gw5910.dtsi b/arch/arm/boot/dts/imx6qdl-gw5910.dtsi
index 6c943a517ad7..ed4e22259959 100644
--- a/arch/arm/boot/dts/imx6qdl-gw5910.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw5910.dtsi
@@ -5,6 +5,7 @@
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/linux-event-codes.h>
+#include <dt-bindings/interrupt-controller/irq.h>
 
 / {
 	/* these are used by bootloader for disabling nodes */
@@ -163,7 +164,7 @@
 		compatible = "gw,gsc";
 		reg = <0x20>;
 		interrupt-parent = <&gpio1>;
-		interrupts = <4 GPIO_ACTIVE_LOW>;
+		interrupts = <4 IRQ_TYPE_LEVEL_LOW>;
 		interrupt-controller;
 		#interrupt-cells = <1>;
 		#size-cells = <0>;
diff --git a/arch/arm/boot/dts/imx6qdl-gw5912.dtsi b/arch/arm/boot/dts/imx6qdl-gw5912.dtsi
index 441d8ce97aa4..797f160249f7 100644
--- a/arch/arm/boot/dts/imx6qdl-gw5912.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw5912.dtsi
@@ -5,6 +5,7 @@
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/linux-event-codes.h>
+#include <dt-bindings/interrupt-controller/irq.h>
 
 / {
 	/* these are used by bootloader for disabling nodes */
@@ -158,7 +159,7 @@
 		compatible = "gw,gsc";
 		reg = <0x20>;
 		interrupt-parent = <&gpio1>;
-		interrupts = <4 GPIO_ACTIVE_LOW>;
+		interrupts = <4 IRQ_TYPE_LEVEL_LOW>;
 		interrupt-controller;
 		#interrupt-cells = <1>;
 		#address-cells = <1>;
diff --git a/arch/arm/boot/dts/imx6qdl-gw5913.dtsi b/arch/arm/boot/dts/imx6qdl-gw5913.dtsi
index d62a8da49367..4cd7d290f5b2 100644
--- a/arch/arm/boot/dts/imx6qdl-gw5913.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw5913.dtsi
@@ -5,6 +5,7 @@
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/linux-event-codes.h>
+#include <dt-bindings/interrupt-controller/irq.h>
 
 / {
 	/* these are used by bootloader for disabling nodes */
@@ -139,7 +140,7 @@
 		compatible = "gw,gsc";
 		reg = <0x20>;
 		interrupt-parent = <&gpio1>;
-		interrupts = <4 GPIO_ACTIVE_LOW>;
+		interrupts = <4 IRQ_TYPE_LEVEL_LOW>;
 		interrupt-controller;
 		#interrupt-cells = <1>;
 		#size-cells = <0>;
-- 
2.17.1

