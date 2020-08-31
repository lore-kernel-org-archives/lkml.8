Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2D85C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 17:11:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DEC020678
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 17:11:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728891AbgHaRL5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 13:11:57 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:45145 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728336AbgHaRLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 13:11:42 -0400
X-Originating-IP: 90.66.108.79
Received: from localhost (lfbn-lyo-1-1932-79.w90-66.abo.wanadoo.fr [90.66.108.79])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id A38CF60007;
        Mon, 31 Aug 2020 17:11:39 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 1/5] ARM: dts: at91: fix cpu node
Date:   Mon, 31 Aug 2020 19:11:24 +0200
Message-Id: <20200831171129.3886857-3-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200831171129.3886857-1-alexandre.belloni@bootlin.com>
References: <20200831171129.3886857-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The reg property is mandatory for cpu nodes, also fix the #address-cells of
the cpus node that has to be at least 1.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 arch/arm/boot/dts/at91rm9200.dtsi  | 5 +++--
 arch/arm/boot/dts/at91sam9260.dtsi | 5 +++--
 arch/arm/boot/dts/at91sam9261.dtsi | 5 +++--
 arch/arm/boot/dts/at91sam9263.dtsi | 5 +++--
 arch/arm/boot/dts/at91sam9g45.dtsi | 5 +++--
 arch/arm/boot/dts/at91sam9n12.dtsi | 5 +++--
 arch/arm/boot/dts/at91sam9rl.dtsi  | 5 +++--
 arch/arm/boot/dts/at91sam9x5.dtsi  | 5 +++--
 arch/arm/boot/dts/sam9x60.dtsi     | 5 +++--
 9 files changed, 27 insertions(+), 18 deletions(-)

