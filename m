Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BA9AC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 08:04:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6517B207F5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 08:04:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbgERIEr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 04:04:47 -0400
Received: from inva021.nxp.com ([92.121.34.21]:40212 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726828AbgERIEr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 04:04:47 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 1CD4420096C;
        Mon, 18 May 2020 10:04:45 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id CEA28200977;
        Mon, 18 May 2020 10:04:41 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id AC46C402B4;
        Mon, 18 May 2020 16:04:37 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        paul.liu@linaro.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH] dt-bindings: regulator: Convert anatop regulator to json-schema
Date:   Mon, 18 May 2020 15:55:05 +0800
Message-Id: <1589788505-18024-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the anatop regulator binding to DT schema format using json-schema.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 .../bindings/regulator/anatop-regulator.txt        | 40 ---------
 .../bindings/regulator/anatop-regulator.yaml       | 94 ++++++++++++++++++++++
 2 files changed, 94 insertions(+), 40 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/regulator/anatop-regulator.txt
 create mode 100644 Documentation/devicetree/bindings/regulator/anatop-regulator.yaml

diff --git a/Documentation/devicetree/bindings/regulator/anatop-regulator.txt b/Documentation/devicetree/bindings/regulator/anatop-regulator.txt
deleted file mode 100644
index a3106c7..0000000
--- a/Documentation/devicetree/bindings/regulator/anatop-regulator.txt
+++ /dev/null
@@ -1,40 +0,0 @@
-Anatop Voltage regulators
-
-Required properties:
-- compatible: Must be "fsl,anatop-regulator"
-- regulator-name: A string used as a descriptive name for regulator outputs
-- anatop-reg-offset: Anatop MFD register offset
-- anatop-vol-bit-shift: Bit shift for the register
-- anatop-vol-bit-width: Number of bits used in the register
-- anatop-min-bit-val: Minimum value of this register
-- anatop-min-voltage: Minimum voltage of this regulator
-- anatop-max-voltage: Maximum voltage of this regulator
-
-Optional properties:
-- anatop-delay-reg-offset: Anatop MFD step time register offset
-- anatop-delay-bit-shift: Bit shift for the step time register
-- anatop-delay-bit-width: Number of bits used in the step time register
-- vin-supply: The supply for this regulator
-- anatop-enable-bit: Regulator enable bit offset
-
-Any property defined as part of the core regulator
-binding, defined in regulator.txt, can also be used.
-
-Example:
-
-	regulator-vddpu {
-		compatible = "fsl,anatop-regulator";
-		regulator-name = "vddpu";
-		regulator-min-microvolt = <725000>;
-		regulator-max-microvolt = <1300000>;
-		regulator-always-on;
-		anatop-reg-offset = <0x140>;
-		anatop-vol-bit-shift = <9>;
-		anatop-vol-bit-width = <5>;
-		anatop-delay-reg-offset = <0x170>;
-		anatop-delay-bit-shift = <24>;
-		anatop-delay-bit-width = <2>;
-		anatop-min-bit-val = <1>;
-		anatop-min-voltage = <725000>;
-		anatop-max-voltage = <1300000>;
-	};
diff --git a/Documentation/devicetree/bindings/regulator/anatop-regulator.yaml b/Documentation/devicetree/bindings/regulator/anatop-regulator.yaml
new file mode 100644
index 0000000..a8c9dd0
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/anatop-regulator.yaml
@@ -0,0 +1,94 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/anatop-regulator.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale Anatop Voltage Regulators
+
+maintainers:
+  - Ying-Chun Liu (PaulLiu) <paul.liu@linaro.org>
+
+allOf:
+  - $ref: "regulator.yaml#"
+
+properties:
+  compatible:
+    const: fsl,anatop-regulator
+
+  regulator-name:
+    $ref: '/schemas/types.yaml#/definitions/string'
+    description: string used as a descriptive name for regulator outputs
+
+  anatop-reg-offset:
+    $ref: '/schemas/types.yaml#/definitions/uint32'
+    description: u32 value representing the anatop MFD register offset.
+
+  anatop-vol-bit-shift:
+    $ref: '/schemas/types.yaml#/definitions/uint32'
+    description: u32 value representing the bit shift for the register.
+
+  anatop-vol-bit-width:
+    $ref: '/schemas/types.yaml#/definitions/uint32'
+    description: u32 value representing the number of bits used in the register.
+
+  anatop-min-bit-val:
+    $ref: '/schemas/types.yaml#/definitions/uint32'
+    description: u32 value representing the minimum value of this register.
+
+  anatop-min-voltage:
+    $ref: '/schemas/types.yaml#/definitions/uint32'
+    description: u32 value representing the minimum voltage of this regulator.
+
+  anatop-max-voltage:
+    $ref: '/schemas/types.yaml#/definitions/uint32'
+    description: u32 value representing the maximum voltage of this regulator.
+
+  anatop-delay-reg-offset:
+    $ref: '/schemas/types.yaml#/definitions/uint32'
+    description: u32 value representing the anatop MFD step time register offset.
+
+  anatop-delay-bit-shift:
+    $ref: '/schemas/types.yaml#/definitions/uint32'
+    description: u32 value representing the bit shift for the step time register.
+
+  anatop-delay-bit-width:
+    $ref: '/schemas/types.yaml#/definitions/uint32'
+    description: u32 value representing the number of bits used in the step time register.
+
+  anatop-enable-bit:
+    $ref: '/schemas/types.yaml#/definitions/uint32'
+    description: u32 value representing regulator enable bit offset.
+
+  vin-supply:
+    $ref: '/schemas/types.yaml#/definitions/phandle'
+    description: input supply phandle.
+
+required:
+  - compatible
+  - regulator-name
+  - anatop-reg-offset
+  - anatop-vol-bit-shift
+  - anatop-vol-bit-width
+  - anatop-min-bit-val
+  - anatop-min-voltage
+  - anatop-max-voltage
+
+examples:
+  - |
+    regulator-vddpu {
+        compatible = "fsl,anatop-regulator";
+        regulator-name = "vddpu";
+        regulator-min-microvolt = <725000>;
+        regulator-max-microvolt = <1300000>;
+        regulator-always-on;
+        anatop-reg-offset = <0x140>;
+        anatop-vol-bit-shift = <9>;
+        anatop-vol-bit-width = <5>;
+        anatop-delay-reg-offset = <0x170>;
+        anatop-delay-bit-shift = <24>;
+        anatop-delay-bit-width = <2>;
+        anatop-min-bit-val = <1>;
+        anatop-min-voltage = <725000>;
+        anatop-max-voltage = <1300000>;
+    };
-- 
2.7.4

