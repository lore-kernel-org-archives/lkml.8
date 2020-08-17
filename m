Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9D63C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 14:50:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 921B2204FD
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 14:50:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729061AbgHQOuh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 10:50:37 -0400
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:55232 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728651AbgHQOua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 10:50:30 -0400
Received: from [78.134.86.56] (port=43576 helo=melee.fritz.box)
        by hostingweb31.netsons.net with esmtpa (Exim 4.93)
        (envelope-from <luca@lucaceresoli.net>)
        id 1k7gSw-0003f6-4o; Mon, 17 Aug 2020 16:50:26 +0200
From:   Luca Ceresoli <luca@lucaceresoli.net>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Luca Ceresoli <luca@lucaceresoli.net>, Keerthy <j-keerthy@ti.com>,
        Axel Lin <axel.lin@ingics.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/3] dt-bindings: mfd: add LP87524-Q1
Date:   Mon, 17 Aug 2020 16:50:17 +0200
Message-Id: <20200817145018.3992-3-luca@lucaceresoli.net>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817145018.3992-1-luca@lucaceresoli.net>
References: <20200817145018.3992-1-luca@lucaceresoli.net>
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

Add the LP87524-Q1 to the bindings along with an example. This is a variant
of the LP87565-Q1 and LP87561-Q1 chips which already have bindings.

Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>

---

Changes in v4:
 - reformat as a standalone file

Changes in v3:
 - fix yaml errors

Changes in v2:
 - RFC,v1 was based on the txt file, rewrite for yaml
 - use uppercase consistently in model names (Lee Jones)
 - replace "regulator" -> "mfd" in subject line (Lee Jones)
 - replace "dt:" suffix with "dt-bindings:" prefix in subject line
---
 .../bindings/mfd/ti,lp87524-q1.yaml           | 105 ++++++++++++++++++
 1 file changed, 105 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/ti,lp87524-q1.yaml

diff --git a/Documentation/devicetree/bindings/mfd/ti,lp87524-q1.yaml b/Documentation/devicetree/bindings/mfd/ti,lp87524-q1.yaml
new file mode 100644
index 000000000000..1193fcb19739
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/ti,lp87524-q1.yaml
@@ -0,0 +1,105 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/ti,lp87524-q1.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TI LP87524-Q1 four 1-phase output buck converter
+
+maintainers:
+  - Keerthy <j-keerthy@ti.com>
+
+properties:
+  compatible:
+    const: ti,lp87524-q1
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
+  buck0-in-supply:
+    description:
+      Phandle to parent supply node for the BUCK0 converter.
+
+  buck1-in-supply:
+    description:
+      Phandle to parent supply node for the BUCK1 converter.
+
+  buck2-in-supply:
+    description:
+      Phandle to parent supply node for the BUCK2 converter.
+
+  buck3-in-supply:
+    description:
+      Phandle to parent supply node for the BUCK3 converter.
+
+required:
+  - compatible
+  - reg
+  - gpio-controller
+  - '#gpio-cells'
+  - buck0-in-supply
+  - buck1-in-supply
+  - buck2-in-supply
+  - buck3-in-supply
+
+examples:
+  - |
+    i2c@0 {
+        reg = <0x0 0x100>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        pmic@60 {
+            compatible = "ti,lp87524-q1";
+            reg = <0x60>;
+            gpio-controller;
+            #gpio-cells = <2>;
+
+            buck0-in-supply = <&vdd_5v0>;
+            buck1-in-supply = <&vdd_5v0>;
+            buck2-in-supply = <&vdd_5v0>;
+            buck3-in-supply = <&vdd_5v0>;
+
+            regulators {
+                buck0_reg: buck0 {
+                    regulator-name = "buck0";
+                    regulator-min-microvolt = <3300000>;
+                    regulator-max-microvolt = <3300000>;
+                    regulator-always-on;
+                };
+
+                buck1_reg: buck1 {
+                    regulator-name = "buck1";
+                    regulator-min-microvolt = <1350000>;
+                    regulator-max-microvolt = <1350000>;
+                    regulator-always-on;
+                };
+
+                buck2_reg: buck2 {
+                    regulator-name = "buck2";
+                    regulator-min-microvolt = <950000>;
+                    regulator-max-microvolt = <950000>;
+                    regulator-always-on;
+                };
+
+                buck3_reg: buck3 {
+                    regulator-name = "buck3";
+                    regulator-min-microvolt = <1800000>;
+                    regulator-max-microvolt = <1800000>;
+                    regulator-always-on;
+                };
+            };
+        };
+    };
+
+...
-- 
2.28.0

