Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2445AC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 09:14:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 073302070A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 09:14:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728965AbgEUJOi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 05:14:38 -0400
Received: from v6.sk ([167.172.42.174]:34946 "EHLO v6.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728748AbgEUJOi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 05:14:38 -0400
Received: from localhost (v6.sk [IPv6:::1])
        by v6.sk (Postfix) with ESMTP id DEC5261301;
        Thu, 21 May 2020 09:14:05 +0000 (UTC)
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
Subject: [PATCH v2 3/9] dt-bindings: i2c: Convert i2c-pxa to json-schema
Date:   Thu, 21 May 2020 11:13:50 +0200
Message-Id: <20200521091356.2211020-4-lkundrak@v3.sk>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200521091356.2211020-1-lkundrak@v3.sk>
References: <20200521091356.2211020-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A conversion of the i2c-pxa binding to DT schema format using json-schema.

This also cleans ups some errors in the binding: The compatible string
description suggested that "mmp" in "mrvl,mmp-twsi" is to be substituted
with a processor model, which wouldn't be a right thing to do and indeed
nobody seems to have been doing that. There also was "Recommended
properties" section that included optional as well as mandatory
properties. Missing mandatory properties were added to the example.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

---
Changes since v1:
- Add default GPL-2.0-only license tag
- Fill in maintainers from MAINTAINERS file

 .../devicetree/bindings/i2c/i2c-pxa.txt       | 31 --------
 .../devicetree/bindings/i2c/i2c-pxa.yaml      | 72 +++++++++++++++++++
 2 files changed, 72 insertions(+), 31 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/i2c/i2c-pxa.txt
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-pxa.yaml

diff --git a/Documentation/devicetree/bindings/i2c/i2c-pxa.txt b/Documentation/devicetree/bindings/i2c/i2c-pxa.txt
deleted file mode 100644
index c30783c0eca0..000000000000
--- a/Documentation/devicetree/bindings/i2c/i2c-pxa.txt
+++ /dev/null
@@ -1,31 +0,0 @@
-* Marvell MMP I2C controller
-
-Required properties :
-
- - reg : Offset and length of the register set for the device
- - compatible : should be "mrvl,mmp-twsi" where mmp is the name of a
-   compatible processor, e.g. pxa168, pxa910, mmp2, mmp3.
-   For the pxa2xx/pxa3xx, an additional node "mrvl,pxa-i2c" is required
-   as shown in the example below.
-   For the Armada 3700, the compatible should be "marvell,armada-3700-i2c".
-
-Recommended properties :
-
- - interrupts : the interrupt number
- - mrvl,i2c-polling : Disable interrupt of i2c controller. Polling
-   status register of i2c controller instead.
- - mrvl,i2c-fast-mode : Enable fast mode of i2c controller.
-
-Examples:
-	twsi1: i2c@d4011000 {
-		compatible = "mrvl,mmp-twsi";
-		reg = <0xd4011000 0x1000>;
-		interrupts = <7>;
-		mrvl,i2c-fast-mode;
-	};
-	
-	twsi2: i2c@d4025000 {
-		compatible = "mrvl,mmp-twsi";
-		reg = <0xd4025000 0x1000>;
-		interrupts = <58>;
-	};
diff --git a/Documentation/devicetree/bindings/i2c/i2c-pxa.yaml b/Documentation/devicetree/bindings/i2c/i2c-pxa.yaml
new file mode 100644
index 000000000000..19c81972243d
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/i2c-pxa.yaml
@@ -0,0 +1,72 @@
+# SPDX-License-Identifier: GPL-2.0-only
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/i2c/i2c-pxa.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Marvell MMP I2C controller bindings
+
+maintainers:
+  - Rob Herring <robh+dt@kernel.org>
+
+allOf:
+  - $ref: /schemas/i2c/i2c-controller.yaml#
+  - if:
+      not:
+        required:
+          - mrvl,i2c-polling
+    then:
+        required:
+          - interrupts
+
+properties:
+  compatible:
+    enum:
+      - mrvl,mmp-twsi
+      - mrvl,pxa-i2c
+      - marvell,armada-3700-i2c
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    minItems: 1
+
+  resets:
+    minItems: 1
+
+  mrvl,i2c-polling:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: |
+      Disable interrupt of i2c controller. Polling status register of i2c
+      controller instead.
+
+  mrvl,i2c-fast-mode:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: Enable fast mode of i2c controller.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - '#address-cells'
+  - '#size-cells'
+
+examples:
+  - |
+    #include <dt-bindings/clock/marvell,mmp2.h>
+    i2c@d4011000 {
+        compatible = "mrvl,mmp-twsi";
+        reg = <0xd4011000 0x1000>;
+        interrupts = <7>;
+        clocks = <&soc_clocks MMP2_CLK_TWSI1>;
+        mrvl,i2c-fast-mode;
+        #address-cells = <1>;
+        #size-cells = <0>;
+    };
+
+...
-- 
2.26.2

