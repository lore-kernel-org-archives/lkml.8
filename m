Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6BFBC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 20:44:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BAE32076A
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 20:44:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730156AbgFVUoA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 16:44:00 -0400
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:41776 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728787AbgFVUnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 16:43:50 -0400
Received: from [37.163.98.205] (port=42634 helo=melee.dev.aim)
        by hostingweb31.netsons.net with esmtpa (Exim 4.93)
        (envelope-from <luca@lucaceresoli.net>)
        id 1jnTI9-00062o-Ut; Mon, 22 Jun 2020 22:43:46 +0200
From:   Luca Ceresoli <luca@lucaceresoli.net>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Luca Ceresoli <luca@lucaceresoli.net>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Keerthy <j-keerthy@ti.com>,
        Axel Lin <axel.lin@ingics.com>
Subject: [PATCH v3 3/4] dt-bindings: mfd: lp87565: add LP87524-Q1 variant
Date:   Mon, 22 Jun 2020 22:43:28 +0200
Message-Id: <20200622204329.11147-4-luca@lucaceresoli.net>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200622204329.11147-1-luca@lucaceresoli.net>
References: <20200622204329.11147-1-luca@lucaceresoli.net>
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

Add the LP87524-Q1 to the LP87565 bindings document along with an example.

Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>

---

Changes in v3:
 - fix yaml errors

Changes in v2:
 - RFC,v1 was based on the txt file, rewrite for yaml
 - use uppercase consistently in model names (Lee Jones)
 - replace "regulator" -> "mfd" in subject line (Lee Jones)
 - replace "dt:" suffix with "dt-bindings:" prefix in subject line
---
 .../devicetree/bindings/mfd/ti,lp875xx.yaml   | 83 +++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/ti,lp875xx.yaml b/Documentation/devicetree/bindings/mfd/ti,lp875xx.yaml
index 2da703918d6a..e6fdf61e89a8 100644
--- a/Documentation/devicetree/bindings/mfd/ti,lp875xx.yaml
+++ b/Documentation/devicetree/bindings/mfd/ti,lp875xx.yaml
@@ -15,6 +15,7 @@ properties:
       - const: ti,lp87565
       - const: ti,lp87565-q1
       - const: ti,lp87561-q1
+      - const: ti,lp87524-q1
 
   reg:
     description: I2C slave address
@@ -72,6 +73,36 @@ allOf:
       required:
         - buck3210-in-supply
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - ti,lp87524-q1
+    then:
+      properties:
+        buck0-in-supply:
+          description:
+            Phandle to parent supply node for the BUCK0 converter.
+
+        buck1-in-supply:
+          description:
+            Phandle to parent supply node for the BUCK1 converter.
+
+        buck2-in-supply:
+          description:
+            Phandle to parent supply node for the BUCK2 converter.
+
+        buck3-in-supply:
+          description:
+            Phandle to parent supply node for the BUCK3 converter.
+
+      required:
+        - buck0-in-supply
+        - buck1-in-supply
+        - buck2-in-supply
+        - buck3-in-supply
+
 examples:
   - |
     /* TI LP87565-Q1 PMIC (dual 2-phase output configuration) */
@@ -139,4 +170,56 @@ examples:
         };
     };
 
+  - |
+    /* TI LP87524-Q1 PMIC (four 1-phase output configuration) */
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
+
+
 ...
-- 
2.27.0