diff --git a/arch/arm/boot/dts/at91rm9200.dtsi b/arch/arm/boot/dts/at91rm9200.dtsi
index a5040f5ea641..231313e4c926 100644
--- a/arch/arm/boot/dts/at91rm9200.dtsi
+++ b/arch/arm/boot/dts/at91rm9200.dtsi
@@ -39,12 +39,13 @@ aliases {
 		ssc2 = &ssc2;
 	};
 	cpus {
-		#address-cells = <0>;
+		#address-cells = <1>;
 		#size-cells = <0>;
 
-		cpu {
+		cpu@0 {
 			compatible = "arm,arm920t";
 			device_type = "cpu";
+			reg = <0>;
 		};
 	};
 
diff --git a/arch/arm/boot/dts/at91sam9260.dtsi b/arch/arm/boot/dts/at91sam9260.dtsi
index 6afbb48e7ff0..85041ad5e29a 100644
--- a/arch/arm/boot/dts/at91sam9260.dtsi
+++ b/arch/arm/boot/dts/at91sam9260.dtsi
@@ -36,12 +36,13 @@ aliases {
 		ssc0 = &ssc0;
 	};
 	cpus {
-		#address-cells = <0>;
+		#address-cells = <1>;
 		#size-cells = <0>;
 
-		cpu {
+		cpu@0 {
 			compatible = "arm,arm926ej-s";
 			device_type = "cpu";
+			reg = <0>;
 		};
 	};
 
diff --git a/arch/arm/boot/dts/at91sam9261.dtsi b/arch/arm/boot/dts/at91sam9261.dtsi
index 5ed3d745ac86..bb6480afc6f6 100644
--- a/arch/arm/boot/dts/at91sam9261.dtsi
+++ b/arch/arm/boot/dts/at91sam9261.dtsi
@@ -33,12 +33,13 @@ aliases {
 	};
 
 	cpus {
-		#address-cells = <0>;
+		#address-cells = <1>;
 		#size-cells = <0>;
 
-		cpu {
+		cpu@0 {
 			compatible = "arm,arm926ej-s";
 			device_type = "cpu";
+			reg = <0>;
 		};
 	};
 
diff --git a/arch/arm/boot/dts/at91sam9263.dtsi b/arch/arm/boot/dts/at91sam9263.dtsi
index 5c990cfae254..a94fa2ae482c 100644
--- a/arch/arm/boot/dts/at91sam9263.dtsi
+++ b/arch/arm/boot/dts/at91sam9263.dtsi
@@ -35,12 +35,13 @@ aliases {
 	};
 
 	cpus {
-		#address-cells = <0>;
+		#address-cells = <1>;
 		#size-cells = <0>;
 
-		cpu {
+		cpu@0 {
 			compatible = "arm,arm926ej-s";
 			device_type = "cpu";
+			reg = <0>;
 		};
 	};
 
diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
index 1fbee2a7785f..8fe2dbd39040 100644
--- a/arch/arm/boot/dts/at91sam9g45.dtsi
+++ b/arch/arm/boot/dts/at91sam9g45.dtsi
@@ -41,12 +41,13 @@ aliases {
 		pwm0 = &pwm0;
 	};
 	cpus {
-		#address-cells = <0>;
+		#address-cells = <1>;
 		#size-cells = <0>;
 
-		cpu {
+		cpu@0 {
 			compatible = "arm,arm926ej-s";
 			device_type = "cpu";
+			reg = <0>;
 		};
 	};
 
diff --git a/arch/arm/boot/dts/at91sam9n12.dtsi b/arch/arm/boot/dts/at91sam9n12.dtsi
index a994d076dc7e..9e1dc0070193 100644
--- a/arch/arm/boot/dts/at91sam9n12.dtsi
+++ b/arch/arm/boot/dts/at91sam9n12.dtsi
@@ -37,12 +37,13 @@ aliases {
 		pwm0 = &pwm0;
 	};
 	cpus {
-		#address-cells = <0>;
+		#address-cells = <1>;
 		#size-cells = <0>;
 
-		cpu {
+		cpu@0 {
 			compatible = "arm,arm926ej-s";
 			device_type = "cpu";
+			reg = <0>;
 		};
 	};
 
diff --git a/arch/arm/boot/dts/at91sam9rl.dtsi b/arch/arm/boot/dts/at91sam9rl.dtsi
index 4d70194fd808..b737f21f1b4c 100644
--- a/arch/arm/boot/dts/at91sam9rl.dtsi
+++ b/arch/arm/boot/dts/at91sam9rl.dtsi
@@ -38,12 +38,13 @@ aliases {
 	};
 
 	cpus {
-		#address-cells = <0>;
+		#address-cells = <1>;
 		#size-cells = <0>;
 
-		cpu {
+		cpu@0 {
 			compatible = "arm,arm926ej-s";
 			device_type = "cpu";
+			reg = <0>;
 		};
 	};
 
diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
index 948fe99ab6c3..442d3b8cda69 100644
--- a/arch/arm/boot/dts/at91sam9x5.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5.dtsi
@@ -39,12 +39,13 @@ aliases {
 		pwm0 = &pwm0;
 	};
 	cpus {
-		#address-cells = <0>;
+		#address-cells = <1>;
 		#size-cells = <0>;
 
-		cpu {
+		cpu@0 {
 			compatible = "arm,arm926ej-s";
 			device_type = "cpu";
+			reg = <0>;
 		};
 	};
 
diff --git a/arch/arm/boot/dts/sam9x60.dtsi b/arch/arm/boot/dts/sam9x60.dtsi
index d10843da4a85..3a9fa40b2b1c 100644
--- a/arch/arm/boot/dts/sam9x60.dtsi
+++ b/arch/arm/boot/dts/sam9x60.dtsi
@@ -32,12 +32,13 @@ aliases {
 	};
 
 	cpus {
-		#address-cells = <0>;
+		#address-cells = <1>;
 		#size-cells = <0>;
 
-		cpu {
+		cpu@0 {
 			compatible = "arm,arm926ej-s";
 			device_type = "cpu";
+			reg = <0>;
 		};
 	};
 
-- 
2.26.2

