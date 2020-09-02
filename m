Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65784C433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 14:31:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47C4B20767
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 14:31:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728169AbgIBO3t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 10:29:49 -0400
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:51743 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728033AbgIBOYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 10:24:12 -0400
Received: from [88.147.20.154] (port=49114 helo=melee.dev.aim)
        by hostingweb31.netsons.net with esmtpa (Exim 4.93)
        (envelope-from <luca@lucaceresoli.net>)
        id 1kDTfT-0002rt-Fk; Wed, 02 Sep 2020 16:23:19 +0200
From:   Luca Ceresoli <luca@lucaceresoli.net>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Luca Ceresoli <luca@lucaceresoli.net>, Keerthy <j-keerthy@ti.com>,
        Axel Lin <axel.lin@ingics.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/3] dt-bindings: mfd: lp87565: convert to yaml
Date:   Wed,  2 Sep 2020 16:22:57 +0200
Message-Id: <20200902142259.28349-2-luca@lucaceresoli.net>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200902142259.28349-1-luca@lucaceresoli.net>
References: <20200902142259.28349-1-luca@lucaceresoli.net>
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

Also apply a few smaller improvements:

 - document that the only possible I2C slave address is 0x60 as per the
   datasheet and fix the second example accordingly
 - The definition of "xxx-in-supply" was generic, thus define in detail the
   possible cases for each chip variant
 - remove "MFD driver" from the title as it is implementation specific
 - replace "PMIC" with "buck converter" in title as it is more informative

Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>

---

Changes in v5:
 - describe the "regulators" node too (Rob)
 - add 'additionalProperties: false' (Rob)
 - simplify supply description
 - update commit message

Changes in v4:
 - split in two different bindings (Rob)
 - remove "MFD driver" from title as it is implementation specific; also
   replace "PMIC" with "buck converter" which is more informative

Changes in v3:
 - fix yaml errors

Changes in v2:
 - this patch replaces patch "regulator: lp87565: dt: remove duplicated
   section" in RFC,v1 (Rob Herring)
 - use capital letters consistently (Lee Jones)
 - replace "regulator" -> "mfd" in subject line (Lee Jones)
 - replace "dt:" suffix with "dt-bindings:" prefix in subject line
---
 .../devicetree/bindings/mfd/lp87565.txt       |  79 --------------
 .../bindings/mfd/ti,lp87561-q1.yaml           |  83 ++++++++++++++
 .../bindings/mfd/ti,lp87565-q1.yaml           | 101 ++++++++++++++++++
 3 files changed, 184 insertions(+), 79 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mfd/lp87565.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/ti,lp87561-q1.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/ti,lp87565-q1.yaml

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
diff --git a/Documentation/devicetree/bindings/mfd/ti,lp87561-q1.yaml b/Documentation/devicetree/bindings/mfd/ti,lp87561-q1.yaml
new file mode 100644
index 000000000000..a7e57c0913e1
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/ti,lp87561-q1.yaml
@@ -0,0 +1,83 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/ti,lp87561-q1.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TI LP87561-Q1 single 4-phase output buck converter
+
+maintainers:
+  - Keerthy <j-keerthy@ti.com>
+
+properties:
+  compatible:
+    const: ti,lp87561-q1
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
+  buck3210-in-supply:
+    description:
+      Voltage regulator supply for all the four BUCK converters.
+
+  regulators:
+    type: object
+
+    properties:
+      buck3210:
+        type: object
+        $ref: /schemas/regulator/regulator.yaml#
+
+    required:
+      - buck3210
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - gpio-controller
+  - '#gpio-cells'
+  - buck3210-in-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c@0 {
+        reg = <0x0 0x100>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        pmic@60 {
+            compatible = "ti,lp87561-q1";
+            reg = <0x60>;
+            gpio-controller;
+            #gpio-cells = <2>;
+
+            buck3210-in-supply = <&vsys_3v3>;
+
+            regulators {
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
diff --git a/Documentation/devicetree/bindings/mfd/ti,lp87565-q1.yaml b/Documentation/devicetree/bindings/mfd/ti,lp87565-q1.yaml
new file mode 100644
index 000000000000..1da6d6a958c9
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/ti,lp87565-q1.yaml
@@ -0,0 +1,101 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/ti,lp87565-q1.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TI LP87565-Q1 / LP87565 dual 2-phase output buck converter
+
+maintainers:
+  - Keerthy <j-keerthy@ti.com>
+
+properties:
+  compatible:
+    oneOf:
+      - const: ti,lp87565
+      - const: ti,lp87565-q1
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
+  buck10-in-supply:
+    description:
+      Voltage regulator supply for BUCK0 and BUCK1 converters.
+
+  buck23-in-supply:
+    description:
+      Voltage regulator supply for BUCK2 and BUCK3 converters.
+
+  regulators:
+    type: object
+
+    patternProperties:
+      "^buck(10|23)$":
+        type: object
+        $ref: /schemas/regulator/regulator.yaml#
+
+    required:
+      - buck10
+      - buck23
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - gpio-controller
+  - '#gpio-cells'
+  - buck10-in-supply
+  - buck23-in-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c@0 {
+        reg = <0x0 0x100>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        pmic@60 {
+            compatible = "ti,lp87565-q1";
+            reg = <0x60>;
+            gpio-controller;
+            #gpio-cells = <2>;
+
+            buck10-in-supply = <&vsys_3v3>;
+            buck23-in-supply = <&vsys_3v3>;
+
+            regulators {
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
+...
-- 
2.28.0

