Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A85FC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 13:12:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D61AC214DB
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 13:12:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbgFQNMD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 09:12:03 -0400
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:37110 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726134AbgFQNMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 09:12:00 -0400
Received: from [5.157.120.79] (port=34860 helo=melee.fritz.box)
        by hostingweb31.netsons.net with esmtpa (Exim 4.93)
        (envelope-from <luca@lucaceresoli.net>)
        id 1jlXr9-000Frj-Rh; Wed, 17 Jun 2020 15:11:55 +0200
From:   Luca Ceresoli <luca@lucaceresoli.net>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Luca Ceresoli <luca@lucaceresoli.net>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Keerthy <j-keerthy@ti.com>,
        Axel Lin <axel.lin@ingics.com>
Subject: [PATCH v2 2/4] dt-bindings: mfd: lp87565: convert to yaml
Date:   Wed, 17 Jun 2020 15:11:43 +0200
Message-Id: <20200617131145.15696-3-luca@lucaceresoli.net>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200617131145.15696-1-luca@lucaceresoli.net>
References: <20200617131145.15696-1-luca@lucaceresoli.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hostingweb31.netsons.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: hostingweb31.netsons.net: authenticated_id: luca+lucaceresoli.net/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: hostingweb31.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The definition of "xxx-in-supply" was generic, thus define in detail the
possible cases for each chip variant.

Also document that the only possible I2C slave address is 0x60 as per the
datasheet and fix the second example accordingly.

Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>

---

Changes in v2:
 - this patch replaces patch "regulator: lp87565: dt: remove duplicated
   section" in RFC,v1 (Rob Herring)
 - use capital letters consistently (Lee Jones)
 - replace "regulator" -> "mfd" in subject line (Lee Jones)
 - replace "dt:" suffix with "dt-bindings:" prefix in subject line
---
 .../devicetree/bindings/mfd/lp87565.txt       |  79 -----------
 .../devicetree/bindings/mfd/ti,lp875xx.yaml   | 134 ++++++++++++++++++
 2 files changed, 134 insertions(+), 79 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mfd/lp87565.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/ti,lp875xx.yaml

