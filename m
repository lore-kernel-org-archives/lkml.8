Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D15B0C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 09:14:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB6F82070A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 09:14:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728979AbgEUJOm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 05:14:42 -0400
Received: from v6.sk ([167.172.42.174]:34954 "EHLO v6.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728748AbgEUJOl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 05:14:41 -0400
Received: from localhost (v6.sk [IPv6:::1])
        by v6.sk (Postfix) with ESMTP id 394F661303;
        Thu, 21 May 2020 09:14:09 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH v2 5/9] dt-bindings: media: Convert marvell,mmp2-ccic to json-schema
Date:   Thu, 21 May 2020 11:13:52 +0200
Message-Id: <20200521091356.2211020-6-lkundrak@v3.sk>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200521091356.2211020-1-lkundrak@v3.sk>
References: <20200521091356.2211020-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the marvell,mmp2-ccic binding to DT schema format using
json-schema. While at that this drops the "func" and "phy" clocks.

The driver consumes clocks with those names, but it's not clear
what are they for and they are not used in DT systems. "phy" is
probably a clock for the sensor and it would belong in the sensor
node.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

---
Changes since v1:
- Fix indentation
- Drop clocks other than "axi"
- s/GPL-2.0-or-later/GPL-2.0-only/

 .../bindings/media/marvell,mmp2-ccic.txt      | 50 ----------
 .../bindings/media/marvell,mmp2-ccic.yaml     | 97 +++++++++++++++++++
 2 files changed, 97 insertions(+), 50 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/media/marvell,mmp2-ccic.txt
 create mode 100644 Documentation/devicetree/bindings/media/marvell,mmp2-ccic.yaml

diff --git a/Documentation/devicetree/bindings/media/marvell,mmp2-ccic.txt b/Documentation/devicetree/bindings/media/marvell,mmp2-ccic.txt
deleted file mode 100644
index 7ec2c8c8a3b9..000000000000
--- a/Documentation/devicetree/bindings/media/marvell,mmp2-ccic.txt
+++ /dev/null
@@ -1,50 +0,0 @@
-Marvell MMP2 camera host interface
-
-Required properties:
- - compatible: Should be "marvell,mmp2-ccic".
- - reg: Register base and size.
- - interrupts: The interrupt number.
- - #clock-cells: Must be 0.
-
-Optional properties:
- - clocks: Reference to the input clock as specified by
-           Documentation/devicetree/bindings/clock/clock-bindings.txt.
- - clock-names: Names of the clocks used; "axi" for the AXI bus interface,
-                "func" for the peripheral clock and "phy" for the parallel
-                video bus interface.
- - clock-output-names: Optional clock source for sensors. Shall be "mclk".
-
-Required subnodes:
- - port: The parallel bus interface port with a single endpoint linked to
-         the sensor's endpoint as described in
-         Documentation/devicetree/bindings/media/video-interfaces.txt.
-
-Required endpoint properties:
- - bus-type: data bus type, <5> or <6> for Parallel or Bt.656 respectively
- - pclk-sample: pixel clock polarity
- - hsync-active: horizontal synchronization polarity (only required for
-   parallel bus)
- - vsync-active: vertical synchronization polarity (only required for
-   parallel bus)
-
-Example:
-
-	camera0: camera@d420a000 {
-		compatible = "marvell,mmp2-ccic";
-		reg = <0xd420a000 0x800>;
-		interrupts = <42>;
-		clocks = <&soc_clocks MMP2_CLK_CCIC0>;
-		clock-names = "axi";
-		#clock-cells = <0>;
-		clock-output-names = "mclk";
-
-		port {
-			camera0_0: endpoint {
-				remote-endpoint = <&ov7670_0>;
-                                bus-type = <5>;      /* Parallel */
-                                hsync-active = <1>;  /* Active high */
-                                vsync-active = <1>;  /* Active high */
-                                pclk-sample = <0>;   /* Falling */
-			};
-		};
-	};
diff --git a/Documentation/devicetree/bindings/media/marvell,mmp2-ccic.yaml b/Documentation/devicetree/bindings/media/marvell,mmp2-ccic.yaml
new file mode 100644
index 000000000000..fb399de668bb
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/marvell,mmp2-ccic.yaml
@@ -0,0 +1,97 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright 2019,2020 Lubomir Rintel <lkundrak@v3.sk>
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/marvell,mmp2-ccic.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Marvell MMP2 camera host interface bindings
+
+maintainers:
+  - Lubomir Rintel <lkundrak@v3.sk>
+
+properties:
+  $nodename:
+    pattern: '^camera@[a-f0-9]+$'
+
+  compatible:
+    const: marvell,mmp2-ccic
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  port:
+    type: object
+    additionalProperties: false
+
+    properties:
+      endpoint:
+        type: object
+        additionalProperties: false
+
+        # Properties described in
+        # Documentation/devicetree/bindings/media/video-interfaces.txt
+        properties:
+          remote-endpoint: true
+          hsync-active: true
+          vsync-active: true
+          pclk-sample: true
+          bus-type: true
+
+        required:
+          - remote-endpoint
+
+    required:
+      - endpoint
+
+  clocks:
+    minItems: 1
+    maxItems: 3
+    items:
+      - description: AXI bus interface clock
+      - description: Peripheral clock
+      - description: Parallel video bus interface clock
+
+  clock-names:
+    const: axi
+
+  '#clock-cells':
+    const: 0
+
+  clock-output-names:
+    const: mclk
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - port
+
+examples:
+  - |
+    #include <dt-bindings/clock/marvell,mmp2.h>
+
+    camera@d420a000 {
+      compatible = "marvell,mmp2-ccic";
+      reg = <0xd420a000 0x800>;
+      interrupts = <42>;
+      clocks = <&soc_clocks MMP2_CLK_CCIC0>;
+      clock-names = "axi";
+      #clock-cells = <0>;
+      clock-output-names = "mclk";
+
+      port {
+        camera0_0: endpoint {
+          remote-endpoint = <&ov7670_0>;
+          bus-type = <5>;      /* Parallel */
+          hsync-active = <1>;  /* Active high */
+          vsync-active = <1>;  /* Active high */
+          pclk-sample = <0>;   /* Falling */
+        };
+      };
+    };
+
+...
-- 
2.26.2

