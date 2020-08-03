Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E40FFC433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 02:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C45F92070A
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 02:28:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbgHCC2d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Aug 2020 22:28:33 -0400
Received: from inva020.nxp.com ([92.121.34.13]:49816 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725820AbgHCC2d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Aug 2020 22:28:33 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id C56761A0E19;
        Mon,  3 Aug 2020 04:28:28 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 98AF81A0E2B;
        Mon,  3 Aug 2020 04:28:25 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id B870840309;
        Mon,  3 Aug 2020 04:28:21 +0200 (CEST)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        yibin.gong@nxp.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH] dt-bindings: regulator: Convert pfuze100 to json-schema
Date:   Mon,  3 Aug 2020 10:23:59 +0800
Message-Id: <1596421439-19591-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the pfuze100 regulator binding to DT schema format using
json-schema.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 .../devicetree/bindings/regulator/pfuze100.txt     | 394 ---------------------
 .../devicetree/bindings/regulator/pfuze100.yaml    | 186 ++++++++++
 2 files changed, 186 insertions(+), 394 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/regulator/pfuze100.txt
 create mode 100644 Documentation/devicetree/bindings/regulator/pfuze100.yaml

diff --git a/Documentation/devicetree/bindings/regulator/pfuze100.txt b/Documentation/devicetree/bindings/regulator/pfuze100.txt
deleted file mode 100644
index 4d3b12b..0000000
--- a/Documentation/devicetree/bindings/regulator/pfuze100.txt
+++ /dev/null
@@ -1,394 +0,0 @@
-PFUZE100 family of regulators
-
-Required properties:
-- compatible: "fsl,pfuze100", "fsl,pfuze200", "fsl,pfuze3000", "fsl,pfuze3001"
-- reg: I2C slave address
-
-Optional properties:
-- fsl,pfuze-support-disable-sw: Boolean, if present disable all unused switch
-  regulators to save power consumption. Attention, ensure that all important
-  regulators (e.g. DDR ref, DDR supply) has set the "regulator-always-on"
-  property. If not present, the switched regulators are always on and can't be
-  disabled. This binding is a workaround to keep backward compatibility with
-  old dtb's which rely on the fact that the switched regulators are always on
-  and don't mark them explicit as "regulator-always-on".
-- fsl,pmic-stby-poweroff: if present, configure the PMIC to shutdown all
-  power rails when PMIC_STBY_REQ line is asserted during the power off sequence.
-  Use this option if the SoC should be powered off by external power
-  management IC (PMIC) on PMIC_STBY_REQ signal.
-  As opposite to PMIC_STBY_REQ boards can implement PMIC_ON_REQ signal.
-
-Required child node:
-- regulators: This is the list of child nodes that specify the regulator
-  initialization data for defined regulators. Please refer to below doc
-  Documentation/devicetree/bindings/regulator/regulator.txt.
-
-  The valid names for regulators are:
-  --PFUZE100
-  sw1ab,sw1c,sw2,sw3a,sw3b,sw4,swbst,vsnvs,vrefddr,vgen1~vgen6
-  --PFUZE200
-  sw1ab,sw2,sw3a,sw3b,swbst,vsnvs,vrefddr,vgen1~vgen6,coin
-  --PFUZE3000
-  sw1a,sw1b,sw2,sw3,swbst,vsnvs,vrefddr,vldo1,vldo2,vccsd,v33,vldo3,vldo4
-  --PFUZE3001
-  sw1,sw2,sw3,vsnvs,vldo1,vldo2,vccsd,v33,vldo3,vldo4
-
-Each regulator is defined using the standard binding for regulators.
-
-Example 1: PFUZE100
-
-	pfuze100: pmic@8 {
-		compatible = "fsl,pfuze100";
-		reg = <0x08>;
-
-		regulators {
-			sw1a_reg: sw1ab {
-				regulator-min-microvolt = <300000>;
-				regulator-max-microvolt = <1875000>;
-				regulator-boot-on;
-				regulator-always-on;
-				regulator-ramp-delay = <6250>;
-			};
-
-			sw1c_reg: sw1c {
-				regulator-min-microvolt = <300000>;
-				regulator-max-microvolt = <1875000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			sw2_reg: sw2 {
-				regulator-min-microvolt = <800000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			sw3a_reg: sw3a {
-				regulator-min-microvolt = <400000>;
-				regulator-max-microvolt = <1975000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			sw3b_reg: sw3b {
-				regulator-min-microvolt = <400000>;
-				regulator-max-microvolt = <1975000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			sw4_reg: sw4 {
-				regulator-min-microvolt = <800000>;
-				regulator-max-microvolt = <3300000>;
-			};
-
-			swbst_reg: swbst {
-				regulator-min-microvolt = <5000000>;
-				regulator-max-microvolt = <5150000>;
-			};
-
-			snvs_reg: vsnvs {
-				regulator-min-microvolt = <1000000>;
-				regulator-max-microvolt = <3000000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			vref_reg: vrefddr {
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			vgen1_reg: vgen1 {
-				regulator-min-microvolt = <800000>;
-				regulator-max-microvolt = <1550000>;
-			};
-
-			vgen2_reg: vgen2 {
-				regulator-min-microvolt = <800000>;
-				regulator-max-microvolt = <1550000>;
-			};
-
-			vgen3_reg: vgen3 {
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <3300000>;
-			};
-
-			vgen4_reg: vgen4 {
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-always-on;
-			};
-
-			vgen5_reg: vgen5 {
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-always-on;
-			};
-
-			vgen6_reg: vgen6 {
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-always-on;
-			};
-		};
-	};
-
-
-Example 2: PFUZE200
-
-	pfuze200: pmic@8 {
-		compatible = "fsl,pfuze200";
-		reg = <0x08>;
-
-		regulators {
-			sw1a_reg: sw1ab {
-				regulator-min-microvolt = <300000>;
-				regulator-max-microvolt = <1875000>;
-				regulator-boot-on;
-				regulator-always-on;
-				regulator-ramp-delay = <6250>;
-			};
-
-			sw2_reg: sw2 {
-				regulator-min-microvolt = <800000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			sw3a_reg: sw3a {
-				regulator-min-microvolt = <400000>;
-				regulator-max-microvolt = <1975000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			sw3b_reg: sw3b {
-				regulator-min-microvolt = <400000>;
-				regulator-max-microvolt = <1975000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			swbst_reg: swbst {
-				regulator-min-microvolt = <5000000>;
-				regulator-max-microvolt = <5150000>;
-			};
-
-			snvs_reg: vsnvs {
-				regulator-min-microvolt = <1000000>;
-				regulator-max-microvolt = <3000000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			vref_reg: vrefddr {
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			vgen1_reg: vgen1 {
-				regulator-min-microvolt = <800000>;
-				regulator-max-microvolt = <1550000>;
-			};
-
-			vgen2_reg: vgen2 {
-				regulator-min-microvolt = <800000>;
-				regulator-max-microvolt = <1550000>;
-			};
-
-			vgen3_reg: vgen3 {
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <3300000>;
-			};
-
-			vgen4_reg: vgen4 {
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-always-on;
-			};
-
-			vgen5_reg: vgen5 {
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-always-on;
-			};
-
-			vgen6_reg: vgen6 {
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-always-on;
-			};
-
-			coin_reg: coin {
-				regulator-min-microvolt = <2500000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-always-on;
-			};
-		};
-	};
-
-Example 3: PFUZE3000
-
-	pfuze3000: pmic@8 {
-		compatible = "fsl,pfuze3000";
-		reg = <0x08>;
-
-		regulators {
-			sw1a_reg: sw1a {
-				regulator-min-microvolt = <700000>;
-				regulator-max-microvolt = <1475000>;
-				regulator-boot-on;
-				regulator-always-on;
-				regulator-ramp-delay = <6250>;
-			};
-			/* use sw1c_reg to align with pfuze100/pfuze200 */
-			sw1c_reg: sw1b {
-				regulator-min-microvolt = <700000>;
-				regulator-max-microvolt = <1475000>;
-				regulator-boot-on;
-				regulator-always-on;
-				regulator-ramp-delay = <6250>;
-			};
-
-			sw2_reg: sw2 {
-				regulator-min-microvolt = <2500000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			sw3a_reg: sw3 {
-				regulator-min-microvolt = <900000>;
-				regulator-max-microvolt = <1650000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			swbst_reg: swbst {
-				regulator-min-microvolt = <5000000>;
-				regulator-max-microvolt = <5150000>;
-			};
-
-			snvs_reg: vsnvs {
-				regulator-min-microvolt = <1000000>;
-				regulator-max-microvolt = <3000000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			vref_reg: vrefddr {
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			vgen1_reg: vldo1 {
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-always-on;
-			};
-
-			vgen2_reg: vldo2 {
-				regulator-min-microvolt = <800000>;
-				regulator-max-microvolt = <1550000>;
-			};
-
-			vgen3_reg: vccsd {
-				regulator-min-microvolt = <2850000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-always-on;
-			};
-
-			vgen4_reg: v33 {
-				regulator-min-microvolt = <2850000>;
-				regulator-max-microvolt = <3300000>;
-			};
-
-			vgen5_reg: vldo3 {
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-always-on;
-			};
-
-			vgen6_reg: vldo4 {
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-always-on;
-			};
-		};
-	};
-
-Example 4: PFUZE 3001
-
-	pfuze3001: pmic@8 {
-		compatible = "fsl,pfuze3001";
-		reg = <0x08>;
-
-		regulators {
-			sw1_reg: sw1 {
-				regulator-min-microvolt = <700000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			sw2_reg: sw2 {
-				regulator-min-microvolt = <1500000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			sw3_reg: sw3 {
-				regulator-min-microvolt = <900000>;
-				regulator-max-microvolt = <1650000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			snvs_reg: vsnvs {
-				regulator-min-microvolt = <1000000>;
-				regulator-max-microvolt = <3000000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			vgen1_reg: vldo1 {
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-always-on;
-			};
-
-			vgen2_reg: vldo2 {
-				regulator-min-microvolt = <800000>;
-				regulator-max-microvolt = <1550000>;
-				regulator-always-on;
-			};
-
-			vgen3_reg: vccsd {
-				regulator-min-microvolt = <2850000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-always-on;
-			};
-
-			vgen4_reg: v33 {
-				regulator-min-microvolt = <2850000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-always-on;
-			};
-
-			vgen5_reg: vldo3 {
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-always-on;
-			};
-
-			vgen6_reg: vldo4 {
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-always-on;
-			};
-		};
-	};
diff --git a/Documentation/devicetree/bindings/regulator/pfuze100.yaml b/Documentation/devicetree/bindings/regulator/pfuze100.yaml
new file mode 100644
index 0000000..c6de496
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/pfuze100.yaml
@@ -0,0 +1,186 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/pfuze100.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: PFUZE100 family of regulators
+
+maintainers:
+  - Robin Gong <yibin.gong@nxp.com>
+
+description: |
+  The valid names for regulators are:
+  --PFUZE100
+  sw1ab,sw1c,sw2,sw3a,sw3b,sw4,swbst,vsnvs,vrefddr,vgen1~vgen6
+  --PFUZE200
+  sw1ab,sw2,sw3a,sw3b,swbst,vsnvs,vrefddr,vgen1~vgen6,coin
+  --PFUZE3000
+  sw1a,sw1b,sw2,sw3,swbst,vsnvs,vrefddr,vldo1,vldo2,vccsd,v33,vldo3,vldo4
+  --PFUZE3001
+  sw1,sw2,sw3,vsnvs,vldo1,vldo2,vccsd,v33,vldo3,vldo4
+
+  Each regulator is defined using the standard binding for regulators.
+
+properties:
+  $nodename:
+    pattern: "^pmic@[0-9]$"
+
+  compatible:
+    enum:
+      - fsl,pfuze100
+      - fsl,pfuze200
+      - fsl,pfuze3000
+      - fsl,pfuze3001
+
+  reg:
+    maxItems: 1
+
+  fsl,pfuze-support-disable-sw:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: |
+      Boolean, if present disable all unused switch regulators to save power
+      consumption. Attention, ensure that all important regulators
+      (e.g. DDR ref, DDR supply) has set the "regulator-always-on" property.
+      If not present, the switched regulators are always on and can't be
+      disabled. This binding is a workaround to keep backward compatibility
+      with old dtb's which rely on the fact that the switched regulators are
+      always on and don't mark them explicit as "regulator-always-on".
+
+  fsl,pmic-stby-poweroff:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: |
+      if present, configure the PMIC to shutdown all
+      power rails when PMIC_STBY_REQ line is asserted during the power off sequence.
+      Use this option if the SoC should be powered off by external power management
+      IC (PMIC) on PMIC_STBY_REQ signal.
+      As opposite to PMIC_STBY_REQ boards can implement PMIC_ON_REQ signal.
+
+  regulators:
+    type: object
+    description: |
+      list of regulators provided by this controller.
+
+    patternProperties:
+      "^sw([1-4]|[1-4][a-c]|[1-4][a-c][a-c])$":
+        $ref: "regulator.yaml#"
+        type: object
+
+      "^vgen[1-6]$":
+        $ref: "regulator.yaml#"
+        type: object
+
+      "^(vsnvs|vref|vrefddr|swbst|coin)$":
+        $ref: "regulator.yaml#"
+        type: object
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        pmic@8 {
+            compatible = "fsl,pfuze100";
+            reg = <0x08>;
+
+            regulators {
+                sw1a_reg: sw1ab {
+                    regulator-min-microvolt = <300000>;
+                    regulator-max-microvolt = <1875000>;
+                    regulator-boot-on;
+                    regulator-always-on;
+                    regulator-ramp-delay = <6250>;
+                };
+
+                sw1c_reg: sw1c {
+                    regulator-min-microvolt = <300000>;
+                    regulator-max-microvolt = <1875000>;
+                    regulator-boot-on;
+                    regulator-always-on;
+                };
+
+                sw2_reg: sw2 {
+                    regulator-min-microvolt = <800000>;
+                    regulator-max-microvolt = <3300000>;
+                    regulator-boot-on;
+                    regulator-always-on;
+                };
+
+                sw3a_reg: sw3a {
+                    regulator-min-microvolt = <400000>;
+                    regulator-max-microvolt = <1975000>;
+                    regulator-boot-on;
+                    regulator-always-on;
+                };
+
+                sw3b_reg: sw3b {
+                    regulator-min-microvolt = <400000>;
+                    regulator-max-microvolt = <1975000>;
+                    regulator-boot-on;
+                    regulator-always-on;
+                };
+
+                sw4_reg: sw4 {
+                    regulator-min-microvolt = <800000>;
+                    regulator-max-microvolt = <3300000>;
+                };
+
+                swbst_reg: swbst {
+                    regulator-min-microvolt = <5000000>;
+                    regulator-max-microvolt = <5150000>;
+                };
+
+                snvs_reg: vsnvs {
+                    regulator-min-microvolt = <1000000>;
+                    regulator-max-microvolt = <3000000>;
+                    regulator-boot-on;
+                    regulator-always-on;
+                };
+
+                vref_reg: vrefddr {
+                    regulator-boot-on;
+                    regulator-always-on;
+                };
+
+                vgen1_reg: vgen1 {
+                    regulator-min-microvolt = <800000>;
+                    regulator-max-microvolt = <1550000>;
+                };
+
+                vgen2_reg: vgen2 {
+                    regulator-min-microvolt = <800000>;
+                    regulator-max-microvolt = <1550000>;
+                };
+
+                vgen3_reg: vgen3 {
+                    regulator-min-microvolt = <1800000>;
+                    regulator-max-microvolt = <3300000>;
+                };
+
+                vgen4_reg: vgen4 {
+                    regulator-min-microvolt = <1800000>;
+                    regulator-max-microvolt = <3300000>;
+                    regulator-always-on;
+                };
+
+                vgen5_reg: vgen5 {
+                    regulator-min-microvolt = <1800000>;
+                    regulator-max-microvolt = <3300000>;
+                    regulator-always-on;
+                };
+
+                vgen6_reg: vgen6 {
+                    regulator-min-microvolt = <1800000>;
+                    regulator-max-microvolt = <3300000>;
+                    regulator-always-on;
+                };
+            };
+        };
+    };
-- 
2.7.4