diff --git a/Documentation/devicetree/bindings/mfd/lp87565.txt b/Documentation/devicetree/bindings/mfd/lp87565.txt
deleted file mode 100644
index 41671e0dc26b..000000000000
--- a/Documentation/devicetree/bindings/mfd/lp87565.txt
+++ /dev/null
@@ -1,79 +0,0 @@
-TI LP87565 PMIC MFD driver
-
-Required properties:
-  - compatible:	"ti,lp87565", "ti,lp87565-q1"
-  - reg:		I2C slave address.
-  - gpio-controller:	Marks the device node as a GPIO Controller.
-  - #gpio-cells:	Should be two.  The first cell is the pin number and
-			the second cell is used to specify flags.
-			See ../gpio/gpio.txt for more information.
-  - xxx-in-supply:	Phandle to parent supply node of each regulator
-			populated under regulators node. xxx should match
-			the supply_name populated in driver.
-Example:
-
-lp87565_pmic: pmic@60 {
-	compatible = "ti,lp87565-q1";
-	reg = <0x60>;
-	gpio-controller;
-	#gpio-cells = <2>;
-
-	buck10-in-supply = <&vsys_3v3>;
-	buck23-in-supply = <&vsys_3v3>;
-
-	regulators: regulators {
-		buck10_reg: buck10 {
-			/* VDD_MPU */
-			regulator-name = "buck10";
-			regulator-min-microvolt = <850000>;
-			regulator-max-microvolt = <1250000>;
-			regulator-always-on;
-			regulator-boot-on;
-		};
-
-		buck23_reg: buck23 {
-			/* VDD_GPU */
-			regulator-name = "buck23";
-			regulator-min-microvolt = <850000>;
-			regulator-max-microvolt = <1250000>;
-			regulator-boot-on;
-			regulator-always-on;
-		};
-	};
-};
-
-TI LP87561 PMIC:
-
-This is a single output 4-phase regulator configuration
-
-Required properties:
-  - compatible:	"ti,lp87561-q1"
-  - reg:		I2C slave address.
-  - gpio-controller:	Marks the device node as a GPIO Controller.
-  - #gpio-cells:	Should be two.  The first cell is the pin number and
-			the second cell is used to specify flags.
-			See ../gpio/gpio.txt for more information.
-  - xxx-in-supply:	Phandle to parent supply node of each regulator
-			populated under regulators node. xxx should match
-			the supply_name populated in driver.
-Example:
-
-lp87561_pmic: pmic@62 {
-	compatible = "ti,lp87561-q1";
-	reg = <0x62>;
-	gpio-controller;
-	#gpio-cells = <2>;
-
-	buck3210-in-supply = <&vsys_3v3>;
-
-	regulators: regulators {
-		buck3210_reg: buck3210 {
-			/* VDD_CORE */
-			regulator-name = "buck3210";
-			regulator-min-microvolt = <800000>;
-			regulator-max-microvolt = <800000>;
-			regulator-always-on;
-			regulator-boot-on;
-		};
-	};
-};
diff --git a/Documentation/devicetree/bindings/mfd/ti,lp875xx.yaml b/Documentation/devicetree/bindings/mfd/ti,lp875xx.yaml
new file mode 100644
index 000000000000..f6d1ef4fb441
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/ti,lp875xx.yaml
@@ -0,0 +1,134 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/ti,lp875xx.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TI LP875xx PMIC MFD driver
+
+maintainers:
+  - Keerthy <j-keerthy@ti.com>
+
+properties:
+  compatible:
+    oneOf:
+      - const: ti,lp87565
+      - const: ti,lp87565-q1
+      - const: ti,lp87561-q1
+
+  reg:
+    description: I2C slave address
+    const: 0x60
+
+  gpio-controller: true
+
+  '#gpio-cells':
+    description:
+      The first cell is the pin number.
+      The second cell is is used to specify flags.
+      See ../gpio/gpio.txt for more information.
+    const: 2
+
+required:
+  - compatible
+  - reg
+  - gpio-controller
+  - '#gpio-cells'
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - ti,lp87565
+              - ti,lp87565-q1
+    then:
+      properties:
+        buck10-in-supply:
+          description:
+            Phandle to parent supply node for BUCK0 and BUCK1 converters.
+
+        buck23-in-supply:
+          description:
+            Phandle to parent supply node for BUCK2 and BUCK3 converters.
+
+      required:
+        - buck10-in-supply
+        - buck23-in-supply
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - ti,lp87561-q1
+    then:
+      properties:
+        buck3210-in-supply:
+          description:
+            Phandle to parent supply node for all the four BUCK converters.
+
+      required:
+        - buck3210-in-supply
+
+examples:
+  - |
+    /* TI LP87565-Q1 PMIC (dual 2-phase output configuration) */
+    &i2c0 {
+        lp87565_pmic: pmic@60 {
+            compatible = "ti,lp87565-q1";
+            reg = <0x60>;
+            gpio-controller;
+            #gpio-cells = <2>;
+
+            buck10-in-supply = <&vsys_3v3>;
+            buck23-in-supply = <&vsys_3v3>;
+
+            regulators: regulators {
+                buck10_reg: buck10 {
+                    /* VDD_MPU */
+                    regulator-name = "buck10";
+                    regulator-min-microvolt = <850000>;
+                    regulator-max-microvolt = <1250000>;
+                    regulator-always-on;
+                    regulator-boot-on;
+                };
+
+                buck23_reg: buck23 {
+                    /* VDD_GPU */
+                    regulator-name = "buck23";
+                    regulator-min-microvolt = <850000>;
+                    regulator-max-microvolt = <1250000>;
+                    regulator-boot-on;
+                    regulator-always-on;
+                };
+            };
+        };
+    };
+
+  - |
+    /* TI LP87561 PMIC (single 4-phase output configuration) */
+    &i2c0 {
+        lp87561_pmic: pmic@62 {
+            compatible = "ti,lp87561-q1";
+            reg = <0x60>;
+            gpio-controller;
+            #gpio-cells = <2>;
+
+            buck3210-in-supply = <&vsys_3v3>;
+
+            regulators: regulators {
+                buck3210_reg: buck3210 {
+                    /* VDD_CORE */
+                    regulator-name = "buck3210";
+                    regulator-min-microvolt = <800000>;
+                    regulator-max-microvolt = <800000>;
+                    regulator-always-on;
+                    regulator-boot-on;
+                };
+            };
+        };
+    };
+
+...
-- 
2.27.0

