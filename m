Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 960CBC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 23:52:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F58020786
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 23:52:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="UIDT07o7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727983AbgF2XwZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 19:52:25 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:49166 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726226AbgF2XwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 19:52:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1593474740; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=P5Qq095rKF3uyYrOAeCOssNQFzeyNSGNN2mhlGuYWGE=;
        b=UIDT07o7LqUOtL3gDxuLzAWkaKUkTQrPveZZfJwId6GzoldMh/f6XTvM+P/+1ujwHEbpwy
        koAK17MI2X92+mkPcLwl+iWo2YBkuwK1llyf10gXnQsMnG+WjbojRFc9tM3tIAW8VConjr
        JhugrEsLFTEQpoP5qmvNW7+iO/uAZQQ=
From:   Paul Cercueil <paul@crapouillou.net>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>
Cc:     od@zcrc.me, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        Rob Herring <robh@kernel.org>, Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH v2 01/10] dt-bindings: display: Convert ingenic,lcd.txt to YAML
Date:   Tue, 30 Jun 2020 01:52:01 +0200
Message-Id: <20200629235210.441709-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the ingenic,lcd.txt to a new ingenic,lcd.yaml file.

In the process, the new ingenic,jz4780-lcd compatible string has been
added.

Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---

Notes:
    v2: Add info about IPU at port@8

 .../bindings/display/ingenic,lcd.txt          |  45 -------
 .../bindings/display/ingenic,lcd.yaml         | 126 ++++++++++++++++++
 2 files changed, 126 insertions(+), 45 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/display/ingenic,lcd.txt
 create mode 100644 Documentation/devicetree/bindings/display/ingenic,lcd.yaml

diff --git a/Documentation/devicetree/bindings/display/ingenic,lcd.txt b/Documentation/devicetree/bindings/display/ingenic,lcd.txt
deleted file mode 100644
index 01e3261defb6..000000000000
--- a/Documentation/devicetree/bindings/display/ingenic,lcd.txt
+++ /dev/null
@@ -1,45 +0,0 @@
-Ingenic JZ47xx LCD driver
-
-Required properties:
-- compatible: one of:
-  * ingenic,jz4740-lcd
-  * ingenic,jz4725b-lcd
-  * ingenic,jz4770-lcd
-- reg: LCD registers location and length
-- clocks: LCD pixclock and device clock specifiers.
-	   The device clock is only required on the JZ4740.
-- clock-names: "lcd_pclk" and "lcd"
-- interrupts: Specifies the interrupt line the LCD controller is connected to.
-
-Example:
-
-panel {
-	compatible = "sharp,ls020b1dd01d";
-
-	backlight = <&backlight>;
-	power-supply = <&vcc>;
-
-	port {
-		panel_input: endpoint {
-			remote-endpoint = <&panel_output>;
-		};
-	};
-};
-
-
-lcd: lcd-controller@13050000 {
-	compatible = "ingenic,jz4725b-lcd";
-	reg = <0x13050000 0x1000>;
-
-	interrupt-parent = <&intc>;
-	interrupts = <31>;
-
-	clocks = <&cgu JZ4725B_CLK_LCD>;
-	clock-names = "lcd";
-
-	port {
-		panel_output: endpoint {
-			remote-endpoint = <&panel_input>;
-		};
-	};
-};
diff --git a/Documentation/devicetree/bindings/display/ingenic,lcd.yaml b/Documentation/devicetree/bindings/display/ingenic,lcd.yaml
new file mode 100644
index 000000000000..d56db1802fad
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/ingenic,lcd.yaml
@@ -0,0 +1,126 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/ingenic,lcd.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Ingenic SoCs LCD controller devicetree bindings
+
+maintainers:
+  - Paul Cercueil <paul@crapouillou.net>
+
+properties:
+  $nodename:
+    pattern: "^lcd-controller@[0-9a-f]+$"
+
+  compatible:
+    enum:
+      - ingenic,jz4740-lcd
+      - ingenic,jz4725b-lcd
+      - ingenic,jz4770-lcd
+      - ingenic,jz4780-lcd
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: Pixel clock
+      - description: Module clock
+    minItems: 1
+
+  clock-names:
+    items:
+      - const: lcd_pclk
+      - const: lcd
+    minItems: 1
+
+  port:
+    description: OF graph bindings (specified in bindings/graph.txt).
+
+  ports:
+    description: OF graph bindings (specified in bindings/graph.txt).
+    type: object
+    properties:
+      port@0:
+        type: object
+        description: DPI output, to interface with TFT panels.
+
+      port@8:
+        type: object
+        description: Link to the Image Processing Unit (IPU).
+          (See ingenic,ipu.yaml).
+
+    required:
+      - port@0
+
+required:
+    - compatible
+    - reg
+    - interrupts
+    - clocks
+    - clock-names
+
+if:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - ingenic,jz4740-lcd
+          - ingenic,jz4780-lcd
+then:
+  properties:
+    clocks:
+      minItems: 2
+    clock-names:
+      minItems: 2
+else:
+  properties:
+    clocks:
+      maxItems: 1
+    clock-names:
+      maxItems: 1
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/jz4740-cgu.h>
+    lcd-controller@13050000 {
+      compatible = "ingenic,jz4740-lcd";
+      reg = <0x13050000 0x1000>;
+
+      interrupt-parent = <&intc>;
+      interrupts = <30>;
+
+      clocks = <&cgu JZ4740_CLK_LCD_PCLK>, <&cgu JZ4740_CLK_LCD>;
+      clock-names = "lcd_pclk", "lcd";
+
+      port {
+        endpoint {
+          remote-endpoint = <&panel_input>;
+        };
+      };
+    };
+
+  - |
+    #include <dt-bindings/clock/jz4725b-cgu.h>
+    lcd-controller@13050000 {
+      compatible = "ingenic,jz4725b-lcd";
+      reg = <0x13050000 0x1000>;
+
+      interrupt-parent = <&intc>;
+      interrupts = <31>;
+
+      clocks = <&cgu JZ4725B_CLK_LCD>;
+      clock-names = "lcd_pclk";
+
+      port {
+        endpoint {
+          remote-endpoint = <&panel_input>;
+        };
+      };
+    };
-- 
2.27.0

